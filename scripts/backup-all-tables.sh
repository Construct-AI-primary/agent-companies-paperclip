#!/bin/bash

# Paperclip Database Backup Script
# Creates comprehensive backup of all tables with timestamping

set -e  # Exit on any error

# Configuration
BACKUP_DIR="./backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_PREFIX="paperclip_backup_${TIMESTAMP}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create backup directory
mkdir -p "${BACKUP_DIR}"
echo -e "${BLUE}📁 Created backup directory: ${BACKUP_DIR}${NC}"

# Function to log with timestamp
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

# Function to log errors
error_log() {
    echo -e "${RED}[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $1${NC}" >&2
}

# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
    error_log "DATABASE_URL environment variable is not set"
    exit 1
fi

log "🚀 Starting Paperclip database backup..."
log "📅 Timestamp: ${TIMESTAMP}"
log "🎯 Database: ${DATABASE_URL%%@*}@[HIDDEN]"

# Create full database backup
log "💾 Creating full database backup..."
FULL_BACKUP_FILE="${BACKUP_DIR}/${BACKUP_PREFIX}_full.sql"
pg_dump "$DATABASE_URL" --no-owner --no-privileges --clean --if-exists --verbose > "$FULL_BACKUP_FILE"

if [ $? -eq 0 ]; then
    log "✅ Full database backup created: $(basename "$FULL_BACKUP_FILE")"
else
    error_log "Failed to create full database backup"
    exit 1
fi

# Create schema-only backup
log "📋 Creating schema-only backup..."
SCHEMA_BACKUP_FILE="${BACKUP_DIR}/${BACKUP_PREFIX}_schema.sql"
pg_dump "$DATABASE_URL" --schema-only --no-owner --no-privileges --clean --if-exists > "$SCHEMA_BACKUP_FILE"

if [ $? -eq 0 ]; then
    log "✅ Schema backup created: $(basename "$SCHEMA_BACKUP_FILE")"
else
    error_log "Failed to create schema backup"
    exit 1
fi

# Create data-only backup
log "📊 Creating data-only backup..."
DATA_BACKUP_FILE="${BACKUP_DIR}/${BACKUP_PREFIX}_data.sql"
pg_dump "$DATABASE_URL" --data-only --no-owner --no-privileges --clean --if-exists > "$DATA_BACKUP_FILE"

if [ $? -eq 0 ]; then
    log "✅ Data backup created: $(basename "$DATA_BACKUP_FILE")"
else
    error_log "Failed to create data backup"
    exit 1
fi

# Get list of all tables and create individual table backups
log "📋 Getting list of all tables..."
TABLES=$(psql "$DATABASE_URL" -t -c "SELECT tablename FROM pg_tables WHERE schemaname = 'public' ORDER BY tablename;")

if [ $? -ne 0 ]; then
    error_log "Failed to get table list"
    exit 1
fi

TABLE_BACKUP_DIR="${BACKUP_DIR}/tables_${TIMESTAMP}"
mkdir -p "$TABLE_BACKUP_DIR"

log "🗂️  Creating individual table backups in: $(basename "$TABLE_BACKUP_DIR")"

TABLE_COUNT=0
for TABLE in $TABLES; do
    # Skip if table name is empty (can happen with whitespace)
    [ -z "$TABLE" ] && continue

    TABLE_FILE="${TABLE_BACKUP_DIR}/${TABLE}.sql"

    # Create table backup with data
    pg_dump "$DATABASE_URL" --table="$TABLE" --no-owner --no-privileges --clean --if-exists > "$TABLE_FILE"

    if [ $? -eq 0 ]; then
        TABLE_COUNT=$((TABLE_COUNT + 1))
        log "  ✅ $TABLE"
    else
        error_log "Failed to backup table: $TABLE"
    fi
done

