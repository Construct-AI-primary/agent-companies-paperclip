-- Paperclip Ecosystem - Remaining Companies Database Population Script
-- This script populates the remaining 6 Paperclip AI companies and their agents
-- Run this AFTER the PaperclipForge AI script has been executed
-- Generated following the procedure in docs-paperclip/procedures/adding-companies-and-agents.md

-- IMPORTANT: Run this script in a transaction for safety
BEGIN;

-- =============================================================================
-- STEP 1: REMAINING COMPANIES - Insert the remaining 6 companies
-- =============================================================================

-- ContentForge AI - Creative content generation
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
  '550e8400-e29b-41d4-a716-446655440008',
  'ContentForge AI',
  'Creative AI company specializing in content generation, media development, and artistic applications across multiple formats and platforms',
  'active',
  'CFA',
  0,
  0,
  0,
  true,
  '#7c3aed',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  brand_color = EXCLUDED.brand_color,
  updated_at = EXCLUDED.updated_at;

-- MobileForge AI - Mobile application ecosystem
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
  '550e8400-e29b-41d4-a716-446655440009',
  'MobileForge AI',
  'Mobile device ecosystem company specializing in mobile application development, deployment, testing, and user experience optimization',
  'active',
  'MFA',
  0,
  0,
  0,
  true,
  '#059669',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  brand_color = EXCLUDED.brand_color,
  updated_at = EXCLUDED.updated_at;

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
  '550e8400-e29b-41d4-a716-446655440010',
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
  '550e8400-e29b-41d4-a716-446655440011',
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
  '550e8400-e29b-41d4-a716-446655440012',
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
  '550e8400-e29b-41d4-a716-446655440013',
  'DomainForge AI',
  'Multi-discipline autonomous AI company for civil engineering expertise, construction management, and infrastructure development',
  'active',
  'DFG',
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
-- STEP 2: CONTENTFORGE AI AGENTS (16 agents)
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
  '660e8400-e29b-41d4-a716-446655440020',
  '550e8400-e29b-41d4-a716-446655440008', -- ContentForge AI
  'maya-loopy-content-strategist',
  'ceo',
  'Chief Creative Orchestrator',
  'Strategic leadership and vision for ContentForge AI, creative direction oversight, cross-media content strategy, and ecosystem creative coordination.',
  'active',
  NULL, -- CEO reports to no one
  NOW(),
  NOW(),
  '{"team": "Executive", "specialization": "Creative Leadership"}'::jsonb,
  '{"can_create_agents": true, "can_assign_tasks": true, "can_manage_content": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440021',
  '550e8400-e29b-41d4-a716-446655440008',
  'creative-director',
  'general',
  'Creative Operations Director',
  'Creative operations leadership, content production oversight, quality assurance coordination, and creative team management.',
  'active',
  '660e8400-e29b-41d4-a716-446655440020', -- Reports to maya-loopy-content-strategist
  NOW(),
  NOW(),
  '{"team": "Executive", "specialization": "Creative Operations"}'::jsonb,
  '{"can_manage_operations": true, "can_coordinate_content": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440022',
  '550e8400-e29b-41d4-a716-446655440008',
  'content-architect',
  'general',
  'Content Architecture Director',
  'Content architecture design, platform integration strategy, content systems design, and technical content infrastructure.',
  'active',
  '660e8400-e29b-41d4-a716-446655440020', -- Reports to maya-loopy-content-strategist
  NOW(),
  NOW(),
  '{"team": "Executive", "specialization": "Content Architecture"}'::jsonb,
  '{"can_design_architecture": true, "can_manage_platforms": true}'::jsonb
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

-- Content Creation Team
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
  '660e8400-e29b-41d4-a716-446655440023',
  '550e8400-e29b-41d4-a716-446655440008',
  'narrative-crafter',
  'general',
  'Narrative Design Specialist',
  'Story development and narrative design, character development, plot structuring, and storytelling optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440021', -- Reports to creative-director
  NOW(),
  NOW(),
  '{"team": "Content Creation", "specialization": "Narrative Design"}'::jsonb,
  '{"can_create_narratives": true, "can_design_stories": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440024',
  '550e8400-e29b-41d4-a716-446655440008',
  'visual-artist',
  'general',
  'Visual Content Creator',
  'Visual content creation, graphic design, image generation, and visual storytelling optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440021', -- Reports to creative-director
  NOW(),
  NOW(),
  '{"team": "Content Creation", "specialization": "Visual Arts"}'::jsonb,
  '{"can_create_visuals": true, "can_design_graphics": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440025',
  '550e8400-e29b-41d4-a716-446655440008',
  'multimedia-producer',
  'general',
  'Multimedia Content Producer',
  'Multimedia content production, video editing, audio production, and multi-format content optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440021', -- Reports to creative-director
  NOW(),
  NOW(),
  '{"team": "Content Creation", "specialization": "Multimedia Production"}'::jsonb,
  '{"can_produce_multimedia": true, "can_edit_content": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440026',
  '550e8400-e29b-41d4-a716-446655440008',
  'content-optimizer',
  'general',
  'Content Performance Optimizer',
  'Content performance analysis, engagement optimization, SEO optimization, and content distribution strategy.',
  'active',
  '660e8400-e29b-41d4-a716-446655440021', -- Reports to creative-director
  NOW(),
  NOW(),
  '{"team": "Content Creation", "specialization": "Content Optimization"}'::jsonb,
  '{"can_optimize_content": true, "can_analyze_performance": true}'::jsonb
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

