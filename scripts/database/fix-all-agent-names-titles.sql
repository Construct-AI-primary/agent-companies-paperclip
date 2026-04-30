-- ==========================================
-- Universal Agent Name & Title Fix Script
-- ALL COMPANIES - ALL 56 Agents
-- Date: 2026-04-23
-- ==========================================
-- PURPOSE: Fix all malformed agent names and titles across all companies
--
-- This script uses pattern-based fixes to handle all agents systematically:
-- 1. Remove company prefixes from agent names
-- 2. Convert spaces to hyphens in names
-- 3. Preserve appropriate titles
-- 4. Handle special cases individually
--
-- Rules from schema guidelines:
-- - name field: Only agent's personal/character name, no company references
-- - title field: Job title/role description
-- - name should not contain spaces (use single words or hyphenated)
-- ==========================================

-- ==========================================
-- STEP 1: Pattern-based fixes for common naming issues
-- ==========================================

-- Fix agents with "company-ai-" prefix (e.g., "devforge-ai-market-analyst" → "Market-Analyst")
UPDATE agents
SET name = REGEXP_REPLACE(
    REGEXP_REPLACE(name, '^[a-z]+-ai-', '', 'i'),
    '[- ]',
    '-',
    'g'
)
WHERE name ~ '^[a-z]+-ai-'
  AND name NOT LIKE '% %'; -- Skip if already has spaces (handled separately)

-- Fix agents with "company ai " prefix (e.g., "devforge ai market analyst" → "Market-Analyst")
UPDATE agents
SET name = REGEXP_REPLACE(
    REGEXP_REPLACE(name, '^[a-z]+ ai ', '', 'i'),
    '[ ]',
    '-',
    'g'
)
WHERE name ~ '^[a-z]+ ai '
  AND name LIKE '% %'; -- Only process those with spaces

-- Fix agents with just "company-" prefix (e.g., "devforge-market-analyst" → "Market-Analyst")
UPDATE agents
SET name = REGEXP_REPLACE(
    REGEXP_REPLACE(name, '^[a-z]+-', '', 'i'),
    '[- ]',
    '-',
    'g'
)
WHERE name ~ '^[a-z]+-[a-z]'
  AND name NOT LIKE '%ai%'
  AND LENGTH(REGEXP_REPLACE(name, '^[a-z]+-', '', 'i')) > 0;

-- ==========================================
-- STEP 2: Handle special cases and known agent names
-- ==========================================

