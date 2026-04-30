-- ==========================================
-- Remove Agent API Keys Template
-- Created: 2026-04-23
-- Description: Template for removing API keys from MeasureForge AI agents
--              Extends the workflow from _fix-measureforge-agents.sql
-- ==========================================
-- 
-- INSTRUCTIONS:
-- 1. Replace {COMPANY_ID} with the target company UUID
-- 2. Replace {AGENT_NAME} with the agent name to look up agent_id
-- 3. Replace {API_KEY_ID} with the specific API key UUID to delete (optional)
--
-- FK DEPENDENCIES (from FK-DEPENDENCY-LEVELS.md):
-- - agent_api_keys.agent_id → agents.id (NO ACTION)
-- - agent_api_keys.company_id → companies.id (NO ACTION)
-- - NO child tables depend on agent_api_keys (safe to delete)
--
-- DELETION ORDER NOTES (from FK-DEPENDENCY-LEVELS.md):
-- ⚠️  CRITICAL: agent_api_keys must be deleted BEFORE agents (order #8 of 12)
-- - When deleting an agent, you MUST delete all agent_api_keys first
-- - Failure to follow this order will result in FK constraint violations
-- - agent_api_keys has NO child dependencies (safe to delete anytime)
-- - See FK-DEPENDENCY-LEVELS.md for complete deletion order hierarchy
--
-- IMPORTANT: agent_api_keys uses agent_id as UUID FK (not TEXT like agent_models)
-- BEST PRACTICE: Consider revoking keys instead of deleting (soft delete)
-- ==========================================

-- Error handling wrapper
DO $$
DECLARE
  v_rows_deleted INTEGER;
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

-- Step 2: View current API keys before deletion
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

-- Step 3: BACKUP - Create temporary backup before deletion (recommended)
CREATE TEMP TABLE agent_api_keys_backup AS
SELECT *
FROM agent_api_keys
WHERE agent_id = (
  SELECT id FROM agents 
  WHERE company_id = '{COMPANY_ID}' 
    AND name = '{AGENT_NAME}'
  LIMIT 1
);

-- Verify backup
SELECT COUNT(*) as backed_up_keys
FROM agent_api_keys_backup;

-- Step 4: Delete API key(s)

-- Option A: Delete a specific API key by ID
DELETE FROM agent_api_keys
WHERE id = '{API_KEY_ID}'
  AND agent_id = (
    SELECT id FROM agents 
    WHERE company_id = '{COMPANY_ID}' 
      AND name = '{AGENT_NAME}'
    LIMIT 1
  );

GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;

IF v_rows_deleted = 0 THEN
  RAISE NOTICE '⚠️  WARNING: No rows were deleted';
  RAISE NOTICE 'This usually means:';
  RAISE NOTICE '  1. No API key exists with id=''%''', '{API_KEY_ID}';
  RAISE NOTICE '  2. The API key does not belong to agent ''%''', '{AGENT_NAME}';
  RAISE NOTICE '  3. The API key may have already been deleted';
  RAISE NOTICE '';
  RAISE NOTICE 'To verify: SELECT * FROM agent_api_keys WHERE id = ''%'';', '{API_KEY_ID}';
ELSE
  RAISE NOTICE '✅ Successfully deleted % API key(s)', v_rows_deleted;
  RAISE NOTICE '';
  RAISE NOTICE '⚠️  REMINDER: If you plan to delete the agent ''%'', this was required first', '{AGENT_NAME}';
  RAISE NOTICE 'Deletion order: agent_api_keys → agents (see FK-DEPENDENCY-LEVELS.md)';
END IF;

EXCEPTION
  WHEN foreign_key_violation THEN
    RAISE NOTICE '❌ ERROR: Foreign key constraint violation';
    RAISE NOTICE 'This should NOT happen when deleting agent_api_keys (no child dependencies)';
    RAISE NOTICE '';
    RAISE NOTICE 'If you see this error:';
    RAISE NOTICE '  1. There may be a new FK relationship not documented in FK-DEPENDENCY-LEVELS.md';
    RAISE NOTICE '  2. Contact the database administrator';
    RAISE NOTICE '';
    RAISE NOTICE 'Error details:';
    RAISE NOTICE '  Error code: %', SQLSTATE;
    RAISE NOTICE '  Error message: %', SQLERRM;
    RAISE EXCEPTION 'Unexpected foreign key constraint violation - see details above';
  
  WHEN OTHERS THEN
    RAISE NOTICE '❌ ERROR: Unexpected error occurred during deletion';
    RAISE NOTICE 'Error code: %', SQLSTATE;
    RAISE NOTICE 'Error message: %', SQLERRM;
    RAISE EXCEPTION 'Unexpected error - see details above';
END $$;

-- Option B: Delete all revoked API keys for an agent
-- DELETE FROM agent_api_keys
-- WHERE agent_id = (
--   SELECT id FROM agents 
--   WHERE company_id = '{COMPANY_ID}' 
--     AND name = '{AGENT_NAME}'
--   LIMIT 1
-- )
-- AND revoked_at IS NOT NULL;

-- Option C: Delete ALL API keys for an agent (use with caution)
-- DELETE FROM agent_api_keys
-- WHERE agent_id = (
--   SELECT id FROM agents 
--   WHERE company_id = '{COMPANY_ID}' 
--     AND name = '{AGENT_NAME}'
--   LIMIT 1
-- );

-- Step 5: Verification - Check remaining keys
SELECT 
  id,
  name,
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

-- Step 6: Verification - Confirm deletion count
SELECT 
  '{AGENT_NAME}' as agent_name,
  COUNT(*) as remaining_keys,
  COUNT(CASE WHEN revoked_at IS NULL THEN 1 END) as active_keys
FROM agent_api_keys
WHERE agent_id = (
  SELECT id FROM agents 
  WHERE company_id = '{COMPANY_ID}' 
    AND name = '{AGENT_NAME}'
  LIMIT 1
);

-- Step 7: ROLLBACK - Restore from backup if needed (uncomment to use)
/*
INSERT INTO agent_api_keys
SELECT * FROM agent_api_keys_backup;

-- Verify restoration
SELECT COUNT(*) as restored_keys
FROM agent_api_keys
WHERE agent_id = (
  SELECT id FROM agents 
  WHERE company_id = '{COMPANY_ID}' 
    AND name = '{AGENT_NAME}'
  LIMIT 1
);
*/

-- Step 8: Cleanup - Drop temporary backup table
DROP TABLE IF EXISTS agent_api_keys_backup;

-- ==========================================
-- EXAMPLE USAGE FOR MEASUREFORGE AI AGENTS
-- ==========================================

-- Example 1: Delete all revoked API keys for Max the Measurement Maestro
/*
DELETE FROM agent_api_keys
WHERE agent_id = (
  SELECT id FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013' 
    AND name = 'Max the Measurement Maestro'
  LIMIT 1
)
AND revoked_at IS NOT NULL;
*/

-- Example 2: Delete all API keys for a specific agent
/*
DELETE FROM agent_api_keys
WHERE agent_id = (
  SELECT id FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013' 
    AND name = 'Archie the Building Buddy'
  LIMIT 1
);
*/

-- Example 3: Bulk delete all revoked keys for all MeasureForge agents
/*
DELETE FROM agent_api_keys
WHERE agent_id IN (
  SELECT id FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
)
AND revoked_at IS NOT NULL;
*/

-- Example 4: Delete old unused API keys (not used in 180 days)
/*
DELETE FROM agent_api_keys
WHERE agent_id IN (
  SELECT id FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
)
AND (last_used_at IS NULL OR last_used_at < NOW() - INTERVAL '180 days')
AND created_at < NOW() - INTERVAL '180 days';
*/

-- Example 5: Bulk deletion with backup and verification
/*
-- Create backup
CREATE TEMP TABLE measureforge_api_keys_backup AS
SELECT *
FROM agent_api_keys
WHERE agent_id IN (
  SELECT id FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
);

-- Delete all MeasureForge API keys
DELETE FROM agent_api_keys
WHERE agent_id IN (
  SELECT id FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
);

-- Verify deletion
SELECT COUNT(*) as remaining_measureforge_keys
FROM agent_api_keys
WHERE agent_id IN (
  SELECT id FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
);

-- Restore if needed
-- INSERT INTO agent_api_keys SELECT * FROM measureforge_api_keys_backup;

-- Cleanup
DROP TABLE IF EXISTS measureforge_api_keys_backup;
*/
