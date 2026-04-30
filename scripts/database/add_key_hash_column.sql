-- Step 1: Add key_hash column to agent_api_keys table
ALTER TABLE agent_api_keys ADD COLUMN IF NOT EXISTS key_hash TEXT;

-- Step 2: Create index on key_hash (run this separately after column is added)
-- CREATE INDEX IF NOT EXISTS agent_api_keys_key_hash_idx ON agent_api_keys (key_hash);

-- Step 3: Populate key_hash with SHA-256 hashes of existing api_key values
UPDATE agent_api_keys 
SET key_hash = encode(sha256(api_key::bytea), 'hex')
WHERE key_hash IS NULL AND api_key IS NOT NULL;

-- Step 4: Verify the update
SELECT COUNT(*) as total_keys, 
       COUNT(key_hash) as keys_with_hash,
       COUNT(api_key) as keys_with_plaintext
FROM agent_api_keys;
