-- ============================================================================
-- COMPREHENSIVE AGENT & API KEY AUDIT - ALL COMPANIES
-- Generated: 2026-04-12
-- Purpose: Complete status of all companies, agents, and API keys
-- ============================================================================

-- Summary by Company
SELECT 
    '=== SUMMARY BY COMPANY ===' as section;

SELECT 
    c.name as company,
    c.status as company_status,
    COUNT(DISTINCT a.id) as total_agents,
    COUNT(DISTINCT CASE WHEN a.is_active = true THEN a.id END) as active_agents,
    COUNT(DISTINCT aak.id) as total_api_keys,
    COUNT(DISTINCT CASE WHEN a.is_active = true AND aak.id IS NOT NULL THEN a.id END) as active_agents_with_keys,
    COUNT(DISTINCT CASE WHEN a.is_active = true AND aak.id IS NULL THEN a.id END) as active_agents_missing_keys
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.status = 'active'
GROUP BY c.id, c.name, c.status
ORDER BY c.name;

-- Detailed Agent & Key Status by Company
SELECT 
    '' as spacer,
    '=== DETAILED BREAKDOWN ===' as section;

SELECT 
    c.name as company,
    a.name as agent_name,
    a.role as agent_role,
    a.is_active as agent_active,
    CASE WHEN aak.id IS NOT NULL THEN '✓' ELSE '✗' END as has_api_key,
    aak.name as key_name
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.status = 'active'
ORDER BY c.name, a.name;

-- Gap Analysis
SELECT 
    '' as spacer,
    '=== AGENTS WITHOUT API KEYS ===' as section;

SELECT 
    c.name as company,
    a.name as agent_name,
    a.role as agent_role,
    a.is_active as is_active
FROM companies c
INNER JOIN agents a ON c.id = a.company_id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.status = 'active'
  AND a.is_active = true
  AND aak.id IS NULL
ORDER BY c.name, a.name;

-- Total Counts
SELECT 
    '' as spacer,
    '=== OVERALL TOTALS ===' as section;

SELECT 
    COUNT(DISTINCT c.id) as total_active_companies,
    COUNT(DISTINCT a.id) as total_agents,
    COUNT(DISTINCT CASE WHEN a.is_active = true THEN a.id END) as total_active_agents,
    COUNT(DISTINCT aak.id) as total_api_keys,
    COUNT(DISTINCT CASE WHEN a.is_active = true AND aak.id IS NOT NULL THEN a.id END) as active_agents_with_keys,
    COUNT(DISTINCT CASE WHEN a.is_active = true AND aak.id IS NULL THEN a.id END) as active_agents_missing_keys
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.status = 'active';
