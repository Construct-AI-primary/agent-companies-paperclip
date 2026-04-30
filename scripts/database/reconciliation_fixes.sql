-- ============================================================
-- PAPERCLIP AGENT RECONCILIATION FIXES
-- Generated: /Users/_test-20260416/paperclip-render/reconciliation_agent.py
-- ============================================================


-- Insert missing agent:  (Blog Architect)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
    'Blog Architect',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Blog Architect');


-- Insert missing agent:  (Technical SEO Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
    'Technical SEO Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Technical SEO Specialist');


-- Insert missing agent:  (Content Maestro)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
    'Content Maestro',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Content Maestro');


-- Insert missing agent:  (Echo - Communication Orchestrator)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
    'Echo - Communication Orchestrator',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Echo - Communication Orchestrator');


-- Insert missing agent:  (Social Strategist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
    'Social Strategist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Social Strategist');


-- Insert missing agent:  (ally-devforge-partnership-management)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'ally-devforge-partnership-management',
    'general',
    'ally-devforge-partnership-management',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'ally-devforge-partnership-management');


-- Insert missing agent:  (interface-devforge-api-integration)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'interface-devforge-api-integration',
    'general',
    'interface-devforge-api-integration',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'interface-devforge-api-integration');


-- Insert missing agent:  (vector-Vector-processing)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'vector-Vector-processing',
    'general',
    'vector-Vector-processing',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'vector-Vector-processing');


-- Insert missing agent:  (voyager-devforge-market-exploration)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'voyager-devforge-market-exploration',
    'general',
    'voyager-devforge-market-exploration',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'voyager-devforge-market-exploration');


-- Insert missing agent:  (librarian-devforge-knowledge-management)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'librarian-devforge-knowledge-management',
    'general',
    'librarian-devforge-knowledge-management',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'librarian-devforge-knowledge-management');


-- Insert missing agent:  (fixer-devforge-bug-fixing)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'fixer-devforge-bug-fixing',
    'general',
    'fixer-devforge-bug-fixing',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'fixer-devforge-bug-fixing');


-- Insert missing agent:  (forge-devforge-system-architecture)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'forge-devforge-system-architecture',
    'general',
    'forge-devforge-system-architecture',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'forge-devforge-system-architecture');


-- Insert missing agent:  (nexus-devforge-ceo)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'nexus-devforge-ceo',
    'general',
    'nexus-devforge-ceo',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'nexus-devforge-ceo');


-- Insert missing agent:  (synth-Synthetic-data)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'synth-Synthetic-data',
    'general',
    'synth-Synthetic-data',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'synth-Synthetic-data');


-- Insert missing agent:  (archivist-devforge-knowledge-security)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'archivist-devforge-knowledge-security',
    'general',
    'archivist-devforge-knowledge-security',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'archivist-devforge-knowledge-security');


-- Insert missing agent:  (insight-devforge-business-intelligence)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'insight-devforge-business-intelligence',
    'general',
    'insight-devforge-business-intelligence',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'insight-devforge-business-intelligence');


-- Insert missing agent:  (sentinel-devforge-data-quality-monitoring)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'sentinel-devforge-data-quality-monitoring',
    'general',
    'sentinel-devforge-data-quality-monitoring',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'sentinel-devforge-data-quality-monitoring');


-- Insert missing agent:  (merchant-devforge-commerce-operations)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'merchant-devforge-commerce-operations',
    'general',
    'merchant-devforge-commerce-operations',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'merchant-devforge-commerce-operations');


-- Insert missing agent:  (devcore-devforge-core-development)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'devcore-devforge-core-development',
    'general',
    'devcore-devforge-core-development',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'devcore-devforge-core-development');


-- Insert missing agent:  (cloudops-devforge-cloud-operations)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'cloudops-devforge-cloud-operations',
    'general',
    'cloudops-devforge-cloud-operations',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'cloudops-devforge-cloud-operations');


-- Insert missing agent:  (concierge-devforge-customer-experience)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'concierge-devforge-customer-experience',
    'general',
    'concierge-devforge-customer-experience',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'concierge-devforge-customer-experience');


-- Insert missing agent:  (sentinelx-devforge-advanced-monitoring)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'sentinelx-devforge-advanced-monitoring',
    'general',
    'sentinelx-devforge-advanced-monitoring',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'sentinelx-devforge-advanced-monitoring');


-- Insert missing agent:  (sql-query-devforge)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'sql-query-devforge',
    'general',
    'sql-query-devforge',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'sql-query-devforge');


-- Insert missing agent:  (schema-devforge-data-schema-management)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'schema-devforge-data-schema-management',
    'general',
    'schema-devforge-data-schema-management',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'schema-devforge-data-schema-management');


-- Insert missing agent:  (council-devforge-strategic-decision-making)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'council-devforge-strategic-decision-making',
    'general',
    'council-devforge-strategic-decision-making',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'council-devforge-strategic-decision-making');


-- Insert missing agent:  (mentor-devforge-team-development)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'mentor-devforge-team-development',
    'general',
    'mentor-devforge-team-development',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'mentor-devforge-team-development');


-- Insert missing agent:  (dealmaker-devforge-sales-negotiation)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'dealmaker-devforge-sales-negotiation',
    'general',
    'dealmaker-devforge-sales-negotiation',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'dealmaker-devforge-sales-negotiation');


-- Insert missing agent:  (Sage - Workflow Learning Coordinator)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'Sage - Workflow Learning Coordinator',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Sage - Workflow Learning Coordinator');


-- Insert missing agent:  (atlas-devforge-product-mapping)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'atlas-devforge-product-mapping',
    'general',
    'atlas-devforge-product-mapping',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'atlas-devforge-product-mapping');


-- Insert missing agent:  (strategos-devforge-strategic-planning)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'strategos-devforge-strategic-planning',
    'general',
    'strategos-devforge-strategic-planning',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'strategos-devforge-strategic-planning');


-- Insert missing agent:  (guardian-devforge-threat-protection)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'guardian-devforge-threat-protection',
    'general',
    'guardian-devforge-threat-protection',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'guardian-devforge-threat-protection');


-- Insert missing agent:  (amplifier-devforge-marketing-promotion)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'amplifier-devforge-marketing-promotion',
    'general',
    'amplifier-devforge-marketing-promotion',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'amplifier-devforge-marketing-promotion');


-- Insert missing agent:  (nova-devforge-product-launches)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'nova-devforge-product-launches',
    'general',
    'nova-devforge-product-launches',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'nova-devforge-product-launches');


-- Insert missing agent:  (analyst-devforge-market-analysis)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'analyst-devforge-market-analysis',
    'general',
    'analyst-devforge-market-analysis',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'analyst-devforge-market-analysis');


-- Insert missing agent:  (brandforge-devforge-brand-development)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'brandforge-devforge-brand-development',
    'general',
    'brandforge-devforge-brand-development',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'brandforge-devforge-brand-development');


-- Insert missing agent:  (pathfinder-devforge-opportunity-identification)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'pathfinder-devforge-opportunity-identification',
    'general',
    'pathfinder-devforge-opportunity-identification',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'pathfinder-devforge-opportunity-identification');


-- Insert missing agent:  (catalyst-devforge-product-innovation)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'catalyst-devforge-product-innovation',
    'general',
    'catalyst-devforge-product-innovation',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'catalyst-devforge-product-innovation');


-- Insert missing agent:  (codesmith-devforge-backend-engineer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'codesmith-devforge-backend-engineer',
    'general',
    'codesmith-devforge-backend-engineer',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'codesmith-devforge-backend-engineer');


-- Insert missing agent:  (automata-devforge-automation-systems)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'automata-devforge-automation-systems',
    'general',
    'automata-devforge-automation-systems',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'automata-devforge-automation-systems');


-- Insert missing agent:  (storycraft-devforge-product-storytelling)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'storycraft-devforge-product-storytelling',
    'general',
    'storycraft-devforge-product-storytelling',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'storycraft-devforge-product-storytelling');


-- Insert missing agent:  (promptsmith-devforge-prompt-engineering)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'promptsmith-devforge-prompt-engineering',
    'general',
    'promptsmith-devforge-prompt-engineering',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'promptsmith-devforge-prompt-engineering');


-- Insert missing agent:  (compass-devforge-direction-setting)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'compass-devforge-direction-setting',
    'general',
    'compass-devforge-direction-setting',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'compass-devforge-direction-setting');


-- Insert missing agent:  (navigator-devforge-data-discovery)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'navigator-devforge-data-discovery',
    'general',
    'navigator-devforge-data-discovery',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'navigator-devforge-data-discovery');


-- Insert missing agent:  (reviewer-devforge-code-review-qa)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'reviewer-devforge-code-review-qa',
    'general',
    'reviewer-devforge-code-review-qa',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'reviewer-devforge-code-review-qa');


-- Insert missing agent:  (ambassador-devforge-brand-representation)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'ambassador-devforge-brand-representation',
    'general',
    'ambassador-devforge-brand-representation',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'ambassador-devforge-brand-representation');


-- Insert missing agent:  (gatekeeper-devforge-access-control)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'gatekeeper-devforge-access-control',
    'general',
    'gatekeeper-devforge-access-control',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'gatekeeper-devforge-access-control');


-- Insert missing agent:  (Quantum - Workflow Complexity Analyzer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'Quantum - Workflow Complexity Analyzer',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Quantum - Workflow Complexity Analyzer');


-- Insert missing agent:  (watchtower-devforge-security-oversight)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'watchtower-devforge-security-oversight',
    'general',
    'watchtower-devforge-security-oversight',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'watchtower-devforge-security-oversight');


-- Insert missing agent:  (oracle-devforge-predictive-analytics)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'oracle-devforge-predictive-analytics',
    'general',
    'oracle-devforge-predictive-analytics',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'oracle-devforge-predictive-analytics');


-- Insert missing agent:  (auditor-devforge-security-compliance)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'auditor-devforge-security-compliance',
    'general',
    'auditor-devforge-security-compliance',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'auditor-devforge-security-compliance');


-- Insert missing agent:  (stream-devforge-data-streaming)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'stream-devforge-data-streaming',
    'general',
    'stream-devforge-data-streaming',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'stream-devforge-data-streaming');


-- Insert missing agent:  (dataforge-devforge-data-transformation)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'dataforge-devforge-data-transformation',
    'general',
    'dataforge-devforge-data-transformation',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'dataforge-devforge-data-transformation');


-- Insert missing agent:  (catalystx-devforge-market-disruption)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'catalystx-devforge-market-disruption',
    'general',
    'catalystx-devforge-market-disruption',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'catalystx-devforge-market-disruption');


-- Insert missing agent:  (scout-devforge-competitive-intelligence)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'scout-devforge-competitive-intelligence',
    'general',
    'scout-devforge-competitive-intelligence',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'scout-devforge-competitive-intelligence');


-- Insert missing agent:  (cartographer-devforge-product-roadmapping)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'cartographer-devforge-product-roadmapping',
    'general',
    'cartographer-devforge-product-roadmapping',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'cartographer-devforge-product-roadmapping');


-- Insert missing agent:  (ledgerai-devforge-financial-data)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'ledgerai-devforge-financial-data',
    'general',
    'ledgerai-devforge-financial-data',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'ledgerai-devforge-financial-data');


-- Insert missing agent:  (pulse-devforge-realtime-monitoring)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'pulse-devforge-realtime-monitoring',
    'general',
    'pulse-devforge-realtime-monitoring',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'pulse-devforge-realtime-monitoring');


-- Insert missing agent:  (orion-devforge-orchestrator)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'orion-devforge-orchestrator',
    'general',
    'orion-devforge-orchestrator',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'orion-devforge-orchestrator');


