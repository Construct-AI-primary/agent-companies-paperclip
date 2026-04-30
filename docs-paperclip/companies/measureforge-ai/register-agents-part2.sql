-- ============================================================
-- MeasureForge AI Agents Registration - Part 2
-- Created: 2026-04-22
-- Description: Registers the remaining 13 MeasureForge AI agents (Visual/Spatial + Procurement/Compliance + Specialized Domain)
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
  gen_random_uuid(),
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
  gen_random_uuid(),
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
  gen_random_uuid(),
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
  gen_random_uuid(),
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
  gen_random_uuid(),
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
  gen_random_uuid(),
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
  gen_random_uuid(),
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
  gen_random_uuid(),
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
    "max_tokens": 8192,
    "skills": ["solar-measurement", "pv-layout-optimization", "roof-geometry-analysis"],
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
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["solar-measurement", "pv-layout-optimization", "roof-geometry-analysis"]},
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

-- Traffic Signals Measurement Specialist
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
  'traffic-signals-measurement-specialist',
  'specialist',
  'Traffic Signals Measurement Specialist',
  'idle',
  'Traffic signals measurement specialist for intersection geometry analysis, signal phasing optimization, pedestrian crossing design, traffic flow modeling, visibility analysis, and safety compliance verification.',
  'hermes_local',
  '{
    "model": "ernie-4.0-turbo",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": ["traffic-signals-measurement", "intersection-geometry", "signal-phasing"],
    "endpoints": {"primary": "hermes_local", "fallback": "spark-max"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 4,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 8, "burst_limit": 15},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["traffic-signals-measurement", "intersection-geometry", "signal-phasing"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai"], "max_parallel_workflows": 3},
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

-- Electrical Measurement Specialist
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
  'electrical-measurement-specialist',
  'specialist',
  'Electrical Measurement Specialist',
  'idle',
  'Electrical measurement specialist for cable routing optimization, conduit fill calculations, grounding system design, electrical load analysis, voltage drop calculations, and arc flash hazard assessment.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": ["electrical-measurement", "cable-routing", "load-analysis"],
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
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["electrical-measurement", "cable-routing", "load-analysis"]},
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

-- Mechanical Measurement Specialist
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
  'mechanical-measurement-specialist',
  'specialist',
  'Mechanical Measurement Specialist',
  'idle',
  'Mechanical measurement specialist for HVAC ductwork sizing, piping system design, equipment clearance analysis, vibration isolation design, thermal expansion calculations, and structural support requirements.',
  'hermes_local',
  '{
    "model": "ernie-4.0-turbo",
    "temperature": 0.1,
    "max_tokens": 6144,
    "skills": ["mechanical-measurement", "hvac-sizing", "piping-design"],
    "endpoints": {"primary": "hermes_local", "fallback": "spark-max"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 4,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 8, "burst_limit": 15},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["mechanical-measurement", "hvac-sizing", "piping-design"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai"], "max_parallel_workflows": 3},
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

-- Structural Measurement Specialist
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
  'structural-measurement-specialist',
  'specialist',
  'Structural Measurement Specialist',
  'idle',
  'Structural measurement specialist for load path analysis, connection design verification, deflection calculations, foundation sizing, seismic analysis, and wind load assessment.',
  'hermes_local',
  '{
    "model": "qwen-max",
    "temperature": 0.1,
    "max_tokens": 8192,
    "skills": ["structural-measurement", "load-analysis", "connection-design"],
    "endpoints": {"primary": "hermes_local", "fallback": "hunyuan-turbo"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 3,
    "timeout_seconds": 2400,
    "retry_attempts": 2,
    "rate_limiting": {"requests_per_minute": 6, "burst_limit": 12},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["structural-measurement", "load-analysis", "connection-design"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai"], "max_parallel_workflows": 2},
    "access": {"read_company_data": true, "write_company_data": false, "admin_functions": false}
  }'::jsonb,
  70000,
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

-- Sustainability Measurement Specialist
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
  'sustainability-measurement-specialist',
  'specialist',
  'Sustainability Measurement Specialist',
  'idle',
  'Sustainability measurement specialist for carbon footprint analysis, energy efficiency optimization, material lifecycle assessment, water conservation design, renewable energy integration, and green building certification support.',
  'hermes_local',
  '{
    "model": "ernie-4.0-turbo",
    "temperature": 0.2,
    "max_tokens": 6144,
    "skills": ["sustainability-measurement", "carbon-footprint-analysis", "energy-efficiency"],
    "endpoints": {"primary": "hermes_local", "fallback": "spark-max"}
  }'::jsonb,
  '{
    "max_concurrent_tasks": 4,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {"requests_per_minute": 8, "burst_limit": 15},
    "error_handling": {"auto_retry": true, "escalation_enabled": true}
  }'::jsonb,
  '{
    "execute": {"automation_engine": "hermes_local", "allowed_domains": ["sustainability-measurement", "carbon-footprint-analysis", "energy-efficiency"]},
    "orchestrate": {"company_projects": ["measureforge-ai", "integrateforge-ai"], "max_parallel_workflows": 3},
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