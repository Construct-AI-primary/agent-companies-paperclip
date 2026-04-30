---
title: 01900 Procurement Agent & Skills Remediation Plan
description: Remediation plan to address gaps identified in the 01900 Procurement Order Prompt agent and skills review, including glossary reconstruction, skill creation, and agent verification
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/01900_procurement/plan
gigabrain_tags: disciplines, 01900_procurement, remediation, agent-skills, gap-analysis, implementation-plan
openstinger_context: procurement-optimization, agent-enablement, skill-development
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/01900_procurement/agent-data/prompts/01900_PROCUREMENT_ORDER_PROMPT.md
  - docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/1900_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/1900_GLOSSARY.MD
  - docs_construct_ai/codebase/agents/openclaw-teams/PROCUREMENT_WORKFLOW_TEAM_STAFFING_ANALYSIS.md
  - docs_construct_ai/codebase/agents/openclaw-teams/PromptForge_AI_Team.md
  - docs_construct_ai/codebase/agents/openclaw-teams/DomainForge_AI_Team.md
  - docs_construct_ai/codebase/agents/openclaw-teams/InfraForge_AI_Team.md
---

# 01900 Procurement Agent & Skills Remediation Plan

## Executive Summary

A comprehensive review of the 01900 Procurement Order Prompt identified **critical gaps** in skills coverage, glossary completeness, and agent verification. This plan provides a structured remediation approach to achieve full operational readiness for the procurement workflow system.

**Current Readiness Score: 5.8/10 - PARTIALLY READY**
**Target Readiness Score: 9.0/10 - FULLY OPERATIONAL**

---

## Gap Analysis Summary

### Critical Findings

| Dimension | Current Score | Target Score | Gap |
|-----------|--------------|--------------|-----|
| Agent Availability | 7/10 | 9/10 | 4 core teams not verified as procurement-ready |
| Skills Coverage | 3/10 | 9/10 | 8 procurement-specific skills missing |
| Domain Knowledge | 8/10 | 9/10 | Minor cross-reference gaps |
| Glossary Quality | 2/10 | 9/10 | Placeholder text, needs complete rewrite |
| Prompt Structure | 9/10 | 9/10 | Well-structured, minimal changes needed |
| Integration Readiness | 6/10 | 8/10 | Skill bridges needed between teams |

---

## Remediation Phases

### Phase 1: Critical Fixes (Week 1)

#### Task 1.1: Rebuild 1900_GLOSSARY.MD
**Priority:** 🔴 CRITICAL
**Estimated Effort:** 4-6 hours
**Assigned To:** DomainForge AI - Procurement Strategy Specialist + Contract Administration Specialist

**Current State:** 4 placeholder definitions, minimal acronyms
**Target State:** Comprehensive glossary with 30+ terms

**Required Terms to Add:**

