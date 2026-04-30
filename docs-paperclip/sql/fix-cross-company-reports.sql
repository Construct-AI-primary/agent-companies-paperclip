-- Fix cross-company reporting relationships for DevForge AI
-- Ensure all DevForge agents only report to other DevForge agents or null (CEO)

-- First, identify any DevForge agents reporting to agents in other companies
UPDATE agents
SET reports_to = NULL
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND reports_to IS NOT NULL
  AND reports_to NOT IN (
    SELECT id FROM agents WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  );

-- Set up a simple hierarchy for DevForge AI
-- Orion (CEO) - no reports_to
UPDATE agents SET reports_to = NULL WHERE id = 'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5';

-- Key department leads report directly to Orion
UPDATE agents SET reports_to = 'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5' WHERE id IN (
  '77369297-a61e-4de0-a6fb-fd3ef12dda5a', -- Auditor
  '11afbdd2-2c17-4dbb-8c0d-6224ca4a2756', -- Archivist
  '167acf8b-fe71-4eed-a3ac-7253d9c7e496'  -- Analyst
);

-- All other DevForge agents report to one of the department leads or Orion
-- This creates a basic hierarchy without cross-company references
