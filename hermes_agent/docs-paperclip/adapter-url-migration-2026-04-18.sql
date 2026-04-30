-- Adapter URL Migration: 2026-04-18
-- Update adapter URLs for new deployment
-- Generated: 2026-04-18
-- Old URL: https://github.com/tennantalistair/hermes-render-github-testing.git
-- New URL: https://github.com/Construct-AI-primary/construct_ai.git

-- Backup current state (recommended)
CREATE TABLE IF NOT EXISTS agents_backup_20260418 AS
SELECT * FROM agents;

-- Update all agents with adapter_config containing the old GitHub URL
UPDATE agents
SET adapter_config = REPLACE(
    adapter_config::text,
    'https://github.com/tennantalistair/hermes-render-github-testing.git',
    'https://github.com/Construct-AI-primary/construct_ai.git'
)::jsonb
WHERE adapter_config::text LIKE '%https://github.com/tennantalistair/hermes-render-github-testing.git%';

-- Verify the changes
SELECT
    id,
    name,
    adapter_config
FROM agents
WHERE adapter_config::text LIKE '%https://github.com/Construct-AI-primary/construct_ai.git%';

-- Rollback if needed (uncomment and modify as necessary)
-- UPDATE agents
-- SET adapter_config = (
--     SELECT adapter_config
--     FROM agents_backup_20260418
--     WHERE agents_backup_20260418.id = agents.id
-- );

-- Clean up backup after verification
-- DROP TABLE agents_backup_20260418;