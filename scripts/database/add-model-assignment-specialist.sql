-- ============================================================
-- MODEL ASSIGNMENT SPECIALIST AGENT REGISTRATION
-- Company: PaperclipForge AI
-- Agent: paperclipforge-ai-model-assignment-specialist
-- Date: 2026-04-24
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
  (SELECT id FROM companies WHERE name = 'PaperclipForge AI' AND status = 'active'),
  'paperclipforge-ai-model-assignment-specialist',
  'specialist',
  'SparkAssign - Model Assignment Specialist',
  'idle',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-atlas-agent-creator' AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI' AND status = 'active')),
  'SparkAssign specializes in intelligent AI model assignment and optimization across the Paperclip ecosystem. SparkAssign manages the mapping of agents to appropriate AI models based on capability analysis, performance requirements, and cost optimization strategies, ensuring every agent receives the optimal AI model for their specific needs.',
  'hermes_local',
  '{"persistSession": true, "toolsets": ["file_tools", "terminal_tools", "code_execution", "web_tools"]}'::jsonb,
  50000000,
  0,
  true,
  '{"provider": "openrouter", "model": "anthropic/claude-3.5-sonnet"}'::jsonb,
  '{"automation_enabled": true, "max_iterations": 50}'::jsonb,
  '{"company_access": "PaperclipForge AI"}'::jsonb,
  '{"agent_slug": "sparkassign-model-assignment-specialist", "team": "operations", "skills": ["model-assignment-optimization", "capability-based-model-selection", "agent-skill-capability-mapping", "model-performance-tuning", "cost-optimization-analysis", "temperature-parameter-optimization", "reasoning-level-configuration", "fallback-model-management", "company-specific-model-overrides", "model-assignment-audit-compliance", "agent-model-priority-management", "database-model-assignment-operations", "model-benchmark-analysis", "agent-capability-assessment", "skill-pattern-recognition", "agent-skill-change-monitoring", "skill-update-triggered-reassessment", "agent-capability-revalidation", "skill-evolution-tracking", "model-reassignment-recommendations"]}'::jsonb,
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
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-model-assignment-specialist' AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI' AND status = 'active') ORDER BY created_at DESC LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PaperclipForge AI' AND status = 'active'),
  'sparkassign-model-assignment-specialist_key',
  'pcak_' || encode(gen_random_uuid()::text::bytea, 'base64'),
  encode(digest('pcak_sparkassign-model-assignment-specialist_' || gen_random_uuid()::text, 'sha256'), 'hex'),
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
  (SELECT id FROM companies WHERE name = 'PaperclipForge AI' AND status = 'active'),
  'system',
  'atlas-agent-creator',
  'create',
  'agent',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-model-assignment-specialist' AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI' AND status = 'active') ORDER BY created_at DESC LIMIT 1),
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-model-assignment-specialist' AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI' AND status = 'active') ORDER BY created_at DESC LIMIT 1),
  '{
    "description": "Created SparkAssign - Model Assignment Specialist agent",
    "skills": ["model-assignment-optimization", "capability-based-model-selection", "agent-skill-capability-mapping", "model-performance-tuning", "cost-optimization-analysis", "temperature-parameter-optimization", "reasoning-level-configuration", "fallback-model-management", "company-specific-model-overrides", "model-assignment-audit-compliance", "agent-model-priority-management", "database-model-assignment-operations", "model-benchmark-analysis", "agent-capability-assessment", "skill-pattern-recognition", "agent-skill-change-monitoring", "skill-update-triggered-reassessment", "agent-capability-revalidation", "skill-evolution-tracking", "model-reassignment-recommendations"],
    "capabilities": "SparkAssign specializes in intelligent AI model assignment and optimization across the Paperclip ecosystem. SparkAssign manages the mapping of agents to appropriate AI models based on capability analysis, performance requirements, and cost optimization strategies, ensuring every agent receives the optimal AI model for their specific needs.",
    "team": "operations",
    "created_by_procedure": "atlas-agent-creation-with-schema-inspection-procedure"
  }'::jsonb,
  NOW()
)
ON CONFLICT DO NOTHING;

-- Assign initial model (will be optimized by the agent itself)
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
    'paperclipforge-ai-model-assignment-specialist',
    'anthropic/claude-3.5-sonnet',
    'primary',
    1,
    0.3,
    4096,
    'system',
    'Initial model assignment for Model Assignment Specialist - will be self-optimized',
    true,
    '09f438a3-4041-46f2-b3cc-96fc9446e666'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE SET
    model_id = EXCLUDED.model_id,
    temperature = EXCLUDED.temperature,
    reason = EXCLUDED.reason,
    updated_at = NOW();

-- Add fallback model
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
    'paperclipforge-ai-model-assignment-specialist',
    'anthropic/claude-3-haiku',
    'fallback',
    2,
    0.3,
    4096,
    'system',
    'Fallback model for reliability when primary model is unavailable',
    true,
    '09f438a3-4041-46f2-b3cc-96fc9446e666'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE SET
    model_id = EXCLUDED.model_id,
    temperature = EXCLUDED.temperature,
    reason = EXCLUDED.reason,
    updated_at = NOW();

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
  a.name = 'paperclipforge-ai-model-assignment-specialist'
  AND c.name = 'PaperclipForge AI'
ORDER BY
  a.created_at DESC
LIMIT 1;

COMMIT;

-- ==========================================
-- REGISTRATION COMPLETE
-- ==========================================

-- Expected Results:
-- • Agent: paperclipforge-ai-model-assignment-specialist
-- • Status: active
-- • Role: specialist
-- • Capabilities: 15 skills
-- • API Keys: 1
-- • Models: 2 (primary + fallback)

-- The Model Assignment Specialist is now ready to:
-- 1. Analyze agent capabilities based on skills
-- 2. Assign optimal AI models using the capability mapping system
-- 3. Optimize existing model assignments
-- 4. Audit model assignment effectiveness
-- 5. Handle model assignment requests from Atlas during agent creation