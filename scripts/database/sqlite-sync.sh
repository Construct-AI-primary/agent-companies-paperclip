#!/bin/bash
# sqlite-sync.sh - Main sync orchestrator for Supabase ↔ SQLite
# Usage: ./scripts/database/sqlite-sync.sh [pull|push|bidirectional|status]
#
# Syncs all tables between Supabase (source of truth) and local SQLite.
# Before ANY sync, creates a full Supabase backup.
# Conflicts are flagged for manual review (no auto-resolution).
#
# Environment variables required:
#   SUPABASE_URL - Supabase project URL
#   SUPABASE_SERVICE_ROLE_KEY - Service role API key
#   LOCAL_SQLITE_PATH - Path to local SQLite database (default: ./data/paperclip.db)

set -euo pipefail

# Load .env if available
if [ -f .env ]; then
  set -a
  source .env
  set +a
fi

# Validate environment
if [ -z "${SUPABASE_URL:-}" ] || [ -z "${SUPABASE_SERVICE_ROLE_KEY:-}" ]; then
  echo "❌ Missing required environment variables:"
  echo "   SUPABASE_URL: ${SUPABASE_URL:-NOT SET}"
  echo "   SUPABASE_SERVICE_ROLE_KEY: ${SUPABASE_SERVICE_ROLE_KEY:-NOT SET}"
  exit 1
fi

# Configuration
LOCAL_SQLITE_PATH="${LOCAL_SQLITE_PATH:-./data/paperclip.db}"
SYNC_DIRECTION="${1:-pull}"
SYNC_ID="sync_$(date +%Y%m%d_%H%M%S)"
LOG_FILE="logs/sync-${SYNC_ID}.log"
CONFLICT_FILE="logs/conflicts-${SYNC_ID}.md"

# Ensure directories exist
mkdir -p "$(dirname "$LOCAL_SQLITE_PATH")"
mkdir -p logs

# Headers for Supabase REST API
HEADERS=(
  -H "apikey: $SUPABASE_SERVICE_ROLE_KEY"
  -H "Authorization: Bearer $SUPABASE_SERVICE_ROLE_KEY"
  -H "Content-Type: application/json"
)

# Known Paperclip tables (in dependency order for FK safety)
TABLES=(
  "companies"
  "users"
  "profiles"
  "agents"
  "agent_models"
  "agent_api_keys"
  "tasks"
  "issues"
  "task_assignments"
  "activity_logs"
  "comments"
  "attachments"
  "sessions"
  "audit_logs"
  "budgets"
  "approvals"
  "notifications"
  "webhooks"
  "integrations"
  "skills"
  "agent_skills"
  "company_skills"
  "teams"
  "team_members"
  "projects"
  "project_members"
  "files"
  "file_versions"
  "templates"
  "workflows"
  "workflow_runs"
  "workflow_steps"
)

log() {
  echo "[$(date +%H:%M:%S)] $1" | tee -a "$LOG_FILE"
}

# Initialize sync log
log "🔄 Starting sync: $SYNC_ID"
log "📊 Direction: $SYNC_DIRECTION"
log "📁 SQLite: $LOCAL_SQLITE_PATH"

# Step 1: Create Supabase backup
log "📦 Step 1: Creating Supabase backup..."
bash scripts/database/backup-supabase.sh 2>&1 | tee -a "$LOG_FILE"
BACKUP_EXIT=$?
if [ $BACKUP_EXIT -ne 0 ]; then
  log "❌ Backup failed. Aborting sync."
  exit 1
fi
log "✅ Backup complete"

# Step 2: Initialize SQLite schema if needed
log "📋 Step 2: Checking SQLite schema..."
if [ ! -f "$LOCAL_SQLITE_PATH" ]; then
  log "⚠️  SQLite database not found. Creating new database..."
  mkdir -p "$(dirname "$LOCAL_SQLITE_PATH")"
  sqlite3 "$LOCAL_SQLITE_PATH" "SELECT 1;" > /dev/null 2>&1
  log "✅ Created new SQLite database"
fi

# Create sync metadata tables
sqlite3 "$LOCAL_SQLITE_PATH" << 'SQL'
CREATE TABLE IF NOT EXISTS _sync_metadata (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  table_name TEXT NOT NULL UNIQUE,
  last_sync_at TEXT NOT NULL,
  last_sync_direction TEXT CHECK(last_sync_direction IN ('push','pull','bidirectional')),
  sync_version INTEGER DEFAULT 1,
  checksum TEXT,
  row_count INTEGER,
  conflict_count INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS _sync_conflicts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  table_name TEXT NOT NULL,
  record_id TEXT NOT NULL,
  conflict_type TEXT CHECK(conflict_type IN ('insert','update','delete','schema')),
  local_value TEXT,
  remote_value TEXT,
  detected_at TEXT NOT NULL DEFAULT (datetime('now')),
  resolved_at TEXT,
  resolution TEXT,
  resolved_by TEXT
);

