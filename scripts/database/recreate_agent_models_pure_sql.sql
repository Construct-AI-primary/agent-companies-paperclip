-- Pure SQL solution to recreate agent_models records for agents without assignments
-- This is a SQL-only alternative to the Node.js script

-- Step 1: Clean up any invalid agent_models records first
DELETE FROM agent_models
WHERE agent_id NOT LIKE '________-____-____-____-____________'
   OR LENGTH(agent_id) < 36
   OR agent_id ~ '[^0-9a-f\-]';

-- Step 2: Create model assignments for agents without them
-- Using a CTE to identify agents and their appropriate model configurations

WITH agents_needing_models AS (
    SELECT
        a.id,
        a.name,
        a.company_id,
        c.name as company_name,
        -- Determine appropriate model based on company
        CASE a.company_id
            WHEN '550e8400-e29b-41d4-a716-446655440013' THEN 'qwen/qwen-3.6-72b-instruct'  -- QualityForge AI
            WHEN '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d' THEN 'qwen/qwen-3.6-72b-instruct'  -- DomainForge AI
            WHEN '550e8400-e29b-41d4-a716-446655440008' THEN 'z-ai/glm-5-turbo'            -- ContentForge AI
            WHEN '550e8400-e29b-41d4-a716-446655440009' THEN 'z-ai/glm-5.1'                -- LearningForge AI
            WHEN '550e8400-e29b-41d4-a716-446655440011' THEN 'qwen/qwen-3.6-72b-instruct'  -- InfraForge AI
            WHEN '550e8400-e29b-41d4-a716-446655440010' THEN 'qwen/qwen-3.6-72b-instruct'  -- DevForge AI
            WHEN '550e8400-e29b-41d4-a716-446655440012' THEN 'z-ai/glm-5.1'                -- KnowledgeForge AI
            ELSE 'qwen/qwen-3.6-72b-instruct'  -- Default
        END as model_id,
        -- Determine appropriate temperature based on company
        CASE a.company_id
            WHEN '550e8400-e29b-41d4-a716-446655440013' THEN 0.30  -- QualityForge AI - analytical
            WHEN '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d' THEN 0.30  -- DomainForge AI - analytical
            WHEN '550e8400-e29b-41d4-a716-446655440008' THEN 0.70  -- ContentForge AI - creative
            WHEN '550e8400-e29b-41d4-a716-446655440009' THEN 0.70  -- LearningForge AI - adaptive
            WHEN '550e8400-e29b-41d4-a716-446655440011' THEN 0.30  -- InfraForge AI - technical
            WHEN '550e8400-e29b-41d4-a716-446655440010' THEN 0.30  -- DevForge AI - technical
            WHEN '550e8400-e29b-41d4-a716-446655440012' THEN 0.50  -- KnowledgeForge AI - comprehensive
            ELSE 0.30  -- Default
        END as temperature,
        -- Determine reason based on company
        CASE a.company_id
            WHEN '550e8400-e29b-41d4-a716-446655440013' THEN 'Quality assurance and testing agent - requires analytical reasoning'
            WHEN '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d' THEN 'Domain specialization agent - requires deep understanding'
            WHEN '550e8400-e29b-41d4-a716-446655440008' THEN 'Content creation agent - requires creative flexibility'
            WHEN '550e8400-e29b-41d4-a716-446655440009' THEN 'Learning and education agent - requires adaptive reasoning'
            WHEN '550e8400-e29b-41d4-a716-446655440011' THEN 'Infrastructure agent - requires precise technical reasoning'
            WHEN '550e8400-e29b-41d4-a716-446655440010' THEN 'Development agent - requires coding and technical expertise'
            WHEN '550e8400-e29b-41d4-a716-446655440012' THEN 'Knowledge management agent - requires comprehensive understanding'
            ELSE 'General purpose agent - standard configuration'
        END as reason_base
    FROM agents a
    LEFT JOIN agent_models am ON a.id = am.agent_id::uuid
    LEFT JOIN companies c ON a.company_id = c.id::uuid
    WHERE am.id IS NULL
)
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
)
SELECT
    gen_random_uuid(),
    id,
    model_id,
    'primary',
    1,
    temperature,
    4096,
    NOW(),
    'system',
    reason_base || ' - Auto-created after agent_models cleanup',
    0,
    0,
    0,
    0.0000,
    NULL,
    0.0000,
    true,
    NOW(),
    NOW(),
    company_id
FROM agents_needing_models;

-- Step 3: Verification queries
SELECT
    'Total agents' as metric,
    COUNT(*) as count
FROM agents
UNION ALL
SELECT
    'Agents with model assignments' as metric,
    COUNT(DISTINCT am.agent_id) as count
FROM agent_models am
WHERE am.agent_id LIKE '________-____-____-____-____________'
UNION ALL
SELECT
    'Agents without model assignments' as metric,
    COUNT(*) as count
FROM agents a
LEFT JOIN agent_models am ON a.id = am.agent_id::uuid
WHERE am.id IS NULL
UNION ALL
SELECT
    'Total agent_models records' as metric,
    COUNT(*) as count
FROM agent_models
UNION ALL
SELECT
    'Valid agent_models records' as metric,
    COUNT(*) as count
FROM agent_models
WHERE agent_id LIKE '________-____-____-____-____________';

-- Step 4: Show which agents got new assignments
SELECT
    'New assignments created' as status,
    COUNT(*) as count
FROM (
    SELECT a.name, c.name as company_name
    FROM agents a
    JOIN agent_models am ON a.id = am.agent_id::uuid
    LEFT JOIN companies c ON a.company_id = c.id::uuid
    WHERE am.reason LIKE '%Auto-created after agent_models cleanup%'
) as new_assignments;