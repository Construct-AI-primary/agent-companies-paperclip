-- ============================================================
-- FRESH START RECONCILIATION
-- This script:
-- 1. Deletes all existing agents, API keys, and model assignments
-- 2. Re-inserts all agents from filesystem definitions
-- 3. Generates API keys for each agent
-- Generated: /Users/_test-20260416/paperclip-render/fresh_reconciliation.py
-- ============================================================


-- ============================================================
-- FK-AWARE DELETE ORDER FOR ALL AGENTS
-- Generated from: docs-paperclip/schema/FK table relationships.csv
-- ============================================================

BEGIN;

-- Phase 1: SET NULL for nullable FKs (won't block, safety first)
UPDATE agent_config_revisions SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents);
UPDATE company_secret_versions SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents);
UPDATE company_secrets SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents);
UPDATE document_revisions SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents);
UPDATE documents SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents);
UPDATE documents SET updated_by_agent_id = NULL WHERE updated_by_agent_id::text IN (SELECT id::text FROM agents);
UPDATE issue_approvals SET linked_by_agent_id = NULL WHERE linked_by_agent_id::text IN (SELECT id::text FROM agents);
UPDATE issue_relations SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents);
UPDATE routine_triggers SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents);
UPDATE routine_triggers SET updated_by_agent_id = NULL WHERE updated_by_agent_id::text IN (SELECT id::text FROM agents);
UPDATE routines SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents);
UPDATE routines SET updated_by_agent_id = NULL WHERE updated_by_agent_id::text IN (SELECT id::text FROM agents);
UPDATE workspace_runtime_services SET owner_agent_id = NULL WHERE owner_agent_id::text IN (SELECT id::text FROM agents);

-- Phase 2: Delete from tables referencing heartbeat_runs (deepest deps)
UPDATE document_revisions SET created_by_run_id = NULL WHERE created_by_run_id::text IN (SELECT hr.id::text FROM heartbeat_runs hr WHERE hr.agent_id::text IN (SELECT id::text FROM agents));
UPDATE issue_comments SET created_by_run_id = NULL WHERE created_by_run_id::text IN (SELECT hr.id::text FROM heartbeat_runs hr WHERE hr.agent_id::text IN (SELECT id::text FROM agents));
UPDATE issue_execution_decisions SET created_by_run_id = NULL WHERE created_by_run_id::text IN (SELECT hr.id::text FROM heartbeat_runs hr WHERE hr.agent_id::text IN (SELECT id::text FROM agents));
UPDATE issue_thread_interactions SET source_run_id = NULL WHERE source_run_id::text IN (SELECT hr.id::text FROM heartbeat_runs hr WHERE hr.agent_id::text IN (SELECT id::text FROM agents));
UPDATE issue_work_products SET created_by_run_id = NULL WHERE created_by_run_id::text IN (SELECT hr.id::text FROM heartbeat_runs hr WHERE hr.agent_id::text IN (SELECT id::text FROM agents));
UPDATE issues SET checkout_run_id = NULL WHERE checkout_run_id::text IN (SELECT hr.id::text FROM heartbeat_runs hr WHERE hr.agent_id::text IN (SELECT id::text FROM agents));
UPDATE issues SET execution_run_id = NULL WHERE execution_run_id::text IN (SELECT hr.id::text FROM heartbeat_runs hr WHERE hr.agent_id::text IN (SELECT id::text FROM agents));
UPDATE workspace_operations SET heartbeat_run_id = NULL WHERE heartbeat_run_id::text IN (SELECT hr.id::text FROM heartbeat_runs hr WHERE hr.agent_id::text IN (SELECT id::text FROM agents));
UPDATE workspace_runtime_services SET started_by_run_id = NULL WHERE started_by_run_id::text IN (SELECT hr.id::text FROM heartbeat_runs hr WHERE hr.agent_id::text IN (SELECT id::text FROM agents));
DELETE FROM activity_log WHERE run_id::text IN (
    SELECT hr.id::text FROM heartbeat_runs hr
    WHERE hr.agent_id::text IN (SELECT id::text FROM agents)
);
DELETE FROM agent_task_sessions WHERE last_run_id::text IN (
    SELECT hr.id::text FROM heartbeat_runs hr
    WHERE hr.agent_id::text IN (SELECT id::text FROM agents)
);
DELETE FROM cost_events WHERE heartbeat_run_id::text IN (
    SELECT hr.id::text FROM heartbeat_runs hr
    WHERE hr.agent_id::text IN (SELECT id::text FROM agents)
);
DELETE FROM finance_events WHERE heartbeat_run_id::text IN (
    SELECT hr.id::text FROM heartbeat_runs hr
    WHERE hr.agent_id::text IN (SELECT id::text FROM agents)
);
DELETE FROM heartbeat_run_events WHERE run_id::text IN (
    SELECT hr.id::text FROM heartbeat_runs hr
    WHERE hr.agent_id::text IN (SELECT id::text FROM agents)
);

-- Phase 3: Delete heartbeat_run_events
DELETE FROM heartbeat_run_events WHERE run_id::text IN (
    SELECT hr.id::text FROM heartbeat_runs hr
    WHERE hr.agent_id::text IN (SELECT id::text FROM agents)
);

-- Phase 4: Delete heartbeat_runs
DELETE FROM heartbeat_runs WHERE agent_id::text IN (SELECT id::text FROM agents);

-- Phase 5: Delete from agent operational tables (direct agent_id FKs)
DELETE FROM agent_task_sessions WHERE agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM agent_runtime_state WHERE agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM agent_wakeup_requests WHERE agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM agent_skill_assignments WHERE agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM agent_api_keys WHERE agent_id::text IN (SELECT id::text FROM agents);

-- Phase 6: Delete from all other tables referencing agents directly
DELETE FROM a_engineering_analysis WHERE created_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_engineering_audit_trail WHERE user_id::text IN (SELECT id::text FROM agents);
DELETE FROM a_engineering_models WHERE created_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_engineering_models WHERE updated_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_engineering_standards WHERE created_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_engineering_standards WHERE updated_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_engineering_templates WHERE created_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_engineering_templates WHERE updated_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_measurement_approvals WHERE approver_user::text IN (SELECT id::text FROM agents);
DELETE FROM a_measurement_approvals WHERE created_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_measurement_audit_trail WHERE user_id::text IN (SELECT id::text FROM agents);
DELETE FROM a_measurement_cad_integration WHERE created_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_measurement_cad_integration WHERE updated_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_measurement_data WHERE created_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_measurement_data WHERE updated_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_measurement_standards WHERE created_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_measurement_standards WHERE updated_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_measurement_templates WHERE created_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_measurement_templates WHERE updated_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_measurement_validation_rules WHERE created_by::text IN (SELECT id::text FROM agents);
DELETE FROM a_measurement_validation_rules WHERE updated_by::text IN (SELECT id::text FROM agents);
DELETE FROM activity_log WHERE agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM approval_comments WHERE author_agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM approvals WHERE requested_by_agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM assets WHERE created_by_agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM cost_events WHERE agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM finance_events WHERE agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM goals WHERE owner_agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM issue_comments WHERE author_agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM issue_execution_decisions WHERE actor_agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM issue_thread_interactions WHERE created_by_agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM issue_thread_interactions WHERE resolved_by_agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM issues WHERE assignee_agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM issues WHERE created_by_agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM join_requests WHERE created_agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM projects WHERE lead_agent_id::text IN (SELECT id::text FROM agents);
DELETE FROM routines WHERE assignee_agent_id::text IN (SELECT id::text FROM agents);

-- Phase 7: Clear self-referential reports_to FK
UPDATE agents SET reports_to = NULL;

-- Phase 8: Delete all agents
DELETE FROM agents;


-- ============================================================
-- Summary: 59 FKs to agents processed
--   SET NULL: 13
--   CASCADE:  1
--   NO ACTION: 44
--   Heartbeat_runs chain: 15 FKs
-- ============================================================

-- STEP 2: Insert agents from filesystem
-- ============================================================

-- Agent: SEO Strategist (contentforge-ai-seostrategist)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-SEOStrategist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'SEO Strategist',
    'general',
    'contentforge-ai-seostrategist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Link Builder (contentforge-ai-linkbuilder)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-LinkBuilder/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'Link Builder',
    'general',
    'contentforge-ai-linkbuilder',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Performance Optimizer (contentforge-ai-performanceoptimizer)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-PerformanceOptimizer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'Performance Optimizer',
    'general',
    'contentforge-ai-performanceoptimizer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Blog Architect (contentforge-ai-blogarchitect)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-BlogArchitect/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'Blog Architect',
    'general',
    'contentforge-ai-blogarchitect',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: TSS (contentforge-ai-technicalseo)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-TechnicalSEO/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'TSS',
    'general',
    'contentforge-ai-technicalseo',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Reporting Specialist (contentforge-ai-reportingspecialist)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-ReportingSpecialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'Reporting Specialist',
    'general',
    'contentforge-ai-reportingspecialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Content Maestro (contentforge-ai-contentmaestro)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-ContentMaestro/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'Content Maestro',
    'general',
    'contentforge-ai-contentmaestro',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Data Analyst (contentforge-ai-dataanalyst)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-DataAnalyst/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'Data Analyst',
    'general',
    'contentforge-ai-dataanalyst',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Local SEO Expert (contentforge-ai-localseoexpert)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-LocalSEOExpert/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'Local SEO Expert',
    'general',
    'contentforge-ai-localseoexpert',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: SEO Analyst (contentforge-ai-seoanalyst)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-SEOAnalyst/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'SEO Analyst',
    'general',
    'contentforge-ai-seoanalyst',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Conversion Specialist (contentforge-ai-conversionspecialist)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-ConversionSpecialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'Conversion Specialist',
    'general',
    'contentforge-ai-conversionspecialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Mobile Optimizer (contentforge-ai-mobileoptimizer)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-MobileOptimizer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'Mobile Optimizer',
    'general',
    'contentforge-ai-mobileoptimizer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Conversion Analyst (contentforge-ai-conversionanalyst)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-ConversionAnalyst/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'Conversion Analyst',
    'general',
    'contentforge-ai-conversionanalyst',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Email Composer (contentforge-ai-emailcomposer)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-EmailComposer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'Email Composer',
    'general',
    'contentforge-ai-emailcomposer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: E-CO (contentforge-ai-communicationorchestr)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-CommunicationOrchestr/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'E-CO',
    'general',
    'contentforge-ai-communicationorchestr',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: UX Designer (contentforge-ai-uxdesigner)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-UXDesigner/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'UX Designer',
    'general',
    'contentforge-ai-uxdesigner',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Social Strategist (contentforge-ai-socialstrategist)
-- File: docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-SocialStrategist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440008',
    'Social Strategist',
    'general',
    'contentforge-ai-socialstrategist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: ally-devforge-partners (ally-devforge-partnership-management)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Ally/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'ally-devforge-partners',
    'general',
    'ally-devforge-partnership-management',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: interface-devforge-api (interface-devforge-api-integration)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Interface/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'interface-devforge-api',
    'general',
    'interface-devforge-api-integration',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: vector-Vector-processi (vector-Vector-processing)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Vector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'vector-Vector-processi',
    'general',
    'vector-Vector-processing',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: voyager-devforge-marke (voyager-devforge-market-exploration)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Voyager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'voyager-devforge-marke',
    'general',
    'voyager-devforge-market-exploration',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: librarian-devforge-kno (librarian-devforge-knowledge-management)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Librarian/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'librarian-devforge-kno',
    'general',
    'librarian-devforge-knowledge-management',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: fixer-devforge-bug-fix (fixer-devforge-bug-fixing)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Troubleshooter/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'fixer-devforge-bug-fix',
    'general',
    'fixer-devforge-bug-fixing',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: forge-devforge-system- (forge-devforge-system-architecture)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Forge/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'forge-devforge-system-',
    'general',
    'forge-devforge-system-architecture',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: nexus-devforge-ceo (nexus-devforge-ceo)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Nexus/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'nexus-devforge-ceo',
    'general',
    'nexus-devforge-ceo',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: MC (devforge-ai-multidisciplinecoord)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-MultiDisciplineCoord/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'MC',
    'general',
    'devforge-ai-multidisciplinecoord',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: synth-Synthetic-data (synth-Synthetic-data)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Synth/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'synth-Synthetic-data',
    'general',
    'synth-Synthetic-data',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DGS (devforge-ai-documentgenerationsp)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-DocumentGenerationSp/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'DGS',
    'general',
    'devforge-ai-documentgenerationsp',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: archivist-devforge-kno (archivist-devforge-knowledge-security)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Archivist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'archivist-devforge-kno',
    'general',
    'archivist-devforge-knowledge-security',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: insight-devforge-busin (insight-devforge-business-intelligence)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Insight/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'insight-devforge-busin',
    'general',
    'insight-devforge-business-intelligence',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: sentinel-devforge-data (sentinel-devforge-data-quality-monitoring)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Sentinel/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'sentinel-devforge-data',
    'general',
    'sentinel-devforge-data-quality-monitoring',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: merchant-devforge-comm (merchant-devforge-commerce-operations)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Merchant/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'merchant-devforge-comm',
    'general',
    'merchant-devforge-commerce-operations',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: devcore-devforge-core- (devcore-devforge-core-development)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Devcore/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'devcore-devforge-core-',
    'general',
    'devcore-devforge-core-development',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Financial Validator (devforge-ai-financialvalidator)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-FinancialValidator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'Financial Validator',
    'general',
    'devforge-ai-financialvalidator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: cloudops-devforge-clou (cloudops-devforge-cloud-operations)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Cloudops/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'cloudops-devforge-clou',
    'general',
    'cloudops-devforge-cloud-operations',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: concierge-devforge-cus (concierge-devforge-customer-experience)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Concierge/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'concierge-devforge-cus',
    'general',
    'concierge-devforge-customer-experience',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: sentinelx-devforge-adv (sentinelx-devforge-advanced-monitoring)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Sentinelx/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'sentinelx-devforge-adv',
    'general',
    'sentinelx-devforge-advanced-monitoring',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: sql-query-devforge (sql-query-devforge)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-SqlQueryDevforge/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'sql-query-devforge',
    'general',
    'sql-query-devforge',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: schema-devforge-data-s (schema-devforge-data-schema-management)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Schema/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'schema-devforge-data-s',
    'general',
    'schema-devforge-data-schema-management',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: council-devforge-strat (council-devforge-strategic-decision-making)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Council/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'council-devforge-strat',
    'general',
    'council-devforge-strategic-decision-making',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: mentor-devforge-team-d (mentor-devforge-team-development)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Mentor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'mentor-devforge-team-d',
    'general',
    'mentor-devforge-team-development',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: dealmaker-devforge-sal (dealmaker-devforge-sales-negotiation)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Dealmaker/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'dealmaker-devforge-sal',
    'general',
    'dealmaker-devforge-sales-negotiation',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: S-WLC (devforge-ai-workflowlearningcoor)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-WorkflowLearningCoor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'S-WLC',
    'general',
    'devforge-ai-workflowlearningcoor',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: atlas-devforge-product (atlas-devforge-product-mapping)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Atlas/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'atlas-devforge-product',
    'general',
    'atlas-devforge-product-mapping',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: strategos-devforge-str (strategos-devforge-strategic-planning)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Strategos/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'strategos-devforge-str',
    'general',
    'strategos-devforge-strategic-planning',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: guardian-devforge-thre (guardian-devforge-threat-protection)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Guardian/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'guardian-devforge-thre',
    'general',
    'guardian-devforge-threat-protection',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: amplifier-devforge-mar (amplifier-devforge-marketing-promotion)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Amplifier/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'amplifier-devforge-mar',
    'general',
    'amplifier-devforge-marketing-promotion',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: nova-devforge-product- (nova-devforge-product-launches)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Nova/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'nova-devforge-product-',
    'general',
    'nova-devforge-product-launches',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: analyst-devforge-marke (analyst-devforge-market-analysis)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Analyst/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'analyst-devforge-marke',
    'general',
    'analyst-devforge-market-analysis',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: brandforge-devforge-br (brandforge-devforge-brand-development)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Brandforge/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'brandforge-devforge-br',
    'general',
    'brandforge-devforge-brand-development',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: pathfinder-devforge-op (pathfinder-devforge-opportunity-identification)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Pathfinder/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'pathfinder-devforge-op',
    'general',
    'pathfinder-devforge-opportunity-identification',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: catalyst-devforge-prod (catalyst-devforge-product-innovation)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Catalyst/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'catalyst-devforge-prod',
    'general',
    'catalyst-devforge-product-innovation',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: codesmith-devforge-bac (codesmith-devforge-backend-engineer)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Codesmith/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'codesmith-devforge-bac',
    'general',
    'codesmith-devforge-backend-engineer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: automata-devforge-auto (automata-devforge-automation-systems)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Automata/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'automata-devforge-auto',
    'general',
    'automata-devforge-automation-systems',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: storycraft-devforge-pr (storycraft-devforge-product-storytelling)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Storycraft/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'storycraft-devforge-pr',
    'general',
    'storycraft-devforge-product-storytelling',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: promptsmith-devforge-p (promptsmith-devforge-prompt-engineering)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Promptsmith/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'promptsmith-devforge-p',
    'general',
    'promptsmith-devforge-prompt-engineering',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: compass-devforge-direc (compass-devforge-direction-setting)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Compass/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'compass-devforge-direc',
    'general',
    'compass-devforge-direction-setting',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: navigator-devforge-dat (navigator-devforge-data-discovery)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Navigator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'navigator-devforge-dat',
    'general',
    'navigator-devforge-data-discovery',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: reviewer-devforge-code (reviewer-devforge-code-review-qa)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Reviewer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'reviewer-devforge-code',
    'general',
    'reviewer-devforge-code-review-qa',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: ambassador-devforge-br (ambassador-devforge-brand-representation)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Ambassador/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'ambassador-devforge-br',
    'general',
    'ambassador-devforge-brand-representation',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: gatekeeper-devforge-ac (gatekeeper-devforge-access-control)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Gatekeeper/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'gatekeeper-devforge-ac',
    'general',
    'gatekeeper-devforge-access-control',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Transaction Processor (devforge-ai-transactionprocessor)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-TransactionProcessor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'Transaction Processor',
    'general',
    'devforge-ai-transactionprocessor',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Q-WCA (devforge-ai-workflowcomplexityan)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-WorkflowComplexityAn/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'Q-WCA',
    'general',
    'devforge-ai-workflowcomplexityan',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: watchtower-devforge-se (watchtower-devforge-security-oversight)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Watchtower/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'watchtower-devforge-se',
    'general',
    'watchtower-devforge-security-oversight',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: oracle-devforge-predic (oracle-devforge-predictive-analytics)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Oracle/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'oracle-devforge-predic',
    'general',
    'oracle-devforge-predictive-analytics',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: auditor-devforge-secur (auditor-devforge-security-compliance)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Auditor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'auditor-devforge-secur',
    'general',
    'auditor-devforge-security-compliance',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: stream-devforge-data-s (stream-devforge-data-streaming)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Stream/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'stream-devforge-data-s',
    'general',
    'stream-devforge-data-streaming',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: dataforge-devforge-dat (dataforge-devforge-data-transformation)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Dataforge/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'dataforge-devforge-dat',
    'general',
    'dataforge-devforge-data-transformation',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: catalystx-devforge-mar (catalystx-devforge-market-disruption)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Catalystx/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'catalystx-devforge-mar',
    'general',
    'catalystx-devforge-market-disruption',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: scout-devforge-competi (scout-devforge-competitive-intelligence)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Scout/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'scout-devforge-competi',
    'general',
    'scout-devforge-competitive-intelligence',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: cartographer-devforge- (cartographer-devforge-product-roadmapping)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Cartographer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'cartographer-devforge-',
    'general',
    'cartographer-devforge-product-roadmapping',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: ledgerai-devforge-fina (ledgerai-devforge-financial-data)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Ledgerai/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'ledgerai-devforge-fina',
    'general',
    'ledgerai-devforge-financial-data',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: pulse-devforge-realtim (pulse-devforge-realtime-monitoring)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Pulse/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'pulse-devforge-realtim',
    'general',
    'pulse-devforge-realtime-monitoring',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: orion-devforge-orchest (orion-devforge-orchestrator)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Orion/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'orion-devforge-orchest',
    'general',
    'orion-devforge-orchestrator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: ledger-devforge-financ (ledger-devforge-financial-oversight)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Ledger/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'ledger-devforge-financ',
    'general',
    'ledger-devforge-financial-oversight',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: cortex-devforge-ai-rea (cortex-devforge-ai-reasoning)
-- File: docs-paperclip/companies/devforge-ai/agents/devforge-ai-Cortex/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'cortex-devforge-ai-rea',
    'general',
    'cortex-devforge-ai-reasoning',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-constructiondirector)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ConstructionDirector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-constructiondirector',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: procurement-domainforg (procurement-domainforge-procurement-contracts)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-procurement/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'procurement-domainforg',
    'general',
    'procurement-domainforge-procurement-contracts',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: council-domainforge-go (council-domainforge-governance-standards)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-CouncilCouncil/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'council-domainforge-go',
    'general',
    'council-domainforge-governance-standards',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: strategos-domainforge- (strategos-domainforge-strategic-planning)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-strategos/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'strategos-domainforge-',
    'general',
    'strategos-domainforge-strategic-planning',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-publicrelations)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-PublicRelations/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-publicrelations',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-design)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-design/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-design',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-financialcompliance)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-FinancialCompliance/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-financialcompliance',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: contract-administratio (contract-administration-domainforge-contract-administration)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ContractAdministratio/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'contract-administratio',
    'general',
    'contract-administration-domainforge-contract-administration',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-salesdirector)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-SalesDirector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-salesdirector',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-security)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-security/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-security',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-localcontent)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-LocalContent/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-localcontent',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-environmental)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-environmental/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-environmental',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: orion-domainforge-ceo (orion-domainforge-ceo)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-orion/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'orion-domainforge-ceo',
    'general',
    'orion-domainforge-ceo',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-landscaping)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-landscaping/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-landscaping',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-counselspecialist)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-CounselSpecialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-counselspecialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: procurement-strategy-d (procurement-strategy-domainforge-procurement-strategy)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ProcurementStrategy/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'procurement-strategy-d',
    'general',
    'procurement-strategy-domainforge-procurement-strategy',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: contract-administratio (contract-administration-domainforge-contract-administration)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ContractAdmin/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'contract-administratio',
    'general',
    'contract-administration-domainforge-contract-administration',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-otherparties)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-OtherParties/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-otherparties',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: structural-domainforge (structural-domainforge-structural-engineering)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-domainforgeaiStructu/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'structural-domainforge',
    'general',
    'structural-domainforge-structural-engineering',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-hsedirector)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-HseDirector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-hsedirector',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-mobileworkflowdesign)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-MobileWorkflowDesign/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-mobileworkflowdesign',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: finance-domainforge-fi (finance-domainforge-finance-cost-management)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-FinanceFinance/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'finance-domainforge-fi',
    'general',
    'finance-domainforge-finance-cost-management',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: civil-domainforge-civi (civil-domainforge-civil-engineering)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-civil/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'civil-domainforge-civi',
    'general',
    'civil-domainforge-civil-engineering',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-sales)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-sales/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-sales',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-buyerspecialist)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-BuyerSpecialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-buyerspecialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-contractsdirector)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ContractsDirector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-contractsdirector',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: civil-domainforge-civi (civil-domainforge-civil-engineering)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-domainforgeaiCivil/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'civil-domainforge-civi',
    'general',
    'civil-domainforge-civil-engineering',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-projectcontrols)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ProjectControls/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-projectcontrols',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-inspection)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-inspection/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-inspection',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: safety-domainforge-saf (safety-domainforge-safety-risk-management)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-SafetySafety/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'safety-domainforge-saf',
    'general',
    'safety-domainforge-safety-risk-management',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-sundry)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-sundry/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-sundry',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-health)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-health/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-health',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-transportation)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-transportation/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-transportation',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: quality-assurance-doma (quality-assurance-domainforge-quality-assurance)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-QualityAssuranceQual/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'quality-assurance-doma',
    'general',
    'quality-assurance-domainforge-quality-assurance',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: quality-control-domain (quality-control-domainforge-quality-control)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-QualityControlQualit/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'quality-control-domain',
    'general',
    'quality-control-domainforge-quality-control',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: procurement-analytics- (procurement-analytics-domainforge-procurement-analytics)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ProcurementAnalytics/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'procurement-analytics-',
    'general',
    'procurement-analytics-domainforge-procurement-analytics',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-evaluator)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-evaluator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-evaluator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-engineeringdirector)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-EngineeringDirector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-engineeringdirector',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: strategos-domainforge- (strategos-domainforge-strategic-planning)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-domainforgeaiStrateg/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'strategos-domainforge-',
    'general',
    'strategos-domainforge-strategic-planning',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-chemicalengineering)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ChemicalEngineering/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-chemicalengineering',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-architecturalintegrat)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ArchitecturalIntegrat/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-architecturalintegrat',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: council-domainforge-go (council-domainforge-governance-standards)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-council/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'council-domainforge-go',
    'general',
    'council-domainforge-governance-standards',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-contractspreaward)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ContractsPreAward/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-contractspreaward',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-guardian2)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-Guardian2/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-guardian2',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-logisticsdirector)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-LogisticsDirector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-logisticsdirector',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-processengineering)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ProcessEngineering/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-processengineering',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: finance-domainforge-fi (finance-domainforge-finance-cost-management)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-finance/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'finance-domainforge-fi',
    'general',
    'finance-domainforge-finance-cost-management',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: logistics-domainforge- (logistics-domainforge-supply-chain)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-logistics/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'logistics-domainforge-',
    'general',
    'logistics-domainforge-supply-chain',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-financedirector)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-FinanceDirector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-financedirector',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: structural-domainforge (structural-domainforge-structural-engineering)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-StructuralEngineer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'structural-domainforge',
    'general',
    'structural-domainforge-structural-engineering',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: procurement-domainforg (procurement-domainforge-procurement-contracts)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-domainforgeaiProcure/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'procurement-domainforg',
    'general',
    'procurement-domainforge-procurement-contracts',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-ethics)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ethics/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-ethics',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-inspectorspecialist)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-InspectorSpecialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-inspectorspecialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-directors)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-directors/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-directors',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-scrutineer)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-scrutineer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-scrutineer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-contractspostaward)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ContractsPostAward/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-contractspostaward',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: construction-engineeri (construction-engineering-domainforge-construction-engineering)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ConstructionEng/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'construction-engineeri',
    'general',
    'construction-engineering-domainforge-construction-engineering',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-commercial)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-commercial/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-commercial',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-treasurer2)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-Treasurer2/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-treasurer2',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: legal-domainforge-lega (legal-domainforge-legal-regulatory-compliance)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-legal/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'legal-domainforge-lega',
    'general',
    'legal-domainforge-legal-regulatory-compliance',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-mobiletesting)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-MobileTesting/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-mobiletesting',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: orion-domainforge-ceo (orion-domainforge-ceo)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-domainforgeaiOriondo/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'orion-domainforge-ceo',
    'general',
    'orion-domainforge-ceo',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-dispatcherspecialist)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-DispatcherSpecialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-dispatcherspecialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: quality-assurance-doma (quality-assurance-domainforge-quality-assurance)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-QualityAssurance/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'quality-assurance-doma',
    'general',
    'quality-assurance-domainforge-quality-assurance',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: safety-domainforge-saf (safety-domainforge-safety-risk-management)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-SafetyOfficer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'safety-domainforge-saf',
    'general',
    'safety-domainforge-safety-risk-management',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-mechanicalengineering)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-MechanicalEngineering/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-mechanicalengineering',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: geotechnical-domainfor (geotechnical-domainforge-geotechnical-engineering)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-geotechnical/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'geotechnical-domainfor',
    'general',
    'geotechnical-domainforge-geotechnical-engineering',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-directorproject)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-DirectorProject/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-directorproject',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: quality-control-domain (quality-control-domainforge-quality-control)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-QualityControl/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'quality-control-domain',
    'general',
    'quality-control-domainforge-quality-control',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-architectural)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-architectural/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-architectural',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-documentcontrol)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-DocumentControl/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-documentcontrol',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-electricalengineering)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ElectricalEngineering/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-electricalengineering',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-informationtechnology)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-InformationTechnology/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-informationtechnology',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-suppliermanagement)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-SupplierManagement/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-suppliermanagement',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-quantitysurveying)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-QuantitySurveying/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-quantitysurveying',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-scheduling)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-scheduling/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-scheduling',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (domainforge-ai-procurementdirector)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ProcurementDirector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'DM-DT&R',
    'general',
    'domainforge-ai-procurementdirector',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: geotechnical-domainfor (geotechnical-domainforge-geotechnical-engineering)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-geotechnical/domainforge-ai-GeotechnicalGeotechni/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'geotechnical-domainfor',
    'general',
    'geotechnical-domainforge-geotechnical-engineering',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: legal-domainforge-lega (legal-domainforge-legal-regulatory-compliance)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-legal/domainforge-ai-LegalLegal/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'legal-domainforge-lega',
    'general',
    'legal-domainforge-legal-regulatory-compliance',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: construction-engineeri (construction-engineering-domainforge-construction-engineering)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ConstructionEng/domainforge-ai-ConstructionEng/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'construction-engineeri',
    'general',
    'construction-engineering-domainforge-construction-engineering',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: procurement-strategy-d (procurement-strategy-domainforge-procurement-strategy)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-domainforgeaiProcure/domainforge-ai-ProcurementStrategy/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'procurement-strategy-d',
    'general',
    'procurement-strategy-domainforge-procurement-strategy',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: procurement-analytics- (procurement-analytics-domainforge-procurement-analytics)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-domainforgeaiProcure/domainforge-ai-ProcurementAnalytics/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'procurement-analytics-',
    'general',
    'procurement-analytics-domainforge-procurement-analytics',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: logistics-domainforge- (logistics-domainforge-supply-chain)
