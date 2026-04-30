-- ============================================================
-- MeasureForge AI Agent Restoration Script - FIXED VERSION
-- Created: 2026-04-22
-- Description: Restores the 21 correct MeasureForge AI agents
--              after incorrect mass deletion
-- Prerequisites: Company exists with correct UUID
-- ============================================================

-- ==========================================
-- STEP 1: REGISTER THE 21 CORRECT AGENTS
-- ==========================================

-- First, ensure the company exists
INSERT INTO companies (
  id,
  name,
  description,
  status,
  issue_prefix,
  budget_monthly_cents,
  require_board_approval_for_new_agents,
  brand_color,
  created_at,
  updated_at
) VALUES (
  '550e8400-e29b-41d4-a716-446655440013',
  'MeasureForge AI',
  'AI-powered measurement and analytics platform for construction and engineering. Specializes in automated measurement validation, cross-discipline coordination, and intelligent analysis across civil, electrical, mechanical, and structural engineering domains.',
  'active',
  'MEAS',
  1000000,
  true,
  '#2563EB',
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  issue_prefix = EXCLUDED.issue_prefix,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  require_board_approval_for_new_agents = EXCLUDED.require_board_approval_for_new_agents,
  brand_color = EXCLUDED.brand_color,
  updated_at = NOW();

-- ==========================================
-- STEP 2: REGISTER COORDINATOR AGENTS (2)
-- ==========================================

-- CAD Measurement Orchestrator
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  budget_monthly_cents,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-cad-measurement-orchestrator',
  'specialist',
  'CAD Measurement Orchestrator',
  'idle',
  'Coordinates CAD-based measurement workflows and integrates with AutoCAD/Civil3D systems for automated measurement extraction and validation.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["cad-integration", "measurement-orchestration"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": true, "can_assign_agents": false, "can_manage_budget": false}',
  10000,
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- Measurement Coordination Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-measurement-coordination-specialist',
  'Specializes in cross-discipline measurement coordination, ensuring consistency across civil, electrical, mechanical, and structural measurements.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- ==========================================
-- STEP 3: REGISTER ELEMENT SPECIALISTS (11)
-- ==========================================

-- Architectural Element Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-architectural-element-specialist',
  'Specializes in architectural element measurement, including walls, doors, windows, and building envelope components.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- Contour Analysis Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-contour-analysis-specialist',
  'Analyzes terrain contours and topographic features for earthwork calculations and site planning.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- Cost Estimation Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-cost-estimation-specialist',
  'Provides cost estimation based on measured quantities, material requirements, and construction complexity.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- Earthwork Calculation Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-earthwork-calculation-specialist',
  'Calculates cut/fill volumes, earthwork quantities, and site preparation requirements.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- Electrical Compliance Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-electrical-compliance-specialist',
  'Ensures electrical measurements comply with local codes, standards, and safety requirements.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- Electrical Measurement Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-electrical-measurement-specialist',
  'Specializes in electrical system measurements including cable lengths, conduit runs, and equipment quantities.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- MEP Element Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-mep-element-specialist',
  'Handles mechanical, electrical, and plumbing (MEP) system measurements and coordination.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- Quantity Surveyor Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-quantity-surveyor-specialist',
  'Professional quantity surveying for construction measurements, takeoffs, and cost planning.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- Structural Element Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-structural-element-specialist',
  'Specializes in structural element measurements including concrete, steel, and foundation components.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- Traffic Signal Compliance Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-traffic-signal-compliance-specialist',
  'Ensures traffic signal and ITS measurements comply with transportation standards and regulations.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- Traffic Signal Measurement Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-traffic-signal-measurement-specialist',
  'Specializes in traffic signal system measurements, including poles, controllers, and detection equipment.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- ==========================================
-- STEP 4: REGISTER INTEGRATION SPECIALIST (1)
-- ==========================================

-- AutoCAD Integration Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-autocad-integration-specialist',
  'Integrates with AutoCAD and Civil3D for automated measurement extraction and validation workflows.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- ==========================================
-- STEP 5: REGISTER PROCUREMENT SPECIALISTS (2)
-- ==========================================

-- Contract Tender Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-contract-tender-specialist',
  'Manages contract tender processes and procurement measurement requirements.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- Order Generation Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-order-generation-specialist',
  'Generates procurement orders and purchase requisitions based on measured quantities.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- ==========================================
-- STEP 6: REGISTER STANDARDS SPECIALISTS (2)
-- ==========================================

-- ASAQS Standards Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-asaqs-standards-specialist',
  'Ensures compliance with ASAQS (Association of South African Quantity Surveyors) standards.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- SANS Standards Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-sans-standards-specialist',
  'Ensures compliance with SANS (South African National Standards) for construction measurements.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- ==========================================
-- STEP 7: REGISTER VALIDATOR AGENTS (3)
-- ==========================================

-- Electrical QA Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-electrical-qa-specialist',
  'Quality assurance specialist for electrical measurements and compliance validation.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- Measurement Validation Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-measurement-validation-specialist',
  'Validates measurement accuracy, consistency, and compliance across all disciplines.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- Visual Overlay Specialist
INSERT INTO agents (
  id,
  company_id,
  name,
  description,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-visual-overlay-specialist',
  'Provides visual overlays and annotations for measurement validation and quality control.',
  'active',
  NOW(),
  NOW()
) ON CONFLICT (company_id, name) DO NOTHING;

-- ==========================================
-- STEP 8: VERIFICATION
-- ==========================================

-- Count restored agents
-- SELECT COUNT(*) as restored_agents FROM agents WHERE company_id = '550e8400-e29b-41d4-a716-446655440013';

-- List all restored agent names
-- SELECT name FROM agents WHERE company_id = '550e8400-e29b-41d4-a716-446655440013' ORDER BY name;

-- ============================================================
-- Expected Results:
-- - 21 agents restored for MeasureForge AI
-- - All agents have correct names matching filesystem
-- - Company registration successful
-- - Ready for model assignments and API key generation
-- ============================================================