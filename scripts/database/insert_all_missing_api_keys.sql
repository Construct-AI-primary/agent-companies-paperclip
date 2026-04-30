-- ============================================================================
-- INSERT API KEYS FOR ALL AGENTS MISSING THEM
-- Generated: 2026-04-12
-- Purpose: Ensure 100% API key coverage for all active agents
-- ============================================================================

-- This script creates API keys for all active agents that don't have them
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash, created_at)
SELECT 
    gen_random_uuid() as id,
    a.id as agent_id,
    a.company_id,
    'Primary Key' as name,
    encode(sha256(random()::text::bytea), 'hex') as key_hash,
    NOW() as created_at
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id AND aak.revoked_at IS NULL
WHERE a.is_active = true
  AND aak.id IS NULL;

-- Verification query
SELECT 
    '=== VERIFICATION ===' as section,
    COUNT(DISTINCT a.id) as total_active_agents,
    COUNT(DISTINCT aak.id) as agents_with_keys,
    COUNT(DISTINCT a.id) - COUNT(DISTINCT aak.id) as agents_missing_keys
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id AND aak.revoked_at IS NULL
WHERE a.is_active = true;

-- Detailed breakdown by company
SELECT 
    '' as spacer,
    '=== BY COMPANY ===' as section;

SELECT 
    c.name as company,
    COUNT(DISTINCT a.id) as active_agents,
    COUNT(DISTINCT aak.id) as agents_with_keys,
    COUNT(DISTINCT a.id) - COUNT(DISTINCT aak.id) as missing_keys
FROM companies c
INNER JOIN agents a ON c.id = a.company_id AND a.is_active = true
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id AND aak.revoked_at IS NULL
WHERE c.status = 'active'
GROUP BY c.name
ORDER BY missing_keys DESC, c.name;
