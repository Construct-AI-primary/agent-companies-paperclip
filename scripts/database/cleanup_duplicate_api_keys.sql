-- ============================================================================
-- CLEANUP DUPLICATE API KEYS
-- Generated: 2026-04-12
-- Purpose: Revoke duplicate API keys, keeping only the oldest per agent
-- ============================================================================
-- 
-- PROBLEM: Some agents have multiple active API keys
-- SOLUTION: Keep the oldest API key per agent, revoke all others
-- 
-- Affected Companies:
-- - PaperclipForge AI: 43 excess keys
-- - PromptForge AI: 26 excess keys
-- - DevForge AI: 2 excess keys
-- ============================================================================

-- Step 1: Preview which keys will be revoked
SELECT 
    '=== KEYS TO BE REVOKED (PREVIEW) ===' as section;

WITH ranked_keys AS (
    SELECT 
        aak.id,
        aak.agent_id,
        a.name as agent_name,
        c.name as company_name,
        aak.created_at,
        aak.name as key_name,
        ROW_NUMBER() OVER (PARTITION BY aak.agent_id ORDER BY aak.created_at ASC) as key_rank
    FROM agent_api_keys aak
    INNER JOIN agents a ON aak.agent_id = a.id
    INNER JOIN companies c ON a.company_id = c.id
    WHERE aak.revoked_at IS NULL
      AND a.is_active = true
)
SELECT 
    company_name,
    agent_name,
    key_name,
    created_at,
    key_rank,
    CASE WHEN key_rank = 1 THEN '✓ KEEP' ELSE '✗ REVOKE' END as action
FROM ranked_keys
WHERE key_rank > 1  -- Only show duplicates
ORDER BY company_name, agent_name, key_rank;

-- Step 2: Count how many keys will be revoked by company
SELECT 
    '' as spacer,
    '=== REVOCATION COUNT BY COMPANY ===' as section;

WITH ranked_keys AS (
    SELECT 
        aak.id,
        aak.agent_id,
        c.name as company_name,
        ROW_NUMBER() OVER (PARTITION BY aak.agent_id ORDER BY aak.created_at ASC) as key_rank
    FROM agent_api_keys aak
    INNER JOIN agents a ON aak.agent_id = a.id
    INNER JOIN companies c ON a.company_id = c.id
    WHERE aak.revoked_at IS NULL
      AND a.is_active = true
)
SELECT 
    company_name,
    COUNT(*) as keys_to_revoke
FROM ranked_keys
WHERE key_rank > 1
GROUP BY company_name
ORDER BY keys_to_revoke DESC;

-- Step 3: Execute the cleanup (UNCOMMENT TO RUN)
-- WARNING: This will revoke duplicate API keys. Review the preview first!

/*
UPDATE agent_api_keys aak
SET revoked_at = NOW()
FROM (
    SELECT 
        id,
        ROW_NUMBER() OVER (PARTITION BY agent_id ORDER BY created_at ASC) as key_rank
    FROM agent_api_keys
    WHERE revoked_at IS NULL
) ranked
WHERE aak.id = ranked.id
  AND ranked.key_rank > 1;
*/

-- Step 4: Verification after cleanup (UNCOMMENT TO RUN AFTER CLEANUP)

/*
SELECT 
    '=== VERIFICATION AFTER CLEANUP ===' as section;

SELECT 
    c.name as company,
    COUNT(DISTINCT a.id) as active_agents,
    COUNT(DISTINCT aak.id) FILTER (WHERE aak.revoked_at IS NULL) as active_keys,
    COUNT(DISTINCT aak.id) FILTER (WHERE aak.revoked_at IS NOT NULL) as revoked_keys,
    COUNT(DISTINCT a.id) - COUNT(DISTINCT aak.id) FILTER (WHERE aak.revoked_at IS NULL) as excess_keys
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.status = 'active' AND a.is_active = true
GROUP BY c.id, c.name
ORDER BY excess_keys DESC, c.name;
*/

-- ============================================================================
-- EXECUTION INSTRUCTIONS
-- ============================================================================
-- 
-- 1. Run Step 1 & 2 first to preview what will be revoked
-- 2. Review the preview carefully
-- 3. If happy with preview, UNCOMMENT Step 3 and execute
-- 4. After Step 3 completes, UNCOMMENT Step 4 to verify results
-- 
-- Expected Result:
-- - All companies should have "excess_keys: 0"
-- - Each active agent should have exactly 1 active API key
-- - Older keys remain active, newer duplicates are revoked
-- ============================================================================
