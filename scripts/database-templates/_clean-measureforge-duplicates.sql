-- ==========================================
-- Clean MeasureForge AI Agent Duplicates
-- Created: 2026-04-22
-- Description: Removes ALL MeasureForge AI agents to prepare
--              for clean restoration
-- ==========================================

-- First, identify current agents
SELECT
  name,
  COUNT(*) as count
FROM agents
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
GROUP BY name
ORDER BY name;

-- Delete ALL MeasureForge AI agents and related data (clean slate approach)

-- First, delete runtime state records
DELETE FROM agent_runtime_state
WHERE agent_id::text IN (
  SELECT id::text FROM agents
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
);

-- Then delete API keys
DELETE FROM agent_api_keys
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013';

-- Then delete model assignments
DELETE FROM agent_models
WHERE agent_id::text IN (
  SELECT id::text FROM agents
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
);

-- Finally, delete the agents themselves
DELETE FROM agents
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013';

-- Verify cleanup
SELECT
  'MeasureForge Agents' as table_name,
  COUNT(*) as remaining_records
FROM agents
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'

UNION ALL

SELECT
  'Agent API Keys' as table_name,
  COUNT(*) as remaining_records
FROM agent_api_keys
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'

UNION ALL

SELECT
  'Agent Runtime State' as table_name,
  COUNT(*) as remaining_records
FROM agent_runtime_state
WHERE agent_id::text IN (
  SELECT id::text FROM agents
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
)

UNION ALL

SELECT
  'Agent Models' as table_name,
  COUNT(*) as remaining_records
FROM agent_models
WHERE agent_id::text IN (
  SELECT id::text FROM agents
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
);
