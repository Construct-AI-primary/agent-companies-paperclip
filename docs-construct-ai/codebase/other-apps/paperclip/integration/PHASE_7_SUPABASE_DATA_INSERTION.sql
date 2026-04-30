-- =====================================================
-- Phase 7: Supabase Database Data Insertion
-- Gold Star Enterprise - OpenClaw Integration
-- Run this file to insert goals and skills data
-- NOTE: Companies and CEO agents already exist - skipped
-- Schema verified against actual Supabase schema (2026-04-04)
-- =====================================================

-- =====================================================
-- 2. Goals Table (company north-star goals)
-- =====================================================

-- DevForge AI Goal
INSERT INTO goals (
  id,
  company_id,
  title,
  description,
  level,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
  'Enterprise Infrastructure Excellence',
  'Build and maintain enterprise-grade development infrastructure supporting 1000+ concurrent workflows with 99.9% uptime',
  'company',
  'active',
  NOW(),
  NOW()
);

-- DomainForge AI Goal
INSERT INTO goals (
  id,
  company_id,
  title,
  description,
  level,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Multi-Discipline Engineering Solutions',
  'Deliver comprehensive multi-discipline engineering solutions with zero compliance violations across all engineering outputs',
  'company',
  'active',
  NOW(),
  NOW()
);

-- InfraForge AI Goal
INSERT INTO goals (
  id,
  company_id,
  title,
  description,
  level,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Infrastructure Backbone Services',
  'Provision and manage infrastructure backbone enabling sub-second latency for all team operations with 99.99% availability',
  'company',
  'active',
  NOW(),
  NOW()
);

-- Loopy AI Goal
INSERT INTO goals (
  id,
  company_id,
  title,
  description,
  level,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '0a40625e-78f9-4b0a-82e4-169a8befa021',
  'Creative AI Excellence',
  'Generate award-winning creative content achieving 95%+ stakeholder satisfaction across all creative deliverables',
  'company',
  'active',
  NOW(),
  NOW()
);

-- PromptForge AI Goal
INSERT INTO goals (
  id,
  company_id,
  title,
  description,
  level,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  'f02b83a8-e0db-4332-b507-22f85e71ebf5',
  'Prompt Engineering Orchestration',
  'Orchestrate prompt engineering excellence with 98%+ prompt quality score and zero ethical compliance violations',
  'company',
  'active',
  NOW(),
  NOW()
);

-- QualityForge AI Goal
INSERT INTO goals (
  id,
  company_id,
  title,
  description,
  level,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  'f535f9bc-00be-4b6d-9f53-c53abfacacef',
  'Quality Assurance Excellence',
  'Ensure 100% of deliverables pass quality gates with zero critical defects reaching production',
  'company',
  'active',
  NOW(),
  NOW()
);


-- =====================================================
-- 4. Company Skills Table
-- =====================================================

