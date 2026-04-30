-- Strategy: Remove invalid agent_models records and recreate them properly
-- This handles the 53 agents that were created after the backup

-- Step 1: Identify and remove invalid agent_models records for the 53 missing agents
-- These records have agent_id values that are not valid UUIDs

DELETE FROM agent_models
WHERE agent_id NOT LIKE '________-____-____-____-____________'
   OR LENGTH(agent_id) < 36
   OR agent_id ~ '[^0-9a-f\-]';

-- Step 2: Verify the cleanup
-- Should show 0 records with invalid agent_ids
SELECT COUNT(*) as invalid_records
FROM agent_models
WHERE agent_id NOT LIKE '________-____-____-____-____________'
   OR LENGTH(agent_id) < 36
   OR agent_id ~ '[^0-9a-f\-]';

-- Step 3: Check what agent_models records remain
-- These should all have valid UUID agent_ids now
SELECT COUNT(*) as total_remaining_records FROM agent_models;

-- Step 4: Identify agents that don't have any model assignments
-- These are agents that exist but have no agent_models records
SELECT
    a.id,
    a.name,
    a.company_id
FROM agents a
LEFT JOIN agent_models am ON a.id = am.agent_id::uuid
WHERE am.id IS NULL
ORDER BY a.company_id, a.name;

-- Step 5: For agents without model assignments, create default assignments
-- This would need to be done programmatically based on agent roles/skills
-- Example for a specific agent:
/*
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
    'agent-uuid-here',
    'qwen/qwen-3.6-72b-instruct',
    'primary',
    1,
    0.30,
    4096,
    NOW(),
    'system',
    'Recreated after cleanup of invalid agent_id records',
    0,
    0,
    0,
    0.0000,
    NULL,
    0.0000,
    true,
    NOW(),
    NOW(),
    'company-uuid-here'
);
*/

-- Step 6: Final verification
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