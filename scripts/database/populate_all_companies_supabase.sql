-- Paperclip Ecosystem Database Population Script
-- This script populates all 7 Paperclip AI companies and their agents
-- Generated following the procedure in docs-paperclip/procedures/adding-companies-and-agents.md

-- IMPORTANT: Run this script in a transaction for safety
BEGIN;

-- =============================================================================
-- STEP 1: COMPANIES - Insert all 7 companies first (satisfy foreign key constraints)
-- =============================================================================

-- PaperclipForge AI - Operational backbone company
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
  '550e8400-e29b-41d4-a716-446655440001',
  'PaperclipForge AI',
  'Operational backbone company specializing in intelligent project management, issue orchestration, workflow automation, and seamless integration across the Paperclip ecosystem',
  'active',
  'PFA',
  0,
  0,
  0,
  true,
  '#1e40af',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  brand_color = EXCLUDED.brand_color,
  updated_at = EXCLUDED.updated_at;

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
  '550e8400-e29b-41d4-a716-446655440002',
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
  '550e8400-e29b-41d4-a716-446655440003',
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
  '550e8400-e29b-41d4-a716-446655440004',
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
  '550e8400-e29b-41d4-a716-446655440005',
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
  '550e8400-e29b-41d4-a716-446655440006',
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
  '550e8400-e29b-41d4-a716-446655440007',
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
-- STEP 2: AGENTS - Insert all agents with proper reporting hierarchies
-- =============================================================================

-- PaperclipForge AI Agents (16 agents)
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
  '660e8400-e29b-41d4-a716-446655440001',
  '550e8400-e29b-41d4-a716-446655440001', -- PaperclipForge AI
  'project-maestro',
  'ceo',
  'Chief Executive Officer',
  'Strategic leadership and vision for PaperclipForge AI, executive oversight of all project management operations, cross-company integration and ecosystem coordination.',
  'active',
  NULL, -- CEO reports to no one
  NOW(),
  NOW(),
  '{"team": "Executive", "specialization": "Strategic Leadership"}'::jsonb,
  '{"can_create_agents": true, "can_assign_tasks": true, "can_manage_projects": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440002',
  '550e8400-e29b-41d4-a716-446655440001',
  'operations-director',
  'general',
  'Chief Operations Officer',
  'Operational leadership and execution oversight, issue orchestration and workflow management, operational performance monitoring and optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440001', -- Reports to project-maestro
  NOW(),
  NOW(),
  '{"team": "Executive", "specialization": "Operations Management"}'::jsonb,
  '{"can_manage_operations": true, "can_orchestrate_issues": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440003',
  '550e8400-e29b-41d4-a716-446655440001',
  'integration-architect',
  'general',
  'Chief Technology Officer',
  'Technology strategy and architecture leadership, system integration and interoperability design, API ecosystem management and governance.',
  'active',
  '660e8400-e29b-41d4-a716-446655440001', -- Reports to project-maestro
  NOW(),
  NOW(),
  '{"team": "Executive", "specialization": "Technology Integration"}'::jsonb,
  '{"can_manage_technology": true, "can_design_architecture": true}'::jsonb
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

