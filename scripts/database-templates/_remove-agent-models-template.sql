-- ==========================================
-- Remove Agent Model Assignments Template
-- Created: 2026-04-23
-- Description: Template for removing model assignments from MeasureForge AI agents
--              Extends the workflow from _fix-measureforge-agents.sql
-- ==========================================
-- 
-- INSTRUCTIONS:
-- 1. Replace {COMPANY_ID} with the target company UUID
-- 2. Replace {AGENT_NAME} with the agent name (e.g., 'Max the Measurement Maestro')
-- 3. Replace {ASSIGNMENT_TYPE} with 'primary' or 'fallback' (or remove WHERE clause to delete all)
--
-- FK DEPENDENCIES (from FK-DEPENDENCY-LEVELS.md):
-- - agent_models.company_id → companies.id (NO ACTION)
-- - agent_models does NOT have FK to agents table (uses agent_id as identifier)
-- - NO child tables depend on agent_models (safe to delete)
--
-- DELETION ORDER NOTES:
-- - agent_models has NO child dependencies (safe to delete anytime)
-- - agent_models does NOT need to be deleted before agents
-- - agent_models can be deleted independently without affecting other tables
-- - See FK-DEPENDENCY-LEVELS.md for complete deletion order hierarchy
--
-- IMPORTANT: agent_models table uses agent_id as TEXT, not UUID FK
-- ==========================================

-- Error handling wrapper
DO $$
DECLARE
  v_rows_deleted INTEGER;
BEGIN

-- Step 1: Verify target agent exists
SELECT 
  id,
  name,
  company_id,
  role,
  title
FROM agents
WHERE company_id = '{COMPANY_ID}'
  AND name = '{AGENT_NAME}'
LIMIT 1;

-- Step 2: View current model assignments before deletion
SELECT 
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  assigned_at,
  updated_at
FROM agent_models
WHERE agent_id = '{AGENT_NAME}'
ORDER BY priority;

-- Step 3: BACKUP - Create temporary backup before deletion (optional but recommended)
CREATE TEMP TABLE agent_models_backup AS
SELECT *
FROM agent_models
WHERE agent_id = '{AGENT_NAME}';

-- Verify backup
SELECT COUNT(*) as backed_up_records
FROM agent_models_backup;

-- Step 4: Delete specific model assignment
DELETE FROM agent_models
WHERE agent_id = '{AGENT_NAME}'
  AND assignment_type = '{ASSIGNMENT_TYPE}';

GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;

IF v_rows_deleted = 0 THEN
  RAISE NOTICE '⚠️  WARNING: No rows were deleted';
  RAISE NOTICE 'This usually means:';
  RAISE NOTICE '  1. No assignment exists for agent_id=''%'' with assignment_type=''%''', '{AGENT_NAME}', '{ASSIGNMENT_TYPE}';
  RAISE NOTICE '  2. The assignment may have already been deleted';
  RAISE NOTICE '';
  RAISE NOTICE 'To verify: SELECT * FROM agent_models WHERE agent_id = ''%'';', '{AGENT_NAME}';
ELSE
  RAISE NOTICE '✅ Successfully deleted % row(s)', v_rows_deleted;
END IF;

-- Alternative: Delete ALL model assignments for an agent
-- DELETE FROM agent_models
-- WHERE agent_id = '{AGENT_NAME}';

EXCEPTION
  WHEN OTHERS THEN
    RAISE NOTICE '❌ ERROR: Unexpected error occurred during deletion';
    RAISE NOTICE 'Error code: %', SQLSTATE;
    RAISE NOTICE 'Error message: %', SQLERRM;
    RAISE NOTICE '';
    RAISE NOTICE 'NOTE: agent_models has no child dependencies, so FK violations should not occur';
    RAISE NOTICE 'If you see this error, it may be a database constraint issue';
    RAISE EXCEPTION 'Unexpected error - see details above';
END $$;

-- Step 5: Verification - Check remaining assignments
SELECT 
  agent_id,
  model_id,
  assignment_type,
  priority,
  is_active
FROM agent_models
WHERE agent_id = '{AGENT_NAME}'
ORDER BY priority;

-- Step 6: Verification - Confirm deletion count
SELECT 
  '{AGENT_NAME}' as agent_name,
  COUNT(*) as remaining_assignments
FROM agent_models
WHERE agent_id = '{AGENT_NAME}';

-- Step 7: ROLLBACK - Restore from backup if needed (uncomment to use)
/*
INSERT INTO agent_models
SELECT * FROM agent_models_backup;

-- Verify restoration
SELECT COUNT(*) as restored_records
FROM agent_models
WHERE agent_id = '{AGENT_NAME}';
*/

-- Step 8: Cleanup - Drop temporary backup table
DROP TABLE IF EXISTS agent_models_backup;

-- ==========================================
-- EXAMPLE USAGE FOR MEASUREFORGE AI AGENTS
-- ==========================================

-- Example 1: Remove fallback model from Max the Measurement Maestro
/*
DELETE FROM agent_models
WHERE agent_id = 'Max the Measurement Maestro'
  AND assignment_type = 'fallback';
*/

-- Example 2: Remove all model assignments for a specific agent
/*
DELETE FROM agent_models
WHERE agent_id = 'Archie the Building Buddy';
*/

-- Example 3: Remove all inactive model assignments for MeasureForge agents
/*
DELETE FROM agent_models
WHERE agent_id IN (
  SELECT name FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
)
AND is_active = false;
*/

-- Example 4: Remove all model assignments for a specific model across all MeasureForge agents
/*
DELETE FROM agent_models
WHERE agent_id IN (
  SELECT name FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
)
AND model_id = 'deprecated-model-id';
*/

-- Example 5: Bulk removal with backup and verification
/*
-- Create backup
CREATE TEMP TABLE measureforge_models_backup AS
SELECT *
FROM agent_models
WHERE agent_id IN (
  SELECT name FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
);

-- Delete all MeasureForge model assignments
DELETE FROM agent_models
WHERE agent_id IN (
  SELECT name FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
);

-- Verify deletion
SELECT COUNT(*) as remaining_measureforge_assignments
FROM agent_models
WHERE agent_id IN (
  SELECT name FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
);

-- Restore if needed
-- INSERT INTO agent_models SELECT * FROM measureforge_models_backup;

-- Cleanup
DROP TABLE IF EXISTS measureforge_models_backup;
*/