| Term | Definition Source | Category |
|------|-------------------|----------|
| RFQ (Request for Quotation) | 1900_DOMAIN-KNOWLEDGE.MD Section 1.4 | Procurement Process |
| BOQ (Bill of Quantities) | 1900_DOMAIN-KNOWLEDGE.MD Section 1.2 | Documentation |
| MTO (Material Take-Off) | 1900_DOMAIN-KNOWLEDGE.MD Section 1.2 | Documentation |
| GRN (Goods Receipt Note) | 1900_DOMAIN-KNOWLEDGE.MD Section 1.5 | Order Administration |
| SO (Sales Order) | 1900_DOMAIN-KNOWLEDGE.MD Section 2.2 | Order Types |
| WO (Work Order) | 1900_DOMAIN-KNOWLEDGE.MD Section 2.3 | Order Types |
| 3-Way Match | 1900_DOMAIN-KNOWLEDGE.MD Section 2.1 | Financial Control |
| WBS (Work Breakdown Structure) | 1900_DOMAIN-KNOWLEDGE.MD throughout | Project Management |
| JIT (Just-In-Time) | 1900_DOMAIN-KNOWLEDGE.MD Section 1.2 | Order Strategy |
| FAT (Factory Acceptance Test) | 1900_DOMAIN-KNOWLEDGE.MD Section 1.7 | Quality Control |
| Incoterms | 1900_DOMAIN-KNOWLEDGE.MD Section 6.1 | Shipping Terms |
| EXW (Ex Works) | 1900_DOMAIN-KNOWLEDGE.MD Section 6.1 | Incoterm |
| FOB (Free on Board) | 1900_DOMAIN-KNOWLEDGE.MD Section 6.1 | Incoterm |
| CIF (Cost, Insurance, Freight) | 1900_DOMAIN-KNOWLEDGE.MD Section 6.1 | Incoterm |
| DDP (Delivered Duty Paid) | 1900_DOMAIN-KNOWLEDGE.MD Section 6.1 | Incoterm |
| DAP (Delivered at Place) | 1900_DOMAIN-KNOWLEDGE.MD Section 6.1 | Incoterm |
| HITL (Human-in-the-Loop) | 01900_PROCUREMENT_ORDER_PROMPT.md | AI Integration |
| SOW (Scope of Work) | 01900_PROCUREMENT_ORDER_PROMPT.md | Documentation |
| ITT (Invitation to Tender) | 1900_DOMAIN-KNOWLEDGE.MD Section 4.2 | Procurement Process |
| T&M (Time and Materials) | 1900_DOMAIN-KNOWLEDGE.MD Section 6.2 | Payment Terms |
| Net 30 / 2/10 Net 30 | 1900_DOMAIN-KNOWLEDGE.MD Section 6.2 | Payment Terms |
| Retention (0/90/10) | 1900_DOMAIN-KNOWLEDGE.MD Section 6.2 | Payment Terms |
| UoM (Unit of Measure) | 1900_DOMAIN-KNOWLEDGE.MD Section 6.3 | Data Standards |
| ERP (Enterprise Resource Planning) | 1900_DOMAIN-KNOWLEDGE.MD Section 5.2 | Systems |
| RLS (Row Level Security) | 1900_GLOSSARY.MD (existing - expand) | Database Security |
| ETL (Extract, Transform, Load) | 01900_PROCUREMENT_ORDER_PROMPT.md (existing - expand) | Data Processing |
| PARA | Memory system documentation | Knowledge Management |
| Gigabrain | Memory system documentation | AI Integration |
| OpenStinger | Memory system documentation | AI Integration |

**Deliverable:** Complete glossary file with proper definitions, cross-references, and categorized term groups

---

#### Task 1.2: Create domainforge_ai/procurement-order-management/SKILL.md
**Priority:** 🔴 CRITICAL
**Estimated Effort:** 3-4 hours
**Assigned To:** DomainForge AI - Procurement Strategy Specialist + PromptForge AI - Blueprint

**Skill Structure:**
```markdown
---
title: Procurement Order Management
frequency_percent: 90.0
success_rate_percent: 95.0
---

# Procurement Order Management

## Overview
Implement procurement order workflows including 5-phase order creation, supplier qualification, approval routing, and SOW generation.

## When to Use This Skill
- Creating purchase orders, service orders, or work orders
- Configuring approval workflows based on order value
- Managing supplier qualification and evaluation
- Generating Scope of Work documents

## Step-by-Step Procedure
### Step 1: Order Type Selection
### Step 2: 5-Phase Order Creation
### Step 3: Approval Routing Configuration
### Step 4: SOW Generation (19-Stage)
### Step 5: Post-Order Processing

## Success Criteria
## Common Pitfalls
## Cross-References
```

**Dependencies:** Task 1.1 (glossary terms referenced in skill)

---

#### Task 1.3: Create domainforge_ai/supplier-evaluation/SKILL.md
**Priority:** 🔴 CRITICAL
**Estimated Effort:** 2-3 hours
**Assigned To:** DomainForge AI - Supplier Management Specialist

**Skill Structure:**
```markdown
---
title: Supplier Evaluation & Qualification
frequency_percent: 75.0
success_rate_percent: 90.0
---

# Supplier Evaluation & Qualification

## Overview
Manage supplier qualification using Platinum/Gold/Silver/Bronze tier system with performance monitoring and risk assessment.
```

---

#### Task 1.4: Create domainforge_ai/approval-routing/SKILL.md
**Priority:** 🔴 CRITICAL
**Estimated Effort:** 2-3 hours
**Assigned To:** DomainForge AI - Financial Compliance Specialist

