-- Update adapter command to use full path for Render deployment
UPDATE agents
SET adapter_config = jsonb_set(
    adapter_config,
    '{command}',
    '"/opt/render/project/src/hermes_agent/run.sh"'
)
WHERE adapter_config->>'command' = 'hermes';

-- Verify the change
SELECT
    id,
    name,
    adapter_config->>'command' as command
FROM agents
WHERE adapter_config IS NOT NULL
ORDER BY name;