-- Insert missing agent:  (ledger-devforge-financial-oversight)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'ledger-devforge-financial-oversight',
    'general',
    'ledger-devforge-financial-oversight',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'ledger-devforge-financial-oversight');


-- Insert missing agent:  (cortex-devforge-ai-reasoning)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1),
    'cortex-devforge-ai-reasoning',
    'general',
    'cortex-devforge-ai-reasoning',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'cortex-devforge-ai-reasoning');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (procurement-domainforge-procurement-contracts)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'procurement-domainforge-procurement-contracts',
    'general',
    'procurement-domainforge-procurement-contracts',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'procurement-domainforge-procurement-contracts');


-- Insert missing agent:  (council-domainforge-governance-standards)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'council-domainforge-governance-standards',
    'general',
    'council-domainforge-governance-standards',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'council-domainforge-governance-standards');


-- Insert missing agent:  (strategos-domainforge-strategic-planning)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'strategos-domainforge-strategic-planning',
    'general',
    'strategos-domainforge-strategic-planning',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'strategos-domainforge-strategic-planning');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (contract-administration-domainforge-contract-administration)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'contract-administration-domainforge-contract-administration',
    'general',
    'contract-administration-domainforge-contract-administration',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'contract-administration-domainforge-contract-administration');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (orion-domainforge-ceo)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'orion-domainforge-ceo',
    'general',
    'orion-domainforge-ceo',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'orion-domainforge-ceo');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (procurement-strategy-domainforge-procurement-strategy)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'procurement-strategy-domainforge-procurement-strategy',
    'general',
    'procurement-strategy-domainforge-procurement-strategy',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'procurement-strategy-domainforge-procurement-strategy');


-- Insert missing agent:  (contract-administration-domainforge-contract-administration)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'contract-administration-domainforge-contract-administration',
    'general',
    'contract-administration-domainforge-contract-administration',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'contract-administration-domainforge-contract-administration');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (structural-domainforge-structural-engineering)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'structural-domainforge-structural-engineering',
    'general',
    'structural-domainforge-structural-engineering',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'structural-domainforge-structural-engineering');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (finance-domainforge-finance-cost-management)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'finance-domainforge-finance-cost-management',
    'general',
    'finance-domainforge-finance-cost-management',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'finance-domainforge-finance-cost-management');


-- Insert missing agent:  (civil-domainforge-civil-engineering)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'civil-domainforge-civil-engineering',
    'general',
    'civil-domainforge-civil-engineering',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'civil-domainforge-civil-engineering');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (civil-domainforge-civil-engineering)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'civil-domainforge-civil-engineering',
    'general',
    'civil-domainforge-civil-engineering',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'civil-domainforge-civil-engineering');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (safety-domainforge-safety-risk-management)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'safety-domainforge-safety-risk-management',
    'general',
    'safety-domainforge-safety-risk-management',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'safety-domainforge-safety-risk-management');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (quality-assurance-domainforge-quality-assurance)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'quality-assurance-domainforge-quality-assurance',
    'general',
    'quality-assurance-domainforge-quality-assurance',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'quality-assurance-domainforge-quality-assurance');


-- Insert missing agent:  (quality-control-domainforge-quality-control)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'quality-control-domainforge-quality-control',
    'general',
    'quality-control-domainforge-quality-control',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'quality-control-domainforge-quality-control');


-- Insert missing agent:  (procurement-analytics-domainforge-procurement-analytics)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'procurement-analytics-domainforge-procurement-analytics',
    'general',
    'procurement-analytics-domainforge-procurement-analytics',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'procurement-analytics-domainforge-procurement-analytics');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (strategos-domainforge-strategic-planning)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'strategos-domainforge-strategic-planning',
    'general',
    'strategos-domainforge-strategic-planning',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'strategos-domainforge-strategic-planning');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (council-domainforge-governance-standards)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'council-domainforge-governance-standards',
    'general',
    'council-domainforge-governance-standards',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'council-domainforge-governance-standards');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (finance-domainforge-finance-cost-management)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'finance-domainforge-finance-cost-management',
    'general',
    'finance-domainforge-finance-cost-management',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'finance-domainforge-finance-cost-management');


-- Insert missing agent:  (logistics-domainforge-supply-chain)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'logistics-domainforge-supply-chain',
    'general',
    'logistics-domainforge-supply-chain',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'logistics-domainforge-supply-chain');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (structural-domainforge-structural-engineering)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'structural-domainforge-structural-engineering',
    'general',
    'structural-domainforge-structural-engineering',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'structural-domainforge-structural-engineering');


-- Insert missing agent:  (procurement-domainforge-procurement-contracts)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'procurement-domainforge-procurement-contracts',
    'general',
    'procurement-domainforge-procurement-contracts',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'procurement-domainforge-procurement-contracts');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (construction-engineering-domainforge-construction-engineering)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'construction-engineering-domainforge-construction-engineering',
    'general',
    'construction-engineering-domainforge-construction-engineering',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'construction-engineering-domainforge-construction-engineering');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (legal-domainforge-legal-regulatory-compliance)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'legal-domainforge-legal-regulatory-compliance',
    'general',
    'legal-domainforge-legal-regulatory-compliance',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'legal-domainforge-legal-regulatory-compliance');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (orion-domainforge-ceo)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'orion-domainforge-ceo',
    'general',
    'orion-domainforge-ceo',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'orion-domainforge-ceo');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (quality-assurance-domainforge-quality-assurance)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'quality-assurance-domainforge-quality-assurance',
    'general',
    'quality-assurance-domainforge-quality-assurance',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'quality-assurance-domainforge-quality-assurance');


-- Insert missing agent:  (safety-domainforge-safety-risk-management)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'safety-domainforge-safety-risk-management',
    'general',
    'safety-domainforge-safety-risk-management',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'safety-domainforge-safety-risk-management');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (geotechnical-domainforge-geotechnical-engineering)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'geotechnical-domainforge-geotechnical-engineering',
    'general',
    'geotechnical-domainforge-geotechnical-engineering',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'geotechnical-domainforge-geotechnical-engineering');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (quality-control-domainforge-quality-control)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'quality-control-domainforge-quality-control',
    'general',
    'quality-control-domainforge-quality-control',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'quality-control-domainforge-quality-control');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (geotechnical-domainforge-geotechnical-engineering)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'geotechnical-domainforge-geotechnical-engineering',
    'general',
    'geotechnical-domainforge-geotechnical-engineering',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'geotechnical-domainforge-geotechnical-engineering');


-- Insert missing agent:  (legal-domainforge-legal-regulatory-compliance)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'legal-domainforge-legal-regulatory-compliance',
    'general',
    'legal-domainforge-legal-regulatory-compliance',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'legal-domainforge-legal-regulatory-compliance');


-- Insert missing agent:  (construction-engineering-domainforge-construction-engineering)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'construction-engineering-domainforge-construction-engineering',
    'general',
    'construction-engineering-domainforge-construction-engineering',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'construction-engineering-domainforge-construction-engineering');


-- Insert missing agent:  (procurement-strategy-domainforge-procurement-strategy)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'procurement-strategy-domainforge-procurement-strategy',
    'general',
    'procurement-strategy-domainforge-procurement-strategy',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'procurement-strategy-domainforge-procurement-strategy');


-- Insert missing agent:  (procurement-analytics-domainforge-procurement-analytics)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'procurement-analytics-domainforge-procurement-analytics',
    'general',
    'procurement-analytics-domainforge-procurement-analytics',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'procurement-analytics-domainforge-procurement-analytics');


-- Insert missing agent:  (logistics-domainforge-supply-chain)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'DomainForge AI' LIMIT 1),
    'logistics-domainforge-supply-chain',
    'general',
    'logistics-domainforge-supply-chain',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'logistics-domainforge-supply-chain');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (maya-loopy-content-strategist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'maya-loopy-content-strategist',
    'general',
    'maya-loopy-content-strategist',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'maya-loopy-content-strategist');


-- Insert missing agent:  (Vision Loopy CEO - Loopy AI Chief Executive Officer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Vision Loopy CEO - Loopy AI Chief Executive Officer',
    'general',
    'vision-loopy-ceo',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Vision Loopy CEO - Loopy AI Chief Executive Officer');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'ExecForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Nimbus - Supabase Database Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'InfraForge AI' LIMIT 1),
    'Nimbus - Supabase Database Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Nimbus - Supabase Database Specialist');


-- Insert missing agent:  (Render Deployment Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'InfraForge AI' LIMIT 1),
    'Render Deployment Specialist',
    'general',
    'render-deployment-specialist',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Render Deployment Specialist');


-- Insert missing agent:  (Database Infrastructure Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'InfraForge AI' LIMIT 1),
    'Database Infrastructure Agent',
    'general',
    'database-infraforge-database-infrastructure',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Database Infrastructure Agent');


-- Insert missing agent:  (orchestrator-infraforge-ceo)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'InfraForge AI' LIMIT 1),
    'orchestrator-infraforge-ceo',
    'general',
    'orchestrator-infraforge-ceo',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'orchestrator-infraforge-ceo');


-- Insert missing agent:  (supply-chain-integration-infraforge-supply-chain)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'InfraForge AI' LIMIT 1),
    'supply-chain-integration-infraforge-supply-chain',
    'general',
    'supply-chain-integration-infraforge-supply-chain',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'supply-chain-integration-infraforge-supply-chain');


-- Insert missing agent:  (postgres-infraforge)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'InfraForge AI' LIMIT 1),
    'postgres-infraforge',
    'general',
    'postgres-infraforge',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'postgres-infraforge');


-- Insert missing agent:  (mobile-api-infraforge-mobile-api-integration)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'InfraForge AI' LIMIT 1),
    'mobile-api-infraforge-mobile-api-integration',
    'general',
    'mobile-api-infraforge-mobile-api-integration',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'mobile-api-infraforge-mobile-api-integration');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'IntegrateForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Administrator - pre-award)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'KnowledgeForge AI' LIMIT 1),
    'Administrator - pre-award',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Administrator - pre-award');


-- Insert missing agent:  (Co-ordinator)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'KnowledgeForge AI' LIMIT 1),
    'Co-ordinator',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Co-ordinator');


-- Insert missing agent:  (Buyer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'KnowledgeForge AI' LIMIT 1),
    'Buyer',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Buyer');


-- Insert missing agent:  (Co-ordinator)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'KnowledgeForge AI' LIMIT 1),
    'Co-ordinator',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Co-ordinator');


-- Insert missing agent:  (Architect - refactor)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'KnowledgeForge AI' LIMIT 1),
    'Architect - refactor',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Architect - refactor');


-- Insert missing agent:  (User Manager)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'KnowledgeForge AI' LIMIT 1),
    'User Manager',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'User Manager');


-- Insert missing agent:  (Development Manager)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'KnowledgeForge AI' LIMIT 1),
    'Development Manager',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Development Manager');


-- Insert missing agent:  (Communication Manager)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'KnowledgeForge AI' LIMIT 1),
    'Communication Manager',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Communication Manager');


-- Insert missing agent:  (System Administrator)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'KnowledgeForge AI' LIMIT 1),
    'System Administrator',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'System Administrator');


-- Insert missing agent:  (AI Manager)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'KnowledgeForge AI' LIMIT 1),
    'AI Manager',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'AI Manager');


-- Insert missing agent:  (Operations Coordinator)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'KnowledgeForge AI' LIMIT 1),
    'Operations Coordinator',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Operations Coordinator');


-- Insert missing agent:  (KnowledgeForge Workflow Guardian)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'KnowledgeForge AI' LIMIT 1),
    'KnowledgeForge Workflow Guardian',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'KnowledgeForge Workflow Guardian');


-- Insert missing agent:  (Interface Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'KnowledgeForge AI' LIMIT 1),
    'Interface Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Interface Specialist');