**Skill Structure:**
```markdown
---
title: Approval Routing Configuration
frequency_percent: 85.0
success_rate_percent: 92.0
---

# Approval Routing Configuration

## Overview
Configure value-based approval routing with Sequential/Parallel/Hybrid routing types and HITL integration.
```

---

#### Task 1.5: Create domainforge_ai/sow-generation/SKILL.md
**Priority:** 🔴 CRITICAL
**Estimated Effort:** 3-4 hours
**Assigned To:** DomainForge AI - Contract Administration Specialist + Procurement Strategy Specialist

**Skill Structure:**
```markdown
---
title: Scope of Work Generation
frequency_percent: 70.0
success_rate_percent: 88.0
---

# Scope of Work Generation

## Overview
Execute 19-stage SOW generation workflow with template selection, appendix compilation, and document validation.
```

---

### Phase 2: Skill Expansion (Week 2)

#### Task 2.1: Create domainforge_ai/template-management/SKILL.md
**Priority:** 🟡 HIGH
**Estimated Effort:** 2-3 hours
**Assigned To:** DomainForge AI - Procurement Analytics Specialist

#### Task 2.2: Create domainforge_ai/voice-command-integration/SKILL.md
**Priority:** 🟡 HIGH
**Estimated Effort:** 2-3 hours
**Assigned To:** DomainForge AI - Mobile Workflow Designer

#### Task 2.3: Create domainforge_ai/gps-approval-configuration/SKILL.md
**Priority:** 🟡 HIGH
**Estimated Effort:** 2-3 hours
**Assigned To:** DomainForge AI - Mobile Workflow Designer

#### Task 2.4: Create domainforge_ai/offline-procurement/SKILL.md
**Priority:** 🟡 HIGH
**Estimated Effort:** 2-3 hours
**Assigned To:** DomainForge AI - Mobile Workflow Designer + InfraForge AI - Mobile API Integration Specialist

#### Task 2.5: Create infraforge_ai/supply-chain-integration/SKILL.md
**Priority:** 🟡 HIGH
**Estimated Effort:** 2-3 hours
**Assigned To:** InfraForge AI - Supply Chain Integration Specialist

---

### Phase 3: Agent Verification (Week 2-3)

#### Task 3.1: Verify Specialist Agent Database Records
**Priority:** 🔴 CRITICAL
**Estimated Effort:** 1-2 hours
**Assigned To:** DevForge AI - Database Specialist

**Verification Steps:**
1. Query Supabase for all 9 specialist agents by UUID
2. Verify agent status, capabilities, and reporting structure
3. Confirm RLS policies allow agent access to procurement tables
4. Document any discrepancies

**Agent IDs to Verify:**
```
a1a1a1a1-1111-1111-1111-111111111111 - Procurement Strategy Specialist
b2b2b2b2-2222-2222-2222-222222222222 - Supplier Management Specialist
c3c3c3c3-3333-3333-3333-333333333333 - Contract Administration Specialist
d4d4d4d4-4444-4444-4444-444444444444 - Procurement Analytics Specialist
e5e5e5e5-5555-5555-5555-555555555555 - Mobile Workflow Designer
f6f6f6f6-6666-6666-6666-666666666666 - Mobile Testing Specialist
c9c9c9c9-9999-9999-9999-999999999999 - Financial Compliance Specialist
a7a7a7a7-7777-7777-7777-777777777777 - Mobile API Integration Specialist
b8b8b8b8-8888-8888-8888-888888888888 - Supply Chain Integration Specialist
```

---

#### Task 3.2: Link PromptForge Team to Procurement
**Priority:** 🟡 HIGH
**Estimated Effort:** 3-4 hours
**Assigned To:** PromptForge AI - Sage + DomainForge AI - Orion

**Required Actions:**
1. Add procurement-specific agent profiles to PromptForge team documentation
2. Configure Cascade (workflow) and Blueprint (template) agents for procurement templates
3. Establish Probe/Validator/Simulator test suites for procurement workflows
4. Document procurement-specific prompt patterns in Archivist knowledge base

---

