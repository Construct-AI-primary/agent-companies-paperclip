-- ============================================================
-- AGENT REGISTRATION - Paperclip Setup Specialist
-- Company: InfraForge AI
-- Agent: paperclip-setup-infraforge-specialist
-- Date: 2026-04-29
-- Template: docs-paperclip/schema/templates/REGISTER-agent.sql
-- ============================================================
-- INSTRUCTIONS:
-- 1. Verify schema compatibility first:
--    SELECT column_name, data_type 
--    FROM information_schema.columns 
--    WHERE table_name = 'agents' 
--    ORDER BY ordinal_position;
-- 2. Execute this entire script in a single transaction
-- 3. Verify with the final SELECT query
-- ============================================================

BEGIN;

-- Step 1: Insert agent record
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  reports_to,
  capabilities,
  adapter_type,
  adapter_config,
  budget_monthly_cents,
  spent_monthly_cents,
  is_active,
  runtime_config,
  permissions,
  metadata,
  created_at,
  updated_at
)
VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'InfraForge AI' AND status = 'active'),
  'Paperclip Setup Specialist',
  'specialist',
  'Paperclip Setup Specialist',
  'idle',
  (SELECT id FROM agents WHERE name = 'Orchestrator' AND company_id = (SELECT id FROM companies WHERE name = 'InfraForge AI' AND status = 'active')),
  'Paperclip terminal setup, local development environment bootstrap, Supabase connection configuration, and environment verification.',
  'http',
  '{"url": "https://hermes-agent-web-6eeu.onrender.com/", "model": "openrouter/qwen/qwen-3-6-plus", "timeoutSec": 300, "persistSession": true}'::jsonb,
  0,
  0,
  true,
  '{"heartbeat": {"enabled": false, "intervalSec": 300, "wakeOnDemand": true, "wakeOnAssignment": true, "wakeOnAutomation": true, "maxConcurrentRuns": 1}}'::jsonb,
  '{"canCreateAgents": false}'::jsonb,
  '{"agent_slug": "paperclip-setup-infraforge-specialist", "team": "infrastructure", "skills": ["terminal-setup", "supabase-configuration", "development-environment-bootstrap"]}'::jsonb,
  now(),
  now()
)
ON CONFLICT DO NOTHING;

-- Step 2: Insert API key record
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Paperclip Setup Specialist' AND company_id = (SELECT id FROM companies WHERE name = 'InfraForge AI' AND status = 'active') ORDER BY created_at DESC LIMIT 1),
  (SELECT id FROM companies WHERE name = 'InfraForge AI' AND status = 'active'),
  'paperclip-setup-infraforge-specialist_key',
  'pcak_' || encode(gen_random_uuid()::text::bytea, 'base64'),
  encode(digest('pcak_paperclip-setup-infraforge-specialist_' || gen_random_uuid()::text, 'sha256'), 'hex'),
  NOW()
)
ON CONFLICT DO NOTHING;

-- Step 3: Insert activity log record
INSERT INTO activity_log (
  id,
  company_id,
  actor_type,
  actor_id,
  action,
  entity_type,
  entity_id,
  agent_id,
  details,
  created_at
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'InfraForge AI' AND status = 'active'),
  'system',
  'atlas-agent-creator',
  'create',
  'agent',
  (SELECT id FROM agents WHERE name = 'Paperclip Setup Specialist' AND company_id = (SELECT id FROM companies WHERE name = 'InfraForge AI' AND status = 'active') ORDER BY created_at DESC LIMIT 1),
  (SELECT id FROM agents WHERE name = 'Paperclip Setup Specialist' AND company_id = (SELECT id FROM companies WHERE name = 'InfraForge AI' AND status = 'active') ORDER BY created_at DESC LIMIT 1),
  '{
    "description": "Created paperclip-setup-infraforge-specialist agent",
    "skills": ["terminal-setup", "supabase-configuration", "development-environment-bootstrap"],
    "capabilities": "Paperclip terminal setup, local development environment bootstrap, Supabase connection configuration, and environment verification.",
    "team": "infrastructure",
    "created_by_procedure": "atlas-agent-creation-with-schema-inspection-procedure"
  }'::jsonb,
  NOW()
)
ON CONFLICT DO NOTHING;

-- Verification Query
SELECT
  a.id AS agent_id,
  a.name AS agent_name,
  a.role,
  a.title,
  a.status,
  a.adapter_type,
  c.name AS company_name,
  a.created_at,
  ak.name AS api_key_name,
  ak.created_at AS key_created_at
FROM
  agents a
JOIN
  companies c ON a.company_id = c.id
LEFT JOIN
  agent_api_keys ak ON a.id = ak.agent_id
WHERE
  a.name = 'Paperclip Setup Specialist'
  AND c.name = 'InfraForge AI'
ORDER BY
  a.created_at DESC
LIMIT 1;

COMMIT;