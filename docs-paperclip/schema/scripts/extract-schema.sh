#!/bin/bash
# Extract complete PostgreSQL schema from Paperclip database
# Usage: ./extract-schema.sh <DATABASE_URL>
set -euo pipefail

DB_URL="${1:?Usage: $0 <DATABASE_URL>}"
OUTPUT_DIR="$(cd "$(dirname "$0")" && pwd)"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
OUTPUT_FILE="${OUTPUT_DIR}/schema-${TIMESTAMP}.sql"

echo "🔍 Extracting complete schema from Paperclip database..."
echo "   Output: ${OUTPUT_FILE}"

pg_dump --schema-only \
  --no-owner \
  --no-privileges \
  --no-comments \
  --dbname="$DB_URL" > "$OUTPUT_FILE" 2>/dev/null

TABLES=$(grep -c 'CREATE TABLE' "$OUTPUT_FILE" || true)
INDEXES=$(grep -c 'CREATE INDEX' "$OUTPUT_FILE" || true)
CONSTRAINTS=$(grep -c 'CONSTRAINT' "$OUTPUT_FILE" || true)

echo "✅ Schema extracted successfully!"
echo "   Tables: $TABLES"
echo "   Indexes: $INDEXES"
echo "   Constraints: $CONSTRAINTS"
echo "   File: $OUTPUT_FILE"

# Generate a summary
echo ""
echo "📋 Table names:"
grep -o 'CREATE TABLE "[^"]*"' "$OUTPUT_FILE" | sed 's/CREATE TABLE "//' | sed 's/"//' | sort | nl

# Compress
gzip -f "$OUTPUT_FILE"
echo "📦 Compressed: ${OUTPUT_FILE}.gz"