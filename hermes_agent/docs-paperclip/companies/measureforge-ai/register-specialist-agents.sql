-- ============================================================
-- MeasureForge AI Specialist Agents Registration
-- Created: 2026-04-22
-- Description: Registers 22 specialist agents from filesystem directories
-- Prerequisites: MeasureForge AI company must exist, tiered agents registered
-- Follows: Agent Table Reconciliation Plan Phase 4
-- ============================================================

-- Check if MeasureForge AI company exists before proceeding
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM companies WHERE name = 'MeasureForge AI') THEN
        RAISE EXCEPTION 'ERROR: MeasureForge AI company does not exist. Please run register-company.sql first.';
    END IF;
END $$;

-- ============================================================
-- COORDINATORS (2 agents)
-- ============================================================

-- CAD Measurement Orchestrator
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'orchestrator-measureforge',
  'coordinator',
  'CAD Measurement Orchestrator',
  'idle',
  'CAD measurement swarm orchestrator coordinating multi-agent measurement operations across CAD platforms. Manages element detection, quantity extraction, and standards compliance workflows.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 8192}'::jsonb,
  '{"max_concurrent_tasks": 10, "timeout_seconds": 3600}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  75000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'orchestrator-measureforge');

-- Measurement Coordination Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'coordination-measureforge',
  'specialist',
  'Measurement Coordination Specialist',
  'idle',
  'Measurement coordination specialist managing cross-discipline measurement workflows, task distribution, and synchronization between measurement agents.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 8, "timeout_seconds": 2400}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  60000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'coordination-measureforge');

-- ============================================================
-- ELEMENT SPECIALISTS (11 agents)
-- ============================================================

-- Architectural Element Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'arch-element-measureforge',
  'specialist',
  'Architectural Element Specialist',
  'idle',
  'Architectural element measurement specialist for doors, windows, partitions, finishes, and architectural building components.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'arch-element-measureforge');

-- Contour Analysis Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'contour-measureforge',
  'specialist',
  'Contour Analysis Specialist',
  'idle',
  'Contour analysis specialist for terrain modeling, elevation analysis, and topographic measurements.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'contour-measureforge');

-- Cost Estimation Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'cost-estimate-measureforge',
  'specialist',
  'Cost Estimation Specialist',
  'idle',
  'Cost estimation specialist for material quantity analysis, unit rate calculations, and preliminary cost planning.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'cost-estimate-measureforge');

-- Earthwork Calculation Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'earthwork-measureforge',
  'specialist',
  'Earthwork Calculation Specialist',
  'idle',
  'Earthwork calculation specialist for cut/fill calculations, volume computations, and site preparation measurements.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'earthwork-measureforge');

-- Electrical Compliance Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'elec-compliance-measureforge',
  'specialist',
  'Electrical Compliance Specialist',
  'idle',
  'Electrical compliance specialist for SANS standards validation, safety compliance, and regulatory adherence in electrical measurements.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'elec-compliance-measureforge');

-- Electrical Measurement Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'elec-measurement-measureforge',
  'specialist',
  'Electrical Measurement Specialist',
  'idle',
  'Electrical measurement specialist for power systems, conduit runs, cable lengths, and electrical infrastructure quantities.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'elec-measurement-measureforge');

-- MEP Element Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'mep-element-measureforge',
  'specialist',
  'MEP Element Specialist',
  'idle',
  'MEP (Mechanical, Electrical, Plumbing) element measurement specialist for HVAC, fire protection, and building services.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'mep-element-measureforge');

-- Quantity Surveyor Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'qs-specialist-measureforge',
  'specialist',
  'Quantity Surveyor Specialist',
  'idle',
  'Quantity surveying specialist for accurate quantity takeoffs, measurement rules application, and cost analysis per ASAQS standards.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'qs-specialist-measureforge');

-- Structural Element Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'structural-element-measureforge',
  'specialist',
  'Structural Element Specialist',
  'idle',
  'Structural element measurement specialist for beams, columns, foundations, and load-bearing components.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'structural-element-measureforge');

-- Traffic Signal Compliance Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'traffic-compliance-measureforge',
  'specialist',
  'Traffic Signal Compliance Specialist',
  'idle',
  'Traffic signal compliance specialist for regulatory validation, standards enforcement, and traffic engineering requirements.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'traffic-compliance-measureforge');

