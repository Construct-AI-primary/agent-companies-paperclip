-- Fix the Validator agent to use hermes_local adapter instead of http
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = jsonb_build_object(
        'url', 'https://github.com/Construct-AI-primary/construct_ai.git',
        'persistSession', true,
        'toolsets', jsonb_build_array('file_tools', 'terminal_tools', 'git'),
        'timeoutSec', 600,
        'graceSec', 15
    )
WHERE id = '982344cb-0dc9-4cf4-99cc-22bf9a61655a'
AND adapter_type = 'http';

-- Verify the change
SELECT
    id,
    name,
    adapter_type,
    adapter_config
FROM agents
WHERE id = '982344cb-0dc9-4cf4-99cc-22bf9a61655a';