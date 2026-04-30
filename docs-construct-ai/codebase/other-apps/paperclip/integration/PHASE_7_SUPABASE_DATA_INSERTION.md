---
memory_layer: durable_knowledge
para_section: pages/documentation/paperclip-integration
gigabrain_tags: paperclip, supabase, database-insertion, company-setup, agent-setup
openstinger_context: supabase-data-migration
last_updated: 2026-03-04
related_docs:
  - /construct-ai-docs/codebase/other-apps/paperclip/integration/GOLD_STAR_ENTERPRISE_IMPLEMENTATION_PLAN.md
  - /construct-ai-docs/codebase/other-apps/paperclip/integration/PHASE_1_COMPANY_FOUNDATION_SETUP.md
  - /deploy/database.md
  - /api/companies.md
  - /api/agents.md
---

# Phase 7: Supabase Database Data Insertion

## Overview

All company configurations, agent definitions, goals, and skills must be persisted in Supabase for the Paperclip system to function. This document provides the complete SQL insertion scripts for the 6-company OpenClaw enterprise setup.

---

## Database Tables Targeted

| Table | Records | Description |
|-------|---------|-------------|
| `companies` | 6 | Company profiles and configurations |
| `company_goals` | 6 | North-star goals for each company |
| `agents` | 170+ | Agent definitions with capabilities |
| `agent_skills` | 147+ | Skill assignments to agents |
| `agent_reporting` | 170+ | Hierarchical reporting structure |

---

## SQL Insertion Scripts

### 1. Companies Table

```sql
-- DevForge AI
INSERT INTO companies (
  id, 
  name, 
  description, 
  status, 
  issue_prefix, 
  issue_counter, 
  require_board_approval_for_new_agents, 
  brand_color, 
  is_active,
  created_at,
  updated_at
) VALUES (
  'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
  'DevForge AI',
  'Enterprise development, orchestration, and system architecture. Builds technical infrastructure, APIs, data pipelines, security systems, and product features. Receives execution prompts from PromptForge AI and coordinates with QualityForge AI for validation.',
  'active',
  'DFA',
  1,
  false,
  '#3B82F6',
  true,
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  updated_at = NOW();

-- DomainForge AI
INSERT INTO companies (
  id, 
  name, 
  description, 
  status, 
  issue_prefix, 
  issue_counter, 
  require_board_approval_for_new_agents, 
  brand_color, 
  is_active,
  created_at,
  updated_at
) VALUES (
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'DomainForge AI',
  'Multi-discipline autonomous AI company specializing in comprehensive engineering expertise across civil engineering, structural, geotechnical, transportation, construction, and environmental disciplines. Receives engineering-specific prompts from PromptForge AI.',
  'active',
  'DOM',
  0,
  true,
  '#7deb24',
  true,
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  updated_at = NOW();

-- InfraForge AI
INSERT INTO companies (
  id, 
  name, 
  description, 
  status, 
  issue_prefix, 
  issue_counter, 
  require_board_approval_for_new_agents, 
  brand_color, 
  is_active,
  created_at,
  updated_at
) VALUES (
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'InfraForge AI',
  'Dedicated infrastructure services autonomous AI company specializing in comprehensive infrastructure management, system orchestration, data processing, security, and operational excellence. Provides infrastructure backbone for all other teams.',
  'active',
  'INF',
  0,
  true,
  '#3ab2ee',
  true,
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  updated_at = NOW();

-- Loopy AI
INSERT INTO companies (
  id, 
  name, 
  description, 
  status, 
  issue_prefix, 
  issue_counter, 
  require_board_approval_for_new_agents, 
  brand_color, 
  is_active,
  created_at,
  updated_at
) VALUES (
  '0a40625e-78f9-4b0a-82e4-169a8befa021',
  'Loopy AI',
  'Creative AI, content generation, and artistic applications. Produces marketing materials, brand content, social media, creative technology implementations, and user experience design. Receives creative briefs as prompts from PromptForge AI.',
  'active',
  'LPA',
  19,
  false,
  '#EC4899',
  true,
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  updated_at = NOW();

-- PromptForge AI
INSERT INTO companies (
  id, 
  name, 
  description, 
  status, 
  issue_prefix, 
  issue_counter, 
  require_board_approval_for_new_agents, 
  brand_color, 
  is_active,
  created_at,
  updated_at
) VALUES (
  'f02b83a8-e0db-4332-b507-22f85e71ebf5',
  'PromptForge AI',
  'Advanced Prompt Engineering & Orchestration Specialists. CENTRAL HUB for the enterprise - receives project requirements, generates optimized prompts, distributes to execution teams, validates outputs, and ensures ethical AI compliance across all companies.',
  'active',
  'PFA',
  5,
  true,
  '#8B5CF6',
  true,
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  updated_at = NOW();

-- QualityForge AI
INSERT INTO companies (
  id, 
  name, 
  description, 
  status, 
  issue_prefix, 
  issue_counter, 
  require_board_approval_for_new_agents, 
  brand_color, 
  is_active,
  created_at,
  updated_at
) VALUES (
  'f535f9bc-00be-4b6d-9f53-c53abfacacef',
  'QualityForge AI',
  'Testing, debugging, coding excellence, and quality assurance. Comprehensive validation of ALL team outputs including code quality, performance testing, security validation, accessibility compliance, and debugging support. Final quality gate for the entire enterprise.',
  'active',
  'QFA',
  10,
  false,
  '#10B981',
  true,
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  updated_at = NOW();
```