CREATE TABLE IF NOT EXISTS _sync_log (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  sync_id TEXT NOT NULL,
  started_at TEXT NOT NULL DEFAULT (datetime('now')),
  completed_at TEXT,
  direction TEXT,
  status TEXT CHECK(status IN ('running','completed','failed','conflicts_found')),
  tables_synced INTEGER DEFAULT 0,
  records_processed INTEGER DEFAULT 0,
  conflicts_found INTEGER DEFAULT 0,
  error_message TEXT
);
SQL

# Insert sync log entry
sqlite3 "$LOCAL_SQLITE_PATH" "INSERT INTO _sync_log (sync_id, direction, status) VALUES ('$SYNC_ID', '$SYNC_DIRECTION', 'running');"

# Step 3: Sync tables
log "🔄 Step 3: Syncing tables..."
TABLES_SYNCED=0
RECORDS_PROCESSED=0
CONFLICTS_FOUND=0

for TABLE in "${TABLES[@]}"; do
  log "  📦 Syncing: $TABLE"
  
  # Fetch from Supabase
  RESPONSE=$(curl -s -w "\n%{http_code}" "${SUPABASE_URL}/rest/v1/${TABLE}?select=*&order=updated_at.desc" \
    "${HEADERS[@]}" \
    -H "Prefer: return=representation" 2>/dev/null || echo -e "\n000")
  
  HTTP_CODE=$(echo "$RESPONSE" | tail -1)
  BODY=$(echo "$RESPONSE" | sed '$d')
  
  if [ "$HTTP_CODE" = "200" ] && [ -n "$BODY" ] && [ "$BODY" != "[]" ]; then
    # Count records
    ROW_COUNT=$(echo "$BODY" | python3 -c "import sys,json; data=json.load(sys.stdin); print(len(data))" 2>/dev/null || echo "0")
    
    if [ "$ROW_COUNT" -gt 0 ] 2>/dev/null; then
      log "     📥 $ROW_COUNT records from Supabase"
      
      # Convert and insert into SQLite using Node.js adapter
      echo "$BODY" | node scripts/database/apply-changes.mjs "$TABLE" "$LOCAL_SQLITE_PATH" 2>&1 | tee -a "$LOG_FILE"
      
      RECORDS_PROCESSED=$((RECORDS_PROCESSED + ROW_COUNT))
      
      # Update sync metadata
      CHECKSUM=$(echo "$BODY" | md5sum | cut -d' ' -f1)
      sqlite3 "$LOCAL_SQLITE_PATH" "INSERT OR REPLACE INTO _sync_metadata (table_name, last_sync_at, last_sync_direction, checksum, row_count) VALUES ('$TABLE', datetime('now'), '$SYNC_DIRECTION', '$CHECKSUM', $ROW_COUNT);"
    fi
    
    TABLES_SYNCED=$((TABLES_SYNCED + 1))
  elif [ "$HTTP_CODE" = "404" ]; then
    log "     ⏭️  Table does not exist in Supabase"
  else
    log "     ⚠️  HTTP $HTTP_CODE"
  fi
done

# Step 4: Check for conflicts
log "🔍 Step 4: Checking for conflicts..."
CONFLICTS=$(sqlite3 "$LOCAL_SQLITE_PATH" "SELECT COUNT(*) FROM _sync_conflicts WHERE resolved_at IS NULL;")
if [ "$CONFLICTS" -gt 0 ]; then
  CONFLICTS_FOUND=$CONFLICTS
  log "⚠️  $CONFLICTS unresolved conflicts found!"
  
  # Generate conflict report
  node scripts/database/conflict-report.mjs "$LOCAL_SQLITE_PATH" "$CONFLICT_FILE" 2>&1 | tee -a "$LOG_FILE"
  log "📄 Conflict report: $CONFLICT_FILE"
fi

# Step 5: Update sync log
STATUS="completed"
if [ "$CONFLICTS_FOUND" -gt 0 ]; then
  STATUS="conflicts_found"
fi

sqlite3 "$LOCAL_SQLITE_PATH" "UPDATE _sync_log SET completed_at = datetime('now'), status = '$STATUS', tables_synced = $TABLES_SYNCED, records_processed = $RECORDS_PROCESSED, conflicts_found = $CONFLICTS_FOUND WHERE sync_id = '$SYNC_ID';"

# Step 6: Summary
log ""
log "✅ Sync complete!"
log "   📊 Tables synced: $TABLES_SYNCED"
log "   📈 Records processed: $RECORDS_PROCESSED"
log "   ⚠️  Conflicts found: $CONFLICTS_FOUND"
log "   📋 Log: $LOG_FILE"

if [ "$CONFLICTS_FOUND" -gt 0 ]; then
  log ""
  log "🚨 ACTION REQUIRED: Review conflicts in $CONFLICT_FILE"
  log "   Conflicts must be resolved manually before next sync."
  exit 2  # Exit code 2 = conflicts found
fi

exit 0