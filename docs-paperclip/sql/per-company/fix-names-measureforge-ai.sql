-- ============================================================
-- FIX NAMES FOR: measureforge-ai
-- Company ID: 550e8400-e29b-41d4-a716-446655440013
-- Agents: 21
-- Uses UPDATE to fix name field on existing agents
-- Uses human_name field when available, otherwise name
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'Measurement Validation'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'measurement-validation-specialist'
  AND name IS DISTINCT FROM 'Measurement Validation';

UPDATE agents
SET name = 'Visual Overlay Special'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'visual-overlay-specialist'
  AND name IS DISTINCT FROM 'Visual Overlay Special';

UPDATE agents
SET name = 'Electrical QA'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'measureforge-ai-electrical-qa-specialist'
  AND name IS DISTINCT FROM 'Electrical QA';

UPDATE agents
SET name = 'Sans Standards Special'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'sans-standards-specialist'
  AND name IS DISTINCT FROM 'Sans Standards Special';

UPDATE agents
SET name = 'Asaqs Standards'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'asaqs-standards-specialist'
  AND name IS DISTINCT FROM 'Asaqs Standards';

UPDATE agents
SET name = 'Contract Tender'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'contract-tender-specialist'
  AND name IS DISTINCT FROM 'Contract Tender';

UPDATE agents
SET name = 'Order Generation'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'order-generation-specialist'
  AND name IS DISTINCT FROM 'Order Generation';

UPDATE agents
SET name = 'Electrical Measurement'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'measureforge-ai-electrical-measurement-specialist'
  AND name IS DISTINCT FROM 'Electrical Measurement';

UPDATE agents
SET name = 'Contour Analysis'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'contour-analysis-specialist'
  AND name IS DISTINCT FROM 'Contour Analysis';

UPDATE agents
SET name = 'Mep Element Specialist'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'mep-element-specialist'
  AND name IS DISTINCT FROM 'Mep Element Specialist';

UPDATE agents
SET name = 'Traffic Signal Complia'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'measureforge-ai-traffic-signal-compliance-specialist'
  AND name IS DISTINCT FROM 'Traffic Signal Complia';

UPDATE agents
SET name = 'Traffic Signal Measure'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'measureforge-ai-traffic-signal-measurement-specialist'
  AND name IS DISTINCT FROM 'Traffic Signal Measure';

UPDATE agents
SET name = 'Architectural Element'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'architectural-element-specialist'
  AND name IS DISTINCT FROM 'Architectural Element';

UPDATE agents
SET name = 'Electrical Compliance'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'measureforge-ai-electrical-compliance-specialist'
  AND name IS DISTINCT FROM 'Electrical Compliance';

UPDATE agents
SET name = 'Cost Estimation'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'cost-estimation-specialist'
  AND name IS DISTINCT FROM 'Cost Estimation';

UPDATE agents
SET name = 'Structural Element'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'structural-element-specialist'
  AND name IS DISTINCT FROM 'Structural Element';

UPDATE agents
SET name = 'Quantity Surveyor Spec'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'quantity-surveyor-specialist'
  AND name IS DISTINCT FROM 'Quantity Surveyor Spec';

UPDATE agents
SET name = 'Earthwork Calculation'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'earthwork-calculation-specialist'
  AND name IS DISTINCT FROM 'Earthwork Calculation';

UPDATE agents
SET name = 'Autocad Integration Sp'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'autocad-integration-specialist'
  AND name IS DISTINCT FROM 'Autocad Integration Sp';

UPDATE agents
SET name = 'Measurement Coord'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'measurement-coordination-specialist'
  AND name IS DISTINCT FROM 'Measurement Coord';

UPDATE agents
SET name = 'Cad Measurement'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'cad-measurement-orchestrator'
  AND name IS DISTINCT FROM 'Cad Measurement';

COMMIT;
