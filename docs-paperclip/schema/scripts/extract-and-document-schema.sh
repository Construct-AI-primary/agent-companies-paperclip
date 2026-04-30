#!/bin/bash
# Extract PostgreSQL schema from Paperclip database and generate documentation
# Usage: ./extract-and-document-schema.sh <DATABASE_URL>
set -euo pipefail

DB_URL="${1:?Usage: $0 <DATABASE_URL>}"
OUTPUT_DIR="$(cd "$(dirname "$0")" && pwd)"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
SCHEMA_FILE="${OUTPUT_DIR}/schema-${TIMESTAMP}.sql"
DOC_FILE="${OUTPUT_DIR}/schema-tables.md"

echo "🔍 Extracting complete schema from Paperclip database..."
echo "   Output SQL: ${SCHEMA_FILE}"
echo "   Output Docs: ${DOC_FILE}"

# Extract raw SQL schema
pg_dump --schema-only \
  --no-owner \
  --no-privileges \
  --no-comments \
  --dbname="$DB_URL" > "$SCHEMA_FILE" 2>/dev/null

TABLES=$(grep -c 'CREATE TABLE' "$SCHEMA_FILE" || true)
INDEXES=$(grep -c 'CREATE INDEX' "$SCHEMA_FILE" || true)
CONSTRAINTS=$(grep -c 'CONSTRAINT' "$SCHEMA_FILE" || true)

echo "✅ Schema extracted successfully!"
echo "   Tables: $TABLES"
echo "   Indexes: $INDEXES"
echo "   Constraints: $CONSTRAINTS"

# Generate markdown documentation
echo "# Paperclip Database Schema" > "$DOC_FILE"
echo "" >> "$DOC_FILE"
echo "**Generated:** $(date '+%Y-%m-%d %H:%M:%S')" >> "$DOC_FILE"
echo "" >> "$DOC_FILE"
echo "## Tables (${TABLES})" >> "$DOC_FILE"
echo "" >> "$DOC_FILE"

# Extract each table with its columns
awk '/CREATE TABLE/ { table=1; name=$3 } 
     table && /CREATE INDEX/ { table=0 }
     table { print }' "$SCHEMA_FILE" | while IFS= read -r line; do
    if [[ "$line" =~ CREATE\ TABLE ]]; then
        echo "" >> "$DOC_FILE"
        echo "### ${BASH_REMATCH[1]}" >> "$DOC_FILE"
        echo "" >> "$DOC_FILE"
        echo '```sql' >> "$DOC_FILE"
        echo "$line" >> "$DOC_FILE"
        in_table=1
    elif [[ "$line" =~ ^\\)$ ]]; then
        echo "$line" >> "$DOC_FILE"
        echo '```' >> "$DOC_FILE"
        in_table=0
    elif [[ "$line" =~ ^\( ]]; then
        echo "$line" >> "$DOC_FILE"
    elif [[ "$in_table" -eq 1 && -n "$line" ]]; then
        echo "$line" >> "$DOC_FILE"
    fi
done

# Generate table summary
echo "" >> "$DOC_FILE"
echo "## Table Summary" >> "$DOC_FILE"
echo "" >> "$DOC_FILE"
echo "| Table Name | Columns |" >> "$DOC_FILE"
echo "|------------|---------|" >> "$DOC_FILE"

grep 'CREATE TABLE' "$SCHEMA_FILE" | while read -r line; do
    table_name=$(echo "$line" | sed 's/CREATE TABLE "\([^"]*\)"/\1/')
    col_count=$(sed -n "/CREATE TABLE \"$table_name\"/,/^);$/p" "$SCHEMA_FILE" | grep -c '"' || echo "0")
    echo "| \`$table_name\` | $col_count |" >> "$DOC_FILE"
done

# Extract agent_api_keys specifically
echo "" >> "$DOC_FILE"
echo "## agent_api_keys Table Reference" >> "$DOC_FILE"
echo "" >> "$DOC_FILE"
echo '```sql' >> "$DOC_FILE"
sed -n '/CREATE TABLE "agent_api_keys"/,/^);$/p' "$SCHEMA_FILE" >> "$DOC_FILE"
echo '```' >> "$DOC_FILE"

# Extract agents table
echo "" >> "$DOC_FILE"
echo "## agents Table Reference" >> "$DOC_FILE"
echo "" >> "$DOC_FILE"
echo '```sql' >> "$DOC_FILE"
sed -n '/CREATE TABLE "agents"/,/^);$/p' "$SCHEMA_FILE" >> "$DOC_FILE"
echo '```' >> "$DOC_FILE"

# Extract companies table
echo "" >> "$DOC_FILE"
echo "## companies Table Reference" >> "$DOC_FILE"
echo "" >> "$DOC_FILE"
echo '```sql' >> "$DOC_FILE"
sed -n '/CREATE TABLE "companies"/,/^);$/p' "$SCHEMA_FILE" >> "$DOC_FILE"
echo '```' >> "$DOC_FILE"

echo "" 
echo "📄 Documentation: ${DOC_FILE}"

# List all tables
echo ""
echo "📋 Table names:"
grep -o 'CREATE TABLE "[^"]*"' "$SCHEMA_FILE" | sed 's/CREATE TABLE "//' | sed 's/"//' | sort | nl

# Compress raw SQL
gzip -f "$SCHEMA_FILE"
echo "📦 Compressed: ${SCHEMA_FILE}.gz"

echo ""
echo "✅ Done! Schema documentation available at:"
echo "   - ${DOC_FILE}"
echo "   - ${SCHEMA_FILE}.gz"
