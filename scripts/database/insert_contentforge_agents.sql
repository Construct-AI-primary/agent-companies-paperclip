-- ============================================================================
-- INSERT CONTENTFORGE AI AGENTS
-- Generated: 2026-04-12
-- Company: ContentForge AI (16 agents)
-- Company ID: 550e8400-e29b-41d4-a716-446655440008
-- ============================================================================

-- Verify company exists
SELECT id, name FROM companies WHERE id = '550e8400-e29b-41d4-a716-446655440008';

-- Insert ContentForge AI agents
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, budget_monthly_cents, spent_monthly_cents, last_heartbeat_at, metadata, created_at, updated_at, runtime_config, permissions, is_active) VALUES

-- Blog Architect
('550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440008', 'Blog Architect', 'specialist', 'Content Creation Team Lead & Blog Specialist', 'active', 'Blog content strategy, automated writing, SEO content creation', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true),

-- Content Maestro
('550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440008', 'Content Maestro', 'specialist', 'Content Strategy Director', 'active', 'Content strategy and orchestration', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true),

-- Conversion Analyst
('550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', 'Conversion Analyst', 'specialist', 'Conversion Optimization Specialist', 'active', 'Conversion analysis and optimization', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true),

-- Conversion Specialist
('550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440008', 'Conversion Specialist', 'specialist', 'Conversion Rate Optimization Expert', 'active', 'Conversion rate optimization and testing', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true),

-- Data Analyst
('550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440008', 'Data Analyst', 'specialist', 'Content Performance Analyst', 'active', 'Content performance data analysis', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true),

-- Email Composer
('550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440008', 'Email Composer', 'specialist', 'Email Marketing Specialist', 'active', 'Email content creation and optimization', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true),

-- Link Builder
('550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440008', 'Link Builder', 'specialist', 'Link Building Specialist', 'active', 'Link building and outreach strategies', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true),

-- Local SEO Expert
('550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440008', 'Local SEO Expert', 'specialist', 'Local SEO Specialist', 'active', 'Local search engine optimization', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true),

-- Mobile Optimizer
('550e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440008', 'Mobile Optimizer', 'specialist', 'Mobile SEO Specialist', 'active', 'Mobile optimization and performance', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true),

-- Performance Optimizer
('550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440008', 'Performance Optimizer', 'specialist', 'Content Performance Specialist', 'active', 'Content performance optimization', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true),

-- Reporting Specialist
('550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440008', 'Reporting Specialist', 'specialist', 'Content Reporting Analyst', 'active', 'Content performance reporting and analytics', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true),

-- SEO Analyst
('550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440008', 'SEO Analyst', 'specialist', 'SEO Performance Analyst', 'active', 'SEO performance analysis and insights', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true),

-- SEO Strategist
('550e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440008', 'SEO Strategist', 'specialist', 'SEO Strategy Director', 'active', 'SEO strategy development and planning', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true),

-- Social Strategist
('550e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440008', 'Social Strategist', 'specialist', 'Social Media Strategist', 'active', 'Social media strategy and content planning', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true),

-- Technical SEO Specialist
('550e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440008', 'Technical SEO Specialist', 'specialist', 'Technical SEO Expert', 'active', 'Technical SEO implementation and optimization', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true),

-- UX Designer
('550e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440008', 'UX Designer', 'specialist', 'User Experience Designer', 'active', 'User experience design and optimization', 'http', '{"url":"https://hermes-agent/webhook","model":"openrouter/deepseek/deepseek-chat-v3-0324","maxIterations":50,"persistSession":true}', 0, 0, NULL, '{"team":"ContentForge AI","source":"documentation"}', NOW(), NOW(), '{"persistSession":true}', '{"canCreateAgents":false}', true)

ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- INSERT API KEYS FOR CONTENTFORGE AI AGENTS
-- ============================================================================

-- Blog Architect
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440001',
  '550e8400-e29b-41d4-a716-446655440008',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Content Maestro
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440002',
  '550e8400-e29b-41d4-a716-446655440008',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Conversion Analyst
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440003',
  '550e8400-e29b-41d4-a716-446655440008',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Conversion Specialist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440004',
  '550e8400-e29b-41d4-a716-446655440008',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Data Analyst
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440005',
  '550e8400-e29b-41d4-a716-446655440008',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Email Composer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440006',
  '550e8400-e29b-41d4-a716-446655440008',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Link Builder
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440007',
  '550e8400-e29b-41d4-a716-446655440008',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Local SEO Expert
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440008',
  '550e8400-e29b-41d4-a716-446655440008',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Mobile Optimizer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440009',
  '550e8400-e29b-41d4-a716-446655440008',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Performance Optimizer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440010',
  '550e8400-e29b-41d4-a716-446655440008',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Reporting Specialist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440011',
  '550e8400-e29b-41d4-a716-446655440008',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- SEO Analyst
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440012',
  '550e8400-e29b-41d4-a716-446655440008',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- SEO Strategist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  '550e8400-e29b-41d4-a716-446655440008',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Social Strategist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440014',
  '550e8400-e29b-41d4-a716-446655440008',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Technical SEO Specialist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440015',
  '550e8400-e29b-41d4-a716-446655440008',
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- UX Designer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440016',
  '550e8400-e29b-41d4-a716-446655440008',
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
-- WHERE c.name = 'ContentForge AI'
-- GROUP BY c.name;