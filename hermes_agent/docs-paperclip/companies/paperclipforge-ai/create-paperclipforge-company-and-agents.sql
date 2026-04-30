-- ============================================================
-- PaperclipForge AI Company and Agent Cleanup & Fix
-- Created: 2026-04-22
-- Description: Clean up Atlas-created agents and fix company assignments
-- Prerequisites: MeasureForge AI company must exist
-- ============================================================

-- Start transaction for atomicity
BEGIN;

-- ========================================
-- 1. CREATE PAPERCLIPFORGE AI COMPANY
-- ========================================

INSERT INTO companies (
  id,
  name,
  description,
  status,
  issue_prefix,
  budget_monthly_cents,
  require_board_approval_for_new_agents,
  brand_color,
  created_at,
  updated_at
) VALUES (
  '550e8400-e29b-41d4-a716-446655440014',
  'PaperclipForge AI',
  'Core orchestration company managing system-wide coordination, agent lifecycle, workflow automation, and cross-company integration. Responsible for enterprise-level project management, engineering analysis, and operational excellence across the Paperclip ecosystem.',
  'active',
  'PAPF',
  1500000,  -- $15,000 monthly budget
  true,     -- Require board approval for new agents
  '#8B5CF6', -- Purple brand color
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
) ON CONFLICT DO NOTHING;

-- ========================================
-- 2. CLEAN UP DUPLICATE AND MISASSIGNED AGENTS
-- ========================================

-- First, ensure all paperclipforge-ai agents are in the correct company
UPDATE agents
SET company_id = '550e8400-e29b-41d4-a716-446655440014',
    updated_at = NOW()
WHERE name LIKE 'paperclipforge-ai-%';

-- Move measurement agents back to MeasureForge AI (they should not be in PaperclipForge)
UPDATE agents
SET company_id = '550e8400-e29b-41d4-a716-446655440013',
    updated_at = NOW()
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND name LIKE 'paperclipforge-ai-measurement-%';

-- ========================================
-- 3. REMOVE DUPLICATE AGENTS
-- ========================================

-- Remove duplicate agents with incomplete data (Atlas created many with null capabilities)
DELETE FROM agent_api_keys
WHERE agent_id IN (
  SELECT a.id
  FROM agents a
  WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440014'
    AND a.capabilities IS NULL
    AND a.name LIKE 'paperclipforge-ai-%'
    AND a.id NOT IN (
      -- Keep agents with proper data
      SELECT id FROM agents
      WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
        AND capabilities IS NOT NULL
        AND name IN (
          'paperclipforge-ai-operations-director',
          'paperclipforge-ai-issue-importer',
          'paperclipforge-ai-task-allocator',
          'paperclipforge-ai-workflow-orchestrator',
          'paperclipforge-ai-agent-monitor',
          'paperclipforge-ai-system-integrator',
          'paperclipforge-ai-coordination-hub',
          'paperclipforge-ai-orchestration-engine',
          'paperclipforge-ai-atlas-agent-creator'
        )
    )
);

DELETE FROM agents
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND capabilities IS NULL
  AND name LIKE 'paperclipforge-ai-%'
  AND id NOT IN (
    -- Keep agents with proper data
    SELECT id FROM agents
    WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
      AND capabilities IS NOT NULL
      AND name IN (
        'paperclipforge-ai-operations-director',
        'paperclipforge-ai-issue-importer',
        'paperclipforge-ai-task-allocator',
        'paperclipforge-ai-workflow-orchestrator',
        'paperclipforge-ai-agent-monitor',
        'paperclipforge-ai-system-integrator',
        'paperclipforge-ai-coordination-hub',
        'paperclipforge-ai-orchestration-engine',
        'paperclipforge-ai-atlas-agent-creator'
      )
  );

-- ========================================
-- 3. CREATE OPERATIONS DIRECTOR (CEO)
-- ========================================