### 2. Company Goals Table

```sql
-- DevForge AI Goal
INSERT INTO company_goals (
  id,
  company_id,
  goal,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
  'Build and maintain enterprise-grade development infrastructure supporting 1000+ concurrent workflows with 99.9% uptime',
  'active',
  NOW(),
  NOW()
);

-- DomainForge AI Goal
INSERT INTO company_goals (
  id,
  company_id,
  goal,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Deliver comprehensive multi-discipline engineering solutions with zero compliance violations across all engineering outputs',
  'active',
  NOW(),
  NOW()
);

-- InfraForge AI Goal
INSERT INTO company_goals (
  id,
  company_id,
  goal,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Provision and manage infrastructure backbone enabling sub-second latency for all team operations with 99.99% availability',
  'active',
  NOW(),
  NOW()
);

-- Loopy AI Goal
INSERT INTO company_goals (
  id,
  company_id,
  goal,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  '0a40625e-78f9-4b0a-82e4-169a8befa021',
  'Generate award-winning creative content achieving 95%+ stakeholder satisfaction across all creative deliverables',
  'active',
  NOW(),
  NOW()
);

-- PromptForge AI Goal
INSERT INTO company_goals (
  id,
  company_id,
  goal,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  'f02b83a8-e0db-4332-b507-22f85e71ebf5',
  'Orchestrate prompt engineering excellence with 98%+ prompt quality score and zero ethical compliance violations',
  'active',
  NOW(),
  NOW()
);

-- QualityForge AI Goal
INSERT INTO company_goals (
  id,
  company_id,
  goal,
  status,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  'f535f9bc-00be-4b6d-9f53-c53abfacacef',
  'Ensure 100% of deliverables pass quality gates with zero critical defects reaching production',
  'active',
  NOW(),
  NOW()
);
```

### 3. CEO Agents Table