-- PaperclipForge AI agents (already handled in previous script, but ensure they're correct)
UPDATE agents SET name = 'Andy', title = 'Quality Controller' WHERE name = 'andy' AND company_id = '550e8400-e29b-41d4-a716-446655440014';
UPDATE agents SET name = 'Maya', title = 'Chief Operations Officer' WHERE name = 'maya' AND company_id = '550e8400-e29b-41d4-a716-446655440014';
UPDATE agents SET name = 'Charlie', title = 'Coordination Charlie' WHERE name = 'charlie' AND company_id = '550e8400-e29b-41d4-a716-446655440014';
UPDATE agents SET name = 'Uma', title = 'UI Uma' WHERE name = 'uma' AND company_id = '550e8400-e29b-41d4-a716-446655440014';

-- Engineering variants
UPDATE agents SET name = 'Andy', title = 'Analysis Andy' WHERE name = 'engineering-analysis-andy-001' AND company_id = '550e8400-e29b-41d4-a716-446655440014';
UPDATE agents SET name = 'Charlie', title = 'Coordination Charlie' WHERE name = 'engineering-coord-charlie-001' AND company_id = '550e8400-e29b-41d4-a716-446655440014';
UPDATE agents SET name = 'Uma', title = 'UI Specialist Uma' WHERE name = 'engineering-ui-uma-001' AND company_id = '550e8400-e29b-41d4-a716-446655440014';

-- ==========================================
-- STEP 3: Clean up any remaining issues
-- ==========================================

-- Remove any double hyphens
UPDATE agents SET name = REGEXP_REPLACE(name, '--+', '-', 'g') WHERE name LIKE '%--%';

-- Trim leading/trailing hyphens
UPDATE agents SET name = REGEXP_REPLACE(name, '^-+', '', 'g') WHERE name LIKE '-%';
UPDATE agents SET name = REGEXP_REPLACE(name, '-+$', '', 'g') WHERE name LIKE '%-';

-- Convert any remaining spaces to hyphens
UPDATE agents SET name = REGEXP_REPLACE(name, '[ ]', '-', 'g') WHERE name LIKE '% %';

-- Remove duplicate "Specialist" occurrences in names
UPDATE agents SET name = REGEXP_REPLACE(name, '-Specialist-Specialist', '-Specialist', 'g') WHERE name LIKE '%-Specialist-Specialist%';
UPDATE agents SET name = REGEXP_REPLACE(name, 'Specialist-Specialist-', 'Specialist-', 'g') WHERE name LIKE 'Specialist-Specialist-%';
UPDATE agents SET name = REGEXP_REPLACE(name, 'Specialist-Specialist', 'Specialist', 'g') WHERE name = 'Specialist-Specialist';

-- ==========================================
-- STEP 4: Fix remaining issues
-- ==========================================

-- Fix NULL titles (add appropriate titles based on agent names)
UPDATE agents SET title = 'Executive Assistant' WHERE name = 'Reagan' AND title IS NULL;

-- Convert agent names to sentence case (first letter of each word capitalized, rest lowercase)
UPDATE agents
SET name = INITCAP(REPLACE(name, '-', ' '))
WHERE name IS NOT NULL
  AND name != INITCAP(REPLACE(name, '-', ' '))
  AND name LIKE '%-%'; -- Only process hyphenated names

-- Convert non-hyphenated agent names to sentence case (first letter capitalized, rest lowercase)
UPDATE agents
SET name = UPPER(LEFT(name, 1)) || LOWER(SUBSTRING(name, 2))
WHERE name IS NOT NULL
  AND name != UPPER(LEFT(name, 1)) || LOWER(SUBSTRING(name, 2))
  AND name NOT LIKE '%-%'; -- Skip hyphenated names (already handled above)

-- Capitalize first letter of each word in titles (optional improvement)
UPDATE agents
SET title = INITCAP(REGEXP_REPLACE(title, '-', ' ', 'g'))
WHERE title IS NOT NULL
  AND title != INITCAP(REGEXP_REPLACE(title, '-', ' ', 'g'));

-- ==========================================
-- VERIFICATION: Check compliance with schema rules
-- ==========================================

SELECT '=== AGENT NAME & TITLE COMPLIANCE REPORT ===' as status;

-- Check for spaces in agent names (should be 0)
SELECT '=== Checking for invalid agent names (spaces) ===' as validation;
SELECT name, company_id, 'CONTAINS SPACES - FIX REQUIRED' as issue
FROM agents
WHERE name LIKE '% %'
ORDER BY company_id, name;

-- Check for company prefixes in names (should be 0)
SELECT '=== Checking for company prefixes in names ===' as validation;
SELECT name, company_id, 'CONTAINS COMPANY PREFIX - FIX REQUIRED' as issue
FROM agents
WHERE (name ~* '^(dev|infra|quality|knowledge|content|domain|integrate|voice|measure|paperclip|exec|saas|mobile|prompt|learning|loopy)-' OR
       name ~* '^(dev|infra|quality|knowledge|content|domain|integrate|voice|measure|paperclip|exec|saas|mobile|prompt|learning|loopy) ai ')
ORDER BY company_id, name;

-- Check for NULL titles (should be 0)
SELECT '=== Checking for NULL titles ===' as validation;
SELECT name, company_id, 'NULL TITLE - REVIEW REQUIRED' as issue
FROM agents
WHERE title IS NULL
ORDER BY company_id, name;

-- ==========================================
-- SUMMARY: Final compliance status
-- ==========================================

SELECT '=== FINAL COMPLIANCE SUMMARY ===' as summary;
SELECT
  COUNT(*) as total_agents,
  SUM(CASE WHEN name LIKE '% %' THEN 1 ELSE 0 END) as names_with_spaces,
  SUM(CASE WHEN name ~* '^(dev|infra|quality|knowledge|content|domain|integrate|voice|measure|paperclip|exec|saas|mobile|prompt|learning|loopy)' THEN 1 ELSE 0 END) as names_with_company_prefix,
  SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) as null_titles,
  ROUND(
    (COUNT(*) -
     SUM(CASE WHEN name LIKE '% %' THEN 1 ELSE 0 END) -
     SUM(CASE WHEN name ~* '^(dev|infra|quality|knowledge|content|domain|integrate|voice|measure|paperclip|exec|saas|mobile|prompt|learning|loopy)' THEN 1 ELSE 0 END) -
     SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END)
    )::numeric / COUNT(*)::numeric * 100, 1
  ) as compliance_percentage
FROM agents;

-- ==========================================
-- SAMPLE: Show 10 random agents to verify fixes
-- ==========================================

SELECT '=== SAMPLE OF FIXED AGENTS ===' as sample;
SELECT name, title, company_id
FROM agents
ORDER BY RANDOM()
LIMIT 10;

-- ==========================================
-- END OF SCRIPT
-- ==========================================