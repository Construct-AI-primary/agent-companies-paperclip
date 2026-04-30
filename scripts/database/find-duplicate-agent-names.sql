-- ============================================================
-- Find Duplicate Agent Names
-- Created: 2026-04-22
-- Purpose: Identify all duplicate agent names blocking unique constraint
-- Updated: 2026-04-23 - Added PaperclipForge AI specific queries
-- ============================================================

-- 1. Find exact duplicate names (same name, same company)
SELECT 'SAME COMPANY DUPLICATES:' as check_type;
SELECT name, company_id, COUNT(*) as cnt, 
  array_agg(id) as agent_ids
FROM agents
GROUP BY name, company_id
HAVING COUNT(*) > 1
ORDER BY name;

-- 2. Find same name across different companies
SELECT 'CROSS-COMPANY DUPLICATES:' as check_type;
SELECT name, COUNT(DISTINCT company_id) as company_count,
  array_agg(DISTINCT company_id) as company_ids,
  array_agg(id) as agent_ids
FROM agents
GROUP BY name
HAVING COUNT(DISTINCT company_id) > 1
ORDER BY name;

-- 3. Show all agents with duplicate names (full details)
SELECT 'FULL DETAILS OF DUPLICATES:' as check_type;
SELECT a.id, a.name, a.role, a.title, a.status, 
  c.name as company_name, a.created_at, a.updated_at
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.name IN (
  SELECT name FROM agents 
  GROUP BY name 
  HAVING COUNT(*) > 1
)
ORDER BY a.name, c.name;

-- 4. PAPERCLIPFORGE AI SPECIFIC DUPLICATES
SELECT 'PAPERCLIPFORGE AI DUPLICATES:' as check_type;
SELECT name, COUNT(*) as cnt, array_agg(id) as agent_ids
FROM agents
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY name;

-- 5. PAPERCLIPFORGE AI AGENTS WITH DUPLICATE NAMES ACROSS COMPANIES
SELECT 'PAPERCLIPFORGE AI CROSS-COMPANY DUPLICATES:' as check_type;
SELECT a.name, COUNT(DISTINCT a.company_id) as company_count,
  array_agg(DISTINCT c.name) as company_names,
  array_agg(a.id) as agent_ids
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.name IN (
  SELECT name FROM agents
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
)
GROUP BY a.name
HAVING COUNT(DISTINCT a.company_id) > 1
ORDER BY a.name;

-- 6. PAPERCLIPFORGE AI DUPLICATE DETAILS
SELECT 'PAPERCLIPFORGE AI DUPLICATE DETAILS:' as check_type;
SELECT a.id, a.name, a.role, a.title, a.status,
  c.name as company_name, a.created_at, a.updated_at
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND a.name IN (
    SELECT name FROM agents
    WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
    GROUP BY name
    HAVING COUNT(*) > 1
  )
ORDER BY a.name, a.id;

-- 7. PAPERCLIPFORGE AI DUPLICATE SUMMARY
SELECT 'PAPERCLIPFORGE AI SUMMARY:' as check_type;
SELECT
  (SELECT COUNT(*) FROM (
    SELECT name FROM agents
    WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
    GROUP BY name HAVING COUNT(*) > 1
  ) AS dup_names) as paperclipforge_duplicate_names,
  (SELECT COUNT(*) FROM agents
   WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
     AND name IN (
       SELECT name FROM agents
       WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
       GROUP BY name HAVING COUNT(*) > 1
     )) as paperclipforge_agents_with_duplicates;

-- 8. Count total duplicates (ALL COMPANIES)
SELECT 'GLOBAL SUMMARY:' as check_type;
SELECT
  (SELECT COUNT(*) FROM (
    SELECT name FROM agents
    GROUP BY name HAVING COUNT(*) > 1
  ) AS dup_names) as duplicate_names,
  (SELECT COUNT(*) FROM agents
   WHERE name IN (
     SELECT name FROM agents
     GROUP BY name HAVING COUNT(*) > 1
   )) as total_agents_with_duplicates;
