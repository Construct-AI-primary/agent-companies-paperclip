-- Debug the org_chart_hierarchy view to understand how is_ceo is determined

-- Check the view definition (if possible)
-- SELECT * FROM information_schema.views WHERE table_name = 'org_chart_hierarchy';

-- Check what determines is_ceo in the view
-- The view might be using a different logic than agents.role = 'ceo'

-- Let's check if there's a separate CEO designation mechanism
SELECT
  'CEO from agents.role' as source,
  COUNT(*) as count
FROM agents
WHERE company_id = (SELECT id FROM companies WHERE name = 'DevForge AI')
  AND role = 'ceo'

UNION ALL

SELECT
  'CEO from org_chart view' as source,
  COUNT(*) as count
FROM org_chart_hierarchy
WHERE company_name = 'DevForge AI'
  AND is_ceo = true;

-- Check if the view is using a different field or logic
-- Let's see what fields are available in the view
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'org_chart_hierarchy'
ORDER BY ordinal_position;

-- Check if there's a separate ceo_id or similar field in companies table
SELECT
  c.name,
  c.id,
  c.metadata
FROM companies c
WHERE c.name = 'DevForge AI';

-- Alternative: Maybe the view needs to be refreshed or there's a trigger
-- Let's try to understand the view logic by checking if there are any CEO-related fields

-- Check if agents have a separate ceo flag or if it's derived differently
SELECT
  a.name,
  a.role,
  CASE WHEN a.role = 'ceo' THEN true ELSE false END as should_be_ceo,
  och.is_ceo as view_shows_ceo
FROM agents a
LEFT JOIN org_chart_hierarchy och ON och.agent_name = a.name AND och.company_name = (SELECT name FROM companies WHERE id = a.company_id)
WHERE a.company_id = (SELECT id FROM companies WHERE name = 'DevForge AI')
  AND (a.role = 'ceo' OR och.is_ceo = true OR a.name = 'Council - CEO')
ORDER BY a.name;