#### Task 3.3: Link QualityForge Team to Procurement
**Priority:** 🟡 HIGH
**Estimated Effort:** 3-4 hours
**Assigned To:** QualityForge AI - guardian + DomainForge AI - Orion

**Required Actions:**
1. Configure integration and e2e testing for procurement workflows
2. Set up procurement-specific quality gates
3. Establish audit trail validation procedures
4. Document procurement testing standards

---

#### Task 3.4: Link DevForge Team to Procurement
**Priority:** 🟡 HIGH
**Estimated Effort:** 3-4 hours
**Assigned To:** DevForge AI - Orion + Codesmith

**Required Actions:**
1. Configure API integration agents for procurement system endpoints
2. Establish procurement-specific coding standards
3. Set up automated testing pipelines for procurement features
4. Document procurement database schema and naming conventions

---

### Phase 4: Cross-Reference & Integration (Week 3)

#### Task 4.1: Reconcile Agent Naming Schemes
**Priority:** 🟢 MEDIUM
**Estimated Effort:** 2 hours
**Assigned To:** DomainForge AI - Council

**Issue:** Two different agent naming conventions exist:
- Domain knowledge file: PROC-ORD-001, PROC-SUP-001, PROC-REC-001, PROC-COST-001, PROC-RFQ-001
- Staffing analysis: UUID-based specialist agents

**Resolution:** Create agent mapping document and standardize naming

---

#### Task 4.2: Create Procurement Agent Registry
**Priority:** 🟢 MEDIUM
**Estimated Effort:** 2-3 hours
**Assigned To:** DomainForge AI - Procurement Analytics Specialist

**Deliverable:** Updated 1900_AGENTS-REGISTRY-SUMMARY.MD with all 9 specialist agents, their capabilities, and cross-team relationships

---

#### Task 4.3: Create Procurement Testing Skill
**Priority:** 🟢 MEDIUM
**Estimated Effort:** 2 hours
**Assigned To:** QualityForge AI team + DomainForge AI

**Deliverable:** `docs-construct-ai/skills/domainforge_ai/procurement-testing/SKILL.md`

---

#### Task 4.4: Create Mobile Procurement Consolidated Skill
**Priority:** 🟢 MEDIUM
**Estimated Effort:** 3 hours
**Assigned To:** DomainForge AI - Mobile Workflow Designer

**Deliverable:** `docs-construct-ai/skills/domainforge_ai/mobile-procurement/SKILL.md` consolidating voice, GPS, offline, and field procurement

---

### Phase 5: Validation & Documentation (Week 4)

#### Task 5.1: Validate All Skills Work
**Priority:** 🔴 CRITICAL
**Estimated Effort:** 4-6 hours
**Assigned To:** PromptForge AI - Probe + QualityForge AI - e2e

**Validation Steps:**
1. Test each new skill against procurement workflow scenarios
2. Verify skill trigger conditions work correctly
3. Confirm cross-references resolve properly
4. Document test results and fix any issues

---

#### Task 5.2: Update Procurement Prompt
**Priority:** 🟡 HIGH
**Estimated Effort:** 2-3 hours
**Assigned To:** PromptForge AI - Sage + Blueprint

**Required Updates:**
1. Add references to newly created skills
2. Update agent assignment section with verified agents
3. Correct any workflow gaps identified during testing
4. Update version history

---

#### Task 5.3: Create Procurement Readiness Dashboard
**Priority:** 🟢 MEDIUM
**Estimated Effort:** 3-4 hours
**Assigned To:** DomainForge AI - Procurement Analytics Specialist

**Deliverable:** Dashboard showing real-time readiness score, skill coverage, agent availability, and workflow completion rates

---

## Implementation Timeline

