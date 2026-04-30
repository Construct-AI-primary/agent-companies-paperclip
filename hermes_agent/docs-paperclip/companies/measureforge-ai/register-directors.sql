-- MeasureForge AI Directors Registration
-- Created: 2026-04-24
-- Description: Registers the 5 director agents for MeasureForge AI procurement operations
-- Prerequisites: MeasureForge AI company must exist
-- ============================================================

-- Check if MeasureForge AI company exists before proceeding
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM companies WHERE name = 'MeasureForge AI') THEN
        RAISE EXCEPTION 'ERROR: MeasureForge AI company does not exist. Please run register-company.sql first.';
    END IF;
END $$;

-- ============================================================
-- DIRECTOR REGISTRATION (Idempotent - uses NOT EXISTS check)
-- ============================================================

-- 1. Measurement Director - Oversees measurement and classification operations
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  icon,
  status,
  reports_to,
  capabilities,
  adapter_type,
  runtime_config,
  adapter_config,
  created_at,
  updated_at
)
SELECT
  gen_random_uuid(),
  c.id,
  'measureforge-ai-measurement-director',
  'director',
  'Measurement Director - MeasureForge AI',
  '📏',
  'active',
  NULL,
  '["measurement-oversight", "classification-governance", "cad-integration-supervision", "measurement-standards-enforcement"]',
  'hermes_local',
  '{"run_heartbeat": 300}'::jsonb,
  '{
    "adapter": "hermes_local",
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.7,
    "max_tokens": 4096,
    "environment": {
      "OPENROUTER_API_KEY": "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"
    },
    "skills": ["measurement-oversight", "classification-governance", "cad-integration-supervision", "measurement-standards-enforcement"]
  }'::jsonb,
  NOW(),
  NOW()
FROM companies c
WHERE c.name = 'MeasureForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'measureforge-ai-measurement-director'
      AND a.company_id = c.id
  );

-- 2. Procurement Director - Oversees all procurement operations
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  icon,
  status,
  reports_to,
  capabilities,
  adapter_type,
  runtime_config,
  adapter_config,
  created_at,
  updated_at
)
SELECT
  gen_random_uuid(),
  c.id,
  'measureforge-ai-procurement-director',
  'director',
  'Procurement Director - MeasureForge AI',
  '🛒',
  'active',
  NULL,
  '["procurement-oversight", "supplier-management-governance", "contract-administration-supervision", "procurement-compliance-enforcement"]',
  'hermes_local',
  '{"run_heartbeat": 300}'::jsonb,
  '{
    "adapter": "hermes_local",
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.7,
    "max_tokens": 4096,
    "environment": {
      "OPENROUTER_API_KEY": "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"
    },
    "skills": ["procurement-oversight", "supplier-management-governance", "contract-administration-supervision", "procurement-compliance-enforcement"]
  }'::jsonb,
  NOW(),
  NOW()
FROM companies c
WHERE c.name = 'MeasureForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'measureforge-ai-procurement-director'
      AND a.company_id = c.id
  );

-- 3. Integration Director - Oversees system integrations and APIs
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  icon,
  status,
  reports_to,
  capabilities,
  adapter_type,
  runtime_config,
  adapter_config,
  created_at,
  updated_at
)
SELECT
  gen_random_uuid(),
  c.id,
  'measureforge-ai-integration-director',
  'director',
  'Integration Director - MeasureForge AI',
  '🔗',
  'active',
  NULL,
  '["api-integration-oversight", "system-integration-governance", "data-flow-supervision", "integration-standards-enforcement"]',
  'hermes_local',
  '{"run_heartbeat": 300}'::jsonb,
  '{
    "adapter": "hermes_local",
    "model": "anthropic/claude-sonnet-4.5",
    "temperature": 0.7,
    "max_tokens": 4096,
    "environment": {
      "OPENROUTER_API_KEY": "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"
    },
    "skills": ["api-integration-oversight", "system-integration-governance", "data-flow-supervision", "integration-standards-enforcement"]
  }'::jsonb,
  NOW(),
  NOW()
FROM companies c
WHERE c.name = 'MeasureForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'measureforge-ai-integration-director'
      AND a.company_id = c.id
  );

