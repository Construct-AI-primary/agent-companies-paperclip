-- Script to generate API keys for all agents that don't have them
-- This uses the same logic as the Paperclip application

-- First, let's see what agents exist and their current API key status
SELECT
    a.id,
    a.name,
    a.company_id,
    a.status,
    CASE WHEN k.id IS NOT NULL THEN 'HAS_KEY' ELSE 'NO_KEY' END as key_status,
    k.id as key_id,
    k.name as key_name
FROM agents a
LEFT JOIN agent_api_keys k ON k.agent_id = a.id AND k.revoked_at IS NULL
ORDER BY a.company_id, a.name;

-- Generate API keys for agents that don't have them
-- Note: This requires a PostgreSQL function to generate the tokens
-- Since we can't use Node.js crypto functions in pure SQL, we'll need to run this through the application

-- Alternative: Use the application's API endpoint
-- POST /agents/{agentId}/keys with body: {"name": "default"}

-- For bulk generation, you would need to:
-- 1. Query all agents without keys
-- 2. For each agent, call the createApiKey service method
-- 3. Store the returned tokens securely

-- Example of what the application does:
-- 1. Generate token: 'pcp_' + 48 hex characters (24 random bytes)
-- 2. Hash token: SHA256(token)
-- 3. Store hash in agent_api_keys.api_key column
-- 4. Return plain token to user (shown only once)

-- To run this manually, you would use the Paperclip UI or API:
-- For each agent without a key, go to the agent details page and click "Create API Key"