-- File: docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-logistics/domainforge-ai-LogisticsLogistics/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'logistics-domainforge-',
    'general',
    'logistics-domainforge-supply-chain',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-taskcoordinator)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-TaskCoordinator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-taskcoordinator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-securityspecialist)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-SecuritySpecialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-securityspecialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: maya-loopy-content-str (maya-loopy-content-strategist)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-MayaLoopyContentStr/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'maya-loopy-content-str',
    'general',
    'maya-loopy-content-strategist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: VLC-LACEO (vision-loopy-ceo)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-VisionLoopyCeo/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'VLC-LACEO',
    'general',
    'vision-loopy-ceo',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-presentationspecialis)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-PresentationSpecialis/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-presentationspecialis',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-intelligenceanalyst)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-IntelligenceAnalyst/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-intelligenceanalyst',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-systemsintegrator)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-SystemsIntegrator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-systemsintegrator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-datamanager)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-DataManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-datamanager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-performanceanalyst)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-PerformanceAnalyst/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-performanceanalyst',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-automationengineer)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-AutomationEngineer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-automationengineer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-communicationsmanager)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-CommunicationsManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-communicationsmanager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-knowledgecurator)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-KnowledgeCurator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-knowledgecurator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-strategicadvisor)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-StrategicAdvisor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-strategicadvisor',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-researchassistant)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-ResearchAssistant/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-researchassistant',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-workflowoptimizer)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-WorkflowOptimizer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-workflowoptimizer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-scheduler)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-Scheduler/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-scheduler',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-personalassistant)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-PersonalAssistant/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-personalassistant',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (execforge-ai-chiefofstaff)
-- File: docs-paperclip/companies/execforge-ai/agents/execforge-ai-ChiefofStaff/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440010',
    'DM-DT&R',
    'general',
    'execforge-ai-chiefofstaff',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: N-SDS (infraforge-ai-nimbussupabase)
-- File: docs-paperclip/companies/infraforge-ai/agents/infraforge-ai-NimbusSupabase/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'N-SDS',
    'general',
    'infraforge-ai-nimbussupabase',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: RDS (render-deployment-specialist)
-- File: docs-paperclip/companies/infraforge-ai/agents/infraforge-ai-RenderDeployment/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'RDS',
    'general',
    'render-deployment-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DIA (database-infraforge-database-infrastructure)
-- File: docs-paperclip/companies/infraforge-ai/agents/infraforge-ai-DatabaseInfrastructur/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'DIA',
    'general',
    'database-infraforge-database-infrastructure',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: orchestrator-infraforg (orchestrator-infraforge-ceo)
-- File: docs-paperclip/companies/infraforge-ai/agents/infraforge-ai-orchestrator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'orchestrator-infraforg',
    'general',
    'orchestrator-infraforge-ceo',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: supply-chain-integrati (supply-chain-integration-infraforge-supply-chain)
-- File: docs-paperclip/companies/infraforge-ai/agents/infraforge-ai-SupplyChain/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'supply-chain-integrati',
    'general',
    'supply-chain-integration-infraforge-supply-chain',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: postgres-infraforge (postgres-infraforge)
-- File: docs-paperclip/companies/infraforge-ai/agents/infraforge-ai-postgres/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'postgres-infraforge',
    'general',
    'postgres-infraforge',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: mobile-api-infraforge- (mobile-api-infraforge-mobile-api-integration)
-- File: docs-paperclip/companies/infraforge-ai/agents/infraforge-ai-MobileApiIntegration/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'mobile-api-infraforge-',
    'general',
    'mobile-api-infraforge-mobile-api-integration',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-cococandy)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-CocoCandy/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-cococandy',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-hazelhecras)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-HazelHecras/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-hazelhecras',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-astroasta)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-AstroAsta/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-astroasta',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-wileyprojectwise)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-WileyProjectwise/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-wileyprojectwise',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-aceaconex)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-AceAconex/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-aceaconex',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-terracivil3d)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-TerraCivil3d/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-terracivil3d',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-novanavisworks)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-NovaNavisworks/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-novanavisworks',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-stormswmm)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-StormSwmm/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-stormswmm',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-blakebuildsoft)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-BlakeBuildsoft/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-blakebuildsoft',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-elietabs)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-EliEtabs/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-elietabs',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-rexrevit)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-RexRevit/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-rexrevit',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-sashasharepoint)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-SashaSharepoint/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-sashasharepoint',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-phoenixp6)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-PhoenixP6/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-phoenixp6',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-stanstaad)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-StanStaad/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-stanstaad',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-coreyprocore)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-CoreyProcore/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-coreyprocore',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-cashcostx)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-CashCostx/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-cashcostx',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-adaautocad)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-AdaAutocad/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-adaautocad',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-pixelbim360)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-PixelBim360/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-pixelbim360',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-ziggyorchestrator)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-ZiggyOrchestrator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-ziggyorchestrator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-trixtrimble)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-TrixTrimble/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-trixtrimble',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (integrateforge-ai-maxmsproject)
-- File: docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-MaxMsproject/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',
    'DM-DT&R',
    'general',
    'integrateforge-ai-maxmsproject',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Directors (knowledgeforge-ai-directors)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-directors/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Directors',
    'general',
    'knowledgeforge-ai-directors',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: A-p (knowledgeforge-ai-administrator)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-administrator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'A-p',
    'general',
    'knowledgeforge-ai-administrator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Generalist (knowledgeforge-ai-generalist)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-generalist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Generalist',
    'general',
    'knowledgeforge-ai-generalist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Negotiator (knowledgeforge-ai-negotiator)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-negotiator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Negotiator',
    'general',
    'knowledgeforge-ai-negotiator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Specialist (knowledgeforge-ai-specialist)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-specialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Specialist',
    'general',
    'knowledgeforge-ai-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Sentinel (knowledgeforge-ai-sentinel)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-sentinel/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Sentinel',
    'general',
    'knowledgeforge-ai-sentinel',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Physician (knowledgeforge-ai-physician)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-physician/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Physician',
    'general',
    'knowledgeforge-ai-physician',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Constructor (knowledgeforge-ai-constructor)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-constructor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Constructor',
    'general',
    'knowledgeforge-ai-constructor',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Geologist (knowledgeforge-ai-geologist)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-geologist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Geologist',
    'general',
    'knowledgeforge-ai-geologist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Co-ordinator (knowledgeforge-ai-controller)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-controller/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Co-ordinator',
    'general',
    'knowledgeforge-ai-controller',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Designer (knowledgeforge-ai-designer)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-designer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Designer',
    'general',
    'knowledgeforge-ai-designer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Salesperson (knowledgeforge-ai-salesperson)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-salesperson/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Salesperson',
    'general',
    'knowledgeforge-ai-salesperson',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Technician (knowledgeforge-ai-technician)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-technician/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Technician',
    'general',
    'knowledgeforge-ai-technician',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Chemist (knowledgeforge-ai-chemist)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-chemist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Chemist',
    'general',
    'knowledgeforge-ai-chemist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Guardian (knowledgeforge-ai-guardian)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-guardian/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Guardian',
    'general',
    'knowledgeforge-ai-guardian',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Builder (knowledgeforge-ai-builder)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-builder/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Builder',
    'general',
    'knowledgeforge-ai-builder',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Merchant (knowledgeforge-ai-merchant)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-merchant/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Merchant',
    'general',
    'knowledgeforge-ai-merchant',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Inetrmediary (knowledgeforge-ai-inetrmediary)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-inetrmediary/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Inetrmediary',
    'general',
    'knowledgeforge-ai-inetrmediary',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Leader (knowledgeforge-ai-leader)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-leader/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Leader',
    'general',
    'knowledgeforge-ai-leader',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Engineer (knowledgeforge-ai-engineer)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-engineer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Engineer',
    'general',
    'knowledgeforge-ai-engineer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Communicator (knowledgeforge-ai-communicator)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-communicator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Communicator',
    'general',
    'knowledgeforge-ai-communicator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Treasurer (knowledgeforge-ai-treasurer)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Treasurer',
    'general',
    'knowledgeforge-ai-treasurer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Environmentalist (knowledgeforge-ai-environmentalist)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-environmentalist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Environmentalist',
    'general',
    'knowledgeforge-ai-environmentalist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Counsel (knowledgeforge-ai-counsel)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-counsel/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Counsel',
    'general',
    'knowledgeforge-ai-counsel',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Buyer (knowledgeforge-ai-buyer)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-buyer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Buyer',
    'general',
    'knowledgeforge-ai-buyer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Scheduler (knowledgeforge-ai-scheduler)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-scheduler/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Scheduler',
    'general',
    'knowledgeforge-ai-scheduler',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Examiner (knowledgeforge-ai-examiner)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-examiner/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Examiner',
    'general',
    'knowledgeforge-ai-examiner',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Ethicist (knowledgeforge-ai-ethicist)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-ethicist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Ethicist',
    'general',
    'knowledgeforge-ai-ethicist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Landscaper (knowledgeforge-ai-landscaper)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-landscaper/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Landscaper',
    'general',
    'knowledgeforge-ai-landscaper',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Greeter (knowledgeforge-ai-greeter)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-greeter/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Greeter',
    'general',
    'knowledgeforge-ai-greeter',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Chairman (knowledgeforge-ai-chairman)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-chairman/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Chairman',
    'general',
    'knowledgeforge-ai-chairman',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Critic (knowledgeforge-ai-critic)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-critic/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Critic',
    'general',
    'knowledgeforge-ai-critic',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Concierge (knowledgeforge-ai-concierge)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-concierge/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Concierge',
    'general',
    'knowledgeforge-ai-concierge',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Governor (knowledgeforge-ai-governor)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-governor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Governor',
    'general',
    'knowledgeforge-ai-governor',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Optimizer (knowledgeforge-ai-optimizer)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-optimizer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Optimizer',
    'general',
    'knowledgeforge-ai-optimizer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: AmbiguityPrime (knowledgeforge-ai-ambiguityprime)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-ambiguityprime/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'AmbiguityPrime',
    'general',
    'knowledgeforge-ai-ambiguityprime',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Gatekeeper (knowledgeforge-ai-gatekeeper)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-gatekeeper/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Gatekeeper',
    'general',
    'knowledgeforge-ai-gatekeeper',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Inspector (knowledgeforge-ai-inspector)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-inspector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Inspector',
    'general',
    'knowledgeforge-ai-inspector',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Archivist (knowledgeforge-ai-archivist)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-archivist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Archivist',
    'general',
    'knowledgeforge-ai-archivist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Surveyor (knowledgeforge-ai-surveyor)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-surveyor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Surveyor',
    'general',
    'knowledgeforge-ai-surveyor',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Developer (knowledgeforge-ai-developer)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-developer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Developer',
    'general',
    'knowledgeforge-ai-developer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Electrician (knowledgeforge-ai-electrician)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-electrician/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Electrician',
    'general',
    'knowledgeforge-ai-electrician',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Dispatcher (knowledgeforge-ai-dispatcher)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-dispatcher/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Dispatcher',
    'general',
    'knowledgeforge-ai-dispatcher',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Co-ordinator (knowledgeforge-ai-coordinator)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-CoOrdinator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Co-ordinator',
    'general',
    'knowledgeforge-ai-coordinator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Architect - refactor (Architect - refactor)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-ArchitectRefactor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Architect - refactor',
    'general',
    'Architect - refactor',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: User Manager (User Manager)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-UserManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'User Manager',
    'general',
    'User Manager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Development Manager (Development Manager)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-DevelopmentManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Development Manager',
    'general',
    'Development Manager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Communication Manager (Communication Manager)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-CommunicationManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Communication Manager',
    'general',
    'Communication Manager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Director Project (Director Project)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-DirectorProject/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Director Project',
    'general',
    'Director Project',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Director HSE (Director HSE)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-DirectorHse/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Director HSE',
    'general',
    'Director HSE',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Director Sales (Director Sales)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-DirectorSales/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Director Sales',
    'general',
    'Director Sales',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Director Procurement (Director Procurement)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-DirectorProcurement/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Director Procurement',
    'general',
    'Director Procurement',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: System Administrator (System Administrator)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-SystemAdministrator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'System Administrator',
    'general',
    'System Administrator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: AI Manager (AI Manager)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-AiManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'AI Manager',
    'general',
    'AI Manager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Monitor (Monitor)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-MonitorNew/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Monitor',
    'general',
    'Monitor',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Operations Coordinator (Operations Coordinator)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-OperationsCoordinator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Operations Coordinator',
    'general',
    'Operations Coordinator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Director Logistics (Director Logistics)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-DirectorFinance/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Director Logistics',
    'general',
    'Director Logistics',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Investigator (Investigator)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-InvestigatorNew/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Investigator',
    'general',
    'Investigator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Integrator (Integrator)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-IntegratorNew/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Integrator',
    'general',
    'Integrator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Architect (Architect)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-ArchitectNew/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Architect',
    'general',
    'Architect',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Director Engineering (Director Engineering)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-DirectorEngineering/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Director Engineering',
    'general',
    'Director Engineering',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Director Logistics (Director Logistics)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-DirectorLogistics/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Director Logistics',
    'general',
    'Director Logistics',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Analyst Sector (Analyst Sector)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-AnalystSector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Analyst Sector',
    'general',
    'Analyst Sector',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Director Projects (Director Projects)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-DirectorProjects/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Director Projects',
    'general',
    'Director Projects',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Director Construction (Director Construction)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-DirectorConstruction/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Director Construction',
    'general',
    'Director Construction',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Quality Assurance (Quality Assurance)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-QualityAssurance/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Quality Assurance',
    'general',
    'Quality Assurance',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Administrator (Administrator)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-AdministratorPostAwa/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Administrator',
    'general',
    'Administrator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Inspector QC (Inspector QC)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-InspectorQc/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Inspector QC',
    'general',
    'Inspector QC',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: KWG (KnowledgeForge Workflow Guardian)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-CoordinatorGuardian/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'KWG',
    'general',
    'KnowledgeForge Workflow Guardian',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Docs Analyzer (Docs Analyzer)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-DocsAnalyzer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Docs Analyzer',
    'general',
    'Docs Analyzer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Advisor Disciplines (Advisor Disciplines)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-AdvisorDisciplines/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Advisor Disciplines',
    'general',
    'Advisor Disciplines',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Validator (Validator)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-ValidatorNew/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Validator',
    'general',
    'Validator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Interface Specialist (Interface Specialist)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-InterfaceSpecialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'Interface Specialist',
    'general',
    'Interface Specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: A-p (Administrator - pre-award)
-- File: docs-paperclip/companies/knowledgeforge-ai/agents/knowledgeforge-ai-treasurer/knowledgeforge-ai-AdministratorPreAwar/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'A-p',
    'general',
    'Administrator - pre-award',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: AMA (learningforge-ai-assessment-mastery)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-AssessmentMastery/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'AMA',
    'general',
    'learningforge-ai-assessment-mastery',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Error Pattern Monitor (learningforge-ai-error-pattern-monitor)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-ErrorPatternMonitor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Error Pattern Monitor',
    'general',
    'learningforge-ai-error-pattern-monitor',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: User Behavior Analyst (learningforge-ai-user-behavior-analyst)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-UserBehaviorAnalyst/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'User Behavior Analyst',
    'general',
    'learningforge-ai-user-behavior-analyst',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: RCDL (learningforge-ai-research-compliance-division-lead)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-ResearchComplianceDi/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'RCDL',
    'general',
    'learningforge-ai-research-compliance-division-lead',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: EIA (learningforge-ai-equipment-inspection)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-EquipmentInspection/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'EIA',
    'general',
    'learningforge-ai-equipment-inspection',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: AGA (learningforge-ai-autoresearch-gap-analyzer)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-AutoresearchGapAnaly/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'AGA',
    'general',
    'learningforge-ai-autoresearch-gap-analyzer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Doc Usage Analyzer (learningforge-ai-doc-usage-analyzer)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-DocUsageAnalyzer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Doc Usage Analyzer',
    'general',
    'learningforge-ai-doc-usage-analyzer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: SRA-LA (learningforge-ai-safetyresearchagent)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-SafetyResearchAgent/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'SRA-LA',
    'general',
    'learningforge-ai-safetyresearchagent',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: EEA (learningforge-ai-electrical-engineering-agent)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-ElectricalEngineering/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'EEA',
    'general',
    'learningforge-ai-electrical-engineering-agent',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Hazard Pattern Analyst (learningforge-ai-hazard-pattern-analyst)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-HazardPatternAnalyst/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Hazard Pattern Analyst',
    'general',
    'learningforge-ai-hazard-pattern-analyst',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: KPA (learningforge-ai-knowledge-provenance)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-KnowledgeProvenance/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'KPA',
    'general',
    'learningforge-ai-knowledge-provenance',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: FDTLG (learningforge-ai-from-doc-to-lesson-generator)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-FromDocToLessonGen/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'FDTLG',
    'general',
    'learningforge-ai-from-doc-to-lesson-generator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: IPC (learningforge-ai-interaction-pattern-coach)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-InteractionPatternCo/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'IPC',
    'general',
    'learningforge-ai-interaction-pattern-coach',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: VFS Watcher Agent (learningforge-ai-vfs-watcher)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-VfsWatcher/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'VFS Watcher Agent',
    'general',
    'learningforge-ai-vfs-watcher',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Quality Learning Agent (learningforge-ai-quality-learning)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-QualityLearning/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Quality Learning Agent',
    'general',
    'learningforge-ai-quality-learning',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Compliance Guard Agent (learningforge-ai-compliance-guard)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-ComplianceGuard/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Compliance Guard Agent',
    'general',
    'learningforge-ai-compliance-guard',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: RSA (learningforge-ai-research-scheduler)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-ResearchScheduler/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'RSA',
    'general',
    'learningforge-ai-research-scheduler',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: SRRA (learningforge-ai-safety-regulation-research)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-SafetyRegulationRese/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'SRRA',
    'general',
    'learningforge-ai-safety-regulation-research',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: MPA-LA (learningforge-ai-mobilepatternsagent)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-MobilePatternsAgent/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'MPA-LA',
    'general',
    'learningforge-ai-mobilepatternsagent',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: LIA-LA (learningforge-ai-learningintegration)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-LearningIntegration/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'LIA-LA',
    'general',
    'learningforge-ai-learningintegration',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: MDT (learningforge-ai-material-defect-tracker)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-MaterialDefectTracke/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'MDT',
    'general',
    'learningforge-ai-material-defect-tracker',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: STCA (learningforge-ai-safety-training-compliance)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-SafetyTrainingCompli/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'STCA',
    'general',
    'learningforge-ai-safety-training-compliance',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Procurement Agent (learningforge-ai-procurement-agent)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-ProcurementAgent/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Procurement Agent',
    'general',
    'learningforge-ai-procurement-agent',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Safety Workflow Agent (learningforge-ai-safety-workflow-agent)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-SafetyWorkflowAgent/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Safety Workflow Agent',
    'general',
    'learningforge-ai-safety-workflow-agent',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Doc Gap Detector (learningforge-ai-doc-gap-detector)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-DocGapDetector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Doc Gap Detector',
    'general',
    'learningforge-ai-doc-gap-detector',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Hermes Research Agent (learningforge-ai-hermes-research)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-HermesResearch/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Hermes Research Agent',
    'general',
    'learningforge-ai-hermes-research',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: EIRA (learningforge-ai-equipment-innovation-research)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-EquipmentInnovation/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'EIRA',
    'general',
    'learningforge-ai-equipment-innovation-research',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Learning Division Lead (learningforge-ai-learning-division-lead)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-LearningDivisionLead/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Learning Division Lead',
    'general',
    'learningforge-ai-learning-division-lead',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: GA&BA (learningforge-ai-goal-alignment-budget)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-GoalAlignmentBudget/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'GA&BA',
    'general',
    'learningforge-ai-goal-alignment-budget',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: KHA (learningforge-ai-knowledge-hygiene)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-KnowledgeHygiene/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'KHA',
    'general',
    'learningforge-ai-knowledge-hygiene',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Audit By Path Agent (learningforge-ai-audit-by-path)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-AuditByPath/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Audit By Path Agent',
    'general',
    'learningforge-ai-audit-by-path',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: LangChain Runner Agent (learningforge-ai-langchain-runner)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-LangchainRunner/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'LangChain Runner Agent',
    'general',
    'learningforge-ai-langchain-runner',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DPRA (learningforge-ai-defect-pattern-research)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-DefectPatternResearc/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'DPRA',
    'general',
    'learningforge-ai-defect-pattern-research',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: SQDL (learningforge-ai-safety-quality-division-lead)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-SafetyQualityDivisio/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'SQDL',
    'general',
    'learningforge-ai-safety-quality-division-lead',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Logistics Agent (learningforge-ai-logistics-agent)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-LogisticsAgent/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Logistics Agent',
    'general',
    'learningforge-ai-logistics-agent',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: FSA (learningforge-ai-feedback-synthesis)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-FeedbackSynthesis/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'FSA',
    'general',
    'learningforge-ai-feedback-synthesis',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Workflow Coach (learningforge-ai-workflow-coach)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-WorkflowCoach/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Workflow Coach',
    'general',
    'learningforge-ai-workflow-coach',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: ASE (learningforge-ai-autoresearch-skills-enhancer)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-LiteratureScanner/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'ASE',
    'general',
    'learningforge-ai-autoresearch-skills-enhancer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: KFDL (learningforge-ai-knowledge-flow-division-lead)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-KnowledgeFlowDivisio/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'KFDL',
    'general',
    'learningforge-ai-knowledge-flow-division-lead',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: ALS (learningforge-ai-autoresearch-literature-scanner)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-AutoresearchLiteratur/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'ALS',
    'general',
    'learningforge-ai-autoresearch-literature-scanner',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: VFS Markdown Tracker (learningforge-ai-vfs-markdown-tracker)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-VfsMarkdownTracker/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'VFS Markdown Tracker',
    'general',
    'learningforge-ai-vfs-markdown-tracker',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: PDL (learningforge-ai-priority-disciplines-lead)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-PriorityDisciplinesL/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'PDL',
    'general',
    'learningforge-ai-priority-disciplines-lead',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Curriculum Planner (learningforge-ai-curriculum-planner)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-CurriculumPlanner/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Curriculum Planner',
    'general',
    'learningforge-ai-curriculum-planner',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Micro-Lesson Generator (learningforge-ai-micro-lesson-generator)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-MicroLessonGenerator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Micro-Lesson Generator',
    'general',
    'learningforge-ai-micro-lesson-generator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: A&EA (learningforge-ai-audit-explainability)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-AuditExplainability/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'A&EA',
    'general',
    'learningforge-ai-audit-explainability',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Knowledge Flow Agent (learningforge-ai-knowledge-flow-agent)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-KnowledgeFlowAgent/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Knowledge Flow Agent',
    'general',
    'learningforge-ai-knowledge-flow-agent',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Field Safety Inspector (learningforge-ai-field-safety-inspector)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-FieldSafetyInspector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Field Safety Inspector',
    'general',
    'learningforge-ai-field-safety-inspector',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: CLRA (learningforge-ai-construction-law-research)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-ConstructionLawResea/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'CLRA',
    'general',
    'learningforge-ai-construction-law-research',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: LSA (learningforge-ai-ceo)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-ceo/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'LSA',
    'general',
    'learningforge-ai-ceo',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: KTA (learningforge-ai-knowledge-transparency)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-KnowledgeTransparency/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'KTA',
    'general',
    'learningforge-ai-knowledge-transparency',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Contracts Agent (learningforge-ai-contracts-agent)