-- Insert missing agent:  (Administrator - pre-award)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'KnowledgeForge AI' LIMIT 1),
    'Administrator - pre-award',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Administrator - pre-award');


-- Insert missing agent:  (Assessment Mastery Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Assessment Mastery Agent',
    'general',
    'learningforge-ai-assessment-mastery',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Assessment Mastery Agent');


-- Insert missing agent: learningforge-ai-error-pattern-monitor (Error Pattern Monitor)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Error Pattern Monitor',
    'general',
    'learningforge-ai-error-pattern-monitor',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Error Pattern Monitor');


-- Insert missing agent:  (User Behavior Analyst)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'User Behavior Analyst',
    'general',
    'learningforge-ai-user-behavior-analyst',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'User Behavior Analyst');


-- Insert missing agent:  (Research Compliance Division Lead)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Research Compliance Division Lead',
    'general',
    'learningforge-ai-research-compliance-division-lead',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Research Compliance Division Lead');


-- Insert missing agent:  (Equipment Inspection Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Equipment Inspection Agent',
    'general',
    'learningforge-ai-equipment-inspection',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Equipment Inspection Agent');


-- Insert missing agent:  (AutoResearch Gap Analyzer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'AutoResearch Gap Analyzer',
    'general',
    'learningforge-ai-autoresearch-gap-analyzer',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'AutoResearch Gap Analyzer');


-- Insert missing agent:  (Doc Usage Analyzer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Doc Usage Analyzer',
    'general',
    'learningforge-ai-doc-usage-analyzer',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Doc Usage Analyzer');


-- Insert missing agent:  (Safety Research Agent - LearningForge AI)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Safety Research Agent - LearningForge AI',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Safety Research Agent - LearningForge AI');


-- Insert missing agent:  (Electrical Engineering Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Electrical Engineering Agent',
    'general',
    'learningforge-ai-electrical-engineering-agent',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Electrical Engineering Agent');


-- Insert missing agent:  (Hazard Pattern Analyst)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Hazard Pattern Analyst',
    'general',
    'learningforge-ai-hazard-pattern-analyst',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Hazard Pattern Analyst');


-- Insert missing agent:  (Knowledge Provenance Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Knowledge Provenance Agent',
    'general',
    'learningforge-ai-knowledge-provenance',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Knowledge Provenance Agent');


-- Insert missing agent:  (From Doc To Lesson Generator)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'From Doc To Lesson Generator',
    'general',
    'learningforge-ai-from-doc-to-lesson-generator',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'From Doc To Lesson Generator');


-- Insert missing agent:  (Interaction Pattern Coach)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Interaction Pattern Coach',
    'general',
    'learningforge-ai-interaction-pattern-coach',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Interaction Pattern Coach');


-- Insert missing agent:  (VFS Watcher Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'VFS Watcher Agent',
    'general',
    'learningforge-ai-vfs-watcher',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'VFS Watcher Agent');


-- Insert missing agent:  (Quality Learning Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Quality Learning Agent',
    'general',
    'learningforge-ai-quality-learning',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Quality Learning Agent');


-- Insert missing agent:  (Compliance Guard Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Compliance Guard Agent',
    'general',
    'learningforge-ai-compliance-guard',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Compliance Guard Agent');


-- Insert missing agent:  (Research Scheduler Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Research Scheduler Agent',
    'general',
    'learningforge-ai-research-scheduler',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Research Scheduler Agent');


-- Insert missing agent:  (Safety Regulation Research Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Safety Regulation Research Agent',
    'general',
    'learningforge-ai-safety-regulation-research',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Safety Regulation Research Agent');


-- Insert missing agent:  (Mobile Patterns Agent - LearningForge AI)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Mobile Patterns Agent - LearningForge AI',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Mobile Patterns Agent - LearningForge AI');


-- Insert missing agent:  (Learning Integration Agent - LearningForge AI)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Learning Integration Agent - LearningForge AI',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Learning Integration Agent - LearningForge AI');


-- Insert missing agent:  (Material Defect Tracker)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Material Defect Tracker',
    'general',
    'learningforge-ai-material-defect-tracker',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Material Defect Tracker');


-- Insert missing agent:  (Safety Training Compliance Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Safety Training Compliance Agent',
    'general',
    'learningforge-ai-safety-training-compliance',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Safety Training Compliance Agent');


-- Insert missing agent:  (Procurement Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Procurement Agent',
    'general',
    'learningforge-ai-procurement-agent',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Procurement Agent');


-- Insert missing agent:  (Safety Workflow Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Safety Workflow Agent',
    'general',
    'learningforge-ai-safety-workflow-agent',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Safety Workflow Agent');


-- Insert missing agent:  (Doc Gap Detector)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Doc Gap Detector',
    'general',
    'learningforge-ai-doc-gap-detector',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Doc Gap Detector');


-- Insert missing agent:  (Hermes Research Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Hermes Research Agent',
    'general',
    'learningforge-ai-hermes-research',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Hermes Research Agent');


-- Insert missing agent:  (Equipment Innovation Research Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Equipment Innovation Research Agent',
    'general',
    'learningforge-ai-equipment-innovation-research',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Equipment Innovation Research Agent');


-- Insert missing agent:  (Learning Division Lead)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Learning Division Lead',
    'general',
    'learningforge-ai-learning-division-lead',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Learning Division Lead');


-- Insert missing agent:  (Goal Alignment & Budget Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Goal Alignment & Budget Agent',
    'general',
    'learningforge-ai-goal-alignment-budget',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Goal Alignment & Budget Agent');


-- Insert missing agent:  (Knowledge Hygiene Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Knowledge Hygiene Agent',
    'general',
    'learningforge-ai-knowledge-hygiene',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Knowledge Hygiene Agent');


-- Insert missing agent:  (Audit By Path Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Audit By Path Agent',
    'general',
    'learningforge-ai-audit-by-path',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Audit By Path Agent');


-- Insert missing agent:  (LangChain Runner Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'LangChain Runner Agent',
    'general',
    'learningforge-ai-langchain-runner',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'LangChain Runner Agent');


-- Insert missing agent:  (Defect Pattern Research Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Defect Pattern Research Agent',
    'general',
    'learningforge-ai-defect-pattern-research',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Defect Pattern Research Agent');


-- Insert missing agent:  (Safety Quality Division Lead)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Safety Quality Division Lead',
    'general',
    'learningforge-ai-safety-quality-division-lead',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Safety Quality Division Lead');


-- Insert missing agent:  (Logistics Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Logistics Agent',
    'general',
    'learningforge-ai-logistics-agent',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Logistics Agent');


-- Insert missing agent:  (Feedback Synthesis Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Feedback Synthesis Agent',
    'general',
    'learningforge-ai-feedback-synthesis',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Feedback Synthesis Agent');


-- Insert missing agent:  (Workflow Coach)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Workflow Coach',
    'general',
    'learningforge-ai-workflow-coach',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Workflow Coach');


-- Insert missing agent:  (AutoResearch Skills Enhancer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'AutoResearch Skills Enhancer',
    'general',
    'learningforge-ai-autoresearch-skills-enhancer',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'AutoResearch Skills Enhancer');


-- Insert missing agent:  (Knowledge Flow Division Lead)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Knowledge Flow Division Lead',
    'general',
    'learningforge-ai-knowledge-flow-division-lead',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Knowledge Flow Division Lead');


-- Insert missing agent:  (AutoResearch Literature Scanner)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'AutoResearch Literature Scanner',
    'general',
    'learningforge-ai-autoresearch-literature-scanner',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'AutoResearch Literature Scanner');


-- Insert missing agent:  (VFS Markdown Tracker)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'VFS Markdown Tracker',
    'general',
    'learningforge-ai-vfs-markdown-tracker',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'VFS Markdown Tracker');


-- Insert missing agent:  (Priority Disciplines Lead)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Priority Disciplines Lead',
    'general',
    'learningforge-ai-priority-disciplines-lead',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Priority Disciplines Lead');


-- Insert missing agent:  (Curriculum Planner)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Curriculum Planner',
    'general',
    'learningforge-ai-curriculum-planner',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Curriculum Planner');


-- Insert missing agent:  (Micro-Lesson Generator)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Micro-Lesson Generator',
    'general',
    'learningforge-ai-micro-lesson-generator',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Micro-Lesson Generator');


-- Insert missing agent:  (Audit & Explainability Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Audit & Explainability Agent',
    'general',
    'learningforge-ai-audit-explainability',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Audit & Explainability Agent');


-- Insert missing agent:  (Knowledge Flow Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Knowledge Flow Agent',
    'general',
    'learningforge-ai-knowledge-flow-agent',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Knowledge Flow Agent');


-- Insert missing agent:  (Field Safety Inspector)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Field Safety Inspector',
    'general',
    'learningforge-ai-field-safety-inspector',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Field Safety Inspector');


-- Insert missing agent:  (Construction Law Research Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Construction Law Research Agent',
    'general',
    'learningforge-ai-construction-law-research',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Construction Law Research Agent');


-- Insert missing agent:  (Knowledge Transparency Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Knowledge Transparency Agent',
    'general',
    'learningforge-ai-knowledge-transparency',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Knowledge Transparency Agent');


-- Insert missing agent:  (Contracts Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
    'Contracts Agent',
    'general',
    'learningforge-ai-contracts-agent',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Contracts Agent');


-- Insert missing agent:  (jordan-loopy-marketing-specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Loopy AI' LIMIT 1),
    'jordan-loopy-marketing-specialist',
    'general',
    'jordan-loopy-marketing-specialist',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'jordan-loopy-marketing-specialist');


-- Insert missing agent:  (alex-loopy-deep-research)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Loopy AI' LIMIT 1),
    'alex-loopy-deep-research',
    'general',
    'alex-loopy-deep-research',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'alex-loopy-deep-research');


-- Insert missing agent:  (sam-loopy-social-media-coordinator)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Loopy AI' LIMIT 1),
    'sam-loopy-social-media-coordinator',
    'general',
    'sam-loopy-social-media-coordinator',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'sam-loopy-social-media-coordinator');


-- Insert missing agent:  (Vision Loopy CEO - Loopy AI Chief Executive Officer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Loopy AI' LIMIT 1),
    'Vision Loopy CEO - Loopy AI Chief Executive Officer',
    'general',
    'vision-loopy-ceo',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Vision Loopy CEO - Loopy AI Chief Executive Officer');


-- Insert missing agent:  (maya-loopy-content-strategist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Loopy AI' LIMIT 1),
    'maya-loopy-content-strategist',
    'general',
    'maya-loopy-content-strategist',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'maya-loopy-content-strategist');


-- Insert missing agent:  (dev-loopy-technical-creative)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'Loopy AI' LIMIT 1),
    'dev-loopy-technical-creative',
    'general',
    'dev-loopy-technical-creative',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'dev-loopy-technical-creative');


-- Insert missing agent:  (Measurement Validation Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'Measurement Validation Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Measurement Validation Specialist');


-- Insert missing agent:  (Visual Overlay Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'Visual Overlay Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Visual Overlay Specialist');


-- Insert missing agent:  (MeasureForge AI Electrical QA Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'MeasureForge AI Electrical QA Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'MeasureForge AI Electrical QA Specialist');


-- Insert missing agent:  (SANS Standards Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'SANS Standards Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'SANS Standards Specialist');


-- Insert missing agent:  (ASAQS Standards Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'ASAQS Standards Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'ASAQS Standards Specialist');


-- Insert missing agent:  (Contract Tender Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'Contract Tender Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Contract Tender Specialist');


-- Insert missing agent:  (Order Generation Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'Order Generation Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Order Generation Specialist');


-- Insert missing agent:  (MeasureForge AI Electrical Measurement Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'MeasureForge AI Electrical Measurement Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'MeasureForge AI Electrical Measurement Specialist');


-- Insert missing agent:  (Contour Analysis Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'Contour Analysis Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Contour Analysis Specialist');


-- Insert missing agent:  (MEP Element Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'MEP Element Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'MEP Element Specialist');


-- Insert missing agent:  (MeasureForge AI Traffic Signal Compliance Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'MeasureForge AI Traffic Signal Compliance Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'MeasureForge AI Traffic Signal Compliance Specialist');


-- Insert missing agent:  (MeasureForge AI Traffic Signal Measurement Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'MeasureForge AI Traffic Signal Measurement Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'MeasureForge AI Traffic Signal Measurement Specialist');


-- Insert missing agent: measureforge-ai-architectural-element-specialist (Architectural Element Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'Architectural Element Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Architectural Element Specialist');


-- Insert missing agent:  (MeasureForge AI Electrical Compliance Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'MeasureForge AI Electrical Compliance Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'MeasureForge AI Electrical Compliance Specialist');


-- Insert missing agent: measureforge-ai-cost-estimation-specialist (Cost Estimation Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'Cost Estimation Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Cost Estimation Specialist');


-- Insert missing agent:  (Structural Element Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'Structural Element Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Structural Element Specialist');


-- Insert missing agent:  (Quantity Surveyor Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'Quantity Surveyor Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Quantity Surveyor Specialist');


-- Insert missing agent:  (Earthwork Calculation Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'Earthwork Calculation Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Earthwork Calculation Specialist');


-- Insert missing agent:  (AutoCAD Integration Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'AutoCAD Integration Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'AutoCAD Integration Specialist');


-- Insert missing agent: measureforge-ai-measurement-coordination-specialist (Measurement Coordination Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'Measurement Coordination Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Measurement Coordination Specialist');


-- Insert missing agent:  (CAD Measurement Orchestrator)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MeasureForge AI' LIMIT 1),
    'CAD Measurement Orchestrator',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'CAD Measurement Orchestrator');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MobileForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MobileForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MobileForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MobileForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MobileForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MobileForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MobileForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MobileForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MobileForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'MobileForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Data Integrator - Data Flow Management)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Data Integrator - Data Flow Management',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Data Integrator - Data Flow Management');


-- Insert missing agent:  (Issue Generator - AI-Powered Issue Creation)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Issue Generator - AI-Powered Issue Creation',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Issue Generator - AI-Powered Issue Creation');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Operations Director - Chief Operations Officer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Operations Director - Chief Operations Officer',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Operations Director - Chief Operations Officer');


-- Insert missing agent:  (Assignment Specialist - Intelligent Issue Routing)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Assignment Specialist - Intelligent Issue Routing',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Assignment Specialist - Intelligent Issue Routing');


-- Insert missing agent: paperclipforge-ai-database-crud-orchestrator (Configuration Settings)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Configuration Settings',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Configuration Settings');


-- Insert missing agent:  (Vera - Measurement Validation Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Vera - Measurement Validation Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Vera - Measurement Validation Specialist');


-- Insert missing agent:  (UI Uma)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'UI Uma',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'UI Uma');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Molly - Measurement Coordination Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Molly - Measurement Coordination Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Molly - Measurement Coordination Specialist');


-- Insert missing agent:  (API Manager - API Ecosystem Management)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'API Manager - API Ecosystem Management',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'API Manager - API Ecosystem Management');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Resource Manager - Resource Allocation & Optimization)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Resource Manager - Resource Allocation & Optimization',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Resource Manager - Resource Allocation & Optimization');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Quality Controller - Quality Assurance)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Quality Controller - Quality Assurance',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Quality Controller - Quality Assurance');


-- Insert missing agent:  (Recon - Agent Reconciliation Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Recon - Agent Reconciliation Specialist',
    'general',
    'paperclipforge-ai-agent-reconciler',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Recon - Agent Reconciliation Specialist');


-- Insert missing agent:  (Workflow Automator - Workflow Design & Automation)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Workflow Automator - Workflow Design & Automation',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Workflow Automator - Workflow Design & Automation');


-- Insert missing agent:  (Database Druid - Database Management and Optimization Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Database Druid - Database Management and Optimization Agent',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Database Druid - Database Management and Optimization Agent');


-- Insert missing agent:  (maya-loopy-content-strategist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'maya-loopy-content-strategist',
    'general',
    'maya-loopy-content-strategist',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'maya-loopy-content-strategist');


-- Insert missing agent: org-research-folder-creator (Scout - Org Research Folder Creator)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Scout - Org Research Folder Creator',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Scout - Org Research Folder Creator');


-- Insert missing agent:  (Analysis Andy)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Analysis Andy',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Analysis Andy');


-- Insert missing agent:  (Integration Architect - Chief Technology Officer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Integration Architect - Chief Technology Officer',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Integration Architect - Chief Technology Officer');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Issue Batch Importer Agent)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Issue Batch Importer Agent',
    'general',
    'issue-batch-importer-paperclipforge',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Issue Batch Importer Agent');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Project Coordinator - Project Lifecycle Management)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Project Coordinator - Project Lifecycle Management',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Project Coordinator - Project Lifecycle Management');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Vision Loopy CEO - Loopy AI Chief Executive Officer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Vision Loopy CEO - Loopy AI Chief Executive Officer',
    'general',
    'vision-loopy-ceo',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Vision Loopy CEO - Loopy AI Chief Executive Officer');


-- Insert missing agent:  (Stella - Measurement Standards Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Stella - Measurement Standards Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Stella - Measurement Standards Specialist');


-- Insert missing agent:  (Coordination Charlie)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Coordination Charlie',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Coordination Charlie');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Model Assignment Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Model Assignment Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Model Assignment Specialist');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Performance Monitor - Performance Tracking & Analytics)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Performance Monitor - Performance Tracking & Analytics',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Performance Monitor - Performance Tracking & Analytics');


-- Insert missing agent: paperclipforge-ai-atlas-agent-creator (Configuration Settings)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Configuration Settings',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Configuration Settings');


-- Insert missing agent:  (Project Maestro - Chief Executive Officer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Project Maestro - Chief Executive Officer',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Project Maestro - Chief Executive Officer');


-- Insert missing agent:  (Knowledge Integrator - Knowledge Integration)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Knowledge Integrator - Knowledge Integration',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Knowledge Integrator - Knowledge Integration');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Reporting Analyst - Analytics & Reporting)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Reporting Analyst - Analytics & Reporting',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Reporting Analyst - Analytics & Reporting');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (User Experience Coordinator - User Interaction Management)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'User Experience Coordinator - User Interaction Management',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'User Experience Coordinator - User Interaction Management');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Progress Tracker - Real-Time Monitoring)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Progress Tracker - Real-Time Monitoring',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Progress Tracker - Real-Time Monitoring');


-- Insert missing agent:  (Predictive Modeler - Predictive Analytics)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Predictive Modeler - Predictive Analytics',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Predictive Modeler - Predictive Analytics');


-- Insert missing agent:  (Risk Analyst - Risk Identification & Mitigation)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Risk Analyst - Risk Identification & Mitigation',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Risk Analyst - Risk Identification & Mitigation');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (tuner-promptforge-ab-testing)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'tuner-promptforge-ab-testing',
    'general',
    'tuner-promptforge-ab-testing',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'tuner-promptforge-ab-testing');


-- Insert missing agent:  (cascade-promptforge-workflow-designer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'cascade-promptforge-workflow-designer',
    'general',
    'cascade-promptforge-workflow-designer',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'cascade-promptforge-workflow-designer');


-- Insert missing agent:  (quantifier-promptforge-benchmarking)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'quantifier-promptforge-benchmarking',
    'general',
    'quantifier-promptforge-benchmarking',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'quantifier-promptforge-benchmarking');


