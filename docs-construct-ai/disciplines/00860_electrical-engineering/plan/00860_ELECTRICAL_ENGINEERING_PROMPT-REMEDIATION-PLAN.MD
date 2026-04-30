---
title: 00860 Electrical Engineering Prompt Remediation Plan
description: Comprehensive remediation plan to address all gaps identified in the Prompt Review & Remediation Procedure for the electrical engineering AI-native operations prompt
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00860_electrical-engineering/plan
gigabrain_tags: electrical-engineering, remediation-plan, agent-staffing, skills-development, readiness-improvement
openstinger_context: electrical-engineering-ai-readiness
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/prompts/00860_AI-NATIVE-ELECTRICAL-ENGINEERING-PROMPT.md
  - docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/domain-knowledge/00860_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/domain-knowledge/00860_GLOSSARY.MD
  - docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/
---

# 00860 Electrical Engineering Prompt Remediation Plan

## Current Assessment: 3.2/10

| Dimension | Score | Status |
|-----------|-------|--------|
| Skills Coverage | 0/10 | **Critical Gap** — Zero electrical engineering skills exist |
| Agent Availability | 0/10 | **Critical Gap** — No agents defined or registered |
| Domain Knowledge | 9/10 | ✅ Complete (comprehensive v2.0 with challenges, LOTO, compliance) |
| Prompt Integration | 8/10 | ✅ Good (AI-NATIVE prompt v1.0 with 16 sections complete) |
| Glossary | 8/10 | ✅ Good (50+ terms, 38 acronyms, comprehensive coverage) |
| Testing & Validation | 0/10 | **Critical Gap** — No testing documents, no validation reports |

---

## Phase 1: Critical Agent Infrastructure (Hours: 4-6)

### Step 1.1: Create Agents Registry Summary
- **Status:** Missing entirely
- **Action:** Create `00860_AGENTS-REGISTRY-SUMMARY.MD` based on electrical engineering requirements from the AI-NATIVE prompt
- **Output:** File at `agent-data/00860_AGENTS-REGISTRY-SUMMARY.MD`

### Step 1.2: Create Agent-to-Skill Mapping Document
- **Status:** Missing entirely
- **Action:** Create `00860_ELECTRICAL_AGENT_SKILL_MAPPING.MD` mapping agents to skills
- **Output:** File at `agent-data/00860_ELECTRICAL_AGENT_SKILL_MAPPING.MD`

### Step 1.3: Create Electrical Engineering README
- **Status:** Missing
- **Action:** Create comprehensive README.md documenting discipline structure, agents, and workflows
- **Output:** File at `agent-data/README.md`

---

## Phase 2: Skills Creation (Hours: 8-12)

### Required Electrical Engineering Skills

Based on the AI-NATIVE prompt analysis, the following skills are needed:

| Skill ID | Skill Name | Description | Priority |
|----------|-----------|-------------|----------|
| 001 | `electrical-sld-processing` | SLD/DWG processing pipeline: AUDIT → PURGE → symbol extraction → topology validation → structured JSON | Critical |
| 002 | `electrical-load-analysis` | Load estimation, diversity factor calculation, demand analysis, feeder sizing | Critical |
| 003 | `electrical-cable-sizing` | IEC 60364/NEC cable sizing with derating, voltage drop, short-circuit withstand | Critical |
| 004 | `electrical-protection-coordination` | Relay/fuse coordination, TCC analysis, selective tripping verification | Critical |
| 005 | `electrical-arc-flash-analysis` | IEEE 1584 incident energy calculation, arc flash boundaries, PPE assignment | High |
| 006 | `electrical-short-circuit` | Fault current calculation (3-phase, L-G, L-L, L-L-G) per IEC 60909/IEEE | High |
| 007 | `electrical-document-generation` | Document pipeline: Concept → Design → Construction → Commissioning documents | High |
| 008 | `electrical-loto-compliance` | LOTO procedure generation, energy source mapping, isolation verification | High |
| 009 | `electrical-commissioning` | Commissioning test sequences, pre-energization checklists, functional testing | High |
| 010 | `electrical-power-quality` | Harmonic analysis, power factor correction, voltage fluctuation mitigation | Medium |

**Location:** All skills created under `docs-construct-ai/skills/domainforge_ai/[skill-name]/SKILL.md`

---

## Phase 3: Agent Definition & Verification (Hours: 4-6)