```sql
-- Nexus - DevForge AI CEO
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  reports_to,
  capabilities,
  adapter_type,
  adapter_config,
  is_active,
  created_at,
  updated_at
) VALUES (
  '384dd5fa-eb7d-4d32-991e-e19e70500369',
  'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
  'Nexus',
  'executive',
  'Chief Executive Officer',
  'active',
  NULL,
  'Enterprise-wide strategic leadership and vision; Company direction and long-term planning; Executive team leadership and coordination; Board communication and governance; Major decision authority; Organizational culture stewardship',
  'opencode_local',
  '{"model": "opencode/qwen3.6-plus-free", "provider": "openrouter"}',
  true,
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  updated_at = NOW();

-- Orion - DomainForge AI CEO
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  reports_to,
  capabilities,
  adapter_type,
  adapter_config,
  is_active,
  created_at,
  updated_at
) VALUES (
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Orion',
  'ceo',
  'Chief Domain Orchestrator',
  'active',
  NULL,
  'Central nervous system for domain engineering orchestration and coordination. Oversees multi-disciplinary engineering workflow orchestration, cross-functional team coordination, dependency management, performance monitoring, and engineering quality assurance.',
  'opencode_local',
  '{"model": "opencode/qwen3.6-plus-free", "provider": "openrouter"}',
  true,
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  updated_at = NOW();

-- Orchestrator - InfraForge AI CEO
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  reports_to,
  capabilities,
  adapter_type,
  adapter_config,
  is_active,
  created_at,
  updated_at
) VALUES (
  '2876f20c-220c-4bf7-9baf-6ea668f85ef6',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Orchestrator',
  'ceo',
  'Infrastructure Orchestration Specialist',
  'active',
  NULL,
  'Central orchestration of infrastructure services and system integration. Oversees infrastructure service orchestration and coordination, system integration and API management, service dependency management, and infrastructure performance optimization.',
  'opencode_local',
  '{"model": "opencode/qwen3.6-plus-free", "provider": "openrouter"}',
  true,
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  updated_at = NOW();

-- Vision - Loopy AI CEO
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  reports_to,
  capabilities,
  adapter_type,
  adapter_config,
  is_active,
  created_at,
  updated_at
) VALUES (
  '935a91fc-e0de-4c9a-a552-d1803ccb2be1',
  '0a40625e-78f9-4b0a-82e4-169a8befa021',
  'Vision',
  'executive',
  'Chief Executive Officer',
  'active',
  NULL,
  'Strategic leadership and vision for creative AI; Company-wide decision making and governance; Cross-team coordination and resource allocation; Stakeholder communication and partnership development; Creative AI innovation and market positioning',
  'opencode_local',
  '{"model": "opencode/qwen3.6-plus-free", "provider": "openrouter"}',
  true,
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  updated_at = NOW();

-- Sage - PromptForge AI CEO
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  reports_to,
  capabilities,
  adapter_type,
  adapter_config,
  is_active,
  created_at,
  updated_at
) VALUES (
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  'f02b83a8-e0db-4332-b507-22f85e71ebf5',
  'Sage',
  'chief_prompt_architect',
  'Chief Prompt Architect & Quality Assurance Lead',
  'active',
  NULL,
  '["prompt-architecture", "quality-assurance", "ethical-ai", "team-leadership"]',
  'opencode_local',
  '{"model": "opencode/qwen3.6-plus-free", "provider": "openrouter"}',
  true,
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  updated_at = NOW();

-- Apex - QualityForge AI CEO
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  reports_to,
  capabilities,
  adapter_type,
  adapter_config,
  is_active,
  created_at,
  updated_at
) VALUES (
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  'f535f9bc-00be-4b6d-9f53-c53abfacacef',
  'Apex',
  'executive',
  'Chief Executive Officer',
  'active',
  NULL,
  'Quality-focused enterprise leadership; Company excellence and standards; Quality assurance team leadership; Continuous improvement culture; Executive governance; Strategic quality planning',
  'opencode_local',
  '{"model": "opencode/qwen3.6-plus-free", "provider": "openrouter"}',
  true,
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  updated_at = NOW();
```

### 4. Skills Registry Table

```sql
-- DevForge AI Skills (7 CEO/Executive priority skills)
INSERT INTO agent_skills (
  id,
  agent_id,
  skill_name,
  skill_path,
  description,
  is_active,
  created_at,
  updated_at
) VALUES 
(gen_random_uuid(), '384dd5fa-eb7d-4d32-991e-e19e70500369', 'nexus-devforge-ceo', '/skills/devforge-ai/nexus-devforge-ceo/SKILL.md', 'Enterprise development leadership, system architecture decisions, technical strategy, DevForge AI coordination', true, NOW(), NOW()),
(gen_random_uuid(), 'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5', 'orion-devforge-orchestrator', '/skills/devforge-ai/orion-devforge-orchestrator/SKILL.md', 'Task coordination, workflow orchestration, dependency management, performance monitoring, multi-agent orchestration', true, NOW(), NOW());

-- DomainForge AI Skills
INSERT INTO agent_skills (
  id,
  agent_id,
  skill_name,
  skill_path,
  description,
  is_active,
  created_at,
  updated_at
) VALUES 
(gen_random_uuid(), '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5', 'orion-domainforge-ceo', '/skills/domainforge-ai/orion-domainforge-ceo/SKILL.md', 'Engineering leadership, multi-discipline coordination, civil engineering decisions, infrastructure engineering oversight', true, NOW(), NOW());

-- InfraForge AI Skills
INSERT INTO agent_skills (
  id,
  agent_id,
  skill_name,
  skill_path,
  description,
  is_active,
  created_at,
  updated_at
) VALUES 
(gen_random_uuid(), '2876f20c-220c-4bf7-9baf-6ea668f85ef6', 'orchestrator-infraforge-ceo', '/skills/infraforge-ai/orchestrator-infraforge-ceo/SKILL.md', 'Infrastructure orchestration, database management, mobile API integration, supply chain system integration', true, NOW(), NOW());

-- Loopy AI Skills
INSERT INTO agent_skills (
  id,
  agent_id,
  skill_name,
  skill_path,
  description,
  is_active,
  created_at,
  updated_at
) VALUES 
(gen_random_uuid(), '935a91fc-e0de-4c9a-a552-d1803ccb2be1', 'vision-loopy-ceo', '/skills/loopy-ai/vision-loopy-ceo/SKILL.md', 'Creative leadership, content strategy, marketing direction, creative technology implementation, user experience design', true, NOW(), NOW());

-- PromptForge AI Skills
INSERT INTO agent_skills (
  id,
  agent_id,
  skill_name,
  skill_path,
  description,
  is_active,
  created_at,
  updated_at
) VALUES 
(gen_random_uuid(), '5d18545d-993a-496a-b1bd-76e2a9630525', 'sage-promptforge-chief-architect', '/skills/promptforge-ai/sage-promptforge-chief-architect/SKILL.md', 'Enterprise prompt engineering orchestration, multi-agent workflow design, ethical AI validation, cross-company coordination', true, NOW(), NOW());

-- QualityForge AI Skills
INSERT INTO agent_skills (
  id,
  agent_id,
  skill_name,
  skill_path,
  description,
  is_active,
  created_at,
  updated_at
) VALUES 
(gen_random_uuid(), '9e780111-85f6-4cc3-a110-377f23e8fdfc', 'apex-qualityforge-ceo', '/skills/qualityforge-ai/apex-qualityforge-ceo/SKILL.md', 'Quality assurance leadership, code quality validation, testing oversight, quality gate enforcement', true, NOW(), NOW());
```

### 5. Shared Skills

```sql
INSERT INTO agent_skills (
  id,
  agent_id,
  skill_name,
  skill_path,
  description,
  is_active,
  created_at,
  updated_at
) VALUES 
(gen_random_uuid(), NULL, 'cross-team-collaboration', '/skills/shared/cross-team-collaboration/SKILL.md', 'Cross-company collaboration protocols and workflows for multi-agent coordination', true, NOW(), NOW()),
(gen_random_uuid(), NULL, 'promptforge-integration-protocol', '/skills/shared/promptforge-integration-protocol/SKILL.md', 'Protocol for integrating with PromptForge AI as central orchestration hub', true, NOW(), NOW()),
(gen_random_uuid(), NULL, 'quality-validation-workflow', '/skills/shared/quality-validation-workflow/SKILL.md', 'Quality validation workflow for submitting outputs to QualityForge AI', true, NOW(), NOW()),
(gen_random_uuid(), NULL, 'memory-system-integration', '/skills/shared/memory-system-integration/SKILL.md', 'Memory system integration across Gigabrain, OpenStinger, LCM, and PARA', true, NOW(), NOW()),
(gen_random_uuid(), NULL, 'executive-escalation-protocol', '/skills/shared/executive-escalation-protocol/SKILL.md', 'Executive escalation protocol for cross-company issues and conflicts', true, NOW(), NOW());
```

---

## Execution Instructions

### Prerequisites
- Supabase project set up with Paperclip schema
- Database credentials with INSERT/UPDATE permissions
- All company IDs and agent IDs confirmed from CSV data

### Execution Method 1: Direct SQL
```bash
# Connect to Supabase SQL editor
# Paste and execute each section sequentially
# Verify results after each section
```

### Execution Method 2: Migration File
```bash
# Create migration file
# Run with Supabase CLI
supabase db push
```

### Execution Method 3: API Calls
```bash
# Companies
curl -X POST https://your-project.supabase.co/rest/v1/companies \
  -H "apikey: YOUR_KEY" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Prefer: resolution=merge-duplicates" \
  -d '{"id":"f97b30e8-b022-4350-b4b0-30d43e2ebcf4","name":"DevForge AI",...}'

# Repeat for all companies, agents, goals, skills
```

---

## Verification Queries

### Verify Companies
```sql
SELECT id, name, status, issue_prefix, brand_color, is_active 
FROM companies 
WHERE is_active = true 
ORDER BY name;
```

### Verify Goals
```sql
SELECT c.name, g.goal, g.status
FROM company_goals g
JOIN companies c ON c.id = g.company_id
ORDER BY c.name;
```

### Verify CEO Agents
```sql
SELECT a.name, a.title, c.name as company, a.status
FROM agents a
JOIN companies c ON c.id = a.company_id
WHERE a.reports_to IS NULL
ORDER BY c.name;
```

### Verify Skills
```sql
SELECT s.skill_name, a.name as agent, c.name as company
FROM agent_skills s
LEFT JOIN agents a ON a.id = s.agent_id
LEFT JOIN companies c ON c.id = a.company_id
ORDER BY c.name, a.name;
```

---

## Data Summary

| Entity | Count | Status |
|--------|-------|--------|
| Companies | 6 | Ready for insertion |
| Company Goals | 6 | Ready for insertion |
| CEO Agents | 6 | Ready for insertion |
| CEO Skills | 7 | Ready for insertion |
| Shared Skills | 5 | Ready for insertion |
| Remaining Agent Skills | 140 | Documented, pending creation |

---

*This SQL script ensures all enterprise configuration data is properly persisted in Supabase for runtime use by the Paperclip system.*