-- DevForge AI Skills
INSERT INTO company_skills (
  id,
  company_id,
  key,
  slug,
  name,
  description,
  markdown,
  source_type,
  source_locator,
  trust_level,
  compatibility,
  file_inventory,
  created_at,
  updated_at
) VALUES 
(gen_random_uuid(), 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4', 'nexus-devforge-ceo', 'nexus-devforge-ceo', 'Nexus - DevForge CEO', 'Enterprise development leadership, system architecture decisions, technical strategy, DevForge AI coordination', '# Nexus - DevForge CEO Skill

Enterprise development leadership and system architecture decisions.

## Capabilities
- Technical strategy and vision
- System architecture decisions
- Team coordination
- Board communication
', 'local_path', '/skills/devforge-ai/nexus-devforge-ceo/SKILL.md', 'markdown_only', 'compatible', '[]'::jsonb, NOW(), NOW()),
(gen_random_uuid(), 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4', 'orion-devforge-orchestrator', 'orion-devforge-orchestrator', 'Orion - DevForge Orchestrator', 'Task coordination, workflow orchestration, dependency management, performance monitoring, multi-agent orchestration', '# Orion - DevForge Orchestrator Skill

Task coordination and workflow orchestration.

## Capabilities
- Workflow orchestration
- Dependency management
- Performance monitoring
- Multi-agent coordination
', 'local_path', '/skills/devforge-ai/orion-devforge-orchestrator/SKILL.md', 'markdown_only', 'compatible', '[]'::jsonb, NOW(), NOW());

-- DomainForge AI Skills
INSERT INTO company_skills (
  id,
  company_id,
  key,
  slug,
  name,
  description,
  markdown,
  source_type,
  source_locator,
  trust_level,
  compatibility,
  file_inventory,
  created_at,
  updated_at
) VALUES 
(gen_random_uuid(), '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d', 'orion-domainforge-ceo', 'orion-domainforge-ceo', 'Orion - DomainForge CEO', 'Engineering leadership, multi-discipline coordination, civil engineering decisions, infrastructure engineering oversight', '# Orion - DomainForge CEO Skill

Engineering leadership and multi-discipline coordination.

## Capabilities
- Multi-disciplinary engineering orchestration
- Cross-functional team coordination
- Dependency management
- Engineering quality assurance
', 'local_path', '/skills/domainforge-ai/orion-domainforge-ceo/SKILL.md', 'markdown_only', 'compatible', '[]'::jsonb, NOW(), NOW());

-- InfraForge AI Skills
INSERT INTO company_skills (
  id,
  company_id,
  key,
  slug,
  name,
  description,
  markdown,
  source_type,
  source_locator,
  trust_level,
  compatibility,
  file_inventory,
  created_at,
  updated_at
) VALUES 
(gen_random_uuid(), '09f438a3-4041-46f2-b3cc-96fc9446e666', 'orchestrator-infraforge-ceo', 'orchestrator-infraforge-ceo', 'Orchestrator - InfraForge CEO', 'Infrastructure orchestration, database management, mobile API integration, supply chain system integration', '# Orchestrator - InfraForge CEO Skill

Infrastructure orchestration and system integration.

## Capabilities
- Infrastructure service orchestration
- System integration and API management
- Service dependency management
- Infrastructure performance optimization
', 'local_path', '/skills/infraforge-ai/orchestrator-infraforge-ceo/SKILL.md', 'markdown_only', 'compatible', '[]'::jsonb, NOW(), NOW());

-- Loopy AI Skills
INSERT INTO company_skills (
  id,
  company_id,
  key,
  slug,
  name,
  description,
  markdown,
  source_type,
  source_locator,
  trust_level,
  compatibility,
  file_inventory,
  created_at,
  updated_at
) VALUES 
(gen_random_uuid(), '0a40625e-78f9-4b0a-82e4-169a8befa021', 'vision-loopy-ceo', 'vision-loopy-ceo', 'Vision - Loopy CEO', 'Creative leadership, content strategy, marketing direction, creative technology implementation, user experience design', '# Vision - Loopy CEO Skill

Creative leadership and content strategy.

## Capabilities
- Creative AI strategy
- Content strategy and direction
- Marketing direction
- User experience design
', 'local_path', '/skills/loopy-ai/vision-loopy-ceo/SKILL.md', 'markdown_only', 'compatible', '[]'::jsonb, NOW(), NOW());

-- PromptForge AI Skills
INSERT INTO company_skills (
  id,
  company_id,
  key,
  slug,
  name,
  description,
  markdown,
  source_type,
  source_locator,
  trust_level,
  compatibility,
  file_inventory,
  created_at,
  updated_at
) VALUES 
(gen_random_uuid(), 'f02b83a8-e0db-4332-b507-22f85e71ebf5', 'sage-promptforge-chief-architect', 'sage-promptforge-chief-architect', 'Sage - PromptForge Chief Architect', 'Enterprise prompt engineering orchestration, multi-agent workflow design, ethical AI validation, cross-company coordination', '# Sage - PromptForge Chief Architect Skill

Enterprise prompt engineering orchestration.

## Capabilities
- Prompt architecture design
- Multi-agent workflow design
- Ethical AI validation
- Cross-company coordination
', 'local_path', '/skills/promptforge-ai/sage-promptforge-chief-architect/SKILL.md', 'markdown_only', 'compatible', '[]'::jsonb, NOW(), NOW());

-- QualityForge AI Skills
INSERT INTO company_skills (
  id,
  company_id,
  key,
  slug,
  name,
  description,
  markdown,
  source_type,
  source_locator,
  trust_level,
  compatibility,
  file_inventory,
  created_at,
  updated_at
) VALUES 
(gen_random_uuid(), 'f535f9bc-00be-4b6d-9f53-c53abfacacef', 'apex-qualityforge-ceo', 'apex-qualityforge-ceo', 'Apex - QualityForge CEO', 'Quality assurance leadership, code quality validation, testing oversight, quality gate enforcement', '# Apex - QualityForge CEO Skill

Quality assurance leadership and code quality validation.

## Capabilities
- Quality assurance leadership
- Code quality validation
- Testing oversight
- Quality gate enforcement
', 'local_path', '/skills/qualityforge-ai/apex-qualityforge-ceo/SKILL.md', 'markdown_only', 'compatible', '[]'::jsonb, NOW(), NOW());

-- =====================================================
-- 5. Shared Skills (available to all companies)
-- =====================================================

-- Note: Shared skills need a company_id. Insert for each company or use a designated shared company.
-- For now, inserting for DevForge AI as the primary technical company.
-- Adjust company_id as needed for your setup.

INSERT INTO company_skills (
  id,
  company_id,
  key,
  slug,
  name,
  description,
  markdown,
  source_type,
  source_locator,
  trust_level,
  compatibility,
  file_inventory,
  created_at,
  updated_at
) VALUES 
(gen_random_uuid(), 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4', 'cross-team-collaboration', 'cross-team-collaboration', 'Cross-Team Collaboration', 'Cross-company collaboration protocols and workflows for multi-agent coordination', '# Cross-Team Collaboration Skill

Protocols for cross-company collaboration.

## Usage
- Use when coordinating across multiple companies
- Follow established communication protocols
- Document all cross-team decisions
', 'local_path', '/skills/shared/cross-team-collaboration/SKILL.md', 'markdown_only', 'compatible', '[]'::jsonb, NOW(), NOW()),
(gen_random_uuid(), 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4', 'promptforge-integration-protocol', 'promptforge-integration-protocol', 'PromptForge Integration Protocol', 'Protocol for integrating with PromptForge AI as central orchestration hub', '# PromptForge Integration Protocol

Protocol for integrating with PromptForge AI.

## Usage
- Submit requirements to PromptForge
- Receive optimized prompts
- Validate prompt outputs
', 'local_path', '/skills/shared/promptforge-integration-protocol/SKILL.md', 'markdown_only', 'compatible', '[]'::jsonb, NOW(), NOW()),
(gen_random_uuid(), 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4', 'quality-validation-workflow', 'quality-validation-workflow', 'Quality Validation Workflow', 'Quality validation workflow for submitting outputs to QualityForge AI', '# Quality Validation Workflow

Protocol for submitting outputs to QualityForge AI.

## Usage
- Submit deliverables for quality review
- Address quality feedback
- Track quality metrics
', 'local_path', '/skills/shared/quality-validation-workflow/SKILL.md', 'markdown_only', 'compatible', '[]'::jsonb, NOW(), NOW()),
(gen_random_uuid(), 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4', 'memory-system-integration', 'memory-system-integration', 'Memory System Integration', 'Memory system integration across Gigabrain, OpenStinger, LCM, and PARA', '# Memory System Integration

Integration with the memory system stack.

## Components
- Gigabrain: Automatic knowledge capture
- OpenStinger: Cross-session pattern recognition
- LCM: Session continuity
- PARA: Knowledge organization
', 'local_path', '/skills/shared/memory-system-integration/SKILL.md', 'markdown_only', 'compatible', '[]'::jsonb, NOW(), NOW()),
(gen_random_uuid(), 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4', 'executive-escalation-protocol', 'executive-escalation-protocol', 'Executive Escalation Protocol', 'Executive escalation protocol for cross-company issues and conflicts', '# Executive Escalation Protocol

Protocol for escalating issues to executive level.

## Escalation Path
1. Team lead
2. Company CEO
3. Cross-company executive council
', 'local_path', '/skills/shared/executive-escalation-protocol/SKILL.md', 'markdown_only', 'compatible', '[]'::jsonb, NOW(), NOW());

-- =====================================================
-- Verification Queries
-- =====================================================

-- Verify Companies
SELECT id, name, status, issue_prefix, brand_color, is_active 
FROM companies 
WHERE is_active = true 
ORDER BY name;

-- Verify Goals
SELECT g.title, g.description, g.level, g.status, c.name as company
FROM goals g
JOIN companies c ON c.id = g.company_id
ORDER BY c.name;

-- Verify CEO Agents
SELECT a.name, a.title, a.role, c.name as company, a.status
FROM agents a
JOIN companies c ON c.id = a.company_id
WHERE a.reports_to IS NULL
ORDER BY c.name;

-- Verify Company Skills
SELECT cs.name, cs.key, cs.source_locator, c.name as company
FROM company_skills cs
JOIN companies c ON c.id = cs.company_id
ORDER BY c.name, cs.name;

-- =====================================================
-- Completion Message
-- =====================================================

DO $$
BEGIN
    RAISE NOTICE 'Phase 7: Supabase data insertion completed successfully.';
    RAISE NOTICE 'Goals: 6 inserted';
    RAISE NOTICE 'Company Skills: 12 inserted';
END $$;
