-- ============================================================
-- MeasureForge AI Agents Registration - Part 1
-- Created: 2026-04-22
-- Description: Registers the first 10 MeasureForge AI agents (Core + Document/Data Processing)
-- Prerequisites: MeasureForge AI company must exist (run register-company.sql first)
-- ============================================================

-- Check if MeasureForge AI company exists before proceeding
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM companies WHERE name = 'MeasureForge AI') THEN
        RAISE EXCEPTION 'ERROR: MeasureForge AI company does not exist. Please run register-company.sql first.';
    END IF;
END $$;

-- ============================================================
-- Core Measurement Agents (6)
-- ============================================================

-- Measurement Validation Specialist
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
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'measurement-validation-specialist',
  'specialist',
  'Measurement Validation Specialist',
  'idle',
  'Measurement validation specialist ensuring accuracy, compliance, and quality of measurements across civil, electrical, mechanical, and structural engineering disciplines. Expert in automated validation, tolerance checking, standards compliance, and error detection.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": ["measurement-validation", "standards-compliance", "quality-assurance"],
    "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 5,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 10, "burst_limit": 20},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["measurement-validation", "standards-compliance", "quality-assurance", "cad-validation"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai", "knowledgeforge-ai"], "max_parallel_workflows": 3},
    "access": {"read_company_data": true, "write_company_data": false, "admin_functions": false}
  }'::jsonb,
  60000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  status = EXCLUDED.status,
  capabilities = EXCLUDED.capabilities,
  adapter_type = EXCLUDED.adapter_type,
  adapter_config = EXCLUDED.adapter_config,
  runtime_config = EXCLUDED.runtime_config,
  permissions = EXCLUDED.permissions,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  updated_at = EXCLUDED.updated_at;

-- Measurement Standards Specialist
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
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'measurement-standards-specialist',
  'specialist',
  'Measurement Standards Specialist',
  'idle',
  'Regulatory compliance and standards interpretation specialist. Expert in multi-jurisdictional compliance, standards interpretation, audit preparation, and regulatory updates.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": ["standards-management", "compliance-validation", "regulatory-knowledge"],
    "endpoints": {"primary": "hermes_local", "fallback": "hunyuan-turbo"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 5,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 10, "burst_limit": 20},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["standards-management", "compliance-validation", "regulatory-updates"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "knowledgeforge-ai"], "max_parallel_workflows": 2},
    "access": {"read_company_data": true, "write_company_data": false, "admin_functions": false}
  }'::jsonb,
  55000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  status = EXCLUDED.status,
  capabilities = EXCLUDED.capabilities,
  adapter_type = EXCLUDED.adapter_type,
  adapter_config = EXCLUDED.adapter_config,
  runtime_config = EXCLUDED.runtime_config,
  permissions = EXCLUDED.permissions,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  updated_at = EXCLUDED.updated_at;

-- Measurement Coordination Specialist
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
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'measurement-coordination-specialist',
  'specialist',
  'Measurement Coordination Specialist',
  'idle',
  'Workflow orchestration and stakeholder coordination specialist. Expert in interdisciplinary communication, technical translation, conflict mediation, and integration planning.',
  'hermes_local',
  '{
    "model": "ernie-4.0-turbo",
    "temperature": 0.2,
    "max_tokens": 6144,
    "skills": ["project-coordination", "workflow-management", "stakeholder-engagement"],
    "endpoints": {"primary": "hermes_local", "fallback": "spark-max"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 8,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 15, "burst_limit": 30},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["project-coordination", "workflow-management", "stakeholder-coordination"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai", "knowledgeforge-ai"], "max_parallel_workflows": 5},
    "access": {"read_company_data": true, "write_company_data": true, "admin_functions": false}
  }'::jsonb,
  65000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  status = EXCLUDED.status,
  capabilities = EXCLUDED.capabilities,
  adapter_type = EXCLUDED.adapter_type,
  adapter_config = EXCLUDED.adapter_config,
  runtime_config = EXCLUDED.runtime_config,
  permissions = EXCLUDED.permissions,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  updated_at = EXCLUDED.updated_at;

