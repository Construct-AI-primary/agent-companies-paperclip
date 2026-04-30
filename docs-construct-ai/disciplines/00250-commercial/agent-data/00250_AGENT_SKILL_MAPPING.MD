---
title: 00250 Commercial Agent-to-Skill Mapping
description: Maps all Commercial discipline agents to their primary and supporting skills with environment assignments and cross-team coordination
version: 3.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00250-commercial/agent-data
gigabrain_tags: disciplines, 00250-commercial, agent-skill-mapping, skills-assessment
openstinger_context: commercial-agent-readiness, skill-alignment
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00250-commercial/agent-data/prompts/00250_AI-NATIVE-COMMERCIAL-PROMPT.md
  - docs_construct_ai/disciplines/00250-commercial/agent-data/domain-knowledge/00250_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/skills/domainforge_ai/00250-commercial/commercial-approval-routing/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/00250-commercial/commercial-supplier-evaluation/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/shared/commercial-document-generation/SKILL.md
---

# 00250 Commercial Agent-to-Skill Mapping

## Naming Convention

All commercial discipline skills use the `commercial-` prefix:
- Existing skills renamed: `commercial-approval-routing`, `commercial-supplier-evaluation`
- New skills follow pattern: `commercial-[capability-name]`
- Shared skills from other disciplines maintain their prefix (e.g., `contract-intelligence` from 00400)

## Agent Registry

| Agent ID | Agent Name | Primary Role | Report To |
|----------|-----------|-------------|-----------|
| COM-001 | Commercial Coordinator Agent | Orchestrates commercial operations, risk tracking, multi-agent coordination | Commercial Manager |
| COM-002 | Commercial Contract Administrator Agent | Drafts contract documents, tracks milestones, manages amendments, obligation tracking | Commercial Coordinator |
| COM-003 | Commercial Procurement Specialist Agent | Manages supplier qualification, tender administration, supplier evaluation | Commercial Coordinator |
| COM-004 | Commercial Market Intelligence Agent | Market research, competitor analysis, pricing benchmarks, predictive intelligence | Commercial Manager |
| COM-005 | Commercial Correspondence Agent | Commercial correspondence drafting, communication tracking, stakeholder relationship | Commercial Coordinator |
| COM-006 | Commercial Cost Controller Agent | Cost analysis, pricing, quantity take-off, cost reporting, claims quantification | Commercial Manager |
| COM-007 | Commercial Clause Extraction Agent | Contract clause extraction, interpretation, cross-reference checking | Commercial Contract Administrator |
| COM-008 | Commercial Negotiation Support Agent | BATNA analysis, concession tracking, negotiation strategy, outcome prediction | Commercial Coordinator |
| COM-009 | Commercial Variation & Claims Agent | Variation order analysis, claim quantification, precedent analysis | Commercial Coordinator |
| COM-010 | Commercial Compliance Monitoring Agent | Commercial compliance, regulatory checking, performance bond tracking, obligation monitoring | Commercial Contract Administrator |
| COM-011 | Commercial Risk Register Agent | Risk identification, assessment scoring, mitigation tracking, counterparty risk prediction | Commercial Coordinator |
| COM-012 | Commercial Approval Routing Agent | Value-based approval routing, delegated authority enforcement, escalation management | Commercial Coordinator |
| COM-013 | Commercial Document Generation Agent | Template population, structured data injection, quality validation, audit trail | Commercial Coordinator |
| COM-014 | Commercial Cash Flow & Forecasting Agent | Payment tracking, milestone billing, cost escalation forecasting, cash flow prediction | Commercial Cost Controller |

## Complete Skills Inventory (28 Skills — All with commercial- prefix)

### Critical Skills (must exist for core operations)

