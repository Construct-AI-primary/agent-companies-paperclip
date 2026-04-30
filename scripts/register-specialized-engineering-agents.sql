-- ============================================================
-- Specialized Engineering Agents Registration Script
-- Created: 2026-04-21
-- Description: Registers three specialized agents for enterprise engineering platform
-- Agents: Engineering UI Specialist, Advanced Engineering Analysis, Cross-Discipline Coordination
-- Prerequisites: Operations Director (paperclipforge-ai-operations-director) must exist
-- ============================================================

-- Check if Operations Director exists before proceeding
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'paperclipforge-ai-operations-director') THEN
        RAISE EXCEPTION 'ERROR: Operations Director (paperclipforge-ai-operations-director) does not exist. Please create the Operations Director agent first.';
    END IF;
END $$;

-- Engineering UI Specialist Agent
INSERT INTO agents (
  company_id,
  name,
  role,
  title,
  status,
  reports_to,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  budget_monthly_cents
) VALUES (
  (SELECT id FROM companies WHERE name = 'PaperclipForge AI'),
  'paperclipforge-ai-engineering-ui-specialist',
  'specialist',
  'Engineering UI/UX Specialist',
  'idle',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director'),
  'Engineering UI/UX design specialist focused on creating engineering-specific user interfaces, technical visualizations, and domain-adapted user experiences for complex engineering workflows. Expert in CAD/BIM integration, analysis result visualization, and cross-discipline interface design.',
  'hermes_local',
  '{
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.7,
    "max_tokens": 4096,
    "skills": [
      "engineering-ui-design",
      "technical-visualization",
      "domain-adaptive-interfaces",
      "cad-ui-integration",
      "engineering-dashboard-design",
      "user-experience-engineering"
    ],
    "endpoints": {
      "primary": "hermes_local",
      "fallback": null
    }
  }'::jsonb,
  '{
    "max_concurrent_tasks": 5,
    "timeout_seconds": 1800,
    "retry_attempts": 3,
    "rate_limiting": {
      "requests_per_minute": 10,
      "burst_limit": 20
    },
    "error_handling": {
      "auto_retry": true,
      "escalation_enabled": true
    }
  }'::jsonb,
  '{
    "execute": {
      "automation_engine": "hermes_local",
      "allowed_domains": ["engineering-ui", "technical-visualization", "interface-design"]
    },
    "orchestrate": {
      "company_projects": ["paperclipforge-ai", "devforge-ai", "construct-ai"],
      "max_parallel_workflows": 3
    },
    "access": {
      "read_company_data": true,
      "write_company_data": false,
      "admin_functions": false
    }
  }'::jsonb,
  50000
) ON CONFLICT (name) DO UPDATE SET
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  adapter_config = EXCLUDED.adapter_config,
  runtime_config = EXCLUDED.runtime_config,
  permissions = EXCLUDED.permissions,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  updated_at = NOW()
WHERE agents.name = 'paperclipforge-ai-engineering-ui-specialist';

-- Advanced Engineering Analysis Agent
INSERT INTO agents (
  company_id,
  name,
  role,
  title,
  status,
  reports_to,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  budget_monthly_cents
) VALUES (
  (SELECT id FROM companies WHERE name = 'PaperclipForge AI'),
  'paperclipforge-ai-advanced-engineering-analysis',
  'specialist',
  'Advanced Engineering Analysis Specialist',
  'idle',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director'),
  'Advanced engineering analysis specialist providing enterprise-grade FEA, CFD, thermal analysis, and multi-physics simulations. Expert in structural analysis, fluid dynamics, thermal management, and engineering optimization for critical decision-making.',
  'hermes_local',
  '{
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.3,
    "max_tokens": 8192,
    "skills": [
      "finite-element-analysis",
      "computational-fluid-dynamics",
      "thermal-analysis",
      "structural-analysis",
      "multi-physics-simulation",
      "engineering-optimization",
      "analysis-automation",
      "results-interpretation"
    ],
    "endpoints": {
      "primary": "hermes_local",
      "fallback": null
    }
  }'::jsonb,
  '{
    "max_concurrent_tasks": 3,
    "timeout_seconds": 3600,
    "retry_attempts": 2,
    "rate_limiting": {
      "requests_per_minute": 5,
      "burst_limit": 10
    },
    "error_handling": {
      "auto_retry": true,
      "escalation_enabled": true
    }
  }'::jsonb,
  '{
    "execute": {
      "automation_engine": "hermes_local",
      "allowed_domains": ["engineering-analysis", "simulation", "fea", "cfd", "thermal-analysis"]
    },
    "orchestrate": {
      "company_projects": ["paperclipforge-ai", "domainforge-ai", "construct-ai"],
      "max_parallel_workflows": 2
    },
    "access": {
      "read_company_data": true,
      "write_company_data": false,
      "admin_functions": false
    }
  }'::jsonb,
  75000
) ON CONFLICT (name) DO UPDATE SET
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  adapter_config = EXCLUDED.adapter_config,
  runtime_config = EXCLUDED.runtime_config,
  permissions = EXCLUDED.permissions,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  updated_at = NOW()
