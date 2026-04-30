-- ============================================================================
-- INSERT PAPERCLIPFORGE AI AGENTS
-- Generated: 2026-04-12
-- Company: PaperclipForge AI (21 agents)
-- Company ID: 550e8400-e29b-41d4-a716-446655440013
-- ============================================================================

-- Create PaperclipForge AI company if it doesn't exist
INSERT INTO companies (
    id, name, description, status, issue_prefix, issue_counter,
    budget_monthly_cents, spent_monthly_cents, require_board_approval_for_new_agents,
    created_at, updated_at
) VALUES (
    '550e8400-e29b-41d4-a716-446655440013',
    'PaperclipForge AI',
    'AI-powered project management and orchestration company',
    'active',
    'PPF',
    0,
    0,
    0,
    true,
    NOW(),
    NOW()
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    status = EXCLUDED.status,
    updated_at = NOW();

-- Verify company exists
SELECT id, name FROM companies WHERE name = 'PaperclipForge AI';

-- Insert PaperclipForge AI agents
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, budget_monthly_cents, spent_monthly_cents, last_heartbeat_at, metadata, created_at, updated_at, runtime_config, permissions, icon, pause_reason, paused_at, model_config, device_config, deleted_at, is_active) VALUES

-- API Manager
('550e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440013', 'API Manager', 'specialist', 'API Ecosystem Management', 'active', NULL, 'API ecosystem management and integration', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Assignment Specialist
('550e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440013', 'Assignment Specialist', 'specialist', 'Intelligent Issue Routing', 'active', NULL, 'Intelligent issue routing and assignment', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Data Integrator
('550e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440013', 'Data Integrator', 'specialist', 'Data Flow Management', 'active', NULL, 'Data flow management and integration', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Dependency Manager
('550e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440013', 'Dependency Manager', 'specialist', 'Dependency Tracking & Resolution', 'active', NULL, 'Dependency tracking and resolution', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Integration Architect
('550e8400-e29b-41d4-a716-446655440021', '550e8400-e29b-41d4-a716-446655440013', 'Integration Architect', 'ceo', 'Chief Technology Officer', 'active', NULL, 'System integration and architecture leadership', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":true}', '🏗️', NULL, NULL, NULL, NULL, NULL, true),

-- Issue Generator
('550e8400-e29b-41d4-a716-446655440022', '550e8400-e29b-41d4-a716-446655440013', 'Issue Generator', 'specialist', 'AI-Powered Issue Creation', 'active', NULL, 'AI-powered issue creation and management', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Knowledge Integrator
('550e8400-e29b-41d4-a716-446655440023', '550e8400-e29b-41d4-a716-446655440013', 'Knowledge Integrator', 'specialist', 'Knowledge Integration', 'active', NULL, 'Knowledge integration and management', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Operations Director
('550e8400-e29b-41d4-a716-446655440024', '550e8400-e29b-41d4-a716-446655440013', 'Operations Director', 'specialist', 'Chief Operations Officer', 'active', NULL, 'Operations leadership and management', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', '⚙️', NULL, NULL, NULL, NULL, NULL, true),

-- Performance Monitor
('550e8400-e29b-41d4-a716-446655440025', '550e8400-e29b-41d4-a716-446655440013', 'Performance Monitor', 'specialist', 'Performance Tracking & Analytics', 'active', NULL, 'Performance tracking and analytics', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Predictive Modeler
('550e8400-e29b-41d4-a716-446655440026', '550e8400-e29b-41d4-a716-446655440013', 'Predictive Modeler', 'specialist', 'Predictive Analytics', 'active', NULL, 'Predictive analytics and modeling', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Progress Tracker
('550e8400-e29b-41d4-a716-446655440027', '550e8400-e29b-41d4-a716-446655440013', 'Progress Tracker', 'specialist', 'Real-Time Monitoring', 'active', NULL, 'Real-time progress monitoring', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Project Coordinator
('550e8400-e29b-41d4-a716-446655440028', '550e8400-e29b-41d4-a716-446655440013', 'Project Coordinator', 'specialist', 'Project Lifecycle Management', 'active', NULL, 'Project lifecycle management', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Project Maestro
('550e8400-e29b-41d4-a716-446655440029', '550e8400-e29b-41d4-a716-446655440013', 'Project Maestro', 'specialist', 'Project Orchestration', 'active', NULL, 'Project orchestration and coordination', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Quality Controller
('550e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655440013', 'Quality Controller', 'specialist', 'Quality Assurance', 'active', NULL, 'Quality assurance and control', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Reporting Analyst
('550e8400-e29b-41d4-a716-446655440031', '550e8400-e29b-41d4-a716-446655440013', 'Reporting Analyst', 'specialist', 'Analytics & Reporting', 'active', NULL, 'Analytics and reporting', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Resource Manager
('550e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655440013', 'Resource Manager', 'specialist', 'Resource Allocation & Optimization', 'active', NULL, 'Resource allocation and optimization', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Risk Analyst
('550e8400-e29b-41d4-a716-446655440033', '550e8400-e29b-41d4-a716-446655440013', 'Risk Analyst', 'specialist', 'Risk Identification & Mitigation', 'active', NULL, 'Risk identification and mitigation', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- User Experience Coordinator
('550e8400-e29b-41d4-a716-446655440034', '550e8400-e29b-41d4-a716-446655440013', 'User Experience Coordinator', 'specialist', 'User Interaction Management', 'active', NULL, 'User interaction management', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Vision Loopy CEO
('550e8400-e29b-41d4-a716-446655440035', '550e8400-e29b-41d4-a716-446655440013', 'Vision Loopy CEO', 'specialist', 'Vision Strategist', 'active', NULL, 'Vision and strategic planning', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Workflow Automator
('550e8400-e29b-41d4-a716-446655440036', '550e8400-e29b-41d4-a716-446655440013', 'Workflow Automator', 'specialist', 'Workflow Design & Automation', 'active', NULL, 'Workflow design and automation', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true),

-- Maya Loopy Content Strategist
('550e8400-e29b-41d4-a716-446655440037', '550e8400-e29b-41d4-a716-446655440013', 'Maya Loopy Content Strategist', 'specialist', 'Content Strategist & UX Writer', 'active', NULL, 'Content strategy and UX writing', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"PaperclipForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', NULL, NULL, NULL, NULL, NULL, NULL, true)

ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- INSERT API KEYS FOR PAPERCLIPFORGE AI AGENTS
-- ============================================================================

-- API Manager
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440017',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Assignment Specialist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440018',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Data Integrator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440019',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Dependency Manager
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440020',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Integration Architect
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440021',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Issue Generator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440022',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Knowledge Integrator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440023',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Operations Director
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440024',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Performance Monitor
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440025',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Predictive Modeler
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440026',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Progress Tracker
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440027',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Project Coordinator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440028',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Project Maestro
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440029',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Quality Controller
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440030',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Reporting Analyst
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440031',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Resource Manager
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440032',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Risk Analyst
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440033',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- User Experience Coordinator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440034',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Vision Loopy CEO
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440035',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Workflow Automator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440036',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Maya Loopy Content Strategist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440037',
  '550e8400-e29b-41d4-a716-446655440013',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- ============================================================================
-- VERIFICATION QUERY
-- ============================================================================
-- Run this to verify all agents and keys were created:
-- SELECT
--     c.name as company,
--     COUNT(DISTINCT a.id) as total_agents,
--     COUNT(DISTINCT aak.id) as agents_with_keys
-- FROM companies c
-- LEFT JOIN agents a ON c.id = a.company_id AND a.is_active = true
-- LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
-- WHERE c.name = 'PaperclipForge AI'
-- GROUP BY c.name;