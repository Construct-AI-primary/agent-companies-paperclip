-- ============================================================
-- MeasureForge AI Agents Registration
-- Created: 2026-04-22
-- Description: Registers all 23 MeasureForge AI agents in the Paperclip ecosystem
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
  'a1b2c3d4-e5f6-7890-abcd-measurement-validation',
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
  'a1b2c3d4-e5f6-7890-abcd-measurement-standards',
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
  'a1b2c3d4-e5f6-7890-abcd-measurement-coordination',
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
  'a1b2c3d4-e5f6-7890-abcd-advanced-engineering',
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
  'a1b2c3d4-e5f6-7890-abcd-cross-discipline',
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
  'a1b2c3d4-e5f6-7890-abcd-engineering-ui',
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
  'a1b2c3d4-e5f6-7890-abcd-document-intelligence',
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
  'a1b2c3d4-e5f6-7890-abcd-data-processing',
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
  'a1b2c3d4-e5f6-7890-abcd-integration-orchestration',
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
  'a1b2c3d4-e5f6-7890-abcd-communication-coordination',
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

-- ============================================================
-- Visual & Spatial Intelligence Agents (3)
-- ============================================================

-- Visual Overlay Specialist
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
  'a1b2c3d4-e5f6-7890-abcd-visual-overlay',
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'visual-overlay-specialist',
  'specialist',
  'Visual Overlay Specialist',
  'idle',
  'Visual overlay specialist for element tagging, overlay management, visual filtering, measurement visualization, and user interface overlay.',
  'hermes_local',
  '{
    "model": "ernie-4.0-turbo",
    "temperature": 0.2,
    "max_tokens": 6144,
    "skills": ["visual-processing", "overlay-management", "measurement-visualization"],
    "endpoints": {"primary": "hermes_local", "fallback": "spark-max"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 5,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 10, "burst_limit": 20},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["visual-processing", "overlay-management", "measurement-visualization"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai"], "max_parallel_workflows": 4},
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

-- Spatial Analysis Specialist
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
  'a1b2c3d4-e5f6-7890-abcd-spatial-analysis',
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'spatial-analysis-specialist',
  'specialist',
  'Spatial Analysis Specialist',
  'idle',
  'Spatial analysis specialist for 3D duplicate detection, spatial conflict resolution, geometric validation, coordinate system management, and tolerance analysis.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 8192,
    "skills": ["spatial-analysis", "geometric-validation", "coordinate-management"],
    "endpoints": {"primary": "hermes_local", "fallback": "hunyuan-turbo"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 4,
    "timeout_seconds": 2400,
    "retry_attempts": 2,
    "rate_limiting": {"requests_per_minute": 8, "burst_limit": 15},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["spatial-analysis", "geometric-validation", "coordinate-management"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai"], "max_parallel_workflows": 3},
    "access": {"read_company_data": true, "write_company_data": false, "admin_functions": false}
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

-- Performance Monitoring Specialist
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
  'a1b2c3d4-e5f6-7890-abcd-performance-monitoring',
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'performance-monitoring-specialist',
  'specialist',
  'Performance Monitoring Specialist',
  'idle',
  'Performance monitoring specialist for system performance tracking, resource utilization monitoring, bottleneck identification, optimization recommendations, and capacity planning.',
  'hermes_local',
  '{
    "model": "spark-max",
    "temperature": 0.2,
    "max_tokens": 6144,
    "skills": ["performance-monitoring", "system-optimization", "capacity-planning"],
    "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 6,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 12, "burst_limit": 25},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["performance-monitoring", "system-optimization", "capacity-planning"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "infraforge-ai"], "max_parallel_workflows": 4},
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

-- ============================================================
-- Procurement & Compliance Agents (4)
-- ============================================================

-- Procurement Integration Specialist
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
  'a1b2c3d4-e5f6-7890-abcd-procurement-integration',
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'procurement-integration-specialist',
  'specialist',
  'Procurement Integration Specialist',
  'idle',
  'Procurement integration specialist for CANDY system integration, procurement workflow automation, material cost analysis, supplier management, and contract tender preparation.',
  'hermes_local',
  '{
    "model": "ernie-4.0-turbo",
    "temperature": 0.2,
    "max_tokens": 6144,
    "skills": ["procurement-integration", "supplier-management", "contract-preparation"],
    "endpoints": {"primary": "hermes_local", "fallback": "spark-max"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 5,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 10, "burst_limit": 20},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["procurement-integration", "supplier-management", "contract-preparation"]},
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

-- Standards Compliance Specialist
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
  'a1b2c3d4-e5f6-7890-abcd-standards-compliance',
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'standards-compliance-specialist',
  'specialist',
  'Standards Compliance Specialist',
  'idle',
  'Standards compliance specialist for multi-jurisdictional compliance, standards interpretation, regulatory updates, compliance reporting, and audit preparation.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": ["standards-compliance", "regulatory-compliance", "audit-preparation"],
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
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["standards-compliance", "regulatory-compliance", "audit-preparation"]},
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

-- Security Compliance Specialist
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
  'a1b2c3d4-e5f6-7890-abcd-security-compliance',
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'security-compliance-specialist',
  'specialist',
  'Security Compliance Specialist',
  'idle',
  'Security compliance specialist for data security enforcement, compliance monitoring, access control management, audit trail maintenance, and regulatory reporting.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": ["security-compliance", "access-control", "audit-trail-management"],
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
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["security-compliance", "access-control", "audit-trail-management"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "infraforge-ai"], "max_parallel_workflows": 3},
    "access": {"read_company_data": true, "write_company_data": false, "admin_functions": false}
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

-- Quality Assurance Specialist
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
  'a1b2c3d4-e5f6-7890-abcd-quality-assurance',
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'quality-assurance-specialist',
  'specialist',
  'Quality Assurance Specialist',
  'idle',
  'Quality assurance specialist for measurement accuracy validation, error pattern analysis, quality control automation, statistical process control, and continuous improvement.',
  'hermes_local',
  '{
    "model": "ernie-4.0-turbo",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": ["quality-assurance", "error-analysis", "statistical-process-control"],
    "endpoints": {"primary": "hermes_local", "fallback": "spark-max"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 6,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 12, "burst_limit": 25},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["quality-assurance", "error-analysis", "statistical-process-control"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "qualityforge-ai"], "max_parallel_workflows": 4},
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
-- Specialized Measurement Domain Agents (6)
-- ============================================================

-- Solar Measurement Specialist
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
  'a1b2c3d4-e5f6-7890-abcd-solar-measurement',
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'solar-measurement-specialist',
  'specialist',
  'Solar Measurement Specialist',
  'idle',
  'Solar measurement specialist for PV layout optimization, roof geometry analysis, shading obstruction mapping, electrical stringing design, tilt angle optimization, inter-row spacing calculation, and structural clearance verification.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,