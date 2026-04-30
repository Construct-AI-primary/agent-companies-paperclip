-- ==========================================
-- Fix MeasureForge AI Agents - Remove Duplicates & Add Human Titles
-- Created: 2026-04-23
-- Description: Removes duplicates and updates all MeasureForge AI agents
--              with proper human-readable titles
-- ==========================================

-- Step 1: Remove all existing MeasureForge agents and related data
DELETE FROM agent_runtime_state
WHERE agent_id::text IN (
  SELECT id::text FROM agents
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
);

DELETE FROM agent_api_keys
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013';

-- Delete agent_models using agent NAME (TEXT), not UUID
DELETE FROM agent_models
WHERE agent_id IN (
  SELECT name FROM agents
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
);

DELETE FROM agents
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013';

-- Step 2: Restore agents with proper human-readable titles

-- CEO (1 agent)
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
  'Nexus the Visionary CEO',
  'ceo',
  'Nexus the Visionary CEO',
  'idle',
  'Chief Executive Officer overseeing all MeasureForge AI operations, strategy, and cross-company coordination. Leads the measurement intelligence platform vision and ensures alignment with organizational goals.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["strategic-leadership", "cross-company-coordination", "platform-vision"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": true, "can_assign_agents": true, "can_manage_budget": true}',
  15000,
  NULL,
  NOW(),
  NOW()
);

-- COORDINATORS (2 agents)
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
  'Max the Measurement Maestro',
  'coordinator',
  'Max the Measurement Maestro',
  'idle',
  'Coordinates CAD-based measurement workflows and integrates with AutoCAD/Civil3D systems for automated measurement extraction and validation.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["cad-integration", "measurement-orchestration"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": true, "can_assign_agents": true, "can_manage_budget": false}',
  12000,
  (SELECT id FROM agents WHERE name = 'Nexus the Visionary CEO' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
  NOW(),
  NOW()
);

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
  'Luna the Coordination Queen',
  'coordinator',
  'Luna the Coordination Queen',
  'idle',
  'Specializes in cross-discipline measurement coordination, ensuring consistency across civil, electrical, mechanical, and structural measurements.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["measurement-coordination", "cross-discipline-integration"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": true, "can_assign_agents": false, "can_manage_budget": false}',
  11000,
  (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
  NOW(),
  NOW()
);

-- ELEMENT SPECIALISTS (11 agents) - Report to Max the Measurement Maestro
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
) VALUES
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Archie the Building Buddy',
    'specialist',
    'Archie the Building Buddy',
    'idle',
    'Specializes in architectural element measurement, including walls, doors, windows, and building envelope components.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["architectural-measurement", "building-envelope"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    8000,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  ),
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Terra the Topo Titan',
    'specialist',
    'Terra the Topo Titan',
    'idle',
    'Analyzes terrain contours and topographic features for earthwork calculations and site planning.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["contour-analysis", "topographic-measurement"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    8000,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  ),
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Cash the Calculator King',
    'specialist',
    'Cash the Calculator King',
    'idle',
    'Provides cost estimation based on measured quantities, material requirements, and construction complexity.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["cost-estimation", "quantity-analysis"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    8000,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  ),
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Diggs the Dirt Dynamo',
    'specialist',
    'Diggs the Dirt Dynamo',
    'idle',
    'Calculates cut/fill volumes, earthwork quantities, and site preparation requirements.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["earthwork-calculation", "volume-measurement"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    8000,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  ),
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Sparky the Safety Sentinel',
    'specialist',
    'Sparky the Safety Sentinel',
    'idle',
    'Ensures electrical measurements comply with local codes, standards, and safety requirements.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["electrical-compliance", "safety-standards"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    8000,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  ),
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Volty the Voltage Virtuoso',
    'specialist',
    'Volty the Voltage Virtuoso',
    'idle',
    'Specializes in electrical system measurements including cable lengths, conduit runs, and equipment quantities.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["electrical-measurement", "cable-calculations"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    8000,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  ),
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Pipes the Plumbing Pro',
    'specialist',
    'Pipes the Plumbing Pro',
    'idle',
    'Handles mechanical, electrical, and plumbing (MEP) system measurements and coordination.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["mep-measurement", "system-coordination"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    8000,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  ),
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Quinn the Quantity Queen',
    'specialist',
    'Quinn the Quantity Queen',
    'idle',
    'Professional quantity surveying for construction measurements, takeoffs, and cost planning.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["quantity-surveying", "cost-planning"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    8000,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  ),
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Steel the Structure Sultan',
    'specialist',
    'Steel the Structure Sultan',
    'idle',
    'Specializes in structural element measurements including concrete, steel, and foundation components.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["structural-measurement", "concrete-steel-calculation"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    8000,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  ),
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Lighty the Signal Sorcerer',
    'specialist',
    'Lighty the Signal Sorcerer',
    'idle',
    'Ensures traffic signal and ITS measurements comply with transportation standards and regulations.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["traffic-signal-compliance", "transportation-standards"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    8000,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  ),
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Flash the Traffic Flashmaster',
    'specialist',
    'Flash the Traffic Flashmaster',
    'idle',
    'Specializes in traffic signal system measurements, including poles, controllers, and detection equipment.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["traffic-signal-measurement", "its-equipment"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    8000,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  );