-- File: docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-ContractsAgent/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Contracts Agent',
    'general',
    'learningforge-ai-contracts-agent',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: jordan-loopy-marketing (jordan-loopy-marketing-specialist)
-- File: docs-paperclip/companies/loopy-ai/agents/loopy-ai-JordanLoopyMarketing/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '0a40625e-78f9-4b0a-82e4-169a8befa021',
    'jordan-loopy-marketing',
    'general',
    'jordan-loopy-marketing-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: alex-loopy-deep-resear (alex-loopy-deep-research)
-- File: docs-paperclip/companies/loopy-ai/agents/loopy-ai-AlexLoopyDeepResear/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '0a40625e-78f9-4b0a-82e4-169a8befa021',
    'alex-loopy-deep-resear',
    'general',
    'alex-loopy-deep-research',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: sam-loopy-social-media (sam-loopy-social-media-coordinator)
-- File: docs-paperclip/companies/loopy-ai/agents/loopy-ai-SamLoopySocialMedia/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '0a40625e-78f9-4b0a-82e4-169a8befa021',
    'sam-loopy-social-media',
    'general',
    'sam-loopy-social-media-coordinator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: VLC-LACEO (vision-loopy-ceo)
-- File: docs-paperclip/companies/loopy-ai/agents/loopy-ai-VisionLoopyCeo/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '0a40625e-78f9-4b0a-82e4-169a8befa021',
    'VLC-LACEO',
    'general',
    'vision-loopy-ceo',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: maya-loopy-content-str (maya-loopy-content-strategist)
-- File: docs-paperclip/companies/loopy-ai/agents/loopy-ai-MayaLoopyContentStr/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '0a40625e-78f9-4b0a-82e4-169a8befa021',
    'maya-loopy-content-str',
    'general',
    'maya-loopy-content-strategist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: dev-loopy-technical-cr (dev-loopy-technical-creative)
-- File: docs-paperclip/companies/loopy-ai/agents/loopy-ai-DevLoopyTechnicalCr/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '0a40625e-78f9-4b0a-82e4-169a8befa021',
    'dev-loopy-technical-cr',
    'general',
    'dev-loopy-technical-creative',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: MVS (measurement-validation-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/validators/measureforge-ai-MeasurementValidation/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'MVS',
    'general',
    'measurement-validation-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: VOS (visual-overlay-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/validators/measureforge-ai-VisualOverlaySpecial/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'VOS',
    'general',
    'visual-overlay-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: MAEQS (measureforge-ai-electrical-qa-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/validators/measureforge-ai-ElectricalQA/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'MAEQS',
    'general',
    'measureforge-ai-electrical-qa-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: SSS (sans-standards-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/standards/measureforge-ai-SansStandardsSpecial/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'SSS',
    'general',
    'sans-standards-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: ASS (asaqs-standards-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/standards/measureforge-ai-AsaqsStandards/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'ASS',
    'general',
    'asaqs-standards-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: CTS (contract-tender-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/procurement/measureforge-ai-ContractTender/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'CTS',
    'general',
    'contract-tender-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: OGS (order-generation-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/procurement/measureforge-ai-OrderGeneration/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'OGS',
    'general',
    'order-generation-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: MAEMS (measureforge-ai-electrical-measurement-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/element/measureforge-ai-ElectricalMeasurement/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'MAEMS',
    'general',
    'measureforge-ai-electrical-measurement-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: CAS (contour-analysis-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/element/measureforge-ai-ContourAnalysis/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'CAS',
    'general',
    'contour-analysis-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: MEP Element Specialist (mep-element-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/element/measureforge-ai-MepElementSpecialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'MEP Element Specialist',
    'general',
    'mep-element-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: MATSCS (measureforge-ai-traffic-signal-compliance-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/element/measureforge-ai-TrafficSignalComplia/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'MATSCS',
    'general',
    'measureforge-ai-traffic-signal-compliance-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: MATSMS (measureforge-ai-traffic-signal-measurement-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/element/measureforge-ai-TrafficSignalMeasure/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'MATSMS',
    'general',
    'measureforge-ai-traffic-signal-measurement-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: AES (architectural-element-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/element/measureforge-ai-ArchitecturalElement/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'AES',
    'general',
    'architectural-element-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: MAECS (measureforge-ai-electrical-compliance-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/element/measureforge-ai-ElectricalCompliance/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'MAECS',
    'general',
    'measureforge-ai-electrical-compliance-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: CES (cost-estimation-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/element/measureforge-ai-CostEstimation/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'CES',
    'general',
    'cost-estimation-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: SES (structural-element-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/element/measureforge-ai-StructuralElement/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'SES',
    'general',
    'structural-element-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: QSS (quantity-surveyor-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/element/measureforge-ai-QuantitySurveyorSpec/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'QSS',
    'general',
    'quantity-surveyor-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: ECS (earthwork-calculation-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/element/measureforge-ai-EarthworkCalculation/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'ECS',
    'general',
    'earthwork-calculation-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: AIS (autocad-integration-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/specialists/integration/measureforge-ai-AutocadIntegrationSp/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'AIS',
    'general',
    'autocad-integration-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: MCS (measurement-coordination-specialist)
-- File: docs-paperclip/companies/measureforge-ai/agents/coordinators/measureforge-ai-MeasurementCoord/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'MCS',
    'general',
    'measurement-coordination-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: CMO (cad-measurement-orchestrator)
-- File: docs-paperclip/companies/measureforge-ai/agents/coordinators/measureforge-ai-CadMeasurement/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'CMO',
    'general',
    'cad-measurement-orchestrator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (mobileforge-ai-uiuxspecialist)
-- File: docs-paperclip/companies/mobileforge-ai/agents/mobileforge-ai-UIUXSpecialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440009',
    'DM-DT&R',
    'general',
    'mobileforge-ai-uiuxspecialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (mobileforge-ai-appmanager)
-- File: docs-paperclip/companies/mobileforge-ai/agents/mobileforge-ai-AppManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440009',
    'DM-DT&R',
    'general',
    'mobileforge-ai-appmanager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (mobileforge-ai-cloudconnector)
-- File: docs-paperclip/companies/mobileforge-ai/agents/mobileforge-ai-CloudConnector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440009',
    'DM-DT&R',
    'general',
    'mobileforge-ai-cloudconnector',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (mobileforge-ai-apispecialist)
-- File: docs-paperclip/companies/mobileforge-ai/agents/mobileforge-ai-APISpecialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440009',
    'DM-DT&R',
    'general',
    'mobileforge-ai-apispecialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (mobileforge-ai-performanceoptimizer)
-- File: docs-paperclip/companies/mobileforge-ai/agents/mobileforge-ai-PerformanceOptimizer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440009',
    'DM-DT&R',
    'general',
    'mobileforge-ai-performanceoptimizer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (mobileforge-ai-devicecontroller)
-- File: docs-paperclip/companies/mobileforge-ai/agents/mobileforge-ai-DeviceController/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440009',
    'DM-DT&R',
    'general',
    'mobileforge-ai-devicecontroller',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (mobileforge-ai-mobilemaestro)
-- File: docs-paperclip/companies/mobileforge-ai/agents/mobileforge-ai-MobileMaestro/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440009',
    'DM-DT&R',
    'general',
    'mobileforge-ai-mobilemaestro',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (mobileforge-ai-mobiledeveloper)
-- File: docs-paperclip/companies/mobileforge-ai/agents/mobileforge-ai-MobileDeveloper/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440009',
    'DM-DT&R',
    'general',
    'mobileforge-ai-mobiledeveloper',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (mobileforge-ai-testingcoordinator)
-- File: docs-paperclip/companies/mobileforge-ai/agents/mobileforge-ai-TestingCoordinator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440009',
    'DM-DT&R',
    'general',
    'mobileforge-ai-testingcoordinator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (mobileforge-ai-securityguardian)
-- File: docs-paperclip/companies/mobileforge-ai/agents/mobileforge-ai-SecurityGuardian/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440009',
    'DM-DT&R',
    'general',
    'mobileforge-ai-securityguardian',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DI-DFM (paperclipforge-ai-dataintegrator)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-DataIntegrator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DI-DFM',
    'general',
    'paperclipforge-ai-dataintegrator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: IG-AIC (paperclipforge-ai-issuegenerator)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-IssueGenerator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'IG-AIC',
    'general',
    'paperclipforge-ai-issuegenerator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-monitormaven)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-MonitorMaven/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-monitormaven',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: OD-COO (paperclipforge-ai-operationsdirector)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-OperationsDirector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'OD-COO',
    'general',
    'paperclipforge-ai-operationsdirector',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: AS-IIR (paperclipforge-ai-assignmentspecialist)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-AssignmentSpecialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'AS-IIR',
    'general',
    'paperclipforge-ai-assignmentspecialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DCO (paperclipforge-ai-databasecrudorchestrator)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-DatabaseCrudOrchestrator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DCO',
    'general',
    'paperclipforge-ai-databasecrudorchestrator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: V-MVS (paperclipforge-ai-measurementvalidation)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-MeasurementValidation/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'V-MVS',
    'general',
    'paperclipforge-ai-measurementvalidation',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: UI Uma (paperclipforge-ai-engineeringuispecial)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-EngineeringUiSpecial/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'UI Uma',
    'general',
    'paperclipforge-ai-engineeringuispecial',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-configcurator)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-ConfigCurator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-configcurator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-bridgebuilderextraor)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-BridgeBuilderExtraor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-bridgebuilderextraor',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-documentarian)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-documentarian/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-documentarian',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: M-MCS (paperclipforge-ai-measurementcoordspec)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-MeasurementCoordSpec/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'M-MCS',
    'general',
    'paperclipforge-ai-measurementcoordspec',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: AM-AEM (paperclipforge-ai-apimanager)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-ApiManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'AM-AEM',
    'general',
    'paperclipforge-ai-apimanager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-tickettinkerer)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-TicketTinkerer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-tickettinkerer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: GOS (paperclipforge-ai-githuboperationsspec)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-GithubOperationsSpec/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'GOS',
    'general',
    'paperclipforge-ai-githuboperationsspec',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: RM-RA&O (paperclipforge-ai-resourcemanager)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-ResourceManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'RM-RA&O',
    'general',
    'paperclipforge-ai-resourcemanager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-wisdomweaver)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-WisdomWeaver/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-wisdomweaver',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-networknavigator)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-NetworkNavigator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-networknavigator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: QC-QA (paperclipforge-ai-qualitycontroller)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-QualityController/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'QC-QA',
    'general',
    'paperclipforge-ai-qualitycontroller',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: R-ARS (paperclipforge-ai-agent-reconciler)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-AgentReconciler/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'R-ARS',
    'general',
    'paperclipforge-ai-agent-reconciler',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: WA-WD&A (paperclipforge-ai-workflowautomator)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-WorkflowAutomator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'WA-WD&A',
    'general',
    'paperclipforge-ai-workflowautomator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DD-DMaOA (paperclipforge-ai-databasedruid)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-DatabaseDruid/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DD-DMaOA',
    'general',
    'paperclipforge-ai-databasedruid',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: maya-loopy-content-str (maya-loopy-content-strategist)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-MayaLoopyContentStr/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'maya-loopy-content-str',
    'general',
    'maya-loopy-content-strategist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: S-ORFC (paperclipforge-ai-orgresearchfoldercr)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-OrgResearchFolderCr/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'S-ORFC',
    'general',
    'paperclipforge-ai-orgresearchfoldercr',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Analysis Andy (paperclipforge-ai-advancedengineering)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-AdvancedEngineering/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'Analysis Andy',
    'general',
    'paperclipforge-ai-advancedengineering',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: IA-CTO (paperclipforge-ai-integrationarchitect)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-IntegrationArchitect/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'IA-CTO',
    'general',
    'paperclipforge-ai-integrationarchitect',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-dataarchitect)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-DataArchitect/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-dataarchitect',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: IBIA (issue-batch-importer-paperclipforge)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-IssueBatchImporter/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'IBIA',
    'general',
    'issue-batch-importer-paperclipforge',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-tasktangodancer)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-TaskTangoDancer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-tasktangodancer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-testcommander)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-TestCommander/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-testcommander',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-codesage)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-CodeSage/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-codesage',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: PC-PLM (paperclipforge-ai-projectcoordinator)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-ProjectCoordinator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'PC-PLM',
    'general',
    'paperclipforge-ai-projectcoordinator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-loganalyst)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-LogAnalyst/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-loganalyst',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: VLC-LACEO (vision-loopy-ceo)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-VisionLoopyCeo/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'VLC-LACEO',
    'general',
    'vision-loopy-ceo',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: S-MSS (paperclipforge-ai-measurementstandards)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-MeasurementStandards/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'S-MSS',
    'general',
    'paperclipforge-ai-measurementstandards',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Coordination Charlie (paperclipforge-ai-crossdisciplinecoord)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-CrossDisciplineCoord/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'Coordination Charlie',
    'general',
    'paperclipforge-ai-crossdisciplinecoord',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-performanceprofiler)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-PerformanceProfiler/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-performanceprofiler',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: MAS (paperclipforge-ai-modelassignmentspeci)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-ModelAssignmentSpeci/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'MAS',
    'general',
    'paperclipforge-ai-modelassignmentspeci',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-endpointenchantress)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-EndpointEnchantress/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-endpointenchantress',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: PM-PT&A (paperclipforge-ai-performancemonitor)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-PerformanceMonitor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'PM-PT&A',
    'general',
    'paperclipforge-ai-performancemonitor',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: A-ACaM (paperclipforge-ai-atlasagentcreator)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-AtlasAgentCreator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'A-ACaM',
    'general',
    'paperclipforge-ai-atlasagentcreator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: PM-CEO (paperclipforge-ai-projectmaestro)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-ProjectMaestro/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'PM-CEO',
    'general',
    'paperclipforge-ai-projectmaestro',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: KI-KI (paperclipforge-ai-knowledgeintegrator)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-KnowledgeIntegrator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'KI-KI',
    'general',
    'paperclipforge-ai-knowledgeintegrator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-cachekeeper)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-CacheKeeper/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-cachekeeper',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-integrationillusionis)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-IntegrationIllusionis/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-integrationillusionis',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: RA-A&R (paperclipforge-ai-reportinganalyst)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-ReportingAnalyst/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'RA-A&R',
    'general',
    'paperclipforge-ai-reportinganalyst',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-deployer)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-deployer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-deployer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: UEC-UIM (paperclipforge-ai-userexperiencecoordi)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-UserExperienceCoordi/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'UEC-UIM',
    'general',
    'paperclipforge-ai-userexperiencecoordi',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-chainlinkcharmer)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-ChainlinkCharmer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-chainlinkcharmer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: PT-RM (paperclipforge-ai-progresstracker)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-ProgressTracker/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'PT-RM',
    'general',
    'paperclipforge-ai-progresstracker',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: PM-PA (paperclipforge-ai-predictivemodeler)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-PredictiveModeler/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'PM-PA',
    'general',
    'paperclipforge-ai-predictivemodeler',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: RA-RI&M (paperclipforge-ai-riskanalyst)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-RiskAnalyst/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'RA-RI&M',
    'general',
    'paperclipforge-ai-riskanalyst',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-securityguardian)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-SecurityGuardian/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-securityguardian',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-authadministrator)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-AuthAdministrator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-authadministrator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (paperclipforge-ai-dependencymanager)
-- File: docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-DependencyManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'DM-DT&R',
    'general',
    'paperclipforge-ai-dependencymanager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: tuner-promptforge-ab-t (tuner-promptforge-ab-testing)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-tuner/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'tuner-promptforge-ab-t',
    'general',
    'tuner-promptforge-ab-testing',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: cascade-promptforge-wo (cascade-promptforge-workflow-designer)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-cascade/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'cascade-promptforge-wo',
    'general',
    'cascade-promptforge-workflow-designer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: quantifier-promptforge (quantifier-promptforge-benchmarking)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-quantifier/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'quantifier-promptforge',
    'general',
    'quantifier-promptforge-benchmarking',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: analyzer-promptforge-p (analyzer-promptforge-prompt-analytics)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-analyzer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'analyzer-promptforge-p',
    'general',
    'analyzer-promptforge-prompt-analytics',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: compliance-promptforge (compliance-promptforge-regulatory-compliance)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-compliance/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'compliance-promptforge',
    'general',
    'compliance-promptforge-regulatory-compliance',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: scholar-promptforge-ac (scholar-promptforge-academic-research)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-scholar/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'scholar-promptforge-ac',
    'general',
    'scholar-promptforge-academic-research',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: validator-promptforge- (validator-promptforge-syntax-logic-validation)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-validator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'validator-promptforge-',
    'general',
    'validator-promptforge-syntax-logic-validation',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: integration-promptforg (integration-promptforge-cross-agent-compatibility)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-integration/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'integration-promptforg',
    'general',
    'integration-promptforge-cross-agent-compatibility',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: sage-promptforge-chief (sage-promptforge-chief-architect)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-sage/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'sage-promptforge-chief',
    'general',
    'sage-promptforge-chief-architect',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: archivist-promptforge- (archivist-promptforge-knowledge-management)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-archivist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'archivist-promptforge-',
    'general',
    'archivist-promptforge-knowledge-management',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: flowdesigner-promptfor (flowdesigner-promptforge-agent-handoff)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-flowdesigner/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'flowdesigner-promptfor',
    'general',
    'flowdesigner-promptforge-agent-handoff',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DAA (promptforge-ai-disciplineautomation)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-DisciplineAutomation/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'DAA',
    'general',
    'promptforge-ai-disciplineautomation',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: predictor-promptforge- (predictor-promptforge-outcome-prediction)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-predictor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'predictor-promptforge-',
    'general',
    'predictor-promptforge-outcome-prediction',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: enhancer-promptforge-a (enhancer-promptforge-advanced-innovation)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-enhancer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'enhancer-promptforge-a',
    'general',
    'enhancer-promptforge-advanced-innovation',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: statemaster-promptforg (statemaster-promptforge-state-management)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-statemaster/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'statemaster-promptforg',
    'general',
    'statemaster-promptforge-state-management',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: blueprint-promptforge- (blueprint-promptforge-template-designer)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-blueprint/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'blueprint-promptforge-',
    'general',
    'blueprint-promptforge-template-designer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: refiner-promptforge-ve (refiner-promptforge-version-control)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-refiner/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'refiner-promptforge-ve',
    'general',
    'refiner-promptforge-version-control',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: explorer-promptforge-n (explorer-promptforge-new-techniques)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-explorer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'explorer-promptforge-n',
    'general',
    'explorer-promptforge-new-techniques',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: experimenter-promptfor (experimenter-promptforge-hypothesis-testing)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-experimenter/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'experimenter-promptfor',
    'general',
    'experimenter-promptforge-hypothesis-testing',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: harmonic-promptforge-o (harmonic-promptforge-orchestration-strategy)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-harmonic/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'harmonic-promptforge-o',
    'general',
    'harmonic-promptforge-orchestration-strategy',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: collaborator-promptfor (collaborator-promptforge-cross-company-knowledge-sharing)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-collaborator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'collaborator-promptfor',
    'general',
    'collaborator-promptforge-cross-company-knowledge-sharing',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: clarity-promptforge-pe (clarity-promptforge-performance-optimization)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-clarity/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'clarity-promptforge-pe',
    'general',
    'clarity-promptforge-performance-optimization',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: integrity-promptforge- (integrity-promptforge-ethical-ai)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-integrity/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'integrity-promptforge-',
    'general',
    'integrity-promptforge-ethical-ai',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: specialist-promptforge (specialist-promptforge-domain-adaptation)
-- File: docs-paperclip/companies/promptforge-ai/agents/promptforge-ai-specialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'specialist-promptforge',
    'general',
    'specialist-promptforge-domain-adaptation',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: monitor-qualityforge-q (monitor-qualityforge-quality-monitor)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Monitor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'monitor-qualityforge-q',
    'general',
    'monitor-qualityforge-quality-monitor',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: tracer-qualityforge-ex (tracer-qualityforge-execution-tracer)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Tracer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'tracer-qualityforge-ex',
    'general',
    'tracer-qualityforge-execution-tracer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: integrator-Integration (integrator-Integration-specialist)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Integrator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'integrator-Integration',
    'general',
    'integrator-Integration-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: guardian-qualityforge- (guardian-qualityforge-quality-guardian)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Guardian/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'guardian-qualityforge-',
    'general',
    'guardian-qualityforge-quality-guardian',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: integration-Integratio (integration-Integration-testing)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Integration/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'integration-Integratio',
    'general',
    'integration-Integration-testing',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: profiler-Performance-p (profiler-Performance-profiler)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Profiler/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'profiler-Performance-p',
    'general',
    'profiler-Performance-profiler',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: apex-qualityforge-ceo (apex-qualityforge-ceo)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Apex/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'apex-qualityforge-ceo',
    'general',
    'apex-qualityforge-ceo',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: resolver-qualityforge- (resolver-qualityforge-issue-resolver)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Resolver/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'resolver-qualityforge-',
    'general',
    'resolver-qualityforge-issue-resolver',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: fixer-qualityforge-bug (fixer-qualityforge-bug-fixing-specialist)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Fixer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'fixer-qualityforge-bug',
    'general',
    'fixer-qualityforge-bug-fixing-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: refactor-Refactoring-s (refactor-Refactoring-specialist)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Refactor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'refactor-Refactoring-s',
    'general',
    'refactor-Refactoring-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: loadtester-qualityforg (loadtester-qualityforge-scalability-testing)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Loadtester/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'loadtester-qualityforg',
    'general',
    'loadtester-qualityforge-scalability-testing',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: coverage-qualityforge- (coverage-qualityforge-test-coverage-analyst)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Coverage/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'coverage-qualityforge-',
    'general',
    'coverage-qualityforge-test-coverage-analyst',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: Compliance Validator (qualityforge-ai-compliancevalidator)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-ComplianceValidator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'Compliance Validator',
    'general',
    'qualityforge-ai-compliancevalidator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: dbat-testing-qualityfo (dbat-testing-qualityforge)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-DbatTesting/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'dbat-testing-qualityfo',
    'general',
    'dbat-testing-qualityforge',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: maintainer-qualityforg (maintainer-qualityforge-code-maintainer)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Maintainer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'maintainer-qualityforg',
    'general',
    'maintainer-qualityforge-code-maintainer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: compatibility (compatibility)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Compatibility/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'compatibility',
    'general',
    'compatibility',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: documenter-qualityforg (documenter-qualityforge-documentation-specialist)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Documenter/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'documenter-qualityforg',
    'general',
    'documenter-qualityforge-documentation-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: code-analyzer (code-analyzer)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-CodeAnalyzer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'code-analyzer',
    'general',
    'code-analyzer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: validator-Validator (validator-Validator)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Validator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'validator-Validator',
    'general',
    'validator-Validator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: debugger-Debugger-spec (debugger-Debugger-specialist)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Debugger/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'debugger-Debugger-spec',
    'general',
    'debugger-Debugger-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: inspector-qualityforge (inspector-qualityforge-code-inspector)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Inspector/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'inspector-qualityforge',
    'general',
    'inspector-qualityforge-code-inspector',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: optimizer-qualityforge (optimizer-qualityforge-code-optimizer)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Optimizer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'optimizer-qualityforge',
    'general',
    'optimizer-qualityforge-code-optimizer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DP (qualityforge-ai-documentationprocess)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-DocumentationProcess/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'DP',
    'general',
    'qualityforge-ai-documentationprocess',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: performance-Performanc (performance-Performance-testing)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Performance/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'performance-Performanc',
    'general',
    'performance-Performance-testing',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: accessibility-Accessib (accessibility-Accessibility-testing)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-accessibility/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'accessibility-Accessib',
    'general',
    'accessibility-Accessibility-testing',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DSS (qualityforge-ai-decisionsupport)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-DecisionSupport/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'DSS',
    'general',
    'qualityforge-ai-decisionsupport',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: reporter-qualityforge- (reporter-qualityforge-quality-reporter)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Reporter/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'reporter-qualityforge-',
    'general',
    'reporter-qualityforge-quality-reporter',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: load-Load-testing (load-Load-testing)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Load/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'load-Load-testing',
    'general',
    'load-Load-testing',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: ACM (qualityforge-ai-assessmentcriteria)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-AssessmentCriteria/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'ACM',
    'general',
    'qualityforge-ai-assessmentcriteria',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: standards-Standards-en (standards-Standards-enforcer)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Standards/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'standards-Standards-en',
    'general',
    'standards-Standards-enforcer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: reviewer-qualityforge- (reviewer-qualityforge-code-reviewer)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-CodeReviewer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'reviewer-qualityforge-',
    'general',
    'reviewer-qualityforge-code-reviewer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: auditor (auditor)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Auditor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'auditor',
    'general',
    'auditor',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: automation-qualityforg (automation-qualityforge-test-automation)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Automation/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'automation-qualityforg',
    'general',
    'automation-qualityforge-test-automation',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: e2e-qualityforge-end-t (e2e-qualityforge-end-to-end-testing)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-E2E/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'e2e-qualityforge-end-t',
    'general',
    'e2e-qualityforge-end-to-end-testing',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: probe-qualityforge-pro (probe-qualityforge-prompt-testing)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Probe/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'probe-qualityforge-pro',
    'general',
    'probe-qualityforge-prompt-testing',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: codesmith-qualityforge (codesmith-qualityforge-code-architect)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Codesmith/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'codesmith-qualityforge',
    'general',
    'codesmith-qualityforge-code-architect',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: migrator-qualityforge- (migrator-qualityforge-migration-specialist)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Migrator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'migrator-qualityforge-',
    'general',
    'migrator-qualityforge-migration-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: simulator-qualityforge (simulator-qualityforge-workflow-simulation)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Simulator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'simulator-qualityforge',
    'general',
    'simulator-qualityforge-workflow-simulation',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: trainer-qualityforge-q (trainer-qualityforge-quality-trainer)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Trainer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'trainer-qualityforge-q',
    'general',
    'trainer-qualityforge-quality-trainer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: architect-qualityforge (architect-qualityforge-system-architect)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Architect/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'architect-qualityforge',
    'general',
    'architect-qualityforge-system-architect',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: diagnostics-Diagnostic (diagnostics-Diagnostics-specialist)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Diagnostics/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'diagnostics-Diagnostic',
    'general',
    'diagnostics-Diagnostics-specialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: governor-qualityforge- (governor-qualityforge-quality-director)