-- Insert missing agent:  (analyzer-promptforge-prompt-analytics)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'analyzer-promptforge-prompt-analytics',
    'general',
    'analyzer-promptforge-prompt-analytics',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'analyzer-promptforge-prompt-analytics');


-- Insert missing agent:  (compliance-promptforge-regulatory-compliance)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'compliance-promptforge-regulatory-compliance',
    'general',
    'compliance-promptforge-regulatory-compliance',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'compliance-promptforge-regulatory-compliance');


-- Insert missing agent:  (scholar-promptforge-academic-research)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'scholar-promptforge-academic-research',
    'general',
    'scholar-promptforge-academic-research',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'scholar-promptforge-academic-research');


-- Insert missing agent:  (validator-promptforge-syntax-logic-validation)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'validator-promptforge-syntax-logic-validation',
    'general',
    'validator-promptforge-syntax-logic-validation',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'validator-promptforge-syntax-logic-validation');


-- Insert missing agent:  (integration-promptforge-cross-agent-compatibility)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'integration-promptforge-cross-agent-compatibility',
    'general',
    'integration-promptforge-cross-agent-compatibility',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'integration-promptforge-cross-agent-compatibility');


-- Insert missing agent:  (sage-promptforge-chief-architect)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'sage-promptforge-chief-architect',
    'general',
    'sage-promptforge-chief-architect',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'sage-promptforge-chief-architect');


-- Insert missing agent:  (archivist-promptforge-knowledge-management)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'archivist-promptforge-knowledge-management',
    'general',
    'archivist-promptforge-knowledge-management',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'archivist-promptforge-knowledge-management');


-- Insert missing agent:  (flowdesigner-promptforge-agent-handoff)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'flowdesigner-promptforge-agent-handoff',
    'general',
    'flowdesigner-promptforge-agent-handoff',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'flowdesigner-promptforge-agent-handoff');


-- Insert missing agent:  (predictor-promptforge-outcome-prediction)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'predictor-promptforge-outcome-prediction',
    'general',
    'predictor-promptforge-outcome-prediction',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'predictor-promptforge-outcome-prediction');


-- Insert missing agent:  (enhancer-promptforge-advanced-innovation)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'enhancer-promptforge-advanced-innovation',
    'general',
    'enhancer-promptforge-advanced-innovation',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'enhancer-promptforge-advanced-innovation');


-- Insert missing agent:  (statemaster-promptforge-state-management)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'statemaster-promptforge-state-management',
    'general',
    'statemaster-promptforge-state-management',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'statemaster-promptforge-state-management');


-- Insert missing agent:  (blueprint-promptforge-template-designer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'blueprint-promptforge-template-designer',
    'general',
    'blueprint-promptforge-template-designer',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'blueprint-promptforge-template-designer');


-- Insert missing agent:  (refiner-promptforge-version-control)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'refiner-promptforge-version-control',
    'general',
    'refiner-promptforge-version-control',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'refiner-promptforge-version-control');


-- Insert missing agent:  (explorer-promptforge-new-techniques)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'explorer-promptforge-new-techniques',
    'general',
    'explorer-promptforge-new-techniques',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'explorer-promptforge-new-techniques');


-- Insert missing agent:  (experimenter-promptforge-hypothesis-testing)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'experimenter-promptforge-hypothesis-testing',
    'general',
    'experimenter-promptforge-hypothesis-testing',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'experimenter-promptforge-hypothesis-testing');


-- Insert missing agent:  (harmonic-promptforge-orchestration-strategy)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'harmonic-promptforge-orchestration-strategy',
    'general',
    'harmonic-promptforge-orchestration-strategy',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'harmonic-promptforge-orchestration-strategy');


-- Insert missing agent:  (collaborator-promptforge-cross-company-knowledge-sharing)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'collaborator-promptforge-cross-company-knowledge-sharing',
    'general',
    'collaborator-promptforge-cross-company-knowledge-sharing',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'collaborator-promptforge-cross-company-knowledge-sharing');


-- Insert missing agent:  (clarity-promptforge-performance-optimization)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'clarity-promptforge-performance-optimization',
    'general',
    'clarity-promptforge-performance-optimization',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'clarity-promptforge-performance-optimization');