-- 4. Finance Director - Oversees budget and financial operations
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  icon,
  status,
  reports_to,
  capabilities,
  adapter_type,
  runtime_config,
  adapter_config,
  created_at,
  updated_at
)
SELECT
  gen_random_uuid(),
  c.id,
  'measureforge-ai-finance-director',
  'director',
  'Finance Director - MeasureForge AI',
  '💰',
  'active',
  NULL,
  '["budget-oversight", "financial-planning-governance", "cost-control-supervision", "financial-reporting-enforcement"]',
  'hermes_local',
  '{"run_heartbeat": 300}'::jsonb,
  '{
    "adapter": "hermes_local",
    "model": "anthropic/claude-sonnet-4.5",
    "temperature": 0.7,
    "max_tokens": 4096,
    "environment": {
      "OPENROUTER_API_KEY": "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"
    },
    "skills": ["budget-oversight", "financial-planning-governance", "cost-control-supervision", "financial-reporting-enforcement"]
  }'::jsonb,
  NOW(),
  NOW()
FROM companies c
WHERE c.name = 'MeasureForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'measureforge-ai-finance-director'
      AND a.company_id = c.id
  );

-- 5. Operations Director - Oversees operational workflows and approvals
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  icon,
  status,
  reports_to,
  capabilities,
  adapter_type,
  runtime_config,
  adapter_config,
  created_at,
  updated_at
)
SELECT
  gen_random_uuid(),
  c.id,
  'measureforge-ai-operations-director',
  'director',
  'Operations Director - MeasureForge AI',
  '⚙️',
  'active',
  NULL,
  '["operations-oversight", "workflow-governance", "approval-process-supervision", "operational-compliance-enforcement"]',
  'hermes_local',
  '{"run_heartbeat": 300}'::jsonb,
  '{
    "adapter": "hermes_local",
    "model": "anthropic/claude-sonnet-4.5",
    "temperature": 0.7,
    "max_tokens": 4096,
    "environment": {
      "OPENROUTER_API_KEY": "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"
    },
    "skills": ["operations-oversight", "workflow-governance", "approval-process-supervision", "operational-compliance-enforcement"]
  }'::jsonb,
  NOW(),
  NOW()
FROM companies c
WHERE c.name = 'MeasureForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'measureforge-ai-operations-director'
      AND a.company_id = c.id
  );

-- ============================================================
-- API KEY GENERATION FOR DIRECTORS
-- ============================================================

INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
)
SELECT
  gen_random_uuid(),
  a.id,
  a.company_id,
  a.name || ' API Key',
  'PLACEHOLDER_KEY_SET_MANUALLY',
  encode(sha256(('pcak_' || gen_random_uuid()::text)::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI')
  AND a.name IN ('measureforge-ai-measurement-director', 'measureforge-ai-procurement-director',
                 'measureforge-ai-integration-director', 'measureforge-ai-finance-director',
                 'measureforge-ai-operations-director')
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys ak WHERE ak.agent_id = a.id
  );

-- ============================================================
-- ACTIVITY LOG ENTRIES FOR DIRECTORS
-- ============================================================

INSERT INTO activity_log (
  id,
  company_id,
  agent_id,
  action,
  details,
  created_at
)
SELECT
  gen_random_uuid(),
  a.company_id,
  a.id,
  'agent_created',
  jsonb_build_object(
    'agent_name', a.name,
    'agent_title', a.title,
    'created_by', 'Nimbus - Supabase Database Specialist',
    'purpose', 'Director role for MeasureForge AI procurement operations'
  ),
  NOW()
FROM agents a
WHERE a.company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI')
  AND a.name IN ('measureforge-ai-measurement-director', 'measureforge-ai-procurement-director',
                 'measureforge-ai-integration-director', 'measureforge-ai-finance-director',
                 'measureforge-ai-operations-director');

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Count of created directors
-- SELECT COUNT(*) as director_count FROM agents
-- WHERE company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI')
--   AND name LIKE '%-director';

-- List all created directors with details
-- SELECT a.name, a.title, a.status, a.adapter_config->>'model' as model
-- FROM agents a
-- WHERE a.company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI')
--   AND name LIKE '%-director'
-- ORDER BY a.name;