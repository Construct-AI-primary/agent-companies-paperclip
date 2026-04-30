-- Fix Orion's ranking to make him the CEO in the org chart view

-- First, check what ranking values indicate CEO status
SELECT DISTINCT authority_level, hierarchy_rank, division_rank
FROM org_chart_hierarchy
WHERE company_name = 'DevForge AI'
ORDER BY hierarchy_rank ASC, authority_level;

-- Check what the current CEO values should be (lowest hierarchy_rank = highest position)
SELECT agent_name, authority_level, hierarchy_rank, division_rank
FROM org_chart_hierarchy
WHERE company_name = 'DevForge AI'
  AND hierarchy_rank = 1;  -- CEO should have rank 1

-- If no one has rank 1, check what the highest authority level is
SELECT DISTINCT authority_level
FROM org_chart_hierarchy
WHERE company_name = 'DevForge AI'
ORDER BY authority_level;

-- Update Orion to be the CEO:
-- Set hierarchy_rank = 1 (highest rank)
-- Set authority_level = 'executive' (highest authority)
UPDATE org_chart_hierarchy
SET
  authority_level = 'executive',
  hierarchy_rank = 1,
  division_rank = 1
WHERE company_name = 'DevForge AI'
  AND agent_name = 'Orion';

-- Ensure no other agent has rank 1 for DevForge AI
UPDATE org_chart_hierarchy
SET hierarchy_rank = hierarchy_rank + 1
WHERE company_name = 'DevForge AI'
  AND agent_name != 'Orion'
  AND hierarchy_rank = 1;

-- Verify the fix
SELECT agent_name, authority_level, hierarchy_rank, division_rank, is_ceo
FROM org_chart_hierarchy
WHERE company_name = 'DevForge AI'
ORDER BY hierarchy_rank ASC, agent_name;

-- Check if Orion now shows as CEO
SELECT agent_name, is_ceo, company_name
FROM org_chart_hierarchy
WHERE company_name = 'DevForge AI'
  AND is_ceo = true;