-- INTEGRATION SPECIALIST (1 agent)
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
  'Caddy the CAD Commander',
  'specialist',
  'Caddy the CAD Commander',
  'idle',
  'Integrates with AutoCAD and Civil3D for automated measurement extraction and validation workflows.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["autocad-integration", "civil3d-workflows"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
  '{"max_iterations": 50, "timeout_seconds": 300}',
  '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
  9000,
  (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
  NOW(),
  NOW()
);

-- PROCUREMENT SPECIALISTS (2 agents)
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
) VALUES
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Biddo the Tender Titan',
    'specialist',
    'Biddo the Tender Titan',
    'idle',
    'Manages contract tender processes and procurement measurement requirements.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["contract-tender", "procurement-measurement"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    7000,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  ),
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Orderly the Order Oracle',
    'specialist',
    'Orderly the Order Oracle',
    'idle',
    'Generates procurement orders and purchase requisitions based on measured quantities.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["order-generation", "purchase-requisitions"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    7000,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  );

-- STANDARDS SPECIALISTS (2 agents)
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
) VALUES
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Ruley the Standards Sultan',
    'specialist',
    'Ruley the Standards Sultan',
    'idle',
    'Ensures compliance with ASAQS (Association of South African Quantity Surveyors) standards.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["asaqs-standards", "south-african-compliance"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    6000,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  ),
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Codey the Compliance King',
    'specialist',
    'Codey the Compliance King',
    'idle',
    'Ensures compliance with SANS (South African National Standards) for construction measurements.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["sans-standards", "national-standards-compliance"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    6000,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  );

-- VALIDATOR AGENTS (3 agents)
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
) VALUES
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Zap the QA Wizard',
    'specialist',
    'Zap the QA Wizard',
    'idle',
    'Quality assurance specialist for electrical measurements and compliance validation.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["electrical-qa", "compliance-validation"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    7500,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  ),
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Checky the Validation Chief',
    'specialist',
    'Checky the Validation Chief',
    'idle',
    'Validates measurement accuracy, consistency, and compliance across all disciplines.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["measurement-validation", "accuracy-checking"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    7500,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  ),
  (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440013',
    'Vizzy the Visual Virtuoso',
    'specialist',
    'Vizzy the Visual Virtuoso',
    'idle',
    'Provides visual overlays and annotations for measurement validation and quality control.',
    'hermes_local',
    '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144, "skills": ["visual-overlay", "annotation-tools"], "endpoints": {"primary": "hermes_local", "fallback": "ernie-4.0-turbo"}}',
    '{"max_iterations": 50, "timeout_seconds": 300}',
    '{"can_create_issues": false, "can_assign_agents": false, "can_manage_budget": false}',
    7500,
    (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1),
    NOW(),
    NOW()
  );

-- Step 3: Create API keys for all agents
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
WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND a.is_active = true
  AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak
    WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL
  );

-- Step 4: Create model assignments for all agents
-- PRIMARY model assignments (uses agent NAME as agent_id)
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
) SELECT
  a.name,                    -- agent_id is TEXT (agent name)
  'qwen-max',
  'primary',
  1,
  0.1,
  6144,
  'system',
  CONCAT('Primary model assignment for ', a.title),
  true,
  a.company_id
FROM agents a
WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND a.is_active = true
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  company_id = EXCLUDED.company_id,
  updated_at = NOW();

-- FALLBACK model assignments (uses agent NAME as agent_id)
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
) SELECT
  a.name,                    -- agent_id is TEXT (agent name)
  'ernie-4.0-turbo',
  'fallback',
  2,
  0.1,
  6144,
  'system',
  CONCAT('Fallback model assignment for ', a.title),
  true,
  a.company_id
FROM agents a
WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND a.is_active = true
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET
  model_id = EXCLUDED.model_id,
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  reason = EXCLUDED.reason,
  is_active = EXCLUDED.is_active,
  company_id = EXCLUDED.company_id,
  updated_at = NOW();

-- Step 5: Set reports_to hierarchy for all specialists
UPDATE agents SET reports_to = (SELECT id FROM agents WHERE name = 'Max the Measurement Maestro' AND company_id = '550e8400-e29b-41d4-a716-446655440013' LIMIT 1)
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND role = 'specialist'
  AND reports_to IS NULL;

-- Step 6: Update titles (in case INSERT didn't work)
UPDATE agents SET title = 'Chief Measurement Orchestrator' WHERE name = 'measureforge-ai-cad-measurement-orchestrator' AND company_id = '550e8400-e29b-41d4-a716-446655440013';
UPDATE agents SET title = 'Senior Measurement Coordinator' WHERE name = 'measureforge-ai-measurement-coordination-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';

-- ELEMENT SPECIALISTS
UPDATE agents SET title = 'Architectural Element Specialist' WHERE name = 'measureforge-ai-architectural-element-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';
UPDATE agents SET title = 'Terrain Analysis Specialist' WHERE name = 'measureforge-ai-contour-analysis-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';
UPDATE agents SET title = 'Cost Analysis Specialist' WHERE name = 'measureforge-ai-cost-estimation-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';
UPDATE agents SET title = 'Earthwork Calculation Specialist' WHERE name = 'measureforge-ai-earthwork-calculation-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';
UPDATE agents SET title = 'Electrical Compliance Specialist' WHERE name = 'measureforge-ai-electrical-compliance-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';
UPDATE agents SET title = 'Electrical Systems Specialist' WHERE name = 'measureforge-ai-electrical-measurement-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';
UPDATE agents SET title = 'MEP Systems Specialist' WHERE name = 'measureforge-ai-mep-element-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';
UPDATE agents SET title = 'Quantity Surveying Specialist' WHERE name = 'measureforge-ai-quantity-surveyor-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';
UPDATE agents SET title = 'Structural Engineering Specialist' WHERE name = 'measureforge-ai-structural-element-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';
UPDATE agents SET title = 'Traffic Signal Compliance Specialist' WHERE name = 'measureforge-ai-traffic-signal-compliance-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';
UPDATE agents SET title = 'Traffic Signal Measurement Specialist' WHERE name = 'measureforge-ai-traffic-signal-measurement-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';

-- INTEGRATION SPECIALIST
UPDATE agents SET title = 'CAD Integration Specialist' WHERE name = 'measureforge-ai-autocad-integration-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';

-- PROCUREMENT SPECIALISTS
UPDATE agents SET title = 'Contract Tender Specialist' WHERE name = 'measureforge-ai-contract-tender-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';
UPDATE agents SET title = 'Procurement Order Specialist' WHERE name = 'measureforge-ai-order-generation-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';

-- STANDARDS SPECIALISTS
UPDATE agents SET title = 'ASAQS Standards Specialist' WHERE name = 'measureforge-ai-asaqs-standards-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';
UPDATE agents SET title = 'SANS Standards Specialist' WHERE name = 'measureforge-ai-sans-standards-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';

-- VALIDATOR AGENTS
UPDATE agents SET title = 'Electrical Quality Assurance Specialist' WHERE name = 'measureforge-ai-electrical-qa-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';
UPDATE agents SET title = 'Measurement Validation Specialist' WHERE name = 'measureforge-ai-measurement-validation-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';
UPDATE agents SET title = 'Visual Analysis Specialist' WHERE name = 'measureforge-ai-visual-overlay-specialist' AND company_id = '550e8400-e29b-41d4-a716-446655440013';

-- Step 5: Verification
SELECT
  COUNT(*) as total_agents,
  COUNT(CASE WHEN role = 'coordinator' THEN 1 END) as coordinators,
  COUNT(CASE WHEN role = 'specialist' THEN 1 END) as specialists
FROM agents
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013';

SELECT
  title,
  role,
  reports_to IS NOT NULL as has_manager
FROM agents
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
ORDER BY role, title;

-- Additional Verification Queries

-- Check API keys were created
SELECT
  'API Keys Created' as verification_check,
  COUNT(*) as count
FROM agent_api_keys aak
JOIN agents a ON aak.agent_id = a.id
WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND aak.revoked_at IS NULL;

-- Check model assignments were created
SELECT
  'Model Assignments' as verification_check,
  assignment_type,
  COUNT(*) as count
FROM agent_models am
WHERE am.agent_id IN (
  SELECT name FROM agents 
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
)
GROUP BY assignment_type
ORDER BY assignment_type;

-- Check organizational hierarchy
SELECT
  'Agents with Managers' as hierarchy_check,
  COUNT(*) as count
FROM agents
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND reports_to IS NOT NULL;

-- Check for duplicate names (should be 0)
SELECT
  'Duplicate Agent Names' as duplicate_check,
  COUNT(*) as duplicate_count
FROM (
  SELECT name, COUNT(*) as cnt
  FROM agents
  WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  GROUP BY name
  HAVING COUNT(*) > 1
) duplicates;

-- Verify human-readable titles
SELECT
  'Agents with Human Titles' as title_check,
  COUNT(*) as count
FROM agents
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title IS NOT NULL
  AND title != ''
  AND title NOT LIKE '%measureforge-ai%'; -- Should not contain technical names
