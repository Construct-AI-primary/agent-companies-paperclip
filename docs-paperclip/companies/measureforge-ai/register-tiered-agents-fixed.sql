-- ============================================================
-- MeasureForge AI Tiered Architecture Agents Registration
-- Created: 2026-04-22
-- Description: Registers 10 agents in the new 3-tier architecture (3 Strategic + 7 Tactical)
-- Prerequisites: MeasureForge AI company must exist, all old agents deleted
-- Follows: Measurement Platform Scalability Architecture Plan
-- ============================================================

-- Check if MeasureForge AI company exists before proceeding
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM companies WHERE name = 'MeasureForge AI') THEN
        RAISE EXCEPTION 'ERROR: MeasureForge AI company does not exist. Please run register-company.sql first.';
    END IF;
END $$;

-- ============================================================
-- STRATEGIC TIER (Company-Level Orchestration)
-- ============================================================

-- Chief Measurement Orchestrator - "The MeasureMaster"
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  budget_monthly_cents,
  created_at,
  updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'the-measuremaster',
  'director',
  'Chief Measurement Orchestrator',
  'idle',
  'Strategic measurement platform orchestrator with expertise in workflow prioritization, resource allocation, quality oversight, and cross-discipline coordination. The MeasureMaster ensures strategic alignment and optimal platform performance.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 8192,
    "skills": ["strategic-planning", "multi-discipline-coordination", "performance-monitoring", "resource-allocation"],
    "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 10,
    "timeout_seconds": 3600,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 20, "burst_limit": 50},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["strategic-orchestration", "platform-management", "quality-oversight"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai", "knowledgeforge-ai", "qualityforge-ai"], "max_parallel_workflows": 15},
    "access": {"read_company_data": true, "write_company_data": true, "admin_functions": true}
  }'::jsonb,
  100000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'the-measuremaster');

-- Measurement Standards Director - "Reggie the Regulator"
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  budget_monthly_cents,
  created_at,
  updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'reggie-the-regulator',
  'director',
  'Measurement Standards Director',
  'idle',
  'Regulatory compliance and standards oversight specialist. Reggie ensures multi-jurisdictional compliance, standards interpretation, regulatory updates, and audit coordination across all measurement disciplines.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": ["regulatory-oversight", "standards-enforcement", "compliance-monitoring", "audit-coordination"],
    "endpoints": {"primary": "hermes_local", "fallback": "hunyuan-turbo"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 8,
    "timeout_seconds": 2400,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 15, "burst_limit": 30},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["standards-enforcement", "compliance-monitoring", "regulatory-updates"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "knowledgeforge-ai"], "max_parallel_workflows": 10},
    "access": {"read_company_data": true, "write_company_data": true, "admin_functions": true}
  }'::jsonb,
  85000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'reggie-the-regulator');

-- Quality Assurance Coordinator - "Quincy the Quality Queen"
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  budget_monthly_cents,
  created_at,
  updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'quincy-the-quality-queen',
  'coordinator',
  'Quality Assurance Coordinator',
  'idle',
  'Platform-wide quality management and assurance specialist. Quincy oversees QA frameworks, performance analytics, improvement initiatives, and ensures consistent quality standards across all measurement operations.',
  'hermes_local',
  '{
    "model": "ernie-4.0-turbo",
    "temperature": 0.2,
    "max_tokens": 6144,
    "skills": ["quality-management", "performance-analytics", "process-optimization", "improvement-initiatives"],
    "endpoints": {"primary": "hermes_local", "fallback": "spark-max"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 12,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 25, "burst_limit": 50},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["quality-management", "performance-analytics", "process-optimization"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "qualityforge-ai", "learningforge-ai"], "max_parallel_workflows": 20},
    "access": {"read_company_data": true, "write_company_data": true, "admin_functions": false}
  }'::jsonb,
  75000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'quincy-the-quality-queen');

-- ============================================================
-- TACTICAL TIER (Discipline-Level Coordination)
-- ============================================================

-- Quantity Surveying Coordinator - "Quantina the Calculator"
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  budget_monthly_cents,
  created_at,
  updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'quantina-the-calculator',
  'coordinator',
  'Quantity Surveying Coordinator',
  'idle',
  'Quantity surveying discipline coordinator managing cost planning, procurement workflows, contract administration, and material cost analysis. Quantina ensures accurate quantity takeoffs and cost estimations.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": ["cost-planning", "procurement-coordination", "contract-administration", "material-analysis"],
    "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 8,
    "timeout_seconds": 2400,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 15, "burst_limit": 30},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["quantity-surveying", "cost-planning", "procurement-workflows"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai"], "max_parallel_workflows": 12},
    "access": {"read_company_data": true, "write_company_data": true, "admin_functions": false}
  }'::jsonb,
  65000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'quantina-the-calculator');

-- Earthwork & Terrain Coordinator - "Terra the Terrain Titan"
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  budget_monthly_cents,
  created_at,
  updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'terra-the-terrain-titan',
  'coordinator',
  'Earthwork & Terrain Coordinator',
  'idle',
  'Earthwork and terrain analysis coordinator managing volume calculations, terrain modeling, contour analysis, and survey management. Terra specializes in complex earthwork calculations and terrain optimization.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 8192,
    "skills": ["volume-calculations", "terrain-modeling", "contour-analysis", "survey-management"],
    "endpoints": {"primary": "hermes_local", "fallback": "hunyuan-turbo"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 6,
    "timeout_seconds": 3600,
    "retry_attempts": 2,
    "rate_limiting": {"requests_per_minute": 12, "burst_limit": 25},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["earthwork-analysis", "terrain-modeling", "volume-calculations"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai"], "max_parallel_workflows": 8},
    "access": {"read_company_data": true, "write_company_data": true, "admin_functions": false}
  }'::jsonb,
  70000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'terra-the-terrain-titan');

