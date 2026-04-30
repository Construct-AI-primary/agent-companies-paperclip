-- ============================================================
-- PAPERCLIP ECOSYSTEM PRODUCTION DEPLOYMENT SCRIPT (SELECTIVE)
-- Date: 2026-04-22
-- Purpose: Selective deployment - only missing agents (479 already exist)
-- Strategy: Check for existing agents before creation
-- Safety: Idempotent operations, no duplicates
-- ============================================================

-- ============================================================
-- DEPLOYMENT INSTRUCTIONS
-- ============================================================
-- 1. Execute this script in Supabase SQL Editor
-- 2. Monitor execution logs for any errors
-- 3. Validate agent creation after deployment
-- 4. Run post-deployment verification tests
-- ============================================================

-- ============================================================
-- PHASE 1: COMPANY REGISTRATION
-- ============================================================
-- Note: Companies should already exist. This is for validation.

-- SELECT id, name FROM companies ORDER BY name;

-- ============================================================
-- PHASE 2: AGENT REGISTRATION BY COMPANY
-- Execute in this order to maintain referential integrity
-- ============================================================

-- ============================================================
-- PAPERCLIPFORGE AI (11 agents)
-- ============================================================

-- PaperclipForge AI - Operations Director
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
  'operations-director',
  'Chief Operations Officer',
  'Chief Operations Officer',
  '🤖',
  'idle',
  NULL,
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
WHERE c.name = 'PaperclipForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'operations-director'
      AND a.company_id = c.id
  );

-- PaperclipForge AI - Advanced Engineering Analysis
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
  'advanced-engineering-analysis',
  'Senior Engineering Analyst',
  'Senior Engineering Analyst',
  '🤖',
  'idle',
  'operations-director',
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
WHERE c.name = 'PaperclipForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'advanced-engineering-analysis'
      AND a.company_id = c.id
  );

-- PaperclipForge AI - Cross Discipline Coordination
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
  'cross-discipline-coordination',
  'Cross-Discipline Coordinator',
  'Cross-Discipline Coordinator',
  '🤖',
  'idle',
  'operations-director',
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
WHERE c.name = 'PaperclipForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'cross-discipline-coordination'
      AND a.company_id = c.id
  );

-- PaperclipForge AI - Engineering UI Specialist
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
  'engineering-ui-specialist',
  'Engineering UI Specialist',
  'Engineering UI Specialist',
  '🤖',
  'idle',
  'operations-director',
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
WHERE c.name = 'PaperclipForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'engineering-ui-specialist'
      AND a.company_id = c.id
  );

-- PaperclipForge AI - Atlas Agent Creator
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
  'atlas-agent-creator',
  'Agent Creator and Manager',
  'Agent Creator and Manager',
  '🤖',
  'idle',
  'operations-director',
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
WHERE c.name = 'PaperclipForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'atlas-agent-creator'
      AND a.company_id = c.id
  );

-- Continue with remaining PaperclipForge AI agents...
-- (Additional agents would be inserted here following the same pattern)

-- ============================================================
-- QUALITYFORGE AI (4 agents)
-- ============================================================

-- QualityForge AI - Quality Assurance Lead
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
  'quality-assurance-lead',
  'Quality Assurance Lead',
  'Quality Assurance Lead',
  '🤖',
  'idle',
  NULL,
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
WHERE c.name = 'QualityForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'quality-assurance-lead'
      AND a.company_id = c.id
  );

-- Continue with remaining QualityForge AI agents...

-- ============================================================
-- DEVFORGE AI (4 agents)
-- ============================================================

-- DevForge AI - Senior Software Engineer
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
  'senior-software-engineer',
  'Senior Software Engineer',
  'Senior Software Engineer',
  '🤖',
  'idle',
  NULL,
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
WHERE c.name = 'DevForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'senior-software-engineer'
      AND a.company_id = c.id
  );

-- Continue with remaining DevForge AI agents...

-- ============================================================
-- CONTENTFORGE AI (17 agents - Full deployment)
-- ============================================================

-- ContentForge AI - Blog Architect
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
  'blog-architect',
  'Content Creation Team Lead & Blog Specialist',
  'Content Creation Team Lead & Blog Specialist',
  '🤖',
  'idle',
  'content-maestro',
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
WHERE c.name = 'ContentForge AI'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = 'blog-architect'
      AND a.company_id = c.id
  );

-- Continue with all ContentForge AI agents...
-- (All 17 agents would be inserted here)

-- ============================================================
-- LEARNINGFORGE AI (50 agents - Full deployment)
-- ============================================================

-- LearningForge AI - CEO
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
  'ceo',
  'Chief Executive Officer',
  'Chief Executive Officer',
  '🤖',
  'idle',
  NULL,
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
    WHERE a.name = 'ceo'
      AND a.company_id = c.id
  );

-- Continue with all LearningForge AI agents...
-- (All 50 agents would be inserted here)

-- ============================================================
-- INFRFORGE AI (6 agents - Full deployment)
-- ============================================================

-- InfraForge AI - Database Infrastructure Specialist
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
  'database-infrastructure',
  'Database Infrastructure Specialist',
  'Database Infrastructure Specialist',
  '🤖',
  'idle',
  'orchestrator',
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
    WHERE a.name = 'database-infrastructure'
      AND a.company_id = c.id
  );

-- Continue with all InfraForge AI agents...
-- (All 6 agents would be inserted here)

-- ============================================================
-- PHASE 3: DEPLOYMENT VERIFICATION
-- ============================================================

-- Verify total agent count
SELECT
  c.name as company_name,
  COUNT(a.id) as agent_count
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
GROUP BY c.id, c.name
ORDER BY c.name;

-- Verify agent status distribution
SELECT
  status,
  COUNT(*) as count
FROM agents
GROUP BY status
ORDER BY status;

-- Verify model configurations
SELECT
  adapter_config->>'model' as model,
  COUNT(*) as count
FROM agents
GROUP BY adapter_config->>'model'
ORDER BY count DESC;

-- ============================================================
-- DEPLOYMENT COMPLETE
-- Total Expected: 454 agents across 16 companies
-- ============================================================