INSERT INTO agents (
  id,
  name,
  role,
  title,
  status,
  adapter_type,
  budget_monthly_cents,
  spent_monthly_cents,
  last_heartbeat_at,
  is_active,
  created_at,
  updated_at,
  capabilities,
  icon,
  adapter_config,
  runtime_config,
  permissions,
  metadata,
  company_id
) VALUES (
  gen_random_uuid(),
  'paperclipforge-ai-operations-director',
  'executive',
  'Chief Operations Officer',
  'idle',
  'http',
  750000,
  0,
  '2026-04-22T11:00:00.000Z',
  true,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z',
  'Operational leadership and execution oversight; Issue orchestration and workflow management; Operational performance monitoring and optimization; Team coordination and resource management; Operational risk management and mitigation.',
  '👔',
  '{"url":"https://hermes-agent-web-6eeu.onrender.com/","model":"z-ai/glm-4-flash","skills":["operations-management","issue-orchestration","workflow-optimization","performance-monitoring","team-leadership"],"max_tokens":8192,"temperature":0.7}',
  '{"heartbeat":{"enabled":false,"intervalSec":300,"wakeOnDemand":true,"wakeOnAssignment":true,"wakeOnAutomation":true,"maxConcurrentRuns":1},"error_handling":{"auto_retry":true,"escalation_enabled":true},"retry_attempts":3,"timeout_seconds":1800,"max_concurrent_tasks":5}',
  '{"access":{"admin_functions":true,"read_company_data":true,"write_company_data":true},"execute":{"allowed_domains":["docs-paperclip"],"automation_engine":"workflow_ops"},"orchestrate":{"company_projects":["paperclipforge-ai"],"max_parallel_workflows":10}}',
  '{"department":"executive","human_name":"Operations Director","created_via":"ATLAS-001","specialization":"operations-leadership"}',
  '550e8400-e29b-41d4-a716-446655440014'
);

-- ========================================
-- 4. CREATE MISSING CRITICAL AGENTS
-- ========================================

-- 4.1 Issue Importer
INSERT INTO agents (
  id,
  name,
  role,
  title,
  status,
  adapter_type,
  budget_monthly_cents,
  spent_monthly_cents,
  last_heartbeat_at,
  is_active,
  created_at,
  updated_at,
  capabilities,
  icon,
  adapter_config,
  runtime_config,
  permissions,
  metadata,
  company_id,
  reports_to
) VALUES (
  gen_random_uuid(),
  'paperclipforge-ai-issue-importer',
  'specialist',
  'Issue Batch Import Specialist',
  'idle',
  'http',
  250000,
  0,
  '2026-04-22T11:00:00.000Z',
  true,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z',
  'Automated issue batch import and processing; CSV parsing and validation; Issue deduplication; Priority assignment; Cross-company issue routing.',
  '📥',
  '{"url":"https://hermes-agent-web-6eeu.onrender.com/","model":"openrouter/qwen/qwen-3-6-plus","timeoutSec":300,"persistSession":true}',
  '{"heartbeat":{"enabled":false,"intervalSec":300,"wakeOnDemand":true,"wakeOnAssignment":true,"wakeOnAutomation":true,"maxConcurrentRuns":1},"persistSession":true}',
  '{"access":{"read_company_data":true,"write_company_data":true},"execute":{"allowed_domains":["docs-paperclip"],"automation_engine":"issue_import"}}',
  '{"team":"operations","specialization":"issue-import","created_via":"ATLAS-001","human_name":"Issue Import Specialist"}',
  '550e8400-e29b-41d4-a716-446655440014',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director' LIMIT 1)
);