-- Civil Engineering Coordinator - "Cindy the Concrete Queen"
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  budget_monthly_cents,
  created_at,
  updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'cindy-the-concrete-queen',
  'coordinator',
  'Civil Engineering Coordinator',
  'idle',
  'Civil engineering discipline coordinator managing structural, concrete, foundation, and construction measurements. Cindy ensures compliance with civil engineering standards and material analysis.',
  'hermes_local',
  '{
    "model": "ernie-4.0-turbo",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": ["civil-engineering-coordination", "material-analysis", "construction-standards", "structural-measurements"],
    "endpoints": {"primary": "hermes_local", "fallback": "spark-max"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 8,
    "timeout_seconds": 2400,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 15, "burst_limit": 30},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["civil-engineering", "structural-measurements", "material-analysis"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai"], "max_parallel_workflows": 10},
    "access": {"read_company_data": true, "write_company_data": true, "admin_functions": false}
  }'::jsonb,
  65000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'cindy-the-concrete-queen');

-- Electrical Coordinator - "Sparky the Electrical Wizard"
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  budget_monthly_cents,
  created_at,
  updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'sparky-the-electrical-wizard',
  'coordinator',
  'Electrical Coordinator',
  'idle',
  'Electrical systems discipline coordinator managing power systems, safety compliance, equipment validation, and electrical standards. Sparky ensures electrical measurement accuracy and regulatory compliance.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": ["electrical-coordination", "safety-management", "compliance-oversight", "power-systems"],
    "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 7,
    "timeout_seconds": 2400,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 14, "burst_limit": 28},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["electrical-measurements", "safety-compliance", "equipment-validation"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai"], "max_parallel_workflows": 9},
    "access": {"read_company_data": true, "write_company_data": true, "admin_functions": false}
  }'::jsonb,
  68000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'sparky-the-electrical-wizard');

-- Traffic & Transportation Coordinator - "Traffic Tina the Transit Guru"
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  budget_monthly_cents,
  created_at,
  updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'traffic-tina-the-transit-guru',
  'coordinator',
  'Traffic & Transportation Coordinator',
  'idle',
  'Traffic and transportation systems coordinator managing signal systems, intersection coordination, transportation standards, and regulatory compliance. Tina specializes in intelligent transportation systems and traffic flow optimization.',
  'hermes_local',
  '{
    "model": "ernie-4.0-turbo",
    "temperature": 0.2,
    "max_tokens": 6144,
    "skills": ["transportation-coordination", "signal-management", "regulatory-compliance", "traffic-systems"],
    "endpoints": {"primary": "hermes_local", "fallback": "spark-max"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 6,
    "timeout_seconds": 2400,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 12, "burst_limit": 24},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["traffic-systems", "signal-management", "transportation-standards"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai"], "max_parallel_workflows": 8},
    "access": {"read_company_data": true, "write_company_data": true, "admin_functions": false}
  }'::jsonb,
  62000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'traffic-tina-the-transit-guru');

-- CAD Integration Coordinator - "Caddy the CAD Commander"
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  budget_monthly_cents,
  created_at,
  updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'caddy-the-cad-commander',
  'coordinator',
  'CAD Integration Coordinator',
  'idle',
  'CAD systems integration coordinator managing multi-CAD platforms, data synchronization, drawing management, and version control. Caddy ensures seamless CAD integration across all measurement workflows.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": ["cad-orchestration", "data-integration", "version-control", "multi-cad-systems"],
    "endpoints": {"primary": "hermes_local", "fallback": "hunyuan-turbo"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 10,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 20, "burst_limit": 40},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["cad-integration", "data-synchronization", "drawing-management"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai"], "max_parallel_workflows": 15},
    "access": {"read_company_data": true, "write_company_data": true, "admin_functions": false}
  }'::jsonb,
  60000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'caddy-the-cad-commander');

-- Quality Control Coordinator - "Quill the Quality Inspector"
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  budget_monthly_cents,
  created_at,
  updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'quill-the-quality-inspector',
  'coordinator',
  'Quality Control Coordinator',
  'idle',
  'Quality control and validation coordinator managing measurement validation, auditing, discrepancy resolution, and quality assurance frameworks. Quill ensures measurement accuracy and compliance across all disciplines.',
  'hermes_local',
  '{
    "model": "ernie-4.0-turbo",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": ["quality-coordination", "audit-management", "validation-frameworks", "discrepancy-resolution"],
    "endpoints": {"primary": "hermes_local", "fallback": "spark-max"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 12,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 25, "burst_limit": 50},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["quality-control", "validation-auditing", "discrepancy-resolution"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "qualityforge-ai"], "max_parallel_workflows": 18},
    "access": {"read_company_data": true, "write_company_data": true, "admin_functions": false}
  }'::jsonb,
  58000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'quill-the-quality-inspector');

-- Log successful registration
DO $$
DECLARE
    inserted_count INTEGER;
BEGIN
    GET DIAGNOSTICS inserted_count = ROW_COUNT;
    RAISE NOTICE 'Successfully registered % tiered architecture agents for MeasureForge AI', inserted_count;
END $$;