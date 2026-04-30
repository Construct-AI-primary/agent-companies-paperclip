-- Find the underlying table that stores the hierarchy information
-- The org_chart_hierarchy view is based on this table

-- Look for tables that might contain hierarchy/ranking information
SELECT table_name
FROM information_schema.tables
WHERE table_name LIKE '%hierarchy%' OR table_name LIKE '%org%' OR table_name LIKE '%chart%'
   OR table_name LIKE '%rank%' OR table_name LIKE '%level%';

-- Check if there's a separate table for agent hierarchy/organization
SELECT table_name
FROM information_schema.columns
WHERE column_name IN ('authority_level', 'hierarchy_rank', 'division_rank')
GROUP BY table_name;

-- Look for tables with agent_id and company_id that might store hierarchy
SELECT table_name, column_name
FROM information_schema.columns
WHERE column_name IN ('agent_id', 'company_id', 'authority_level', 'hierarchy_rank')
ORDER BY table_name, column_name;

-- Check if the hierarchy data is stored in a separate table
-- Look for tables that have both agent references and ranking columns
SELECT DISTINCT table_name
FROM information_schema.columns
WHERE table_name IN (
    SELECT table_name
    FROM information_schema.columns
    WHERE column_name = 'agent_id'
)
AND column_name IN ('authority_level', 'hierarchy_rank', 'division_rank');

-- If it's in a separate table, let's see what it looks like
-- This might be the table we need to update directly