-- 4.1 Issue Importer
INSERT INTO agents (
  id,
  name,
  role,
  title,
  status,
  adapter_type,
  budget_monthly_cents,
  spent_monthly_cents,
  last_heartbeat_at,
  is_active,
  created_at,
  updated_at,
  capabilities,
  icon,
  adapter_config,
  runtime_config,
  permissions,
  metadata,
  company_id,
  reports_to
) VALUES (
  gen_random_uuid(),
  'paperclipforge-ai-task-allocator',
  'specialist',
  'Task Distribution Specialist',
  'idle',
  'http',
  300000,
  0,
  '2026-04-22T11:00:00.000Z',
  true,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z',
  'Intelligent task distribution and assignment; Workload balancing; Skill-based routing; Priority queue management; Resource optimization.',
  '🎯',
  '{"url":"https://hermes-agent-web-6eeu.onrender.com/","model":"openrouter/qwen/qwen-3-6-plus","timeoutSec":300,"persistSession":true}',
  '{"heartbeat":{"enabled":false,"intervalSec":300,"wakeOnDemand":true,"wakeOnAssignment":true,"wakeOnAutomation":true,"maxConcurrentRuns":1},"persistSession":true}',
  '{"access":{"read_company_data":true,"write_company_data":true},"execute":{"allowed_domains":["docs-paperclip"],"automation_engine":"task_allocation"}}',
  '{"team":"operations","specialization":"task-allocation","created_via":"ATLAS-001","human_name":"Task Allocation Specialist"}',
  '550e8400-e29b-41d4-a716-446655440014',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director' LIMIT 1)
);

-- 4.3 Workflow Orchestrator
INSERT INTO agents (
  id,
  name,
  role,
  title,
  status,
  adapter_type,
  budget_monthly_cents,
  spent_monthly_cents,
  last_heartbeat_at,
  is_active,
  created_at,
  updated_at,
  capabilities,
  icon,
  adapter_config,
  runtime_config,
  permissions,
  metadata,
  company_id,
  reports_to
) VALUES (
  gen_random_uuid(),
  'paperclipforge-ai-workflow-orchestrator',
  'specialist',
  'Cross-Company Workflow Coordinator',
  'idle',
  'http',
  400000,
  0,
  '2026-04-22T11:00:00.000Z',
  true,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z',
  'Cross-company workflow coordination and orchestration; Dependency management; Timeline optimization; Milestone tracking; Progress reporting.',
  '🔄',
  '{"url":"https://hermes-agent-web-6eeu.onrender.com/","model":"openrouter/qwen/qwen-3-6-plus","timeoutSec":300,"persistSession":true}',
  '{"heartbeat":{"enabled":false,"intervalSec":300,"wakeOnDemand":true,"wakeOnAssignment":true,"wakeOnAutomation":true,"maxConcurrentRuns":1},"persistSession":true}',
  '{"access":{"read_company_data":true,"write_company_data":true},"execute":{"allowed_domains":["docs-paperclip"],"automation_engine":"workflow_orchestration"},"orchestrate":{"max_parallel_workflows":5}}',
  '{"team":"operations","specialization":"workflow-orchestration","created_via":"ATLAS-001","human_name":"Workflow Orchestrator"}',
  '550e8400-e29b-41d4-a716-446655440014',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director' LIMIT 1)
);

-- 4.4 Agent Monitor
INSERT INTO agents (
  id,
  name,
  role,
  title,
  status,
  adapter_type,
  budget_monthly_cents,
  spent_monthly_cents,
  last_heartbeat_at,
  is_active,
  created_at,
  updated_at,
  capabilities,
  icon,
  adapter_config,
  runtime_config,
  permissions,
  metadata,
  company_id,
  reports_to
) VALUES (
  gen_random_uuid(),
  'paperclipforge-ai-agent-monitor',
  'specialist',
  'Agent Health & Performance Monitor',
  'idle',
  'http',
  350000,
  0,
  '2026-04-22T11:00:00.000Z',
  true,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z',
  'Agent health monitoring and performance tracking; System availability checks; Performance metrics collection; Alert generation; Capacity planning.',
  '📊',
  '{"url":"https://hermes-agent-web-6eeu.onrender.com/","model":"openrouter/qwen/qwen-3-6-plus","timeoutSec":300,"persistSession":true}',
  '{"heartbeat":{"enabled":false,"intervalSec":300,"wakeOnDemand":true,"wakeOnAssignment":true,"wakeOnAutomation":true,"maxConcurrentRuns":1},"persistSession":true}',
  '{"access":{"read_company_data":true,"write_company_data":false},"execute":{"allowed_domains":["docs-paperclip"],"automation_engine":"monitoring"}}',
  '{"team":"operations","specialization":"agent-monitoring","created_via":"ATLAS-001","human_name":"Agent Monitor"}',
  '550e8400-e29b-41d4-a716-446655440014',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director' LIMIT 1)
);

