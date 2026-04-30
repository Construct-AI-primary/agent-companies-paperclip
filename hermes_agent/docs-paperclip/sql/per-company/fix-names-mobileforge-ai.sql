-- ============================================================
-- FIX NAMES FOR: mobileforge-ai
-- Company ID: 550e8400-e29b-41d4-a716-446655440009
-- Agents: 10
-- Uses UPDATE to fix name field on existing agents
-- Uses human_name field when available, otherwise name
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'API Specialist'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440009'
  AND title = 'mobileforge-ai-apispecialist'
  AND name IS DISTINCT FROM 'API Specialist';

UPDATE agents
SET name = 'App Manager'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440009'
  AND title = 'mobileforge-ai-appmanager'
  AND name IS DISTINCT FROM 'App Manager';

UPDATE agents
SET name = 'Cloud Connector'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440009'
  AND title = 'mobileforge-ai-cloudconnector'
  AND name IS DISTINCT FROM 'Cloud Connector';

UPDATE agents
SET name = 'Device Controller'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440009'
  AND title = 'mobileforge-ai-devicecontroller'
  AND name IS DISTINCT FROM 'Device Controller';

UPDATE agents
SET name = 'Mobile Developer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440009'
  AND title = 'mobileforge-ai-mobiledeveloper'
  AND name IS DISTINCT FROM 'Mobile Developer';

UPDATE agents
SET name = 'Mobile Maestro'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440009'
  AND title = 'mobileforge-ai-mobilemaestro'
  AND name IS DISTINCT FROM 'Mobile Maestro';

UPDATE agents
SET name = 'Performance Optimizer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440009'
  AND title = 'mobileforge-ai-performanceoptimizer'
  AND name IS DISTINCT FROM 'Performance Optimizer';

UPDATE agents
SET name = 'Security Guardian'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440009'
  AND title = 'mobileforge-ai-securityguardian'
  AND name IS DISTINCT FROM 'Security Guardian';

UPDATE agents
SET name = 'Testing Coordinator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440009'
  AND title = 'mobileforge-ai-testingcoordinator'
  AND name IS DISTINCT FROM 'Testing Coordinator';

UPDATE agents
SET name = 'UI UX Specialist'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440009'
  AND title = 'mobileforge-ai-uiuxspecialist'
  AND name IS DISTINCT FROM 'UI UX Specialist';

COMMIT;