WHERE agents.name = 'paperclipforge-ai-advanced-engineering-analysis';

-- Cross-Discipline Coordination Agent
INSERT INTO agents (
  company_id,
  name,
  role,
  title,
  status,
  reports_to,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  budget_monthly_cents
) VALUES (
  (SELECT id FROM companies WHERE name = 'PaperclipForge AI'),
  'paperclipforge-ai-cross-discipline-coordination',
  'specialist',
  'Cross-Discipline Coordination Specialist',
  'idle',
  (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director'),
  'Cross-discipline coordination specialist managing BIM coordination, clash detection, interdisciplinary design integration, and engineering change management for enterprise construction projects. Expert in federated model management and multi-disciplinary collaboration.',
  'hermes_local',
  '{
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.5,
    "max_tokens": 6144,
    "skills": [
      "bim-coordination",
      "clash-detection",
      "interdisciplinary-integration",
      "engineering-change-management",
      "design-coordination",
      "conflict-resolution",
      "federated-model-management",
      "coordination-automation"
    ],
    "endpoints": {
      "primary": "hermes_local",
      "fallback": null
    }
  }'::jsonb,
  '{
    "max_concurrent_tasks": 4,
    "timeout_seconds": 2400,
    "retry_attempts": 3,
    "rate_limiting": {
      "requests_per_minute": 8,
      "burst_limit": 15
    },
    "error_handling": {
      "auto_retry": true,
      "escalation_enabled": true
    }
  }'::jsonb,
  '{
    "execute": {
      "automation_engine": "hermes_local",
      "allowed_domains": ["bim-coordination", "clash-detection", "interdisciplinary-integration", "change-management"]
    },
    "orchestrate": {
      "company_projects": ["paperclipforge-ai", "construct-ai", "domainforge-ai", "integrateforge-ai"],
      "max_parallel_workflows": 4
    },
    "access": {
      "read_company_data": true,
      "write_company_data": true,
      "admin_functions": false
    }
  }'::jsonb,
  60000
) ON CONFLICT (name) DO UPDATE SET
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  adapter_config = EXCLUDED.adapter_config,
  runtime_config = EXCLUDED.runtime_config,
  permissions = EXCLUDED.permissions,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  updated_at = NOW()
WHERE agents.name = 'paperclipforge-ai-cross-discipline-coordination';

-- Verification queries
-- SELECT id, name, role, title, status, adapter_config->>'model' as model
-- FROM agents
-- WHERE name LIKE 'paperclipforge-ai-%-specialist'
-- ORDER BY name;

-- JOIN companies c ON a.company_id = c.id
-- WHERE a.name LIKE 'paperclipforge-ai-%-specialist';

-- ============================================================
-- Clean up: Uncomment to remove all three agents
-- DELETE FROM agents WHERE name IN (
--   'paperclipforge-ai-engineering-ui-specialist',
--   'paperclipforge-ai-advanced-engineering-analysis',
--   'paperclipforge-ai-cross-discipline-coordination'
-- );