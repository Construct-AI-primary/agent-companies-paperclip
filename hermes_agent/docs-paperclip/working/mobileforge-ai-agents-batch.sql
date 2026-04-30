-- MobileForge AI Agents Population Script
-- Generated: 2026-04-10
-- This script creates all MobileForge AI agents in the database

BEGIN;

-- Insert MobileForge AI Company (if not exists)
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
  'mobileforge-ai-company-id',
  'MobileForge AI',
  'Specialized autonomous AI company focused on mobile device ecosystem management, optimization, and development within the Paperclip ecosystem',
  'active',
  'MFG',
  0,
  0,
  0,
  true,
  '#3b82f6',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  issue_prefix = EXCLUDED.issue_prefix,
  brand_color = EXCLUDED.brand_color,
  updated_at = EXCLUDED.updated_at;

-- Insert MobileForge AI Agents
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  metadata,
  permissions,
  created_at,
  updated_at
) VALUES
-- CEO
(
  'mobile-maestro',
  'mobileforge-ai-company-id',
  'Mobile Maestro',
  'ceo',
  'Chief Mobile Orchestrator',
  'Strategic leadership, team management, business operations, and technical oversight for mobile initiatives',
  'active',
  NULL,
  '{"team": "MobileForge AI", "specialization": "Mobile Strategy & Leadership"}'::jsonb,
  '{"can_create_agents": true, "can_assign_tasks": true, "can_manage_budget": true}'::jsonb,
  NOW(),
  NOW()
),
-- Device Management Team
(
  'device-controller',
  'mobileforge-ai-company-id',
  'Device Controller',
  'general',
  'Device Management Specialist',
  'iOS/Android device management, OS updates, device configuration, and technical support',
  'active',
  'mobile-maestro',
  '{"team": "Device Management", "specialization": "Device Lifecycle"}'::jsonb,
  '{"can_manage_devices": true, "can_configure_security": true}'::jsonb,
  NOW(),
  NOW()
),
(
  'app-manager',
  'mobileforge-ai-company-id',
  'App Manager',
  'general',
  'Mobile Application Lifecycle Specialist',
  'App store management, deployment coordination, version control, and user experience optimization',
  'active',
  'mobile-maestro',
  '{"team": "Device Management", "specialization": "App Lifecycle"}'::jsonb,
  '{"can_manage_releases": true, "can_publish_apps": true}'::jsonb,
  NOW(),
  NOW()
),
(
  'security-guardian',
  'mobileforge-ai-company-id',
  'Security Guardian',
  'general',
  'Mobile Security Specialist',
  'Mobile security frameworks, threat detection, compliance monitoring, and data protection',
  'active',
  'mobile-maestro',
  '{"team": "Device Management", "specialization": "Mobile Security"}'::jsonb,
  '{"can_manage_security": true, "can_audit_compliance": true}'::jsonb,
  NOW(),
  NOW()
),
(
  'performance-optimizer',
  'mobileforge-ai-company-id',
  'Performance Optimizer',
  'general',
  'Device Performance Specialist',
  'Battery optimization, memory management, network optimization, and performance monitoring',
  'active',
  'mobile-maestro',
  '{"team": "Device Management", "specialization": "Performance Optimization"}'::jsonb,
  '{"can_optimize_performance": true, "can_monitor_systems": true}'::jsonb,
  NOW(),
  NOW()
),
-- Development Team
(
  'mobile-developer',
  'mobileforge-ai-company-id',
  'Mobile Developer',
  'engineer',
  'Cross-Platform Development Specialist',
  'React Native, Flutter, Swift/Kotlin development, framework selection, and code architecture',
  'active',
  'mobile-maestro',
  '{"team": "Development", "specialization": "Cross-Platform Development"}'::jsonb,
  '{"can_develop_apps": true, "can_review_code": true}'::jsonb,
  NOW(),
  NOW()
),
(
  'ui-ux-specialist',
  'mobileforge-ai-company-id',
  'UI/UX Specialist',
  'general',
  'Mobile Interface Design Specialist',
  'Mobile UI/UX design, accessibility, user research, and design system development',
  'active',
  'mobile-maestro',
  '{"team": "Development", "specialization": "Mobile UI/UX"}'::jsonb,
  '{"can_design_interfaces": true, "can_conduct_research": true}'::jsonb,
  NOW(),
  NOW()
),
(
  'testing-coordinator',
  'mobileforge-ai-company-id',
  'Testing Coordinator',
  'general',
  'Mobile Testing Specialist',
  'Automated testing frameworks, device compatibility testing, performance testing, and QA processes',
  'active',
  'mobile-maestro',
  '{"team": "Development", "specialization": "Mobile Testing"}'::jsonb,
  '{"can_manage_testing": true, "can_coordinate_qa": true}'::jsonb,
  NOW(),
  NOW()
),
-- Integration Team
(
  'api-specialist',
  'mobileforge-ai-company-id',
  'API Specialist',
  'engineer',
  'Mobile API Integration Specialist',
  'REST/GraphQL API design, third-party integrations, authentication, and performance optimization',
  'active',
  'mobile-maestro',
  '{"team": "Integration", "specialization": "Mobile APIs"}'::jsonb,
  '{"can_design_apis": true, "can_integrate_systems": true}'::jsonb,
  NOW(),
  NOW()
),
(
  'cloud-connector',
  'mobileforge-ai-company-id',
  'Cloud Connector',
  'engineer',
  'Mobile-Cloud Services Specialist',
  'Cloud infrastructure for mobile, push notifications, offline sync, and scalability solutions',
  'active',
  'mobile-maestro',
  '{"team": "Integration", "specialization": "Mobile Cloud"}'::jsonb,
  '{"can_manage_cloud": true, "can_configure_notifications": true}'::jsonb,
  NOW(),
  NOW()
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

-- Add model assignments for all agents
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
-- CEO
(
  'Mobile Maestro',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for CEO agent',
  true
),
-- Device Management Team
(
  'Device Controller',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for device management agent',
  true
),
(
  'App Manager',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for app management agent',
  true
),
(
  'Security Guardian',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for security agent',
  true
),
(
  'Performance Optimizer',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for performance agent',
  true
),
-- Development Team
(
  'Mobile Developer',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for mobile development agent',
  true
),
(
  'UI/UX Specialist',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for UI/UX agent',
  true
),
(
  'Testing Coordinator',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for testing agent',
  true
),
-- Integration Team
(
  'API Specialist',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for API integration agent',
  true
),
(
  'Cloud Connector',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for cloud services agent',
  true
)
ON CONFLICT (agent_id, assignment_type) DO NOTHING;

COMMIT;

-- Verification queries
-- SELECT c.name, COUNT(a.id) as agent_count FROM companies c LEFT JOIN agents a ON c.id = a.company_id WHERE c.name = 'MobileForge AI' GROUP BY c.name;
-- SELECT name, role, title, reports_to FROM agents WHERE company_id = 'mobileforge-ai-company-id' ORDER BY name;