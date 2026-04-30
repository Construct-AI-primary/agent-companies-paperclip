---
title: 0000 Prompt Review & Remediation Procedure
description: Standardized procedure for reviewing discipline prompts, assessing agent capabilities, verifying skills coverage, and executing remediation to achieve full operational readiness
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/codebase/procedures/workflow-management
gigabrain_tags: procedures, prompt-review, agent-remediation, skills-assessment, readiness-verification, quality-assurance
openstinger_context: prompt-quality, agent-readiness, remediation-automation
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/codebase/agents/openclaw-teams/PromptForge_AI_Team.md
  - docs_construct_ai/skills/shared/pre-task-assessment-readiness/SKILL.md
  - docs_construct_ai/disciplines/01900_procurement/plan/1900_PROCUREMENT_AGENT_SKILLS_REMEDIATION_PLAN.MD
  - docs_construct_ai/disciplines/01900_procurement/testing/1900_PROCUREMENT_SKILLS_VALIDATION_REPORT.MD
  - docs_construct_ai/disciplines/01900_procurement/testing/1900_PROCUREMENT_READINESS_DASHBOARD.MD
  - docs_construct_ai/disciplines/00850_civil-engineering/plan/00850_CIVIL_ENGINEERING_PROMPT_REMEDIATION_PLAN.MD
  - docs_construct_ai/disciplines/00850_civil-engineering/testing/00850_CIVIL_ENGINEERING_SKILLS_VALIDATION.MD
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/00850_CIVIL_AGENT_SKILL_MAPPING.MD
---

# 0000 Prompt Review & Remediation Procedure

## Overview

This procedure defines the standardized process for reviewing discipline prompts, assessing agent and skills coverage, identifying deficiencies, and executing remediation to achieve a readiness score of 10.0/10. It is triggered when any new discipline prompt is created or existing prompt is updated with new requirements.

Based on: 01900 Procurement (2026-03-31) + 00850 Civil Engineering (2026-03-31) — both achieved 10.0/10 readiness

## Scope

This procedure applies to all AI discipline prompts within the Construct AI memory system. It covers review of:
- Prompt templates and use case definitions
- Domain knowledge files and glossaries
- Agent availability and capabilities
- Skills coverage and integration
- Cross-team coordination requirements
- Testing and validation requirements

## Roles & Responsibilities

| Role | Responsible Agents | Responsibility |
|------|-------------------|----------------|
| Lead Reviewer | PromptForge Sage | Overall assessment coordination, quality gates |
| Domain Assessor | PromptForge Specialist + DomainForge agents | Domain knowledge assessment |
| Skills Architect | PromptForge Blueprint | Skills design and generation |
| Agent Coordinator | DevForge Orion + DomainForge Orion | Agent verification and staffing |
| Testing Lead | QualityForge guardian + PromptForge Probe | Testing and validation |
| Dashboard Owner | PromptForge Sage + QualityForge guardian | Readiness dashboard management |

---

## Phase 1: Prompt & Requirements Analysis

### Step 1.1: Read the Target Prompt
- Read the full prompt file (e.g., `01900_PROCUREMENT_ORDER_PROMPT.md`)
- Identify all referenced agents, skills, workflows, and integrations
- Extract functional, technical, and compliance requirements

### Step 1.2: Classify Prompt Complexity
- **Simple:** Single workflow, existing domain knowledge, adequate staffing
- **Standard:** Multiple workflows, partial gaps, minor staffing needs
- **Complex:** Multi-system integration, significant gaps, major staffing needs

### Step 1.3: Inventory Existing Capabilities
- List all existing skills that relate to this task (check `/skills/` directory)
- List all existing agents that can work on this task (check agent registry)
- List all existing domain knowledge files for this discipline

### Step 1.4: Produce Task Analysis Report
```
TASK ANALYSIS REPORT — [Prompt Name]
Target Discipline: [Code & Name]
Task Complexity: [Simple / Standard / Complex]
Existing Skills Found: [List with locations]
Existing Agents Available: [List with capabilities]
Existing Domain Knowledge: [List with locations]
Knowledge Gaps Identified: [List]
Skills Gaps Identified: [List]
Staffing Gaps Identified: [List]
Readiness Status: [READY / NEEDS PREPARATION / BLOCKED]
```

**Gate 1 Checkpoint:** Task analysis report produced and reviewed by Lead Reviewer.

---

## Phase 2: Domain Knowledge Assessment

### Step 2.1: Inventory Domain Knowledge Files
- Locate the discipline's domain knowledge file
- Locate the discipline's glossary file
- List all related documentation

### Step 2.2: Assess Domain Knowledge Completeness
Evaluate against 7 criteria (Pass/Fail):
1. Role & Scope — Clear definition and boundaries
2. Core Knowledge — Order types, processes, data elements
3. Behavioral Rules — Agent persona, communication, decision rules
4. Scenarios — Common scenarios with response patterns
5. Workflow Architecture — Process flows, integration, thresholds
6. Reference Materials — Incoterms, payment terms, lead-times
7. Safety Boundaries — What the agent must NOT do

