-- Cleanup Script: Remove hermesCommand from hermes_local Agent Configurations
-- 
-- Purpose: Remove the hermesCommand field from all agents using hermes_local adapter.
-- The built-in hermes_local adapter uses the system 'hermes' command by default
-- and does not need (and should not have) a hermesCommand field in adapter_config.
--
-- Background:
-- - The hermes_local adapter is built into Paperclip server via hermes-paperclip-adapter npm package
-- - It spawns the 'hermes' CLI command from the system PATH
-- - Previous configurations incorrectly added hermesCommand pointing to hermes_agent/run.sh
-- - This caused failures because hermes_agent/venv is gitignored and doesn't exist on Render
--
-- Date: 2026-04-20
-- Version: 1.0

-- Step 1: Show current state (before cleanup)
SELECT
    id,
    name,
    adapter_type,
    adapter_config->>'hermesCommand' as hermes_command_before,
    adapter_config
FROM agents
WHERE adapter_type = 'hermes_local'
  AND adapter_config::text LIKE '%hermesCommand%';

-- Step 2: Remove hermesCommand field from all hermes_local agents
UPDATE agents 
SET adapter_config = adapter_config - 'hermesCommand'
WHERE adapter_type = 'hermes_local' 
  AND adapter_config::text LIKE '%hermesCommand%';

-- Step 3: Verify cleanup (should return no rows)
SELECT
    id,
    name,
    adapter_type,
    adapter_config->>'hermesCommand' as hermes_command_after,
    adapter_config
FROM agents
WHERE adapter_type = 'hermes_local'
  AND adapter_config::text LIKE '%hermesCommand%';

-- Step 4: Show final state of all hermes_local agents
SELECT
    id,
    name,
    adapter_type,
    adapter_config
FROM agents
WHERE adapter_type = 'hermes_local'
ORDER BY name;