-- Insert missing agent:  (integrity-promptforge-ethical-ai)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'integrity-promptforge-ethical-ai',
    'general',
    'integrity-promptforge-ethical-ai',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'integrity-promptforge-ethical-ai');


-- Insert missing agent:  (specialist-promptforge-domain-adaptation)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
    'specialist-promptforge-domain-adaptation',
    'general',
    'specialist-promptforge-domain-adaptation',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'specialist-promptforge-domain-adaptation');


-- Insert missing agent:  (monitor-qualityforge-quality-monitor)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'monitor-qualityforge-quality-monitor',
    'general',
    'monitor-qualityforge-quality-monitor',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'monitor-qualityforge-quality-monitor');


-- Insert missing agent:  (tracer-qualityforge-execution-tracer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'tracer-qualityforge-execution-tracer',
    'general',
    'tracer-qualityforge-execution-tracer',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'tracer-qualityforge-execution-tracer');


-- Insert missing agent:  (integrator-Integration-specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'integrator-Integration-specialist',
    'general',
    'integrator-Integration-specialist',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'integrator-Integration-specialist');


-- Insert missing agent:  (guardian-qualityforge-quality-guardian)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'guardian-qualityforge-quality-guardian',
    'general',
    'guardian-qualityforge-quality-guardian',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'guardian-qualityforge-quality-guardian');


-- Insert missing agent:  (integration-Integration-testing)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'integration-Integration-testing',
    'general',
    'integration-Integration-testing',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'integration-Integration-testing');


-- Insert missing agent:  (profiler-Performance-profiler)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'profiler-Performance-profiler',
    'general',
    'profiler-Performance-profiler',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'profiler-Performance-profiler');


-- Insert missing agent:  (apex-qualityforge-ceo)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'apex-qualityforge-ceo',
    'general',
    'apex-qualityforge-ceo',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'apex-qualityforge-ceo');


-- Insert missing agent:  (resolver-qualityforge-issue-resolver)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'resolver-qualityforge-issue-resolver',
    'general',
    'resolver-qualityforge-issue-resolver',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'resolver-qualityforge-issue-resolver');


-- Insert missing agent:  (fixer-qualityforge-bug-fixing-specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'fixer-qualityforge-bug-fixing-specialist',
    'general',
    'fixer-qualityforge-bug-fixing-specialist',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'fixer-qualityforge-bug-fixing-specialist');


-- Insert missing agent:  (refactor-Refactoring-specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'refactor-Refactoring-specialist',
    'general',
    'refactor-Refactoring-specialist',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'refactor-Refactoring-specialist');


-- Insert missing agent:  (loadtester-qualityforge-scalability-testing)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'loadtester-qualityforge-scalability-testing',
    'general',
    'loadtester-qualityforge-scalability-testing',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'loadtester-qualityforge-scalability-testing');


-- Insert missing agent:  (coverage-qualityforge-test-coverage-analyst)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'coverage-qualityforge-test-coverage-analyst',
    'general',
    'coverage-qualityforge-test-coverage-analyst',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'coverage-qualityforge-test-coverage-analyst');


-- Insert missing agent:  (dbat-testing-qualityforge)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'dbat-testing-qualityforge',
    'general',
    'dbat-testing-qualityforge',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'dbat-testing-qualityforge');


-- Insert missing agent:  (maintainer-qualityforge-code-maintainer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'maintainer-qualityforge-code-maintainer',
    'general',
    'maintainer-qualityforge-code-maintainer',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'maintainer-qualityforge-code-maintainer');


-- Insert missing agent:  (documenter-qualityforge-documentation-specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'documenter-qualityforge-documentation-specialist',
    'general',
    'documenter-qualityforge-documentation-specialist',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'documenter-qualityforge-documentation-specialist');


-- Insert missing agent:  (code-analyzer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'code-analyzer',
    'general',
    'code-analyzer',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'code-analyzer');


-- Insert missing agent:  (validator-Validator)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'validator-Validator',
    'general',
    'validator-Validator',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'validator-Validator');


-- Insert missing agent:  (debugger-Debugger-specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'debugger-Debugger-specialist',
    'general',
    'debugger-Debugger-specialist',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'debugger-Debugger-specialist');


-- Insert missing agent:  (inspector-qualityforge-code-inspector)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'inspector-qualityforge-code-inspector',
    'general',
    'inspector-qualityforge-code-inspector',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'inspector-qualityforge-code-inspector');


-- Insert missing agent:  (optimizer-qualityforge-code-optimizer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'optimizer-qualityforge-code-optimizer',
    'general',
    'optimizer-qualityforge-code-optimizer',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'optimizer-qualityforge-code-optimizer');


-- Insert missing agent:  (performance-Performance-testing)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'performance-Performance-testing',
    'general',
    'performance-Performance-testing',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'performance-Performance-testing');


-- Insert missing agent:  (accessibility-Accessibility-testing)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'accessibility-Accessibility-testing',
    'general',
    'accessibility-Accessibility-testing',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'accessibility-Accessibility-testing');


-- Insert missing agent:  (Decision Support Specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'Decision Support Specialist',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Decision Support Specialist');


-- Insert missing agent:  (reporter-qualityforge-quality-reporter)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'reporter-qualityforge-quality-reporter',
    'general',
    'reporter-qualityforge-quality-reporter',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'reporter-qualityforge-quality-reporter');


-- Insert missing agent:  (load-Load-testing)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'load-Load-testing',
    'general',
    'load-Load-testing',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'load-Load-testing');


-- Insert missing agent:  (Assessment Criteria Manager)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'Assessment Criteria Manager',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Assessment Criteria Manager');


-- Insert missing agent:  (standards-Standards-enforcer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'standards-Standards-enforcer',
    'general',
    'standards-Standards-enforcer',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'standards-Standards-enforcer');


-- Insert missing agent:  (reviewer-qualityforge-code-reviewer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'reviewer-qualityforge-code-reviewer',
    'general',
    'reviewer-qualityforge-code-reviewer',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'reviewer-qualityforge-code-reviewer');


-- Insert missing agent:  (automation-qualityforge-test-automation)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'automation-qualityforge-test-automation',
    'general',
    'automation-qualityforge-test-automation',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'automation-qualityforge-test-automation');


-- Insert missing agent:  (e2e-qualityforge-end-to-end-testing)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'e2e-qualityforge-end-to-end-testing',
    'general',
    'e2e-qualityforge-end-to-end-testing',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'e2e-qualityforge-end-to-end-testing');


-- Insert missing agent:  (probe-qualityforge-prompt-testing)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'probe-qualityforge-prompt-testing',
    'general',
    'probe-qualityforge-prompt-testing',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'probe-qualityforge-prompt-testing');


-- Insert missing agent:  (codesmith-qualityforge-code-architect)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'codesmith-qualityforge-code-architect',
    'general',
    'codesmith-qualityforge-code-architect',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'codesmith-qualityforge-code-architect');


-- Insert missing agent:  (migrator-qualityforge-migration-specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'migrator-qualityforge-migration-specialist',
    'general',
    'migrator-qualityforge-migration-specialist',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'migrator-qualityforge-migration-specialist');


-- Insert missing agent:  (simulator-qualityforge-workflow-simulation)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'simulator-qualityforge-workflow-simulation',
    'general',
    'simulator-qualityforge-workflow-simulation',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'simulator-qualityforge-workflow-simulation');


-- Insert missing agent:  (trainer-qualityforge-quality-trainer)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'trainer-qualityforge-quality-trainer',
    'general',
    'trainer-qualityforge-quality-trainer',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'trainer-qualityforge-quality-trainer');


-- Insert missing agent:  (architect-qualityforge-system-architect)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'architect-qualityforge-system-architect',
    'general',
    'architect-qualityforge-system-architect',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'architect-qualityforge-system-architect');


-- Insert missing agent:  (diagnostics-Diagnostics-specialist)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'diagnostics-Diagnostics-specialist',
    'general',
    'diagnostics-Diagnostics-specialist',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'diagnostics-Diagnostics-specialist');


-- Insert missing agent:  (governor-qualityforge-quality-director)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'QualityForge AI' LIMIT 1),
    'governor-qualityforge-quality-director',
    'general',
    'governor-qualityforge-quality-director',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'governor-qualityforge-quality-director');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'SaaSForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'VoiceForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'VoiceForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'VoiceForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'VoiceForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'VoiceForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'VoiceForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'VoiceForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'VoiceForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'VoiceForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'VoiceForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'VoiceForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Insert missing agent:  (Dependency Manager - Dependency Tracking & Resolution)
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = 'VoiceForge AI' LIMIT 1),
    'Dependency Manager - Dependency Tracking & Resolution',
    'general',
    '',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Dependency Manager - Dependency Tracking & Resolution');


-- Generate API key for agent: Maya
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Maya' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_04115ac70f4882c3d3f37c0d4b1a930d926ab41da35a7b1f',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Maya' LIMIT 1)
);


-- Generate API key for agent: Atlas Sync
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Atlas Sync' LIMIT 1),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'default',
    'pcp_17b3bc4e5d1b5187bbba6460294857372037000dc1168b8e',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Atlas Sync' LIMIT 1)
);


-- Generate API key for agent: Andy
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Andy' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_08e111f2ca257c89ba99121548423ea0c0bd0de153ece446',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Andy' LIMIT 1)
);


-- Generate API key for agent: Dancer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Dancer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_c464add63691aa950180bc731c6ca32b736aa77ed90954c9',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Dancer' LIMIT 1)
);


-- Generate API key for agent: Charlie
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Charlie' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_9a6c638a3828fef2a57d5aa8e25dcc9547f3b38aa926bfe3',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Charlie' LIMIT 1)
);


-- Generate API key for agent: CRUD Commander

INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'CRUD Commander
' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_264565fb48b42bc0884b7a8039a5915cf9a2702532c14943',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'CRUD Commander
' LIMIT 1)
);


-- Generate API key for agent: sqlite-atlas-agent-creator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'sqlite-atlas-agent-creator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_9cadffc8cba5da870560f56b072c219db05a427bfe0f41df',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'sqlite-atlas-agent-creator' LIMIT 1)
);


-- Generate API key for agent: sqlite-druid
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'sqlite-druid' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_63372cb5f1f6e57bbd14db4ae6103a927cd47edd2f9dc835',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'sqlite-druid' LIMIT 1)
);


-- Generate API key for agent: Deployer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Deployer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_7b6f68fdbdc42392a3485fad949a1fb7d8ecb22a83affd18',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Deployer' LIMIT 1)
);


-- Generate API key for agent: Assessment Manager
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Assessment Manager' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_e86d8cc73cf4993390a1db682e14e7683200ae94ea0ca5d8',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Assessment Manager' LIMIT 1)
);


-- Generate API key for agent: Compliance Validator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Compliance Validator' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_d69b32b824fe8510fa8d741527fa3c97ca634be8e8c16d71',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Compliance Validator' LIMIT 1)
);


-- Generate API key for agent: DBAT Testing
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'DBAT Testing' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_22610a3aadc49beba2ef5370cc9b1ac00a4b74193ba0ed1a',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'DBAT Testing' LIMIT 1)
);


-- Generate API key for agent: Probe
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Probe' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_6ec6ea8175d5e87567a0668538582c07a39475b8db631562',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Probe' LIMIT 1)
);


-- Generate API key for agent: Simulator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Simulator' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_946986931f4ba8be0ede07df9d1186368b24e4c5e551b575',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Simulator' LIMIT 1)
);


-- Generate API key for agent: Sentinel
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Sentinel' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_e0f92c05ef954c2293cc0ac1d8b0f321b446ba394537ff62',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Sentinel' LIMIT 1)
);