-- File: docs-paperclip/companies/qualityforge-ai/agents/qualityforge-ai-Governor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'governor-qualityforge-',
    'general',
    'governor-qualityforge-quality-director',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-successmanager)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-SuccessManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-successmanager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-clientconfigmanager)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-ClientConfigManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-clientconfigmanager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-renderservicemanager)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-RenderServiceManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-renderservicemanager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-onboardmaster)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-OnboardMaster/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-onboardmaster',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-dataguardian)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-DataGuardian/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-dataguardian',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-githubbranchmanager)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-GitHubBranchManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-githubbranchmanager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-accesscontroller)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-AccessController/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-accesscontroller',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-onboardingcoordinator)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-OnboardingCoordinator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-onboardingcoordinator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-supportintegrator)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-SupportIntegrator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-supportintegrator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-securityspecialist)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-SecuritySpecialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-securityspecialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-analyticsspecialist)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-AnalyticsSpecialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-analyticsspecialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-tenantmanager)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-TenantManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-tenantmanager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-devopsengineer)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-DevOpsEngineer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-devopsengineer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-resourceoptimizer)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-ResourceOptimizer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-resourceoptimizer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-deploymentorchestrato)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-DeploymentOrchestrato/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-deploymentorchestrato',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (saasforge-ai-platformarchitect)
-- File: docs-paperclip/companies/saasforge-ai/agents/saasforge-ai-PlatformArchitect/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011',
    'DM-DT&R',
    'general',
    'saasforge-ai-platformarchitect',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (voiceforge-ai-contextcoordinator)
-- File: docs-paperclip/companies/voiceforge-ai/agents/voiceforge-ai-ContextCoordinator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440012',
    'DM-DT&R',
    'general',
    'voiceforge-ai-contextcoordinator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (voiceforge-ai-intentanalyst)
-- File: docs-paperclip/companies/voiceforge-ai/agents/voiceforge-ai-IntentAnalyst/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440012',
    'DM-DT&R',
    'general',
    'voiceforge-ai-intentanalyst',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (voiceforge-ai-personalitydesigner)
-- File: docs-paperclip/companies/voiceforge-ai/agents/voiceforge-ai-PersonalityDesigner/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440012',
    'DM-DT&R',
    'general',
    'voiceforge-ai-personalitydesigner',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (voiceforge-ai-platformintegrator)
-- File: docs-paperclip/companies/voiceforge-ai/agents/voiceforge-ai-PlatformIntegrator/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440012',
    'DM-DT&R',
    'general',
    'voiceforge-ai-platformintegrator',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (voiceforge-ai-speechprocessor)
-- File: docs-paperclip/companies/voiceforge-ai/agents/voiceforge-ai-SpeechProcessor/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440012',
    'DM-DT&R',
    'general',
    'voiceforge-ai-speechprocessor',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (voiceforge-ai-languagespecialist)
-- File: docs-paperclip/companies/voiceforge-ai/agents/voiceforge-ai-LanguageSpecialist/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440012',
    'DM-DT&R',
    'general',
    'voiceforge-ai-languagespecialist',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (voiceforge-ai-audioengineer)
-- File: docs-paperclip/companies/voiceforge-ai/agents/voiceforge-ai-AudioEngineer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440012',
    'DM-DT&R',
    'general',
    'voiceforge-ai-audioengineer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (voiceforge-ai-qualityassurance)
-- File: docs-paperclip/companies/voiceforge-ai/agents/voiceforge-ai-QualityAssurance/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440012',
    'DM-DT&R',
    'general',
    'voiceforge-ai-qualityassurance',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (voiceforge-ai-conversationmanager)
-- File: docs-paperclip/companies/voiceforge-ai/agents/voiceforge-ai-ConversationManager/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440012',
    'DM-DT&R',
    'general',
    'voiceforge-ai-conversationmanager',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (voiceforge-ai-apiarchitect)
-- File: docs-paperclip/companies/voiceforge-ai/agents/voiceforge-ai-APIArchitect/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440012',
    'DM-DT&R',
    'general',
    'voiceforge-ai-apiarchitect',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (voiceforge-ai-voicesynthesizer)
-- File: docs-paperclip/companies/voiceforge-ai/agents/voiceforge-ai-VoiceSynthesizer/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440012',
    'DM-DT&R',
    'general',
    'voiceforge-ai-voicesynthesizer',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- Agent: DM-DT&R (voiceforge-ai-voicemaestro)
-- File: docs-paperclip/companies/voiceforge-ai/agents/voiceforge-ai-VoiceMaestro/AGENTS.md
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440012',
    'DM-DT&R',
    'general',
    'voiceforge-ai-voicemaestro',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- STEP 3: Generate API keys for all agents
-- ============================================================

