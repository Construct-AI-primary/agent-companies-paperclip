---
title: 01900 Procurement Agent-to-Skill Mapping
description: Maps all procurement agents to their primary and supporting skills with environment assignments and cross-team coordination
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/01900_procurement/agent-data
gigabrain_tags: disciplines, 01900_procurement, agent-mapping, skill-assignment, domainforge, infraforge
openstinger_context: agent-staffing, skill-alignment, procurement-team
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/1900_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/01900_procurement/agent-data/prompts/01900_AI-NATIVE-PROCUREMENT-OPERATIONS-PROMPT.md
  - docs_construct_ai/codebase/agents/openclaw-teams/DomainForge_AI_Team.md
  - docs_construct_ai/codebase/agents/openclaw-teams/InfraForge_AI_Team.md
  - docs_construct_ai/disciplines/01900_procurement/agent-data/1900_AGENT-NAMING-MAP.MD
---

# 01900 Procurement Agent-to-Skill Mapping

**See also:** [1900_AGENT-NAMING-MAP.MD](./1900_AGENT-NAMING-MAP.MD) for legacy OpenClaw naming reconciliation (PROC-XXX-NNN → UUID).

## DomainForge AI Agents

| Agent | ID | Primary Skills | Supporting Skills | Environment |
|-------|----|----------------|------------------|-------------|
| **Procurement Strategy Specialist** | `a1a1a1a1-1111-1111-1111-111111111111` | procurement-order-management, sow-generation, approval-routing | procurement-data-extraction, supplier-evaluation | DevForge Dev + Staging |
| **Supplier Management Specialist** | `b2b2b2b2-2222-2222-2222-222222222222` | supplier-evaluation, procurement-order-management | procurement-data-extraction, procurement-compliance | DevForge Dev + Staging |
| **Contract Administration Specialist** | `c3c3c3c3-3333-3333-3333-333333333333` | contract-intelligence, procurement-document-generation, sow-generation | procurement-compliance, procurement-order-management | DevForge Dev + Staging |
| **Procurement Analytics Specialist** | `d4d4d4d4-4444-4444-4444-444444444444` | procurement-analytics, procurement-document-generation | procurement-data-extraction, supplier-evaluation | DevForge Dev + Staging |
| **Mobile Workflow Designer** | `e5e5e5e5-5555-5555-5555-555555555555` | mobile-procurement, voice-command-integration, gps-approval-configuration | offline-procurement, supply-chain-integration | DevForge Dev + Mobile Dev |
| **Mobile Testing Specialist** | `f6f6f6f6-6666-6666-6666-666666666666` | mobile-procurement, procurement-testing, offline-procurement | voice-command-integration, gps-approval-configuration | DevForge QA + Staging |
| **Financial Compliance Specialist** | `c9c9c9c9-9999-9999-9999-999999999999` | procurement-compliance, approval-routing, contract-intelligence | procurement-order-management, procurement-analytics | DevForge Dev + Staging |

## InfraForge AI Agents

| Agent | ID | Primary Skills | Supporting Skills | Environment |
|-------|----|----------------|------------------|-------------|
| **Mobile API Integration Specialist** | `a7a7a7a7-7777-7777-7777-777777777777` | supply-chain-integration, mobile-procurement | procurement-data-extraction, procurement-testing | InfraForge Dev + Staging |
| **Supply Chain Integration Specialist** | `b8b8b8b8-8888-8888-8888-888888888888` | supply-chain-integration, procurement-analytics | procurement-order-management, procurement-data-extraction | InfraForge Dev + Staging |

## Shared Team Agents

| Agent | Company | Primary Skills | Supporting Skills | Environment |
|-------|---------|----------------|------------------|-------------|
| **PromptForge Sage** | PromptForge | pre-task-assessment-readiness, workflow-implementation | procurement-testing, all procurement skills | PromptForge Dev + QA |
| **PromptForge Blueprint** | PromptForge | workflow-implementation, procurement-document-generation | procurement-order-management, sow-generation | PromptForge Dev |
| **QualityForge guardian** | QualityForge | procurement-testing, testing-verification | pre-task-assessment-readiness, all procurement skills | QualityForge QA + Staging |
| **QualityForge e2e** | QualityForge | procurement-testing | workflow-implementation | QualityForge QA |

## Complete Skills Inventory