-- Project Management Team
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
  '660e8400-e29b-41d4-a716-446655440004',
  '550e8400-e29b-41d4-a716-446655440001',
  'project-coordinator',
  'pm',
  'Project Lifecycle Management',
  'Project planning and initiation, project execution and monitoring, stakeholder coordination and communication, project documentation and reporting.',
  'active',
  '660e8400-e29b-41d4-a716-446655440001', -- Reports to project-maestro
  NOW(),
  NOW(),
  '{"team": "Project Management", "specialization": "Project Coordination"}'::jsonb,
  '{"can_manage_projects": true, "can_coordinate_stakeholders": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440005',
  '550e8400-e29b-41d4-a716-446655440001',
  'resource-manager',
  'pm',
  'Resource Allocation & Optimization',
  'Resource capacity planning and forecasting, resource allocation and scheduling, utilization monitoring and optimization, resource conflict resolution.',
  'active',
  '660e8400-e29b-41d4-a716-446655440001', -- Reports to project-maestro
  NOW(),
  NOW(),
  '{"team": "Project Management", "specialization": "Resource Management"}'::jsonb,
  '{"can_manage_resources": true, "can_optimize_allocation": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440006',
  '550e8400-e29b-41d4-a716-446655440001',
  'risk-analyst',
  'pm',
  'Risk Identification & Mitigation',
  'Risk identification and assessment, risk impact analysis and prioritization, mitigation strategy development, risk monitoring and reporting.',
  'active',
  '660e8400-e29b-41d4-a716-446655440001', -- Reports to project-maestro
  NOW(),
  NOW(),
  '{"team": "Project Management", "specialization": "Risk Management"}'::jsonb,
  '{"can_assess_risks": true, "can_develop_mitigation": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440007',
  '550e8400-e29b-41d4-a716-446655440001',
  'performance-monitor',
  'pm',
  'Performance Tracking & Analytics',
  'Performance metric collection and monitoring, performance analysis and trend identification, performance reporting and dashboard management.',
  'active',
  '660e8400-e29b-41d4-a716-446655440001', -- Reports to project-maestro
  NOW(),
  NOW(),
  '{"team": "Project Management", "specialization": "Performance Monitoring"}'::jsonb,
  '{"can_monitor_performance": true, "can_analyze_metrics": true}'::jsonb
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

-- Issue Orchestration Team
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
  '660e8400-e29b-41d4-a716-446655440008',
  '550e8400-e29b-41d4-a716-446655440001',
  'issue-generator',
  'general',
  'AI-Powered Issue Creation',
  'AI-powered issue identification and analysis, structured issue creation and documentation, requirement analysis and breakdown, problem identification and prioritization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440002', -- Reports to operations-director
  NOW(),
  NOW(),
  '{"team": "Issue Orchestration", "specialization": "AI Issue Generation"}'::jsonb,
  '{"can_generate_issues": true, "can_analyze_requirements": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440009',
  '550e8400-e29b-41d4-a716-446655440001',
  'assignment-specialist',
  'general',
  'Intelligent Issue Routing',
  'AI-powered agent matching and assignment, skill and availability analysis, workload balancing and optimization, assignment optimization and routing.',
  'active',
  '660e8400-e29b-41d4-a716-446655440002', -- Reports to operations-director
  NOW(),
  NOW(),
  '{"team": "Issue Orchestration", "specialization": "Intelligent Routing"}'::jsonb,
  '{"can_assign_issues": true, "can_match_skills": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440010',
  '550e8400-e29b-41d4-a716-446655440001',
  'dependency-manager',
  'general',
  'Dependency Tracking & Resolution',
  'Dependency identification and mapping, blocking issue analysis and resolution, workflow orchestration and sequencing, critical path management.',
  'active',
  '660e8400-e29b-41d4-a716-446655440002', -- Reports to operations-director
  NOW(),
  NOW(),
  '{"team": "Issue Orchestration", "specialization": "Dependency Management"}'::jsonb,
  '{"can_manage_dependencies": true, "can_orchestrate_workflows": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440011',
  '550e8400-e29b-41d4-a716-446655440001',
  'progress-tracker',
  'general',
  'Real-Time Monitoring',
  'Real-time progress monitoring and tracking, status updates and milestone tracking, bottleneck identification and resolution, progress reporting and visualization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440002', -- Reports to operations-director
  NOW(),
  NOW(),
  '{"team": "Issue Orchestration", "specialization": "Progress Tracking"}'::jsonb,
  '{"can_track_progress": true, "can_identify_bottlenecks": true}'::jsonb
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