-- API key for: SEO Strategist (contentforge-ai-seostrategist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-seostrategist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_743054440715d248d8450e2126ca4c34ff553edb90985a4f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Link Builder (contentforge-ai-linkbuilder)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-linkbuilder' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_53c2fb6d57e8b69766ca9057db8d116c7c6b3bd839f64737',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Performance Optimizer (contentforge-ai-performanceoptimizer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-performanceoptimizer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_f886cb07848b800b8a7d3789d3febb5e6e09a8f8fe0ec387',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Blog Architect (contentforge-ai-blogarchitect)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-blogarchitect' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_4ece6724dbb49237c7b88b0ef93e9f0e8970299103c260d8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: TSS (contentforge-ai-technicalseo)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-technicalseo' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_4c5c85165f631012ca12d417bff51ac55f173a0eb76d5b5f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Reporting Specialist (contentforge-ai-reportingspecialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-reportingspecialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_be46001d026339ce68bf0ce837048a3e6bb4977bdfe47814',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Content Maestro (contentforge-ai-contentmaestro)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-contentmaestro' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_0d6602bb03a08fc4a35332d49fa43effd0b733b5d77ff02f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Data Analyst (contentforge-ai-dataanalyst)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-dataanalyst' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_7cb3ab4685e50a57939b39dce1de9f64b7f44f8a051f2174',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Local SEO Expert (contentforge-ai-localseoexpert)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-localseoexpert' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_6b60a14589c4dfdcd88c2a8974876c536e81048ab6f49e30',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: SEO Analyst (contentforge-ai-seoanalyst)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-seoanalyst' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_c23ffb2139dde202086556b96bee585532a6c66575f37024',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Conversion Specialist (contentforge-ai-conversionspecialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-conversionspecialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_99fda51206513b1b63a36be45caba016f1a6d8b5162a5875',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Mobile Optimizer (contentforge-ai-mobileoptimizer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-mobileoptimizer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_6e78477e05c960be2a190646f37a18d830d7b3269ebb9752',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Conversion Analyst (contentforge-ai-conversionanalyst)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-conversionanalyst' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_f91baf9dbd44b7714d171e2da34263730f0365a83a90cdf8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Email Composer (contentforge-ai-emailcomposer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-emailcomposer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_03fe41ac6376a5d8cb7666c9a7e4aae60c9bd6f6bde1a18d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: E-CO (contentforge-ai-communicationorchestr)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-communicationorchestr' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_e3b3266a367b8d229feda71f483ea23240efd3bd6b9d57d8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: UX Designer (contentforge-ai-uxdesigner)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-uxdesigner' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_285a3c2e27b501d9bfc73fd0c82db8109ce9dfea37188b12',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Social Strategist (contentforge-ai-socialstrategist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-socialstrategist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440008',
    'default',
    'pcp_6bc1f3a58d2445ba10448c039424ecc6c748faa2d3f004b9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: ally-devforge-partners (ally-devforge-partnership-management)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'ally-devforge-partnership-management' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_67b6f961cac411719f1c202c1a8dcd74826d97884be84a3d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: interface-devforge-api (interface-devforge-api-integration)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'interface-devforge-api-integration' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_ce1dff6198b54fbbfa257ae1744114d7ab1b71c42de7fc8f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: vector-Vector-processi (vector-Vector-processing)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'vector-Vector-processing' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_125fac876d23f2d5a304d0bb625865403497c4c13c7825c8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: voyager-devforge-marke (voyager-devforge-market-exploration)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voyager-devforge-market-exploration' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_c9c72fc4b3f11e15b269525f7f74ccdba658543c6743a121',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: librarian-devforge-kno (librarian-devforge-knowledge-management)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'librarian-devforge-knowledge-management' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_97df2836dacde34447bf250e582d8b161dc0c312f92d79fe',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: fixer-devforge-bug-fix (fixer-devforge-bug-fixing)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'fixer-devforge-bug-fixing' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_8bf8f6b7b60ef4770c2ab33a4c142ded656925bcad627c7c',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: forge-devforge-system- (forge-devforge-system-architecture)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'forge-devforge-system-architecture' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_1ccf0073eb9aee549b5eb52086d5a9b08d9528e9263fba1e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: nexus-devforge-ceo (nexus-devforge-ceo)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'nexus-devforge-ceo' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_d7f4d7b63643441066475f89559cc2d39aee83b8e50b6c79',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: MC (devforge-ai-multidisciplinecoord)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'devforge-ai-multidisciplinecoord' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_0d81ee83e2bc14654ea8a09a8eac068ac9a2cf9c740066e2',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: synth-Synthetic-data (synth-Synthetic-data)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'synth-Synthetic-data' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_d36e3c846346027e66fd19047b60e4cf8f5931c6d3664c35',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DGS (devforge-ai-documentgenerationsp)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'devforge-ai-documentgenerationsp' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_3cecc0f4436cbabc5cc0750343c2c6bc30e2883803547962',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: archivist-devforge-kno (archivist-devforge-knowledge-security)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'archivist-devforge-knowledge-security' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_2f4dbd98957eb8efe3a3fcbac1939b04c21a2378c0487ec9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: insight-devforge-busin (insight-devforge-business-intelligence)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'insight-devforge-business-intelligence' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_d3e0bae1c11302c49c5e1883d2b4d7527f9133e0444ee607',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: sentinel-devforge-data (sentinel-devforge-data-quality-monitoring)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'sentinel-devforge-data-quality-monitoring' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_5e447c961e9f6878a3073e6203438b7dc0ca0d4d9746d4d3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: merchant-devforge-comm (merchant-devforge-commerce-operations)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'merchant-devforge-commerce-operations' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_8947b8f3833c8734d35d519380c600cdcfccde561d242dd1',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: devcore-devforge-core- (devcore-devforge-core-development)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'devcore-devforge-core-development' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_1b9e237e5c64d9f1785ace377bc8ce54228ef1201751aaf9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Financial Validator (devforge-ai-financialvalidator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'devforge-ai-financialvalidator' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_18622d394297e5e87c76c269b2245696009ce289972cdd2e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: cloudops-devforge-clou (cloudops-devforge-cloud-operations)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'cloudops-devforge-cloud-operations' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_7cc4ed05308fea3511c5f9626ae4e80984ac023549e7dbca',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: concierge-devforge-cus (concierge-devforge-customer-experience)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'concierge-devforge-customer-experience' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_55511d62e91400b05a7a05cd177cb12453c5204dbea665bc',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: sentinelx-devforge-adv (sentinelx-devforge-advanced-monitoring)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'sentinelx-devforge-advanced-monitoring' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_02c0fa1fe47305015108134f8cd8c294b079ee9570d6a696',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: sql-query-devforge (sql-query-devforge)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'sql-query-devforge' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_58865fdac4f9fe4a03aca27a0083ae413589df38cedb050b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: schema-devforge-data-s (schema-devforge-data-schema-management)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'schema-devforge-data-schema-management' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_d641596d7029a5b44e5d7074bb61b9e9bb0794a14d6149dd',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: council-devforge-strat (council-devforge-strategic-decision-making)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'council-devforge-strategic-decision-making' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_811c496356ce03daa6c3264cb6f60d0f7a509725df77b869',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: mentor-devforge-team-d (mentor-devforge-team-development)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mentor-devforge-team-development' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_e22d357075f047f9c1a85d28751fb243fa0b2f785d563839',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: dealmaker-devforge-sal (dealmaker-devforge-sales-negotiation)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'dealmaker-devforge-sales-negotiation' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_5a996d90ff8ea16d20080607c4eadab8188e66129b72b69d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: S-WLC (devforge-ai-workflowlearningcoor)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'devforge-ai-workflowlearningcoor' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_5035c9a2e977e45fd7742120fdca4fba6cb03627b6006ea4',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: atlas-devforge-product (atlas-devforge-product-mapping)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'atlas-devforge-product-mapping' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_fc874768b38bcb49c969bce0c11c7fb73119b8e96d92f06c',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: strategos-devforge-str (strategos-devforge-strategic-planning)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'strategos-devforge-strategic-planning' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_70cd555bd31f8a7f97620c571265c79b304d562f356b9763',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: guardian-devforge-thre (guardian-devforge-threat-protection)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'guardian-devforge-threat-protection' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_cda9c1b5488d3012b1ed393f732edcb1ddc6fdff7e12b015',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: amplifier-devforge-mar (amplifier-devforge-marketing-promotion)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'amplifier-devforge-marketing-promotion' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_ee9da6400e27357c3d1405810a0e1efe82be9f81f9e49c15',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: nova-devforge-product- (nova-devforge-product-launches)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'nova-devforge-product-launches' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_a28b363d166f1233cb42ca768b3183b92a811121cee97b21',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: analyst-devforge-marke (analyst-devforge-market-analysis)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'analyst-devforge-market-analysis' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_fd95be0805b4c5e43c34c8eb03c6230bd31b26a55e0452d9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: brandforge-devforge-br (brandforge-devforge-brand-development)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'brandforge-devforge-brand-development' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_ccaffb2e9d6618ea74f2e5d2df9a85c287b1f487872b5ccb',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: pathfinder-devforge-op (pathfinder-devforge-opportunity-identification)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'pathfinder-devforge-opportunity-identification' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_f71c93c3809fff0f004e07d62d7fc1aacef5ded47a6f2e2f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: catalyst-devforge-prod (catalyst-devforge-product-innovation)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'catalyst-devforge-product-innovation' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_0d4ab2d997c624eaae9265c44848bdf2b45e843d192144e3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: codesmith-devforge-bac (codesmith-devforge-backend-engineer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'codesmith-devforge-backend-engineer' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_729cbd0eebd14f1742d2970ce162c9bf3defb44739699e17',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: automata-devforge-auto (automata-devforge-automation-systems)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'automata-devforge-automation-systems' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_5ddf47b5e26d0ad8ee514e722df8e2a8f6c7fff1e0505745',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: storycraft-devforge-pr (storycraft-devforge-product-storytelling)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'storycraft-devforge-product-storytelling' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_29bb341f80cc20273316312de4664999dd4ca70712c861d6',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: promptsmith-devforge-p (promptsmith-devforge-prompt-engineering)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'promptsmith-devforge-prompt-engineering' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_abf48d5d05f3ded7b173dc4e119f36b70e0d6733798232d8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: compass-devforge-direc (compass-devforge-direction-setting)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'compass-devforge-direction-setting' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_4e9c1f5247680099eb179e735866782b8e49fe5413548882',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: navigator-devforge-dat (navigator-devforge-data-discovery)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'navigator-devforge-data-discovery' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_26096bceb09e2afd8667d2122ed7ca3f6fa35d18d12239e7',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: reviewer-devforge-code (reviewer-devforge-code-review-qa)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'reviewer-devforge-code-review-qa' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_6d4858076b274ce36d936a65e1875369458d5dd0e6c653fd',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: ambassador-devforge-br (ambassador-devforge-brand-representation)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'ambassador-devforge-brand-representation' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_0116e7c0bebd3860781e35a462050a922adcd7e537549197',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: gatekeeper-devforge-ac (gatekeeper-devforge-access-control)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'gatekeeper-devforge-access-control' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_216b65aeea8e635e38dcc92194982e3e9174343ba5a72853',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Transaction Processor (devforge-ai-transactionprocessor)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'devforge-ai-transactionprocessor' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_64e530c872704a757ec169b1224951f20d2ac21b0105df8e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Q-WCA (devforge-ai-workflowcomplexityan)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'devforge-ai-workflowcomplexityan' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_3eeb4ddc75d0ea2f1a57c2c2e78b5000a2ea59aaeda3fa10',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: watchtower-devforge-se (watchtower-devforge-security-oversight)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'watchtower-devforge-security-oversight' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_bf242e4315594fde96f4b3917be99ecb500b7c63f7fe4ff3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: oracle-devforge-predic (oracle-devforge-predictive-analytics)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'oracle-devforge-predictive-analytics' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_2500c8bbf4a067e78d8aaf44845cce6a3a81ba9c87643c63',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: auditor-devforge-secur (auditor-devforge-security-compliance)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'auditor-devforge-security-compliance' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_db886c5efe5f48a18574acc10be730aa60825e5eb015b13a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: stream-devforge-data-s (stream-devforge-data-streaming)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'stream-devforge-data-streaming' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_4851872abee08a8550bce08ceed2069e2400695efd138b79',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: dataforge-devforge-dat (dataforge-devforge-data-transformation)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'dataforge-devforge-data-transformation' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_3193e40a02fbcb0502190ba9be67c688136f4d9655580e73',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: catalystx-devforge-mar (catalystx-devforge-market-disruption)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'catalystx-devforge-market-disruption' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_0f9f0bc33509c12247f3e08240d0872fe2944f056480b567',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: scout-devforge-competi (scout-devforge-competitive-intelligence)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'scout-devforge-competitive-intelligence' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_ebbaab3adfa34984b70781ded2dbc5b0675f8716a6d8ce80',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: cartographer-devforge- (cartographer-devforge-product-roadmapping)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'cartographer-devforge-product-roadmapping' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_22223c86386ef4731aa8dc1011ef839b1bd5274a0a950439',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: ledgerai-devforge-fina (ledgerai-devforge-financial-data)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'ledgerai-devforge-financial-data' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_fc0091be8149d29522c89b15a25dcd5646648781b43c81cd',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: pulse-devforge-realtim (pulse-devforge-realtime-monitoring)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'pulse-devforge-realtime-monitoring' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_12f9748d48436b8c440dd244ba7e8ef4f56788f0e1c627b6',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: orion-devforge-orchest (orion-devforge-orchestrator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'orion-devforge-orchestrator' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_56cf5260ce783f34447d6cf8448bacc18f639589326fb89c',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: ledger-devforge-financ (ledger-devforge-financial-oversight)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'ledger-devforge-financial-oversight' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_32a0ac98d2775dd3b5ea2925e743c0ec131ae977723d2cee',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: cortex-devforge-ai-rea (cortex-devforge-ai-reasoning)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'cortex-devforge-ai-reasoning' LIMIT 1),
    'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
    'default',
    'pcp_1542bfe079ebeca0497048a2afc4e83b5a7bc77df8c6ed47',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-constructiondirector)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-constructiondirector' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_3df46c903daabe8dff837cadc948fc072e7acc84752302ff',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: procurement-domainforg (procurement-domainforge-procurement-contracts)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'procurement-domainforge-procurement-contracts' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_b1775e7814db5d7629588f8144307e6275a026413b2ca286',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: council-domainforge-go (council-domainforge-governance-standards)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'council-domainforge-governance-standards' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_ac12f9fb618fa57d759c9d4a432de94c0a3805f749caf63f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: strategos-domainforge- (strategos-domainforge-strategic-planning)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'strategos-domainforge-strategic-planning' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_264ccaaac80ea427a56df06c5bd1afb8ca36d45636838878',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-publicrelations)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-publicrelations' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_55e3f262b912cde98ff2103e8418a5be0967bd25557ada2e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-design)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-design' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_d8476ad1bd5dc11aad52abaa6e24ca57984be54f060212d6',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-financialcompliance)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-financialcompliance' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_94a56c48b1aefafd4138812788d4cc324753379cee8b6200',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: contract-administratio (contract-administration-domainforge-contract-administration)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contract-administration-domainforge-contract-administration' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_fc913e9da2ddbd6fd4cdbb53f1973aa1e00fbc182edbe241',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-salesdirector)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-salesdirector' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_995bc290611f16aed46a6af8e67b800bff678a09d4817cc5',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-security)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-security' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_4e95887d86a9df6f46b982c2977749ad6157cab847f88f88',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-localcontent)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-localcontent' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_88d9a03936abd8b2e968ab6c9caf505041c88021eea1d13c',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-environmental)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-environmental' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_0d1202cebf615fa4a000e98b375369576a85f0bd49b1affe',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: orion-domainforge-ceo (orion-domainforge-ceo)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'orion-domainforge-ceo' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_0792de46d51bf5a94184331cf18140afd58a93cb5d6b03b1',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-landscaping)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-landscaping' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_7f5df308dca5363f496cb2529ebf9dce39fa2cb1192d59e5',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-counselspecialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-counselspecialist' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_c12186652b13b1fa26a8d09539669bd44a9d835c852ada56',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: procurement-strategy-d (procurement-strategy-domainforge-procurement-strategy)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'procurement-strategy-domainforge-procurement-strategy' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_741b43b7e70b48a9416862a5fd54cdca3ad70b12bb14721e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: contract-administratio (contract-administration-domainforge-contract-administration)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contract-administration-domainforge-contract-administration' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_8d17fee3c8748c900a593f70c38592824a4af0a4cb58dd30',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-otherparties)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-otherparties' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_458d05ae82a54e93664ae510c24a3ba81854efb2646ad8b6',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: structural-domainforge (structural-domainforge-structural-engineering)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'structural-domainforge-structural-engineering' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_1a2373eeb3ab5291cebb276bacc59156b7704a2f822cc16c',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-hsedirector)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-hsedirector' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_cb78d99f857ba5b841380d05227eb26d8ca07079e2c2477a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-mobileworkflowdesign)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-mobileworkflowdesign' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_e8e181ed6a5f5ef69be1d650c6fc510af53af16da91a9c6b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: finance-domainforge-fi (finance-domainforge-finance-cost-management)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'finance-domainforge-finance-cost-management' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_38fc701ff9d67cc65f166e04a0a1f323edbdb51f1a3d44aa',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: civil-domainforge-civi (civil-domainforge-civil-engineering)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'civil-domainforge-civil-engineering' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_21aa4d7ef992a3b856730d8c6342bb6db0c06e07b600faeb',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-sales)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-sales' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_cdd349e9e80ac5b6b4353fc9fb73bf83c49ccb254aef9b92',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-buyerspecialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-buyerspecialist' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_1026befecc464d88e7a70b3414f5f3c785ab48af19b3deda',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-contractsdirector)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-contractsdirector' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_73dc74115c75c3aebfe5ba97ecfe162879ff2732595eef8b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: civil-domainforge-civi (civil-domainforge-civil-engineering)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'civil-domainforge-civil-engineering' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_6fb01a7719ca905c89af52b2abff22e4e8281750c8ab770e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-projectcontrols)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-projectcontrols' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_2ae1b62dfc9ed159dc301bb3b2306ebbd6807fc603c7987e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-inspection)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-inspection' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_eb15f1746315b6013b9d07a41f9f320838bd897a7642c531',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: safety-domainforge-saf (safety-domainforge-safety-risk-management)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'safety-domainforge-safety-risk-management' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_2ebdef630414d66fb87b2584f312830542c083dd32ce10a5',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-sundry)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-sundry' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_5cd5555d3a643cf23833095a83e58f36667c62482c11cacb',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-health)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-health' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_556752c371d409fa4ccda9a16ebd3f082b782b17ed53b50c',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-transportation)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-transportation' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_5ab52f13b61855edfcf9f98d85cdeb1630321c01ab0c2699',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: quality-assurance-doma (quality-assurance-domainforge-quality-assurance)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'quality-assurance-domainforge-quality-assurance' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_9efb3eee863585bb41afb8e2d36d7af406b826f42808addc',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: quality-control-domain (quality-control-domainforge-quality-control)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'quality-control-domainforge-quality-control' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_41fd40cf7b1c787dbd8c7b9048b8e34ed06a384f3fea4cc3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: procurement-analytics- (procurement-analytics-domainforge-procurement-analytics)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'procurement-analytics-domainforge-procurement-analytics' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_39e7106714c69569acd762ae9796f31f0cadb74a0e7ffa6b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-evaluator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-evaluator' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_3d9224fe9a242583f264b24f44c9daccdefef9b954ccb320',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-engineeringdirector)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-engineeringdirector' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_668a13a8879eb0b42211e34aaf9428fb0dcb5eb876e22288',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: strategos-domainforge- (strategos-domainforge-strategic-planning)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'strategos-domainforge-strategic-planning' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_7c96e7ce7e0c767e0db9894bb30c2d657de3ddcfe7b39503',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-chemicalengineering)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-chemicalengineering' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_707481d4dc119ddc69d77387039a33638098214bff448eb5',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-architecturalintegrat)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-architecturalintegrat' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_a098235bb42640c0b139bc5b1b72576ea2cf27b77373ec12',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: council-domainforge-go (council-domainforge-governance-standards)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'council-domainforge-governance-standards' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_c9af54379bb33125b1088d40efd775725b4f5c91977a7bd0',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-contractspreaward)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-contractspreaward' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_2bf954d7d719588257ef09717ab1f6169de5bbffb97d98d9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-guardian2)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-guardian2' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_39d6725df5658eca04a64c06ce6a2e5d58ffa6617026de1a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-logisticsdirector)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-logisticsdirector' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_8d8f3ebbab243a0fe2fbc9b4d80364dad4cb24858214c05a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-processengineering)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-processengineering' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_1c821ce77d9cd7445bb547b33e16dacf047b087d1e3bac35',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: finance-domainforge-fi (finance-domainforge-finance-cost-management)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'finance-domainforge-finance-cost-management' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_707f3698b7dad43415899da92683406d2b64202f533ecd62',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: logistics-domainforge- (logistics-domainforge-supply-chain)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'logistics-domainforge-supply-chain' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_4e1ae1cc2f9f490e02ec6650f3764f74bc25ccda43559526',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-financedirector)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-financedirector' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_5aab85e0f33d86f26ca95a3f1559bad5efd91e4dba2ac8fe',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: structural-domainforge (structural-domainforge-structural-engineering)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'structural-domainforge-structural-engineering' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_03c19d727af6bbbb38a8baf08654319119711335f7d89a62',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: procurement-domainforg (procurement-domainforge-procurement-contracts)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'procurement-domainforge-procurement-contracts' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_d4566076f20905fb43a7bedc6356dc89fcec0d3ea0502440',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-ethics)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-ethics' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_5851498792c2b06c5cca18a913d87d7d694b2355ffe850a4',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-inspectorspecialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-inspectorspecialist' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_bf5b65eaff40f136df2784622d6e578adfb2c8c6b6186436',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-directors)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-directors' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_52736f33ef2e1cc75ba917d7f5be5d4d9bcc38118ea34af8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-scrutineer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-scrutineer' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_b534a8b29b11f0007431e6cfac30f41cf537e458ca5d1e4e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-contractspostaward)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-contractspostaward' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_da235e2402ae91e4c28b76ef3edc2de68fb3ac650312cb3d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: construction-engineeri (construction-engineering-domainforge-construction-engineering)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'construction-engineering-domainforge-construction-engineering' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_2a3161ddc827da0d9268c783ca8df33a53632c93b9036ec4',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-commercial)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-commercial' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_ea136523605ca6abb46253e62a8d3948b9f0ad3c61f5594f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-treasurer2)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-treasurer2' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_529bdd2cc27a6aa9dfbe92d14593d2c6007d458289f744e3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: legal-domainforge-lega (legal-domainforge-legal-regulatory-compliance)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'legal-domainforge-legal-regulatory-compliance' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_b512958f36c109f9058bb0ce341163d0cb9d6c826cc40530',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-mobiletesting)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-mobiletesting' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_e2e0792711fc40b51cc8a84f21a9b027261fc4aca3f3603b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: orion-domainforge-ceo (orion-domainforge-ceo)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'orion-domainforge-ceo' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_ba261d2b6f5de516002f10a40f64fd3cbfffe59004bb0b73',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-dispatcherspecialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-dispatcherspecialist' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_6262935766cc2beebfeea83b6e1349dc8c1826bcfc9c7933',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: quality-assurance-doma (quality-assurance-domainforge-quality-assurance)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'quality-assurance-domainforge-quality-assurance' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_8a1894f0b3a2c3c5ca5370f192034262329a5d961b78ff3f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: safety-domainforge-saf (safety-domainforge-safety-risk-management)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'safety-domainforge-safety-risk-management' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_54f322888bc2812170b9f77a214df2ce0c475f031f0ab564',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-mechanicalengineering)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-mechanicalengineering' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_86b26e0858534442b1bc70b54540e05a748a28171ece6e22',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: geotechnical-domainfor (geotechnical-domainforge-geotechnical-engineering)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'geotechnical-domainforge-geotechnical-engineering' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_64935a14d124c297ceb4355dee7d5ff3bedcb68e39f9d579',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-directorproject)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-directorproject' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_4209263f7a32bb1f848564e57a216569b4da4f2692200232',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: quality-control-domain (quality-control-domainforge-quality-control)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'quality-control-domainforge-quality-control' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_06d77682c711b92d134f22ec2a53972438c10451052f5a5d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-architectural)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-architectural' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_163d1222ec32dbb94b06389e44cdc762509c13200751a8f7',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-documentcontrol)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-documentcontrol' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_492f9c4144e19109c58e871ee7f130e452aade8e700eb09e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-electricalengineering)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-electricalengineering' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_bbbfd0e9cafebc76297d6fc217035715e518ecc6bde30cc9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-informationtechnology)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-informationtechnology' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_acbc47afaba861dcaf26d80532e4bad7d716f4023441ba3d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-suppliermanagement)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-suppliermanagement' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_375e90c87eb540d00a9216b0df18ba449a5ba729d68fbbb1',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-quantitysurveying)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-quantitysurveying' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_e354f3cfe97955783a9aa000f07f647cfe840d7c7b691e94',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-scheduling)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-scheduling' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_5c0395613bb97cf7cb8363f0773744627d66b51c276cb377',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (domainforge-ai-procurementdirector)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-procurementdirector' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_946d4836e0f013c6917a4caa959f331923e21b5c4f5044ef',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: geotechnical-domainfor (geotechnical-domainforge-geotechnical-engineering)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'geotechnical-domainforge-geotechnical-engineering' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_2543d7b70677dfe4886b451f18955b84d4514f44ceb84fa2',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: legal-domainforge-lega (legal-domainforge-legal-regulatory-compliance)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'legal-domainforge-legal-regulatory-compliance' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_fc5077712c5cb35f79c6a89e649af61d2f10c9360cf1a093',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: construction-engineeri (construction-engineering-domainforge-construction-engineering)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'construction-engineering-domainforge-construction-engineering' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_1eb13f174a9ddfa5b5422e456daaf1aea5e3972facb31ddd',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: procurement-strategy-d (procurement-strategy-domainforge-procurement-strategy)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'procurement-strategy-domainforge-procurement-strategy' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_19d801737735e9bac6036b1008db16ef0812ee94f585e1d6',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: procurement-analytics- (procurement-analytics-domainforge-procurement-analytics)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'procurement-analytics-domainforge-procurement-analytics' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_95bd98f4ef4843c2819738da1b4f4ad264f462900f936ae2',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: logistics-domainforge- (logistics-domainforge-supply-chain)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'logistics-domainforge-supply-chain' LIMIT 1),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
    'default',
    'pcp_801749d0f930e70de6178b6bd265f79f9cadf8da9606c3af',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-taskcoordinator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-taskcoordinator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_3ec7bfdd5d1432f48a0a4a3f6bf65675178f49b0325c2c90',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-securityspecialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-securityspecialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_a8593e000a131c97a0d4104bf56234f413eaf44b63251cf3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: maya-loopy-content-str (maya-loopy-content-strategist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'maya-loopy-content-strategist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_6bcfc418449c2de463d5cc454d908080671f84ed4047c55b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: VLC-LACEO (vision-loopy-ceo)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'vision-loopy-ceo' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_9a33563c0d9b67b93855b89c78e38a5ae49c5d945b2749eb',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-presentationspecialis)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-presentationspecialis' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_04c982c26660bb2b7b9abcf514827dbbce0e02fe10c14ed1',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-intelligenceanalyst)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-intelligenceanalyst' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_e7a5cda322acecc0b0de87771429a3a0b375c27530ceafbe',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-systemsintegrator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-systemsintegrator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_75fb689fcba50a3ea61a49702ad4bc4e0a3e3bc6d1d67575',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-datamanager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-datamanager' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_69ceb1cccabdfc1d4f99a965278280683a62d4d313f4178d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-performanceanalyst)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-performanceanalyst' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_bf0cfed6c49bd9350223999aed9c22bd7b8ec5d03143c6d0',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-automationengineer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-automationengineer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_51bebccf636c3111195f74cd6d8414d797c4d129d8d8932e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-communicationsmanager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-communicationsmanager' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_7decfe07a386e32542013ad7eea0569bcc5e6a2f3f3d6f80',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-knowledgecurator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-knowledgecurator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_842de5f50fbc8014911ba97891bb2dcb634a8c4114bd3410',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-strategicadvisor)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-strategicadvisor' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_997c13d32e0614b97a7edb553cc6451b9ff15a9960e8de3e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-researchassistant)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-researchassistant' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_253ff9c5d387e914cb2c68fad446a194e1db1271ebf834c2',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-workflowoptimizer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-workflowoptimizer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_a92b8801c445699e3be3d598a8b17b43fd764b4792c87664',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-scheduler)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-scheduler' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_f600aaa799fe068e2ed7cdd05aaadc671f24b49f03918b5f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-personalassistant)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-personalassistant' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_c56dd4ddf7f016558bd1f5ec1232b7505a7d62ac1c46a6fc',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (execforge-ai-chiefofstaff)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-chiefofstaff' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440010',
    'default',
    'pcp_3b3776f45f466b006934738fdc889cb7acddf3d5129b1a55',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: N-SDS (infraforge-ai-nimbussupabase)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'infraforge-ai-nimbussupabase' LIMIT 1),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'default',
    'pcp_f55bb85c2ab554c3f1165cc324ba6e46574322356e881947',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: RDS (render-deployment-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'render-deployment-specialist' LIMIT 1),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'default',
    'pcp_054f48773b2c480ceaf1698d562692901b903c39d03cd419',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DIA (database-infraforge-database-infrastructure)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'database-infraforge-database-infrastructure' LIMIT 1),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'default',
    'pcp_2ff3d2b4c11e6f6a935a3b9c6f912ee817de6fe07d7a7cd7',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: orchestrator-infraforg (orchestrator-infraforge-ceo)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'orchestrator-infraforge-ceo' LIMIT 1),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'default',
    'pcp_3c8dccaf654d65d518d8ebe71d2cefa929ec18c46b3b78b3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: supply-chain-integrati (supply-chain-integration-infraforge-supply-chain)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'supply-chain-integration-infraforge-supply-chain' LIMIT 1),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'default',
    'pcp_242fe38d9ef1f1474b54734b824c26f1490bc98f9657d90e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: postgres-infraforge (postgres-infraforge)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'postgres-infraforge' LIMIT 1),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'default',
    'pcp_540e87bc6928dfb5145794ff3281678531c9efc78c603a79',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: mobile-api-infraforge- (mobile-api-infraforge-mobile-api-integration)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobile-api-infraforge-mobile-api-integration' LIMIT 1),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'default',
    'pcp_5a1d02b7244f5fe51ded45eb14ea4d568554abeba2413935',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-cococandy)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-cococandy' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_5b400b3ee7f1791ec0e6ec3f6c476eeadddea17fec398a29',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-hazelhecras)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-hazelhecras' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_8adf5b6e7afa493e6be0b93e4572a27165b1cb8f42d78b8f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-astroasta)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-astroasta' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_c8e8a20277c97402c8eb454a2ef3b88057f83bc9c308c156',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-wileyprojectwise)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-wileyprojectwise' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_72fba851369e2544dec3a3317ca698e1251381853b89f78a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-aceaconex)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-aceaconex' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_7e1657a8334faf36a2d07bad1ec2a4c1bcece2ae0f2df6fc',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-terracivil3d)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-terracivil3d' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_7702929a6aca28d76110146a20de524e2b6ccb8b3183fe1c',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-novanavisworks)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-novanavisworks' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_ca12c63fefa61cf6bee52e1806c18437a67eecdee3032197',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-stormswmm)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-stormswmm' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_1a7b20862740a219c02de9783d85b719df0b57572c6009da',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-blakebuildsoft)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-blakebuildsoft' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_f6d0bb75f4fb8b9bf3132ab345013b493825fe2a5fdcc5f7',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-elietabs)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-elietabs' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_aa5b1433c83d1904868802ec6ed4c268074ae1bbce7409c4',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-rexrevit)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-rexrevit' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_deded5bc1ed645db8cabdd17f8d51f6ce5eaa49c1ed59e0e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-sashasharepoint)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-sashasharepoint' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_568be95970e33167d5255e6222ddd88253af89d2fd457a4f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-phoenixp6)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-phoenixp6' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_952a5547cc140999349a8cd2b11be7ebd35bcdf24b052b08',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-stanstaad)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-stanstaad' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_7c6a28fc6844b7a30560c359b3415f3f8cafd3a6940ac411',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-coreyprocore)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-coreyprocore' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_463044502d173056ed6f2c96d65f24f29c3f442f50eba4a4',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-cashcostx)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-cashcostx' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_5dd37d89d0c98e8bae774031567ec7dedc44d86f5310326e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-adaautocad)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-adaautocad' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_8a341b77d567a70190bbebd36af0fc97c3855eecec3c7313',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-pixelbim360)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-pixelbim360' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_cf0e7b3c5257e287968484baafd91770ab0588616dc3313c',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-ziggyorchestrator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-ziggyorchestrator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_06a7c9343e2aa087ef78f5cf30910fd232f68d65150734e5',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-trixtrimble)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-trixtrimble' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_2fd7b517b9e2c997bb5362c86ea8a91107462791447ac75d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (integrateforge-ai-maxmsproject)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-maxmsproject' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440000',
    'default',
    'pcp_e27ceed08bf4d912224098ce8d577c394ebe12ea3c4df963',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Directors (knowledgeforge-ai-directors)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-directors' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_0502d311945404e57eae89a56a94edcae216e0d611bf4c01',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: A-p (knowledgeforge-ai-administrator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-administrator' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_8c47249384940d74ff789b7c121bb5f5858e0a1ac0907c58',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Generalist (knowledgeforge-ai-generalist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-generalist' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_de25d0e79be172d728ad901b1b834ae71de7d07e1c289249',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Negotiator (knowledgeforge-ai-negotiator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-negotiator' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_8b860b4b5e50532067ecb8f820cf312dba4265edceea5775',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Specialist (knowledgeforge-ai-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-specialist' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_28a266de5b611c41155c9888f7493213e5eca0f5c331b824',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Sentinel (knowledgeforge-ai-sentinel)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-sentinel' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_15c1db89eef3efb20509135d720ed60e686a4e187d559e1a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Physician (knowledgeforge-ai-physician)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-physician' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_d6078eb1952a8aca419852a43fceae41998e51f245679a92',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Constructor (knowledgeforge-ai-constructor)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-constructor' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_8114791a765348184f1ea7190743dac77f6300f40d3717dd',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Geologist (knowledgeforge-ai-geologist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-geologist' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_d9630e8db656548ec967522046abfec6a615b6dad8fbe37d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Co-ordinator (knowledgeforge-ai-controller)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-controller' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_d737c256bdd418e251b9f84177c3ca577943e8a33e1d1a42',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Designer (knowledgeforge-ai-designer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-designer' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_508b44ebee925c7e6e100ecd741d13fe92b88df7312cd942',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Salesperson (knowledgeforge-ai-salesperson)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-salesperson' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_66514aa0704b6028c2ad210cbb257ab502c27102ba358682',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Technician (knowledgeforge-ai-technician)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-technician' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_e43e82b84048a14ebe68b98560b6e7546ea620026417cc95',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Chemist (knowledgeforge-ai-chemist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-chemist' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_f0214f5c2b52169ec538ba18b818976a162bc26b7d151d96',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Guardian (knowledgeforge-ai-guardian)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-guardian' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_af84f333bcbda54e4adbada99d6685ad1d9021872fab4697',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Builder (knowledgeforge-ai-builder)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-builder' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_814d830a6367677009573e533491d38c8c415731b3c94671',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Merchant (knowledgeforge-ai-merchant)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-merchant' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_af4786a7c73b7446ab5d548a73b6494cc496bf4d35e249be',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Inetrmediary (knowledgeforge-ai-inetrmediary)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-inetrmediary' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_103180b8b15912fa6450d253589a3545031f7554487182da',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Leader (knowledgeforge-ai-leader)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-leader' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_5dcad37123df9db04fa795c9997c2e08a9b3f7be0c41c641',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Engineer (knowledgeforge-ai-engineer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-engineer' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_7c862cd9f17655e383d2e4752c255503433b93c21cfe3329',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Communicator (knowledgeforge-ai-communicator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-communicator' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_030271bd75727c4cf250d65780c59467f6eeddd9e11713c5',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Treasurer (knowledgeforge-ai-treasurer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-treasurer' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_0e6e9876aa4eb5f752c7bdf1f0e8b91182ca117bbe0b818f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Environmentalist (knowledgeforge-ai-environmentalist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-environmentalist' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_b0d883a30030568e35e53600ab3c9962ba278b5da519b20d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Counsel (knowledgeforge-ai-counsel)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-counsel' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_2474637a84b8b76be65965212755fc78983776e209ef8b3c',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Buyer (knowledgeforge-ai-buyer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-buyer' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_e158a2c5b8e6f02a9b5abf446d58b4ad4bab5062240a4b8f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Scheduler (knowledgeforge-ai-scheduler)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-scheduler' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_620e8512289702e949908463a4f627da3eb9b9fe75d28b07',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Examiner (knowledgeforge-ai-examiner)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-examiner' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_43f03270105ffb9157bb810127e2ffa0c63aed4f3e1643c2',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Ethicist (knowledgeforge-ai-ethicist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-ethicist' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_6dedbca93c3b1096cce937fb52ebc75d2d8c5450a966dd1a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Landscaper (knowledgeforge-ai-landscaper)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-landscaper' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_deb9ccc8010e92656da249f92879dc1555df18cddc5eb8ba',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Greeter (knowledgeforge-ai-greeter)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-greeter' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_0a33e6942a636193e313478a89b6992e400cd87e8eea99c8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Chairman (knowledgeforge-ai-chairman)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-chairman' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_f1470be9e7f6e27c06beae64a22dbb28a2e7ee5fd4e5892b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Critic (knowledgeforge-ai-critic)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-critic' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_d6f156814d1c7cf8e0d237440b9575763863dee444d62b3b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Concierge (knowledgeforge-ai-concierge)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-concierge' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_4aec2e314e940a85c9f3ed7ac99851b3c9ccb3b477d4e543',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Governor (knowledgeforge-ai-governor)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-governor' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_8e8b52289366c5b3932940adc93e768fb3558333e5917ecc',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Optimizer (knowledgeforge-ai-optimizer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-optimizer' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_a5e607d62e10620dc98e01536ae2552ea5fd0ab26ca3b664',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: AmbiguityPrime (knowledgeforge-ai-ambiguityprime)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-ambiguityprime' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_c18c9862b8e97f16d4c2fbb7828d5188b0d24c9606f46ee3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Gatekeeper (knowledgeforge-ai-gatekeeper)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-gatekeeper' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_d0fc732928cace656faddb255f7cdb0463e0bf61bcc8572a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Inspector (knowledgeforge-ai-inspector)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-inspector' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_2e5504185453fe5c4bc6bf137abeac31daeea0bb2c60103b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Archivist (knowledgeforge-ai-archivist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-archivist' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_8d8cd7b9cfa9cd8d1f194257c3fc0b081a239464d9d35006',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Surveyor (knowledgeforge-ai-surveyor)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-surveyor' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_e36cb91a2796a4d18d860ab544890be9a66b1491cb1cf573',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Developer (knowledgeforge-ai-developer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-developer' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_43b6d58aed25b1514ca568333545c97b2868a1668dfd288f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Electrician (knowledgeforge-ai-electrician)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-electrician' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_836e54ae9562aedfb78d8f794883af3271868569603e045a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Dispatcher (knowledgeforge-ai-dispatcher)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-dispatcher' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_71115860462b050a94687a541a0a130090fee33f49c567e7',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Co-ordinator (knowledgeforge-ai-coordinator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-coordinator' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_2fe83e3997d715170ebc84ee7d9635b10b6ba650b16cde7d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Architect - refactor (Architect - refactor)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Architect - refactor' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_554365613fd0369dba8b82810644e2c64722653e9d906dec',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: User Manager (User Manager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'User Manager' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_546102c82d1e40674931081f5c2d8fdc863f0687b6bcb32e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Development Manager (Development Manager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Development Manager' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_08f751f7b9b5275aadfa150a76dafbeceaef5624a6831042',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Communication Manager (Communication Manager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Communication Manager' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_00200293681518954b808db359ff675d705bde851e5efa35',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Director Project (Director Project)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Project' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_0ca74a4f612ca921135b7b49dd0bb9fe68660a61ef983170',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Director HSE (Director HSE)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director HSE' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_fcc2c12e3b7dc005e2266d69ad4ee7a24093eff67c9ba3e9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Director Sales (Director Sales)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Sales' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_fad64f08b01651eb52fc29e48eff7b8eac3b22bf8ebef695',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Director Procurement (Director Procurement)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Procurement' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_346c01a6a517b2c175bbd1d30e518ad208a5abbb84e5c071',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: System Administrator (System Administrator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'System Administrator' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_92f0e188e54adb2f8a77e205923ecc64f92a191cd7ab631b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: AI Manager (AI Manager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'AI Manager' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_e222ecbe7797f06b8424216793e3063521df88822b186401',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Monitor (Monitor)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Monitor' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_19e9780d22ba0bde4023e794211f513d67d84b6055f5ed28',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Operations Coordinator (Operations Coordinator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Operations Coordinator' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_9bbc2d52ccd81e84faf86d72d9dd0c3ca3359cc58a6b3a7f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Director Logistics (Director Logistics)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Logistics' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_e333e4ff4932a3140501dca35f48da80ce22a340907a0c43',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Investigator (Investigator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Investigator' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_44cc84bedd32a21167e8be08f19af2c9a344d39dc5e41916',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Integrator (Integrator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Integrator' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_b0a6689b673fc098e86360bb9311ee7d504e215a82476df8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Architect (Architect)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Architect' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_03bcd35c6b4be0f07af892639f3cc2c914b8a01c419f33d1',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Director Engineering (Director Engineering)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Engineering' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_75378e9dc58fa2e2b0557f66fa4984b1afc1f9acac2a7986',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Director Logistics (Director Logistics)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Logistics' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_91103a68a565c01e30a036eab2931462bd0439b812af5f26',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Analyst Sector (Analyst Sector)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Analyst Sector' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_813320ca53deb03c4a268fe47fc8b99487d9c46758cc0b10',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Director Projects (Director Projects)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Projects' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_dcf49d830fdec098b2a2a6f8ad63c0b80c2e4df03187c988',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Director Construction (Director Construction)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Construction' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_18ee58a040f5bc79a9f6e2bb81b24464b2459ec9f91f7ad9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Quality Assurance (Quality Assurance)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Quality Assurance' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_a03ba1755b36271a9f03d45e341c6a45c9574dddbb1fa332',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Administrator (Administrator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Administrator' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_8193ee1c814819f7f34ce82093d743c0730a65b3a72cb44a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Inspector QC (Inspector QC)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Inspector QC' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_b6ebabe91d56afeb5a21f0cc1f9d9c2607a7290cb49a0aba',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: KWG (KnowledgeForge Workflow Guardian)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'KnowledgeForge Workflow Guardian' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_bccdb43057f82f893f8c1f060e99a9f199847001586811ba',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Docs Analyzer (Docs Analyzer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Docs Analyzer' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_cab74f4f8b419b61547be1324ef17e9dc47f55519fd13552',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Advisor Disciplines (Advisor Disciplines)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Advisor Disciplines' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_c72f14e1d2dd654a4415c1fd1458351583a49172405b6cec',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Validator (Validator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Validator' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_34098947148fd2f9e72b931286c0b18e799fe50fae939322',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Interface Specialist (Interface Specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Interface Specialist' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_b645207d7d8b3eec7a9b5f27d0f9272fe0f55130f487a8cf',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: A-p (Administrator - pre-award)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Administrator - pre-award' LIMIT 1),
    'c4d52645-a0ea-4a26-b381-baf0b3042f34',
    'default',
    'pcp_97446eee301fe59dfc0ae3fa5dd029174c7d8ebfdeeb1a7d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: AMA (learningforge-ai-assessment-mastery)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-assessment-mastery' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_6e83b32217732f6497143f988094ce147f1244c146770eab',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Error Pattern Monitor (learningforge-ai-error-pattern-monitor)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-error-pattern-monitor' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_8d5e10410104a1a1a382e00cf9423a18309b2329640138b1',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: User Behavior Analyst (learningforge-ai-user-behavior-analyst)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-user-behavior-analyst' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_46710ed8641859f6a6e9cb8d445167bef277666f7a0159e5',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: RCDL (learningforge-ai-research-compliance-division-lead)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-research-compliance-division-lead' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_1926cdac83682be73676b9f5e1cec9df19e4c63353221b36',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: EIA (learningforge-ai-equipment-inspection)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-equipment-inspection' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_1dc01cb805807f8a898091276e3f456685b2ffa78077afa8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: AGA (learningforge-ai-autoresearch-gap-analyzer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-autoresearch-gap-analyzer' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_278d2fee4570e4beeb75c9cbd273d468fded52d0bf85231a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Doc Usage Analyzer (learningforge-ai-doc-usage-analyzer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-doc-usage-analyzer' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_9ef9fff5e6e15bfa6b64690a1c4c2cb247201aafa68ddad1',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: SRA-LA (learningforge-ai-safetyresearchagent)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-safetyresearchagent' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_0b08d7b2ce4270469b35c45e1e03d68ac4f2a4c0649557f6',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: EEA (learningforge-ai-electrical-engineering-agent)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-electrical-engineering-agent' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_60d23a6d7bfd0c12a8fdf313b140092752d8e1dcd1da3bde',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Hazard Pattern Analyst (learningforge-ai-hazard-pattern-analyst)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-hazard-pattern-analyst' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_741b4fb8ed98fa33d1b04f5999bae8af3694cd8564715244',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: KPA (learningforge-ai-knowledge-provenance)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-knowledge-provenance' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_49a4411523823c8876fa5549542f2f27d8c83bf15500d9f3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: FDTLG (learningforge-ai-from-doc-to-lesson-generator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-from-doc-to-lesson-generator' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_28bf4577133a67e5295750a7e8f9d5fa23d6b393b42677b4',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: IPC (learningforge-ai-interaction-pattern-coach)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-interaction-pattern-coach' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_7e64f2fca8df9eadbd50d7ee24d71fed0762e8157f23cfac',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: VFS Watcher Agent (learningforge-ai-vfs-watcher)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-vfs-watcher' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_d13301a4ec97565a607b22dc21afa46ab3d51d7215d07efd',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Quality Learning Agent (learningforge-ai-quality-learning)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-quality-learning' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_f908b888a4528ba2cde9988ed2dca8f60ef9bc0060ba2786',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Compliance Guard Agent (learningforge-ai-compliance-guard)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-compliance-guard' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_7e6673404b086b1aaa65fbd5a6e508768b6f298ce53a5f43',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: RSA (learningforge-ai-research-scheduler)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-research-scheduler' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_c19f93a3d91563cf92cdf041a08c4ab2df67503c61c6e894',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: SRRA (learningforge-ai-safety-regulation-research)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-safety-regulation-research' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_a21a022c5917a36f7f2ab91c6de8ce98497e2680ae4c173c',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: MPA-LA (learningforge-ai-mobilepatternsagent)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-mobilepatternsagent' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_451f3d0a7d46e48a5356af94f9277413dcfe82dcaf784b6b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: LIA-LA (learningforge-ai-learningintegration)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-learningintegration' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_fa37f448d88502023346c7f377489b2c08f3f84a4b0dedce',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: MDT (learningforge-ai-material-defect-tracker)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-material-defect-tracker' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_fe5e612d302cef879afa07e009d297f0dca7fd40a5f3f7e3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: STCA (learningforge-ai-safety-training-compliance)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-safety-training-compliance' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_0e9ddda4ed4fd8d6a6cdc80769f5a7443be02b17c9e2dd0a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Procurement Agent (learningforge-ai-procurement-agent)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-procurement-agent' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_d685139f478728371bcdbcef916b22afacee436e6575efc1',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Safety Workflow Agent (learningforge-ai-safety-workflow-agent)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-safety-workflow-agent' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_75c8b12d0a98b54ed3c4586532effa23f98968fe9fbc4e38',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Doc Gap Detector (learningforge-ai-doc-gap-detector)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-doc-gap-detector' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_c3b65a89cea5276b8fe28d7ef3b4e8ee8ef581f654388ab6',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Hermes Research Agent (learningforge-ai-hermes-research)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-hermes-research' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_1fd44fda6d6d11fef9a343326c008251c3f480cb205a7090',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: EIRA (learningforge-ai-equipment-innovation-research)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-equipment-innovation-research' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_6e768b6959333a7705fa3bf3cf0bd4941162c48db09e6ce9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Learning Division Lead (learningforge-ai-learning-division-lead)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-learning-division-lead' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_a25ad9a9a04e432a7ef9a7966777646f609156914fe22069',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: GA&BA (learningforge-ai-goal-alignment-budget)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-goal-alignment-budget' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_b6c64047e1e3d1f33ec4f5b1f4ea9c4ffda08f77594f6d8a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: KHA (learningforge-ai-knowledge-hygiene)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-knowledge-hygiene' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_9bb69027c6f441108eeebed9e02df76567fe327b6f497cc8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Audit By Path Agent (learningforge-ai-audit-by-path)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-audit-by-path' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_9abd9818f1e3182a3cbaf60d9cbad82b34eef7d097455c26',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: LangChain Runner Agent (learningforge-ai-langchain-runner)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-langchain-runner' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_f3dceba035023437bedc19213ccccdfaeda101f9be8cdb28',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DPRA (learningforge-ai-defect-pattern-research)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-defect-pattern-research' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_d812a6108d1160095ba39dde8a037891f8cb27f13ca0fb35',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: SQDL (learningforge-ai-safety-quality-division-lead)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-safety-quality-division-lead' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_d34ce07f29005c5b92b5bddd9cf85b9d157438012e03fcec',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Logistics Agent (learningforge-ai-logistics-agent)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-logistics-agent' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_7859ddd542f2957aeea8272c154fcb7ba1b8445ed4e76461',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: FSA (learningforge-ai-feedback-synthesis)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-feedback-synthesis' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_96d9d55fe54aaacea41893d6df8bd2f044352a4af90eebcf',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Workflow Coach (learningforge-ai-workflow-coach)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-workflow-coach' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_0f15ed68e034477b614829fdf7374074f31213ef096c2291',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: ASE (learningforge-ai-autoresearch-skills-enhancer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-autoresearch-skills-enhancer' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_253843004bb28745e3716e6068aef6fdf8a9c4ae616610c1',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: KFDL (learningforge-ai-knowledge-flow-division-lead)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-knowledge-flow-division-lead' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_75d602efb84fd83a4c706772552ed71a6adc66c31566c5d7',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: ALS (learningforge-ai-autoresearch-literature-scanner)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-autoresearch-literature-scanner' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_43c01ba1439e110ee102d61a57bb7e20da92aba93513f96d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: VFS Markdown Tracker (learningforge-ai-vfs-markdown-tracker)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-vfs-markdown-tracker' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_c7ff29353c8e8d75f2e16bb511b4bb5741e68beda914d098',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: PDL (learningforge-ai-priority-disciplines-lead)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-priority-disciplines-lead' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_4ade90956deb2f23775a98aa821f55f96c1657c5f50687d2',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Curriculum Planner (learningforge-ai-curriculum-planner)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-curriculum-planner' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_bc9a724ee6994f7b25fce1e364daa826a156588e48b76156',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Micro-Lesson Generator (learningforge-ai-micro-lesson-generator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-micro-lesson-generator' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_1d18876cb3a514b9abb8dd9f0adee7702e6516266f1791e8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: A&EA (learningforge-ai-audit-explainability)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-audit-explainability' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_f3d55f9179462152dfe911dfeca73a70b44f77590a804f16',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Knowledge Flow Agent (learningforge-ai-knowledge-flow-agent)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-knowledge-flow-agent' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_3ef9b4e8990f73156aef3056e508608142c3e217e49fb76a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Field Safety Inspector (learningforge-ai-field-safety-inspector)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-field-safety-inspector' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_1c3637f466cee71aaaff95065c7e1f0e5648502c024070ea',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: CLRA (learningforge-ai-construction-law-research)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-construction-law-research' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_31ba3438aa67c59205cdf2890baf1df6a69617072d280789',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: LSA (learningforge-ai-ceo)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-ceo' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_63c4af5cbb471a9fd8c9dca61d78157f8a72afaff86c0021',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: KTA (learningforge-ai-knowledge-transparency)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-knowledge-transparency' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_0d3acde7443de5552134381619a57d69a62cbfd90be698f9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Contracts Agent (learningforge-ai-contracts-agent)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-contracts-agent' LIMIT 1),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'default',
    'pcp_fdb2e808bf60b5e316d98af859e75d84d77428dc9d60f36a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: jordan-loopy-marketing (jordan-loopy-marketing-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'jordan-loopy-marketing-specialist' LIMIT 1),
    '0a40625e-78f9-4b0a-82e4-169a8befa021',
    'default',
    'pcp_45a9ea17af687b35deb5e674cc5dbbb4e679611239620d05',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: alex-loopy-deep-resear (alex-loopy-deep-research)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'alex-loopy-deep-research' LIMIT 1),
    '0a40625e-78f9-4b0a-82e4-169a8befa021',
    'default',
    'pcp_2a0ca85799436cec3ff2eba4490ac560427fd4e70875ffa4',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: sam-loopy-social-media (sam-loopy-social-media-coordinator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'sam-loopy-social-media-coordinator' LIMIT 1),
    '0a40625e-78f9-4b0a-82e4-169a8befa021',
    'default',
    'pcp_7cdeccfdfedd1b5bbe8fe5bafdeccae929ea090d9508ed98',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: VLC-LACEO (vision-loopy-ceo)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'vision-loopy-ceo' LIMIT 1),
    '0a40625e-78f9-4b0a-82e4-169a8befa021',
    'default',
    'pcp_708eafc66a29fc29a64dc17d258a3bd3d23fb7d180304a45',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: maya-loopy-content-str (maya-loopy-content-strategist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'maya-loopy-content-strategist' LIMIT 1),
    '0a40625e-78f9-4b0a-82e4-169a8befa021',
    'default',
    'pcp_ed8412a805601bdc513f06226f14370783cd2ea0e9977e57',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: dev-loopy-technical-cr (dev-loopy-technical-creative)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'dev-loopy-technical-creative' LIMIT 1),
    '0a40625e-78f9-4b0a-82e4-169a8befa021',
    'default',
    'pcp_7e7d3c5cbabcf158f9d023bb266e65da0f0718cfc95c92e8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: MVS (measurement-validation-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'measurement-validation-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_e460ec0731f6662ab757defc99f89e3584af248aa182f631',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: VOS (visual-overlay-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'visual-overlay-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_2424b10a0b50391787c868e1668e764dc6fd51590165fa20',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: MAEQS (measureforge-ai-electrical-qa-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'measureforge-ai-electrical-qa-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_01ae3c6cd196d455d33db58c2b338bf406aa1cc50f4bd5a2',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: SSS (sans-standards-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'sans-standards-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_a96b2ed688e8b4a40821cc8e7a15594cdd725bbfadd663c9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: ASS (asaqs-standards-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'asaqs-standards-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_585c934ff878f827b17604169789431270f25cf059306a4f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: CTS (contract-tender-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contract-tender-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_087884f5e52067c1867d736501dd1c140e51d7196a6dcfaa',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: OGS (order-generation-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'order-generation-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_7386d1c776cec6aca455117f5a93c41fbe0a649d3a73e0c5',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: MAEMS (measureforge-ai-electrical-measurement-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'measureforge-ai-electrical-measurement-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_99a64474fd93a98d62874d9edae43d1a3463ac3bb1546c39',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: CAS (contour-analysis-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contour-analysis-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_bbf2993b04e02d5a1cca44d3ba2895de5e59a526ee8ed6d0',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: MEP Element Specialist (mep-element-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mep-element-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_bb1f68ff9e90af47ba611e649d948977737d9470191d1cd9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: MATSCS (measureforge-ai-traffic-signal-compliance-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'measureforge-ai-traffic-signal-compliance-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_6fa9803128c331970120dfe2104accd61697284f21ea6d2a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: MATSMS (measureforge-ai-traffic-signal-measurement-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'measureforge-ai-traffic-signal-measurement-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_8ab83641289179b910d57c8831aad9939f5cbf677a2209a4',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: AES (architectural-element-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'architectural-element-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_d5b1373275ec2811e76346139633cd2a08cae9cd269ffdb7',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: MAECS (measureforge-ai-electrical-compliance-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'measureforge-ai-electrical-compliance-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_36090f4ed8f528535c80c6ca8f6c2954037c74d59e629dd6',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: CES (cost-estimation-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'cost-estimation-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_38830f787a7695d704a0ba8cc984a0914fb922e70b4d3b90',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: SES (structural-element-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'structural-element-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_39e49c2fe3042e72a149fd988f208577439739864e8da634',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: QSS (quantity-surveyor-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'quantity-surveyor-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_c0648c684087c247bc4bca0c263093693fcf010a5154e294',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: ECS (earthwork-calculation-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'earthwork-calculation-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_cbcfe3ce503132b3f788746cbddef15e1fa908ec52c7c7cf',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: AIS (autocad-integration-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'autocad-integration-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_45d11bba1182bad198ad801a7fc90d9c698d5bd7f161e735',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: MCS (measurement-coordination-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'measurement-coordination-specialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_ccd3d66fd8bdb912e70d0243adfc0c4f2356c126809ecb5f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: CMO (cad-measurement-orchestrator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'cad-measurement-orchestrator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440013',
    'default',
    'pcp_86cd0b279871d2c913bf4123d3d84b7e5cf28bccdc0ccd39',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (mobileforge-ai-uiuxspecialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-uiuxspecialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440009',
    'default',
    'pcp_1c6ae5c4cd955b264aa42a3b78df81c06ae51c0e66474f65',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (mobileforge-ai-appmanager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-appmanager' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440009',
    'default',
    'pcp_f01dacb4fd1175f754ba1849e1a1333f8175b44faccbb8df',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (mobileforge-ai-cloudconnector)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-cloudconnector' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440009',
    'default',
    'pcp_cbfea15e3d31ddc3d9bd607047f99b00dff59713cb8f7a78',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (mobileforge-ai-apispecialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-apispecialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440009',
    'default',
    'pcp_5b23c3328f440ed5d00b4ef84be42d40a1f0b64b0fe4acf7',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (mobileforge-ai-performanceoptimizer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-performanceoptimizer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440009',
    'default',
    'pcp_ea4678d69fc5ab92ca76ea9a316c464c15169e6b6fc8b0f5',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (mobileforge-ai-devicecontroller)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-devicecontroller' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440009',
    'default',
    'pcp_c0ea650ce7eceb481b0962373b0bcfdabfe7f0b442142b14',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (mobileforge-ai-mobilemaestro)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-mobilemaestro' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440009',
    'default',
    'pcp_faf44b310f841afb6ad238c37d5d6ac05b6676f0d12244ac',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (mobileforge-ai-mobiledeveloper)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-mobiledeveloper' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440009',
    'default',
    'pcp_0a6c370798f651a8d58aa5bbd43182544578ed25829037c8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (mobileforge-ai-testingcoordinator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-testingcoordinator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440009',
    'default',
    'pcp_cb3f1b46b03fa284b89483bad763c00936d901f5c9f7f71b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (mobileforge-ai-securityguardian)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-securityguardian' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440009',
    'default',
    'pcp_41c23ed9b081f5d7c09f1e81d8d380d62d027b739d05b830',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DI-DFM (paperclipforge-ai-dataintegrator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-dataintegrator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_c36ada538c30b356c8fae15d3732cd122425670367cc55ff',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: IG-AIC (paperclipforge-ai-issuegenerator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-issuegenerator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_5b4e93a05bdfca933d03440a2e2b3205fd29cd6d1cf425b1',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-monitormaven)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-monitormaven' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_41e10b403f829f6f2d97663cba2450c0e555a3cef207019f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: OD-COO (paperclipforge-ai-operationsdirector)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-operationsdirector' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_06cc3cbc88901c321490bf16f8cfa68c7d3526067c852a7b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: AS-IIR (paperclipforge-ai-assignmentspecialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-assignmentspecialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_43252826ac81b9fe7a9023c8009afaf5842f1e230e4f1af2',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DCO (paperclipforge-ai-databasecrudorchestrator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-databasecrudorchestrator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_039c3feb3867d07d374609f1b9797ece9c1f15906e5e1dbd',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: V-MVS (paperclipforge-ai-measurementvalidation)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-measurementvalidation' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_737f8ca8428c2930410f6550307ed6824123ffa69ec67d36',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: UI Uma (paperclipforge-ai-engineeringuispecial)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-engineeringuispecial' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_738af33c001f99fb3fa8cc74ed8f8ca630ef9516e0d596a1',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-configcurator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-configcurator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_37616bdb0f7af421417dbc2dd02a804055fa5262c0b009b2',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-bridgebuilderextraor)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-bridgebuilderextraor' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_f572c2566e7924c6a8a2f9a877a3ac663b9a2ddf258703a6',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-documentarian)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-documentarian' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_fea1409daf4faa754d9daa4077cc566373e336d6edbb1ba9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: M-MCS (paperclipforge-ai-measurementcoordspec)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-measurementcoordspec' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_9ed24f4d06684869f161dded53b2b17e11f1992a23fb59c5',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: AM-AEM (paperclipforge-ai-apimanager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-apimanager' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_5808102631f39c02d79f3f4c18cc2546304ee8b5f80b804d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-tickettinkerer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-tickettinkerer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_df6187932b82ceaea8c45218a5d791f561f11ba192ff218e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: GOS (paperclipforge-ai-githuboperationsspec)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-githuboperationsspec' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_b4569045d201f92c10e2497a545ff022c4fe8e2904c1992f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: RM-RA&O (paperclipforge-ai-resourcemanager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-resourcemanager' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_15b33bc66eaa0682ccb4d2198932f431dc725c9413fa5b8d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-wisdomweaver)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-wisdomweaver' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_ee04050765f12767e9d0a75ae174fd43581197d526e1a57d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-networknavigator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-networknavigator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_bf40b16267862d42e990fe132e05932d3756e8b99e5c4b12',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: QC-QA (paperclipforge-ai-qualitycontroller)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-qualitycontroller' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_bcf9b02c069530dad1656b6a833b527be1f72524200627b4',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: R-ARS (paperclipforge-ai-agent-reconciler)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-agent-reconciler' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_21c8940b104020781741fe151f5755617d867f79e765a487',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: WA-WD&A (paperclipforge-ai-workflowautomator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-workflowautomator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_cb5a103d59f8952a40752089bbc81fdb4428b30d6df799c9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DD-DMaOA (paperclipforge-ai-databasedruid)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-databasedruid' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_99d721d0c120884d3a1625bc0b3708bcd2de88e1743848a7',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: maya-loopy-content-str (maya-loopy-content-strategist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'maya-loopy-content-strategist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_dfaaaea3fe08cb9dece557313f32867ebd6032ed9b5db55e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: S-ORFC (paperclipforge-ai-orgresearchfoldercr)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-orgresearchfoldercr' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_9da676a0e9cd22a3a6bacfeb00a577ef7d2ffde163cafd20',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Analysis Andy (paperclipforge-ai-advancedengineering)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-advancedengineering' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_44f7cd57cc82a40c0ab09282678537757c83e547f0a5d8d3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: IA-CTO (paperclipforge-ai-integrationarchitect)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-integrationarchitect' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_aab2f22d3932a4c52c1fc5fd1bb058d5810fe2f2ac07db99',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-dataarchitect)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-dataarchitect' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_5e9f7f9d92a06fb7c4c1e8b326903939b55e1932627a2954',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: IBIA (issue-batch-importer-paperclipforge)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'issue-batch-importer-paperclipforge' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_00753793f03c0b31137904f6e7dd959ae5bd340658028d3c',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-tasktangodancer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-tasktangodancer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_f6e8e3177e21460a9c2772a2932304bc79bbc7b98a8d5b64',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-testcommander)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-testcommander' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_fd2ebd34e71789acfcc9ea32813c3ea19c46f57afb80a57b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-codesage)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-codesage' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_3a660715bc19cb4ad54d5fc9b2d345e8c918dd1efb034d0f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: PC-PLM (paperclipforge-ai-projectcoordinator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-projectcoordinator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_5ad417ebce268d6594df73cdd76c28fca60ae44274b5ba75',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-loganalyst)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-loganalyst' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_910d29bfc3d21ac243cde0977b09685865b5837245f1177c',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: VLC-LACEO (vision-loopy-ceo)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'vision-loopy-ceo' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_548a25d5d03d94e3721816c2ac58657888fc1562aa3b480f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: S-MSS (paperclipforge-ai-measurementstandards)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-measurementstandards' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_38366ccf4b6bb728674b92b80d8938454e889c22bc3125c0',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Coordination Charlie (paperclipforge-ai-crossdisciplinecoord)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-crossdisciplinecoord' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_06ab9c16397c32325c9b2f4c01f16d88c1da0bfcfddadd8e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-performanceprofiler)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-performanceprofiler' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_2a5aef158fccdfa2a21a100bfb26edd14e7b4a0766bf3af8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: MAS (paperclipforge-ai-modelassignmentspeci)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-modelassignmentspeci' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_c6f707b04989d27d6eb7dfb847a92e4f3c55dfe593691a6f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-endpointenchantress)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-endpointenchantress' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_dab349bbb28af79fabaf0a93ecd8a55012e7709107c0f114',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: PM-PT&A (paperclipforge-ai-performancemonitor)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-performancemonitor' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_e2ee61312990d704ecc2b872b773c2efd6352f3cdff3ceb3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: A-ACaM (paperclipforge-ai-atlasagentcreator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-atlasagentcreator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_c8d17783d05de72cadce57b55a4f4614ed71268624b02083',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: PM-CEO (paperclipforge-ai-projectmaestro)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-projectmaestro' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_7e6e080e25ab79f139078761efc58cbeaefc853866f9d221',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: KI-KI (paperclipforge-ai-knowledgeintegrator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-knowledgeintegrator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_92f4bbc6263d8e7957bcb2f7f18a1b769d730d9b8e99a41c',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-cachekeeper)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-cachekeeper' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_637eb44aace33c80b4c2a0646be17d2c1542bc08c8706aef',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-integrationillusionis)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-integrationillusionis' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_15c7903dc353e1981cfa90371e253ca95e3ccce79e39590f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: RA-A&R (paperclipforge-ai-reportinganalyst)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-reportinganalyst' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_2fa592ff1a79e834f5727f215c9a729b4ab3068e093a6b1b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-deployer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-deployer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_9cebe28518e8cd66582ce92bc4dde4547f0c783dac3a9a21',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: UEC-UIM (paperclipforge-ai-userexperiencecoordi)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-userexperiencecoordi' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_1d2d3c24c086f3a84917c27068d29236694f08c2a955972c',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-chainlinkcharmer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-chainlinkcharmer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_66640d035cf1bdb81e6a16502258d2919ce3a5b6849844ee',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: PT-RM (paperclipforge-ai-progresstracker)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-progresstracker' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_11b563ef4ed7820ffea5297e247effe434cf53a3332dd03d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: PM-PA (paperclipforge-ai-predictivemodeler)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-predictivemodeler' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_fd20d9d12f42c48626f50e8fbd200c87ba6d26b30c823b5f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: RA-RI&M (paperclipforge-ai-riskanalyst)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-riskanalyst' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_7cab26d5e9f41c7f3f740eadd593df32f4dceaf03c3d64e2',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-securityguardian)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-securityguardian' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_5a96d970f0e392324d8c9da9ed86ccca4c02d6637ab0bc49',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-authadministrator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-authadministrator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_d2eab9d1593badff12def1e646f43edc181fd129d3e5db85',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (paperclipforge-ai-dependencymanager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-dependencymanager' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440014',
    'default',
    'pcp_adc0a7b955258f9590b57a9678aa9f5acfd009ad369a95af',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: tuner-promptforge-ab-t (tuner-promptforge-ab-testing)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'tuner-promptforge-ab-testing' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_ef078ef054f3f8a2826a75f1ae9ceda8f60d648bd775302e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: cascade-promptforge-wo (cascade-promptforge-workflow-designer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'cascade-promptforge-workflow-designer' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_e8a0473a7db8ea30922945f638d0226f80d8d0a332580e87',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: quantifier-promptforge (quantifier-promptforge-benchmarking)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'quantifier-promptforge-benchmarking' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_51e9d056cc9f3ff4b4d5c413357eb1f51f7252efc8ffb973',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: analyzer-promptforge-p (analyzer-promptforge-prompt-analytics)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'analyzer-promptforge-prompt-analytics' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_8c4deeb732976ecd028c060590874a105b6441bc214cf225',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: compliance-promptforge (compliance-promptforge-regulatory-compliance)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'compliance-promptforge-regulatory-compliance' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_2f66e97400ccb3dfefc823712830968dd0ea6d59b16c7851',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: scholar-promptforge-ac (scholar-promptforge-academic-research)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'scholar-promptforge-academic-research' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_71db5d5572610f8ea5d910c66f011e2e6a6cd2ea5822ce3d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: validator-promptforge- (validator-promptforge-syntax-logic-validation)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'validator-promptforge-syntax-logic-validation' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_15c903dcc611d756fbb01e9db544835e6e03188b82c67e44',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: integration-promptforg (integration-promptforge-cross-agent-compatibility)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integration-promptforge-cross-agent-compatibility' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_07b68d9f252a9cd86cc2456ebf6f182f9560032e50c20fb2',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: sage-promptforge-chief (sage-promptforge-chief-architect)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'sage-promptforge-chief-architect' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_2300face8cf4cdd265af578aea269da5d2e2205df10a4165',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: archivist-promptforge- (archivist-promptforge-knowledge-management)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'archivist-promptforge-knowledge-management' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_609395614c5e2909f3c6886c2b75303fc105d38ac1ebdaae',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: flowdesigner-promptfor (flowdesigner-promptforge-agent-handoff)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'flowdesigner-promptforge-agent-handoff' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_fcf0111d4b9a91f691796ddc00c9432daaa2027917de7080',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DAA (promptforge-ai-disciplineautomation)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'promptforge-ai-disciplineautomation' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_14c6e71b13026a19ac16716e630da00163a804a372c381a8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: predictor-promptforge- (predictor-promptforge-outcome-prediction)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'predictor-promptforge-outcome-prediction' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_0a0e66e651de482d7213a27a54317e8b16885ad1b75e858a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: enhancer-promptforge-a (enhancer-promptforge-advanced-innovation)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'enhancer-promptforge-advanced-innovation' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_81ac80fdf133afb28dafe727d05a77d920ef53022d94d60f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: statemaster-promptforg (statemaster-promptforge-state-management)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'statemaster-promptforge-state-management' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_a4692000cf25dae78aea4b433ed40912893fd42073148fea',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: blueprint-promptforge- (blueprint-promptforge-template-designer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'blueprint-promptforge-template-designer' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_5da0a43f14419f11f5485d2e7879fa25730b78c839966662',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: refiner-promptforge-ve (refiner-promptforge-version-control)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'refiner-promptforge-version-control' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_8ec438a0d0b6da033f8843c4bb3d373c87d85cd4e336d834',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: explorer-promptforge-n (explorer-promptforge-new-techniques)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'explorer-promptforge-new-techniques' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_b2c9e4ddb83f29fb9acb4866e316dfbba43ed37321aeb23b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: experimenter-promptfor (experimenter-promptforge-hypothesis-testing)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'experimenter-promptforge-hypothesis-testing' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_9efddc1f2911da63599a8406f6495050ce0003c0505ffc8e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: harmonic-promptforge-o (harmonic-promptforge-orchestration-strategy)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'harmonic-promptforge-orchestration-strategy' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_d713da0f2ab2064b18651c583caa38e021f3498f01b8a82a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: collaborator-promptfor (collaborator-promptforge-cross-company-knowledge-sharing)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'collaborator-promptforge-cross-company-knowledge-sharing' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_d6d201588dd300bff704a5f6e68ae534fc55019c6e0f4cc8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: clarity-promptforge-pe (clarity-promptforge-performance-optimization)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'clarity-promptforge-performance-optimization' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_201e53440792e9f3c141a2ab294868f80a9a5f62c2e68dd6',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: integrity-promptforge- (integrity-promptforge-ethical-ai)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrity-promptforge-ethical-ai' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_69ad3a4240bd6b9e39274cd9b849348fc19fe96ba138e49c',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: specialist-promptforge (specialist-promptforge-domain-adaptation)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'specialist-promptforge-domain-adaptation' LIMIT 1),
    'f02b83a8-e0db-4332-b507-22f85e71ebf5',
    'default',
    'pcp_2c84859c73b2f08205928f3a03b9ca1c73576c6e1a10d861',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: monitor-qualityforge-q (monitor-qualityforge-quality-monitor)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'monitor-qualityforge-quality-monitor' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_ab8e8c1a2b4a2ee59975c8e4bbef6ac397ab0e5d5ad0cfef',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: tracer-qualityforge-ex (tracer-qualityforge-execution-tracer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'tracer-qualityforge-execution-tracer' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_77b5f13af20c02cd11e7155e53477b0567f2499347c27d16',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: integrator-Integration (integrator-Integration-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrator-Integration-specialist' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_6be5c6f4fbd52ae7fa4ed0435ffdf3c7f14d70518360eb8d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: guardian-qualityforge- (guardian-qualityforge-quality-guardian)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'guardian-qualityforge-quality-guardian' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_eff03df289f188979494ab8998a9236b8fe044ced09c5d10',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: integration-Integratio (integration-Integration-testing)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integration-Integration-testing' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_cb33d2ae1c003c9dde8ca6275941f4f73947bff2a876adc3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: profiler-Performance-p (profiler-Performance-profiler)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'profiler-Performance-profiler' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_dc95be86a477248ec6e3bf90fdb328216b66ed0dfe3691a0',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: apex-qualityforge-ceo (apex-qualityforge-ceo)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'apex-qualityforge-ceo' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_06692b985bad1f7120c5ff4b0d32939e0f6675aa867a262b',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: resolver-qualityforge- (resolver-qualityforge-issue-resolver)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'resolver-qualityforge-issue-resolver' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_70324040c5954eec441df0b8c20c359f5476eb67aaca18c9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: fixer-qualityforge-bug (fixer-qualityforge-bug-fixing-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'fixer-qualityforge-bug-fixing-specialist' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_999afa56706098a91e3f200f87f5e5c3c14b18273a043df3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: refactor-Refactoring-s (refactor-Refactoring-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'refactor-Refactoring-specialist' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_01d51227b6064c5e1e6f31ffcfa2c5af564cc0770429f52d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: loadtester-qualityforg (loadtester-qualityforge-scalability-testing)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'loadtester-qualityforge-scalability-testing' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_211ff8a75441f0402e4be0624d3e945b38c477acc2adf23d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: coverage-qualityforge- (coverage-qualityforge-test-coverage-analyst)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'coverage-qualityforge-test-coverage-analyst' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_8b03409946ad2031b8bb1fcb0debc37c9de7649c3e6fb5b0',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: Compliance Validator (qualityforge-ai-compliancevalidator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'qualityforge-ai-compliancevalidator' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_d9aae41b359ec1644bc7e8b6acde1bc9a6c356850a3b13ea',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: dbat-testing-qualityfo (dbat-testing-qualityforge)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'dbat-testing-qualityforge' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_a7f8595a8ca2ec10cb4657851fc2a76008f602dc01b486fc',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: maintainer-qualityforg (maintainer-qualityforge-code-maintainer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'maintainer-qualityforge-code-maintainer' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_5b14296541a99e896261e27d8fd7f5d943ff84e6f02e4515',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: compatibility (compatibility)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'compatibility' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_fc1510b5320c213ddc2c7bd0d59dd953afe6a3e65ec7698d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: documenter-qualityforg (documenter-qualityforge-documentation-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'documenter-qualityforge-documentation-specialist' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_79321a350a3a8ee23c5d91cf484d8f7091df76f2872da32d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: code-analyzer (code-analyzer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'code-analyzer' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_5dd55b1dabff0c4266dba4ec5b265ab00af09ac5d0b17b02',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: validator-Validator (validator-Validator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'validator-Validator' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_8ee5ef34e3c20e17739211b5397973ff05d3e646d01fac9e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: debugger-Debugger-spec (debugger-Debugger-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'debugger-Debugger-specialist' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_edd74201908734bb241a4f3231bfbe4c409284471cf286c9',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: inspector-qualityforge (inspector-qualityforge-code-inspector)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'inspector-qualityforge-code-inspector' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_46333959ade7ee73137bf163327b3506e1fab78f6929cf48',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: optimizer-qualityforge (optimizer-qualityforge-code-optimizer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'optimizer-qualityforge-code-optimizer' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_2d9dcdc8c6c6228a4f4b2e3cbec8799b524fe8d920c35cc1',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DP (qualityforge-ai-documentationprocess)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'qualityforge-ai-documentationprocess' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_d94cafda9a8de50863c4e29d51866d06c8cf6580f9e4f9df',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: performance-Performanc (performance-Performance-testing)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'performance-Performance-testing' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_02a6f75349b8dcfed1931be79a052b3f25aafb75d6d6ba09',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: accessibility-Accessib (accessibility-Accessibility-testing)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'accessibility-Accessibility-testing' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_69bf6e3f8f00cf6020bdbe48b562f126982f60d37a969aea',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DSS (qualityforge-ai-decisionsupport)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'qualityforge-ai-decisionsupport' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_5c43b40d628a086415d67214ce30725887688af5f20889f0',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: reporter-qualityforge- (reporter-qualityforge-quality-reporter)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'reporter-qualityforge-quality-reporter' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_a40aea868ee665fd8c93ed7c2a04d6db8858f3cdd7e6b606',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: load-Load-testing (load-Load-testing)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'load-Load-testing' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_aa69f1d24ffac9f89fe46eceed57794c5e2ed7132c55f20e',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: ACM (qualityforge-ai-assessmentcriteria)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'qualityforge-ai-assessmentcriteria' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_620f9cb0504372bfc43e8818e8832dbb96e6e70d32481b88',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: standards-Standards-en (standards-Standards-enforcer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'standards-Standards-enforcer' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_24cd172da46c37b06d0f662c442faec4740140d54818e6de',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: reviewer-qualityforge- (reviewer-qualityforge-code-reviewer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'reviewer-qualityforge-code-reviewer' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_44a78220bf0d04ef332b8e3cc077d3f8e349108179b2dce1',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: auditor (auditor)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'auditor' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_3771aefbe1af40fbabdfd8aba14ada4b8ea8a2b72ad02807',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: automation-qualityforg (automation-qualityforge-test-automation)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'automation-qualityforge-test-automation' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_ed9f54110bbb92563d7f230725b99d6f8ab1f71c5e07d7cb',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: e2e-qualityforge-end-t (e2e-qualityforge-end-to-end-testing)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'e2e-qualityforge-end-to-end-testing' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_f90db714118e6751019cf25b17d2ea73a2d333da358a7636',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: probe-qualityforge-pro (probe-qualityforge-prompt-testing)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'probe-qualityforge-prompt-testing' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_9da907d1a9fbfaa80eb95dd87f33f10f5170439d0e71600a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: codesmith-qualityforge (codesmith-qualityforge-code-architect)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'codesmith-qualityforge-code-architect' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_d2a071e22141dfbbbc3aa9aa2518acfd136f7af6c8ae58d7',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: migrator-qualityforge- (migrator-qualityforge-migration-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'migrator-qualityforge-migration-specialist' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_bcc2535f1b38c72cab2880291917a2c37a1831c80c0dd346',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: simulator-qualityforge (simulator-qualityforge-workflow-simulation)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'simulator-qualityforge-workflow-simulation' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_7ebecc9415641933738bce9e848844d4bd64cb77039e9fe5',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: trainer-qualityforge-q (trainer-qualityforge-quality-trainer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'trainer-qualityforge-quality-trainer' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_69daf301986a1314ca1756c96b22dbc9a34fae6090d7d189',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: architect-qualityforge (architect-qualityforge-system-architect)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'architect-qualityforge-system-architect' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_30bed33fb981a7ea734ccbca5ce4ae195781ec36cc94716d',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: diagnostics-Diagnostic (diagnostics-Diagnostics-specialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'diagnostics-Diagnostics-specialist' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_e3eddb54f6b70730cd9ba6097e1d0be1fe0b0b7110436e57',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: governor-qualityforge- (governor-qualityforge-quality-director)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'governor-qualityforge-quality-director' LIMIT 1),
    'f535f9bc-00be-4b6d-9f53-c53abfacacef',
    'default',
    'pcp_4b1f652b992c6994f42d9be6c95650badbd4db44153af701',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-successmanager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-successmanager' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_55166d1c6c0ae96358853fcd9f2e5e4fcc29d6c84fb066a6',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-clientconfigmanager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-clientconfigmanager' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_4b404809ebcd238141adadd2e131ac2fd08aa4329f99c14a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-renderservicemanager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-renderservicemanager' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_066fcb741bc50d0fbf5ac7342fefd6bea7f8cf675d297b31',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-onboardmaster)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-onboardmaster' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_13140e6e3d160c4eb54e7feca7830aab589eab9e9f592051',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-dataguardian)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-dataguardian' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_5ce9587c646928fa00139cb5ad5218cee7daa2abf5e98431',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-githubbranchmanager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-githubbranchmanager' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_ecb913d063a3cd0de3a06575270665257540cb4ed19a535f',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-accesscontroller)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-accesscontroller' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_1d8e5bf0124e1ab07acd2f3372ea1190533042af834a6850',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-onboardingcoordinator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-onboardingcoordinator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_143749007ea5ac6c26763fd5cbf227e728f5451b1c7013cb',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-supportintegrator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-supportintegrator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_10f9bde0ca42802b2729a0d233fdcc55dcf21daad150d869',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-securityspecialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-securityspecialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_84d09b75a13d1f86d5ae822544e464c1907d70d8fa264e63',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-analyticsspecialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-analyticsspecialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_aa46096256cfdb508b1bf78989b6d82806ef90a0acf57c29',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-tenantmanager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-tenantmanager' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_4cff48edf05e101f67b858823ea707b196f3a102cbdb6005',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-devopsengineer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-devopsengineer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_ab5a1c305d680463de18a5c0159ba39753b00ba1e3d5c3e3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-resourceoptimizer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-resourceoptimizer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_ef9dd1c19abac99caaf07d6110849b36245f997e7b2529f1',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-deploymentorchestrato)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-deploymentorchestrato' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_eec8278f429cbfc228a56e7b4d3a8ccf55fff7455c2a8ce2',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (saasforge-ai-platformarchitect)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-platformarchitect' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440011',
    'default',
    'pcp_76d0eddc5efe26afedae8a0ec7f8f24b81159d1a88e44f98',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (voiceforge-ai-contextcoordinator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-contextcoordinator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440012',
    'default',
    'pcp_5965d1f0c7868484d5bc1834c0786185d3d9a8dec8952c66',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (voiceforge-ai-intentanalyst)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-intentanalyst' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440012',
    'default',
    'pcp_4f48f8ed047157725ae5f042ca36ee7bf4af47c23ea14e83',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (voiceforge-ai-personalitydesigner)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-personalitydesigner' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440012',
    'default',
    'pcp_aeccc7379e134f4522fe9f8370e5affaa9182910b5787ee1',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (voiceforge-ai-platformintegrator)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-platformintegrator' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440012',
    'default',
    'pcp_88ee3d5bce1405d5cbc7e1b146864b154bc3a2f6bf29bef3',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (voiceforge-ai-speechprocessor)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-speechprocessor' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440012',
    'default',
    'pcp_4ad7fbb007b66323b5236fbe1135d0a25851bc77eabd04d8',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (voiceforge-ai-languagespecialist)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-languagespecialist' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440012',
    'default',
    'pcp_56d6472d106b7c71ef7b0ce2b06178d24eb61c38a364a822',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (voiceforge-ai-audioengineer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-audioengineer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440012',
    'default',
    'pcp_f4c81816e9d1087f9f0abcb4a6c5430eb4cff8c34e619b55',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (voiceforge-ai-qualityassurance)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-qualityassurance' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440012',
    'default',
    'pcp_9196593ece35fcecc2e9249545fdc62c55b9c8b96a372c0a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (voiceforge-ai-conversationmanager)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-conversationmanager' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440012',
    'default',
    'pcp_555a4a330815f44c86ea98501639c6b5eaa1159941a0bd9a',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (voiceforge-ai-apiarchitect)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-apiarchitect' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440012',
    'default',
    'pcp_01d3ba5b98cff068424fd17c7466f9b82865b7175c4c9f66',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (voiceforge-ai-voicesynthesizer)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-voicesynthesizer' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440012',
    'default',
    'pcp_239f466460a903ea23ac2f5b812b005149093de7f4057019',
    NOW()
ON CONFLICT DO NOTHING;


-- API key for: DM-DT&R (voiceforge-ai-voicemaestro)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-voicemaestro' LIMIT 1),
    '550e8400-e29b-41d4-a716-446655440012',
    'default',
    'pcp_3b9837dd07fa883438e8b162c701dace92b5336fe6f9166f',
    NOW()
ON CONFLICT DO NOTHING;


-- STEP 4: Create model assignments for all agents
-- ============================================================

-- Model assignment for: SEO Strategist (contentforge-ai-seostrategist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-seostrategist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Link Builder (contentforge-ai-linkbuilder)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-linkbuilder' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Performance Optimizer (contentforge-ai-performanceoptimizer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-performanceoptimizer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Blog Architect (contentforge-ai-blogarchitect)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-blogarchitect' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: TSS (contentforge-ai-technicalseo)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-technicalseo' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Reporting Specialist (contentforge-ai-reportingspecialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-reportingspecialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Content Maestro (contentforge-ai-contentmaestro)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-contentmaestro' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Data Analyst (contentforge-ai-dataanalyst)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-dataanalyst' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Local SEO Expert (contentforge-ai-localseoexpert)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-localseoexpert' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: SEO Analyst (contentforge-ai-seoanalyst)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-seoanalyst' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Conversion Specialist (contentforge-ai-conversionspecialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-conversionspecialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Mobile Optimizer (contentforge-ai-mobileoptimizer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-mobileoptimizer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Conversion Analyst (contentforge-ai-conversionanalyst)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-conversionanalyst' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Email Composer (contentforge-ai-emailcomposer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-emailcomposer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: E-CO (contentforge-ai-communicationorchestr)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-communicationorchestr' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: UX Designer (contentforge-ai-uxdesigner)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-uxdesigner' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Social Strategist (contentforge-ai-socialstrategist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contentforge-ai-socialstrategist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: ally-devforge-partners (ally-devforge-partnership-management)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'ally-devforge-partnership-management' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: interface-devforge-api (interface-devforge-api-integration)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'interface-devforge-api-integration' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: vector-Vector-processi (vector-Vector-processing)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'vector-Vector-processing' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: voyager-devforge-marke (voyager-devforge-market-exploration)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voyager-devforge-market-exploration' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: librarian-devforge-kno (librarian-devforge-knowledge-management)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'librarian-devforge-knowledge-management' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: fixer-devforge-bug-fix (fixer-devforge-bug-fixing)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'fixer-devforge-bug-fixing' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: forge-devforge-system- (forge-devforge-system-architecture)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'forge-devforge-system-architecture' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: nexus-devforge-ceo (nexus-devforge-ceo)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'nexus-devforge-ceo' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: MC (devforge-ai-multidisciplinecoord)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'devforge-ai-multidisciplinecoord' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: synth-Synthetic-data (synth-Synthetic-data)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'synth-Synthetic-data' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DGS (devforge-ai-documentgenerationsp)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'devforge-ai-documentgenerationsp' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: archivist-devforge-kno (archivist-devforge-knowledge-security)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'archivist-devforge-knowledge-security' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: insight-devforge-busin (insight-devforge-business-intelligence)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'insight-devforge-business-intelligence' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: sentinel-devforge-data (sentinel-devforge-data-quality-monitoring)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'sentinel-devforge-data-quality-monitoring' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: merchant-devforge-comm (merchant-devforge-commerce-operations)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'merchant-devforge-commerce-operations' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: devcore-devforge-core- (devcore-devforge-core-development)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'devcore-devforge-core-development' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Financial Validator (devforge-ai-financialvalidator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'devforge-ai-financialvalidator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: cloudops-devforge-clou (cloudops-devforge-cloud-operations)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'cloudops-devforge-cloud-operations' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: concierge-devforge-cus (concierge-devforge-customer-experience)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'concierge-devforge-customer-experience' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: sentinelx-devforge-adv (sentinelx-devforge-advanced-monitoring)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'sentinelx-devforge-advanced-monitoring' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: sql-query-devforge (sql-query-devforge)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'sql-query-devforge' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: schema-devforge-data-s (schema-devforge-data-schema-management)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'schema-devforge-data-schema-management' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: council-devforge-strat (council-devforge-strategic-decision-making)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'council-devforge-strategic-decision-making' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: mentor-devforge-team-d (mentor-devforge-team-development)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mentor-devforge-team-development' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: dealmaker-devforge-sal (dealmaker-devforge-sales-negotiation)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'dealmaker-devforge-sales-negotiation' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: S-WLC (devforge-ai-workflowlearningcoor)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'devforge-ai-workflowlearningcoor' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: atlas-devforge-product (atlas-devforge-product-mapping)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'atlas-devforge-product-mapping' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: strategos-devforge-str (strategos-devforge-strategic-planning)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'strategos-devforge-strategic-planning' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: guardian-devforge-thre (guardian-devforge-threat-protection)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'guardian-devforge-threat-protection' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: amplifier-devforge-mar (amplifier-devforge-marketing-promotion)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'amplifier-devforge-marketing-promotion' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: nova-devforge-product- (nova-devforge-product-launches)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'nova-devforge-product-launches' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: analyst-devforge-marke (analyst-devforge-market-analysis)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'analyst-devforge-market-analysis' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: brandforge-devforge-br (brandforge-devforge-brand-development)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'brandforge-devforge-brand-development' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: pathfinder-devforge-op (pathfinder-devforge-opportunity-identification)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'pathfinder-devforge-opportunity-identification' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: catalyst-devforge-prod (catalyst-devforge-product-innovation)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'catalyst-devforge-product-innovation' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: codesmith-devforge-bac (codesmith-devforge-backend-engineer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'codesmith-devforge-backend-engineer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: automata-devforge-auto (automata-devforge-automation-systems)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'automata-devforge-automation-systems' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: storycraft-devforge-pr (storycraft-devforge-product-storytelling)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'storycraft-devforge-product-storytelling' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: promptsmith-devforge-p (promptsmith-devforge-prompt-engineering)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'promptsmith-devforge-prompt-engineering' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: compass-devforge-direc (compass-devforge-direction-setting)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'compass-devforge-direction-setting' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: navigator-devforge-dat (navigator-devforge-data-discovery)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'navigator-devforge-data-discovery' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: reviewer-devforge-code (reviewer-devforge-code-review-qa)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'reviewer-devforge-code-review-qa' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: ambassador-devforge-br (ambassador-devforge-brand-representation)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'ambassador-devforge-brand-representation' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: gatekeeper-devforge-ac (gatekeeper-devforge-access-control)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'gatekeeper-devforge-access-control' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Transaction Processor (devforge-ai-transactionprocessor)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'devforge-ai-transactionprocessor' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Q-WCA (devforge-ai-workflowcomplexityan)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'devforge-ai-workflowcomplexityan' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: watchtower-devforge-se (watchtower-devforge-security-oversight)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'watchtower-devforge-security-oversight' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: oracle-devforge-predic (oracle-devforge-predictive-analytics)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'oracle-devforge-predictive-analytics' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: auditor-devforge-secur (auditor-devforge-security-compliance)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'auditor-devforge-security-compliance' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: stream-devforge-data-s (stream-devforge-data-streaming)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'stream-devforge-data-streaming' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: dataforge-devforge-dat (dataforge-devforge-data-transformation)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'dataforge-devforge-data-transformation' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: catalystx-devforge-mar (catalystx-devforge-market-disruption)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'catalystx-devforge-market-disruption' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: scout-devforge-competi (scout-devforge-competitive-intelligence)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'scout-devforge-competitive-intelligence' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: cartographer-devforge- (cartographer-devforge-product-roadmapping)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'cartographer-devforge-product-roadmapping' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: ledgerai-devforge-fina (ledgerai-devforge-financial-data)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'ledgerai-devforge-financial-data' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: pulse-devforge-realtim (pulse-devforge-realtime-monitoring)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'pulse-devforge-realtime-monitoring' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: orion-devforge-orchest (orion-devforge-orchestrator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'orion-devforge-orchestrator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: ledger-devforge-financ (ledger-devforge-financial-oversight)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'ledger-devforge-financial-oversight' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: cortex-devforge-ai-rea (cortex-devforge-ai-reasoning)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'cortex-devforge-ai-reasoning' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-constructiondirector)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-constructiondirector' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: procurement-domainforg (procurement-domainforge-procurement-contracts)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'procurement-domainforge-procurement-contracts' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: council-domainforge-go (council-domainforge-governance-standards)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'council-domainforge-governance-standards' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: strategos-domainforge- (strategos-domainforge-strategic-planning)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'strategos-domainforge-strategic-planning' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-publicrelations)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-publicrelations' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-design)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-design' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-financialcompliance)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-financialcompliance' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: contract-administratio (contract-administration-domainforge-contract-administration)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contract-administration-domainforge-contract-administration' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-salesdirector)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-salesdirector' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-security)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-security' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-localcontent)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-localcontent' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-environmental)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-environmental' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: orion-domainforge-ceo (orion-domainforge-ceo)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'orion-domainforge-ceo' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-landscaping)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-landscaping' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-counselspecialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-counselspecialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: procurement-strategy-d (procurement-strategy-domainforge-procurement-strategy)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'procurement-strategy-domainforge-procurement-strategy' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: contract-administratio (contract-administration-domainforge-contract-administration)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contract-administration-domainforge-contract-administration' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-otherparties)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-otherparties' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: structural-domainforge (structural-domainforge-structural-engineering)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'structural-domainforge-structural-engineering' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-hsedirector)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-hsedirector' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-mobileworkflowdesign)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-mobileworkflowdesign' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: finance-domainforge-fi (finance-domainforge-finance-cost-management)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'finance-domainforge-finance-cost-management' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: civil-domainforge-civi (civil-domainforge-civil-engineering)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'civil-domainforge-civil-engineering' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-sales)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-sales' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-buyerspecialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-buyerspecialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-contractsdirector)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-contractsdirector' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: civil-domainforge-civi (civil-domainforge-civil-engineering)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'civil-domainforge-civil-engineering' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-projectcontrols)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-projectcontrols' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-inspection)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-inspection' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: safety-domainforge-saf (safety-domainforge-safety-risk-management)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'safety-domainforge-safety-risk-management' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-sundry)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-sundry' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-health)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-health' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-transportation)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-transportation' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: quality-assurance-doma (quality-assurance-domainforge-quality-assurance)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'quality-assurance-domainforge-quality-assurance' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: quality-control-domain (quality-control-domainforge-quality-control)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'quality-control-domainforge-quality-control' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: procurement-analytics- (procurement-analytics-domainforge-procurement-analytics)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'procurement-analytics-domainforge-procurement-analytics' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-evaluator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-evaluator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-engineeringdirector)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-engineeringdirector' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: strategos-domainforge- (strategos-domainforge-strategic-planning)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'strategos-domainforge-strategic-planning' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-chemicalengineering)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-chemicalengineering' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-architecturalintegrat)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-architecturalintegrat' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: council-domainforge-go (council-domainforge-governance-standards)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'council-domainforge-governance-standards' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-contractspreaward)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-contractspreaward' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-guardian2)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-guardian2' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-logisticsdirector)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-logisticsdirector' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-processengineering)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-processengineering' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: finance-domainforge-fi (finance-domainforge-finance-cost-management)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'finance-domainforge-finance-cost-management' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: logistics-domainforge- (logistics-domainforge-supply-chain)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'logistics-domainforge-supply-chain' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-financedirector)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-financedirector' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: structural-domainforge (structural-domainforge-structural-engineering)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'structural-domainforge-structural-engineering' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: procurement-domainforg (procurement-domainforge-procurement-contracts)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'procurement-domainforge-procurement-contracts' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-ethics)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-ethics' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-inspectorspecialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-inspectorspecialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-directors)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-directors' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-scrutineer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-scrutineer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-contractspostaward)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-contractspostaward' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: construction-engineeri (construction-engineering-domainforge-construction-engineering)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'construction-engineering-domainforge-construction-engineering' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-commercial)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-commercial' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-treasurer2)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-treasurer2' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: legal-domainforge-lega (legal-domainforge-legal-regulatory-compliance)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'legal-domainforge-legal-regulatory-compliance' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-mobiletesting)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-mobiletesting' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: orion-domainforge-ceo (orion-domainforge-ceo)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'orion-domainforge-ceo' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-dispatcherspecialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-dispatcherspecialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: quality-assurance-doma (quality-assurance-domainforge-quality-assurance)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'quality-assurance-domainforge-quality-assurance' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: safety-domainforge-saf (safety-domainforge-safety-risk-management)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'safety-domainforge-safety-risk-management' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-mechanicalengineering)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-mechanicalengineering' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: geotechnical-domainfor (geotechnical-domainforge-geotechnical-engineering)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'geotechnical-domainforge-geotechnical-engineering' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-directorproject)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-directorproject' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: quality-control-domain (quality-control-domainforge-quality-control)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'quality-control-domainforge-quality-control' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-architectural)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-architectural' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-documentcontrol)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-documentcontrol' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-electricalengineering)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-electricalengineering' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-informationtechnology)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-informationtechnology' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-suppliermanagement)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-suppliermanagement' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-quantitysurveying)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-quantitysurveying' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-scheduling)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-scheduling' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (domainforge-ai-procurementdirector)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'domainforge-ai-procurementdirector' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: geotechnical-domainfor (geotechnical-domainforge-geotechnical-engineering)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'geotechnical-domainforge-geotechnical-engineering' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: legal-domainforge-lega (legal-domainforge-legal-regulatory-compliance)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'legal-domainforge-legal-regulatory-compliance' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: construction-engineeri (construction-engineering-domainforge-construction-engineering)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'construction-engineering-domainforge-construction-engineering' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: procurement-strategy-d (procurement-strategy-domainforge-procurement-strategy)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'procurement-strategy-domainforge-procurement-strategy' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: procurement-analytics- (procurement-analytics-domainforge-procurement-analytics)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'procurement-analytics-domainforge-procurement-analytics' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: logistics-domainforge- (logistics-domainforge-supply-chain)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'logistics-domainforge-supply-chain' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-taskcoordinator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-taskcoordinator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-securityspecialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-securityspecialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: maya-loopy-content-str (maya-loopy-content-strategist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'maya-loopy-content-strategist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: VLC-LACEO (vision-loopy-ceo)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'vision-loopy-ceo' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-presentationspecialis)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-presentationspecialis' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-intelligenceanalyst)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-intelligenceanalyst' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-systemsintegrator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-systemsintegrator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-datamanager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-datamanager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-performanceanalyst)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-performanceanalyst' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-automationengineer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-automationengineer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-communicationsmanager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-communicationsmanager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-knowledgecurator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-knowledgecurator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-strategicadvisor)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-strategicadvisor' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-researchassistant)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-researchassistant' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-workflowoptimizer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-workflowoptimizer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-scheduler)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-scheduler' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-personalassistant)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-personalassistant' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (execforge-ai-chiefofstaff)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'execforge-ai-chiefofstaff' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: N-SDS (infraforge-ai-nimbussupabase)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'infraforge-ai-nimbussupabase' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: RDS (render-deployment-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'render-deployment-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DIA (database-infraforge-database-infrastructure)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'database-infraforge-database-infrastructure' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: orchestrator-infraforg (orchestrator-infraforge-ceo)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'orchestrator-infraforge-ceo' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: supply-chain-integrati (supply-chain-integration-infraforge-supply-chain)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'supply-chain-integration-infraforge-supply-chain' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: postgres-infraforge (postgres-infraforge)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'postgres-infraforge' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: mobile-api-infraforge- (mobile-api-infraforge-mobile-api-integration)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobile-api-infraforge-mobile-api-integration' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-cococandy)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-cococandy' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-hazelhecras)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-hazelhecras' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-astroasta)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-astroasta' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-wileyprojectwise)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-wileyprojectwise' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-aceaconex)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-aceaconex' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-terracivil3d)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-terracivil3d' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-novanavisworks)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-novanavisworks' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-stormswmm)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-stormswmm' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-blakebuildsoft)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-blakebuildsoft' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-elietabs)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-elietabs' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-rexrevit)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-rexrevit' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-sashasharepoint)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-sashasharepoint' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-phoenixp6)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-phoenixp6' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-stanstaad)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-stanstaad' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-coreyprocore)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-coreyprocore' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-cashcostx)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-cashcostx' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-adaautocad)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-adaautocad' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-pixelbim360)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-pixelbim360' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-ziggyorchestrator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-ziggyorchestrator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-trixtrimble)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-trixtrimble' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (integrateforge-ai-maxmsproject)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrateforge-ai-maxmsproject' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Directors (knowledgeforge-ai-directors)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-directors' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: A-p (knowledgeforge-ai-administrator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-administrator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Generalist (knowledgeforge-ai-generalist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-generalist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Negotiator (knowledgeforge-ai-negotiator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-negotiator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Specialist (knowledgeforge-ai-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Sentinel (knowledgeforge-ai-sentinel)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-sentinel' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Physician (knowledgeforge-ai-physician)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-physician' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Constructor (knowledgeforge-ai-constructor)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-constructor' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Geologist (knowledgeforge-ai-geologist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-geologist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Co-ordinator (knowledgeforge-ai-controller)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-controller' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Designer (knowledgeforge-ai-designer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-designer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Salesperson (knowledgeforge-ai-salesperson)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-salesperson' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Technician (knowledgeforge-ai-technician)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-technician' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Chemist (knowledgeforge-ai-chemist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-chemist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Guardian (knowledgeforge-ai-guardian)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-guardian' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Builder (knowledgeforge-ai-builder)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-builder' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Merchant (knowledgeforge-ai-merchant)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-merchant' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Inetrmediary (knowledgeforge-ai-inetrmediary)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-inetrmediary' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Leader (knowledgeforge-ai-leader)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-leader' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Engineer (knowledgeforge-ai-engineer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-engineer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Communicator (knowledgeforge-ai-communicator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-communicator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Treasurer (knowledgeforge-ai-treasurer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-treasurer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Environmentalist (knowledgeforge-ai-environmentalist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-environmentalist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Counsel (knowledgeforge-ai-counsel)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-counsel' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Buyer (knowledgeforge-ai-buyer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-buyer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Scheduler (knowledgeforge-ai-scheduler)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-scheduler' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Examiner (knowledgeforge-ai-examiner)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-examiner' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Ethicist (knowledgeforge-ai-ethicist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-ethicist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Landscaper (knowledgeforge-ai-landscaper)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-landscaper' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Greeter (knowledgeforge-ai-greeter)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-greeter' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Chairman (knowledgeforge-ai-chairman)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-chairman' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Critic (knowledgeforge-ai-critic)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-critic' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Concierge (knowledgeforge-ai-concierge)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-concierge' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Governor (knowledgeforge-ai-governor)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-governor' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Optimizer (knowledgeforge-ai-optimizer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-optimizer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: AmbiguityPrime (knowledgeforge-ai-ambiguityprime)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-ambiguityprime' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Gatekeeper (knowledgeforge-ai-gatekeeper)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-gatekeeper' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Inspector (knowledgeforge-ai-inspector)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-inspector' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Archivist (knowledgeforge-ai-archivist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-archivist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Surveyor (knowledgeforge-ai-surveyor)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-surveyor' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Developer (knowledgeforge-ai-developer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-developer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Electrician (knowledgeforge-ai-electrician)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-electrician' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Dispatcher (knowledgeforge-ai-dispatcher)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-dispatcher' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Co-ordinator (knowledgeforge-ai-coordinator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'knowledgeforge-ai-coordinator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Architect - refactor (Architect - refactor)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Architect - refactor' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: User Manager (User Manager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'User Manager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Development Manager (Development Manager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Development Manager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Communication Manager (Communication Manager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Communication Manager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Director Project (Director Project)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Project' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Director HSE (Director HSE)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director HSE' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Director Sales (Director Sales)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Sales' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Director Procurement (Director Procurement)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Procurement' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: System Administrator (System Administrator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'System Administrator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: AI Manager (AI Manager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'AI Manager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Monitor (Monitor)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Monitor' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Operations Coordinator (Operations Coordinator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Operations Coordinator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Director Logistics (Director Logistics)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Logistics' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Investigator (Investigator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Investigator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Integrator (Integrator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Integrator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Architect (Architect)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Architect' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Director Engineering (Director Engineering)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Engineering' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Director Logistics (Director Logistics)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Logistics' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Analyst Sector (Analyst Sector)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Analyst Sector' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Director Projects (Director Projects)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Projects' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Director Construction (Director Construction)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Director Construction' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Quality Assurance (Quality Assurance)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Quality Assurance' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Administrator (Administrator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Administrator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Inspector QC (Inspector QC)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Inspector QC' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: KWG (KnowledgeForge Workflow Guardian)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'KnowledgeForge Workflow Guardian' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Docs Analyzer (Docs Analyzer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Docs Analyzer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Advisor Disciplines (Advisor Disciplines)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Advisor Disciplines' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Validator (Validator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Validator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Interface Specialist (Interface Specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Interface Specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: A-p (Administrator - pre-award)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'Administrator - pre-award' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: AMA (learningforge-ai-assessment-mastery)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-assessment-mastery' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Error Pattern Monitor (learningforge-ai-error-pattern-monitor)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-error-pattern-monitor' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: User Behavior Analyst (learningforge-ai-user-behavior-analyst)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-user-behavior-analyst' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: RCDL (learningforge-ai-research-compliance-division-lead)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-research-compliance-division-lead' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: EIA (learningforge-ai-equipment-inspection)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-equipment-inspection' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: AGA (learningforge-ai-autoresearch-gap-analyzer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-autoresearch-gap-analyzer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Doc Usage Analyzer (learningforge-ai-doc-usage-analyzer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-doc-usage-analyzer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: SRA-LA (learningforge-ai-safetyresearchagent)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-safetyresearchagent' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: EEA (learningforge-ai-electrical-engineering-agent)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-electrical-engineering-agent' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Hazard Pattern Analyst (learningforge-ai-hazard-pattern-analyst)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-hazard-pattern-analyst' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: KPA (learningforge-ai-knowledge-provenance)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-knowledge-provenance' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: FDTLG (learningforge-ai-from-doc-to-lesson-generator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-from-doc-to-lesson-generator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: IPC (learningforge-ai-interaction-pattern-coach)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-interaction-pattern-coach' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: VFS Watcher Agent (learningforge-ai-vfs-watcher)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-vfs-watcher' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Quality Learning Agent (learningforge-ai-quality-learning)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-quality-learning' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Compliance Guard Agent (learningforge-ai-compliance-guard)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-compliance-guard' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: RSA (learningforge-ai-research-scheduler)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-research-scheduler' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: SRRA (learningforge-ai-safety-regulation-research)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-safety-regulation-research' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: MPA-LA (learningforge-ai-mobilepatternsagent)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-mobilepatternsagent' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: LIA-LA (learningforge-ai-learningintegration)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-learningintegration' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: MDT (learningforge-ai-material-defect-tracker)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-material-defect-tracker' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: STCA (learningforge-ai-safety-training-compliance)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-safety-training-compliance' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Procurement Agent (learningforge-ai-procurement-agent)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-procurement-agent' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Safety Workflow Agent (learningforge-ai-safety-workflow-agent)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-safety-workflow-agent' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Doc Gap Detector (learningforge-ai-doc-gap-detector)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-doc-gap-detector' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Hermes Research Agent (learningforge-ai-hermes-research)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-hermes-research' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: EIRA (learningforge-ai-equipment-innovation-research)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-equipment-innovation-research' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Learning Division Lead (learningforge-ai-learning-division-lead)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-learning-division-lead' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: GA&BA (learningforge-ai-goal-alignment-budget)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-goal-alignment-budget' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: KHA (learningforge-ai-knowledge-hygiene)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-knowledge-hygiene' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Audit By Path Agent (learningforge-ai-audit-by-path)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-audit-by-path' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: LangChain Runner Agent (learningforge-ai-langchain-runner)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-langchain-runner' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DPRA (learningforge-ai-defect-pattern-research)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-defect-pattern-research' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: SQDL (learningforge-ai-safety-quality-division-lead)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-safety-quality-division-lead' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Logistics Agent (learningforge-ai-logistics-agent)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-logistics-agent' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: FSA (learningforge-ai-feedback-synthesis)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-feedback-synthesis' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Workflow Coach (learningforge-ai-workflow-coach)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-workflow-coach' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: ASE (learningforge-ai-autoresearch-skills-enhancer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-autoresearch-skills-enhancer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: KFDL (learningforge-ai-knowledge-flow-division-lead)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-knowledge-flow-division-lead' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: ALS (learningforge-ai-autoresearch-literature-scanner)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-autoresearch-literature-scanner' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: VFS Markdown Tracker (learningforge-ai-vfs-markdown-tracker)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-vfs-markdown-tracker' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: PDL (learningforge-ai-priority-disciplines-lead)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-priority-disciplines-lead' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Curriculum Planner (learningforge-ai-curriculum-planner)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-curriculum-planner' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Micro-Lesson Generator (learningforge-ai-micro-lesson-generator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-micro-lesson-generator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: A&EA (learningforge-ai-audit-explainability)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-audit-explainability' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Knowledge Flow Agent (learningforge-ai-knowledge-flow-agent)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-knowledge-flow-agent' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Field Safety Inspector (learningforge-ai-field-safety-inspector)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-field-safety-inspector' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: CLRA (learningforge-ai-construction-law-research)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-construction-law-research' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: LSA (learningforge-ai-ceo)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-ceo' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: KTA (learningforge-ai-knowledge-transparency)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-knowledge-transparency' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Contracts Agent (learningforge-ai-contracts-agent)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'learningforge-ai-contracts-agent' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: jordan-loopy-marketing (jordan-loopy-marketing-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'jordan-loopy-marketing-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: alex-loopy-deep-resear (alex-loopy-deep-research)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'alex-loopy-deep-research' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: sam-loopy-social-media (sam-loopy-social-media-coordinator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'sam-loopy-social-media-coordinator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: VLC-LACEO (vision-loopy-ceo)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'vision-loopy-ceo' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: maya-loopy-content-str (maya-loopy-content-strategist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'maya-loopy-content-strategist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: dev-loopy-technical-cr (dev-loopy-technical-creative)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'dev-loopy-technical-creative' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: MVS (measurement-validation-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'measurement-validation-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: VOS (visual-overlay-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'visual-overlay-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: MAEQS (measureforge-ai-electrical-qa-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'measureforge-ai-electrical-qa-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: SSS (sans-standards-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'sans-standards-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: ASS (asaqs-standards-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'asaqs-standards-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: CTS (contract-tender-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contract-tender-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: OGS (order-generation-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'order-generation-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: MAEMS (measureforge-ai-electrical-measurement-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'measureforge-ai-electrical-measurement-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: CAS (contour-analysis-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'contour-analysis-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: MEP Element Specialist (mep-element-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mep-element-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: MATSCS (measureforge-ai-traffic-signal-compliance-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'measureforge-ai-traffic-signal-compliance-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: MATSMS (measureforge-ai-traffic-signal-measurement-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'measureforge-ai-traffic-signal-measurement-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: AES (architectural-element-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'architectural-element-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: MAECS (measureforge-ai-electrical-compliance-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'measureforge-ai-electrical-compliance-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: CES (cost-estimation-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'cost-estimation-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: SES (structural-element-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'structural-element-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: QSS (quantity-surveyor-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'quantity-surveyor-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: ECS (earthwork-calculation-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'earthwork-calculation-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: AIS (autocad-integration-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'autocad-integration-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: MCS (measurement-coordination-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'measurement-coordination-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: CMO (cad-measurement-orchestrator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'cad-measurement-orchestrator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (mobileforge-ai-uiuxspecialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-uiuxspecialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (mobileforge-ai-appmanager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-appmanager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (mobileforge-ai-cloudconnector)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-cloudconnector' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (mobileforge-ai-apispecialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-apispecialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (mobileforge-ai-performanceoptimizer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-performanceoptimizer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (mobileforge-ai-devicecontroller)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-devicecontroller' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (mobileforge-ai-mobilemaestro)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-mobilemaestro' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (mobileforge-ai-mobiledeveloper)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-mobiledeveloper' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (mobileforge-ai-testingcoordinator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-testingcoordinator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (mobileforge-ai-securityguardian)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'mobileforge-ai-securityguardian' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DI-DFM (paperclipforge-ai-dataintegrator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-dataintegrator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: IG-AIC (paperclipforge-ai-issuegenerator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-issuegenerator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-monitormaven)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-monitormaven' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: OD-COO (paperclipforge-ai-operationsdirector)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-operationsdirector' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: AS-IIR (paperclipforge-ai-assignmentspecialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-assignmentspecialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DCO (paperclipforge-ai-databasecrudorchestrator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-databasecrudorchestrator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: V-MVS (paperclipforge-ai-measurementvalidation)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-measurementvalidation' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: UI Uma (paperclipforge-ai-engineeringuispecial)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-engineeringuispecial' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-configcurator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-configcurator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-bridgebuilderextraor)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-bridgebuilderextraor' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-documentarian)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-documentarian' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: M-MCS (paperclipforge-ai-measurementcoordspec)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-measurementcoordspec' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: AM-AEM (paperclipforge-ai-apimanager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-apimanager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-tickettinkerer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-tickettinkerer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: GOS (paperclipforge-ai-githuboperationsspec)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-githuboperationsspec' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: RM-RA&O (paperclipforge-ai-resourcemanager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-resourcemanager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-wisdomweaver)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-wisdomweaver' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-networknavigator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-networknavigator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: QC-QA (paperclipforge-ai-qualitycontroller)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-qualitycontroller' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: R-ARS (paperclipforge-ai-agent-reconciler)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-agent-reconciler' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: WA-WD&A (paperclipforge-ai-workflowautomator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-workflowautomator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DD-DMaOA (paperclipforge-ai-databasedruid)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-databasedruid' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: maya-loopy-content-str (maya-loopy-content-strategist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'maya-loopy-content-strategist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: S-ORFC (paperclipforge-ai-orgresearchfoldercr)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-orgresearchfoldercr' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Analysis Andy (paperclipforge-ai-advancedengineering)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-advancedengineering' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: IA-CTO (paperclipforge-ai-integrationarchitect)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-integrationarchitect' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-dataarchitect)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-dataarchitect' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: IBIA (issue-batch-importer-paperclipforge)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'issue-batch-importer-paperclipforge' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-tasktangodancer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-tasktangodancer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-testcommander)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-testcommander' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-codesage)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-codesage' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: PC-PLM (paperclipforge-ai-projectcoordinator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-projectcoordinator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-loganalyst)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-loganalyst' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: VLC-LACEO (vision-loopy-ceo)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'vision-loopy-ceo' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: S-MSS (paperclipforge-ai-measurementstandards)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-measurementstandards' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Coordination Charlie (paperclipforge-ai-crossdisciplinecoord)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-crossdisciplinecoord' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-performanceprofiler)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-performanceprofiler' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: MAS (paperclipforge-ai-modelassignmentspeci)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-modelassignmentspeci' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-endpointenchantress)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-endpointenchantress' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: PM-PT&A (paperclipforge-ai-performancemonitor)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-performancemonitor' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: A-ACaM (paperclipforge-ai-atlasagentcreator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-atlasagentcreator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: PM-CEO (paperclipforge-ai-projectmaestro)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-projectmaestro' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: KI-KI (paperclipforge-ai-knowledgeintegrator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-knowledgeintegrator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-cachekeeper)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-cachekeeper' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-integrationillusionis)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-integrationillusionis' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: RA-A&R (paperclipforge-ai-reportinganalyst)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-reportinganalyst' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-deployer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-deployer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: UEC-UIM (paperclipforge-ai-userexperiencecoordi)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-userexperiencecoordi' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-chainlinkcharmer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-chainlinkcharmer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: PT-RM (paperclipforge-ai-progresstracker)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-progresstracker' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: PM-PA (paperclipforge-ai-predictivemodeler)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-predictivemodeler' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: RA-RI&M (paperclipforge-ai-riskanalyst)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-riskanalyst' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-securityguardian)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-securityguardian' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-authadministrator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-authadministrator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (paperclipforge-ai-dependencymanager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'paperclipforge-ai-dependencymanager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: tuner-promptforge-ab-t (tuner-promptforge-ab-testing)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'tuner-promptforge-ab-testing' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: cascade-promptforge-wo (cascade-promptforge-workflow-designer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'cascade-promptforge-workflow-designer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: quantifier-promptforge (quantifier-promptforge-benchmarking)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'quantifier-promptforge-benchmarking' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: analyzer-promptforge-p (analyzer-promptforge-prompt-analytics)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'analyzer-promptforge-prompt-analytics' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: compliance-promptforge (compliance-promptforge-regulatory-compliance)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'compliance-promptforge-regulatory-compliance' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: scholar-promptforge-ac (scholar-promptforge-academic-research)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'scholar-promptforge-academic-research' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: validator-promptforge- (validator-promptforge-syntax-logic-validation)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'validator-promptforge-syntax-logic-validation' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: integration-promptforg (integration-promptforge-cross-agent-compatibility)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integration-promptforge-cross-agent-compatibility' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: sage-promptforge-chief (sage-promptforge-chief-architect)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'sage-promptforge-chief-architect' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: archivist-promptforge- (archivist-promptforge-knowledge-management)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'archivist-promptforge-knowledge-management' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: flowdesigner-promptfor (flowdesigner-promptforge-agent-handoff)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'flowdesigner-promptforge-agent-handoff' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DAA (promptforge-ai-disciplineautomation)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'promptforge-ai-disciplineautomation' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: predictor-promptforge- (predictor-promptforge-outcome-prediction)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'predictor-promptforge-outcome-prediction' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: enhancer-promptforge-a (enhancer-promptforge-advanced-innovation)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'enhancer-promptforge-advanced-innovation' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: statemaster-promptforg (statemaster-promptforge-state-management)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'statemaster-promptforge-state-management' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: blueprint-promptforge- (blueprint-promptforge-template-designer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'blueprint-promptforge-template-designer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: refiner-promptforge-ve (refiner-promptforge-version-control)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'refiner-promptforge-version-control' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: explorer-promptforge-n (explorer-promptforge-new-techniques)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'explorer-promptforge-new-techniques' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: experimenter-promptfor (experimenter-promptforge-hypothesis-testing)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'experimenter-promptforge-hypothesis-testing' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: harmonic-promptforge-o (harmonic-promptforge-orchestration-strategy)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'harmonic-promptforge-orchestration-strategy' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: collaborator-promptfor (collaborator-promptforge-cross-company-knowledge-sharing)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'collaborator-promptforge-cross-company-knowledge-sharing' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: clarity-promptforge-pe (clarity-promptforge-performance-optimization)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'clarity-promptforge-performance-optimization' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: integrity-promptforge- (integrity-promptforge-ethical-ai)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrity-promptforge-ethical-ai' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: specialist-promptforge (specialist-promptforge-domain-adaptation)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'specialist-promptforge-domain-adaptation' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: monitor-qualityforge-q (monitor-qualityforge-quality-monitor)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'monitor-qualityforge-quality-monitor' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: tracer-qualityforge-ex (tracer-qualityforge-execution-tracer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'tracer-qualityforge-execution-tracer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: integrator-Integration (integrator-Integration-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integrator-Integration-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: guardian-qualityforge- (guardian-qualityforge-quality-guardian)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'guardian-qualityforge-quality-guardian' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: integration-Integratio (integration-Integration-testing)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'integration-Integration-testing' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: profiler-Performance-p (profiler-Performance-profiler)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'profiler-Performance-profiler' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: apex-qualityforge-ceo (apex-qualityforge-ceo)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'apex-qualityforge-ceo' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: resolver-qualityforge- (resolver-qualityforge-issue-resolver)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'resolver-qualityforge-issue-resolver' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: fixer-qualityforge-bug (fixer-qualityforge-bug-fixing-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'fixer-qualityforge-bug-fixing-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: refactor-Refactoring-s (refactor-Refactoring-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'refactor-Refactoring-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: loadtester-qualityforg (loadtester-qualityforge-scalability-testing)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'loadtester-qualityforge-scalability-testing' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: coverage-qualityforge- (coverage-qualityforge-test-coverage-analyst)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'coverage-qualityforge-test-coverage-analyst' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: Compliance Validator (qualityforge-ai-compliancevalidator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'qualityforge-ai-compliancevalidator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: dbat-testing-qualityfo (dbat-testing-qualityforge)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'dbat-testing-qualityforge' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: maintainer-qualityforg (maintainer-qualityforge-code-maintainer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'maintainer-qualityforge-code-maintainer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: compatibility (compatibility)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'compatibility' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: documenter-qualityforg (documenter-qualityforge-documentation-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'documenter-qualityforge-documentation-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: code-analyzer (code-analyzer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'code-analyzer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: validator-Validator (validator-Validator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'validator-Validator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: debugger-Debugger-spec (debugger-Debugger-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'debugger-Debugger-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: inspector-qualityforge (inspector-qualityforge-code-inspector)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'inspector-qualityforge-code-inspector' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: optimizer-qualityforge (optimizer-qualityforge-code-optimizer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'optimizer-qualityforge-code-optimizer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DP (qualityforge-ai-documentationprocess)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'qualityforge-ai-documentationprocess' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: performance-Performanc (performance-Performance-testing)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'performance-Performance-testing' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: accessibility-Accessib (accessibility-Accessibility-testing)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'accessibility-Accessibility-testing' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DSS (qualityforge-ai-decisionsupport)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'qualityforge-ai-decisionsupport' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: reporter-qualityforge- (reporter-qualityforge-quality-reporter)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'reporter-qualityforge-quality-reporter' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: load-Load-testing (load-Load-testing)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'load-Load-testing' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: ACM (qualityforge-ai-assessmentcriteria)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'qualityforge-ai-assessmentcriteria' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: standards-Standards-en (standards-Standards-enforcer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'standards-Standards-enforcer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: reviewer-qualityforge- (reviewer-qualityforge-code-reviewer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'reviewer-qualityforge-code-reviewer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: auditor (auditor)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'auditor' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: automation-qualityforg (automation-qualityforge-test-automation)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'automation-qualityforge-test-automation' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: e2e-qualityforge-end-t (e2e-qualityforge-end-to-end-testing)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'e2e-qualityforge-end-to-end-testing' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: probe-qualityforge-pro (probe-qualityforge-prompt-testing)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'probe-qualityforge-prompt-testing' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: codesmith-qualityforge (codesmith-qualityforge-code-architect)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'codesmith-qualityforge-code-architect' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: migrator-qualityforge- (migrator-qualityforge-migration-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'migrator-qualityforge-migration-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: simulator-qualityforge (simulator-qualityforge-workflow-simulation)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'simulator-qualityforge-workflow-simulation' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: trainer-qualityforge-q (trainer-qualityforge-quality-trainer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'trainer-qualityforge-quality-trainer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: architect-qualityforge (architect-qualityforge-system-architect)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'architect-qualityforge-system-architect' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: diagnostics-Diagnostic (diagnostics-Diagnostics-specialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'diagnostics-Diagnostics-specialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: governor-qualityforge- (governor-qualityforge-quality-director)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'governor-qualityforge-quality-director' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-successmanager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-successmanager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-clientconfigmanager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-clientconfigmanager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-renderservicemanager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-renderservicemanager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-onboardmaster)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-onboardmaster' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-dataguardian)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-dataguardian' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-githubbranchmanager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-githubbranchmanager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-accesscontroller)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-accesscontroller' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-onboardingcoordinator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-onboardingcoordinator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-supportintegrator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-supportintegrator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-securityspecialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-securityspecialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-analyticsspecialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-analyticsspecialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-tenantmanager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-tenantmanager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-devopsengineer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-devopsengineer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-resourceoptimizer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-resourceoptimizer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-deploymentorchestrato)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-deploymentorchestrato' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (saasforge-ai-platformarchitect)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'saasforge-ai-platformarchitect' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (voiceforge-ai-contextcoordinator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-contextcoordinator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (voiceforge-ai-intentanalyst)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-intentanalyst' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (voiceforge-ai-personalitydesigner)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-personalitydesigner' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (voiceforge-ai-platformintegrator)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-platformintegrator' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (voiceforge-ai-speechprocessor)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-speechprocessor' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (voiceforge-ai-languagespecialist)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-languagespecialist' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (voiceforge-ai-audioengineer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-audioengineer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (voiceforge-ai-qualityassurance)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-qualityassurance' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (voiceforge-ai-conversationmanager)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-conversationmanager' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (voiceforge-ai-apiarchitect)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-apiarchitect' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (voiceforge-ai-voicesynthesizer)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-voicesynthesizer' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


-- Model assignment for: DM-DT&R (voiceforge-ai-voicemaestro)
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = 'voiceforge-ai-voicemaestro' LIMIT 1),
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
ON CONFLICT DO NOTHING;


COMMIT;

-- ============================================================
-- RECONCILIATION COMPLETE
-- Total agents: 516
-- ============================================================