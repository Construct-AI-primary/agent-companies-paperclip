-- ==========================================
-- Add Agent API Keys Template
-- Created: 2026-04-23
-- Description: Template for adding API keys to MeasureForge AI agents
--              Extends the workflow from _fix-measureforge-agents.sql
-- ==========================================
-- 
-- INSTRUCTIONS:
-- 1. Replace {COMPANY_ID} with the target company UUID
-- 2. Replace {AGENT_NAME} with the agent name to look up agent_id
-- 3. Optionally customize the key name
--
-- FK DEPENDENCIES (from FK-DEPENDENCY-LEVELS.md):
-- - agent_api_keys.agent_id → agents.id (NO ACTION)
-- - agent_api_keys.company_id → companies.id (NO ACTION)
--
-- DELETION ORDER NOTES (from FK-DEPENDENCY-LEVELS.md):
-- - agent_api_keys must be deleted BEFORE agents (order #8 of 12)
-- - agent_api_keys has NO child dependencies (safe to delete anytime)
-- - When deleting agents, you MUST delete agent_api_keys first
-- - See FK-DEPENDENCY-LEVELS.md for complete deletion order hierarchy
--
-- IMPORTANT: agent_api_keys uses agent_id as UUID FK (not TEXT like agent_models)
-- ==========================================

-- Error handling wrapper
DO $$
DECLARE
  v_agent_id UUID;
  v_rows_inserted INTEGER;
BEGIN

-- Step 1: Verify target agent exists and get agent_id
SELECT 
  id as agent_id,
  name,
  company_id,
  role,
  title,
  status
FROM agents
WHERE company_id = '{COMPANY_ID}'
  AND name = '{AGENT_NAME}'
LIMIT 1;

-- Step 2: Check existing API keys for this agent
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
AND revoked_at IS NULL
ORDER BY created_at DESC;

-- Step 3: Add new API key for the agent
-- NOTE: Uses agent UUID from agents table, not agent name

-- First, get the agent_id
SELECT id INTO v_agent_id
FROM agents
WHERE company_id = '{COMPANY_ID}'
  AND name = '{AGENT_NAME}'
LIMIT 1;

IF v_agent_id IS NULL THEN
  RAISE NOTICE '❌ ERROR: Agent not found';
  RAISE NOTICE 'No agent exists with:';
  RAISE NOTICE '  company_id = ''%''', '{COMPANY_ID}';
  RAISE NOTICE '  name = ''%''', '{AGENT_NAME}';
  RAISE NOTICE '';
  RAISE NOTICE 'To fix: Verify the agent exists with:';
  RAISE NOTICE '  SELECT id, name, company_id FROM agents WHERE name = ''%'';', '{AGENT_NAME}';
  RAISE EXCEPTION 'Agent not found - see details above';
END IF;

INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) SELECT
  gen_random_uuid(),
  a.id,                                                    -- agent_id (UUID FK)
  a.company_id,
  CONCAT(a.title, ' API Key'),                            -- key name
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),   -- generate API key
  encode(sha256(random()::text::bytea), 'hex'),           -- generate key hash
  NOW()
FROM agents a
WHERE a.company_id = '{COMPANY_ID}'
  AND a.name = '{AGENT_NAME}'
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id 
      AND aak.revoked_at IS NULL
  )
LIMIT 1;

GET DIAGNOSTICS v_rows_inserted = ROW_COUNT;

IF v_rows_inserted = 0 THEN
  RAISE NOTICE '⚠️  WARNING: No API key was created';
  RAISE NOTICE 'This usually means:';
  RAISE NOTICE '  1. The agent already has an active (non-revoked) API key';
  RAISE NOTICE '  2. The agent is not active (is_active = false)';
  RAISE NOTICE '';
  RAISE NOTICE 'To check existing keys:';
  RAISE NOTICE '  SELECT * FROM agent_api_keys WHERE agent_id = ''%'';', v_agent_id;
ELSE
  RAISE NOTICE '✅ Successfully created API key for agent ''%''', '{AGENT_NAME}';
END IF;

EXCEPTION
  WHEN foreign_key_violation THEN
    RAISE NOTICE '❌ ERROR: Foreign key constraint violation';
    RAISE NOTICE 'This usually means:';
    RAISE NOTICE '  1. The agent_id does not exist in the agents table';
    RAISE NOTICE '  2. The company_id does not exist in the companies table';
    RAISE NOTICE '';
    RAISE NOTICE 'To fix: Verify the agent and company exist:';
    RAISE NOTICE '  SELECT id, name FROM agents WHERE id = ''%'';', v_agent_id;
    RAISE NOTICE '  SELECT id, name FROM companies WHERE id = ''%'';', '{COMPANY_ID}';
    RAISE EXCEPTION 'Foreign key constraint violation - see details above';
  
  WHEN unique_violation THEN
    RAISE NOTICE '❌ ERROR: Unique constraint violation';
    RAISE NOTICE 'This usually means:';
    RAISE NOTICE '  1. An API key with this ID already exists (very rare with gen_random_uuid)';
    RAISE NOTICE '  2. There may be a unique constraint on api_key or key_hash';
    RAISE EXCEPTION 'Unique constraint violation - see details above';
  
  WHEN OTHERS THEN
    RAISE NOTICE '❌ ERROR: Unexpected error occurred';
    RAISE NOTICE 'Error code: %', SQLSTATE;
    RAISE NOTICE 'Error message: %', SQLERRM;
    RAISE EXCEPTION 'Unexpected error - see details above';
END $$;

-- Step 4: Verification - View newly created API key
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
ORDER BY created_at DESC
LIMIT 1;

-- Step 5: Verification - Count total active keys for this agent
SELECT 
  '{AGENT_NAME}' as agent_name,
  COUNT(*) as total_keys,
  COUNT(CASE WHEN revoked_at IS NULL THEN 1 END) as active_keys,
  COUNT(CASE WHEN revoked_at IS NOT NULL THEN 1 END) as revoked_keys
FROM agent_api_keys
WHERE agent_id = (
  SELECT id FROM agents 
  WHERE company_id = '{COMPANY_ID}' 
    AND name = '{AGENT_NAME}'
  LIMIT 1
);

-- ==========================================
-- EXAMPLE USAGE FOR MEASUREFORGE AI AGENTS
-- ==========================================

-- Example 1: Add API key for Max the Measurement Maestro
/*
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) SELECT
  gen_random_uuid(),
  a.id,
  a.company_id,
  'Max the Measurement Maestro API Key',
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),
  encode(sha256(random()::text::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND a.name = 'Max the Measurement Maestro'
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL
  )
LIMIT 1;
*/

-- Example 2: Bulk create API keys for all MeasureForge agents without keys
/*
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) SELECT
  gen_random_uuid(),
  a.id,
  a.company_id,
  CONCAT(a.title, ' API Key'),
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),
  encode(sha256(random()::text::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL
  );
*/

-- Example 3: Add a second API key for an agent (e.g., for testing)
/*
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) SELECT
  gen_random_uuid(),
  a.id,
  a.company_id,
  CONCAT(a.title, ' Testing API Key'),
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),
  encode(sha256(random()::text::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND a.name = 'Luna the Coordination Queen'
  AND a.is_active = true
LIMIT 1;
*/
