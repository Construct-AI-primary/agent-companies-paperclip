-- ============================================================
-- Agent Registration: orchestrator-infraforge-ceo
-- Company: InfraForge AI
-- Date: 2026-04-21
-- Purpose: Register the orchestrator-infraforge-ceo agent
-- ============================================================

-- Step 1: Get InfraForge AI company ID
-- SELECT id, name FROM companies WHERE name LIKE '%InfraForge%';

-- ============================================================
-- IMPORTANT: Schema constraints for this table:
-- - agents table has NO unique constraint on 'name'
-- - Model config is stored in adapter_config JSONB field
-- - There is NO agent_models table in this schema
-- ============================================================

-- ============================================================
-- AGENT REGISTRATION (Idempotent - uses NOT EXISTS check)
-- ============================================================
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
  adapter_config,
  created_at,
  updated_at
)
SELECT
  gen_random_uuid(),
  c.id,
  'orchestrator-infraforge-ceo',
  'Agent',
  'Agent',
  '🤖',
  'idle',
  'null',
  '["task_execution", "communication", "analysis"]',
  '{
    "adapter": "hermes_local",
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.7,
    "max_tokens": 4096
  }'::jsonb,
  NOW(),
  NOW()
FROM companies c
WHERE c.name = 'InfraForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'orchestrator-infraforge-ceo'
      AND a.company_id = c.id
  );

-- ============================================================
-- VERIFICATION QUERY
-- ============================================================
-- SELECT id, name, role, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'orchestrator-infraforge-ceo';