-- Integration & Automation Team
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
  '660e8400-e29b-41d4-a716-446655440012',
  '550e8400-e29b-41d4-a716-446655440001',
  'api-manager',
  'general',
  'API Ecosystem Management',
  'API design and architecture, API documentation and maintenance, API versioning and lifecycle management, API integration and orchestration.',
  'active',
  '660e8400-e29b-41d4-a716-446655440003', -- Reports to integration-architect
  NOW(),
  NOW(),
  '{"team": "Integration & Automation", "specialization": "API Management"}'::jsonb,
  '{"can_manage_apis": true, "can_design_interfaces": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440013',
  '550e8400-e29b-41d4-a716-446655440001',
  'workflow-automator',
  'general',
  'Workflow Design & Automation',
  'Workflow design and architecture, process automation implementation, workflow optimization and improvement, automation testing and validation.',
  'active',
  '660e8400-e29b-41d4-a716-446655440003', -- Reports to integration-architect
  NOW(),
  NOW(),
  '{"team": "Integration & Automation", "specialization": "Workflow Automation"}'::jsonb,
  '{"can_design_workflows": true, "can_implement_automation": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440014',
  '550e8400-e29b-41d4-a716-446655440001',
  'quality-controller',
  'general',
  'Quality Assurance',
  'Quality assurance for integrations and automations, quality control implementation and monitoring, quality testing and validation procedures.',
  'active',
  '660e8400-e29b-41d4-a716-446655440003', -- Reports to integration-architect
  NOW(),
  NOW(),
  '{"team": "Integration & Automation", "specialization": "Quality Control"}'::jsonb,
  '{"can_assure_quality": true, "can_control_processes": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440015',
  '550e8400-e29b-41d4-a716-446655440001',
  'data-integrator',
  'general',
  'Data Flow Management',
  'Data integration architecture and design, data flow orchestration and management, data synchronization and consistency, cross-system data management.',
  'active',
  '660e8400-e29b-41d4-a716-446655440003', -- Reports to integration-architect
  NOW(),
  NOW(),
  '{"team": "Integration & Automation", "specialization": "Data Integration"}'::jsonb,
  '{"can_integrate_data": true, "can_manage_flows": true}'::jsonb
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