-- Generate API key for agent: Loadtester
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Loadtester' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_1cb3acf97e9f0d9fde260149de982e26d705503c295694c2',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Loadtester' LIMIT 1)
);


-- Generate API key for agent: Decision Advisor
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Decision Advisor' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_cbe8fc79657189549a4d74b08300255b2babc90e0e6a4539',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Decision Advisor' LIMIT 1)
);


-- Generate API key for agent: Architect
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Architect' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_e3857a056e1e9ec735a1afe9d57b45cd548a463ef5139950',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Architect' LIMIT 1)
);


-- Generate API key for agent: Maven
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Maven' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_eea9dba090e83a8cdb36200764f1174a690bebf149c810c1',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Maven' LIMIT 1)
);


-- Generate API key for agent: Documentation Processor
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Documentation Processor' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_693753f6882799eb44b1cf19acf6689b8a07ab321b5e909e',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Documentation Processor' LIMIT 1)
);


-- Generate API key for agent: Ally
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Ally' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_ee5c6576f38dc0673ed5e77442b7e35b253f828d4bde879e',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Ally' LIMIT 1)
);


-- Generate API key for agent: Document Generation Specialist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Document Generation Specialist' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_c552c487282969b938fc5ecd4bba5db2b6dcbe0199dc2369',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Document Generation Specialist' LIMIT 1)
);


-- Generate API key for agent: Financial Validator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Financial Validator' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_f1a3ac692c0eb0db138861ee186a8a3ea748a6233a776156',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Financial Validator' LIMIT 1)
);


-- Generate API key for agent: Multi-Discipline Coordinator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Multi-Discipline Coordinator' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_38e601a8601ee7dd05a36fcfa57786e71a010846de6c158e',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Multi-Discipline Coordinator' LIMIT 1)
);


-- Generate API key for agent: Transaction Processor
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Transaction Processor' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_26b18da0c8cee5ba068f0f9c6d14c7ec192068532cbd629e',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Transaction Processor' LIMIT 1)
);


-- Generate API key for agent: Sage
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Sage' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_8f90d41b8d6fe8a0d5c07106478fd19fd3e766bddfeceef1',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Sage' LIMIT 1)
);


-- Generate API key for agent: Workflow Complexity Analyzer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Workflow Complexity Analyzer' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_d7d8cbf07e5379a04cb98088aa0b2d9eb9b9b3f152bba254',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Workflow Complexity Analyzer' LIMIT 1)
);


-- Generate API key for agent: Workflow Learning Coordinator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Workflow Learning Coordinator' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_f77713105c930fab4cedc1904e526787141f26a361c7e5bc',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Workflow Learning Coordinator' LIMIT 1)
);


-- Generate API key for agent: Uma
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Uma' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_e5308fc4592b20a5a10599d2538bfdf37fc65d0721986c91',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Uma' LIMIT 1)
);


-- Generate API key for agent: Audit
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Audit' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_4bf457eb1a599c8a579626c6d29bd44e9ba6ea5c5843b690',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Audit' LIMIT 1)
);


-- Generate API key for agent: Data Synchronization Manager
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Data Synchronization Manager' LIMIT 1),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'default',
    'pcp_26207cb30aaa2867918e6c46cd0ac031789324b3f84e90ec',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Data Synchronization Manager' LIMIT 1)
);


-- Generate API key for agent: Bridge
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_6ee4ecbd894016af910e00533b1bf3dc82e45ca9c5fdf2da',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Bridge' LIMIT 1)
);


-- Generate API key for agent: Scribe
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Scribe' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_7b0e0fafb05932dba305942018ce95bb9b317e24058dba89',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Scribe' LIMIT 1)
);


-- Generate API key for agent: Classy
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Classy' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_80db9879092da85ab84b01158d2f3f966777184ff219f5c7',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Classy' LIMIT 1)
);


-- Generate API key for agent: Security and Compliance Monitor
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Security and Compliance Monitor' LIMIT 1),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'default',
    'pcp_d182bb8b2794225bd6d9ae45ec3e3b2a815dfde9e3aaa23b',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Security and Compliance Monitor' LIMIT 1)
);


-- Generate API key for agent: Echo
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Echo' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_4fb342d4268f8fba535e06a1975ae399f0d813563ebe0286',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Echo' LIMIT 1)
);


-- Generate API key for agent: Chatter
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Chatter' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_34e2129b422246f09cdf0cefe5c91ab29f7b080f377e58e9',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Chatter' LIMIT 1)
);


-- Generate API key for agent: Finn
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Finn' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_57ea3477a02eaf26c0a0dc045971df8b578b19d04b10fb1a',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Finn' LIMIT 1)
);


-- Generate API key for agent: Specialist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_ac746c174b79711569eb63294b1c36eb2e68f0c82d0d3093',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1)
);


-- Generate API key for agent: Specialist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_5511ac1371012c388d0aaf425c2dae212fa8ed8d72609457',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1)
);


-- Generate API key for agent: Specialist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_68c8c3503b02f062fd1555c73d6ae581b9620bcb3735ac8a',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1)
);


-- Generate API key for agent: Documentarian
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Documentarian' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_cb1b11bd96f1d7173d60cee23684bdffaafe1a3ed1a237bc',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Documentarian' LIMIT 1)
);


-- Generate API key for agent: Architect
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Architect' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_52d626448a7103344246f4b8d246ba5fde33f8720a917774',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Architect' LIMIT 1)
);


-- Generate API key for agent: Generator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Generator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_930c1753438787442486e98ebe73d922c69af2c30c5efaa0',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Generator' LIMIT 1)
);


-- Generate API key for agent: Extractor
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Extractor' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_bc93bafe050488f3fc0da7037cc1dae8118ce78d23a847e0',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Extractor' LIMIT 1)
);


-- Generate API key for agent: Specialist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_9b8789c6c97768197860a80864b4a7a6d75b83486966c045',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1)
);


-- Generate API key for agent: Quantum
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Quantum' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_2a97580aadfc7d9f8221e725faaedcd560840aeff5e30b23',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Quantum' LIMIT 1)
);


-- Generate API key for agent: Folder creator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Folder creator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_47c27cad9b69c6c841b5c7e360d87be6befad880197734c3',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Folder creator' LIMIT 1)
);


-- Generate API key for agent: Bridge builder extraordinaire
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge builder extraordinaire' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_f30ce0c0834af68915a1895dadd4bd39b938d1162a736e34',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Bridge builder extraordinaire' LIMIT 1)
);


-- Generate API key for agent: Weaver
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Weaver' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_0410c8f4a0875e1bc1cff80ad550b9507b3ba5be60aa5ce6',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Weaver' LIMIT 1)
);


-- Generate API key for agent: Tinkerer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Tinkerer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_96f654f5c40132ed113a7875f59fdc58956a7c9a47d30b32',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Tinkerer' LIMIT 1)
);


-- Generate API key for agent: Enchantress
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Enchantress' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_46f716c89c1e78e9653beadc16b0cc5f311fc7342a7347df',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Enchantress' LIMIT 1)
);


-- Generate API key for agent: Illusionist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Illusionist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_1f8b575a37fac54cc55a31d54cc67e95b0b8550b2ec54713',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Illusionist' LIMIT 1)
);


-- Generate API key for agent: Administrator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Administrator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_02f2740558f92250d59bdcfbbaa4e871885250fed6c96971',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Administrator' LIMIT 1)
);


-- Generate API key for agent: Butler
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Butler' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_ea3ec085589eee3d8e5f00d083cff96a79ba8a9efeeedfc1',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Butler' LIMIT 1)
);


-- Generate API key for agent: Keeper
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Keeper' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_d1127068aacf26c240798e9833fccfcf38e9fed1951e474b',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Keeper' LIMIT 1)
);


-- Generate API key for agent: Champion
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Champion' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_783afa517fba6b79b9cdd366fd99d9881e365f582ef2083a',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Champion' LIMIT 1)
);


-- Generate API key for agent: Architect
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Architect' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_f6bfcb5685109d56a4f0e9fb4e9d1a3b90a6a5bfe02b0a0b',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Architect' LIMIT 1)
);


-- Generate API key for agent: Integrator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Integrator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_196494a02ce85c3399e8d6e6e0e794a0faf71c87b923856b',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Integrator' LIMIT 1)
);


-- Generate API key for agent: Druid
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Druid' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_f33afc2e90dc98520e9b2c8ce9f3a95ce2d9a3cd89e40fb8',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Druid' LIMIT 1)
);


-- Generate API key for agent: Manager
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Manager' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_f555083f91abc495a2ed5bf3a5ba05a20c5a49a55e1ad313',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Manager' LIMIT 1)
);


-- Generate API key for agent: Master
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Master' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_5792eb7015b426e04b6f8094b8539bb3fdd33da6b78d14a4',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Master' LIMIT 1)
);


-- Generate API key for agent: Navigator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Navigator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_752c741573b3bdf51ce9c5347ecde7e006412dab73831239',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Navigator' LIMIT 1)
);


-- Generate API key for agent: Monitor
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Monitor' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_7aadff28673e88dae2b954c3743f020777766d006532f74a',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Monitor' LIMIT 1)
);


-- Generate API key for agent: Profiler
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Profiler' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_8dea45c6fbe7bb2007ec5db6e3223aec5ea083bec8b98489',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Profiler' LIMIT 1)
);


-- Generate API key for agent: Modeler
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Modeler' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_753a60171d0c66eb68d3b695709888639653790dd1d33a2b',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Modeler' LIMIT 1)
);


-- Generate API key for agent: Tracker
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Tracker' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_62a55f66fa42d521785a85a31fc155e539669a2a45981a5c',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Tracker' LIMIT 1)
);


-- Generate API key for agent: Coordinator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Coordinator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_21098fe9035f3e88f233eab083afa21c8e8c2e6abe4eadd2',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Coordinator' LIMIT 1)
);


-- Generate API key for agent: Designer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Designer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_e33ad91ee425b8106eac6fc7674c7cce7f32358875ee480c',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Designer' LIMIT 1)
);


-- Generate API key for agent: Sage
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Sage' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_5c270f8746ec864caea8014cb14a3df800dea0c7ab836ef1',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Sage' LIMIT 1)
);


-- Generate API key for agent: Curator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Curator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_0e388b0c707fdce0b1c523f8c1388cea75cf07350cb23100',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Curator' LIMIT 1)
);


-- Generate API key for agent: Integrator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Integrator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_e819009966b2653bd2e4746022951d9904a59752c58b12f9',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Integrator' LIMIT 1)
);


-- Generate API key for agent: Harmony
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Harmony' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_2c1902aaa1c1deb2fa04aa7454c77360cc797b5cff1da9be',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Harmony' LIMIT 1)
);


-- Generate API key for agent: Analyst
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Analyst' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_55e48dbed8d4c4be35eeb646f2818dff2de5fe9fa62d4e4d',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Analyst' LIMIT 1)
);


-- Generate API key for agent: Maestro
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Maestro' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_f04773fd7b0b6c869a9b21bbc5126253c17ff4178f35be0c',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Maestro' LIMIT 1)
);


-- Generate API key for agent: Chainlink charmer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Chainlink charmer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_d16d13c7155b8939681361e87fad097ff100e05888c8233e',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Chainlink charmer' LIMIT 1)
);


-- Generate API key for agent: Zara
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Zara' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_02c53f675de30bd7995620e5370478fd481007fe69f0c678',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Zara' LIMIT 1)
);


-- Generate API key for agent: Nexus
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Nexus' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_ea24438c5d55f511da39e2ffd27ed886768e708ea3315ff8',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Nexus' LIMIT 1)
);


-- Generate API key for agent: Performance Optimization Specialist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Performance Optimization Specialist' LIMIT 1),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'default',
    'pcp_97edb2e6227829958864586f1ab67c2553aa07454af25c03',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Performance Optimization Specialist' LIMIT 1)
);


