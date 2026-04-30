-- ============================================================
-- Phase 1: Database Audit & Cleanup
-- Date: 2026-04-22
-- Purpose: Identify duplicate agents, missing agents, and naming issues
-- Companies: PaperclipForge AI + MeasureForge AI
-- ============================================================

-- ============================================================
-- STEP 1: Find all duplicate agent names (same name + same company)
-- ============================================================
SELECT '=== DUPLICATE AGENT NAMES (same name + same company) ===' as audit_section;

SELECT name, company_id, COUNT(*) as duplicate_count
FROM agents
GROUP BY name, company_id
HAVING COUNT(*) > 1
ORDER BY name, company_id;

-- ============================================================
-- STEP 2: Find agents with same name across different companies
-- ============================================================
SELECT '=== CROSS-COMPANY NAME CONFLICTS ===' as audit_section;

SELECT name, COUNT(DISTINCT company_id) as company_count, array_agg(DISTINCT company_id) as company_ids
FROM agents
GROUP BY name
HAVING COUNT(DISTINCT company_id) > 1
ORDER BY name;

-- ============================================================
-- STEP 3: List ALL PaperclipForge AI agents
-- ============================================================
SELECT '=== PAPERCLIPFORGE AI - ALL AGENTS ===' as audit_section;

SELECT a.id, a.name, a.role, a.title, a.status, c.name as company_name, a.created_at, a.updated_at
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'PaperclipForge AI'
ORDER BY a.name;

-- ============================================================
-- STEP 4: List ALL MeasureForge AI agents
-- ============================================================
SELECT '=== MEASUREFORGE AI - ALL AGENTS ===' as audit_section;

SELECT a.id, a.name, a.role, a.title, a.status, c.name as company_name, a.created_at, a.updated_at
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'MeasureForge AI'
ORDER BY a.name;

-- ============================================================
-- STEP 5: Count agents per company
-- ============================================================
SELECT '=== AGENT COUNTS PER COMPANY ===' as audit_section;

SELECT c.name as company_name, COUNT(a.id) as agent_count
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
GROUP BY c.name
ORDER BY agent_count DESC;

-- ============================================================
-- STEP 6: Find agents with non-standard names (not human-name-company pattern)
-- ============================================================
SELECT '=== AGENTS WITH NON-STANDARD NAMES (technical slugs) ===' as audit_section;

SELECT a.id, a.name, a.title, c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name IN ('PaperclipForge AI', 'MeasureForge AI')
  AND (a.name LIKE '%-%-ai-%' OR a.name LIKE '%the-%' OR a.name LIKE '%-specialist' OR a.name LIKE '%-coordinator')
ORDER BY c.name, a.name;

-- ============================================================
-- STEP 7: Find agents with empty or null names
-- ============================================================
SELECT '=== AGENTS WITH EMPTY/NULL NAMES ===' as audit_section;

SELECT a.id, a.name, a.title, c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.name IS NULL OR a.name = ''
ORDER BY c.name;

-- ============================================================
-- STEP 8: Check company existence
-- ============================================================
SELECT '=== COMPANY EXISTENCE CHECK ===' as audit_section;

SELECT id, name, created_at
FROM companies
WHERE name IN ('PaperclipForge AI', 'MeasureForge AI')
ORDER BY name;