-- Content Strategy Team
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
  '660e8400-e29b-41d4-a716-446655440027',
  '550e8400-e29b-41d4-a716-446655440008',
  'brand-strategist',
  'general',
  'Brand Strategy Specialist',
  'Brand strategy development, brand voice definition, brand consistency management, and brand performance analysis.',
  'active',
  '660e8400-e29b-41d4-a716-446655440020', -- Reports to maya-loopy-content-strategist
  NOW(),
  NOW(),
  '{"team": "Content Strategy", "specialization": "Brand Strategy"}'::jsonb,
  '{"can_develop_strategy": true, "can_manage_brand": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440028',
  '550e8400-e29b-41d4-a716-446655440008',
  'audience-analyst',
  'general',
  'Audience Insights Analyst',
  'Audience analysis and segmentation, user behavior analysis, demographic research, and audience engagement optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440020', -- Reports to maya-loopy-content-strategist
  NOW(),
  NOW(),
  '{"team": "Content Strategy", "specialization": "Audience Analysis"}'::jsonb,
  '{"can_analyze_audience": true, "can_segment_users": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440029',
  '550e8400-e29b-41d4-a716-446655440008',
  'trend-forecaster',
  'general',
  'Content Trend Forecaster',
  'Content trend analysis and forecasting, market research, competitive analysis, and trend-driven content strategy.',
  'active',
  '660e8400-e29b-41d4-a716-446655440020', -- Reports to maya-loopy-content-strategist
  NOW(),
  NOW(),
  '{"team": "Content Strategy", "specialization": "Trend Forecasting"}'::jsonb,
  '{"can_forecast_trends": true, "can_analyze_market": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440030',
  '550e8400-e29b-41d4-a716-446655440008',
  'content-scheduler',
  'general',
  'Content Scheduling Coordinator',
  'Content scheduling and planning, editorial calendar management, content distribution timing, and publishing optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440020', -- Reports to maya-loopy-content-strategist
  NOW(),
  NOW(),
  '{"team": "Content Strategy", "specialization": "Content Scheduling"}'::jsonb,
  '{"can_schedule_content": true, "can_manage_calendar": true}'::jsonb
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

-- Content Technology Team
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
  '660e8400-e29b-41d4-a716-446655440031',
  '550e8400-e29b-41d4-a716-446655440008',
  'content-platform-engineer',
  'general',
  'Content Platform Engineer',
  'Content platform development, API integration, content management systems, and platform scalability optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440022', -- Reports to content-architect
  NOW(),
  NOW(),
  '{"team": "Content Technology", "specialization": "Platform Engineering"}'::jsonb,
  '{"can_engineer_platforms": true, "can_integrate_apis": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440032',
  '550e8400-e29b-41d4-a716-446655440008',
  'ai-content-generator',
  'general',
  'AI Content Generation Specialist',
  'AI-powered content generation, automated content creation, content personalization, and AI content optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440022', -- Reports to content-architect
  NOW(),
  NOW(),
  '{"team": "Content Technology", "specialization": "AI Content Generation"}'::jsonb,
  '{"can_generate_ai_content": true, "can_personalize_content": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440033',
  '550e8400-e29b-41d4-a716-446655440008',
  'content-quality-assurance',
  'general',
  'Content Quality Assurance Specialist',
  'Content quality control, editorial standards enforcement, content accuracy verification, and quality improvement processes.',
  'active',
  '660e8400-e29b-41d4-a716-446655440022', -- Reports to content-architect
  NOW(),
  NOW(),
  '{"team": "Content Technology", "specialization": "Quality Assurance"}'::jsonb,
  '{"can_assure_quality": true, "can_enforce_standards": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440034',
  '550e8400-e29b-41d4-a716-446655440008',
  'content-analytics-engineer',
  'general',
  'Content Analytics Engineer',
  'Content analytics implementation, performance tracking systems, data visualization, and analytics dashboard development.',
  'active',
  '660e8400-e29b-41d4-a716-446655440022', -- Reports to content-architect
  NOW(),
  NOW(),
  '{"team": "Content Technology", "specialization": "Analytics Engineering"}'::jsonb,
  '{"can_implement_analytics": true, "can_build_dashboards": true}'::jsonb
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

