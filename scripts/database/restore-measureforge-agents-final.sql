-- ============================================================
-- MeasureForge AI Agent Restoration Script - FINAL VERSION
-- Created: 2026-04-22
-- Description: Restores the 21 correct MeasureForge AI agents
--              with proper database schema compliance
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

-- CAD Measurement Orchestrator (Team Lead)
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
  'coordinator',
  'Chief Measurement Orchestrator',
  'idle',
  'Coordinates CAD-based measurement workflows and integrates with AutoCAD/Civil3D systems for automated measurement extraction and validation.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["cad-integration", "measurement-orchestration"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": true, "can_assign_agents": true, "can_manage_budget": false}',
  12000,
  NOW(),
  NOW()
);

-- Measurement Coordination Specialist
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
  reports_to,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013',
  'measureforge-ai-measurement-coordination-specialist',
  'coordinator',
  'Senior Measurement Coordinator',
  'idle',
  'Specializes in cross-discipline measurement coordination, ensuring consistency across civil, electrical, mechanical, and structural measurements.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["measurement-coordination", "cross-discipline-integration"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": true, "can_assign_agents": false, "can_manage_budget": false}',
  11000,
  (SELECT id FROM agents WHERE name = 'measureforge-ai-cad-measurement-orchestrator' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
  NOW(),
  NOW()
);

-- ==========================================
-- STEP 3: REGISTER ELEMENT SPECIALISTS (11)
-- ==========================================

-- Architectural Element Specialist
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
  'measureforge-ai-architectural-element-specialist',
  'specialist',
  'Architectural Element Specialist',
  'idle',
  'Specializes in architectural element measurement, including walls, doors, windows, and building envelope components.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["architectural-measurement", "building-envelope"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  8000,
  NOW(),
  NOW()
);

-- Contour Analysis Specialist
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
  'measureforge-ai-contour-analysis-specialist',
  'specialist',
  'Contour Analysis Specialist',
  'idle',
  'Analyzes terrain contours and topographic features for earthwork calculations and site planning.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["contour-analysis", "topographic-measurement"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  8000,
  NOW(),
  NOW()
);

-- Cost Estimation Specialist
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
  'measureforge-ai-cost-estimation-specialist',
  'specialist',
  'Cost Estimation Specialist',
  'idle',
  'Provides cost estimation based on measured quantities, material requirements, and construction complexity.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["cost-estimation", "quantity-analysis"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  8000,
  NOW(),
  NOW());

-- Earthwork Calculation Specialist
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
  'measureforge-ai-earthwork-calculation-specialist',
  'specialist',
  'Earthwork Calculation Specialist',
  'idle',
  'Calculates cut/fill volumes, earthwork quantities, and site preparation requirements.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["earthwork-calculation", "volume-measurement"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  8000,
  NOW(),
  NOW());

-- Electrical Compliance Specialist
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
  'measureforge-ai-electrical-compliance-specialist',
  'specialist',
  'Electrical Compliance Specialist',
  'idle',
  'Ensures electrical measurements comply with local codes, standards, and safety requirements.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["electrical-compliance", "safety-standards"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  8000,
  NOW(),
  NOW());

-- Electrical Measurement Specialist
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
  'measureforge-ai-electrical-measurement-specialist',
  'specialist',
  'Electrical Measurement Specialist',
  'idle',
  'Specializes in electrical system measurements including cable lengths, conduit runs, and equipment quantities.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["electrical-measurement", "cable-calculations"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  8000,
  NOW(),
  NOW());

-- MEP Element Specialist
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
  'measureforge-ai-mep-element-specialist',
  'specialist',
  'MEP Element Specialist',
  'idle',
  'Handles mechanical, electrical, and plumbing (MEP) system measurements and coordination.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["mep-measurement", "system-coordination"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  8000,
  NOW(),
  NOW());

-- Quantity Surveyor Specialist
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
  'measureforge-ai-quantity-surveyor-specialist',
  'specialist',
  'Quantity Surveyor Specialist',
  'idle',
  'Professional quantity surveying for construction measurements, takeoffs, and cost planning.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["quantity-surveying", "cost-planning"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  8000,
  NOW(),
  NOW());

-- Structural Element Specialist
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
  'measureforge-ai-structural-element-specialist',
  'specialist',
  'Structural Element Specialist',
  'idle',
  'Specializes in structural element measurements including concrete, steel, and foundation components.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["structural-measurement", "concrete-steel-calculation"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  8000,
  NOW(),
  NOW());

-- Traffic Signal Compliance Specialist
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
  'measureforge-ai-traffic-signal-compliance-specialist',
  'specialist',
  'Traffic Signal Compliance Specialist',
  'idle',
  'Ensures traffic signal and ITS measurements comply with transportation standards and regulations.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["traffic-signal-compliance", "transportation-standards"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  8000,
  NOW(),
  NOW());

-- Traffic Signal Measurement Specialist
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
  'measureforge-ai-traffic-signal-measurement-specialist',
  'specialist',
  'Traffic Signal Measurement Specialist',
  'idle',
  'Specializes in traffic signal system measurements, including poles, controllers, and detection equipment.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["traffic-signal-measurement", "its-equipment"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  8000,
  NOW(),
  NOW());

-- ==========================================
-- STEP 4: REGISTER INTEGRATION SPECIALIST (1)
-- ==========================================

-- AutoCAD Integration Specialist
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
  'measureforge-ai-autocad-integration-specialist',
  'specialist',
  'AutoCAD Integration Specialist',
  'idle',
  'Integrates with AutoCAD and Civil3D for automated measurement extraction and validation workflows.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["autocad-integration", "civil3d-workflows"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  9000,
  NOW(),
  NOW());

