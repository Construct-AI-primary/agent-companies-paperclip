---
title: 00425 Contracts Pre-Award Agent-to-Skill Mapping
description: Maps all pre-award agents to their primary and supporting skills with environment assignments and cross-team coordination
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00425_contracts-pre-award/agent-data
gigabrain_tags: disciplines, 00425_contracts-pre-award, agent-mapping, skill-assignment, agent-readiness
openstinger_context: pre-award-agent-assignment, skill-mapping, readiness-assessment
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00425_contracts-pre-award/agent-data/prompts/00425_AI-NATIVE-CONTRACTS-PRE-AWARD-PROMPT.md
  - docs_construct_ai/disciplines/00425_contracts-pre-award/agent-data/domain-knowledge/00425_DOMAIN-KNOWLEDGE.MD
---

# 00425 Contracts Pre-Award Agent-to-Skill Mapping

## Agent Registry

| Agent ID | Agent Name | Primary Role | Reports To | Specialization |
|----------|-----------|--------------|------------|----------------|
| 00425-001 | Tender Specification Agent | Tender specification generation from requirements | Contracts Pre-Award Manager | Technical requirements, scope definition, tender documentation |
| 00425-002 | Supplier Invitation Agent | Supplier identification and invitation management | Contracts Pre-Award Manager | Supplier database, pre-qualification, communication |
| 00425-003 | Tender Publication Agent | Tender publication and notice management | Contracts Pre-Award Manager | Publication channels, notice drafting, addenda |
| 00425-004 | Submission Compliance Agent | Submission compliance verification | Contracts Pre-Award Manager | Submission verification, completeness checking |
| 00425-005 | Evaluation Analysis Agent | Evaluation score analysis and summary generation | Contracts Pre-Award Manager | Evaluation processing, score analysis, recommendation drafting |
| 00425-006 | Award Recommendation Agent | Award recommendation generation | Contracts Pre-Award Manager | Award recommendation, notification management |
| 00425-007 | Contract Preparation Agent | Contract drafting from award decisions | Contracts Pre-Award Manager | Contract template generation, term drafting |
| 00425-008 | Compliance Monitoring Agent | Procurement compliance and conflict detection | Contracts Pre-Award Manager | Compliance checking, audit trail, conflict detection |

## Agent-to-Skill Mapping

| Agent | Primary Skill | Supporting Skills | Environment | Status |
|-------|--------------|-------------------|-------------|--------|
| 00425-001 Tender Specification Agent | `pre-award-tender-specification` | `pre-award-template-management` | dev, staging | Need Creation |
| 00425-002 Supplier Invitation Agent | `pre-award-supplier-invitation` | `shared/supplier-database` | dev, staging | Need Creation |
| 00425-003 Tender Publication Agent | `pre-award-tender-publication` | `pre-award-tender-specification` | dev, staging | Need Creation |
| 00425-004 Submission Compliance Agent | `pre-award-submission-compliance` | `shared/document-processing` | dev, staging, prod | Need Creation |
| 00425-005 Evaluation Analysis Agent | `pre-award-evaluation-analysis` | `shared/data-analysis` | dev, staging, prod | Need Creation |
| 00425-006 Award Recommendation Agent | `pre-award-award-recommendation` | `pre-award-evaluation-analysis` | dev, staging | Need Creation |
| 00425-007 Contract Preparation Agent | `pre-award-contract-preparation` | `shared/document-generation` | dev, staging | Need Creation |
| 00425-008 Compliance Monitoring Agent | `pre-award-compliance-monitoring` | `shared/audit-trail` | dev, staging, prod | Need Creation |

## Skills Required (To Be Created)

All 8 skills needed under `docs-construct-ai/skills/domainforge_ai/pre-award-[skill-name]/SKILL.md`:

| Priority | Skill Name | Description | Estimated Effort |
|----------|-----------|-------------|-----------------|
| Critical | `pre-award-tender-specification` | Tender specification generation from requirements | 2h |
| Critical | `pre-award-evaluation-analysis` | Evaluation score processing and analysis | 2h |
| Critical | `pre-award-submission-compliance` | Submission completeness and compliance verification | 1h |
| High | `pre-award-award-recommendation` | Award recommendation generation from evaluations | 2h |
| High | `pre-award-contract-preparation` | Contract drafting from award decisions | 1h |
| High | `pre-award-compliance-monitoring` | Procurement compliance checking and conflict detection | 2h |
| Medium | `pre-award-supplier-invitation` | Supplier identification and invitation management | 1h |
| Medium | `pre-award-tender-publication` | Tender publication and notice management | 1h |

## Cross-Team Coordination

| Team | Coordination Point | Shared Skills Used |
|------|-------------------|-------------------|
| Procurement (01900) | Supplier management and pre-qualification | `pre-award-supplier-invitation` |
| Contracts (00400) | Contract post-award handover | `pre-award-contract-preparation` |
| Legal (01750) | Contract terms legal review | `pre-award-compliance-monitoring` |

---

## Version History
- v1.0 (2026-04-01): Initial agent-to-skill mapping for Contracts Pre-Award discipline