```
Week 1: Phase 1 - Critical Fixes
├── Days 1-2: Task 1.1 - Rebuild Glossary
├── Days 2-3: Task 1.2 - Create procurement-order-management skill
├── Days 3-4: Task 1.3 - Create supplier-evaluation skill
├── Day 4: Task 1.4 - Create approval-routing skill
└── Days 4-5: Task 1.5 - Create sow-generation skill

Week 2: Phase 2 + Phase 3 Start
├── Days 1-2: Tasks 2.1-2.2 - Template management + voice command skills
├── Days 2-3: Tasks 2.3-2.4 - GPS approval + offline procurement skills
├── Day 3: Task 2.5 - Supply chain integration skill
├── Days 3-4: Task 3.1 - Verify specialist agent database records
└── Days 4-5: Tasks 3.2-3.3 - Link PromptForge + QualityForge to procurement

Week 3: Phase 3 Complete + Phase 4
├── Days 1-2: Task 3.4 - Link DevForge to procurement
├── Days 2-3: Task 4.1 - Reconcile agent naming schemes
├── Days 3-4: Task 4.2 - Create procurement agent registry
└── Days 4-5: Tasks 4.3-4.4 - Testing skill + mobile procurement skill

Week 4: Phase 5 - Validation & Documentation
├── Days 1-2: Task 5.1 - Validate all skills work
├── Days 2-3: Task 5.2 - Update procurement prompt
└── Days 3-5: Task 5.3 - Create readiness dashboard
```

---

## Success Criteria

### Phase 1 Success Criteria
- [ ] Glossary contains 25+ properly defined terms
- [ ] All 4 critical skills created with proper structure
- [ ] Skills reference correct glossary terms
- [ ] Cross-references between skills resolve correctly

### Phase 2 Success Criteria
- [ ] All 5 additional skills created
- [ ] Skills follow established SKILL.md format
- [ ] Frequency and success rate metrics defined
- [ ] Skills reference correct agents

### Phase 3 Success Criteria
- [ ] All 9 specialist agents verified in database
- [ ] PromptForge linked with 5+ procurement-specific configurations
- [ ] QualityForge linked with 3+ procurement test suites
- [ ] DevForge linked with 3+ procurement integrations

### Phase 4 Success Criteria
- [ ] Agent naming standardized and documented
- [ ] Procurement agent registry complete
- [ ] Testing skill created and validated
- [ ] Mobile procurement skill consolidated

### Phase 5 Success Criteria
- [ ] All 9+ skills tested against procurement scenarios
- [ ] Procurement prompt updated with skill references
- [ ] Readiness dashboard operational
- [ ] Overall readiness score ≥ 9.0/10

---

## Risk Register

| Risk | Probability | Impact | Mitigation | Owner |
|------|-------------|--------|------------|-------|
| Glossary rewrite takes longer than estimated | Medium | Low | Parallel work on skills while glossary is being built | Procurement Strategy Specialist |
| Specialist agents not found in database | Low | High | Prepare fallback plan to create agents from scratch | Database Specialist |
| Skill trigger conditions conflict with existing skills | Medium | Medium | Use unique para_section and specific trigger conditions | Blueprint + Sage |
| Cross-team coordination delays | Medium | Medium | Daily stand-ups, clear escalation paths | Orion + Sage |
| Mobile procurement features require additional infrastructure | Low | High | Phase mobile skills to depend on available infrastructure | Mobile Workflow Designer |

---

## Resource Requirements

### Agent Hours Estimate

| Phase | Team | Estimated Hours |
|-------|------|-----------------|
| Phase 1 | DomainForge AI | 14-19 hours |
| Phase 1 | PromptForge AI | 3-4 hours |
| Phase 2 | DomainForge AI | 10-13 hours |
| Phase 2 | InfraForge AI | 2-3 hours |
| Phase 3 | DevForge AI | 7-10 hours |
| Phase 3 | PromptForge AI | 3-4 hours |
| Phase 3 | QualityForge AI | 3-4 hours |
| Phase 4 | All Teams | 8-10 hours |
| Phase 5 | All Teams | 9-13 hours |
| **TOTAL** | | **59-80 hours** |

---

## Approval & Sign-Off

| Role | Agent | Status | Date |
|------|-------|--------|------|
| Plan Author | Procurement Review Team | ✅ Complete | 2026-03-31 |
| Technical Review | DevForge Orion | 📋 Pending | |
| Quality Review | QualityForge guardian | 📋 Pending | |
| Domain Review | DomainForge Orion | 📋 Pending | |
| Executive Approval | DevForge Orion + DomainForge Orion | 📋 Pending | |

---

*01900 Procurement Agent & Skills Remediation Plan — Version 1.0*
*Based on review completed: 2026-03-31*
*Estimated completion: 4 weeks from approval*