---
title: 01100 Ethics Team — Agent/Skill Mapping
description: Mapping of AI agents to skills, capabilities, and team assignments for the ethics discipline covering ABAC compliance, whistleblower management, due diligence, training compliance, and investigation reporting
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/01100_ethics/agent-data/prompts
gigabrain_tags: disciplines, 01100_ethics, agent-skill-mapping, multi-agent-orchestration, abac-compliance, whistleblower-management, due-diligence, ethics-training, investigation-reporting
openstinger_context: ethics-agent-skill-relationships
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/01100_ethics/agent-data/domain-knowledge/01100_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/01100_ethics/agent-data/domain-knowledge/01100_GLOSSARY.MD
  - docs_construct_ai/disciplines/01100_ethics/agent-data/prompts/01100_AI-NATIVE-ETHICS-OPERATIONS-PROMPT.md
---

# 01100 Ethics Team — Agent/Skill Mapping

## Overview

Maps 10 ethics AI agents to their primary and supporting skills across 5 key skill areas: ABAC compliance, whistleblower management, due diligence, training compliance, and investigation reporting. Each skill has one primary agent and 2-4 supporting agents.

---

## Agent Summary by Skill

### Skill: ethics-abac-compliance
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | ETH-ABAC-001 | OpenClaw | Anti-bribery policy enforcement, gifts/hospitality review, compliance monitoring |
| Supporting | ETH-INVEST-001 | OpenClaw | Investigation of ABAC violations |
| Supporting | ETH-SCREEN-001 | deep-agents | Sanctions screening and bribery red flag detection |

### Skill: ethics-whistleblower-management
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | ETH-WB-001 | OpenClaw | Whistleblower intake, de-identification, case logging, protection monitoring |
| Supporting | ETH-INVEST-001 | OpenClaw | Investigation coordination and evidence management |
| Supporting | ETH-COMPLIANCE-001 | OpenClaw | Compliance outcome tracking and reporting |

### Skill: ethics-due-diligence
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | ETH-DD-001 | deep-agents | Third-party background checks, risk scoring, clearance recommendations |
| Supporting | ETH-SCREEN-001 | deep-agents | Sanctions list screening (OFAC, UN, EU, local) |
| Supporting | ETH-REGISTRY-001 | OpenClaw | Third-party registry maintenance and clearance tracking |

### Skill: ethics-training-compliance
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | ETH-TRAIN-001 | OpenClaw | Training enrollment, delivery tracking, completion monitoring, gap analysis |
| Supporting | ETH-COMPLIANCE-001 | OpenClaw | Compliance reporting and dashboard updates |
| Supporting | ETH-AUDIT-001 | OpenClaw | Training completion audit trail and record maintenance |

### Skill: ethics-investigation-reporting
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | ETH-INVEST-001 | OpenClaw | Investigation coordination, evidence collection, findings documentation |
| Supporting | ETH-RISK-001 | deep-agents | Risk analysis, pattern detection, correlation with other cases |
| Supporting | ETH-REPORT-001 | OpenClaw | Report generation, trend analysis, management communication |

---

## Agent Capability Summary

| Agent | Primary Skill(s) | Supporting Skill(s) | Environments | Total Skills |
|-------|-----------------|---------------------|-------------|-------------|
| ETH-INVEST-001 | ethics-investigation-reporting | ethics-abac-compliance, ethics-whistleblower-management | OpenClaw | 3 |
| ETH-ABAC-001 | ethics-abac-compliance | — | OpenClaw | 1 |
| ETH-WB-001 | ethics-whistleblower-management | — | OpenClaw | 1 |
| ETH-DD-001 | ethics-due-diligence | — | deep-agents | 1 |
| ETH-SCREEN-001 | — | ethics-abac-compliance, ethics-due-diligence | deep-agents | 2 |
| ETH-TRAIN-001 | ethics-training-compliance | — | OpenClaw | 1 |
| ETH-COMPLIANCE-001 | — | ethics-training-compliance, ethics-whistleblower-management | OpenClaw | 2 |
| ETH-REGISTRY-001 | — | ethics-due-diligence | OpenClaw | 1 |
| ETH-REPORT-001 | — | ethics-investigation-reporting | OpenClaw | 1 |
| ETH-AUDIT-001 | — | ethics-training-compliance, ethics-investigation-reporting | OpenClaw | 2 |
| ETH-RISK-001 | — | ethics-investigation-reporting | deep-agents | 1 |

---

## Cross-Team Agent Assignments

### OpenClaw Team (Orchestration, Workflow, Processing)
- ETH-INVEST-001, ETH-ABAC-001, ETH-WB-001, ETH-TRAIN-001, ETH-COMPLIANCE-001, ETH-REGISTRY-001, ETH-REPORT-001, ETH-AUDIT-001
- **Total: 8 agents**

### deep-agents Team (Complex Analysis, Specialized Functions)
- ETH-DD-001, ETH-SCREEN-001, ETH-RISK-001
- **Total: 3 agents**

### JS Swarm Team (Transaction, Real-time, Mobile)
- None currently assigned
- **Total: 0 agents**

### DevForge Team (Code Quality, Standards)
- None currently assigned
- **Total: 0 agents**

**Grand Total: 11 agents mapped to 5 skills**

---

*01100 Ethics Team Agent/Skill Mapping — Version 1.0 — Last Updated: 2026-03-31*