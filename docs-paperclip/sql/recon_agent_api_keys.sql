-- Reconnaissance: Check for missing agent_api_keys
-- This script identifies agents that exist but don't have API keys

-- Step 1: Basic counts
SELECT
    'Total agents' as metric,
    COUNT(*) as count
FROM agents
UNION ALL
SELECT
    'Agents with API keys' as metric,
    COUNT(DISTINCT aak.agent_id) as count
FROM agent_api_keys aak
WHERE aak.agent_id LIKE '________-____-____-____-____________'
UNION ALL
SELECT
    'Agents without API keys' as metric,
    COUNT(*) as count
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid
WHERE aak.id IS NULL;

-- Step 2: List agents without API keys
SELECT
    a.id,
    a.name,
    a.company_id,
    c.name as company_name,
    a.created_at
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid
LEFT JOIN companies c ON a.company_id = c.id::uuid
WHERE aak.id IS NULL
ORDER BY a.company_id, a.name;

-- Step 3: Check for invalid agent_api_keys records (non-UUID agent_ids)
SELECT
    'Invalid agent_api_keys records' as metric,
    COUNT(*) as count
FROM agent_api_keys
WHERE agent_id NOT LIKE '________-____-____-____-____________'
   OR LENGTH(agent_id) < 36
   OR agent_id ~ '[^0-9a-f\-]';

-- Step 4: Show invalid agent_api_keys records
SELECT
    id,
    agent_id,
    api_key_prefix,
    created_at
FROM agent_api_keys
WHERE agent_id NOT LIKE '________-____-____-____-____-____________'
   OR LENGTH(agent_id) < 36
   OR agent_id ~ '[^0-9a-f\-]'
ORDER BY created_at DESC;

-- Step 5: Company breakdown of agents without API keys
SELECT
    COALESCE(c.name, 'Unknown Company') as company_name,
    COUNT(*) as agents_without_keys
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid
LEFT JOIN companies c ON a.company_id = c.id::uuid
WHERE aak.id IS NULL
GROUP BY c.name
ORDER BY agents_without_keys DESC;

-- Step 6: Check recent agents (created after backup) without keys
SELECT
    a.id,
    a.name,
    c.name as company_name,
    a.created_at
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid
LEFT JOIN companies c ON a.company_id = c.id::uuid
WHERE aak.id IS NULL
  AND a.created_at > '2026-04-15 08:16:20'  -- After backup timestamp
ORDER BY a.created_at DESC;