| # | Skill Name | Folder Path | Primary Agent | Priority | Status | Description |
|---|-----------|-------------|--------------|----------|--------|-------------|
| 1 | commercial-approval-routing | skills/domainforge_ai/00250-commercial/commercial-approval-routing/ | COM-012 | Critical | ✅ Exists | Value-based approval routing through delegated authority matrix |
| 2 | commercial-supplier-evaluation | skills/domainforge_ai/00250-commercial/commercial-supplier-evaluation/ | COM-003 | Critical | ✅ Exists | Supplier qualification and scoring with configurable criteria |
| 3 | commercial-clause-extraction | skills/domainforge_ai/00250-commercial/commercial-clause-extraction/ | COM-007 | Critical | ❌ Missing | NLP-based clause extraction from contracts with reference tagging |
| 4 | commercial-contract-interpretation | skills/domainforge_ai/00250-commercial/commercial-contract-interpretation/ | COM-007 | Critical | ❌ Missing | Contract term interpretation, cross-reference checking, clause comparison |
| 5 | commercial-correspondence-drafting | skills/domainforge_ai/00250-commercial/commercial-correspondence-drafting/ | COM-005 | Critical | ❌ Missing | Professional commercial correspondence generation with template injection |
| 6 | commercial-contract-drafting | skills/domainforge_ai/00250-commercial/commercial-contract-drafting/ | COM-002 | Critical | ❌ Missing | Contract document generation with structured data injection |
| 7 | commercial-obligation-tracking | skills/domainforge_ai/00250-commercial/commercial-obligation-tracking/ | COM-002 | Critical | ❌ Missing | Contract obligation lifecycle monitoring and compliance verification |

### High Priority Skills

| # | Skill Name | Folder Path | Primary Agent | Priority | Status | Description |
|---|-----------|-------------|--------------|----------|--------|-------------|
| 8 | commercial-tender-document-preparation | skills/domainforge_ai/00250-commercial/commercial-tender-document-preparation/ | COM-003 | High | ❌ Missing | RFP/RFQ package generation with evaluation criteria and scope injection |
| 9 | commercial-quotation-analysis | skills/domainforge_ai/00250-commercial/commercial-quotation-analysis/ | COM-003 | High | ❌ Missing | Supplier quotation comparison against BOQ and budget benchmarks |
| 10 | commercial-negotiation-strategy | skills/domainforge_ai/00250-commercial/commercial-negotiation-strategy/ | COM-008 | High | ❌ Missing | Counterparty analysis, BATNA assessment, concession planning |
| 11 | commercial-risk-assessment | skills/domainforge_ai/00250-commercial/commercial-risk-assessment/ | COM-011 | High | ❌ Missing | Risk identification, scoring, mitigation strategy generation |
| 12 | commercial-risk-register-management | skills/domainforge_ai/00250-commercial/commercial-risk-register-management/ | COM-011 | High | ❌ Missing | Risk register CRUD operations, score updates, mitigation tracking |
| 13 | commercial-counterparty-risk-assessment | skills/domainforge_ai/00250-commercial/commercial-counterparty-risk-assessment/ | COM-011 | High | ❌ Missing | Financial analysis, market conditions, performance history evaluation |
| 14 | commercial-claim-quantification | skills/domainforge_ai/00250-commercial/commercial-claim-quantification/ | COM-009 | High | ❌ Missing | Contract clause identification, impact calculation, evidence gathering |
| 15 | commercial-variation-order-analysis | skills/domainforge_ai/00250-commercial/commercial-variation-order-analysis/ | COM-009 | High | ❌ Missing | Rate application, impact assessment, precedent analysis |

### Medium Priority Skills

| # | Skill Name | Folder Path | Primary Agent | Priority | Status | Description |
|---|-----------|-------------|--------------|----------|--------|-------------|
| 16 | commercial-pricing-analysis | skills/domainforge_ai/00250-commercial/commercial-pricing-analysis/ | COM-006 | Medium | ❌ Missing | Historical rate analysis, market benchmarking, cost escalation trends |
| 17 | commercial-cost-estimation | skills/domainforge_ai/00250-commercial/commercial-cost-estimation/ | COM-006 | Medium | ❌ Missing | Quantity take-off, unit rate application, BOQ cost calculation |
| 18 | commercial-contract-amendment | skills/domainforge_ai/00250-commercial/commercial-contract-amendment/ | COM-002 | Medium | ❌ Missing | Amendment drafting, version control, approval routing for changes |
| 19 | commercial-dispute-resolution | skills/domainforge_ai/00250-commercial/commercial-dispute-resolution/ | COM-008 | Medium | ❌ Missing | Evidence gathering, precedent analysis, position paper generation |
| 20 | commercial-compliance-monitoring | skills/domainforge_ai/00250-commercial/commercial-compliance-monitoring/ | COM-010 | Medium | ❌ Missing | Obligation verification, regulatory checking, compliance reporting |
| 21 | commercial-milestone-billing | skills/domainforge_ai/00250-commercial/commercial-milestone-billing/ | COM-006 | Medium | ❌ Missing | Milestone tracking, billing generation, payment schedule management |