-- Generate API key for agent: API Integration Specialist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'API Integration Specialist' LIMIT 1),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'default',
    'pcp_b6c3c651815f26a1f97f3d1ec5b90f7fcb9d429f537b32b2',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'API Integration Specialist' LIMIT 1)
);


-- Generate API key for agent: Hal
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Hal' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_14099d807819959956c8aad90a220cff43893976d1c833dc',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Hal' LIMIT 1)
);


-- Generate API key for agent: Engine
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Engine' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_27b8f242b5951f8a2f441a4ce92ffaf65a966df9b765b6b3',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Engine' LIMIT 1)
);


-- Generate API key for agent: Zara
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Zara' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_2233baee365a642adcc8feb9b543593bb41baab2f85cda8a',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Zara' LIMIT 1)
);


-- Generate API key for agent: Ledger luck
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Ledger luck' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_229f1f9bef7ee3cee8521ace8bc7aad13d75dbc86f14626b',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Ledger luck' LIMIT 1)
);


-- Generate API key for agent: Judge
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Judge' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_e74f64ccf47bf86923aa36407ef431db4223ca4edffb972c',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Judge' LIMIT 1)
);


-- Create model assignment for agent: Maya
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Maya' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Maya' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Atlas Sync
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Atlas Sync' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Atlas Sync' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Andy
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Andy' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Andy' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Dancer
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Dancer' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Dancer' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Charlie
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Charlie' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Charlie' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Atlas Sync
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Atlas Sync' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Atlas Sync' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: CRUD Commander

INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'CRUD Commander
' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'CRUD Commander
' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: paperclipforge-ai-model-assignment-specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'paperclipforge-ai-model-assignment-specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'paperclipforge-ai-model-assignment-specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Database Operations Specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Database Operations Specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Database Operations Specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: sqlite-atlas-agent-creator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'sqlite-atlas-agent-creator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'sqlite-atlas-agent-creator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Luna
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Luna' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Luna' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: sqlite-druid
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'sqlite-druid' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'sqlite-druid' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Deployer
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Deployer' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Deployer' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Assessment Manager
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Assessment Manager' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Assessment Manager' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Compliance Validator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Compliance Validator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Compliance Validator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: DBAT Testing
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'DBAT Testing' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'DBAT Testing' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Probe
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Probe' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Probe' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Simulator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Simulator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Simulator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Sentinel
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Sentinel' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Sentinel' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Loadtester
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Loadtester' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Loadtester' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Documenter
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Documenter' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Documenter' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Decision Advisor
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Decision Advisor' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Decision Advisor' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Architect
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Architect' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Architect' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Maven
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Maven' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Maven' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Documentation Processor
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Documentation Processor' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Documentation Processor' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Ally
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Ally' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Ally' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Document Generation Specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Document Generation Specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Document Generation Specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Financial Validator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Financial Validator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Financial Validator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Multi-Discipline Coordinator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Multi-Discipline Coordinator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Multi-Discipline Coordinator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Transaction Processor
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Transaction Processor' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Transaction Processor' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Sage
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Sage' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Sage' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Workflow Complexity Analyzer
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Workflow Complexity Analyzer' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Workflow Complexity Analyzer' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Workflow Learning Coordinator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Workflow Learning Coordinator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Workflow Learning Coordinator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Blake
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Blake' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Blake' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: paperclipforge-ai-model-assignment-specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'paperclipforge-ai-model-assignment-specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'paperclipforge-ai-model-assignment-specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Ace
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Ace' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Ace' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: paperclipforge-ai-model-assignment-specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'paperclipforge-ai-model-assignment-specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'paperclipforge-ai-model-assignment-specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Uma
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Uma' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Uma' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Zara
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Zara' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Zara' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Audit
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Audit' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Audit' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Data Synchronization Manager
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Data Synchronization Manager' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Data Synchronization Manager' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Bridge
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Bridge' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Scribe
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Scribe' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Scribe' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Classy
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Classy' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Classy' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Hazel
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Hazel' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Hazel' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Ada
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Ada' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Ada' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Storm
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Storm' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Storm' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Drew
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Drew' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Drew' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Max
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Max' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Max' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Cash
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Cash' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Cash' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Security and Compliance Monitor
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Security and Compliance Monitor' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Security and Compliance Monitor' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Corey
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Corey' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Corey' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Decider
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Decider' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Decider' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Echo
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Echo' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Echo' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Terra
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Terra' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Terra' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Chatter
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Chatter' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Chatter' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Finn
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Finn' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Finn' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Phoenix
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Phoenix' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Phoenix' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Nova
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Nova' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Nova' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Manager
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Manager' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Manager' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Documentarian
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Documentarian' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Documentarian' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Architect
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Architect' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Architect' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Generator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Generator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Generator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Creator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Creator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Creator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Extractor
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Extractor' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Extractor' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Quantum
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Quantum' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Quantum' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Folder creator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Folder creator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Folder creator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Bridge builder extraordinaire
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Bridge builder extraordinaire' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Bridge builder extraordinaire' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Pipes the plumbing pro
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Pipes the plumbing pro' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Pipes the plumbing pro' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Github operations specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Github operations specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Github operations specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Workflow orchestrator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Workflow orchestrator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Workflow orchestrator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Coordination hub
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Coordination hub' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Coordination hub' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Orchestration engine
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Orchestration engine' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Orchestration engine' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Ginny
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Ginny' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Ginny' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Weaver
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Weaver' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Weaver' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Tinkerer
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Tinkerer' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Tinkerer' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Enchantress
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Enchantress' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Enchantress' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Illusionist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Illusionist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Illusionist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Administrator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Administrator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Administrator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Butler
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Butler' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Butler' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Keeper
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Keeper' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Keeper' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Champion
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Champion' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Champion' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Architect
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Architect' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Architect' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Integrator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Integrator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Integrator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Druid
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Druid' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Druid' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Manager
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Manager' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Manager' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Master
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Master' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Master' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Navigator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Navigator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Navigator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Monitor
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Monitor' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Monitor' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Profiler
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Profiler' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Profiler' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Modeler
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Modeler' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Modeler' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Tracker
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Tracker' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Tracker' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Coordinator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Coordinator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Coordinator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Maestro
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Maestro' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Maestro' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Analyst
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Analyst' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Analyst' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Render rosy
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Render rosy' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Render rosy' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Luna the coordination queen
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Luna the coordination queen' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Luna the coordination queen' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Designer
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Designer' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Designer' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Sage
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Sage' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Sage' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Curator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Curator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Curator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Integrator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Integrator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Integrator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Harmony
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Harmony' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Harmony' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Archie the building buddy
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Archie the building buddy' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Archie the building buddy' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Diggs the dirt dynamo
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Diggs the dirt dynamo' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Diggs the dirt dynamo' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Issue importer
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Issue importer' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Issue importer' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Agent monitor
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Agent monitor' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Agent monitor' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Lighty the signal sorcerer
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Lighty the signal sorcerer' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Lighty the signal sorcerer' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Flash the traffic flashmaster
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Flash the traffic flashmaster' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Flash the traffic flashmaster' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Caddy the cad commander
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Caddy the cad commander' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Caddy the cad commander' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Zap the qa wizard
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Zap the qa wizard' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Zap the qa wizard' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Analyst
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Analyst' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Analyst' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Maestro
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Maestro' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Maestro' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Chainlink charmer
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Chainlink charmer' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Chainlink charmer' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Checky the validation chief
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Checky the validation chief' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Checky the validation chief' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: System integrator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'System integrator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'System integrator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Vizzy the visual virtuoso
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Vizzy the visual virtuoso' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Vizzy the visual virtuoso' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Max the measurement maestro
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Max the measurement maestro' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Max the measurement maestro' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Zara
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Zara' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Zara' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Biddo the tender titan
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Biddo the tender titan' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Biddo the tender titan' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Nexus
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Nexus' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Nexus' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Performance Optimization Specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Performance Optimization Specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Performance Optimization Specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Manager
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Manager' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Manager' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: API Integration Specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'API Integration Specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'API Integration Specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Trix
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Trix' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Trix' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Sasha
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Sasha' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Sasha' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Coordination
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Coordination' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Coordination' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Hal
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Hal' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Hal' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Render ryan
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Render ryan' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Render ryan' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Engine
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Engine' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Engine' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Ziggy
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Ziggy' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Ziggy' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Zara
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Zara' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Zara' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Kai
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Kai' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Kai' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Coco
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Coco' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Coco' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Rex
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Rex' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Rex' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Cash the calculator king
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Cash the calculator king' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Cash the calculator king' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Sparky the safety sentinel
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Sparky the safety sentinel' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Sparky the safety sentinel' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Volty the voltage virtuoso
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Volty the voltage virtuoso' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Volty the voltage virtuoso' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Quinn the quantity queen
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Quinn the quantity queen' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Quinn the quantity queen' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Steel the structure sultan
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Steel the structure sultan' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Steel the structure sultan' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Orderly the order oracle
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Orderly the order oracle' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Orderly the order oracle' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Ruley the standards sultan
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Ruley the standards sultan' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Ruley the standards sultan' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Codey the compliance king
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Codey the compliance king' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Codey the compliance king' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Agent reconciliation specialist
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Agent reconciliation specialist' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Agent reconciliation specialist' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Nexus the visionary ceo
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Nexus the visionary ceo' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Nexus the visionary ceo' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Terra the topo titan
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Terra the topo titan' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Terra the topo titan' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Task allocator
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Task allocator' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Task allocator' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Ledger luck
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Ledger luck' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Ledger luck' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Wiley
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Wiley' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Wiley' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Pixel
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Pixel' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Pixel' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Stan
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Stan' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Stan' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Astro
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Astro' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Astro' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Eli
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Eli' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Eli' LIMIT 1)
    AND is_active = true
);


-- Create model assignment for agent: Judge
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Judge' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = 'Judge' LIMIT 1)
    AND is_active = true
);


-- Fix invalid name: paperclipforge-ai-model-assignment-specialist (Name >= 23 chars (45))
-- UPDATE agents SET name = 'paperclipforge-ai-mode' WHERE name = 'paperclipforge-ai-model-assignment-specialist';


-- Fix invalid name: Database Operations Specialist (Name >= 23 chars (30))
-- UPDATE agents SET name = 'Database Operations Sp' WHERE name = 'Database Operations Specialist';


-- Fix invalid name: sqlite-atlas-agent-creator (Name >= 23 chars (26))
-- UPDATE agents SET name = 'sqlite-atlas-agent-cre' WHERE name = 'sqlite-atlas-agent-creator';


-- Fix invalid name: Documentation Processor (Name >= 23 chars (23))
-- UPDATE agents SET name = 'Documentation Processo' WHERE name = 'Documentation Processor';


-- Fix invalid name: Document Generation Specialist (Name >= 23 chars (30))
-- UPDATE agents SET name = 'Document Generation Sp' WHERE name = 'Document Generation Specialist';


-- Fix invalid name: Multi-Discipline Coordinator (Name >= 23 chars (28))
-- UPDATE agents SET name = 'Multi-Discipline Coord' WHERE name = 'Multi-Discipline Coordinator';


-- Fix invalid name: Workflow Complexity Analyzer (Name >= 23 chars (28))
-- UPDATE agents SET name = 'Workflow Complexity An' WHERE name = 'Workflow Complexity Analyzer';


-- Fix invalid name: Workflow Learning Coordinator (Name >= 23 chars (29))
-- UPDATE agents SET name = 'Workflow Learning Coor' WHERE name = 'Workflow Learning Coordinator';