-- Advanced Engineering Analysis Specialist
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
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'advanced-engineering-analysis',
  'specialist',
  'Advanced Engineering Analysis Specialist',
  'idle',
  'Advanced engineering analysis specialist with expertise in structural analysis, FEA simulation, thermal analysis, and fluid dynamics.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 8192,
    "skills": ["engineering-analysis", "simulation-modeling", "technical-computation"],
    "endpoints": {"primary": "hermes_local", "fallback": "hunyuan-turbo"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 3,
    "timeout_seconds": 3600,
    "retry_attempts": 2,
    "rate_limiting": {"requests_per_minute": 5, "burst_limit": 10},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["engineering-analysis", "simulation-modeling", "fea-analysis"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai"], "max_parallel_workflows": 2},
    "access": {"read_company_data": true, "write_company_data": false, "admin_functions": false}
  }'::jsonb,
  75000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  status = EXCLUDED.status,
  capabilities = EXCLUDED.capabilities,
  adapter_type = EXCLUDED.adapter_type,
  adapter_config = EXCLUDED.adapter_config,
  runtime_config = EXCLUDED.runtime_config,
  permissions = EXCLUDED.permissions,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  updated_at = EXCLUDED.updated_at;

-- Cross-Discipline Coordination Specialist
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
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'cross-discipline-coordination',
  'specialist',
  'Cross-Discipline Coordination Specialist',
  'idle',
  'Cross-discipline coordination specialist facilitating interdisciplinary communication, technical translation, conflict mediation, and integration planning.',
  'hermes_local',
  '{
    "model": "ernie-4.0-turbo",
    "temperature": 0.2,
    "max_tokens": 6144,
    "skills": ["interdisciplinary-coordination", "technical-translation", "conflict-resolution"],
    "endpoints": {"primary": "hermes_local", "fallback": "qwen-max"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 6,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 12, "burst_limit": 25},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["interdisciplinary-coordination", "technical-translation", "conflict-mediation"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai", "knowledgeforge-ai"], "max_parallel_workflows": 4},
    "access": {"read_company_data": true, "write_company_data": true, "admin_functions": false}
  }'::jsonb,
  60000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  status = EXCLUDED.status,
  capabilities = EXCLUDED.capabilities,
  adapter_type = EXCLUDED.adapter_type,
  adapter_config = EXCLUDED.adapter_config,
  runtime_config = EXCLUDED.runtime_config,
  permissions = EXCLUDED.permissions,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  updated_at = EXCLUDED.updated_at;

-- Engineering UI Specialist
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
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'engineering-ui-specialist',
  'specialist',
  'Engineering UI Specialist',
  'idle',
  'Engineering user interface specialist focused on interface design, user experience, accessibility compliance, and responsive layout for technical applications.',
  'hermes_local',
  '{
    "model": "spark-max",
    "temperature": 0.3,
    "max_tokens": 6144,
    "skills": ["ui-ux-design", "accessibility", "user-experience"],
    "endpoints": {"primary": "hermes_local", "fallback": "hunyuan-turbo"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 4,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 8, "burst_limit": 15},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["ui-ux-design", "accessibility", "user-experience"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai"], "max_parallel_workflows": 3},
    "access": {"read_company_data": true, "write_company_data": false, "admin_functions": false}
  }'::jsonb,
  55000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  status = EXCLUDED.status,
  capabilities = EXCLUDED.capabilities,
  adapter_type = EXCLUDED.adapter_type,
  adapter_config = EXCLUDED.adapter_config,
  runtime_config = EXCLUDED.runtime_config,
  permissions = EXCLUDED.permissions,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  updated_at = EXCLUDED.updated_at;

-- ============================================================
-- Document & Data Processing Agents (4)
-- ============================================================

-- Document Intelligence Specialist
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
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'document-intelligence-specialist',
  'specialist',
  'Document Intelligence Specialist',
  'idle',
  'Document intelligence specialist for analysis, specification extraction, cross-document correlation, knowledge synthesis, and compliance matrix generation.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 8192,
    "skills": ["document-processing", "information-extraction", "knowledge-synthesis"],
    "endpoints": {"primary": "hermes_local", "fallback": "hunyuan-turbo"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 4,
    "timeout_seconds": 2400,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 8, "burst_limit": 15},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["document-processing", "information-extraction", "knowledge-synthesis"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "knowledgeforge-ai"], "max_parallel_workflows": 3},
    "access": {"read_company_data": true, "write_company_data": false, "admin_functions": false}
  }'::jsonb,
  60000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  status = EXCLUDED.status,
  capabilities = EXCLUDED.capabilities,
  adapter_type = EXCLUDED.adapter_type,
  adapter_config = EXCLUDED.adapter_config,
  runtime_config = EXCLUDED.runtime_config,
  permissions = EXCLUDED.permissions,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  updated_at = EXCLUDED.updated_at;

