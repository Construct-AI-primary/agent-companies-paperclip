-- Check Nimbus current status with correct ID
SELECT
    'Nimbus Current Status' as check_type,
    CASE
        WHEN a.id IS NOT NULL THEN '✅ EXISTS'
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
    a.id,
    a.name,
    a.company_id,
    c.name as company_name,
    am.model_id,
    am.temperature,
    LEFT(aak.api_key, 12) || '...' as key_preview,
    array_length(a.skills, 1) as skill_count
FROM agents a
LEFT JOIN companies c ON a.company_id = c.id::uuid
LEFT JOIN agent_models am ON a.id = am.agent_id::uuid
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid
WHERE a.id = '660e8400-e29b-41d4-a716-446655440002'::uuid;

-- Show Nimbus skills
SELECT
    'Nimbus Skills' as skill_check,
    unnest(skills) as skill
FROM agents
WHERE id = '660e8400-e29b-41d4-a716-446655440002'::uuid
ORDER BY skill;

-- Check if Nimbus can be used for agent_api_keys investigation
SELECT
    'Nimbus Readiness for API Keys Work' as assessment,
    CASE
        WHEN a.id IS NOT NULL AND am.id IS NOT NULL AND aak.id IS NOT NULL THEN '✅ READY TO USE'
        ELSE '❌ NEEDS ACTIVATION'
    END as status,
    CASE
        WHEN array_length(a.skills, 1) >= 5 THEN '✅ SPECIALIZED'
        ELSE '❌ UNDER-SKILLED'
    END as expertise,
    am.model_id as assigned_model
FROM agents a
LEFT JOIN agent_models am ON a.id = am.agent_id::uuid
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid
WHERE a.id = '660e8400-e29b-41d4-a716-446655440002'::uuid;