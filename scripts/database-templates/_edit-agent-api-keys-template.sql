-- ==========================================
-- Edit Agent API Keys Template
-- Created: 2026-04-23
-- Description: Template for editing existing API keys for MeasureForge AI agents
--              Extends the workflow from _fix-measureforge-agents.sql
-- ==========================================
-- 
-- INSTRUCTIONS:
-- 1. Replace {COMPANY_ID} with the target company UUID
-- 2. Replace {AGENT_NAME} with the agent name to look up agent_id
-- 3. Replace {API_KEY_ID} with the specific API key UUID to edit
-- 4. Update fields as needed (name, revoked_at, etc.)
--
-- FK DEPENDENCIES (from FK-DEPENDENCY-LEVELS.md):
-- - agent_api_keys.agent_id → agents.id (NO ACTION)
-- - agent_api_keys.company_id → companies.id (NO ACTION)
--
-- DELETION ORDER NOTES (from FK-DEPENDENCY-LEVELS.md):
-- - agent_api_keys must be deleted BEFORE agents (order #8 of 12)
-- - agent_api_keys has NO child dependencies (safe to delete anytime)
-- - See FK-DEPENDENCY-LEVELS.md for complete deletion order hierarchy
--
-- IMPORTANT: agent_api_keys uses agent_id as UUID FK (not TEXT like agent_models)
-- COMMON OPERATIONS: Rename key, revoke key, update last_used_at
-- ==========================================

-- Error handling wrapper
DO $$
DECLARE
  v_rows_affected INTEGER;
BEGIN

-- Step 1: Verify target agent exists
SELECT 
  id as agent_id,
  name,
  company_id,
  role,
  title
FROM agents
WHERE company_id = '{COMPANY_ID}'
  AND name = '{AGENT_NAME}'
LIMIT 1;

-- Step 2: View current API keys for this agent
SELECT 
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at,
  last_used_at,
  revoked_at
FROM agent_api_keys
WHERE agent_id = (
  SELECT id FROM agents 
  WHERE company_id = '{COMPANY_ID}' 
    AND name = '{AGENT_NAME}'
  LIMIT 1
)
ORDER BY created_at DESC;

-- Step 3: Update API key (choose operation below)

-- Option A: Rename an API key
UPDATE agent_api_keys
SET
  name = '{NEW_KEY_NAME}'
WHERE id = '{API_KEY_ID}'
  AND agent_id = (
    SELECT id FROM agents 
    WHERE company_id = '{COMPANY_ID}' 
      AND name = '{AGENT_NAME}'
    LIMIT 1
  );

GET DIAGNOSTICS v_rows_affected = ROW_COUNT;

IF v_rows_affected = 0 THEN
  RAISE NOTICE '⚠️  WARNING: No rows were updated';
  RAISE NOTICE 'This usually means:';
  RAISE NOTICE '  1. No API key exists with id=''%''', '{API_KEY_ID}';
  RAISE NOTICE '  2. The API key does not belong to agent ''%''', '{AGENT_NAME}';
  RAISE NOTICE '';
  RAISE NOTICE 'To verify: SELECT * FROM agent_api_keys WHERE id = ''%'';', '{API_KEY_ID}';
ELSE
  RAISE NOTICE '✅ Successfully updated % row(s)', v_rows_affected;
END IF;

EXCEPTION
  WHEN foreign_key_violation THEN
    RAISE NOTICE '❌ ERROR: Foreign key constraint violation';
    RAISE NOTICE 'This usually means:';
    RAISE NOTICE '  1. You tried to change agent_id or company_id to a non-existent value';
    RAISE NOTICE '  2. The referenced agent or company does not exist';
    RAISE NOTICE '';
    RAISE NOTICE 'To fix: Verify the agent and company exist:';
    RAISE NOTICE '  SELECT id, name FROM agents WHERE company_id = ''%'' AND name = ''%'';', '{COMPANY_ID}', '{AGENT_NAME}';
    RAISE EXCEPTION 'Foreign key constraint violation - see details above';
  
  WHEN OTHERS THEN
    RAISE NOTICE '❌ ERROR: Unexpected error occurred';
    RAISE NOTICE 'Error code: %', SQLSTATE;
    RAISE NOTICE 'Error message: %', SQLERRM;
    RAISE EXCEPTION 'Unexpected error - see details above';
END $$;

-- Option B: Revoke an API key (soft delete)
-- UPDATE agent_api_keys
-- SET
--   revoked_at = NOW()
-- WHERE id = '{API_KEY_ID}'
--   AND agent_id = (
--     SELECT id FROM agents 
--     WHERE company_id = '{COMPANY_ID}' 
--       AND name = '{AGENT_NAME}'
--     LIMIT 1
--   )
--   AND revoked_at IS NULL;

-- Option C: Un-revoke an API key (restore)
-- UPDATE agent_api_keys
-- SET
--   revoked_at = NULL
-- WHERE id = '{API_KEY_ID}'
--   AND agent_id = (
--     SELECT id FROM agents 
--     WHERE company_id = '{COMPANY_ID}' 
--       AND name = '{AGENT_NAME}'
--     LIMIT 1
--   );

-- Step 4: Verification - View updated API key
SELECT 
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at,
  last_used_at,
  revoked_at
FROM agent_api_keys
WHERE id = '{API_KEY_ID}';

-- Step 5: Verification - View all keys for this agent
SELECT 
  id,
  name,
  created_at,
  last_used_at,
  revoked_at,
  CASE 
    WHEN revoked_at IS NULL THEN 'Active'
    ELSE 'Revoked'
  END as status
FROM agent_api_keys
WHERE agent_id = (
  SELECT id FROM agents 
  WHERE company_id = '{COMPANY_ID}' 
    AND name = '{AGENT_NAME}'
  LIMIT 1
)
ORDER BY created_at DESC;

-- ==========================================
-- EXAMPLE USAGE FOR MEASUREFORGE AI AGENTS
-- ==========================================

-- Example 1: Rename an API key
/*
UPDATE agent_api_keys
SET
  name = 'Max the Measurement Maestro Production API Key'
WHERE agent_id = (
  SELECT id FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013' 
    AND name = 'Max the Measurement Maestro'
  LIMIT 1
)
AND name = 'Max the Measurement Maestro API Key';
*/

-- Example 2: Revoke all API keys for a specific agent
/*
UPDATE agent_api_keys
SET
  revoked_at = NOW()
WHERE agent_id = (
  SELECT id FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013' 
    AND name = 'Archie the Building Buddy'
  LIMIT 1
)
AND revoked_at IS NULL;
*/

-- Example 3: Revoke old API keys (older than 90 days, not used recently)
/*
UPDATE agent_api_keys
SET
  revoked_at = NOW()
WHERE agent_id IN (
  SELECT id FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
)
AND created_at < NOW() - INTERVAL '90 days'
AND (last_used_at IS NULL OR last_used_at < NOW() - INTERVAL '30 days')
AND revoked_at IS NULL;
*/

-- Example 4: Update last_used_at for testing (normally done by system)
/*
UPDATE agent_api_keys
SET
  last_used_at = NOW()
WHERE id = '{API_KEY_ID}';
*/

-- Example 5: Bulk rename all MeasureForge API keys with a prefix
/*
UPDATE agent_api_keys
SET
  name = CONCAT('MeasureForge - ', name)
WHERE agent_id IN (
  SELECT id FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
)
AND name NOT LIKE 'MeasureForge -%';
*/
