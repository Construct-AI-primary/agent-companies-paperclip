-- Update all agent adapter types to 'http'
-- This script changes all agents from their current adapter types (hermes_local, opencode_local, etc.) to http

UPDATE agents
SET adapter_type = 'http'
WHERE adapter_type IS NOT NULL;

-- Verify the update
SELECT
    adapter_type,
    COUNT(*) as count
FROM agents
GROUP BY adapter_type
ORDER BY adapter_type;