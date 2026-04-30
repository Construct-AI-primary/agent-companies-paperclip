-- ==========================================
-- Batch Agent Registration Template
-- Created: 2026-04-23
-- Description: Template for registering multiple agents in a single transaction
--              Includes agent registration, model assignments, and API keys
-- 
-- USAGE:
-- 1. Copy this file to your company's agent directory
-- 2. Replace all {PLACEHOLDERS} with actual values
-- 3. Run in Supabase SQL Editor (not REST API)
--
-- TEMPLATE PATTERN:
-- - agents table: INSERT ... SELECT ... WHERE NOT EXISTS
-- - agent_models table: INSERT ... ON CONFLICT (agent_id, assignment_type) DO UPDATE
-- - agent_api_keys table: INSERT ... SELECT ... (uses UUID from agents.id)
-- ==========================================

-- ==========================================
-- SECTION 1: CONFIGURATION (Replace these)
-- ==========================================
-- {COMPANY_ID} - UUID of the company (e.g., '550e8400-e29b-41d4-a716-446655440014')
-- {DEFAULT_MODEL} - Default model for agents (e.g., 'z-ai/glm-4-flash')
-- {REPORTS_TO_AGENT} - Agent name that new agents report to (e.g., 'company-operations-director')

-- ==========================================
-- SECTION 2: AGENT REGISTRATIONS
-- ==========================================
-- Add each agent as an INSERT ... SELECT ... WHERE NOT EXISTS statement

-- Example agent template:
/*
INSERT INTO agents (
  id, company_id, name, role, title, status, reports_to,
  capabilities, adapter_type, adapter_config, runtime_config,
  budget_monthly_cents, spent_monthly_cents, permissions, metadata,
  created_at, updated_at, is_active
)
SELECT
  gen_random_uuid(),
  '{COMPANY_ID}',
  '{AGENT_NAME}',              -- kebab-case: company-role-specialty
  'specialist',                -- or 'executive', 'analyst', etc.
  '{Human Title}',            -- Display name
  'idle',                      -- or 'active', 'maintenance'
  (SELECT id FROM agents WHERE name = '{REPORTS_TO_AGENT}' LIMIT 1),  -- or NULL for top-level
  '{capability1; capability2; capability3;}',
  'process',                   -- or 'http', 'cli', etc.
  '{"model": "{MODEL}", "temperature": 0.7, "max_tokens": 4096}'::jsonb,
  '{"max_concurrent_tasks": 3, "timeout_seconds": 1200}'::jsonb,
  500000, 0,                   -- budget_monthly_cents, spent_monthly_cents
  '{"access": {"read_company_data": true, "write_company_data": true}}'::jsonb,
  '{"human_name": "{Human Title}", "specialization": "area", "created_via": "batch-registration"}'::jsonb,
  NOW(), NOW(), true
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = '{AGENT_NAME}');
*/

-- ==========================================
-- SECTION 3: MODEL ASSIGNMENTS
-- ==========================================
-- Add after all agent registrations
-- Uses ON CONFLICT pattern from _add-agent-models-template.sql

/*
INSERT INTO agent_models (
  agent_id, model_id, assignment_type, priority,
  temperature, max_tokens, assigned_by, reason, is_active, company_id
) VALUES
  ('{AGENT_NAME_1}', '{MODEL}', 'primary', 1, 0.7, 4096, 'system', 'Default model for {specialty}', true, '{COMPANY_ID}'),
  ('{AGENT_NAME_2}', '{MODEL}', 'primary', 1, 0.5, 4096, 'system', 'Default model for {specialty}', true, '{COMPANY_ID}')
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  updated_at = NOW();
*/

-- ==========================================
-- SECTION 4: API KEY GENERATION
-- ==========================================
-- Add after model assignments
-- Uses pattern from _add-agent-api-keys-template.sql

/*
INSERT INTO agent_api_keys (
  id, agent_id, company_id, name, api_key, key_hash, created_at
) SELECT
  gen_random_uuid(),
  a.id,                              -- UUID from agents table
  a.company_id,
  CONCAT(a.title, ' API Key'),
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),
  encode(sha256(random()::text::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = '{COMPANY_ID}'
  AND a.name IN ('{AGENT_NAME_1}', '{AGENT_NAME_2}', ...)
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL
  );
*/

-- ==========================================
-- SECTION 5: VERIFICATION QUERIES
-- ==========================================

-- Count registered agents
SELECT 'Registered Agents' as status,
  COUNT(*) as total
FROM agents
WHERE company_id = '{COMPANY_ID}';

-- Count model assignments
SELECT 'Model Assignments' as status,
  COUNT(*) as total
FROM agent_models
WHERE company_id = '{COMPANY_ID}';

-- Count API keys
SELECT 'API Keys' as status,
  COUNT(*) as total
FROM agent_api_keys aak
JOIN agents a ON aak.agent_id = a.id
WHERE a.company_id = '{COMPANY_ID}'
  AND aak.revoked_at IS NULL;

-- ==========================================
-- EXAMPLE: PaperclipForge AI Batch Registration
-- ==========================================
/*
-- PaperclipForge AI company: 550e8400-e29b-41d4-a716-446655440014

-- Agent 1: Operations Specialist
INSERT INTO agents (id, company_id, name, role, title, status, reports_to,
  capabilities, adapter_type, adapter_config, runtime_config,
  budget_monthly_cents, spent_monthly_cents, permissions, metadata,
  created_at, updated_at, is_active)
SELECT gen_random_uuid(), '550e8400-e29b-41d4-a716-446655440014',
  'company-operations-specialist', 'specialist', 'Operations Specialist', 'idle',
  (SELECT id FROM agents WHERE name = 'company-operations-director' LIMIT 1),
  'Operations coordination; Process optimization; Performance monitoring.',
  'process', '{"model": "z-ai/glm-4-flash", "temperature": 0.7}'::jsonb,
  '{"max_concurrent_tasks": 3}'::jsonb, 400000, 0,
  '{"access": {"read_company_data": true}}'::jsonb,
  '{"human_name": "Operations Specialist"}'::jsonb, NOW(), NOW(), true
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'company-operations-specialist');

-- Model assignment with ON CONFLICT
INSERT INTO agent_models (agent_id, model_id, assignment_type, priority,
  temperature, max_tokens, assigned_by, reason, is_active, company_id)
VALUES ('company-operations-specialist', 'z-ai/glm-4-flash', 'primary', 1,
  0.7, 4096, 'system', 'Default model for operations', true,
  '550e8400-e29b-41d4-a716-446655440014')
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET model_id = EXCLUDED.model_id, updated_at = NOW();
*/

-- ==========================================
-- FK DEPENDENCY REFERENCE
-- ==========================================
-- agents.id → UUID primary key
-- agent_models.agent_id → TEXT (agent name, NOT UUID)
-- agent_api_keys.agent_id → UUID FK to agents.id
-- agent_api_keys.company_id → companies.id
-- 
-- INSERT ORDER:
-- 1. agents (must exist first for FK references)
-- 2. agent_models (uses agent name as TEXT)
-- 3. agent_api_keys (uses agent UUID from step 1)
