-- ============================================================================
-- DIAGNOSE API KEY DATA QUALITY ISSUES
-- Generated: 2026-04-12
-- Purpose: Identify why some companies have more keys than active agents
-- ============================================================================

-- 1. Companies with more keys than active agents
SELECT 
    '=== COMPANIES WITH EXCESS API KEYS ===' as section;

SELECT 
    c.name as company,
    COUNT(DISTINCT a.id) FILTER (WHERE a.is_active = true) as active_agents,
    COUNT(DISTINCT aak.id) FILTER (WHERE aak.revoked_at IS NULL) as active_keys,
    COUNT(DISTINCT aak.id) FILTER (WHERE aak.revoked_at IS NULL) - COUNT(DISTINCT a.id) FILTER (WHERE a.is_active = true) as excess_keys
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.status = 'active'
GROUP BY c.id, c.name
HAVING COUNT(DISTINCT aak.id) FILTER (WHERE aak.revoked_at IS NULL) > COUNT(DISTINCT a.id) FILTER (WHERE a.is_active = true)
ORDER BY excess_keys DESC;

-- 2. Agents with multiple API keys
SELECT 
    '' as spacer,
    '=== AGENTS WITH MULTIPLE API KEYS ===' as section;

SELECT 
    c.name as company,
    a.name as agent_name,
    a.is_active,
    COUNT(aak.id) FILTER (WHERE aak.revoked_at IS NULL) as active_key_count,
    COUNT(aak.id) FILTER (WHERE aak.revoked_at IS NOT NULL) as revoked_key_count
FROM agents a
INNER JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.status = 'active'
GROUP BY c.name, a.name, a.is_active, a.id
HAVING COUNT(aak.id) FILTER (WHERE aak.revoked_at IS NULL) > 1
ORDER BY active_key_count DESC, c.name, a.name;

-- 3. API keys for inactive agents
SELECT 
    '' as spacer,
    '=== API KEYS FOR INACTIVE AGENTS ===' as section;

SELECT 
    c.name as company,
    a.name as agent_name,
    a.is_active,
    COUNT(aak.id) FILTER (WHERE aak.revoked_at IS NULL) as active_keys,
    COUNT(aak.id) FILTER (WHERE aak.revoked_at IS NOT NULL) as revoked_keys
FROM agent_api_keys aak
INNER JOIN agents a ON aak.agent_id = a.id
INNER JOIN companies c ON a.company_id = c.id
WHERE a.is_active = false AND c.status = 'active'
GROUP BY c.name, a.name, a.is_active
ORDER BY c.name, a.name;

-- 4. Orphaned API keys (keys with no matching agent)
SELECT 
    '' as spacer,
    '=== ORPHANED API KEYS (NO MATCHING AGENT) ===' as section;

SELECT 
    aak.id,
    aak.agent_id,
    aak.company_id,
    aak.name,
    aak.created_at,
    aak.revoked_at
FROM agent_api_keys aak
LEFT JOIN agents a ON aak.agent_id = a.id
WHERE a.id IS NULL;

-- 5. Summary statistics by company
SELECT 
    '' as spacer,
    '=== DETAILED STATISTICS BY COMPANY ===' as section;

SELECT 
    c.name as company,
    COUNT(DISTINCT a.id) FILTER (WHERE a.is_active = true) as active_agents,
    COUNT(DISTINCT a.id) FILTER (WHERE a.is_active = false) as inactive_agents,
    COUNT(DISTINCT aak.agent_id) FILTER (WHERE aak.revoked_at IS NULL AND a.is_active = true) as active_agents_with_keys,
    COUNT(DISTINCT aak.id) FILTER (WHERE aak.revoked_at IS NULL) as total_active_keys,
    COUNT(DISTINCT aak.id) FILTER (WHERE aak.revoked_at IS NOT NULL) as total_revoked_keys
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.status = 'active'
GROUP BY c.id, c.name
ORDER BY c.name;