-- STEP 3: MOBILEFORGE AI AGENTS (10 agents)
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
  '660e8400-e29b-41d4-a716-446655440035',
  '550e8400-e29b-41d4-a716-446655440009', -- MobileForge AI
  'mobile-maestro',
  'ceo',
  'Chief Mobile Orchestrator',
  'Strategic leadership and vision for MobileForge AI, mobile ecosystem oversight, cross-platform strategy, and mobile innovation coordination.',
  'active',
  NULL, -- CEO reports to no one
  NOW(),
  NOW(),
  '{"team": "Executive", "specialization": "Mobile Leadership"}'::jsonb,
  '{"can_create_agents": true, "can_assign_tasks": true, "can_manage_mobile": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440036',
  '550e8400-e29b-41d4-a716-446655440009',
  'app-architecture-director',
  'general',
  'Mobile Architecture Director',
  'Mobile architecture design, platform strategy, technical standards, and mobile development governance.',
  'active',
  '660e8400-e29b-41d4-a716-446655440035', -- Reports to mobile-maestro
  NOW(),
  NOW(),
  '{"team": "Executive", "specialization": "Mobile Architecture"}'::jsonb,
  '{"can_design_architecture": true, "can_manage_platforms": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440037',
  '550e8400-e29b-41d4-a716-446655440009',
  'ux-mobile-director',
  'general',
  'Mobile UX Director',
  'Mobile user experience strategy, design standards, usability optimization, and user interface innovation.',
  'active',
  '660e8400-e29b-41d4-a716-446655440035', -- Reports to mobile-maestro
  NOW(),
  NOW(),
  '{"team": "Executive", "specialization": "Mobile UX"}'::jsonb,
  '{"can_design_ux": true, "can_optimize_usability": true}'::jsonb
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

-- Development Team
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
  '660e8400-e29b-41d4-a716-446655440038',
  '550e8400-e29b-41d4-a716-446655440009',
  'ios-developer',
  'general',
  'iOS Development Specialist',
  'iOS application development, Swift programming, iOS frameworks, and Apple ecosystem integration.',
  'active',
  '660e8400-e29b-41d4-a716-446655440036', -- Reports to app-architecture-director
  NOW(),
  NOW(),
  '{"team": "Development", "specialization": "iOS Development"}'::jsonb,
  '{"can_develop_ios": true, "can_integrate_apple": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440039',
  '550e8400-e29b-41d4-a716-446655440009',
  'android-developer',
  'general',
  'Android Development Specialist',
  'Android application development, Kotlin/Java programming, Android frameworks, and Google ecosystem integration.',
  'active',
  '660e8400-e29b-41d4-a716-446655440036', -- Reports to app-architecture-director
  NOW(),
  NOW(),
  '{"team": "Development", "specialization": "Android Development"}'::jsonb,
  '{"can_develop_android": true, "can_integrate_google": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440040',
  '550e8400-e29b-41d4-a716-446655440009',
  'cross-platform-developer',
  'general',
  'Cross-Platform Development Specialist',
  'Cross-platform development, React Native/Flutter, hybrid applications, and multi-platform deployment.',
  'active',
  '660e8400-e29b-41d4-a716-446655440036', -- Reports to app-architecture-director
  NOW(),
  NOW(),
  '{"team": "Development", "specialization": "Cross-Platform Development"}'::jsonb,
  '{"can_develop_cross_platform": true, "can_deploy_multi_platform": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440041',
  '550e8400-e29b-41d4-a716-446655440009',
  'mobile-qa-engineer',
  'general',
  'Mobile QA Engineer',
  'Mobile application testing, device compatibility testing, performance optimization, and quality assurance.',
  'active',
  '660e8400-e29b-41d4-a716-446655440036', -- Reports to app-architecture-director
  NOW(),
  NOW(),
  '{"team": "Development", "specialization": "Mobile QA"}'::jsonb,
  '{"can_test_mobile": true, "can_assure_quality": true}'::jsonb
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

-- UX/UI Team
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
  '660e8400-e29b-41d4-a716-446655440042',
  '550e8400-e29b-41d4-a716-446655440009',
  'mobile-ui-designer',
  'general',
  'Mobile UI Designer',
  'Mobile user interface design, responsive design, touch interaction design, and mobile-first design principles.',
  'active',
  '660e8400-e29b-41d4-a716-446655440037', -- Reports to ux-mobile-director
  NOW(),
  NOW(),
  '{"team": "UX/UI", "specialization": "Mobile UI Design"}'::jsonb,
  '{"can_design_ui": true, "can_create_responsive": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440043',
  '550e8400-e29b-41d4-a716-446655440009',
  'mobile-ux-researcher',
  'general',
  'Mobile UX Researcher',
  'Mobile user research, usability testing, user behavior analysis, and mobile user experience optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440037', -- Reports to ux-mobile-director
  NOW(),
  NOW(),
  '{"team": "UX/UI", "specialization": "Mobile UX Research"}'::jsonb,
  '{"can_research_users": true, "can_test_usability": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440044',
  '550e8400-e29b-41d4-a716-446655440009',
  'mobile-accessibility-specialist',
  'general',
  'Mobile Accessibility Specialist',
  'Mobile accessibility compliance, inclusive design, assistive technology support, and accessibility standards implementation.',
  'active',
  '660e8400-e29b-41d4-a716-446655440037', -- Reports to ux-mobile-director
  NOW(),
  NOW(),
  '{"team": "UX/UI", "specialization": "Mobile Accessibility"}'::jsonb,
  '{"can_implement_accessibility": true, "can_design_inclusive": true}'::jsonb
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

COMMIT;
