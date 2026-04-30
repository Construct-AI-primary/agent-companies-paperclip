-- Script to populate agent_api_keys table with API keys for all agents
-- This generates API keys directly in the database

-- Function to generate a random API key (same format as Paperclip)
CREATE OR REPLACE FUNCTION generate_api_key()
RETURNS TEXT AS $$
BEGIN
  -- Generate 24 random bytes and convert to hex, prefix with 'pcp_'
  RETURN 'pcp_' || encode(gen_random_bytes(24), 'hex');
END;
$$ LANGUAGE plpgsql;

-- Insert API keys for all active agents that don't have keys
INSERT INTO agent_api_keys (
  agent_id,
  company_id,
  name,
  api_key,
  created_at
)
SELECT
  a.id as agent_id,
  a.company_id,
  'default' as name,
  generate_api_key() as api_key,
  NOW() as created_at
FROM agents a
WHERE a.status NOT IN ('pending_approval', 'terminated')
AND NOT EXISTS (
  SELECT 1 FROM agent_api_keys k
  WHERE k.agent_id = a.id
  AND k.revoked_at IS NULL
);

-- Show the results
SELECT
  'Generated API keys:' as info,
  COUNT(*) as total_keys_generated
FROM agent_api_keys
WHERE created_at >= NOW() - INTERVAL '1 minute';

-- Show all API keys with agent details
SELECT
  a.name as agent_name,
  a.company_id,
  k.api_key,
  k.created_at
FROM agent_api_keys k
JOIN agents a ON a.id = k.agent_id
WHERE k.revoked_at IS NULL
ORDER BY k.created_at DESC;