-- 4.5 System Integrator
INSERT INTO agents (
  id,
  name,
  role,
  title,
  status,
  adapter_type,
  budget_monthly_cents,
  spent_monthly_cents,
  last_heartbeat_at,
  is_active,
  created_at,
  updated_at,
  capabilities,
  icon,
  adapter_config,
  runtime_config,
  permissions,
  metadata,
  company_id,
  reports_to
) VALUES (
  gen_random_uuid(),
  'paperclipforge-ai-system-integrator',
  'specialist',
  'System Integration Manager',
  'idle',
  'http',
  400000,
  0,
  '2026-04-22T11:00:00.000Z',
  true,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z',
  'System-wide integration management and coordination; API connectivity validation; Data flow optimization; Integration testing; Service dependency mapping.',
  '🔗',
  '{"url":"https://hermes-agent-web-6eeu.onrender.com/","model":"openrouter/qwen/qwen-3-6-plus","timeoutSec":300,"persistSession":true}',
  '{"heartbeat":{"enabled":false,"intervalSec":300,"wakeOnDemand":true,"wakeOnAssignment":true,"wakeOnAutomation":true,"maxConcurrentRuns":1},"persistSession":true}',
  '{"access":{"read_company_data":true,"write_company_data":true},"execute":{"allowed_domains":["docs-paperclip"],"automation_engine":"system_integration"}}',
  '{"team":"operations","specialization":"system-integration","created_via":"ATLAS-001","human_name":"System Integrator"}',
  '550e8400-e29b-41d4-a716-446655440014',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director' LIMIT 1)
);

-- 4.6 Coordination Hub
INSERT INTO agents (
  id,
  name,
  role,
  title,
  status,
  adapter_type,
  budget_monthly_cents,
  spent_monthly_cents,
  last_heartbeat_at,
  is_active,
  created_at,
  updated_at,
  capabilities,
  icon,
  adapter_config,
  runtime_config,
  permissions,
  metadata,
  company_id,
  reports_to
) VALUES (
  gen_random_uuid(),
  'paperclipforge-ai-coordination-hub',
  'specialist',
  'Central Coordination Hub',
  'idle',
  'http',
  350000,
  0,
  '2026-04-22T11:00:00.000Z',
  true,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z',
  'Central communication and coordination hub; Message routing; Stakeholder notifications; Status broadcasting; Coordination workflow management.',
  '📡',
  '{"url":"https://hermes-agent-web-6eeu.onrender.com/","model":"openrouter/qwen/qwen-3-6-plus","timeoutSec":300,"persistSession":true}',
  '{"heartbeat":{"enabled":false,"intervalSec":300,"wakeOnDemand":true,"wakeOnAssignment":true,"wakeOnAutomation":true,"maxConcurrentRuns":1},"persistSession":true}',
  '{"access":{"read_company_data":true,"write_company_data":true},"execute":{"allowed_domains":["docs-paperclip"],"automation_engine":"coordination"}}',
  '{"team":"operations","specialization":"coordination-hub","created_via":"ATLAS-001","human_name":"Coordination Hub"}',
  '550e8400-e29b-41d4-a716-446655440014',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director' LIMIT 1)
);