# Create compressed archive
log "📦 Creating compressed backup archive..."
ARCHIVE_FILE="${BACKUP_DIR}/${BACKUP_PREFIX}.tar.gz"
tar -czf "$ARCHIVE_FILE" -C "$BACKUP_DIR" "$(basename "$FULL_BACKUP_FILE")" "$(basename "$SCHEMA_BACKUP_FILE")" "$(basename "$DATA_BACKUP_FILE")" "$(basename "$TABLE_BACKUP_DIR")"

if [ $? -eq 0 ]; then
    log "✅ Compressed archive created: $(basename "$ARCHIVE_FILE")"
else
    error_log "Failed to create compressed archive"
fi

# Generate backup manifest
MANIFEST_FILE="${BACKUP_DIR}/${BACKUP_PREFIX}_manifest.txt"
cat > "$MANIFEST_FILE" << EOF
Paperclip Database Backup Manifest
==================================

Backup Date: $(date)
Timestamp: $TIMESTAMP
Database: ${DATABASE_URL%%@*}@[HIDDEN]

Files Created:
--------------
- $(basename "$FULL_BACKUP_FILE") ($(du -h "$FULL_BACKUP_FILE" | cut -f1))
- $(basename "$SCHEMA_BACKUP_FILE") ($(du -h "$SCHEMA_BACKUP_FILE" | cut -f1))
- $(basename "$DATA_BACKUP_FILE") ($(du -h "$DATA_BACKUP_FILE" | cut -f1))
- $(basename "$ARCHIVE_FILE") ($(du -h "$ARCHIVE_FILE" | cut -f1))

Individual Table Backups ($TABLE_COUNT tables):
$(ls -la "$TABLE_BACKUP_DIR" | grep '\.sql$' | awk '{print "  - " $9 " (" $5 " bytes)"}')

Database Statistics:
------------------
$(psql "$DATABASE_URL" -c "
SELECT
  schemaname,
  tablename,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size,
  pg_total_relation_size(schemaname||'.'||tablename) as bytes
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY bytes DESC
LIMIT 10;
" 2>/dev/null || echo "Could not retrieve table statistics")

Backup Verification:
------------------
To restore from full backup:
  psql \$DATABASE_URL < $FULL_BACKUP_FILE

To restore from schema + data:
  psql \$DATABASE_URL < $SCHEMA_BACKUP_FILE
  psql \$DATABASE_URL < $DATA_BACKUP_FILE

To restore from archive:
  tar -xzf $ARCHIVE_FILE -C /tmp/
  # Then use individual files as needed

EOF

log "📋 Backup manifest created: $(basename "$MANIFEST_FILE")"

# Display backup summary
echo
echo -e "${YELLOW}🎉 Paperclip Database Backup Complete!${NC}"
echo
echo -e "${BLUE}Backup Summary:${NC}"
echo "  📅 Timestamp: $TIMESTAMP"
echo "  📁 Location: $BACKUP_DIR"
echo "  📊 Tables Backed Up: $TABLE_COUNT"
echo "  📦 Archive: $(basename "$ARCHIVE_FILE")"
echo "  📋 Manifest: $(basename "$MANIFEST_FILE")"
echo
echo -e "${GREEN}Files Created:${NC}"
echo "  • $(basename "$FULL_BACKUP_FILE")"
echo "  • $(basename "$SCHEMA_BACKUP_FILE")"
echo "  • $(basename "$DATA_BACKUP_FILE")"
echo "  • $(basename "$ARCHIVE_FILE")"
echo "  • $(basename "$MANIFEST_FILE")"
echo "  • $TABLE_BACKUP_DIR/ ($TABLE_COUNT table files)"
echo
echo -e "${YELLOW}💡 To restore: psql \$DATABASE_URL < $FULL_BACKUP_FILE${NC}"
echo

# Calculate total backup size
TOTAL_SIZE=$(du -sh "$BACKUP_DIR" | cut -f1)
log "📏 Total backup size: $TOTAL_SIZE"

log "✅ Paperclip database backup completed successfully!"