### AI-Native Skills (predictive and intelligence capabilities)

| # | Skill Name | Folder Path | Primary Agent | Priority | Status | Description |
|---|-----------|-------------|--------------|----------|--------|-------------|
| 22 | commercial-market-intelligence | skills/domainforge_ai/00250-commercial/commercial-market-intelligence/ | COM-004 | Medium | ❌ Missing | Market trend analysis, competitor monitoring, opportunity identification |
| 23 | commercial-predictive-counterparty-risk | skills/domainforge_ai/00250-commercial/commercial-predictive-counterparty-risk/ | COM-004 | Medium | ❌ Missing | Counterparty risk prediction from payment history and market trends |
| 24 | commercial-cost-escalation-forecasting | skills/domainforge_ai/00250-commercial/commercial-cost-escalation-forecasting/ | COM-014 | Medium | ❌ Missing | Commodity price trends, currency impact, historical escalation prediction |
| 25 | commercial-negotiation-outcome-prediction | skills/domainforge_ai/00250-commercial/commercial-negotiation-outcome-prediction/ | COM-008 | Medium | ❌ Missing | Historical negotiation pattern analysis, outcome probability |
| 26 | commercial-cash-flow-prediction | skills/domainforge_ai/00250-commercial/commercial-cash-flow-prediction/ | COM-014 | Medium | ❌ Missing | Contract milestone scheduling, payment term analysis, cash flow forecasting |
| 27 | commercial-document-template-management | skills/domainforge_ai/00250-commercial/commercial-document-template-management/ | COM-013 | Low | ❌ Missing | Template creation, version control, structured data injection, quality validation |
| 28 | commercial-contract-query | skills/domainforge_ai/00250-commercial/commercial-contract-query/ | COM-007 | Low | ❌ Missing | Natural language contract queries, clause retrieval, structured response |

## Cross-Team Skill Sharing

| Shared Skill | Source Discipline | Target Commercial Agents | Purpose |
|-------------|-------------------|-------------------------|---------|
| contract-intelligence | 00400_contracts | COM-002, COM-007, COM-010 | Clause extraction, obligation analysis, contract interpretation |
| pre-award-award-recommendation | 00425_contracts-pre-award | COM-003 | Tender evaluation and award recommendations |
| pre-award-contract-preparation | 00425_contracts-pre-award | COM-003 | Pre-award document and contract preparation |
| approval-routing | 00250-commercial (existing) | All discipline agents | Cross-discipline approval workflows |

## Skills Creation Priority

### Phase 1 — Critical Foundation (6 skills)
1. commercial-clause-extraction
2. commercial-contract-interpretation
3. commercial-correspondence-drafting
4. commercial-contract-drafting
5. commercial-obligation-tracking
6. commercial-contract-amendment

### Phase 2 — Core Operations (8 skills)
7. commercial-tender-document-preparation
8. commercial-quotation-analysis
9. commercial-negotiation-strategy
10. commercial-risk-assessment
11. commercial-risk-register-management
12. commercial-counterparty-risk-assessment
13. commercial-claim-quantification
14. commercial-variation-order-analysis

### Phase 3 — Commercial Intelligence (6 skills)
15. commercial-pricing-analysis
16. commercial-cost-estimation
17. commercial-dispute-resolution
18. commercial-compliance-monitoring
19. commercial-milestone-billing
20. commercial-document-template-management

