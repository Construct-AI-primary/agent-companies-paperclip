#!/bin/bash
# =====================================================
# Schema Verification Script for Gold Star Enterprise
# =====================================================
# This script queries your actual Supabase database
# to verify table structures BEFORE running any DML.
# =====================================================

# Update these with your actual Supabase credentials
SUPABASE_URL="${SUPABASE_URL:-https://your-project.supabase.co}"
SUPABASE_KEY="${SUPABASE_KEY:-your-service-role-key}"

OUTPUT_FILE="/tmp/schema_verification_$(date +%Y%m%d_%H%M%S).txt"

echo "=============================================" | tee "$OUTPUT_FILE"
echo "SCHEMA VERIFICATION - $(date)" | tee -a "$OUTPUT_FILE"
echo "Database: $SUPABASE_URL" | tee -a "$OUTPUT_FILE"
echo "=============================================" | tee -a "$OUTPUT_FILE"

# Headers
HEADERS="apikey: $SUPABASE_KEY"
HEADERS="$HEADERS"$'\n'"Authorization: Bearer $SUPABASE_KEY"
HEADERS="$HEADERS"$'\n'"Content-Type: application/json"
HEADERS="$HEADERS"$'\n'"Prefer: return=representation"

echo "" >> "$OUTPUT_FILE"
echo "--- Checking Tables ---" | tee -a "$OUTPUT_FILE"

# Query all tables in public schema
TABLES=$(curl -s -X GET "$SUPABASE_URL/rest/v1/rpc/get_tables" \
  -H "$HEADERS" 2>/dev/null)

echo "Tables query sent..." | tee -a "$OUTPUT_FILE"

# Alternative: Use SQL endpoint to get schema
echo "" >> "$OUTPUT_FILE"
echo "--- Full Schema via SQL ---" | tee -a "$OUTPUT_FILE"

SQL_QUERY='
SELECT 
  t.table_name,
  c.column_name,
  c.data_type,
  c.is_nullable,
  c.column_default,
  c.character_maximum_length,
  tc.constraint_type,
  kcu.constraint_name as fk_constraint,
  ccu.table_name as fk_table,
  ccu.column_name as fk_column
FROM information_schema.tables t
LEFT JOIN information_schema.columns c ON t.table_name = c.table_name AND c.table_schema = t.table_schema
LEFT JOIN information_schema.key_column_usage kcu ON c.table_name = kcu.table_name AND c.column_name = kcu.column_name
LEFT JOIN information_schema.table_constraints tc ON kcu.constraint_name = tc.constraint_name
LEFT JOIN information_schema.constraint_column_usage ccu ON tc.constraint_name = ccu.constraint_name
WHERE t.table_schema = ''public''
ORDER BY t.table_name, c.ordinal_position;
'

# URL encode the SQL
ENCODED_SQL=$(python3 -c "
import urllib.parse, sys
sql = sys.stdin.read()
print(urllib.parse.quote(sql, safe=''))
" <<< "$SQL_QUERY" 2>/dev/null || echo "$SQL_QUERY" | tr ' ' '+')

echo "" | tee -a "$OUTPUT_FILE"
echo "=============================================" | tee -a "$OUTPUT_FILE"
echo "IMPORTANT: Run this SQL manually in Supabase" | tee -a "$OUTPUT_FILE"
echo "SQL Editor for the most accurate schema dump:" | tee -a "$OUTPUT_FILE"
echo "=============================================" | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"
echo "$SQL_QUERY" | tee -a "$OUTPUT_FILE"

echo "" | tee -a "$OUTPUT_FILE"
echo "--- Checking Specific Tables ---" | tee -a "$OUTPUT_FILE"

# Check each table we plan to insert into
for table in companies agents agent_skills agent_reporting company_goals hitl_queue hitl_audit_log hitl_experts knowledge_integration_log; do
  echo "" >> "$OUTPUT_FILE"
  echo "=== Table: $table ===" | tee -a "$OUTPUT_FILE"
  
  # Try to get one record (will show structure on error)
  RESULT=$(curl -s -w "\nHTTP_STATUS:%{http_code}" -X GET "$SUPABASE_URL/rest/v1/$table?limit=1" \
    -H "$HEADERS" 2>/dev/null)
  
  HTTP_CODE=$(echo "$RESULT" | grep "HTTP_STATUS:" | cut -d: -f2)
  BODY=$(echo "$RESULT" | sed '/HTTP_STATUS:/d')
  
  echo "  HTTP Status: $HTTP_CODE" | tee -a "$OUTPUT_FILE"
  if [ "$HTTP_CODE" = "200" ]; then
    echo "  Table EXISTS ✓" | tee -a "$OUTPUT_FILE"
    echo "  Sample: $BODY" | tee -a "$OUTPUT_FILE"
  else
    echo "  Table may not exist or access denied" | tee -a "$OUTPUT_FILE"
    echo "  Response: $BODY" | tee -a "$OUTPUT_FILE"
  fi
done

echo "" >> "$OUTPUT_FILE"
echo "=============================================" | tee -a "$OUTPUT_FILE"
echo "VERIFICATION COMPLETE" | tee -a "$OUTPUT_FILE"
echo "Full output saved to: $OUTPUT_FILE" | tee -a "$OUTPUT_FILE"
echo "=============================================" | tee -a "$OUTPUT_FILE"