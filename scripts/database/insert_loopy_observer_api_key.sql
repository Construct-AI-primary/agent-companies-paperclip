-- ============================================================================
-- INSERT API KEY FOR LOOPY AI OBSERVER AGENT
-- Generated: 2026-04-12
-- Purpose: Create missing API key for Observer agent
-- ============================================================================

-- Step 1: Verify the agent exists
SELECT 
    a.id as agent_id,
    a.name as agent_name,
    c.id as company_id,
    c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.name = 'Observer' 
  AND c.name = 'Loopy AI'
  AND a.is_active = true;

-- Step 2: Check if API key already exists
SELECT 
    aak.id,
    aak.name,
    aak.created_at,
    a.name as agent_name,
    c.name as company_name
FROM agent_api_keys aak
JOIN agents a ON aak.agent_id = a.id
JOIN companies c ON aak.company_id = c.id
WHERE a.name = 'Observer' 
  AND c.name = 'Loopy AI';

-- Step 3: Insert API key for Observer agent (if not already exists)
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash, created_at) VALUES (
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Observer' AND company_id = (SELECT id FROM companies WHERE name = 'Loopy AI') LIMIT 1),
    (SELECT id FROM companies WHERE name = 'Loopy AI' LIMIT 1),
    'Primary Key',
    encode(sha256(random()::text::bytea), 'hex'),
    NOW()
)
ON CONFLICT DO NOTHING;

-- Step 4: Verification - Show all Loopy AI agents and their API key status
SELECT 
    c.name as company,
    a.name as agent_name,
    a.is_active,
    CASE WHEN aak.id IS NULL THEN '✗ Missing API Key' ELSE '✓ Has API Key' END as status,
    aak.created_at as api_key_created
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.name = 'Loopy AI'
  AND a.is_active = true
ORDER BY a.name;
