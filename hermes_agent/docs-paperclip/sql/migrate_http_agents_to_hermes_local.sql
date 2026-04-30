-- Migration Script: Convert HTTP Agents to hermes_local Adapter
-- 
-- Purpose: Migrate agents using HTTP adapter (pointing to external Hermes service)
-- to the built-in hermes_local adapter.
--
-- Background:
-- - Sample agent shows adapter_type='http' with URL pointing to srv-d7h2col7vvec738ujfag:3100
-- - This appears to be an external Hermes service that is no longer needed
-- - The built-in hermes_local adapter provides the same functionality
-- - Model config from payloadTemplate should be preserved in adapter_config
--
-- Date: 2026-04-20
-- Version: 1.0

-- Step 1: Show current HTTP agents (before migration)
SELECT
    id,
    name,
    adapter_type,
    adapter_config->>'url' as current_url,
    adapter_config->'payloadTemplate'->>'model' as current_model,
    adapter_config
FROM agents
WHERE adapter_type = 'http'
  AND (adapter_config->>'url' LIKE '%hermes%' 
       OR adapter_config->>'url' LIKE '%srv-%')
ORDER BY name;

-- Step 2: Migrate HTTP agents to hermes_local
-- Extract model from payloadTemplate if present, otherwise use empty config
UPDATE agents
SET 
    adapter_type = 'hermes_local',
    adapter_config = CASE
        WHEN adapter_config->'payloadTemplate'->>'model' IS NOT NULL THEN
            jsonb_build_object(
                'model', adapter_config->'payloadTemplate'->>'model',
                'timeoutSec', COALESCE((adapter_config->>'timeoutMs')::int / 1000, 300),
                'persistSession', COALESCE((runtime_config->>'persistSession')::boolean, true)
            )
        ELSE
            jsonb_build_object(
                'timeoutSec', COALESCE((adapter_config->>'timeoutMs')::int / 1000, 300),
                'persistSession', COALESCE((runtime_config->>'persistSession')::boolean, true)
            )
    END
WHERE adapter_type = 'http'
  AND (adapter_config->>'url' LIKE '%hermes%' 
       OR adapter_config->>'url' LIKE '%srv-%');

-- Step 3: Verify migration (should show hermes_local with proper config)
SELECT
    id,
    name,
    adapter_type,
    adapter_config->>'model' as model,
    adapter_config->>'timeoutSec' as timeout_sec,
    adapter_config->>'persistSession' as persist_session,
    adapter_config
FROM agents
WHERE adapter_type = 'hermes_local'
ORDER BY name;

-- Step 4: Check for any remaining HTTP agents
SELECT
    id,
    name,
    adapter_type,
    adapter_config->>'url' as url
FROM agents
WHERE adapter_type = 'http'
ORDER BY name;
