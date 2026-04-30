-- ==========================================
-- Add Agent Model Assignments Template
-- Created: 2026-04-23
-- Description: Template for adding model assignments to MeasureForge AI agents
--              Extends the workflow from _fix-measureforge-agents.sql
-- ==========================================
-- 
-- INSTRUCTIONS:
-- 1. Replace {COMPANY_ID} with the target company UUID
-- 2. Replace {AGENT_NAME} with the agent name (e.g., 'Max the Measurement Maestro')
-- 3. Replace {MODEL_ID} with the model identifier (e.g., 'qwen-max', 'ernie-4.0-turbo')
-- 4. Replace {ASSIGNMENT_TYPE} with 'primary' or 'fallback'
-- 5. Replace {PRIORITY} with priority number (1 for primary, 2+ for fallback)
-- 6. Adjust temperature and max_tokens as needed
-- 7. Update reason field with specific justification
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

-- Step 2: Check existing model assignments for this agent
SELECT 
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  is_active,
  assigned_at
FROM agent_models
WHERE agent_id = '{AGENT_NAME}'
ORDER BY priority;

-- Step 3: Add new model assignment
-- NOTE: Uses agent name as agent_id (TEXT), not UUID
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  '{AGENT_NAME}',                    -- agent_id (TEXT - agent name)
  '{MODEL_ID}',                      -- model_id (e.g., 'qwen-max')
  '{ASSIGNMENT_TYPE}',               -- 'primary' or 'fallback'
  {PRIORITY},                        -- 1 for primary, 2+ for fallback
  0.1,                               -- temperature (adjust as needed)
  6144,                              -- max_tokens (adjust as needed)
  'system',                          -- assigned_by
  'Model assignment for {AGENT_NAME} - {ASSIGNMENT_TYPE}',  -- reason
  true,                              -- is_active
  '{COMPANY_ID}'                     -- company_id
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

EXCEPTION
  WHEN foreign_key_violation THEN
    RAISE NOTICE '❌ ERROR: Foreign key constraint violation';
    RAISE NOTICE 'This usually means:';
    RAISE NOTICE '  1. The company_id does not exist in the companies table';
    RAISE NOTICE '  2. Check that company_id = ''%'' exists', '{COMPANY_ID}';
    RAISE NOTICE '';
    RAISE NOTICE 'To fix: Verify the company exists with:';
    RAISE NOTICE '  SELECT id, name FROM companies WHERE id = ''%'';', '{COMPANY_ID}';
    RAISE EXCEPTION 'Foreign key constraint violation - see details above';
  
  WHEN unique_violation THEN
    RAISE NOTICE '❌ ERROR: Unique constraint violation';
    RAISE NOTICE 'This usually means:';
    RAISE NOTICE '  1. An assignment with this agent_id and assignment_type already exists';
    RAISE NOTICE '  2. The ON CONFLICT clause should have handled this - check your data';
    RAISE NOTICE '';
    RAISE NOTICE 'Current assignment: agent_id=''%'', assignment_type=''%''', '{AGENT_NAME}', '{ASSIGNMENT_TYPE}';
    RAISE EXCEPTION 'Unique constraint violation - see details above';
  
  WHEN OTHERS THEN
    RAISE NOTICE '❌ ERROR: Unexpected error occurred';
    RAISE NOTICE 'Error code: %', SQLSTATE;
    RAISE NOTICE 'Error message: %', SQLERRM;
    RAISE EXCEPTION 'Unexpected error - see details above';
END $$;

-- Step 4: Verification - Check all assignments for this agent
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

-- Step 5: Verification - Count total assignments by type
SELECT 
  assignment_type,
  COUNT(*) as count,
  COUNT(CASE WHEN is_active THEN 1 END) as active_count
FROM agent_models
WHERE agent_id = '{AGENT_NAME}'
GROUP BY assignment_type;

-- ==========================================
-- EXAMPLE USAGE FOR MEASUREFORGE AI AGENTS
-- ==========================================

-- Example 1: Add primary model to Max the Measurement Maestro
/*
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'Max the Measurement Maestro',
  'qwen-max',
  'primary',
  1,
  0.1,
  6144,
  'system',
  'Primary model assignment for measurement orchestration',
  true,
  '550e8400-e29b-41d4-a716-446655440013'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  updated_at = NOW();
*/

-- Example 2: Add fallback model to Luna the Coordination Queen
/*
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'Luna the Coordination Queen',
  'ernie-4.0-turbo',
  'fallback',
  2,
  0.1,
  6144,
  'system',
  'Fallback model for cross-discipline coordination',
  true,
  '550e8400-e29b-41d4-a716-446655440013'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  updated_at = NOW();
*/
