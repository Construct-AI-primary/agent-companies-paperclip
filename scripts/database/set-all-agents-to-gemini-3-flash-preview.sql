-- ==========================================
-- Set ALL Agents to Use Google Gemini 3 Flash Preview
-- Created: 2026-04-23
-- Description: Bulk update ALL agents in the system to use google/gemini-3-flash-preview
--              in the agent_models table (model_id VARCHAR column)
-- ==========================================
--
-- TABLE SCHEMA REFERENCE:
-- - agent_models: id (UUID PK), agent_id (VARCHAR(100)), model_id (VARCHAR(255)),
--   assignment_type (VARCHAR(20), default 'primary'), priority, temperature, max_tokens,
--   is_active, company_id (UUID FK -> companies), created_at, updated_at
-- - agents: id (UUID PK), company_id (UUID FK), name (TEXT), role, title, status, ...
--
-- UNIQUE CONSTRAINT: agent_models_agent_id_assignment_type_key UNIQUE (agent_id, assignment_type)
--
-- STRATEGY:
-- 1. UPDATE all existing agent_models rows to set model_id = 'google/gemini-3-flash-preview'
-- 2. INSERT new 'primary' assignments for agents that have no entry in agent_models
-- ==========================================

-- Step 1: Show current model distribution before update
SELECT
    model_id,
    COUNT(*) as count,
    COUNT(CASE WHEN is_active THEN 1 END) as active_count
FROM agent_models
GROUP BY model_id
ORDER BY model_id;

-- Step 2: UPDATE all existing model assignments to google/gemini-3-flash-preview
UPDATE agent_models
SET
    model_id = 'google/gemini-3-flash-preview',
    reason = 'Bulk migration: All agents set to Google Gemini 3 Flash Preview',
    updated_at = NOW()
WHERE is_active = true;

-- Step 3: INSERT primary model assignments for agents without any agent_models entry
-- Uses agent name as agent_id (matching the VARCHAR(100) pattern)
-- Only includes non-deleted, active agents
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
)
SELECT
    a.name,
    'google/gemini-3-flash-preview',
    'primary',
    1,
    0.7,
    8192,
    'system',
    'Bulk migration: All agents set to Google Gemini 3 Flash Preview',
    true,
    a.company_id
FROM agents a
WHERE a.deleted_at IS NULL
  AND a.is_active = true
  AND a.name IS NOT NULL
  AND a.company_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM agent_models am
      WHERE am.agent_id = a.name
  )
ON CONFLICT (agent_id, assignment_type) DO NOTHING;

-- Step 4: Verification - Show new model distribution
SELECT
    model_id,
    COUNT(*) as count,
    COUNT(CASE WHEN is_active THEN 1 END) as active_count
FROM agent_models
GROUP BY model_id
ORDER BY model_id;

-- Step 5: Verification - Count agents using gemini-3-flash-preview
SELECT
    COUNT(DISTINCT agent_id) as agents_using_gemini,
    COUNT(*) as total_assignments
FROM agent_models
WHERE model_id = 'google/gemini-3-flash-preview'
  AND is_active = true;

-- Step 6: Verification - Find any agents still using other models
SELECT
    agent_id,
    model_id,
    assignment_type,
    is_active
FROM agent_models
WHERE model_id != 'google/gemini-3-flash-preview'
  AND is_active = true
ORDER BY agent_id;

-- Step 7: Verification - Find active agents with NO agent_models entry
SELECT
    a.name as agent_name,
    a.role,
    a.title,
    c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.deleted_at IS NULL
  AND a.is_active = true
  AND NOT EXISTS (
      SELECT 1
      FROM agent_models am
      WHERE am.agent_id = a.name
  )
ORDER BY a.name;

-- ==========================================
-- SUMMARY
-- ==========================================
-- After running, check:
-- - Step 4: All model_id values should be 'google/gemini-3-flash-preview'
-- - Step 5: Count should match your total active agent count
-- - Step 6: Should return 0 rows (no other models in use)
-- - Step 7: Should return 0 rows (all agents have model assignments)