### Required Electrical Engineering Agents

| Agent ID | Agent Name | Role | Assigned Skills | Environment |
|----------|-----------|------|----------------|-------------|
| EE-ORCH-001 | Electrical Orchestrator | Lead coordinator, workflow management | All (primary) | OpenClaw |
| EE-LOAD-001 | Load Analysis Agent | Load estimation, demand calculation | electrical-load-analysis | OpenClaw |
| EE-CABLE-001 | Cable Sizing Agent | Cable sizing calculations | electrical-cable-sizing | OpenClaw |
| EE-PROT-001 | Protection Coordination Agent | Relay/fuse coordination, TCC analysis | electrical-protection-coordination | deep-agents |
| EE-ARC-001 | Arc Flash Agent | Arc flash analysis, PPE assignment | electrical-arc-flash-analysis | deep-agents |
| EE-SC-001 | Short Circuit Agent | Fault current calculations | electrical-short-circuit | deep-agents |
| EE-DWG-001 | SLD Processing Agent | SLD extraction, topology validation | electrical-sld-processing | deep-agents |
| EE-DOCS-001 | Document Generation Agent | Template-based document generation | electrical-document-generation | OpenClaw |
| EE-LOTO-001 | LOTO Compliance Agent | LOTO procedures, energy mapping | electrical-loto-compliance | OpenClaw |
| EE-COMM-001 | Commissioning Agent | Test sequences, commissioning protocols | electrical-commissioning | OpenClaw |
| EE-QA-001 | Electrical QA Agent | Quality assurance, code compliance | All (supporting) | OpenClaw |
| EE-LIB-001 | Electrical Library Agent | Reference data, code databases | All (supporting) | OpenClaw |

### Step 3.1: Verify/Create Agent Definitions
- **Action:** Create agent definition files or SQL migrations if they don't exist
- **Output:** SQL migration files at `database/migrations/` for new agents

---

## Phase 4: Integration & Validation (Hours: 2-4)

### Step 4.1: Update AI-NATIVE Prompt
- Add skills integration section referencing all 10 skills
- Link to agent registry
- Update version to 1.1

### Step 4.2: Create Skills Validation Report
- **Output:** `testing/00860_ELECTRICAL_SKILLS_VALIDATION_REPORT.MD`
- Validate all 10 skills across 6 dimensions
- Target: 60/60 checks passed

### Step 4.3: Create Readiness Dashboard
- **Output:** `testing/00860_ELECTRICAL_READINESS_DASHBOARD.MD`
- Real-time readiness status tracking
- Target: 10.0/10 overall score

---

## Phase-Based Execution Schedule

### Phase 1: Critical Fixes (Days 1-2)
- [ ] Create agents registry summary
- [ ] Create agent-to-skill mapping document
- [ ] Create electrical engineering README
- **Estimated effort:** 4-6 hours

### Phase 2: Skills Expansion (Days 2-5)
- [ ] Create Phase 2 critical skills (sld-processing, load-analysis, cable-sizing, protection-coordination)
- [ ] Create Phase 2 high-priority skills (arc-flash, short-circuit, document-generation, loto-compliance, commissioning)
- [ ] Create Phase 2 medium-priority skill (power-quality)
- **Estimated effort:** 8-12 hours

### Phase 3: Agent Definition & Staffing (Days 4-5)
- [ ] Verify all 12 EE agents exist in database
- [ ] Create SQL migrations for missing agents
- [ ] Complete agent-to-skill mapping with primary/supporting roles
- **Estimated effort:** 4-6 hours

### Phase 4: Integration & Validation (Days 5-6)
- [ ] Update prompt with skills integration
- [ ] Create skills validation report (60 checks)
- [ ] Create readiness dashboard
- **Estimated effort:** 2-4 hours

**Total estimated effort:** 18-28 hours

---

## Success Criteria

- [ ] All 10 electrical engineering skills created and validated
- [ ] All 12 EE agents defined and registered
- [ ] Agent-to-skill mapping complete with environments
- [ ] Prompt updated with skills integration (v1.1+)
- [ ] Skills validation report with 60/60 checks passed
- [ ] Readiness dashboard showing 10.0/10 overall score
- [ ] All cross-references resolve correctly

---

*00860 Electrical Engineering Prompt Remediation Plan — Version 1.0*
*Last Updated: 2026-03-31*