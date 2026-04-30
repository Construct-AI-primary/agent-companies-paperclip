-- Migration Script: Convert HTTP Agents to hermes_local Adapter (v2)
-- 
-- Purpose: Migrate agents using HTTP adapter (pointing to external Hermes service)
-- to the built-in hermes_local adapter.
--
-- Version 2 Changes:
-- - Simplified WHERE clause to catch all HTTP agents
-- - Added diagnostic queries to understand current state
-- - More flexible pattern matching
--
-- Date: 2026-04-20
-- Version: 2.0

-- DIAGNOSTIC: Show ALL agents to understand current state
SELECT
    id,
    name,
    adapter_type,
    adapter_config
FROM agents
ORDER BY adapter_type, name
LIMIT 50;

-- DIAGNOSTIC: Show only HTTP agents
SELECT
    id,
    name,
    adapter_type,
    adapter_config->>'url' as url,
    adapter_config->'payloadTemplate'->>'model' as model,
    adapter_config
FROM agents
WHERE adapter_type = 'http'
ORDER BY name;

-- DIAGNOSTIC: Check if URL field exists in adapter_config
SELECT
    id,
    name,
    adapter_type,
    adapter_config ? 'url' as has_url_field,
    adapter_config->>'url' as url_value
FROM agents
WHERE adapter_type = 'http';

-- MIGRATION: Convert ALL HTTP agents to hermes_local
-- (Remove the URL filter to migrate all HTTP agents)
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
WHERE adapter_type = 'http';

-- VERIFICATION: Show migrated agents
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

-- VERIFICATION: Check for any remaining HTTP agents
SELECT
    COUNT(*) as remaining_http_agents
FROM agents
WHERE adapter_type = 'http';
