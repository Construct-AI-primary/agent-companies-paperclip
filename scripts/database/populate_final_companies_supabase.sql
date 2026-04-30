-- Paperclip Ecosystem - Final Companies Database Population Script
-- This script populates the final 4 Paperclip AI companies and their agents
-- Run this AFTER the previous scripts have been executed
-- Generated following the procedure in docs-paperclip/procedures/adding-companies-and-agents.md

-- IMPORTANT: Run this script in a transaction for safety
BEGIN;

-- =============================================================================
-- STEP 1: FINAL COMPANIES - Insert the final 4 companies
-- =============================================================================

-- ExecForge AI - Executive support and business intelligence
INSERT INTO companies (
  id,
  name,
  description,
  status,
  issue_prefix,
  issue_counter,
  budget_monthly_cents,
  spent_monthly_cents,
  require_board_approval_for_new_agents,
  brand_color,
  created_at,
  updated_at
) VALUES
(
  '550e8400-e29b-41d4-a716-446655440014',
  'ExecForge AI',
  'Executive support company specializing in business intelligence, strategic analysis, executive assistance, and high-level decision support',
  'active',
  'EFA',
  0,
  0,
  0,
  true,
  '#dc2626',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  brand_color = EXCLUDED.brand_color,
  updated_at = EXCLUDED.updated_at;

-- SaaSForge AI - SaaS platform management
INSERT INTO companies (
  id,
  name,
  description,
  status,
  issue_prefix,
  issue_counter,
  budget_monthly_cents,
  spent_monthly_cents,
  require_board_approval_for_new_agents,
  brand_color,
  created_at,
  updated_at
) VALUES
(
  '550e8400-e29b-41d4-a716-446655440015',
  'SaaSForge AI',
  'SaaS platform management company specializing in customer success, platform operations, subscription management, and user engagement',
  'active',
  'SFA',
  0,
  0,
  0,
  true,
  '#ea580c',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  brand_color = EXCLUDED.brand_color,
  updated_at = EXCLUDED.updated_at;

-- VoiceForge AI - Voice AI and conversational intelligence
INSERT INTO companies (
  id,
  name,
  description,
  status,
  issue_prefix,
  issue_counter,
  budget_monthly_cents,
  spent_monthly_cents,
  require_board_approval_for_new_agents,
  brand_color,
  created_at,
  updated_at
) VALUES
(
  '550e8400-e29b-41d4-a716-446655440016',
  'VoiceForge AI',
  'Voice AI company specializing in conversational intelligence, speech processing, voice synthesis, and multi-modal communication systems',
  'active',
  'VFA',
  0,
  0,
  0,
  true,
  '#0891b2',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  brand_color = EXCLUDED.brand_color,
  updated_at = EXCLUDED.updated_at;

-- DomainForge AI - Construction industry expertise
INSERT INTO companies (
  id,
  name,
  description,
  status,
  issue_prefix,
  issue_counter,
  budget_monthly_cents,
  spent_monthly_cents,
  require_board_approval_for_new_agents,
  brand_color,
  created_at,
  updated_at
) VALUES
(
  '550e8400-e29b-41d4-a716-446655440017',
  'DomainForge AI',
  'Multi-discipline autonomous AI company for civil engineering expertise, construction management, and infrastructure development',
  'active',
  'DFA',
  0,
  0,
  0,
  true,
  '#2563eb',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  brand_color = EXCLUDED.brand_color,
  updated_at = EXCLUDED.updated_at;

-- =============================================================================
-- STEP 2: EXECFORGE AI AGENTS (16 agents)
-- =============================================================================

-- Executive Team
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  created_at,
  updated_at,
  metadata,
  permissions
) VALUES
(
  '660e8400-e29b-41d4-a716-446655440045',
  '550e8400-e29b-41d4-a716-446655440014', -- ExecForge AI
  'executive-orchestrator',
  'ceo',
  'Chief Executive Orchestrator',
  'Strategic leadership and vision for ExecForge AI, executive ecosystem oversight, strategic decision support, and executive intelligence coordination.',
  'active',
  NULL, -- CEO reports to no one
  NOW(),
  NOW(),
  '{"team": "Executive", "specialization": "Executive Leadership"}'::jsonb,
  '{"can_create_agents": true, "can_assign_tasks": true, "can_manage_executive": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440046',
  '550e8400-e29b-41d4-a716-446655440014',
  'business-intelligence-director',
  'general',
  'Business Intelligence Director',
  'Business intelligence strategy, analytics framework, executive reporting, and intelligence operations management.',
  'active',
  '660e8400-e29b-41d4-a716-446655440045', -- Reports to executive-orchestrator
  NOW(),
  NOW(),
  '{"team": "Executive", "specialization": "Business Intelligence"}'::jsonb,
  '{"can_analyze_business": true, "can_manage_intelligence": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440047',
  '550e8400-e29b-41d4-a716-446655440014',
  'executive-assistance-director',
  'general',
  'Executive Assistance Director',
  'Executive assistance strategy, communication management, scheduling optimization, and executive support coordination.',
  'active',
  '660e8400-e29b-41d4-a716-446655440045', -- Reports to executive-orchestrator
  NOW(),
  NOW(),
  '{"team": "Executive", "specialization": "Executive Assistance"}'::jsonb,
  '{"can_assist_executive": true, "can_manage_communication": true}'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions;

-- Business Intelligence Team
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  created_at,
  updated_at,
  metadata,
  permissions
) VALUES
(
  '660e8400-e29b-41d4-a716-446655440048',
  '550e8400-e29b-41d4-a716-446655440014',
  'strategic-analyst',
  'general',
  'Strategic Analysis Specialist',
  'Strategic analysis and planning, market intelligence, competitive analysis, and strategic recommendation development.',
  'active',
  '660e8400-e29b-41d4-a716-446655440046', -- Reports to business-intelligence-director
  NOW(),
  NOW(),
  '{"team": "Business Intelligence", "specialization": "Strategic Analysis"}'::jsonb,
  '{"can_analyze_strategy": true, "can_develop_recommendations": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440049',
  '550e8400-e29b-41d4-a716-446655440014',
  'market-intelligence-analyst',
  'general',
  'Market Intelligence Analyst',
  'Market research and analysis, industry trends monitoring, market opportunity identification, and intelligence reporting.',
  'active',
  '660e8400-e29b-41d4-a716-446655440046', -- Reports to business-intelligence-director
  NOW(),
  NOW(),
  '{"team": "Business Intelligence", "specialization": "Market Intelligence"}'::jsonb,
  '{"can_research_market": true, "can_monitor_trends": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440050',
  '550e8400-e29b-41d4-a716-446655440014',
  'performance-metrics-analyst',
  'general',
  'Performance Metrics Analyst',
  'Performance metrics development, KPI tracking, performance analysis, and executive dashboard management.',
  'active',
  '660e8400-e29b-41d4-a716-446655440046', -- Reports to business-intelligence-director
  NOW(),
  NOW(),
  '{"team": "Business Intelligence", "specialization": "Performance Metrics"}'::jsonb,
  '{"can_develop_metrics": true, "can_track_kpi": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440051',
  '550e8400-e29b-41d4-a716-446655440014',
  'risk-assessment-analyst',
  'general',
  'Risk Assessment Analyst',
  'Risk assessment and analysis, risk mitigation strategy development, compliance monitoring, and risk reporting.',
  'active',
  '660e8400-e29b-41d4-a716-446655440046', -- Reports to business-intelligence-director
  NOW(),
  NOW(),
  '{"team": "Business Intelligence", "specialization": "Risk Assessment"}'::jsonb,
  '{"can_assess_risk": true, "can_develop_mitigation": true}'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions;

-- Executive Assistance Team
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  created_at,
  updated_at,
  metadata,
  permissions
) VALUES
(
  '660e8400-e29b-41d4-a716-446655440052',
  '550e8400-e29b-41d4-a716-446655440014',
  'communication-manager',
  'general',
  'Executive Communication Manager',
  'Executive communication management, stakeholder coordination, message development, and communication strategy.',
  'active',
  '660e8400-e29b-41d4-a716-446655440047', -- Reports to executive-assistance-director
  NOW(),
  NOW(),
  '{"team": "Executive Assistance", "specialization": "Communication Management"}'::jsonb,
  '{"can_manage_communication": true, "can_coordinate_stakeholders": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440053',
  '550e8400-e29b-41d4-a716-446655440014',
  'scheduling-coordinator',
  'general',
  'Executive Scheduling Coordinator',
  'Executive scheduling and calendar management, meeting coordination, time optimization, and priority management.',
  'active',
  '660e8400-e29b-41d4-a716-446655440047', -- Reports to executive-assistance-director
  NOW(),
  NOW(),
  '{"team": "Executive Assistance", "specialization": "Scheduling Coordination"}'::jsonb,
  '{"can_manage_schedules": true, "can_coordinate_meetings": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440054',
  '550e8400-e29b-41d4-a716-446655440014',
  'decision-support-analyst',
  'general',
  'Decision Support Analyst',
  'Decision support analysis, option evaluation, recommendation development, and decision framework implementation.',
  'active',
  '660e8400-e29b-41d4-a716-446655440047', -- Reports to executive-assistance-director
  NOW(),
  NOW(),
  '{"team": "Executive Assistance", "specialization": "Decision Support"}'::jsonb,
  '{"can_support_decisions": true, "can_evaluate_options": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440055',
  '550e8400-e29b-41d4-a716-446655440014',
  'executive-admin-assistant',
  'general',
  'Executive Administrative Assistant',
  'Administrative support, document management, executive correspondence, and operational coordination.',
  'active',
  '660e8400-e29b-41d4-a716-446655440047', -- Reports to executive-assistance-director
  NOW(),
  NOW(),
  '{"team": "Executive Assistance", "specialization": "Administrative Support"}'::jsonb,
  '{"can_support_admin": true, "can_manage_documents": true}'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions;

-- Strategic Operations Team
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  created_at,
  updated_at,
  metadata,
  permissions
) VALUES
(
  '660e8400-e29b-41d4-a716-446655440056',
  '550e8400-e29b-41d4-a716-446655440014',
  'strategic-planner',
  'general',
  'Strategic Planning Specialist',
  'Strategic planning and execution, goal setting and tracking, strategic initiative management, and performance monitoring.',
  'active',
  '660e8400-e29b-41d4-a716-446655440045', -- Reports to executive-orchestrator
  NOW(),
  NOW(),
  '{"team": "Strategic Operations", "specialization": "Strategic Planning"}'::jsonb,
  '{"can_plan_strategy": true, "can_track_goals": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440057',
  '550e8400-e29b-41d4-a716-446655440014',
  'change-management-specialist',
  'general',
  'Change Management Specialist',
  'Change management strategy, organizational change implementation, stakeholder engagement, and change communication.',
  'active',
  '660e8400-e29b-41d4-a716-446655440045', -- Reports to executive-orchestrator
  NOW(),
  NOW(),
  '{"team": "Strategic Operations", "specialization": "Change Management"}'::jsonb,
  '{"can_manage_change": true, "can_engage_stakeholders": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440058',
  '550e8400-e29b-41d4-a716-446655440014',
  'executive-coach',
  'general',
  'Executive Coaching Specialist',
  'Executive coaching and development, leadership development, performance improvement, and executive mentoring.',
  'active',
  '660e8400-e29b-41d4-a716-446655440045', -- Reports to executive-orchestrator
  NOW(),
  NOW(),
  '{"team": "Strategic Operations", "specialization": "Executive Coaching"}'::jsonb,
  '{"can_coach_executive": true, "can_develop_leadership": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440059',
  '550e8400-e29b-41d4-a716-446655440014',
  'governance-specialist',
  'general',
  'Executive Governance Specialist',
  'Governance framework development, board relations management, compliance oversight, and governance reporting.',
  'active',
  '660e8400-e29b-41d4-a716-446655440045', -- Reports to executive-orchestrator
  NOW(),
  NOW(),
  '{"team": "Strategic Operations", "specialization": "Executive Governance"}'::jsonb,
  '{"can_develop_governance": true, "can_manage_board": true}'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions;

-- =============================================================================
-- STEP 3: AGENT MODEL ASSIGNMENTS - Add model assignments for ExecForge AI agents
-- =============================================================================

INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_at,
  assigned_by,
  reason,
  is_active
) VALUES
-- Executive Team
('executive-orchestrator', 'anthropic/claude-3.5-sonnet', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Default model assignment for CEO agent', true),
('business-intelligence-director', 'anthropic/claude-3.5-sonnet', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Default model assignment for BI director', true),
('executive-assistance-director', 'anthropic/claude-3.5-sonnet', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Default model assignment for assistance director', true),

-- Business Intelligence Team
('strategic-analyst', 'anthropic/claude-3.5-sonnet', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Default model assignment for strategic analyst', true),
('market-intelligence-analyst', 'anthropic/claude-3.5-sonnet', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Default model assignment for market intelligence analyst', true),
('performance-metrics-analyst', 'anthropic/claude-3.5-sonnet', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Default model assignment for performance analyst', true),
('risk-assessment-analyst', 'anthropic/claude-3.5-sonnet', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Default model assignment for risk analyst', true),

-- Executive Assistance Team
('communication-manager', 'anthropic/claude-3.5-sonnet', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Default model assignment for communication manager', true),
('scheduling-coordinator', 'anthropic/claude-3.5-sonnet', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Default model assignment for scheduling coordinator', true),
('decision-support-analyst', 'anthropic/claude-3.5-sonnet', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Default model assignment for decision support analyst', true),
('executive-admin-assistant', 'anthropic/claude-3.5-sonnet', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Default model assignment for admin assistant', true),

-- Strategic Operations Team
('strategic-planner', 'anthropic/claude-3.5-sonnet', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Default model assignment for strategic planner', true),
('change-management-specialist', 'anthropic/claude-3.5-sonnet', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Default model assignment for change management specialist', true),
('executive-coach', 'anthropic/claude-3.5-sonnet', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Default model assignment for executive coach', true),
('governance-specialist', 'anthropic/claude-3.5-sonnet', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Default model assignment for governance specialist', true)
ON CONFLICT (agent_id, assignment_type) DO NOTHING;

COMMIT;

-- =============================================================================
-- SUCCESS MESSAGE
-- =============================================================================

-- If you reach this point without errors, ExecForge AI has been successfully
-- inserted into the Paperclip database.

-- Next steps:
-- 1. Continue with SaaSForge AI, VoiceForge AI, and DomainForge AI
-- 2. Run the verification script to confirm successful insertion
-- 3. Update AGENTS.md files with correct reportsTo field matching database
-- 4. Test agent functionality in the Paperclip system