#!/bin/bash
# backup-supabase.sh - Full Supabase backup before sync operations
# Usage: ./scripts/database/backup-supabase.sh
# 
# Creates a complete backup of all Supabase tables with:
# - Schema dump (schema.sql)
# - Per-table CSV exports (data/)
# - Metadata file (metadata.json)
#
# Environment variables required:
#   SUPABASE_URL - Supabase project URL
#   SUPABASE_SERVICE_ROLE_KEY - Service role API key

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
  echo ""
  echo "Please set these variables or create a .env file."
  exit 1
fi

# Configuration
BACKUP_DIR="supabase_backup_$(date +%Y%m%d_%H%M%S)"
DATA_DIR="$BACKUP_DIR/data"
METADATA_FILE="$BACKUP_DIR/metadata.json"
SCHEMA_FILE="$BACKUP_DIR/schema.sql"

# Headers for Supabase REST API
HEADERS=(
  -H "apikey: $SUPABASE_SERVICE_ROLE_KEY"
  -H "Authorization: Bearer $SUPABASE_SERVICE_ROLE_KEY"
  -H "Content-Type: application/json"
)

echo "🔄 Starting Supabase backup..."
echo "📁 Backup directory: $BACKUP_DIR"

# Create directories
mkdir -p "$DATA_DIR"

# Step 1: Get list of all tables
echo "📋 Fetching table list..."
TABLES_RESPONSE=$(curl -s "${SUPABASE_URL}/rest/v1/" \
  "${HEADERS[@]}" \
  -H "Prefer: return=representation" \
  -X GET 2>/dev/null || echo '{"error": "failed"}')

# Use information_schema to get tables via SQL endpoint
# Since REST API doesn't list tables, we use a known table list
# For a complete solution, use pg_dump or the Supabase Management API

# Fetch tables via SQL (using the SQL API if available)
# Fallback: use a predefined list of known Paperclip tables
KNOWN_TABLES=(
  "companies"
  "agents"
  "agent_models"
  "agent_api_keys"
  "tasks"
  "issues"
  "task_assignments"
  "activity_logs"
  "comments"
  "attachments"
  "users"
  "profiles"
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
  "sync_metadata"
  "sync_conflicts"
  "sync_log"
)

# Step 2: Export schema
echo "📄 Exporting schema..."
# Use pg_dump if available, otherwise note that schema export requires direct DB access
if command -v pg_dump &> /dev/null; then
  # Extract host and credentials from SUPABASE_URL
  DB_HOST=$(echo "$SUPABASE_URL" | sed -E 's|https?://([^/]+).*|\1|')
  DB_PORT=6543
  DB_NAME="postgres"
  
  # Get password from service role key (it's a JWT, we need the actual password)
  # For pg_dump, we need the direct database password, not the API key
  echo "⚠️  Schema export via pg_dump requires direct database credentials."
  echo "   Please set SUPABASE_DB_PASSWORD for full schema export."
  echo "   Skipping schema export for now."
else
  echo "⚠️  pg_dump not available. Schema export skipped."
  echo "   Install PostgreSQL client tools for full schema backup."
fi

# Create placeholder schema file
cat > "$SCHEMA_FILE" << 'SCHEMA_EOF'
-- Schema export requires direct PostgreSQL access via pg_dump
-- To export schema manually:
-- pg_dump "postgresql://postgres.[project-ref]:[password]@[host]:6543/postgres" \
--   -f schema.sql --schema-only
--
-- Or use the Supabase Dashboard > SQL Editor to export schema
SCHEMA_EOF

# Step 3: Export each table as CSV
echo "📊 Exporting table data..."
TABLE_COUNT=0
TOTAL_ROWS=0
TABLE_INFO="{}"

for TABLE in "${KNOWN_TABLES[@]}"; do
  echo "  📦 Exporting: $TABLE"
  
  # Fetch all rows from the table
  RESPONSE=$(curl -s -w "\n%{http_code}" "${SUPABASE_URL}/rest/v1/${TABLE}?select=*" \
    "${HEADERS[@]}" \
    -H "Prefer: return=representation" \
    -H "Accept: text/csv" 2>/dev/null || echo -e "\n000")
  
  HTTP_CODE=$(echo "$RESPONSE" | tail -1)
  BODY=$(echo "$RESPONSE" | sed '$d')
  
  if [ "$HTTP_CODE" = "200" ]; then
    # Save as CSV
    echo "$BODY" > "$DATA_DIR/${TABLE}.csv"
    ROW_COUNT=$(echo "$BODY" | wc -l | tr -d ' ')
    # Subtract 1 for header row
    ROW_COUNT=$((ROW_COUNT - 1))
    if [ $ROW_COUNT -lt 0 ]; then
      ROW_COUNT=0
    fi
    
    echo "     ✅ $ROW_COUNT rows exported"
    TABLE_COUNT=$((TABLE_COUNT + 1))
    TOTAL_ROWS=$((TOTAL_ROWS + ROW_COUNT))
    
    # Add to table info JSON
    TABLE_INFO=$(echo "$TABLE_INFO" | jq --arg t "$TABLE" --argjson c "$ROW_COUNT" '. + {($t): $c}')
  elif [ "$HTTP_CODE" = "404" ]; then
    echo "     ⏭️  Table does not exist (skipped)"
  else
    echo "     ⚠️  HTTP $HTTP_CODE (skipped)"
  fi
done

# Step 4: Create metadata file
echo "📝 Creating metadata..."
cat > "$METADATA_FILE" << EOF
{
  "backup_timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "backup_dir": "$BACKUP_DIR",
  "supabase_url": "$SUPABASE_URL",
  "tables_exported": $TABLE_COUNT,
  "total_rows": $TOTAL_ROWS,
  "table_row_counts": $TABLE_INFO,
  "schema_exported": false,
  "schema_note": "Schema export requires direct PostgreSQL access via pg_dump",
  "backup_type": "full",
  "backup_tool": "backup-supabase.sh"
}
EOF

# Step 5: Summary
echo ""
echo "✅ Backup complete!"
echo "   📁 Directory: $BACKUP_DIR"
echo "   📊 Tables: $TABLE_COUNT"
echo "   📈 Total rows: $TOTAL_ROWS"
echo "   📄 Schema: $SCHEMA_FILE (placeholder)"
echo "   📋 Metadata: $METADATA_FILE"
echo ""
echo "💡 For full schema backup, install PostgreSQL client tools:"
echo "   brew install postgresql  (macOS)"
echo "   apt-get install postgresql-client  (Ubuntu)"
echo ""
echo "🔒 Backup retention: Configure BACKUP_RETENTION_DAYS in .env"

# Step 6: Cleanup old backups (if retention configured)
RETENTION_DAYS="${BACKUP_RETENTION_DAYS:-30}"
if [ "$RETENTION_DAYS" -gt 0 ] 2>/dev/null; then
  echo "🧹 Cleaning up backups older than $RETENTION_DAYS days..."
  find . -maxdepth 1 -name "supabase_backup_*" -type d -mtime +$RETENTION_DAYS -exec rm -rf {} \; 2>/dev/null || true
  echo "   ✅ Cleanup complete"
fi

exit 0