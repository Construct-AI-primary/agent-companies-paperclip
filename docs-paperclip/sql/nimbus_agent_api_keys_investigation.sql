-- Investigation Request for Nimbus: Agent API Keys Gap Analysis
-- This query provides the data Nimbus needs to analyze agent_api_keys gaps

-- Step 1: Current agent_api_keys status summary
SELECT
    'Agent API Keys Status Summary' as investigation_request,
    COUNT(*) as total_agents,
    COUNT(CASE WHEN aak.id IS NOT NULL THEN 1 END) as agents_with_keys,
    COUNT(CASE WHEN aak.id IS NULL THEN 1 END) as agents_without_keys,
    ROUND(
        COUNT(CASE WHEN aak.id IS NOT NULL THEN 1 END)::decimal /
        COUNT(*)::decimal * 100, 1
    ) as coverage_percentage
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid;

-- Step 2: Agents missing API keys (for Nimbus analysis)
SELECT
    'Agents Missing API Keys' as investigation_data,
    a.id as agent_id,
    a.name as agent_name,
    c.name as company_name,
    a.created_at as agent_created,
    a.role,
    a.title
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid
LEFT JOIN companies c ON a.company_id = c.id::uuid
WHERE aak.id IS NULL
ORDER BY a.company_id, a.created_at DESC;

-- Step 3: Company breakdown of API key gaps
SELECT
    'Company API Key Coverage' as investigation_data,
    COALESCE(c.name, 'Unknown Company') as company_name,
    COUNT(a.id) as total_agents,
    COUNT(CASE WHEN aak.id IS NOT NULL THEN 1 END) as with_api_keys,
    COUNT(CASE WHEN aak.id IS NULL THEN 1 END) as missing_api_keys,
    ROUND(
        COUNT(CASE WHEN aak.id IS NOT NULL THEN 1 END)::decimal /
        COUNT(a.id)::decimal * 100, 1
    ) as coverage_percentage
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid
LEFT JOIN companies c ON a.company_id = c.id::uuid
GROUP BY c.name
ORDER BY missing_api_keys DESC;

-- Step 4: Recent agents without keys (potential onboarding issues)
SELECT
    'Recent Agents Without Keys' as investigation_data,
    a.id as agent_id,
    a.name as agent_name,
    c.name as company_name,
    a.created_at as created_date,
    EXTRACT(EPOCH FROM (NOW() - a.created_at))/86400 as days_old
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid
LEFT JOIN companies c ON a.company_id = c.id::uuid
WHERE aak.id IS NULL
  AND a.created_at > NOW() - INTERVAL '30 days'
ORDER BY a.created_at DESC;

-- Step 5: Invalid agent_api_keys records (data quality issues)
SELECT
    'Invalid API Key Records' as investigation_data,
    COUNT(*) as invalid_records,
    COUNT(CASE WHEN agent_id::text NOT LIKE '________-____-____-____-____________' THEN 1 END) as malformed_uuids,
    COUNT(CASE WHEN LENGTH(agent_id::text) < 36 THEN 1 END) as short_ids,
    COUNT(CASE WHEN agent_id::text ~ '[^0-9a-f\-]' THEN 1 END) as invalid_characters
FROM agent_api_keys
WHERE agent_id::text NOT LIKE '________-____-____-____-____________'
   OR LENGTH(agent_id::text) < 36
   OR agent_id::text ~ '[^0-9a-f\-]';

-- Step 6: Sample of valid API keys for pattern analysis
SELECT
    'Valid API Key Patterns' as investigation_data,
    LEFT(api_key, 8) || '...' as key_prefix,
    api_key_prefix,
    created_at
FROM agent_api_keys
WHERE agent_id LIKE '________-____-____-____-____________'
ORDER BY created_at DESC
LIMIT 10;

-- Investigation Request Summary for Nimbus
SELECT
    'INVESTIGATION REQUEST' as nimbus_task,
    'Analyze agent_api_keys gaps and provide recommendations' as task_description,
    COUNT(*) as total_agents,
    COUNT(CASE WHEN aak.id IS NULL THEN 1 END) as missing_keys,
    ROUND(
        COUNT(CASE WHEN aak.id IS NULL THEN 1 END)::decimal /
        COUNT(*)::decimal * 100, 1
    ) as gap_percentage
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid;