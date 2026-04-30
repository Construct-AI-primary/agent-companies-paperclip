-- ==========================================
-- Add Agent Boundary Agents Script
-- Created: 2026-04-23
-- Description: Add the 10 new agents for the QS vs Builder boundary redefinition
--              8 agents to DomainForge AI, 2 agents to KnowledgeForge AI
-- ==========================================

-- IMPORTANT: Run this script in a transaction for safety
BEGIN;

-- ==========================================
-- STEP 1: ADD AGENTS TO DOMAINFORGE AI (8 agents)
-- ==========================================

-- Cost Cassandra - Cost Database & Rate Analysis (QS)
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  created_at,
  updated_at,
  metadata,
  permissions,
  is_active
) VALUES (
  gen_random_uuid(),
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d', -- DomainForge AI
  'cost-cassandra-domainforge-qs',
  'specialist',
  'Cost Database & Rate Analysis Specialist',
  'Cost database management, rate analysis, historical cost data integration, tender pricing support, and cost estimation for quantity surveying workflows.',
  'active',
  (SELECT id FROM agents WHERE name = 'orion-domainforge-ceo' AND company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d' LIMIT 1),
  NOW(),
  NOW(),
  '{"team": "Operations", "specialization": "Cost Analysis", "workflow": "QS"}'::jsonb,
  '{"can_access_cost_data": true, "can_analyze_rates": true}'::jsonb,
  true
);

-- Tender Theo - Tender Compilation & Comparison (QS)
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  created_at,
  updated_at,
  metadata,
  permissions,
  is_active
) VALUES (
  gen_random_uuid(),
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d', -- DomainForge AI
  'tender-theo-domainforge-qs',
  'specialist',
  'Tender Compilation & Comparison Specialist',
  'Tender document compilation, tender comparison analysis, bid evaluation, and tender packaging for quantity surveying procurement processes.',
  'active',
  (SELECT id FROM agents WHERE name = 'orion-domainforge-ceo' AND company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d' LIMIT 1),
  NOW(),
  NOW(),
  '{"team": "Operations", "specialization": "Tender Management", "workflow": "QS"}'::jsonb,
  '{"can_compile_tenders": true, "can_compare_bids": true}'::jsonb,
  true
);

-- Variation Victor - Change Order Measurement & Valuation (QS)
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  created_at,
  updated_at,
  metadata,
  permissions,
  is_active
) VALUES (
  gen_random_uuid(),
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d', -- DomainForge AI
  'variation-victor-domainforge-qs',
  'specialist',
  'Change Order Measurement & Valuation Specialist',
  'Variation order processing, change order measurement, contract amendment valuation, and variation claim assessment for quantity surveying contract administration.',
  'active',
  (SELECT id FROM agents WHERE name = 'orion-domainforge-ceo' AND company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d' LIMIT 1),
  NOW(),
  NOW(),
  '{"team": "Operations", "specialization": "Contract Variations", "workflow": "QS"}'::jsonb,
  '{"can_process_variations": true, "can_value_changes": true}'::jsonb,
  true
);

-- Payment Penny - Interim Payment Certificate Processing (QS)
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  created_at,
  updated_at,
  metadata,
  permissions,
  is_active
) VALUES (
  gen_random_uuid(),
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d', -- DomainForge AI
  'payment-penny-domainforge-qs',
  'specialist',
  'Interim Payment Certificate Processing Specialist',
  'Payment certificate validation, subcontractor claim verification, progress payment processing, and retention calculations for quantity surveying financial administration.',
  'active',
  (SELECT id FROM agents WHERE name = 'orion-domainforge-ceo' AND company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d' LIMIT 1),
  NOW(),
  NOW(),
  '{"team": "Operations", "specialization": "Payment Processing", "workflow": "QS"}'::jsonb,
  '{"can_validate_payments": true, "can_process_certificates": true}'::jsonb,
  true
);

-- Supplier Sam - Supplier Price Lookup & RFQ Generation (Builder)
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  created_at,
  updated_at,
  metadata,
  permissions,
  is_active
) VALUES (
  gen_random_uuid(),
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d', -- DomainForge AI
  'supplier-sam-domainforge-builder',
  'specialist',
  'Supplier Price Lookup & RFQ Generation Specialist',
  'Supplier database integration, live price lookup, RFQ generation and distribution, supplier relationship management for builder procurement workflows.',
  'active',
  (SELECT id FROM agents WHERE name = 'orion-domainforge-ceo' AND company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d' LIMIT 1),
  NOW(),
  NOW(),
  '{"team": "Operations", "specialization": "Supplier Management", "workflow": "Builder"}'::jsonb,
  '{"can_lookup_prices": true, "can_generate_rfqs": true}'::jsonb,
  true
);

-- Order Olivia - Purchase Order Generation & Tracking (Builder)
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  created_at,
  updated_at,
  metadata,
  permissions,
  is_active
) VALUES (
  gen_random_uuid(),
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d', -- DomainForge AI
  'order-olivia-domainforge-builder',
  'specialist',
  'Purchase Order Generation & Tracking Specialist',
  'Purchase order creation, order tracking and monitoring, supplier communication, delivery scheduling coordination for builder procurement operations.',
  'active',
  (SELECT id FROM agents WHERE name = 'orion-domainforge-ceo' AND company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d' LIMIT 1),
  NOW(),
  NOW(),
  '{"team": "Operations", "specialization": "Order Management", "workflow": "Builder"}'::jsonb,
  '{"can_generate_orders": true, "can_track_deliveries": true}'::jsonb,
  true
);

-- Inventory Ian - Site Inventory & Stock Level Management (Builder)
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  created_at,
  updated_at,
  metadata,
  permissions,
  is_active
) VALUES (
  gen_random_uuid(),
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d', -- DomainForge AI
  'inventory-ian-domainforge-builder',
  'specialist',
  'Site Inventory & Stock Level Management Specialist',
  'Construction site inventory tracking, stock level monitoring, material reconciliation, shortage identification and reporting for builder site operations.',
  'active',
  (SELECT id FROM agents WHERE name = 'orion-domainforge-ceo' AND company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d' LIMIT 1),
  NOW(),
  NOW(),
  '{"team": "Operations", "specialization": "Inventory Management", "workflow": "Builder"}'::jsonb,
  '{"can_track_inventory": true, "can_monitor_stock": true}'::jsonb,
  true
);

-- Delivery Dan - Delivery Scheduling & Logistics Coordination (Builder)
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  created_at,
  updated_at,
  metadata,
  permissions,
  is_active
) VALUES (
  gen_random_uuid(),
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d', -- DomainForge AI
  'delivery-dan-domainforge-builder',
  'specialist',
  'Delivery Scheduling & Logistics Coordination Specialist',
  'Delivery scheduling optimization, logistics coordination, transportation management, site delivery coordination for builder construction operations.',
  'active',
  (SELECT id FROM agents WHERE name = 'orion-domainforge-ceo' AND company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d' LIMIT 1),
  NOW(),
  NOW(),
  '{"team": "Operations", "specialization": "Delivery Logistics", "workflow": "Builder"}'::jsonb,
  '{"can_schedule_deliveries": true, "can_coordinate_logistics": true}'::jsonb,
  true
);

-- ==========================================
-- STEP 2: ADD AGENTS TO KNOWLEDGEFORGE AI (2 agents)
-- ==========================================

-- Measure Mentor - Measurement Best Practices & Lessons Learned (QS)
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  created_at,
  updated_at,
  metadata,
  permissions,
  is_active
) VALUES (
  gen_random_uuid(),
  'c4d52645-a0ea-4a26-b381-baf0b3042f34', -- KnowledgeForge AI
  'measure-mentor-knowledgeforge-qs',
  'specialist',
  'Measurement Best Practices & Lessons Learned Specialist',
  'Institutional memory for measurement techniques, best practices documentation, common error patterns, efficient measurement methods, and lessons learned from past projects.',
  'active',
  (SELECT id FROM agents WHERE name = 'kfg-coordinator-guardian-id' AND company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34' LIMIT 1),
  NOW(),
  NOW(),
  '{"team": "Knowledge Engineering", "specialization": "Measurement Best Practices", "workflow": "QS"}'::jsonb,
  '{"can_document_practices": true, "can_share_lessons": true}'::jsonb,
  true
);

-- Rate Recorder - Historical Rate Capture & Trend Analysis (QS)
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  created_at,
  updated_at,
  metadata,
  permissions,
  is_active
) VALUES (
  gen_random_uuid(),
  'c4d52645-a0ea-4a26-b381-baf0b3042f34', -- KnowledgeForge AI
  'rate-recorder-knowledgeforge-qs',
  'specialist',
  'Historical Rate Capture & Trend Analysis Specialist',
  'Historical cost rate database management, rate trend analysis, market rate monitoring, cost escalation tracking, and early-stage estimating support.',
  'active',
  (SELECT id FROM agents WHERE name = 'kfg-coordinator-guardian-id' AND company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34' LIMIT 1),
  NOW(),
  NOW(),
  '{"team": "Knowledge Engineering", "specialization": "Rate Analysis", "workflow": "QS"}'::jsonb,
  '{"can_capture_rates": true, "can_analyze_trends": true}'::jsonb,
  true
);

-- ==========================================
-- STEP 3: VERIFICATION QUERIES
-- ==========================================

-- Verify DomainForge AI agents were added
SELECT
  'DomainForge AI' as company,
  COUNT(*) as total_agents
FROM agents
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d';

-- Verify KnowledgeForge AI agents were added
SELECT
  'KnowledgeForge AI' as company,
  COUNT(*) as total_agents
FROM agents
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34';

-- List all newly added agents
SELECT
  c.name as company_name,
  a.name as agent_name,
  a.title,
  a.metadata->>'workflow' as workflow_type
FROM agents a
JOIN companies c ON a.company_id = c.id
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
-- Added 10 new agents for QS vs Builder boundary redefinition:
-- - 8 agents to DomainForge AI (4 QS, 4 Builder)
-- - 2 agents to KnowledgeForge AI (measurement knowledge)