### DomainForge AI Skills (14)
| Skill | Location | Primary Agent |
|-------|----------|---------------|
| `procurement-order-management` | `skills/domainforge_ai/procurement-order-management/SKILL.md` | Procurement Strategy Specialist |
| `supplier-evaluation` | `skills/domainforge_ai/supplier-evaluation/SKILL.md` | Supplier Management Specialist |
| `approval-routing` | `skills/domainforge_ai/approval-routing/SKILL.md` | Financial Compliance Specialist |
| `sow-generation` | `skills/domainforge_ai/sow-generation/SKILL.md` | Contract Administration Specialist |
| `template-management` | `skills/domainforge_ai/template-management/SKILL.md` | Procurement Analytics Specialist |
| `voice-command-integration` | `skills/domainforge_ai/voice-command-integration/SKILL.md` | Mobile Workflow Designer |
| `gps-approval-configuration` | `skills/domainforge_ai/gps-approval-configuration/SKILL.md` | Mobile Workflow Designer |
| `offline-procurement` | `skills/domainforge_ai/offline-procurement/SKILL.md` | Mobile Testing Specialist |
| `mobile-procurement` | `skills/domainforge_ai/mobile-procurement/SKILL.md` | Mobile Workflow Designer |
| `procurement-data-extraction` | `skills/domainforge_ai/procurement-data-extraction/SKILL.md` | Procurement Strategy Specialist |
| `procurement-document-generation` | `skills/domainforge_ai/procurement-document-generation/SKILL.md` | Contract Administration Specialist |
| `contract-intelligence` | `skills/domainforge_ai/contract-intelligence/SKILL.md` | Contract Administration Specialist |
| `procurement-analytics` | `skills/domainforge_ai/procurement-analytics/SKILL.md` | Procurement Analytics Specialist |
| `procurement-compliance` | `skills/domainforge_ai/procurement-compliance/SKILL.md` | Financial Compliance Specialist |

### InfraForge AI Skills (1)
| Skill | Location | Primary Agent |
|-------|----------|---------------|
| `supply-chain-integration` | `skills/infraforge_ai/supply-chain-integration/SKILL.md` | Supply Chain Integration Specialist |

### Shared Skills (3)
| Skill | Location | Primary Agent |
|-------|----------|---------------|
| `pre-task-assessment-readiness` | `skills/shared/pre-task-assessment-readiness/SKILL.md` | PromptForge Sage |
| `procurement-testing` | `skills/shared/procurement-testing/SKILL.md` | Mobile Testing Specialist |
| `testing-verification` | `skills/shared/testing-verification/SKILL.md` | QualityForge guardian |

## Cross-Team Coordination

### DomainForge ↔ InfraForge
| Handoff | Skills Involved | Agents |
|---------|----------------|--------|
| Mobile ↔ Supply Chain | mobile-procurement + supply-chain-integration | Mobile Workflow Designer + Supply Chain Integration Specialist |
| API Integration | supply-chain-integration + procurement-data-extraction | Mobile API Integration Specialist + Supplier Management Specialist |

### DomainForge ↔ PromptForge
| Handoff | Skills Involved | Agents |
|---------|----------------|--------|
| Task Readiness | pre-task-assessment-readiness + all skills | PromptForge Sage + all DomainForge |
| Workflow Architecture | workflow-implementation + procurement-order-management | PromptForge Blueprint + Procurement Strategy Specialist |

### DomainForge ↔ QualityForge
| Handoff | Skills Involved | Agents |
|---------|----------------|--------|
| Testing | procurement-testing + all skills | QualityForge guardian + all DomainForge |
| Quality Gates | testing-verification + workflow-implementation | QualityForge e2e + Mobile Testing Specialist |

## Coverage Analysis

| AI-Native Phase | Skills | Primary Agent |
|-----------------|--------|---------------|
| Phase 1: Foundation | procurement-data-extraction | Procurement Strategy Specialist |
| Phase 2: Order Creation | procurement-order-management | Procurement Strategy Specialist |
| Phase 3: Document Generation | procurement-document-generation | Contract Administration Specialist |
| Phase 4: Supplier Management | supplier-evaluation | Supplier Management Specialist |
| Phase 5: Approval & Compliance | approval-routing, procurement-compliance | Financial Compliance Specialist |
| Phase 6: Contract Intelligence | contract-intelligence | Contract Administration Specialist |
| Phase 7: Analytics & Reporting | procurement-analytics | Procurement Analytics Specialist |
| Phase 8: Safety & Governance | procurement-compliance | Financial Compliance Specialist |
| Mobile/UI | mobile-procurement, voice-command-integration, gps-approval-configuration, offline-procurement | Mobile Workflow Designer, Mobile Testing Specialist |
| Infrastructure | supply-chain-integration | Supply Chain Integration Specialist |
| Testing | procurement-testing | Mobile Testing Specialist, QualityForge |