-- Verify that Orion is properly set as CEO in the agents table
-- This should make the org_chart_hierarchy view show is_ceo = true for Orion

-- Check Orion's role in agents table
SELECT
  a.name,
  a.role,
  c.name as company_name,
  CASE WHEN a.role = 'ceo' THEN 'Should be CEO in view' ELSE 'Not CEO' END as ceo_status
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'DevForge AI'
  AND a.name = 'Orion';

-- Check what the org_chart_hierarchy view shows for Orion now
SELECT
  agent_name,
  is_ceo,
  company_name,
  agent_role
FROM org_chart_hierarchy
WHERE company_name = 'DevForge AI'
  AND agent_name = 'Orion';

-- Check all CEOs in the view
SELECT
  agent_name,
  is_ceo,
  company_name
FROM org_chart_hierarchy
WHERE is_ceo = true
ORDER BY company_name, agent_name;

-- If Orion still doesn't show as CEO, the view logic might be different
-- Let's check if there's a separate CEO designation mechanism