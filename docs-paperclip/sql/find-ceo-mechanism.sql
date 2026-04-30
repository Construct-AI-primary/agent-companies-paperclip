-- Find the actual mechanism that determines CEO status in org_chart_hierarchy view

-- Check if there's a separate CEO table or field
SELECT table_name
FROM information_schema.tables
WHERE table_name LIKE '%ceo%' OR table_name LIKE '%chief%' OR table_name LIKE '%exec%';

-- Check columns in existing tables that might relate to CEO
SELECT table_name, column_name
FROM information_schema.columns
WHERE column_name LIKE '%ceo%' OR column_name LIKE '%chief%' OR column_name LIKE '%exec%'
   OR column_name = 'authority_level' OR column_name = 'hierarchy_rank';

-- Check if companies table has a ceo_agent_id or similar
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'companies'
ORDER BY ordinal_position;

-- Look at the companies table for DevForge AI
SELECT * FROM companies WHERE name = 'DevForge AI';

-- Check if there's a separate leadership or executive table
SELECT table_name
FROM information_schema.tables
WHERE table_name LIKE '%leader%' OR table_name LIKE '%exec%' OR table_name LIKE '%chief%';

-- Alternative: Maybe the view uses a different logic
-- Let's check what the view definition looks like (if accessible)
-- SELECT * FROM information_schema.views WHERE table_name = 'org_chart_hierarchy';

-- Check if authority_level or hierarchy_rank determines CEO
SELECT DISTINCT authority_level, hierarchy_rank
FROM org_chart_hierarchy
WHERE company_name = 'DevForge AI'
ORDER BY hierarchy_rank;

-- Check what Orion's values are
SELECT agent_name, authority_level, hierarchy_rank, division_rank
FROM org_chart_hierarchy
WHERE company_name = 'DevForge AI'
  AND agent_name = 'Orion';