-- Analytics & Intelligence Team
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
  '660e8400-e29b-41d4-a716-446655440016',
  '550e8400-e29b-41d4-a716-446655440001',
  'reporting-analyst',
  'general',
  'Analytics & Reporting',
  'Analytics and reporting framework development, business intelligence dashboard creation, performance metrics analysis and reporting, stakeholder reporting and communication.',
  'active',
  '660e8400-e29b-41d4-a716-446655440001', -- Reports to project-maestro
  NOW(),
  NOW(),
  '{"team": "Analytics & Intelligence", "specialization": "Business Intelligence"}'::jsonb,
  '{"can_analyze_data": true, "can_create_reports": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440017',
  '550e8400-e29b-41d4-a716-446655440001',
  'predictive-modeler',
  'general',
  'Predictive Analytics',
  'Predictive model development and implementation, forecasting algorithm design and optimization, predictive analytics framework management, model validation and performance monitoring.',
  'active',
  '660e8400-e29b-41d4-a716-446655440001', -- Reports to project-maestro
  NOW(),
  NOW(),
  '{"team": "Analytics & Intelligence", "specialization": "Predictive Modeling"}'::jsonb,
  '{"can_build_models": true, "can_forecast_trends": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440018',
  '550e8400-e29b-41d4-a716-446655440001',
  'knowledge-integrator',
  'general',
  'Knowledge Integration',
  'Knowledge integration architecture and design, cross-system knowledge sharing and synchronization, unified knowledge repository management, knowledge quality assurance and validation.',
  'active',
  '660e8400-e29b-41d4-a716-446655440001', -- Reports to project-maestro
  NOW(),
  NOW(),
  '{"team": "Analytics & Intelligence", "specialization": "Knowledge Management"}'::jsonb,
  '{"can_integrate_knowledge": true, "can_manage_repositories": true}'::jsonb
),
(
  '660e8400-e29b-41d4-a716-446655440019',
  '550e8400-e29b-41d4-a716-446655440001',
  'user-experience-coordinator',
  'general',
  'User Interaction Management',
  'User experience design and optimization, interaction design and user interface management, feedback collection and analysis, user satisfaction monitoring and improvement.',
  'active',
  '660e8400-e29b-41d4-a716-446655440001', -- Reports to project-maestro
  NOW(),
  NOW(),
  '{"team": "Analytics & Intelligence", "specialization": "User Experience"}'::jsonb,
  '{"can_design_ux": true, "can_manage_interactions": true}'::jsonb
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
-- STEP 3: AGENT MODEL ASSIGNMENTS - Add model assignments for all agents
-- =============================================================================

-- PaperclipForge AI Agent Model Assignments (Using Model Selection Guidelines)
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
-- Executive Team (Complex strategic reasoning)
('project-maestro', 'GLM-5.1', 'primary', 1, 0.7, 4096, NOW(), 'system', 'CEO requires complex strategic reasoning and decision-making', true),
('operations-director', 'GLM-5.1', 'primary', 1, 0.7, 4096, NOW(), 'system', 'COO needs complex operational reasoning and coordination', true),
('integration-architect', 'Qwen-3.6', 'primary', 1, 0.7, 4096, NOW(), 'system', 'CTO requires expert-level system design and architecture', true),

-- Project Management Team (General coordination with some analysis)
('project-coordinator', 'GLM-5.1', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Project coordination requires complex reasoning and stakeholder management', true),
('resource-manager', 'GLM-4-Plus', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Resource management involves medium complexity optimization', true),
('risk-analyst', 'GLM-5.1', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Risk analysis requires deep analytical reasoning', true),
('performance-monitor', 'GLM-4-Plus', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Performance monitoring involves data analysis and reporting', true),

-- Issue Orchestration Team (AI-powered analysis and coordination)
('issue-generator', 'GLM-5.1', 'primary', 1, 0.7, 4096, NOW(), 'system', 'AI issue generation requires complex reasoning and analysis', true),
('assignment-specialist', 'GLM-5.1', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Intelligent routing requires complex matching algorithms', true),
('dependency-manager', 'GLM-4-Plus', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Dependency tracking involves medium complexity logic', true),
('progress-tracker', 'GLM-4-Plus', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Progress tracking requires data analysis capabilities', true),

-- Integration & Automation Team (Technical implementation)
('api-manager', 'Qwen-3.6', 'primary', 1, 0.7, 4096, NOW(), 'system', 'API management requires expert-level coding and design', true),
('workflow-automator', 'Qwen-3.6', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Workflow automation requires expert system design', true),
('quality-controller', 'GLM-5.1', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Quality control requires complex analytical reasoning', true),
('data-integrator', 'Qwen-3.6', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Data integration requires expert-level system design', true),

-- Analytics & Intelligence Team (Data analysis and insights)
('reporting-analyst', 'Qwen-3.6', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Advanced analytics requires expert data analysis capabilities', true),
('predictive-modeler', 'Qwen-3.6', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Predictive modeling requires expert analytical reasoning', true),
('knowledge-integrator', 'GLM-5.1', 'primary', 1, 0.7, 4096, NOW(), 'system', 'Knowledge integration requires complex reasoning and synthesis', true),
('user-experience-coordinator', 'GLM-5.1', 'primary', 1, 0.7, 4096, NOW(), 'system', 'UX coordination requires deep understanding and analysis', true)
ON CONFLICT (agent_id, assignment_type) DO NOTHING;

-- =============================================================================
-- STEP 4: VERIFICATION QUERIES - Uncomment to verify successful insertion
-- =============================================================================

/*
-- Count agents by company
SELECT
  c.name AS company_name,
  COUNT(a.id) AS agent_count
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
WHERE c.id IN (
  '550e8400-e29b-41d4-a716-446655440001',
  '550e8400-e29b-41d4-a716-446655440002',
  '550e8400-e29b-41d4-a716-446655440003',
  '550e8400-e29b-41d4-a716-446655440004',
  '550e8400-e29b-41d4-a716-446655440005',
  '550e8400-e29b-41d4-a716-446655440006',
  '550e8400-e29b-41d4-a716-446655440007'
)
GROUP BY c.name;

-- View agent hierarchy for PaperclipForge AI
SELECT
  a.name,
  a.role,
  a.title,
  boss.name AS reports_to
FROM agents a
LEFT JOIN agents boss ON a.reports_to = boss.id
WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440001'
ORDER BY a.created_at;

-- Check for agents missing model assignments
SELECT a.name, a.company_id, c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
WHERE am.id IS NULL
ORDER BY c.name, a.name;
*/

COMMIT;

-- =============================================================================
-- SUCCESS MESSAGE
-- =============================================================================

-- If you reach this point without errors, all companies and agents have been
-- successfully inserted into the Paperclip database following the procedure
-- in docs-paperclip/procedures/adding-companies-and-agents.md

-- Next steps:
-- 1. Run the verification queries above to confirm successful insertion
-- 2. Update AGENTS.md files with correct reportsTo field matching database
-- 3. Test agent functionality in the Paperclip system