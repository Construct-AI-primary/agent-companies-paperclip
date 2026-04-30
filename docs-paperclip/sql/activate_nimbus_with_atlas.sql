-- Activate Nimbus using Atlas Agent Creator
-- This script creates the Nimbus agent record based on its documentation

-- Step 1: Create the Nimbus agent record
INSERT INTO agents (
    id,
    name,
    description,
    company_id,
    reports_to,
    team,
    skills,
    created_at,
    updated_at
) VALUES (
    '550e8400-e29b-41d4-a716-446655440011'::uuid, -- InfraForge AI company ID
    'nimbus-infraforge-supabase-specialist',
    'Supabase Database Specialist - Expert in Supabase API, PostgreSQL operations, authentication troubleshooting, schema management, and SQL development/testing',
    '550e8400-e29b-41d4-a716-446655440011'::uuid, -- InfraForge AI
    'orchestrator-infraforge-ceo',
    'infrastructure',
    ARRAY['supabase-api-mastery', 'postgresql-expertise', 'authentication-flow-management', 'performance-monitoring-optimization', 'security-policy-implementation', 'sql-generation-testing', 'backup-restore-operations', 'integration-support'],
    NOW(),
    NOW()
) ON CONFLICT (id) DO NOTHING;

-- Step 2: Assign appropriate model to Nimbus
INSERT INTO agent_models (
    id,
    agent_id,
    model_id,
    assignment_type,
    priority,
    temperature,
    max_tokens,
    assigned_at,
    assigned_by,
    reason,
    total_requests,
    total_tokens_input,
    total_tokens_output,
    total_cost,
    avg_latency_ms,
    error_rate,
    is_active,
    created_at,
    updated_at,
    company_id
) VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011'::uuid, -- Nimbus agent ID
    'qwen/qwen-3.6-72b-instruct', -- Advanced analytical model for database work
    'primary',
    1,
    0.30, -- Lower temperature for precise database operations
    4096,
    NOW(),
    'atlas-agent-creator',
    'Primary model for Supabase Database Specialist - requires analytical reasoning for SQL generation, authentication troubleshooting, and performance optimization',
    0,
    0,
    0,
    0.0000,
    NULL,
    0.0000,
    true,
    NOW(),
    NOW(),
    '550e8400-e29b-41d4-a716-446655440011'::uuid -- InfraForge AI
) ON CONFLICT (agent_id, model_id) DO NOTHING;

-- Step 3: Generate API key for Nimbus
INSERT INTO agent_api_keys (
    id,
    agent_id,
    api_key,
    api_key_prefix,
    created_at,
    updated_at,
    company_id
) VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440011'::uuid, -- Nimbus agent ID
    encode(gen_random_bytes(32), 'hex'),
    'nimbus_',
    NOW(),
    NOW(),
    '550e8400-e29b-41d4-a716-446655440011'::uuid -- InfraForge AI
) ON CONFLICT (agent_id) DO NOTHING;

-- Step 4: Verification
SELECT
    'Nimbus Activation Status' as check_type,
    CASE
        WHEN a.id IS NOT NULL THEN '✅ ACTIVATED'
        ELSE '❌ NOT FOUND'
    END as agent_status,
    CASE
        WHEN am.id IS NOT NULL THEN '✅ HAS MODEL'
        ELSE '❌ NO MODEL'
    END as model_status,
    CASE
        WHEN aak.id IS NOT NULL THEN '✅ HAS API KEY'
        ELSE '❌ NO API KEY'
    END as api_key_status,
    a.name,
    am.model_id,
    LEFT(aak.api_key, 12) || '...' as key_preview
FROM agents a
LEFT JOIN agent_models am ON a.id = am.agent_id::uuid
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid
WHERE a.name = 'nimbus-infraforge-supabase-specialist';

-- Step 5: Show Nimbus capabilities summary
SELECT
    'Nimbus Capabilities' as summary,
    COUNT(*) as total_skills,
    string_agg(skill, ', ') as skills_list
FROM (
    SELECT unnest(skills) as skill
    FROM agents
    WHERE name = 'nimbus-infraforge-supabase-specialist'
) as skill_list;