-- Check the actual definition of the org_chart_hierarchy view
-- This will show us how is_ceo is computed

-- Try to get the view definition
SELECT * FROM information_schema.views WHERE table_name = 'org_chart_hierarchy';

-- If that doesn't work, try PostgreSQL specific syntax
SELECT pg_get_viewdef('org_chart_hierarchy'::regclass, true);

-- Alternative: Check if org_chart_hierarchy is actually a table, not a view
-- The error might be misleading
SELECT
    schemaname,
    tablename,
    tableowner,
    tablespace,
    hasindexes,
    hasrules,
    hastriggers,
    rowsecurity
FROM pg_tables
WHERE tablename = 'org_chart_hierarchy';

-- Check if it's a view
SELECT
    schemaname,
    viewname,
    viewowner,
    definition
FROM pg_views
WHERE viewname = 'org_chart_hierarchy';

-- If it's a view, maybe we can find the underlying table by looking at the definition
-- Let's try to understand what tables are joined in the view

-- Check if there's a way to update through the view
-- Some databases allow updates on simple views
-- Let's try a simple update to see if it works
-- UPDATE org_chart_hierarchy SET is_ceo = true WHERE agent_name = 'Orion' AND company_name = 'DevForge AI';