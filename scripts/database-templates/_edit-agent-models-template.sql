-- ==========================================
-- Edit Agent Model Assignments Template
-- Created: 2026-04-23
-- Description: Template for editing existing model assignments for MeasureForge AI agents
--              Extends the workflow from _fix-measureforge-agents.sql
-- ==========================================
-- 
-- INSTRUCTIONS:
-- 1. Replace {COMPANY_ID} with the target company UUID
-- 2. Replace {AGENT_NAME} with the agent name (e.g., 'Max the Measurement Maestro')
-- 3. Replace {ASSIGNMENT_TYPE} with 'primary' or 'fallback'
-- 4. Update fields as needed (model_id, priority, temperature, max_tokens, etc.)
--
-- FK DEPENDENCIES (from FK-DEPENDENCY-LEVELS.md):
-- - agent_models.company_id → companies.id (NO ACTION)
-- - agent_models does NOT have FK to agents table (uses agent_id as identifier)
--
-- DELETION ORDER NOTES:
-- - agent_models has NO child dependencies (safe to delete anytime)
-- - agent_models does NOT need to be deleted before agents
-- - See FK-DEPENDENCY-LEVELS.md for complete deletion order hierarchy
--
-- IMPORTANT: agent_models table uses agent_id as TEXT, not UUID FK
-- ==========================================

-- Error handling wrapper
DO $$
DECLARE
  v_rows_affected INTEGER;
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

-- Step 2: View current model assignment
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
  AND assignment_type = '{ASSIGNMENT_TYPE}';

-- Step 3: Update model assignment
-- Modify the SET clause fields as needed
UPDATE agent_models
SET
  model_id = '{NEW_MODEL_ID}',           -- Update model if needed
  priority = {NEW_PRIORITY},             -- Update priority if needed
  temperature = {NEW_TEMPERATURE},       -- Update temperature if needed
  max_tokens = {NEW_MAX_TOKENS},         -- Update max_tokens if needed
  reason = '{NEW_REASON}',               -- Update reason if needed
  is_active = {NEW_IS_ACTIVE},           -- true or false
  updated_at = NOW()
WHERE agent_id = '{AGENT_NAME}'
  AND assignment_type = '{ASSIGNMENT_TYPE}';

GET DIAGNOSTICS v_rows_affected = ROW_COUNT;

IF v_rows_affected = 0 THEN
  RAISE NOTICE '⚠️  WARNING: No rows were updated';
  RAISE NOTICE 'This usually means:';
  RAISE NOTICE '  1. No assignment exists for agent_id=''%'' with assignment_type=''%''', '{AGENT_NAME}', '{ASSIGNMENT_TYPE}';
  RAISE NOTICE '  2. Check that the agent name and assignment type are correct';
  RAISE NOTICE '';
  RAISE NOTICE 'To verify: SELECT * FROM agent_models WHERE agent_id = ''%'';', '{AGENT_NAME}';
ELSE
  RAISE NOTICE '✅ Successfully updated % row(s)', v_rows_affected;
END IF;

EXCEPTION
  WHEN foreign_key_violation THEN
    RAISE NOTICE '❌ ERROR: Foreign key constraint violation';
    RAISE NOTICE 'This usually means:';
    RAISE NOTICE '  1. The new company_id does not exist (if you modified company_id)';
    RAISE NOTICE '  2. Check that the company exists in the companies table';
    RAISE NOTICE '';
    RAISE NOTICE 'To fix: Verify the company exists with:';
    RAISE NOTICE '  SELECT id, name FROM companies WHERE id = ''%'';', '{COMPANY_ID}';
    RAISE EXCEPTION 'Foreign key constraint violation - see details above';
  
  WHEN OTHERS THEN
    RAISE NOTICE '❌ ERROR: Unexpected error occurred';
    RAISE NOTICE 'Error code: %', SQLSTATE;
    RAISE NOTICE 'Error message: %', SQLERRM;
    RAISE EXCEPTION 'Unexpected error - see details above';
END $$;

-- Step 4: Verification - View updated assignment
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
  AND assignment_type = '{ASSIGNMENT_TYPE}';

-- Step 5: Verification - View all assignments for this agent
SELECT 
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  is_active,
  assigned_at,
  updated_at
FROM agent_models
WHERE agent_id = '{AGENT_NAME}'
ORDER BY priority;

-- ==========================================
-- EXAMPLE USAGE FOR MEASUREFORGE AI AGENTS
-- ==========================================

-- Example 1: Change model for Max the Measurement Maestro's primary assignment
/*
UPDATE agent_models
SET
  model_id = 'claude-opus-4',
  reason = 'Upgraded to Claude Opus 4 for better measurement orchestration',
  updated_at = NOW()
WHERE agent_id = 'Max the Measurement Maestro'
  AND assignment_type = 'primary';
*/

-- Example 2: Adjust temperature for Luna the Coordination Queen's fallback
/*
UPDATE agent_models
SET
  temperature = 0.2,
  reason = 'Increased temperature for more creative coordination strategies',
  updated_at = NOW()
WHERE agent_id = 'Luna the Coordination Queen'
  AND assignment_type = 'fallback';
*/

-- Example 3: Deactivate a model assignment
/*
UPDATE agent_models
SET
  is_active = false,
  reason = 'Temporarily disabled for testing',
  updated_at = NOW()
WHERE agent_id = 'Archie the Building Buddy'
  AND assignment_type = 'primary';
*/

-- Example 4: Bulk update all MeasureForge agents to increase max_tokens
/*
UPDATE agent_models
SET
  max_tokens = 8192,
  reason = 'Increased token limit for complex measurement tasks',
  updated_at = NOW()
WHERE agent_id IN (
  SELECT name FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
)
AND assignment_type = 'primary';
*/

-- Example 5: Update priority for fallback models
/*
UPDATE agent_models
SET
  priority = 3,
  updated_at = NOW()
WHERE agent_id = 'Steel the Structure Sultan'
  AND assignment_type = 'fallback';
*/
