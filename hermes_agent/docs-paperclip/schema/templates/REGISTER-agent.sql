-- ============================================================
-- AGENT REGISTRATION TEMPLATE (ENHANCED)
-- Company: [COMPANY_NAME]
-- Agent: [AGENT_NAME]
-- Date: [DATE]
-- Version: 2.0 (moved from scripts/database-templates)
-- ============================================================
-- INSTRUCTIONS:
-- 1. Replace all [PLACEHOLDER] values before executing
-- 2. Read schema docs BEFORE modifying any column names:
--    - companies: docs-paperclip/schema/tables/companies.md
--    - agents: docs-paperclip/schema/tables/agents.md
--    - agent_api_keys: docs-paperclip/schema/tables/agent-models.md
--    - agent_models: docs-paperclip/schema/tables/agent-models.md
-- 3. Companies table uses 'name' for lookups (NOT 'issue_prefix' or 'slug')
-- 4. Use VALUES pattern (not SELECT) for better error handling
-- 5. This template creates: agents + agent_api_keys + activity_log records
-- 6. agent_models is OPTIONAL (model config can be in agents.model_config)
-- ============================================================

BEGIN;

-- Step 1: Insert agent record
-- REQUIRED: Read docs-paperclip/schema/tables/agents.md for valid columns
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
  (SELECT id FROM companies WHERE name = '[COMPANY_NAME]' AND status = 'active'),
  '[AGENT_NAME]',
  '[AGENT_ROLE]',  -- specialist, manager, ceo, etc.
  '[AGENT_TITLE]',
  'idle',
  (SELECT id FROM agents WHERE name = '[MANAGER_AGENT_NAME]' AND company_id = (SELECT id FROM companies WHERE name = '[COMPANY_NAME]' AND status = 'active')),
  '[CAPABILITIES_DESCRIPTION]',
  'hermes_local',
  '{"persistSession": true, "toolsets": ["file_tools", "terminal_tools", "code_execution"]}'::jsonb,
  50000000,
  0,
  true,
  '{"provider": "openrouter", "model": "[MODEL_ID]"}'::jsonb,
  '{"automation_enabled": true, "max_iterations": 50}'::jsonb,
  '{"company_access": "[COMPANY_NAME]"}'::jsonb,
  '{"agent_slug": "[AGENT_SLUG]", "team": "[TEAM_NAME]", "skills": []}'::jsonb,
  now(),
  now()
)
ON CONFLICT DO NOTHING;

-- Step 2: Insert API key record
-- REQUIRED: Read docs-paperclip/schema/tables/agent-models.md for valid columns
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
  (SELECT id FROM agents WHERE name = '[AGENT_NAME]' AND company_id = (SELECT id FROM companies WHERE name = '[COMPANY_NAME]' AND status = 'active') ORDER BY created_at DESC LIMIT 1),
  (SELECT id FROM companies WHERE name = '[COMPANY_NAME]' AND status = 'active'),
  '[AGENT_SLUG]_key',
  'pcak_' || encode(gen_random_uuid()::text::bytea, 'base64'),
  encode(digest('pcak_[AGENT_SLUG]_' || gen_random_uuid()::text, 'sha256'), 'hex'),
  NOW()
)
ON CONFLICT DO NOTHING;

-- Step 3: Insert activity log record
-- OPTIONAL: Audit trail for agent creation
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
  (SELECT id FROM companies WHERE name = '[COMPANY_NAME]' AND status = 'active'),
  'system',
  'atlas-agent-creator',
  'create',
  'agent',
  (SELECT id FROM agents WHERE name = '[AGENT_NAME]' AND company_id = (SELECT id FROM companies WHERE name = '[COMPANY_NAME]' AND status = 'active') ORDER BY created_at DESC LIMIT 1),
  (SELECT id FROM agents WHERE name = '[AGENT_NAME]' AND company_id = (SELECT id FROM companies WHERE name = '[COMPANY_NAME]' AND status = 'active') ORDER BY created_at DESC LIMIT 1),
  '{
    "description": "Created [AGENT_NAME] agent",
    "skills": [],
    "capabilities": "[CAPABILITIES_DESCRIPTION]",
    "team": "[TEAM_NAME]",
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
  a.name = '[AGENT_NAME]'
  AND c.name = '[COMPANY_NAME]'
ORDER BY
  a.created_at DESC
LIMIT 1;

COMMIT;

-- ============================================================
-- PLACEHOLDER REFERENCE
-- ============================================================
-- [COMPANY_NAME] - Full company name (e.g., "InfraForge AI")
-- [AGENT_NAME] - Agent name (e.g., "Atlas Sync")
-- [AGENT_ROLE] - Agent role (specialist, manager, ceo)
-- [AGENT_TITLE] - Agent title (e.g., "Supabase-SQLite Sync Specialist")
-- [MANAGER_AGENT_NAME] - Manager agent name (e.g., "Orchestrator")
-- [CAPABILITIES_DESCRIPTION] - Text description of capabilities
-- [MODEL_ID] - Model identifier (e.g., "openrouter/anthropic/claude-sonnet-4.5")
-- [AGENT_SLUG] - Kebab-case slug (e.g., "atlas-infraforge-sqlite-sync-specialist")
-- [TEAM_NAME] - Team name (e.g., "infrastructure")
-- [DATE] - Current date (YYYY-MM-DD)