### Step 2.3: Assess Glossary Completeness
Evaluate against 4 criteria (Pass/Fail):
1. Term Coverage — Acronyms defined
2. Technical Terms — Domain-specific terms defined
3. Quality — Actual definitions (not placeholder text)
4. Completeness — 20+ minimum for mature discipline

### Step 2.4: Produce Knowledge Assessment Report
Document: file locations, quality ratings (1-10), gaps by severity, outdated content.

**Gate 2 Checkpoint:** Knowledge assessment complete, gaps cataloged.

---

## Phase 3: Skills Assessment

### Step 3.1: Map Skills to Prompt Requirements
For each workflow component in the prompt, identify:
- Required skill type
- Existing skill (if any)
- Skill gap

### Step 3.2: Assess Existing Skills
For each existing skill:
- Verify structure (YAML frontmatter, steps, success criteria, pitfalls)
- Verify cross-references resolve
- Verify alignment with domain knowledge

### Step 3.3: Document Skills Gaps
List all required skills not yet created, with priority.

**Gate 3 Checkpoint:** Skills assessment complete, gaps prioritized.

---

## Phase 4: Agent Assessment

### Step 4.1: Map Agents to Requirements
For each workflow component, identify the required agent capability.

### Step 4.2: Query Agent Registry
Identify:
- Available agents with matching capabilities
- Agent capacity and current workload
- Reporting structure

### Step 4.3: Identify Staffing Gaps
Document: required capabilities, existing agents, missing agents, recommended new agents.

### Step 4.4: Create Agent-to-Skill Mapping Document
For each discipline, create a mapping document at:
`docs-construct-ai/disciplines/[discipline]/agent-data/[CODE]_AGENT_SKILL_MAPPING.MD`

This document maps all agents to their primary and supporting skills with environment assignments and cross-team coordination.

### Step 4.4: Create Agent Hiring Documents (If Needed)
For each staffing gap:
- Create agent definition (name, role, responsibilities, specialization, reports-to, company)
- Generate SQL migration file at `sql/creations/create-[discipline]-[agent]-agent.sql`

**Gate 4 Checkpoint:** Staffing adequate or new agents defined with SQL migration.

---

## Phase 5: Create Remediation Plan

### Step 5.1: Plan Structure
Create remediation plan document at:
`docs-construct-ai/disciplines/[discipline]/plan/[CODE]_REMEDIATION_PLAN.MD`

**Note:** Skills must be created under `skills/domainforge_ai/[discipline-skill]/SKILL.md` for DomainForge disciplines.

### Step 5.2: Phase-Based Execution
Organize remediation into phases:
- **Phase 1: Critical Fixes** — Glossary rebuild, critical skills creation
- **Phase 2: Skills Expansion** — Remaining skills creation
- **Phase 3: Agent Verification** — Database verification, team linkages
- **Phase 4: Integration** — Naming reconciliation, registries, testing
- **Phase 5: Validation** — Skills validation, prompt update, dashboard

### Step 5.3: Define Success Criteria
For each phase, define measurable success criteria.

### Step 5.4: Estimate Resources
Estimate effort (hours) per phase.

**Gate 5 Checkpoint:** Remediation plan created and approved.

---

## Phase 6: Execute Remediation

### Step 6.1: Execute Phase 1 (Critical Fixes)
- Rebuild glossary with proper definitions (minimum 20+ terms)
- Create critical missing skills under `skills/domainforge_ai/` (or appropriate team directory)
- Validate structure and cross-references

### Step 6.2: Execute Phase 2 (Skills Expansion)
- Create remaining missing skills under `skills/domainforge_ai/` (or appropriate team directory)
- Follow standard skill structure (frontmatter, overview, triggers, prerequisites, steps, success criteria, pitfalls, cross-references, usage, metrics)
- Validate all skills

### Step 6.3: Execute Phase 3 (Agent Verification)
- Verify specialist agents exist in database (check SQL migrations)
- Update agent registry with IDs, capabilities, reporting structure
- Create agent naming reconciliation document (if needed)
- Verify agent-to-skill mapping

### Step 6.4: Execute Phase 4 (Integration)
- Reconcile any naming conflicts between systems
- Create cross-team coordination documentation
- Link teams to discipline workflows

### Step 6.5: Execute Phase 5 (Validation)
- Validate all skills created (structure, frontmatter, cross-references, alignment)
- Update prompt with skills integration section
- Create readiness dashboard

### Step 6.6: Remediate Remaining Deficiencies
- Score each readiness dimension (1-10)
- If any score < 10, identify root cause and apply fix
- Re-score after fix
- Continue until all dimensions score 10/10

---

## Phase 7: Validation & Sign-Off

### Step 7.1: Skills Validation
Validate each skill against 6 dimensions:
1. Structure completeness (overview, triggers, prerequisites, steps, success criteria, pitfalls, cross-references)
2. YAML frontmatter (title, description, frequency, success_rate, tags, docs)
3. Cross-reference validation (all referenced skills and docs exist)
4. Domain knowledge alignment (content matches domain knowledge)
5. Glossary usage (terms defined and used correctly)
6. Agent assignment complete (each skill has agents assigned)

### Step 7.2: Prompt Integration Check
- Verify prompt references all new skills
- Verify agent registry linked
- Verify glossary linked
- Verify version updated

### Step 7.3: Readiness Dashboard
Create dashboard with dimensions:
1. Skills Coverage (target: ≥ 90%)
2. Agent Availability (target: ≥ 90%)
3. Domain Knowledge (target: ≥ 8/10)
4. Prompt Integration (target: ≥ 9/10)
5. Testing & Validation (target: ≥ 95%)
6. Integration Readiness (target: ≥ 7/10)

### Step 7.4: Sign-Off
- Lead Reviewer: [✅ / ❌]
- Domain Assessor: [✅ / ❌]
- Testing Lead: [✅ / ❌]
- Dashboard Owner: [✅ / ❌]

---

## Success Criteria

The procedure is complete when:
- [ ] All 7 phases executed
- [ ] Overall readiness score is 10.0/10 or documented blockers are accepted by leadership
- [ ] All gaps resolved or scheduled for future phases
- [ ] Prompt updated with skills integration section
- [ ] Agent registry updated
- [ ] Glossary complete (50+ terms recommended for mature disciplines)
- [ ] All skills validated (structure, frontmatter, cross-references, alignment)
- [ ] All skills pass 6-dimension validation (structure, frontmatter, cross-refs, domain alignment, glossary, agents)
- [ ] Agent-to-skill mapping document created
- [ ] Readiness dashboard created and current
- [ ] Remediation plan executed and all tasks complete

---

## Artifacts Created

| Artifact | Location | Purpose |
|----------|----------|---------|
| Task Analysis Report | Prompt root | Requirements gap analysis |
| Knowledge Assessment | Prompt root | Domain knowledge evaluation |
| Skills Assessment | Prompt root | Skills evaluation |
| Agent Assessment | Agent registry | Staffing evaluation |
| Remediation Plan | `plan/` folder | Execution plan |
| Updated Glossary | `agent-data/domain-knowledge/` | Term definitions |
| New Skills | `skills/` directory | Workflow capabilities |
| Agent Registry | `agent-data/` folder | Agent documentation |
| Agent Naming Map | `agent-data/` folder | Naming reconciliation |
| Agent-to-Skill Mapping | `agent-data/` folder | Agent-skill relationship documentation |
| Skills Validation Report | `testing/` folder | Validation results |
| Readiness Dashboard | `testing/` folder | Live readiness status |
| Updated Prompt | `agent-data/prompts/` | Skills integration |

---

## Related Procedures

- `0000_WORKFLOW_IMPLEMENTATION_PROCEDURE.md` — Workflow implementation
- `0000_WORKFLOW_TASK_PROCEDURE.md` — Task procedure
- `0000_TESTING_WORKFLOW_PROCEDURE.md` — Testing workflow
- `0000_AGENT_ACCURACY_ENHANCEMENT_PROCEDURE.md` — Agent accuracy
- `0000_SHARED_WORKFLOW_OPTIMIZATION_PROCEDURE.md` — Shared workflow

## Related Skills

- `pre-task-assessment-readiness` — Pre-task assessment skill
- `workflow-implementation` — Workflow implementation skill
- `writing-skills` — Skills writing skill
- Civil engineering testing (`domainforge_ai/civil-testing`) — Discipline-specific skill validation

## Lessons Learned (from executed reviews)

### 00850 Civil Engineering (2026-03-31) — 5.5/10 → 10.0/10
- **Key finding:** Zero civil-engineering-specific skills existed despite comprehensive prompt
- **Resolution:** Created 10 skills under `skills/domainforge_ai/` covering DWG processing, site assessment, design, documentation, QA, mobile, UI cards, quantity takeoff, sync, and tender
- **Glossary expansion:** 35 → 56 key terms + 48 acronyms
- **Agent mapping:** All 26 agents mapped to skills with primary/supporting roles
- **Validation:** 60/60 checks passed across 6 dimensions

### 01900 Procurement (2026-03-31) — 5.8/10 → 10.0/10
- **Key finding:** Glossary had placeholder text, critical skills missing
- **Resolution:** Rebuilt glossary to 30+ terms, created 8+ procurement skills
- **Team linkages:** PromptForge, QualityForge, DevForge linked to procurement workflows
