-- ============================================================
-- CHECK COLUMN EXISTENCE TEMPLATE
-- Purpose: Verify table columns exist before INSERT/UPDATE operations
-- Created: 2026-04-25
-- Version: 1.0
-- ============================================================
--
-- This template provides queries to validate schema compatibility
-- BEFORE executing INSERT/UPDATE operations. Always run this first
-- to prevent "column does not exist" errors.
--
-- IMPORTANT: This is a READ-ONLY validation template - no data changes
-- ============================================================

-- ============================================================
-- SECTION 1: Check agents TABLE columns
-- ============================================================
-- Use this to verify the agents table schema before any agent operations

SELECT 
  column_name,
  data_type,
  character_maximum_length,
  numeric_precision,
  numeric_scale,
  is_nullable,
  column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'agents'
ORDER BY ordinal_position;

-- ============================================================
-- SECTION 2: Check agent_api_keys TABLE columns
-- ============================================================
-- Use this before adding/modifying API keys

SELECT 
  column_name,
  data_type,
  character_maximum_length,
  is_nullable,
  column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'agent_api_keys'
ORDER BY ordinal_position;

-- ============================================================
-- SECTION 3: Check agent_models TABLE columns
-- ============================================================
-- Use this before adding/modifying model assignments

SELECT 
  column_name,
  data_type,
  character_maximum_length,
  is_nullable,
  column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'agent_models'
ORDER BY ordinal_position;

-- ============================================================
-- SECTION 4: Check specific column EXISTS (for conditional logic)
-- ============================================================
-- Returns 1 if column exists, 0 if not

-- Example: Check if 'slug' column exists in agents (it shouldn't!)
SELECT 
  CASE 
    WHEN COUNT(*) > 0 THEN 1 
    ELSE 0 
  END AS column_exists
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'agents'
  AND column_name = 'slug';

-- Example: Check if 'title' column exists in agents (it should!)
SELECT 
  CASE 
    WHEN COUNT(*) > 0 THEN 1 
    ELSE 0 
  END AS column_exists
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'agents'
  AND column_name = 'title';

-- ============================================================
-- SECTION 5: Compare expected vs actual columns
-- ============================================================
-- Use this to validate a template against current schema

-- Expected columns for agents table (from packages/db/src/schema/agents.ts):
/*
  id              - uuid
  company_id      - uuid
  name            - text
  role            - text
  title           - text
  status          - text
  reports_to      - uuid (nullable)
  capabilities    - jsonb
  adapter_type    - text
  adapter_config  - jsonb
  budget_monthly_cents  - integer
  spent_monthly_cents   - integer
  is_active       - boolean
  model_config    - jsonb
  runtime_config  - jsonb
  permissions     - jsonb
  metadata        - jsonb
  created_at      - timestamp
  updated_at      - timestamp
*/

-- Validation query - will return empty if all expected columns exist
SELECT 'MISSING COLUMNS:' AS message, column_name
FROM (
  VALUES 
    ('id'), ('company_id'), ('name'), ('role'), ('title'),
    ('status'), ('reports_to'), ('capabilities'), ('adapter_type'),
    ('adapter_config'), ('budget_monthly_cents'), ('spent_monthly_cents'),
    ('is_active'), ('model_config'), ('runtime_config'), ('permissions'),
    ('metadata'), ('created_at'), ('updated_at')
) AS expected_columns(column_name)
WHERE NOT EXISTS (
  SELECT 1 FROM information_schema.columns
  WHERE table_schema = 'public'
    AND table_name = 'agents'
    AND column_name = expected_columns.column_name
);

-- ============================================================
-- SECTION 6: Quick column existence check (copy-paste friendly)
-- ============================================================
-- Copy this block and run before any INSERT/UPDATE

--/*
SELECT 
  'agents' AS table_name,
  string_agg(column_name, ', ' ORDER BY ordinal_position) AS columns
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'agents'
UNION ALL
SELECT 
  'agent_api_keys' AS table_name,
  string_agg(column_name, ', ' ORDER BY ordinal_position) AS columns
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'agent_api_keys'
UNION ALL
SELECT 
  'agent_models' AS table_name,
  string_agg(column_name, ', ' ORDER BY ordinal_position) AS columns
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'agent_models';
--*/

-- ============================================================
-- SECTION 7: Schema fingerprint (for change detection)
-- ============================================================
-- Use this to detect if schema has changed since last run

SELECT 
  table_name,
  COUNT(*) AS column_count,
  string_agg(column_name || ':' || data_type, ', ' ORDER BY ordinal_position) AS schema_fingerprint
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN ('agents', 'agent_api_keys', 'agent_models', 'companies')
GROUP BY table_name
ORDER BY table_name;

-- ============================================================
-- HOW TO USE THIS TEMPLATE
-- ============================================================
-- 1. Copy the relevant section(s) above
-- 2. Run against your target database
-- 3. Compare results against expected columns in comments
-- 4. If columns are missing or types differ, DO NOT proceed
-- 5. Update your SQL template to match actual schema
-- 6. Re-validate after any schema changes
--
-- CI/CD INTEGRATION:
-- Add this to your pre-deployment checks to catch schema drift
-- ============================================================
