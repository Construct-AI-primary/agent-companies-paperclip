-- ============================================================
-- FIX NAMES FOR: saasforge-ai
-- Company ID: 550e8400-e29b-41d4-a716-446655440011
-- Agents: 16
-- Uses UPDATE to fix name field on existing agents
-- Uses human_name field when available, otherwise name
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'Access Controller'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-accesscontroller'
  AND name IS DISTINCT FROM 'Access Controller';

UPDATE agents
SET name = 'Analytics Specialist'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-analyticsspecialist'
  AND name IS DISTINCT FROM 'Analytics Specialist';

UPDATE agents
SET name = 'Client Config Manager'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-clientconfigmanager'
  AND name IS DISTINCT FROM 'Client Config Manager';

UPDATE agents
SET name = 'Data Guardian'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-dataguardian'
  AND name IS DISTINCT FROM 'Data Guardian';

UPDATE agents
SET name = 'Deployment Orchestrato'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-deploymentorchestrato'
  AND name IS DISTINCT FROM 'Deployment Orchestrato';

UPDATE agents
SET name = 'Dev Ops Engineer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-devopsengineer'
  AND name IS DISTINCT FROM 'Dev Ops Engineer';

UPDATE agents
SET name = 'Git Hub Branch Manager'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-githubbranchmanager'
  AND name IS DISTINCT FROM 'Git Hub Branch Manager';

UPDATE agents
SET name = 'Onboard Master'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-onboardmaster'
  AND name IS DISTINCT FROM 'Onboard Master';

UPDATE agents
SET name = 'Onboarding Coordinator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-onboardingcoordinator'
  AND name IS DISTINCT FROM 'Onboarding Coordinator';

UPDATE agents
SET name = 'Platform Architect'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-platformarchitect'
  AND name IS DISTINCT FROM 'Platform Architect';

UPDATE agents
SET name = 'Render Service Manager'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-renderservicemanager'
  AND name IS DISTINCT FROM 'Render Service Manager';

UPDATE agents
SET name = 'Resource Optimizer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-resourceoptimizer'
  AND name IS DISTINCT FROM 'Resource Optimizer';

UPDATE agents
SET name = 'Security Specialist'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-securityspecialist'
  AND name IS DISTINCT FROM 'Security Specialist';

UPDATE agents
SET name = 'Success Manager'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-successmanager'
  AND name IS DISTINCT FROM 'Success Manager';

UPDATE agents
SET name = 'Support Integrator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-supportintegrator'
  AND name IS DISTINCT FROM 'Support Integrator';

UPDATE agents
SET name = 'Tenant Manager'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND title = 'saasforge-ai-tenantmanager'
  AND name IS DISTINCT FROM 'Tenant Manager';

COMMIT;