-- Data Processing Specialist
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
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'data-processing-specialist',
  'specialist',
  'Data Processing Specialist',
  'idle',
  'Data processing specialist for document ecosystem processing, multi-format file handling, data normalization, information extraction, and knowledge graph construction.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": ["data-processing", "file-format-handling", "data-normalization"],
    "endpoints": {"primary": "hermes_local", "fallback": "hunyuan-turbo"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 6,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 12, "burst_limit": 25},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["data-processing", "file-format-handling", "data-normalization"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai"], "max_parallel_workflows": 4},
    "access": {"read_company_data": true, "write_company_data": true, "admin_functions": false}
  }'::jsonb,
  55000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  status = EXCLUDED.status,
  capabilities = EXCLUDED.capabilities,
  adapter_type = EXCLUDED.adapter_type,
  adapter_config = EXCLUDED.adapter_config,
  runtime_config = EXCLUDED.runtime_config,
  permissions = EXCLUDED.permissions,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  updated_at = EXCLUDED.updated_at;

-- Integration Orchestration Specialist
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
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'integration-orchestration-specialist',
  'specialist',
  'Integration Orchestration Specialist',
  'idle',
  'Integration orchestration specialist for cross-system integration, API orchestration, workflow coordination, dependency management, and error handling.',
  'hermes_local',
  '{
    "model": "ernie-4.0-turbo",
    "temperature": 0.2,
    "max_tokens": 6144,
    "skills": ["system-integration", "api-orchestration", "workflow-coordination"],
    "endpoints": {"primary": "hermes_local", "fallback": "spark-max"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 8,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 15, "burst_limit": 30},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["system-integration", "api-orchestration", "workflow-coordination"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai", "infraforge-ai"], "max_parallel_workflows": 6},
    "access": {"read_company_data": true, "write_company_data": true, "admin_functions": false}
  }'::jsonb,
  65000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  status = EXCLUDED.status,
  capabilities = EXCLUDED.capabilities,
  adapter_type = EXCLUDED.adapter_type,
  adapter_config = EXCLUDED.adapter_config,
  runtime_config = EXCLUDED.runtime_config,
  permissions = EXCLUDED.permissions,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  updated_at = EXCLUDED.updated_at;

-- Communication Coordination Specialist
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
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'communication-coordination-specialist',
  'specialist',
  'Communication Coordination Specialist',
  'idle',
  'Communication coordination specialist for stakeholder communication, progress reporting, issue escalation, collaboration facilitation, and feedback collection.',
  'hermes_local',
  '{
    "model": "ernie-4.0-turbo",
    "temperature": 0.3,
    "max_tokens": 6144,
    "skills": ["stakeholder-communication", "progress-reporting", "collaboration-management"],
    "endpoints": {"primary": "hermes_local", "fallback": "spark-max"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 10,
    "timeout_seconds": 1200,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 20, "burst_limit": 40},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["stakeholder-communication", "progress-reporting", "collaboration-management"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai", "knowledgeforge-ai"], "max_parallel_workflows": 8},
    "access": {"read_company_data": true, "write_company_data": true, "admin_functions": false}
  }'::jsonb,
  55000,
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  status = EXCLUDED.status,
  capabilities = EXCLUDED.capabilities,
  adapter_type = EXCLUDED.adapter_type,
  adapter_config = EXCLUDED.adapter_config,
  runtime_config = EXCLUDED.runtime_config,
  permissions = EXCLUDED.permissions,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  updated_at = EXCLUDED.updated_at;