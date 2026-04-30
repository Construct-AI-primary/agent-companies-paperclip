-- ============================================================
-- FIX NAMES FOR: contentforge-ai
-- Company ID: 550e8400-e29b-41d4-a716-446655440008
-- Agents: 17
-- Uses UPDATE to fix name field on existing agents
-- Uses human_name field when available, otherwise name
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'Blog Architect'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-blogarchitect'
  AND name IS DISTINCT FROM 'Blog Architect';

UPDATE agents
SET name = 'Communication Orchestr'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-communicationorchestr'
  AND name IS DISTINCT FROM 'Communication Orchestr';

UPDATE agents
SET name = 'Content Maestro'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-contentmaestro'
  AND name IS DISTINCT FROM 'Content Maestro';

UPDATE agents
SET name = 'Conversion Analyst'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-conversionanalyst'
  AND name IS DISTINCT FROM 'Conversion Analyst';

UPDATE agents
SET name = 'Conversion Specialist'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-conversionspecialist'
  AND name IS DISTINCT FROM 'Conversion Specialist';

UPDATE agents
SET name = 'Data Analyst'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-dataanalyst'
  AND name IS DISTINCT FROM 'Data Analyst';

UPDATE agents
SET name = 'Email Composer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-emailcomposer'
  AND name IS DISTINCT FROM 'Email Composer';

UPDATE agents
SET name = 'Link Builder'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-linkbuilder'
  AND name IS DISTINCT FROM 'Link Builder';

UPDATE agents
SET name = 'Local SEO Expert'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-localseoexpert'
  AND name IS DISTINCT FROM 'Local SEO Expert';

UPDATE agents
SET name = 'Mobile Optimizer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-mobileoptimizer'
  AND name IS DISTINCT FROM 'Mobile Optimizer';

UPDATE agents
SET name = 'Performance Optimizer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-performanceoptimizer'
  AND name IS DISTINCT FROM 'Performance Optimizer';

UPDATE agents
SET name = 'Reporting Specialist'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-reportingspecialist'
  AND name IS DISTINCT FROM 'Reporting Specialist';

UPDATE agents
SET name = 'SEO Analyst'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-seoanalyst'
  AND name IS DISTINCT FROM 'SEO Analyst';

UPDATE agents
SET name = 'SEO Strategist'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-seostrategist'
  AND name IS DISTINCT FROM 'SEO Strategist';

UPDATE agents
SET name = 'Social Strategist'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-socialstrategist'
  AND name IS DISTINCT FROM 'Social Strategist';

UPDATE agents
SET name = 'Technical SEO'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-technicalseo'
  AND name IS DISTINCT FROM 'Technical SEO';

UPDATE agents
SET name = 'UX Designer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440008'
  AND title = 'contentforge-ai-uxdesigner'
  AND name IS DISTINCT FROM 'UX Designer';

COMMIT;