### Phase 4 — AI-Native Predictive (6 skills)
21. commercial-market-intelligence
22. commercial-predictive-counterparty-risk
23. commercial-cost-escalation-forecasting
24. commercial-negotiation-outcome-prediction
25. commercial-cash-flow-prediction
26. commercial-contract-query

## Agent-to-Skill Assignments

| Agent ID | Primary Skills | Supporting Skills | Supporting (Shared) |
|----------|---------------|-------------------|---------------------|
| COM-001 | commercial-risk-assessment | commercial-approval-routing | contract-intelligence |
| COM-002 | commercial-contract-drafting, commercial-obligation-tracking, commercial-contract-amendment | commercial-clause-extraction | contract-intelligence |
| COM-003 | commercial-supplier-evaluation, commercial-tender-document-preparation, commercial-quotation-analysis | commercial-approval-routing | pre-award-award-recommendation |
| COM-004 | commercial-market-intelligence, commercial-predictive-counterparty-risk | commercial-pricing-analysis | (none) |
| COM-005 | commercial-correspondence-drafting | commercial-approval-routing | commercial-document-template-management |
| COM-006 | commercial-cost-estimation, commercial-pricing-analysis, commercial-milestone-billing | commercial-claim-quantification | (none) |
| COM-007 | commercial-clause-extraction, commercial-contract-interpretation, commercial-contract-query | commercial-compliance-monitoring | contract-intelligence |
| COM-008 | commercial-negotiation-strategy, commercial-dispute-resolution | commercial-negotiation-outcome-prediction | (none) |
| COM-009 | commercial-claim-quantification, commercial-variation-order-analysis | commercial-contract-interpretation | (none) |
| COM-010 | commercial-compliance-monitoring, commercial-obligation-tracking | commercial-risk-assessment | contract-intelligence |
| COM-011 | commercial-risk-register-management, commercial-risk-assessment | commercial-counterparty-risk-assessment | (none) |
| COM-012 | commercial-approval-routing | (none) | (none) |
| COM-013 | commercial-document-template-management | commercial-correspondence-drafting | commercial-contract-drafting |
| COM-014 | commercial-cash-flow-prediction, commercial-cost-escalation-forecasting | commercial-pricing-analysis | (none) |

## Readiness Assessment

| Dimension | Score (1-10) | Notes |
|-----------|-------------|-------|
| Skills Coverage | 7.1 | 2 of 28 required skills exist; 4 available from 00425_contracts-pre-award; 3 from 00400_contracts |
| Agent Definitions | 9.0 | 14 agents defined with clear roles and reporting structure |
| Domain Knowledge | 9.0 | Complete with Part 6B AI-Native Operations section |
| Prompt Integration | 8.0 | Prompt created, references existing skills correctly |
| Safety Boundaries | 9.0 | Well-defined non-delegable decisions and AI must always disclose |
| Cross-Team Alignment | 7.0 | 7 skills available from shared disciplines |
| **Overall Readiness** | **6.8** | Needs 26 new discipline-specific skills to reach 10.0 |

## Recommended Next Steps

1. **Rename existing skills**: Move approval-routing → commercial-approval-routing, supplier-evaluation → commercial-supplier-evaluation
2. **Phase 1 (Critical):** Create 6 foundation skills — commercial-clause-extraction, commercial-contract-interpretation, commercial-correspondence-drafting, commercial-contract-drafting, commercial-obligation-tracking, commercial-contract-amendment
3. **Phase 2 (Core):** Create 8 operational skills — commercial-tender-document-preparation, commercial-quotation-analysis, commercial-negotiation-strategy, commercial-risk-assessment, commercial-risk-register-management, commercial-counterparty-risk-assessment, commercial-claim-quantification, commercial-variation-order-analysis
4. **Phase 3 (Intelligence):** Create 6 commercial intelligence skills
5. **Phase 4 (AI-Native):** Create 6 predictive/intelligence skills
6. **Validation:** Verify all 28 skills pass 6-dimension validation (structure, frontmatter, cross-refs, domain alignment, glossary, agents)