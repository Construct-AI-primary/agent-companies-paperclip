-- Check if Nimbus agent exists and is active
SELECT
    'Nimbus Agent Status' as check_type,
    CASE
        WHEN a.id IS NOT NULL THEN 'EXISTS'
        ELSE 'NOT FOUND'
    END as status,
    a.id,
    a.name,
    a.company_id,
    c.name as company_name,
    a.created_at
FROM agents a
LEFT JOIN companies c ON a.company_id = c.id::uuid
WHERE a.name = 'nimbus-infraforge-supabase-specialist'
   OR a.id::text LIKE '%nimbus%';

-- Check if Nimbus has model assignments
SELECT
    'Nimbus Model Assignment' as check_type,
    CASE
        WHEN am.id IS NOT NULL THEN 'HAS MODEL'
        ELSE 'NO MODEL'
    END as status,
    am.model_id,
    am.assignment_type,
    am.temperature,
    am.created_at
FROM agents a
LEFT JOIN agent_models am ON a.id = am.agent_id::uuid
WHERE a.name = 'nimbus-infraforge-supabase-specialist';

-- Check if Nimbus has API keys
SELECT
    'Nimbus API Key' as check_type,
    CASE
        WHEN aak.id IS NOT NULL THEN 'HAS API KEY'
        ELSE 'NO API KEY'
    END as status,
    LEFT(aak.api_key, 10) || '...' as key_prefix,
    aak.created_at
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid
WHERE a.name = 'nimbus-infraforge-supabase-specialist';

-- Check InfraForge AI agents
SELECT
    'InfraForge AI Agents' as check_type,
    COUNT(*) as total_agents,
    COUNT(CASE WHEN am.id IS NOT NULL THEN 1 END) as with_models,
    COUNT(CASE WHEN aak.id IS NOT NULL THEN 1 END) as with_api_keys
FROM agents a
LEFT JOIN agent_models am ON a.id = am.agent_id::uuid
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid
WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440011'; -- InfraForge AI