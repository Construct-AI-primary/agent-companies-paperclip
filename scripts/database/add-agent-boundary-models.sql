-- ==========================================
-- Add Agent Boundary Models Script
-- Created: 2026-04-23
-- Description: Add model assignments for the 10 new agents from the QS vs Builder boundary redefinition
--              Uses the _add-agent-models-template.sql pattern
-- ==========================================

-- IMPORTANT: Run this script in a transaction for safety
BEGIN;

-- ==========================================
-- DOMAINFORGE AI AGENTS - MODEL ASSIGNMENTS
-- ==========================================

-- Cost Cassandra - Primary: qwen-max, Fallback: ernie-4.0-turbo
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'cost-cassandra-domainforge-qs',
  'qwen-max',
  'primary',
  1,
  0.1,
  6144,
  'system',
  'Primary model for cost database analysis and rate calculations',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'cost-cassandra-domainforge-qs',
  'ernie-4.0-turbo',
  'fallback',
  2,
  0.1,
  6144,
  'system',
  'Fallback model for cost analysis operations',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

-- Tender Theo - Primary: qwen-max, Fallback: ernie-4.0-turbo
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'tender-theo-domainforge-qs',
  'qwen-max',
  'primary',
  1,
  0.1,
  6144,
  'system',
  'Primary model for tender compilation and bid comparison',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'tender-theo-domainforge-qs',
  'ernie-4.0-turbo',
  'fallback',
  2,
  0.1,
  6144,
  'system',
  'Fallback model for tender operations',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

-- Variation Victor - Primary: qwen-max, Fallback: ernie-4.0-turbo
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'variation-victor-domainforge-qs',
  'qwen-max',
  'primary',
  1,
  0.1,
  6144,
  'system',
  'Primary model for variation order processing and valuation',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'variation-victor-domainforge-qs',
  'ernie-4.0-turbo',
  'fallback',
  2,
  0.1,
  6144,
  'system',
  'Fallback model for contract variation operations',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

-- Payment Penny - Primary: qwen-max, Fallback: ernie-4.0-turbo
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'payment-penny-domainforge-qs',
  'qwen-max',
  'primary',
  1,
  0.1,
  6144,
  'system',
  'Primary model for payment certificate validation and processing',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'payment-penny-domainforge-qs',
  'ernie-4.0-turbo',
  'fallback',
  2,
  0.1,
  6144,
  'system',
  'Fallback model for payment processing operations',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

-- Supplier Sam - Primary: qwen-max, Fallback: ernie-4.0-turbo
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'supplier-sam-domainforge-builder',
  'qwen-max',
  'primary',
  1,
  0.1,
  6144,
  'system',
  'Primary model for supplier price lookup and RFQ generation',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'supplier-sam-domainforge-builder',
  'ernie-4.0-turbo',
  'fallback',
  2,
  0.1,
  6144,
  'system',
  'Fallback model for supplier operations',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

-- Order Olivia - Primary: qwen-max, Fallback: ernie-4.0-turbo
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'order-olivia-domainforge-builder',
  'qwen-max',
  'primary',
  1,
  0.1,
  6144,
  'system',
  'Primary model for purchase order generation and tracking',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'order-olivia-domainforge-builder',
  'ernie-4.0-turbo',
  'fallback',
  2,
  0.1,
  6144,
  'system',
  'Fallback model for order management operations',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

-- Inventory Ian - Primary: qwen-max, Fallback: ernie-4.0-turbo
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'inventory-ian-domainforge-builder',
  'qwen-max',
  'primary',
  1,
  0.1,
  6144,
  'system',
  'Primary model for site inventory tracking and stock management',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'inventory-ian-domainforge-builder',
  'ernie-4.0-turbo',
  'fallback',
  2,
  0.1,
  6144,
  'system',
  'Fallback model for inventory operations',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

-- Delivery Dan - Primary: qwen-max, Fallback: ernie-4.0-turbo
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'delivery-dan-domainforge-builder',
  'qwen-max',
  'primary',
  1,
  0.1,
  6144,
  'system',
  'Primary model for delivery scheduling and logistics coordination',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'delivery-dan-domainforge-builder',
  'ernie-4.0-turbo',
  'fallback',
  2,
  0.1,
  6144,
  'system',
  'Fallback model for delivery logistics operations',
  true,
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

-- ==========================================
-- KNOWLEDGEFORGE AI AGENTS - MODEL ASSIGNMENTS
-- ==========================================

-- Measure Mentor - Primary: qwen-max, Fallback: ernie-4.0-turbo
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'measure-mentor-knowledgeforge-qs',
  'qwen-max',
  'primary',
  1,
  0.1,
  6144,
  'system',
  'Primary model for measurement best practices and lessons learned',
  true,
  'c4d52645-a0ea-4a26-b381-baf0b3042f34'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'measure-mentor-knowledgeforge-qs',
  'ernie-4.0-turbo',
  'fallback',
  2,
  0.1,
  6144,
  'system',
  'Fallback model for measurement knowledge operations',
  true,
  'c4d52645-a0ea-4a26-b381-baf0b3042f34'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

-- Rate Recorder - Primary: qwen-max, Fallback: ernie-4.0-turbo
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'rate-recorder-knowledgeforge-qs',
  'qwen-max',
  'primary',
  1,
  0.1,
  6144,
  'system',
  'Primary model for historical rate capture and trend analysis',
  true,
  'c4d52645-a0ea-4a26-b381-baf0b3042f34'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active,
  company_id
) VALUES (
  'rate-recorder-knowledgeforge-qs',
  'ernie-4.0-turbo',
  'fallback',
  2,
  0.1,
  6144,
  'system',
  'Fallback model for rate analysis operations',
  true,
  'c4d52645-a0ea-4a26-b381-baf0b3042f34'
)
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();

-- ==========================================
-- VERIFICATION QUERIES
-- ==========================================

-- Verify DomainForge AI model assignments
SELECT
  'DomainForge AI' as company,
  COUNT(*) as total_assignments
FROM agent_models
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND agent_id IN (
    'cost-cassandra-domainforge-qs',
    'tender-theo-domainforge-qs',
    'variation-victor-domainforge-qs',
    'payment-penny-domainforge-qs',
    'supplier-sam-domainforge-builder',
    'order-olivia-domainforge-builder',
    'inventory-ian-domainforge-builder',
    'delivery-dan-domainforge-builder'
  );

-- Verify KnowledgeForge AI model assignments
SELECT
  'KnowledgeForge AI' as company,
  COUNT(*) as total_assignments
FROM agent_models
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND agent_id IN (
    'measure-mentor-knowledgeforge-qs',
    'rate-recorder-knowledgeforge-qs'
  );

-- List all model assignments for new agents
SELECT
  c.name as company_name,
  am.agent_id,
  am.model_id,
  am.assignment_type,
  am.priority,
  am.is_active
FROM agent_models am
JOIN companies c ON am.company_id = c.id
WHERE am.agent_id IN (
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
ORDER BY c.name, am.agent_id, am.priority;

COMMIT;

-- ==========================================
-- SUCCESS MESSAGE
-- ==========================================

-- Script completed successfully!
-- Added model assignments for 10 new agents:
-- - 8 DomainForge AI agents (2 models each = 16 assignments)
-- - 2 KnowledgeForge AI agents (2 models each = 4 assignments)
-- Total: 20 model assignments added