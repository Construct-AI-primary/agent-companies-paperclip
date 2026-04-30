-- ==========================================
-- Add Agent Boundary API Keys Script
-- Created: 2026-04-23
-- Description: Add API keys for the 10 new agents from the QS vs Builder boundary redefinition
--              Uses the _add-agent-api-keys-template.sql pattern
-- ==========================================

-- IMPORTANT: Run this script in a transaction for safety
BEGIN;

-- ==========================================
-- DOMAINFORGE AI AGENTS - API KEYS
-- ==========================================

-- Cost Cassandra - QS Cost Analysis
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) SELECT
  gen_random_uuid(),
  a.id,
  a.company_id,
  CONCAT(a.title, ' API Key'),
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),
  encode(sha256(random()::text::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND a.name = 'cost-cassandra-domainforge-qs'
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL
  )
LIMIT 1;

-- Tender Theo - QS Tender Management
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) SELECT
  gen_random_uuid(),
  a.id,
  a.company_id,
  CONCAT(a.title, ' API Key'),
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),
  encode(sha256(random()::text::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND a.name = 'tender-theo-domainforge-qs'
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL
  )
LIMIT 1;

-- Variation Victor - QS Contract Variations
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) SELECT
  gen_random_uuid(),
  a.id,
  a.company_id,
  CONCAT(a.title, ' API Key'),
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),
  encode(sha256(random()::text::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND a.name = 'variation-victor-domainforge-qs'
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL
  )
LIMIT 1;

-- Payment Penny - QS Payment Processing
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) SELECT
  gen_random_uuid(),
  a.id,
  a.company_id,
  CONCAT(a.title, ' API Key'),
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),
  encode(sha256(random()::text::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND a.name = 'payment-penny-domainforge-qs'
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL
  )
LIMIT 1;

-- Supplier Sam - Builder Supplier Management
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) SELECT
  gen_random_uuid(),
  a.id,
  a.company_id,
  CONCAT(a.title, ' API Key'),
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),
  encode(sha256(random()::text::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND a.name = 'supplier-sam-domainforge-builder'
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL
  )
LIMIT 1;

-- Order Olivia - Builder Order Management
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) SELECT
  gen_random_uuid(),
  a.id,
  a.company_id,
  CONCAT(a.title, ' API Key'),
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),
  encode(sha256(random()::text::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND a.name = 'order-olivia-domainforge-builder'
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL
  )
LIMIT 1;

-- Inventory Ian - Builder Inventory Management
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) SELECT
  gen_random_uuid(),
  a.id,
  a.company_id,
  CONCAT(a.title, ' API Key'),
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),
  encode(sha256(random()::text::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND a.name = 'inventory-ian-domainforge-builder'
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL
  )
LIMIT 1;

-- Delivery Dan - Builder Delivery Logistics
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) SELECT
  gen_random_uuid(),
  a.id,
  a.company_id,
  CONCAT(a.title, ' API Key'),
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),
  encode(sha256(random()::text::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND a.name = 'delivery-dan-domainforge-builder'
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL
  )
LIMIT 1;

-- ==========================================
-- KNOWLEDGEFORGE AI AGENTS - API KEYS
-- ==========================================

-- Measure Mentor - QS Measurement Knowledge
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) SELECT
  gen_random_uuid(),
  a.id,
  a.company_id,
  CONCAT(a.title, ' API Key'),
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),
  encode(sha256(random()::text::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND a.name = 'measure-mentor-knowledgeforge-qs'
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL
  )
LIMIT 1;

-- Rate Recorder - QS Rate Analysis Knowledge
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) SELECT
  gen_random_uuid(),
  a.id,
  a.company_id,
  CONCAT(a.title, ' API Key'),
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),
  encode(sha256(random()::text::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND a.name = 'rate-recorder-knowledgeforge-qs'
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL
  )
LIMIT 1;

-- ==========================================
-- VERIFICATION QUERIES
-- ==========================================

-- Verify DomainForge AI API keys were created
SELECT
  'DomainForge AI' as company,
  COUNT(*) as total_keys
FROM agent_api_keys
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND agent_id IN (
    SELECT id FROM agents WHERE name IN (
      'cost-cassandra-domainforge-qs',
      'tender-theo-domainforge-qs',
      'variation-victor-domainforge-qs',
      'payment-penny-domainforge-qs',
      'supplier-sam-domainforge-builder',
      'order-olivia-domainforge-builder',
      'inventory-ian-domainforge-builder',
      'delivery-dan-domainforge-builder'
    )
  )
  AND revoked_at IS NULL;

-- Verify KnowledgeForge AI API keys were created
SELECT
  'KnowledgeForge AI' as company,
  COUNT(*) as total_keys
FROM agent_api_keys
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND agent_id IN (
    SELECT id FROM agents WHERE name IN (
      'measure-mentor-knowledgeforge-qs',
      'rate-recorder-knowledgeforge-qs'
    )
  )
  AND revoked_at IS NULL;

-- List all API keys for new agents
SELECT
  c.name as company_name,
  a.name as agent_name,
  aak.name as key_name,
  aak.api_key,
  aak.created_at,
  aak.revoked_at
FROM agent_api_keys aak
JOIN agents a ON aak.agent_id = a.id
JOIN companies c ON aak.company_id = c.id
WHERE a.name IN (
  'cost-cassandra-domainforge-qs',
  'tender-theo-domainforge-qs',
  'variation-victor-domainforge-qs',
  'payment-penny-domainforge-qs',
  'supplier-sam-domainforge-builder',
  'order-olivia-domainforge-builder',
  'inventory-ian-domainforge-builder',
  'delivery-dan-domainforge-builder',
  'measure-mentor-knowledgeforge-qs',
  'rate-recorder-knowledgeforge-qs'
)
ORDER BY c.name, a.name;

COMMIT;

-- ==========================================
-- SUCCESS MESSAGE
-- ==========================================

-- Script completed successfully!
-- Added API keys for 10 new agents:
-- - 8 DomainForge AI agents (1 key each = 8 keys)
-- - 2 KnowledgeForge AI agents (1 key each = 2 keys)
-- Total: 10 API keys added