-- ==========================================
-- STEP 5: REGISTER PROCUREMENT SPECIALISTS (2)
-- ==========================================

-- Contract Tender Specialist
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
  'measureforge-ai-contract-tender-specialist',
  'specialist',
  'Contract Tender Specialist',
  'idle',
  'Manages contract tender processes and procurement measurement requirements.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["contract-tender", "procurement-measurement"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  7000,
  NOW(),
  NOW());

-- Order Generation Specialist
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
  'measureforge-ai-order-generation-specialist',
  'specialist',
  'Order Generation Specialist',
  'idle',
  'Generates procurement orders and purchase requisitions based on measured quantities.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["order-generation", "purchase-requisitions"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  7000,
  NOW(),
  NOW());

-- ==========================================
-- STEP 6: REGISTER STANDARDS SPECIALISTS (2)
-- ==========================================

-- ASAQS Standards Specialist
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
  'measureforge-ai-asaqs-standards-specialist',
  'specialist',
  'ASAQS Standards Specialist',
  'idle',
  'Ensures compliance with ASAQS (Association of South African Quantity Surveyors) standards.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["asaqs-standards", "south-african-compliance"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  6000,
  NOW(),
  NOW());

-- SANS Standards Specialist
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
  'measureforge-ai-sans-standards-specialist',
  'specialist',
  'SANS Standards Specialist',
  'idle',
  'Ensures compliance with SANS (South African National Standards) for construction measurements.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["sans-standards", "national-standards-compliance"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  6000,
  NOW(),
  NOW());

-- ==========================================
-- STEP 7: REGISTER VALIDATOR AGENTS (3)
-- ==========================================

-- Electrical QA Specialist
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
  'measureforge-ai-electrical-qa-specialist',
  'specialist',
  'Electrical QA Specialist',
  'idle',
  'Quality assurance specialist for electrical measurements and compliance validation.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["electrical-qa", "compliance-validation"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  7500,
  NOW(),
  NOW());

-- Measurement Validation Specialist
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
  'measureforge-ai-measurement-validation-specialist',
  'specialist',
  'Measurement Validation Specialist',
  'idle',
  'Validates measurement accuracy, consistency, and compliance across all disciplines.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["measurement-validation", "accuracy-checking"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  7500,
  NOW(),
  NOW());

-- Visual Overlay Specialist
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
  'measureforge-ai-visual-overlay-specialist',
  'specialist',
  'Visual Overlay Specialist',
  'idle',
  'Provides visual overlays and annotations for measurement validation and quality control.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["visual-overlay", "annotation-tools"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  7500,
  NOW(),
  NOW());

-- ==========================================
-- STEP 8: CREATE AGENT API KEYS
-- ==========================================

-- Generate API keys for all restored agents
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
  CONCAT(a.name, ' API Key'),
  CONCAT('pcak_', encode(gen_random_bytes(32), 'hex')),
  encode(sha256(random()::text::bytea), 'hex'),
  NOW()
FROM agents a
WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL
  );

-- ==========================================
-- STEP 9: CREATE AGENT MODEL ASSIGNMENTS
-- ==========================================

-- Assign primary model (qwen-max) to all agents
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active
) SELECT
  a.id,
  'qwen-max',
  'primary',
  1,
  0.1,
  6144,
  'system',
  'Default model assignment for MeasureForge AI agents',
  true
FROM agents a
WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND a.is_active = true
ON CONFLICT (agent_id, model_id) DO NOTHING;

-- Assign fallback model (ernie-4.0-turbo) to all agents
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_by,
  reason,
  is_active
) SELECT
  a.id,
  'ernie-4.0-turbo',
  'fallback',
  2,
  0.1,
  6144,
  'system',
  'Fallback model assignment for MeasureForge AI agents',
  true
FROM agents a
WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND a.is_active = true
ON CONFLICT (agent_id, model_id) DO NOTHING;

-- ==========================================
-- STEP 10: VERIFICATION
-- ==========================================

-- Count restored agents
-- SELECT COUNT(*) as restored_agents FROM agents WHERE company_id = '550e8400-e29b-41d4-a716-446655440013';

-- List all restored agent names
-- SELECT name FROM agents WHERE company_id = '550e8400-e29b-41d4-a716-446655440013' ORDER BY name;

-- Verify API keys created
-- SELECT COUNT(*) as api_keys_created FROM agent_api_keys WHERE company_id = '550e8400-e29b-41d4-a716-446655440013' AND revoked_at IS NULL;

-- Verify model assignments created
-- SELECT COUNT(*) as model_assignments FROM agent_models WHERE agent_id IN (SELECT id FROM agents WHERE company_id = '550e8400-e29b-41d4-a716-446655440013') AND is_active = true;

-- Check for orphaned records (should be 0)
-- SELECT COUNT(*) FROM agent_api_keys WHERE agent_id NOT IN (SELECT id FROM agents);
-- SELECT COUNT(*) FROM agent_models WHERE agent_id NOT IN (SELECT id FROM agents);

-- ============================================================
-- Expected Results:
-- - 21 agents restored for MeasureForge AI
-- - All agents have correct names matching filesystem
-- - 21 API keys created (one per agent)
-- - 42 model assignments created (2 per agent: primary + fallback)
-- - Company registration successful
-- - No orphaned records in related tables
-- - Ready for immediate use
-- ============================================================