-- Traffic Signal Measurement Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'traffic-measurement-measureforge',
  'specialist',
  'Traffic Signal Measurement Specialist',
  'idle',
  'Traffic signal measurement specialist for intersection components, signal hardware, and transportation infrastructure quantities.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'traffic-measurement-measureforge');

-- ============================================================
-- INTEGRATION SPECIALISTS (1 agent)
-- ============================================================

-- AutoCAD Integration Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'autocad-measureforge',
  'specialist',
  'AutoCAD Integration Specialist',
  'idle',
  'AutoCAD integration specialist for DWG/DXF file processing, layer extraction, and CAD measurement automation.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'autocad-measureforge');

-- ============================================================
-- PROCUREMENT SPECIALISTS (2 agents)
-- ============================================================

-- Contract Tender Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'tender-measureforge',
  'specialist',
  'Contract Tender Specialist',
  'idle',
  'Contract tender specialist for tender document preparation, bill of quantities compilation, and procurement workflow support.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'tender-measureforge');

-- Order Generation Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'order-gen-measureforge',
  'specialist',
  'Order Generation Specialist',
  'idle',
  'Order generation specialist for procurement order creation, supplier integration, and 01900 workflow automation.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'order-gen-measureforge');

-- ============================================================
-- STANDARDS SPECIALISTS (2 agents)
-- ============================================================

-- ASAQS Standards Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'asaqs-measureforge',
  'specialist',
  'ASAQS Standards Specialist',
  'idle',
  'ASAQS (South African Quantity Surveying) standards specialist for measurement rules, coding standards, and professional practice requirements.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'asaqs-measureforge');

-- SANS Standards Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'sans-measureforge',
  'specialist',
  'SANS Standards Specialist',
  'idle',
  'SANS (South African National Standards) compliance specialist for regulatory validation, standards interpretation, and compliance monitoring.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'sans-measureforge');

-- ============================================================
-- VALIDATORS (3 agents)
-- ============================================================

-- Electrical QA Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'elec-qa-measureforge',
  'specialist',
  'Electrical QA Specialist',
  'idle',
  'Electrical quality assurance specialist for measurement validation, safety compliance verification, and quality control.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'elec-qa-measureforge');

-- Measurement Validation Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'validation-measureforge',
  'specialist',
  'Measurement Validation Specialist',
  'idle',
  'Measurement validation specialist for accuracy verification, discrepancy detection, and quality assurance frameworks.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'validation-measureforge');

-- Visual Overlay Specialist
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'visual-overlay-measureforge',
  'specialist',
  'Visual Overlay Specialist',
  'idle',
  'Visual overlay specialist for audit trail generation, compliance visualization, and non-destructive measurement overlays.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'visual-overlay-measureforge');

-- ============================================================
-- CREATORS (1 agent)
-- ============================================================

-- Atlas Agent Creator
INSERT INTO agents (
  id, company_id, name, role, title, status, capabilities,
  adapter_type, adapter_config, runtime_config, permissions,
  budget_monthly_cents, created_at, updated_at
) SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'atlas-measureforge',
  'creator',
  'Atlas Agent Creator',
  'idle',
  'Atlas agent creator for automated agent generation, skill assignment, and measurement agent instantiation.',
  'hermes_local',
  '{"model": "qwen-max", "temperature": 0.1, "max_tokens": 6144}'::jsonb,
  '{"max_concurrent_tasks": 6, "timeout_seconds": 1800}'::jsonb,
  '{"execute": {"automation_engine": "hermes_local"}, "orchestrate": {"company_projects": ["measureforge-ai"]}}'::jsonb,
  55000,
  '2026-04-22T12:00:00.000Z',
  '2026-04-22T12:00:00.000Z'
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'atlas-measureforge');

-- ============================================================
-- VERIFICATION
-- ============================================================

-- Count registered specialist agents
DO $$
DECLARE
    specialist_count INTEGER;
    total_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO specialist_count
    FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'MeasureForge AI'
      AND a.name LIKE '%-measureforge';
    
    SELECT COUNT(*) INTO total_count
    FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'MeasureForge AI';
    
    RAISE NOTICE 'MeasureForge AI Agent Registration Summary:';
    RAISE NOTICE '  - Specialist agents registered: %', specialist_count;
    RAISE NOTICE '  - Total agents in company: %', total_count;
    RAISE NOTICE '  - Expected: 32 (10 tiered + 22 specialist)';
END $$;