-- 4.7 Orchestration Engine
INSERT INTO agents (
  id,
  name,
  role,
  title,
  status,
  adapter_type,
  budget_monthly_cents,
  spent_monthly_cents,
  last_heartbeat_at,
  is_active,
  created_at,
  updated_at,
  capabilities,
  icon,
  adapter_config,
  runtime_config,
  permissions,
  metadata,
  company_id,
  reports_to
) VALUES (
  gen_random_uuid(),
  'paperclipforge-ai-orchestration-engine',
  'specialist',
  'Core Orchestration Engine',
  'idle',
  'http',
  500000,
  0,
  '2026-04-22T11:00:00.000Z',
  true,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z',
  'Core orchestration engine for complex multi-agent workflows; Process automation; Decision engine; Rule-based execution; Exception handling.',
  '⚙️',
  '{"url":"https://hermes-agent-web-6eeu.onrender.com/","model":"openrouter/qwen/qwen-3-6-plus","timeoutSec":300,"persistSession":true}',
  '{"heartbeat":{"enabled":false,"intervalSec":300,"wakeOnDemand":true,"wakeOnAssignment":true,"wakeOnAutomation":true,"maxConcurrentRuns":1},"persistSession":true}',
  '{"access":{"admin_functions":true,"read_company_data":true,"write_company_data":true},"execute":{"allowed_domains":["docs-paperclip"],"automation_engine":"orchestration"},"orchestrate":{"max_parallel_workflows":10}}',
  '{"team":"operations","specialization":"orchestration-engine","created_via":"ATLAS-001","human_name":"Orchestration Engine"}',
  '550e8400-e29b-41d4-a716-446655440014',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director' LIMIT 1)
);

-- ========================================
-- 5. UPDATE EXISTING AGENTS TO REPORT TO OPERATIONS DIRECTOR
-- ========================================

UPDATE agents
SET reports_to = (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director' LIMIT 1),
    updated_at = NOW()
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND name LIKE 'paperclipforge-ai-%'
  AND name != 'paperclipforge-ai-operations-director'
  AND reports_to IS NULL;

-- ========================================
-- 6. CREATE API KEYS FOR NEW AGENTS
-- ========================================

-- Generate API keys for the new agents
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, key_hash, created_at)
SELECT
  gen_random_uuid(),
  a.id,
  a.company_id,
  CONCAT(a.name, ' API Key'),
  CONCAT('pcak_', encode(gen_random_bytes(16), 'hex')),
  encode(gen_random_bytes(32), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND a.name IN (
    'paperclipforge-ai-issue-importer',
    'paperclipforge-ai-task-allocator',
    'paperclipforge-ai-workflow-orchestrator',
    'paperclipforge-ai-agent-monitor',
    'paperclipforge-ai-system-integrator',
    'paperclipforge-ai-coordination-hub',
    'paperclipforge-ai-orchestration-engine'
  )
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak WHERE aak.agent_id = a.id
  );

-- ========================================
-- 7. VERIFICATION QUERIES
-- ========================================

-- Check company creation
-- SELECT id, name, description, status, issue_prefix FROM companies WHERE name = 'PaperclipForge AI';

-- Check agent count by company
-- SELECT
--   c.name as company_name,
--   COUNT(a.id) as agent_count
-- FROM companies c
-- LEFT JOIN agents a ON c.id = a.company_id
-- WHERE c.name IN ('MeasureForge AI', 'PaperclipForge AI')
-- GROUP BY c.name;

-- Check new agents
-- SELECT name, role, title, status
-- FROM agents
-- WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
-- ORDER BY name;

-- Commit transaction
COMMIT;

-- ============================================================
-- POST-DEPLOYMENT VERIFICATION
-- ============================================================

-- Run these queries after deployment to verify:

-- 1. Company exists
-- SELECT * FROM companies WHERE name = 'PaperclipForge AI';

-- 2. All agents are in correct companies
-- SELECT
--   c.name as company,
--   a.name as agent,
--   a.role,
--   a.status
-- FROM companies c
-- JOIN agents a ON c.id = a.company_id
-- WHERE c.name IN ('MeasureForge AI', 'PaperclipForge AI')
-- ORDER BY c.name, a.name;

-- 3. Agent hierarchy is correct
-- SELECT
--   a.name as agent,
--   reporter.name as reports_to
-- FROM agents a
-- LEFT JOIN agents reporter ON a.reports_to = reporter.id
-- WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440014'
-- ORDER BY a.name;

-- 4. API keys exist
-- SELECT
--   a.name,
--   CASE WHEN aak.agent_id IS NOT NULL THEN 'Has API Key' ELSE 'Missing API Key' END as api_key_status
-- FROM agents a
-- LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
-- WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440014'
-- ORDER BY a.name;