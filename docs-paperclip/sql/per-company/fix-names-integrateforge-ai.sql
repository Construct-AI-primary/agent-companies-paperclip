-- ============================================================
-- FIX NAMES FOR: integrateforge-ai
-- Company ID: 550e8400-e29b-41d4-a716-446655440000
-- Agents: 21
-- Uses UPDATE to fix name field on existing agents
-- Uses human_name field when available, otherwise name
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'Ace Aconex'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-aceaconex'
  AND name IS DISTINCT FROM 'Ace Aconex';

UPDATE agents
SET name = 'Ada Autocad'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-adaautocad'
  AND name IS DISTINCT FROM 'Ada Autocad';

UPDATE agents
SET name = 'Astro Asta'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-astroasta'
  AND name IS DISTINCT FROM 'Astro Asta';

UPDATE agents
SET name = 'Blake Buildsoft'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-blakebuildsoft'
  AND name IS DISTINCT FROM 'Blake Buildsoft';

UPDATE agents
SET name = 'Cash Costx'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-cashcostx'
  AND name IS DISTINCT FROM 'Cash Costx';

UPDATE agents
SET name = 'Coco Candy'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-cococandy'
  AND name IS DISTINCT FROM 'Coco Candy';

UPDATE agents
SET name = 'Corey Procore'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-coreyprocore'
  AND name IS DISTINCT FROM 'Corey Procore';

UPDATE agents
SET name = 'Eli Etabs'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-elietabs'
  AND name IS DISTINCT FROM 'Eli Etabs';

UPDATE agents
SET name = 'Hazel Hecras'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-hazelhecras'
  AND name IS DISTINCT FROM 'Hazel Hecras';

UPDATE agents
SET name = 'Max Msproject'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-maxmsproject'
  AND name IS DISTINCT FROM 'Max Msproject';

UPDATE agents
SET name = 'Nova Navisworks'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-novanavisworks'
  AND name IS DISTINCT FROM 'Nova Navisworks';

UPDATE agents
SET name = 'Phoenix P 6'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-phoenixp6'
  AND name IS DISTINCT FROM 'Phoenix P 6';

UPDATE agents
SET name = 'Pixel Bim 360'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-pixelbim360'
  AND name IS DISTINCT FROM 'Pixel Bim 360';

UPDATE agents
SET name = 'Rex Revit'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-rexrevit'
  AND name IS DISTINCT FROM 'Rex Revit';

UPDATE agents
SET name = 'Sasha Sharepoint'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-sashasharepoint'
  AND name IS DISTINCT FROM 'Sasha Sharepoint';

UPDATE agents
SET name = 'Stan Staad'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-stanstaad'
  AND name IS DISTINCT FROM 'Stan Staad';

UPDATE agents
SET name = 'Storm Swmm'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-stormswmm'
  AND name IS DISTINCT FROM 'Storm Swmm';

UPDATE agents
SET name = 'Terra Civil 3'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-terracivil3d'
  AND name IS DISTINCT FROM 'Terra Civil 3';

UPDATE agents
SET name = 'Trix Trimble'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-trixtrimble'
  AND name IS DISTINCT FROM 'Trix Trimble';

UPDATE agents
SET name = 'Wiley Projectwise'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-wileyprojectwise'
  AND name IS DISTINCT FROM 'Wiley Projectwise';

UPDATE agents
SET name = 'Ziggy Orchestrator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440000'
  AND title = 'integrateforge-ai-ziggyorchestrator'
  AND name IS DISTINCT FROM 'Ziggy Orchestrator';

COMMIT;