-- Fix invalid name: paperclipforge-ai-model-assignment-specialist (Name >= 23 chars (45))
-- UPDATE agents SET name = 'paperclipforge-ai-mode' WHERE name = 'paperclipforge-ai-model-assignment-specialist';


-- Fix invalid name: paperclipforge-ai-model-assignment-specialist (Name >= 23 chars (45))
-- UPDATE agents SET name = 'paperclipforge-ai-mode' WHERE name = 'paperclipforge-ai-model-assignment-specialist';


-- Fix invalid name: Data Synchronization Manager (Name >= 23 chars (28))
-- UPDATE agents SET name = 'Data Synchronization M' WHERE name = 'Data Synchronization Manager';


-- Fix invalid name: Security and Compliance Monitor (Name >= 23 chars (31))
-- UPDATE agents SET name = 'Security and Complianc' WHERE name = 'Security and Compliance Monitor';


-- Fix invalid name: Mobile workflow designer (Name >= 23 chars (24))
-- UPDATE agents SET name = 'Mobile workflow design' WHERE name = 'Mobile workflow designer';


-- Fix invalid name: Bridge builder extraordinaire (Name >= 23 chars (29))
-- UPDATE agents SET name = 'Bridge builder extraor' WHERE name = 'Bridge builder extraordinaire';


-- Fix invalid name: Github operations specialist (Name >= 23 chars (28))
-- UPDATE agents SET name = 'Github operations spec' WHERE name = 'Github operations specialist';


-- Fix invalid name: Landscaping domain specialist (Name >= 23 chars (29))
-- UPDATE agents SET name = 'Landscaping domain spe' WHERE name = 'Landscaping domain specialist';


-- Fix invalid name: Other parties domain specialist (Name >= 23 chars (31))
-- UPDATE agents SET name = 'Other parties domain s' WHERE name = 'Other parties domain specialist';


-- Fix invalid name: Logistics director domain specialist (Name >= 23 chars (36))
-- UPDATE agents SET name = 'Logistics director dom' WHERE name = 'Logistics director domain specialist';


-- Fix invalid name: Director project domain specialist (Name >= 23 chars (34))
-- UPDATE agents SET name = 'Director project domai' WHERE name = 'Director project domain specialist';


-- Fix invalid name: Luna the coordination queen (Name >= 23 chars (27))
-- UPDATE agents SET name = 'Luna the coordination ' WHERE name = 'Luna the coordination queen';


-- Fix invalid name: Archie the building buddy (Name >= 23 chars (25))
-- UPDATE agents SET name = 'Archie the building bu' WHERE name = 'Archie the building buddy';


-- Fix invalid name: Lighty the signal sorcerer (Name >= 23 chars (26))
-- UPDATE agents SET name = 'Lighty the signal sorc' WHERE name = 'Lighty the signal sorcerer';


-- Fix invalid name: Flash the traffic flashmaster (Name >= 23 chars (29))
-- UPDATE agents SET name = 'Flash the traffic flas' WHERE name = 'Flash the traffic flashmaster';


-- Fix invalid name: Caddy the cad commander (Name >= 23 chars (23))
-- UPDATE agents SET name = 'Caddy the cad commande' WHERE name = 'Caddy the cad commander';


-- Fix invalid name: Checky the validation chief (Name >= 23 chars (27))
-- UPDATE agents SET name = 'Checky the validation ' WHERE name = 'Checky the validation chief';


-- Fix invalid name: Vizzy the visual virtuoso (Name >= 23 chars (25))
-- UPDATE agents SET name = 'Vizzy the visual virtu' WHERE name = 'Vizzy the visual virtuoso';


-- Fix invalid name: Security domain specialist (Name >= 23 chars (26))
-- UPDATE agents SET name = 'Security domain specia' WHERE name = 'Security domain specialist';


-- Fix invalid name: Sales director domain specialist (Name >= 23 chars (32))
-- UPDATE agents SET name = 'Sales director domain ' WHERE name = 'Sales director domain specialist';


-- Fix invalid name: Max the measurement maestro (Name >= 23 chars (27))
-- UPDATE agents SET name = 'Max the measurement ma' WHERE name = 'Max the measurement maestro';


-- Fix invalid name: Public relations domain specialist (Name >= 23 chars (34))
-- UPDATE agents SET name = 'Public relations domai' WHERE name = 'Public relations domain specialist';


-- Fix invalid name: Quantity surveying domain specialist (Name >= 23 chars (36))
-- UPDATE agents SET name = 'Quantity surveying dom' WHERE name = 'Quantity surveying domain specialist';


-- Fix invalid name: Performance Optimization Specialist (Name >= 23 chars (35))
-- UPDATE agents SET name = 'Performance Optimizati' WHERE name = 'Performance Optimization Specialist';


-- Fix invalid name: API Integration Specialist (Name >= 23 chars (26))
-- UPDATE agents SET name = 'API Integration Specia' WHERE name = 'API Integration Specialist';


-- Fix invalid name: Discipline automation agent (Name >= 23 chars (27))
-- UPDATE agents SET name = 'Discipline automation ' WHERE name = 'Discipline automation agent';


-- Fix invalid name: Presentation specialist (Name >= 23 chars (23))
-- UPDATE agents SET name = 'Presentation specialis' WHERE name = 'Presentation specialist';


-- Fix invalid name: Inspection domain specialist (Name >= 23 chars (28))
-- UPDATE agents SET name = 'Inspection domain spec' WHERE name = 'Inspection domain specialist';


-- Fix invalid name: Contract administration (Name >= 23 chars (23))
-- UPDATE agents SET name = 'Contract administratio' WHERE name = 'Contract administration';


-- Fix invalid name: Scheduling domain specialist (Name >= 23 chars (28))
-- UPDATE agents SET name = 'Scheduling domain spec' WHERE name = 'Scheduling domain specialist';


-- Fix invalid name: Cash the calculator king (Name >= 23 chars (24))
-- UPDATE agents SET name = 'Cash the calculator ki' WHERE name = 'Cash the calculator king';


-- Fix invalid name: Project controls domain specialist (Name >= 23 chars (34))
-- UPDATE agents SET name = 'Project controls domai' WHERE name = 'Project controls domain specialist';


-- Fix invalid name: Process engineering domain specialist (Name >= 23 chars (37))
-- UPDATE agents SET name = 'Process engineering do' WHERE name = 'Process engineering domain specialist';


-- Fix invalid name: Sales domain specialist (Name >= 23 chars (23))
-- UPDATE agents SET name = 'Sales domain specialis' WHERE name = 'Sales domain specialist';


-- Fix invalid name: Health domain specialist (Name >= 23 chars (24))
-- UPDATE agents SET name = 'Health domain speciali' WHERE name = 'Health domain specialist';


-- Fix invalid name: Ethics domain specialist (Name >= 23 chars (24))
-- UPDATE agents SET name = 'Ethics domain speciali' WHERE name = 'Ethics domain specialist';


-- Fix invalid name: Contracts director domain specialist (Name >= 23 chars (36))
-- UPDATE agents SET name = 'Contracts director dom' WHERE name = 'Contracts director domain specialist';


-- Fix invalid name: Design domain specialist (Name >= 23 chars (24))
-- UPDATE agents SET name = 'Design domain speciali' WHERE name = 'Design domain specialist';


-- Fix invalid name: Hse director domain specialist (Name >= 23 chars (30))
-- UPDATE agents SET name = 'Hse director domain sp' WHERE name = 'Hse director domain specialist';


-- Fix invalid name: Sparky the safety sentinel (Name >= 23 chars (26))
-- UPDATE agents SET name = 'Sparky the safety sent' WHERE name = 'Sparky the safety sentinel';


-- Fix invalid name: Volty the voltage virtuoso (Name >= 23 chars (26))
-- UPDATE agents SET name = 'Volty the voltage virt' WHERE name = 'Volty the voltage virtuoso';


-- Fix invalid name: Quinn the quantity queen (Name >= 23 chars (24))
-- UPDATE agents SET name = 'Quinn the quantity que' WHERE name = 'Quinn the quantity queen';


-- Fix invalid name: Steel the structure sultan (Name >= 23 chars (26))
-- UPDATE agents SET name = 'Steel the structure su' WHERE name = 'Steel the structure sultan';


-- Fix invalid name: Orderly the order oracle (Name >= 23 chars (24))
-- UPDATE agents SET name = 'Orderly the order orac' WHERE name = 'Orderly the order oracle';


-- Fix invalid name: Ruley the standards sultan (Name >= 23 chars (26))
-- UPDATE agents SET name = 'Ruley the standards su' WHERE name = 'Ruley the standards sultan';


-- Fix invalid name: Codey the compliance king (Name >= 23 chars (25))
-- UPDATE agents SET name = 'Codey the compliance k' WHERE name = 'Codey the compliance king';


-- Fix invalid name: Agent reconciliation specialist (Name >= 23 chars (31))
-- UPDATE agents SET name = 'Agent reconciliation s' WHERE name = 'Agent reconciliation specialist';


-- Fix invalid name: Nexus the visionary ceo (Name >= 23 chars (23))
-- UPDATE agents SET name = 'Nexus the visionary ce' WHERE name = 'Nexus the visionary ceo';


-- Fix invalid name: Learning strategy agent (Name >= 23 chars (23))
-- UPDATE agents SET name = 'Learning strategy agen' WHERE name = 'Learning strategy agent';


-- Fix invalid name: Document control domain specialist (Name >= 23 chars (34))
-- UPDATE agents SET name = 'Document control domai' WHERE name = 'Document control domain specialist';


-- Fix invalid name: Directors domain specialist (Name >= 23 chars (27))
-- UPDATE agents SET name = 'Directors domain speci' WHERE name = 'Directors domain specialist';


-- Fix invalid name: Local content domain specialist (Name >= 23 chars (31))
-- UPDATE agents SET name = 'Local content domain s' WHERE name = 'Local content domain specialist';


-- Fix invalid name: Construction director domain specialist (Name >= 23 chars (39))
-- UPDATE agents SET name = 'Construction director ' WHERE name = 'Construction director domain specialist';


-- Fix invalid name: Construction engineering (Name >= 23 chars (24))
-- UPDATE agents SET name = 'Construction engineeri' WHERE name = 'Construction engineering';


-- Fix invalid name: Commercial domain specialist (Name >= 23 chars (28))
-- UPDATE agents SET name = 'Commercial domain spec' WHERE name = 'Commercial domain specialist';


-- Fix invalid name: Information technology domain specialist (Name >= 23 chars (40))
-- UPDATE agents SET name = 'Information technology' WHERE name = 'Information technology domain specialist';


-- Fix invalid name: Engineering director domain specialist (Name >= 23 chars (38))
-- UPDATE agents SET name = 'Engineering director d' WHERE name = 'Engineering director domain specialist';


-- Fix invalid name: Environmental domain specialist (Name >= 23 chars (31))
-- UPDATE agents SET name = 'Environmental domain s' WHERE name = 'Environmental domain specialist';


-- Fix invalid name: Procurement director domain specialist (Name >= 23 chars (38))
-- UPDATE agents SET name = 'Procurement director d' WHERE name = 'Procurement director domain specialist';


-- Fix invalid name: Chemical engineering domain specialist (Name >= 23 chars (38))
-- UPDATE agents SET name = 'Chemical engineering d' WHERE name = 'Chemical engineering domain specialist';


-- Fix invalid name: Finance director domain specialist (Name >= 23 chars (34))
-- UPDATE agents SET name = 'Finance director domai' WHERE name = 'Finance director domain specialist';


-- Fix invalid name: Sundry domain specialist (Name >= 23 chars (24))
-- UPDATE agents SET name = 'Sundry domain speciali' WHERE name = 'Sundry domain specialist';

