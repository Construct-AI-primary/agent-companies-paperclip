-- ============================================================
-- AGENT REGISTRATION: Error Pattern Monitor
-- Company: LearningForge AI
-- Agent: learningforge-ai-error-pattern-monitor
-- Date: 2026-04-25
-- ============================================================
-- INSTRUCTIONS:
-- 1. Replace all [PLACEHOLDER] values before executing
-- 2. Read schema docs BEFORE modifying any column names:
--    - agents: docs-paperclip/schema/tables/agents.md
--    - agent_api_keys: docs-paperclip/schema/tables/agent-models.md
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
  model_config,
  runtime_config,
  permissions,
  metadata,
  created_at,
  updated_at
)
VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'LearningForge AI' AND status = 'active'),
  'learningforge-ai-error-pattern-monitor',
  'specialist',
  'Error Pattern Monitor',
  'idle',
  (SELECT id FROM agents WHERE name = 'learningforge-ai-learning-division-lead' AND company_id = (SELECT id FROM companies WHERE name = 'LearningForge AI' AND status = 'active')),
  '["error_pattern_detection", "cross_company_monitoring", "alert_generation"]',
  'hermes_local',
  '{"persistSession": true, "toolsets": ["file_tools", "terminal_tools"]}'::jsonb,
  50000000,
  0,
  true,
  '{"provider": "openrouter", "model": "openrouter/anthropic/claude-sonnet-4.5"}'::jsonb,
  '{"automation_enabled": true, "max_iterations": 50}'::jsonb,
  '{"company_access": "all"}'::jsonb,
  '{"team": "learning", "skills": ["learningforge-ai-error-pattern-monitor"]}'::jsonb,
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
  (SELECT id FROM agents WHERE name = 'learningforge-ai-error-pattern-monitor' AND company_id = (SELECT id FROM companies WHERE name = 'LearningForge AI' AND status = 'active') ORDER BY created_at DESC LIMIT 1),
  (SELECT id FROM companies WHERE name = 'LearningForge AI' AND status = 'active'),
  'learningforge-ai-error-pattern-monitor_key',
  'pcak_' || encode(gen_random_uuid()::text::bytea, 'base64'),
  encode(digest('pcak_learningforge-ai-error-pattern-monitor_' || gen_random_uuid()::text, 'sha256'), 'hex'),
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
  a.created_at
FROM
  agents a
JOIN
  companies c ON a.company_id = c.id
WHERE
  a.name = 'learningforge-ai-error-pattern-monitor'
  AND c.name = 'LearningForge AI'
ORDER BY
  a.created_at DESC
LIMIT 1;

COMMIT;
