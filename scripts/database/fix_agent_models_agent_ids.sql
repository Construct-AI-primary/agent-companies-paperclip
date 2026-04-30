-- Fix agent_id mixup in agent_models table
-- Replace agent names with proper UUIDs

-- First, create a temporary mapping table
CREATE TEMP TABLE agent_name_to_uuid AS
SELECT
    id as agent_uuid,
    name as agent_name
FROM agents
WHERE name IS NOT NULL AND id IS NOT NULL;

-- Update agent_models table where agent_id contains names instead of UUIDs
UPDATE agent_models
SET agent_id = COALESCE(
    (SELECT agent_uuid FROM agent_name_to_uuid WHERE agent_name = agent_models.agent_id),
    agent_id  -- Keep original if no mapping found
)
WHERE agent_id NOT LIKE '________-____-____-____-____________'
   OR LENGTH(agent_id) < 36
   OR agent_id ~ '[^0-9a-f\-]';  -- Contains non-hex characters (excluding dashes)

-- Report results
SELECT
    COUNT(*) as total_records,
    COUNT(CASE WHEN agent_id LIKE '________-____-____-____-____________' THEN 1 END) as uuid_records,
    COUNT(CASE WHEN agent_id NOT LIKE '________-____-____-____-____________' OR LENGTH(agent_id) < 36 THEN 1 END) as non_uuid_records
FROM agent_models;

-- Show a sample of fixed records
SELECT
    am.id,
    am.agent_id,
    a.name as agent_name,
    am.model_id,
    am.assignment_type
FROM agent_models am
LEFT JOIN agents a ON a.id = am.agent_id::uuid
WHERE am.agent_id LIKE '________-____-____-____-____________'
LIMIT 10;