-- ============================================================
-- Agent Registration: Audit By Path Agent
-- Company: LearningForge AI
-- Date: 2026-04-21
-- Purpose: Register the Audit By Path Agent agent
-- ============================================================

-- Step 1: Get LearningForge AI company ID
-- SELECT id, name FROM companies WHERE name LIKE '%LearningForge%';

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
  'Audit By Path Agent',
  'specialist',
  'Audit Trail Indexing Specialist',
  '🤖',
  'idle',
  'learningforge-ai-knowledge-flow-division-lead',
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
WHERE c.name = 'LearningForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'Audit By Path Agent'
      AND a.company_id = c.id
  );

-- ============================================================
-- VERIFICATION QUERY
-- ============================================================
-- SELECT id, name, role, status, adapter_config->>'model' as model
-- FROM agents WHERE name = 'Audit By Path Agent';
