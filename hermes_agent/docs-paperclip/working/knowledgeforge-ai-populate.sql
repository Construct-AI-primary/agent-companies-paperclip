-- KnowledgeForge AI System Management Agents Population Script
-- Generated: 2026-04-10
-- This script adds the new system management agents to the existing KnowledgeForge AI company
-- Company ID: 24ff8810-d4cd-4846-99f2-fe82b02d44b4 (already exists in database)

BEGIN;

-- Insert KnowledgeForge AI System Management Agents
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
-- System Management Agents (report to Coordinator Guardian)
-- System Management Agents
(
  'kfg-ai-manager-id',
  '24ff8810-d4cd-4846-99f2-fe82b02d44b4',
  'AI Manager',
  'engineer',
  'AI Manager',
  'AI Systems, Agent Management, Machine Learning Operations',
  'idle',
  'kfg-coordinator-guardian-id',
  '{"team": "KnowledgeForge AI", "discipline": "AI Management"}'::jsonb,
  '{}'::jsonb,
  NOW(),
  NOW()
),
(
  'kfg-communication-manager-id',
  '24ff8810-d4cd-4846-99f2-fe82b02d44b4',
  'Communication Manager',
  'general',
  'Communication Manager',
  'Email Systems, Notifications, Communication Management',
  'idle',
  'kfg-coordinator-guardian-id',
  '{"team": "KnowledgeForge AI", "discipline": "Communication Management"}'::jsonb,
  '{}'::jsonb,
  NOW(),
  NOW()
),
(
  'kfg-development-manager-id',
  '24ff8810-d4cd-4846-99f2-fe82b02d44b4',
  'Development Manager',
  'engineer',
  'Development Manager',
  'Development Tools, Templates, Code Management',
  'idle',
  'kfg-coordinator-guardian-id',
  '{"team": "KnowledgeForge AI", "discipline": "Development Management"}'::jsonb,
  '{}'::jsonb,
  NOW(),
  NOW()
),
(
  'kfg-interface-specialist-id',
  '24ff8810-d4cd-4846-99f2-fe82b02d44b4',
  'Interface Specialist',
  'general',
  'Interface Specialist',
  'UI Components, Modal Management, Interface Design',
  'idle',
  'kfg-coordinator-guardian-id',
  '{"team": "KnowledgeForge AI", "discipline": "Interface Management"}'::jsonb,
  '{}'::jsonb,
  NOW(),
  NOW()
),
(
  'kfg-operations-coordinator-id',
  '24ff8810-d4cd-4846-99f2-fe82b02d44b4',
  'Operations Coordinator',
  'general',
  'Operations Coordinator',
  'Business Operations, Workflow Management, Administrative Processes',
  'idle',
  'kfg-coordinator-guardian-id',
  '{"team": "KnowledgeForge AI", "discipline": "Operations Coordination"}'::jsonb,
  '{}'::jsonb,
  NOW(),
  NOW()
),
(
  'kfg-quality-assurance-id',
  '24ff8810-d4cd-4846-99f2-fe82b02d44b4',
  'Quality Assurance',
  'general',
  'Quality Assurance Specialist',
  'Quality Control, Inspection, Testing Processes',
  'idle',
  'kfg-coordinator-guardian-id',
  '{"team": "KnowledgeForge AI", "discipline": "Quality Assurance"}'::jsonb,
  '{}'::jsonb,
  NOW(),
  NOW()
),
(
  'kfg-system-administrator-id',
  '24ff8810-d4cd-4846-99f2-fe82b02d44b4',
  'System Administrator',
  'devops',
  'System Administrator',
  'System Configuration, Administration, IT Management',
  'idle',
  'kfg-coordinator-guardian-id',
  '{"team": "KnowledgeForge AI", "discipline": "System Administration"}'::jsonb,
  '{}'::jsonb,
  NOW(),
  NOW()
),
(
  'kfg-user-manager-id',
  '24ff8810-d4cd-4846-99f2-fe82b02d44b4',
  'User Manager',
  'general',
  'User Manager',
  'User Management, Authentication, Account Lifecycle',
  'idle',
  'kfg-coordinator-guardian-id',
  '{"team": "KnowledgeForge AI", "discipline": "User Management"}'::jsonb,
  '{}'::jsonb,
  NOW(),
  NOW()
),
-- Domain-specific agents (sample - add more as needed)
(
  'kfg-engineer-id',
  '24ff8810-d4cd-4846-99f2-fe82b02d44b4',
  'Engineer',
  'engineer',
  'Knowledge Engineer',
  'Knowledge engineering, documentation systems, and information architecture',
  'active',
  'kfg-coordinator-guardian-id',
  '{"team": "KnowledgeForge AI", "discipline": "Knowledge Engineering"}'::jsonb,
  '{}'::jsonb,
  NOW(),
  NOW()
),
(
  'kfg-electrician-id',
  '24ff8810-d4cd-4846-99f2-fe82b02d44b4',
  'Electrician',
  'engineer',
  'Documentation Electrician',
  'Technical documentation, electrical systems knowledge, and specialized content management',
  'active',
  'kfg-coordinator-guardian-id',
  '{"team": "KnowledgeForge AI", "discipline": "Technical Documentation"}'::jsonb,
  '{}'::jsonb,
  NOW(),
  NOW()
),
(
  'kfg-buyer-id',
  '24ff8810-d4cd-4846-99f2-fe82b02d44b4',
  'Buyer',
  'general',
  'Knowledge Procurement Specialist',
  'Knowledge acquisition, content procurement, and information resource management',
  'active',
  'kfg-coordinator-guardian-id',
  '{"team": "KnowledgeForge AI", "discipline": "Knowledge Procurement"}'::jsonb,
  '{}'::jsonb,
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
-- Coordinator Guardian
(
  'Coordinator Guardian',
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
-- System Management Agents
(
  'AI Manager',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for AI management agent',
  true
),
(
  'Communication Manager',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for communication management agent',
  true
),
(
  'Development Manager',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for development management agent',
  true
),
(
  'Interface Specialist',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for interface management agent',
  true
),
(
  'Operations Coordinator',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for operations coordination agent',
  true
),
(
  'Quality Assurance',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for quality assurance agent',
  true
),
(
  'System Administrator',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for system administration agent',
  true
),
(
  'User Manager',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for user management agent',
  true
),
-- Domain-specific agents
(
  'Engineer',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for knowledge engineering agent',
  true
),
(
  'Electrician',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for technical documentation agent',
  true
),
(
  'Buyer',
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Default model assignment for knowledge procurement agent',
  true
)
ON CONFLICT (agent_id, assignment_type) DO NOTHING;

COMMIT;

-- Verification queries
-- SELECT c.name, COUNT(a.id) as agent_count FROM companies c LEFT JOIN agents a ON c.id = a.company_id WHERE c.name = 'KnowledgeForge AI' GROUP BY c.name;
-- SELECT name, role, title, reports_to FROM agents WHERE company_id = '24ff8810-d4cd-4846-99f2-fe82b02d44b4' ORDER BY name;
