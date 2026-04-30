-- Fix the org chart by directly updating the org_chart_hierarchy table
-- Set Orion as CEO (is_ceo = true) in the org chart table

-- First, check current CEO status
SELECT agent_name, is_ceo, company_name
FROM org_chart_hierarchy
WHERE company_name = 'DevForge AI'
  AND (is_ceo = true OR agent_name = 'Orion')
ORDER BY agent_name;

-- Set Orion as the CEO
UPDATE org_chart_hierarchy
SET is_ceo = true
WHERE company_name = 'DevForge AI'
  AND agent_name = 'Orion';

-- Ensure no other agents are marked as CEO for DevForge AI
UPDATE org_chart_hierarchy
SET is_ceo = false
WHERE company_name = 'DevForge AI'
  AND agent_name != 'Orion';

-- Verify the fix
SELECT agent_name, is_ceo, company_name, agent_role, authority_level
FROM org_chart_hierarchy
WHERE company_name = 'DevForge AI'
ORDER BY is_ceo DESC, agent_name;

-- Also check that Orion has the correct role in agents table
SELECT a.name, a.role, c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'DevForge AI'
  AND a.name = 'Orion';