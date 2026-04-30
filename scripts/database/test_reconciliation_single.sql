-- ============================================================
-- TEST: Single Record Reconciliation
-- This script tests the fix for the duplicate key error on
-- agent_models_agent_id_assignment_type_key constraint
-- ============================================================

BEGIN;

-- STEP 1: Check if the test agent already exists
SELECT id, name, title, company_id 
FROM agents 
WHERE title = 'contentforge-ai-SEOStrategist'
LIMIT 1;

-- STEP 2: Check if model assignment already exists
SELECT id, agent_id, model_id, assignment_type 
FROM agent_models 
WHERE agent_id = (SELECT id FROM agents WHERE title = 'contentforge-ai-SEOStrategist' LIMIT 1)
  AND assignment_type = 'default'
LIMIT 1;

-- STEP 3: Delete existing records for this agent (if any)
-- This follows the FK deletion order from _delete-agent-template.sql

-- 3a. Delete agent model assignments first (no child deps)
DELETE FROM agent_models 
WHERE agent_id IN (
    SELECT id FROM agents 
    WHERE title = 'contentforge-ai-SEOStrategist'
);

-- 3b. Delete agent API keys
DELETE FROM agent_api_keys 
WHERE agent_id IN (
    SELECT id FROM agents 
    WHERE title = 'contentforge-ai-SEOStrategist'
);

-- 3c. Delete agent skill assignments
DELETE FROM agent_skill_assignments 
WHERE agent_id IN (
    SELECT id FROM agents 
    WHERE title = 'contentforge-ai-SEOStrategist'
);

-- 3d. Delete agent runtime state
DELETE FROM agent_runtime_state 
WHERE agent_id IN (
    SELECT id FROM agents 
    WHERE title = 'contentforge-ai-SEOStrategist'
);

-- 3e. Delete agent task sessions
DELETE FROM agent_task_sessions 
WHERE agent_id IN (
    SELECT id FROM agents 
    WHERE title = 'contentforge-ai-SEOStrategist'
);

-- 3f. Delete the agent itself
DELETE FROM agents 
WHERE title = 'contentforge-ai-SEOStrategist';

-- STEP 4: Insert the test agent
INSERT INTO agents (
    id, company_id, name, role, title, status, capabilities, 
    adapter_type, adapter_config, runtime_config, created_at, updated_at
) VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'SEO Strategist',
    'general',
    'contentforge-ai-SEOStrategist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- STEP 5: Insert model assignment using ON CONFLICT pattern
-- This is the FIX for the duplicate key error
INSERT INTO agent_models (
    id, agent_id, model_id, assignment_type, temperature, max_tokens, 
    is_active, created_at, updated_at
)
SELECT
    gen_random_uuid(),
    a.id,
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
FROM agents a
WHERE a.title = 'contentforge-ai-SEOStrategist'
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
    model_id = EXCLUDED.model_id,
    temperature = EXCLUDED.temperature,
    max_tokens = EXCLUDED.max_tokens,
    is_active = EXCLUDED.is_active,
    updated_at = NOW();

-- STEP 6: Insert API key
INSERT INTO agent_api_keys (
    id, agent_id, company_id, name, api_key, key_hash, created_at
)
SELECT
    gen_random_uuid(),
    a.id,
    a.company_id,
    'SEO Strategist API Key',
    'pcak_' || encode(gen_random_bytes(32), 'hex'),
    encode(sha256(random()::text::bytea), 'hex'),
    NOW()
FROM agents a
WHERE a.title = 'contentforge-ai-SEOStrategist'
ON CONFLICT DO NOTHING;

-- STEP 7: Verify the results
SELECT 'Agent' as record_type, id, name, title, status
FROM agents 
WHERE title = 'contentforge-ai-SEOStrategist';

SELECT 'Model Assignment' as record_type, id, agent_id, model_id, assignment_type, is_active
FROM agent_models 
WHERE agent_id = (SELECT id FROM agents WHERE title = 'contentforge-ai-SEOStrategist');

SELECT 'API Key' as record_type, id, agent_id, name
FROM agent_api_keys 
WHERE agent_id = (SELECT id FROM agents WHERE title = 'contentforge-ai-SEOStrategist');

COMMIT;