-- ============================================================================
-- VERIFY API KEYS AFTER CLEANUP
-- Run this AFTER executing the cleanup script
-- ============================================================================

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

-- Expected Result: All companies should show "excess_keys: 0"
