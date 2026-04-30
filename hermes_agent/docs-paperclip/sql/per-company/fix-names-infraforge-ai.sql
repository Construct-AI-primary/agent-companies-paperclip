-- ============================================================
-- FIX NAMES FOR: infraforge-ai
-- Company ID: 09f438a3-4041-46f2-b3cc-96fc9446e666
-- Agents: 7
-- Uses UPDATE to fix name field on existing agents
-- Uses human_name field when available, otherwise name
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'Database Infrastructur'
WHERE company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
  AND title = 'database-infraforge-database-infrastructure'
  AND name IS DISTINCT FROM 'Database Infrastructur';

UPDATE agents
SET name = 'Mobile Api Integration'
WHERE company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
  AND title = 'mobile-api-infraforge-mobile-api-integration'
  AND name IS DISTINCT FROM 'Mobile Api Integration';

UPDATE agents
SET name = 'Nimbus Supabase'
WHERE company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
  AND title = 'infraforge-ai-nimbussupabase'
  AND name IS DISTINCT FROM 'Nimbus Supabase';

UPDATE agents
SET name = 'Render Deployment'
WHERE company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
  AND title = 'render-deployment-specialist'
  AND name IS DISTINCT FROM 'Render Deployment';

UPDATE agents
SET name = 'Supply Chain'
WHERE company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
  AND title = 'supply-chain-integration-infraforge-supply-chain'
  AND name IS DISTINCT FROM 'Supply Chain';

UPDATE agents
SET name = 'Orchestrator'
WHERE company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
  AND title = 'orchestrator-infraforge-ceo'
  AND name IS DISTINCT FROM 'Orchestrator';

UPDATE agents
SET name = 'Postgres'
WHERE company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
  AND title = 'postgres-infraforge'
  AND name IS DISTINCT FROM 'Postgres';

COMMIT;
