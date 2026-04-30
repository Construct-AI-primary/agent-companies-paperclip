-- ============================================================================
-- VERIFY AUTORESEARCH AGENTS REMOVAL STATUS
-- Generated: 2026-04-12
-- Purpose: Verify AutoResearch agents deactivation and API key revocation
-- ============================================================================

-- Check 1: Count active vs inactive AutoResearch agents
SELECT 
    'Active AutoResearch Agents' as check_type,
    COUNT(*) as count
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Learning Forge AI'
  AND a.is_active = true
  AND a.name LIKE '%AutoResearch%'

UNION ALL

SELECT 
    'Inactive AutoResearch Agents' as check_type,
    COUNT(*) as count
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Learning Forge AI'
  AND a.is_active = false
  AND a.name LIKE '%AutoResearch%'

UNION ALL

SELECT 
    'Total AutoResearch Agents' as check_type,
    COUNT(*) as count
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Learning Forge AI'
  AND a.name LIKE '%AutoResearch%';

-- Check 2: Detailed status of each AutoResearch agent
SELECT 
    a.name as agent_name,
    a.is_active,
    a.updated_at as last_updated,
    CASE 
        WHEN aak.revoked_at IS NULL AND aak.id IS NOT NULL THEN '✓ Active API Key'
        WHEN aak.revoked_at IS NOT NULL THEN '✗ Revoked API Key'
        ELSE '✗ No API Key'
    END as api_key_status,
    aak.revoked_at
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.name = 'Learning Forge AI'
  AND a.name IN (
    'AutoResearch Skills Enhancer',
    'AutoResearch Literature Scanner',
    'AutoResearch Gap Analyzer'
  )
ORDER BY a.name;

-- Check 3: API Keys status summary
SELECT 
    'Active API Keys for AutoResearch Agents' as check_type,
    COUNT(*) as count
FROM agent_api_keys aak
JOIN agents a ON aak.agent_id = a.id
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Learning Forge AI'
  AND a.name LIKE '%AutoResearch%'
  AND aak.revoked_at IS NULL

UNION ALL

SELECT 
    'Revoked API Keys for AutoResearch Agents' as check_type,
    COUNT(*) as count
FROM agent_api_keys aak
JOIN agents a ON aak.agent_id = a.id
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Learning Forge AI'
  AND a.name LIKE '%AutoResearch%'
  AND aak.revoked_at IS NOT NULL;

-- Check 4: Verify no agents report to deactivated AutoResearch agents
SELECT 
    a.name as active_agent,
    boss.name as reports_to_deactivated_agent,
    boss.is_active as boss_is_active
FROM agents a
JOIN agents boss ON a.reports_to = boss.id
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Learning Forge AI'
  AND a.is_active = true
  AND boss.is_active = false
  AND boss.name LIKE '%AutoResearch%';

-- ============================================================================
-- EXPECTED RESULTS AFTER DEACTIVATION:
-- 
-- Check 1:
-- - Active AutoResearch Agents: 0
-- - Inactive AutoResearch Agents: 3
-- - Total AutoResearch Agents: 3
--
-- Check 2:
-- - All 3 agents should show is_active = false
-- - All 3 agents should show "✗ Revoked API Key"
--
-- Check 3:
-- - Active API Keys: 0
-- - Revoked API Keys: 3
--
-- Check 4:
-- - Should return no rows (no active agents reporting to deactivated agents)
-- ============================================================================
