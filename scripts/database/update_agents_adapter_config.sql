-- Update all agents to use 'http' adapter_type and generate proper adapter_config for empty arrays
-- This script updates all agents to use HTTP adapters with proper configuration

-- First, update all agents to use 'http' adapter_type
UPDATE agents
SET adapter_type = 'http'
WHERE adapter_type IS NOT NULL;

-- Then, for agents where adapter_config is an empty array [], generate a proper HTTP adapter config
UPDATE agents
SET adapter_config = '{
  "url": "https://ecb3-102-132-198-101.ngrok-free.app/webhook",
  "model": "openrouter/qwen/qwen-3-6-plus",
  "api_key": "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",
  "provider": "openrouter",
  "maxIterations": 50,
  "persistSession": true
}'::jsonb
WHERE adapter_config = '[]'::jsonb;

-- Verify the updates
SELECT
    adapter_type,
    COUNT(*) as count
FROM agents
GROUP BY adapter_type
ORDER BY adapter_type;

-- Check how many agents had empty array configs that were updated
SELECT
    COUNT(*) as agents_with_empty_config_updated
FROM agents
WHERE adapter_config::text LIKE '%"url":%'; -- This will count agents that now have the proper config structure