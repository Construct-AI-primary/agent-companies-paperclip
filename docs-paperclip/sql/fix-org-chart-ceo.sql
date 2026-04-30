-- Fix the org chart CEO designation
-- Based on the hierarchy data, ORION is the actual CEO/root, not Council - CEO
-- Council - CEO reports to Orion, so Orion should be the CEO

-- Set Orion as the CEO (remove ceo role from Council - CEO first)
UPDATE agents
SET role = 'executive'  -- or appropriate role
WHERE name = 'Council - CEO'
  AND company_id = (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1);

-- Set Orion as the CEO
UPDATE agents
SET role = 'ceo'
WHERE name = 'Orion'
  AND company_id = (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1);

-- Verify the changes
SELECT
  a.name,
  a.role,
  c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'DevForge AI'
  AND (a.name IN ('Orion', 'Council - CEO') OR a.role = 'ceo')
ORDER BY a.name;

-- Check the org chart view to see if Orion now shows as CEO
SELECT
  agent_name,
  is_ceo,
  company_name
FROM org_chart_hierarchy
WHERE company_name = 'DevForge AI'
  AND (agent_name IN ('Orion', 'Council - CEO') OR is_ceo = true)
ORDER BY agent_name;