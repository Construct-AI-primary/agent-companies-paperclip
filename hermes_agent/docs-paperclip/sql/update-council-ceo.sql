-- Update Council - CEO to have role = 'ceo' in agents table
-- Since org_chart_hierarchy is a view, we need to update the underlying agents table
-- This should fix the empty org chart issue

-- First, find the DevForge AI company ID
-- Update the agent with name 'Council - CEO' to have role 'ceo'
UPDATE agents
SET role = 'ceo'
WHERE name = 'Council - CEO'
  AND company_id = (
    SELECT id FROM companies
    WHERE name = 'DevForge AI'
    LIMIT 1
  );

-- Alternative: If the agent name is slightly different, update by pattern
-- Uncomment if the exact name doesn't match:
-- UPDATE agents
-- SET role = 'ceo'
-- WHERE name LIKE '%Council%'
--   AND name LIKE '%CEO%'
--   AND company_id = (
--     SELECT id FROM companies
--     WHERE name = 'DevForge AI'
--     LIMIT 1
--   );

-- Verify the update by checking the org_chart_hierarchy view
SELECT
  agent_name,
  is_ceo,
  company_name
FROM org_chart_hierarchy
WHERE agent_name LIKE '%Council%'
   OR agent_name LIKE '%CEO%'
   OR is_ceo = true
ORDER BY company_name, agent_name;

-- Also check the agents table directly
SELECT
  a.name,
  a.role,
  c.name as company_name,
  a.status
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.name LIKE '%Council%'
   OR a.name LIKE '%CEO%'
   OR a.role = 'ceo'
ORDER BY c.name, a.name;
