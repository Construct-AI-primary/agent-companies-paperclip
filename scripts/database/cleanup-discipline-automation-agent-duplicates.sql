-- Cleanup duplicate Discipline Automation Agents
-- Keep only the most recent agent record and handle foreign key constraints

-- First, identify all duplicate agents and their relationships
SELECT
  a.id,
  a.name,
  a.created_at,
  ROW_NUMBER() OVER (PARTITION BY a.name ORDER BY a.created_at DESC) as rn,
  COUNT(al.id) as activity_log_entries,
  COUNT(aak.id) as api_key_entries,
  COUNT(am.id) as model_assignments
FROM agents a
LEFT JOIN activity_log al ON a.id = al.agent_id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
LEFT JOIN agent_models am ON a.name = am.agent_id
WHERE a.name = 'Discipline Automation Agent'
GROUP BY a.id, a.name, a.created_at
ORDER BY a.created_at DESC;

-- Get the ID of the most recent agent (the one to keep)
CREATE TEMP TABLE agent_to_keep AS
SELECT id
FROM (
  SELECT
    id,
    ROW_NUMBER() OVER (PARTITION BY name ORDER BY created_at DESC) as rn
  FROM agents
  WHERE name = 'Discipline Automation Agent'
) ranked
WHERE rn = 1;

-- Update foreign key references to point to the agent we're keeping
UPDATE activity_log
SET agent_id = (SELECT id FROM agent_to_keep)
WHERE agent_id IN (
  SELECT id FROM agents
  WHERE name = 'Discipline Automation Agent'
  AND id NOT IN (SELECT id FROM agent_to_keep)
);

UPDATE agent_api_keys
SET agent_id = (SELECT id FROM agent_to_keep)
WHERE agent_id IN (
  SELECT id FROM agents
  WHERE name = 'Discipline Automation Agent'
  AND id NOT IN (SELECT id FROM agent_to_keep)
);

-- Note: agent_models uses agent name, not ID, so no update needed

-- Now delete the duplicate agents (excluding the one to keep)
DELETE FROM agents
WHERE name = 'Discipline Automation Agent'
  AND id NOT IN (SELECT id FROM agent_to_keep);

-- Verify cleanup
SELECT
  a.id,
  a.name,
  a.role,
  a.status,
  a.created_at,
  COUNT(DISTINCT al.id) as activity_log_entries,
  COUNT(DISTINCT aak.id) as api_key_entries,
  COUNT(DISTINCT am.id) as model_assignments
FROM agents a
LEFT JOIN activity_log al ON a.id = al.agent_id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
LEFT JOIN agent_models am ON a.name = am.agent_id
WHERE a.name = 'Discipline Automation Agent'
GROUP BY a.id, a.name, a.role, a.status, a.created_at
ORDER BY a.created_at DESC;

-- Clean up temp table
DROP TABLE agent_to_keep;

COMMIT;
