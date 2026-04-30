-- ============================================================
-- FIX NAMES FOR: execforge-ai
-- Company ID: 550e8400-e29b-41d4-a716-446655440010
-- Agents: 18
-- Uses UPDATE to fix name field on existing agents
-- Uses human_name field when available, otherwise name
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'Automation Engineer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-automationengineer'
  AND name IS DISTINCT FROM 'Automation Engineer';

UPDATE agents
SET name = 'Chief of Staff'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-chiefofstaff'
  AND name IS DISTINCT FROM 'Chief of Staff';

UPDATE agents
SET name = 'Communications Manager'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-communicationsmanager'
  AND name IS DISTINCT FROM 'Communications Manager';

UPDATE agents
SET name = 'Data Manager'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-datamanager'
  AND name IS DISTINCT FROM 'Data Manager';

UPDATE agents
SET name = 'Intelligence Analyst'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-intelligenceanalyst'
  AND name IS DISTINCT FROM 'Intelligence Analyst';

UPDATE agents
SET name = 'Knowledge Curator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-knowledgecurator'
  AND name IS DISTINCT FROM 'Knowledge Curator';

UPDATE agents
SET name = 'Maya Loopy Content Str'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'maya-loopy-content-strategist'
  AND name IS DISTINCT FROM 'Maya Loopy Content Str';

UPDATE agents
SET name = 'Performance Analyst'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-performanceanalyst'
  AND name IS DISTINCT FROM 'Performance Analyst';

UPDATE agents
SET name = 'Personal Assistant'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-personalassistant'
  AND name IS DISTINCT FROM 'Personal Assistant';

UPDATE agents
SET name = 'Presentation Specialis'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-presentationspecialis'
  AND name IS DISTINCT FROM 'Presentation Specialis';

UPDATE agents
SET name = 'Research Assistant'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-researchassistant'
  AND name IS DISTINCT FROM 'Research Assistant';

UPDATE agents
SET name = 'Scheduler'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-scheduler'
  AND name IS DISTINCT FROM 'Scheduler';

UPDATE agents
SET name = 'Security Specialist'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-securityspecialist'
  AND name IS DISTINCT FROM 'Security Specialist';

UPDATE agents
SET name = 'Strategic Advisor'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-strategicadvisor'
  AND name IS DISTINCT FROM 'Strategic Advisor';

UPDATE agents
SET name = 'Systems Integrator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-systemsintegrator'
  AND name IS DISTINCT FROM 'Systems Integrator';

UPDATE agents
SET name = 'Task Coordinator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-taskcoordinator'
  AND name IS DISTINCT FROM 'Task Coordinator';

UPDATE agents
SET name = 'Vision Loopy Ceo'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'vision-loopy-ceo'
  AND name IS DISTINCT FROM 'Vision Loopy Ceo';

UPDATE agents
SET name = 'Workflow Optimizer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440010'
  AND title = 'execforge-ai-workflowoptimizer'
  AND name IS DISTINCT FROM 'Workflow Optimizer';

COMMIT;
