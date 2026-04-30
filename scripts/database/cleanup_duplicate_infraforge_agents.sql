

-- First, check current InfraForge agents
SELECT
    'Current InfraForge agents:' as info,
    COUNT(*) as agent_count
FROM agents
WHERE company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666';

-- Show all InfraForge agents ordered by name and creation date
SELECT
    a.id,
    a.name,
    a.role,
    a.title,
    a.created_at,
    a.updated_at,
    CASE WHEN aak.id IS NOT NULL THEN 'Has API Key' ELSE 'No API Key' END as api_key_status,
    CASE WHEN am.id IS NOT NULL THEN 'Has Model' ELSE 'No Model' END as model_status
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
WHERE a.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
ORDER BY a.name, a.created_at;

-- Check for duplicates by name
SELECT
    name,
    COUNT(*) as count,
    STRING_AGG(id::text, ', ' ORDER BY created_at) as ids,
    STRING_AGG(created_at::text, ', ' ORDER BY created_at) as created_dates
FROM agents
WHERE company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY name;

-- Remove duplicates for 'Database' agents - keep the earliest created one
-- Delete from agent_skill_assignments first (due to foreign key constraints)
DELETE FROM agent_skill_assignments
WHERE agent_id IN (
    SELECT a.id
    FROM agents a
    WHERE a.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
    AND a.name = 'Database'
    AND a.id NOT IN (
        SELECT sub.id
        FROM agents sub
        WHERE sub.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
        AND sub.name = 'Database'
        ORDER BY sub.created_at ASC
        LIMIT 1
    )
);

-- Delete from agent_models
DELETE FROM agent_models
WHERE agent_id IN (
    SELECT a.name
    FROM agents a
    WHERE a.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
    AND a.name = 'Database'
    AND a.id NOT IN (
        SELECT sub.id
        FROM agents sub
        WHERE sub.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
        AND sub.name = 'Database'
        ORDER BY sub.created_at ASC
        LIMIT 1
    )
);

-- Delete from agent_api_keys
DELETE FROM agent_api_keys
WHERE agent_id IN (
    SELECT a.id
    FROM agents a
    WHERE a.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
    AND a.name = 'Database'
    AND a.id NOT IN (
        SELECT sub.id
        FROM agents sub
        WHERE sub.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
        AND sub.name = 'Database'
        ORDER BY sub.created_at ASC
        LIMIT 1
    )
);

-- Delete the duplicate Database agents
DELETE FROM agents
WHERE company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
AND name = 'Database'
AND id NOT IN (
    SELECT sub.id
    FROM agents sub
    WHERE sub.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
    AND sub.name = 'Database'
    ORDER BY sub.created_at ASC
    LIMIT 1
);

-- Remove duplicates for 'Orchestrator' agents - keep the earliest created one
-- Delete from agent_skill_assignments first
DELETE FROM agent_skill_assignments
WHERE agent_id IN (
    SELECT a.id
    FROM agents a
    WHERE a.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
    AND a.name = 'Orchestrator'
    AND a.id NOT IN (
        SELECT sub.id
        FROM agents sub
        WHERE sub.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
        AND sub.name = 'Orchestrator'
        ORDER BY sub.created_at ASC
        LIMIT 1
    )
);

-- Delete from agent_models
DELETE FROM agent_models
WHERE agent_id IN (
    SELECT a.name
    FROM agents a
    WHERE a.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
    AND a.name = 'Orchestrator'
    AND a.id NOT IN (
        SELECT sub.id
        FROM agents sub
        WHERE sub.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
        AND sub.name = 'Orchestrator'
        ORDER BY sub.created_at ASC
        LIMIT 1
    )
);

-- Delete from agent_api_keys
DELETE FROM agent_api_keys
WHERE agent_id IN (
    SELECT a.id
    FROM agents a
    WHERE a.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
    AND a.name = 'Orchestrator'
    AND a.id NOT IN (
        SELECT sub.id
        FROM agents sub
        WHERE sub.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
        AND sub.name = 'Orchestrator'
        ORDER BY sub.created_at ASC
        LIMIT 1
    )
);

-- Delete the duplicate Orchestrator agents
DELETE FROM agents
WHERE company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
AND name = 'Orchestrator'
AND id NOT IN (
    SELECT sub.id
    FROM agents sub
    WHERE sub.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
    AND sub.name = 'Orchestrator'
    ORDER BY sub.created_at ASC
    LIMIT 1
);

-- Verify cleanup - show remaining InfraForge agents
SELECT
    'After cleanup - InfraForge agents:' as info,
    COUNT(*) as remaining_count
FROM agents
WHERE company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666';

-- Show remaining agents with their details
SELECT
    a.id,
    a.name,
    a.role,
    a.title,
    a.created_at,
    CASE WHEN aak.id IS NOT NULL THEN '✓ Has API Key' ELSE '✗ Missing API Key' END as api_key_status,
    CASE WHEN am.id IS NOT NULL THEN '✓ Has Model' ELSE '✗ Missing Model' END as model_status
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
WHERE a.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
ORDER BY a.name, a.created_at;

-- Check for any remaining duplicates
SELECT
    'Remaining duplicates check:' as info,
    name,
    COUNT(*) as count
FROM agents
WHERE company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY name;
