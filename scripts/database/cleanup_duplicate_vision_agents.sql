-- Cleanup duplicate Vision Loopy CEO agents
-- This script removes duplicate Vision agents, keeping only the most recent one

BEGIN;

-- First, check for duplicate Vision agents
SELECT 
    'Duplicate Vision agents found:' as info,
    COUNT(*) as duplicate_count
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Loopy AI' AND a.name = 'Vision';

-- Show all Vision agents with their details
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
JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
WHERE c.name = 'Loopy AI' AND a.name = 'Vision'
ORDER BY a.created_at DESC;

-- If there are duplicates, keep only the most recent Vision agent
-- Delete older duplicates and their associated records
DELETE FROM agent_models 
WHERE agent_id = 'Vision' 
AND agent_id IN (
    SELECT a.name 
    FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'Loopy AI' AND a.name = 'Vision'
    AND a.id NOT IN (
        SELECT sub.id
        FROM agents sub
        JOIN companies sub_c ON sub.company_id = sub_c.id
        WHERE sub_c.name = 'Loopy AI' AND sub.name = 'Vision'
        ORDER BY sub.created_at DESC
        LIMIT 1
    )
);

DELETE FROM agent_api_keys 
WHERE agent_id IN (
    SELECT a.id 
    FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'Loopy AI' AND a.name = 'Vision'
    AND a.id NOT IN (
        SELECT sub.id
        FROM agents sub
        JOIN companies sub_c ON sub.company_id = sub_c.id
        WHERE sub_c.name = 'Loopy AI' AND sub.name = 'Vision'
        ORDER BY sub.created_at DESC
        LIMIT 1
    )
);

DELETE FROM agents 
WHERE id IN (
    SELECT a.id 
    FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'Loopy AI' AND a.name = 'Vision'
    AND a.id NOT IN (
        SELECT sub.id
        FROM agents sub
        JOIN companies sub_c ON sub.company_id = sub_c.id
        WHERE sub_c.name = 'Loopy AI' AND sub.name = 'Vision'
        ORDER BY sub.created_at DESC
        LIMIT 1
    )
);

-- Verify cleanup - should show only one Vision agent
SELECT 
    'After cleanup - Vision agents:' as info,
    COUNT(*) as vision_count
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Loopy AI' AND a.name = 'Vision';

-- Show the remaining Vision agent details
SELECT 
    a.id,
    a.name,
    a.role,
    a.title,
    a.created_at,
    CASE WHEN aak.id IS NOT NULL THEN '✓ Has API Key' ELSE '✗ Missing API Key' END as api_key_status,
    CASE WHEN am.id IS NOT NULL THEN '✓ Has Model' ELSE '✗ Missing Model' END as model_status
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
WHERE c.name = 'Loopy AI' AND a.name = 'Vision';

COMMIT;
