---
title: 02025 Quantity Surveying Team — Agent/Skill Mapping
description: Mapping of AI agents to skills for the 02025_quantity-surveying discipline covering BOQ preparation, cost estimation, variation assessment, claims evaluation, interim valuation, and final account
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02025_quantity-surveying/agent-data/prompts
gigabrain_tags: disciplines, 02025_quantity-surveying, agent-skill-mapping, multi-agent-orchestration, boq-preparation, cost-estimation, variation-assessment, claims-evaluation, interim-valuation, final-account
openstinger_context: qs-agent-skill-relationships
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/02025_quantity-surveying/agent-data/domain-knowledge/02025_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/02025_quantity-surveying/agent-data/domain-knowledge/02025_GLOSSARY.MD
  - docs_construct_ai/disciplines/02025_quantity-surveying/agent-data/prompts/02025_AI-NATIVE-QUANTITY-SURVEYING-OPERATIONS-PROMPT.md
---

# 02025 Quantity Surveying Team — Agent/Skill Mapping

## Overview

Maps 8 quantity surveying AI agents to their primary and supporting skills across 6 key skill areas: BOQ preparation, cost estimation, variation assessment, claims evaluation, interim valuation, and final account.

---

## Agent Summary by Skill

### Skill: qs-boq-preparation
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | QS-BOQ-001 | deep-agents | BOQ item decomposition, quantity take-off, rate build-up, BOQ assembly |
| Supporting | QS-RATE-001 | deep-agents | Rate analysis, benchmarking, market quote validation |
| Supporting | QS-MEAS-001 | OpenClaw | NRM/CESMM measurement standards compliance checking |

### Skill: qs-cost-estimation
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | QS-ESTIMATE-001 | deep-agents | Cost estimation (order of magnitude through pre-tender), parametric estimation |
| Supporting | QS-RATE-001 | deep-agents | Rate database management, historical benchmarking |

### Skill: qs-variation-assessment
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | QS-VAR-001 | OpenClaw | Variation identification, scope analysis, pricing determination |
| Supporting | QS-BOQ-001 | deep-agents | BOQ rate extraction, comparable rate identification |
| Supporting | QS-CLAIMS-001 | deep-agents | Variation vs. claims classification |

### Skill: qs-claims-evaluation
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | QS-CLAIMS-001 | deep-agents | Claims classification, quantum evaluation, causation analysis |
| Supporting | QS-VAR-001 | OpenClaw | Variation overlap analysis |
| Supporting | QS-FA-001 | OpenClaw | Final account impact assessment |

### Skill: qs-interim-valuation
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | QS-IV-001 | OpenClaw | Interim payment certification, measurement verification, valuation calculations |
| Supporting | QS-MEAS-001 | OpenClaw | Measurement sheet verification |
| Supporting | QS-REPORT-001 | OpenClaw | Payment certificate generation |

### Skill: qs-final-account
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | QS-FA-001 | OpenClaw | Final account reconciliation, settlement, outstanding item resolution |
| Supporting | QS-CLAIMS-001 | deep-agents | Final claims assessment |
| Supporting | QS-VAR-001 | OpenClaw | All variation status verification |

---

## Agent Capability Summary

| Agent | Primary Skill(s) | Supporting Skill(s) | Environments | Total Skills |
|-------|-----------------|---------------------|-------------|-------------|
| QS-BOQ-001 | qs-boq-preparation | qs-variation-assessment | deep-agents | 2 |
| QS-RATE-001 | — | qs-boq-preparation, qs-cost-estimation | deep-agents | 2 |
| QS-MEAS-001 | — | qs-boq-preparation, qs-interim-valuation | OpenClaw | 2 |
| QS-ESTIMATE-001 | qs-cost-estimation | — | deep-agents | 1 |
| QS-VAR-001 | qs-variation-assessment | qs-claims-evaluation, qs-final-account | OpenClaw | 3 |
| QS-CLAIMS-001 | qs-claims-evaluation | qs-final-account | deep-agents | 2 |
| QS-IV-001 | qs-interim-valuation | — | OpenClaw | 1 |
| QS-FA-001 | qs-final-account | qs-claims-evaluation | OpenClaw | 2 |
| QS-RATE-001 | — | qs-boq-preparation, qs-cost-estimation | deep-agents | 2 |
| QS-REPORT-001 | — | qs-interim-valuation | OpenClaw | 1 |

---

## Cross-Team Agent Assignments

### OpenClaw Team (Orchestration, Workflow, Processing)
- QS-VAR-001, QS-MEAS-001, QS-IV-001, QS-FA-001, QS-REPORT-001
- **Total: 5 agents**

### deep-agents Team (Complex Analysis, Specialized Functions)
- QS-BOQ-001, QS-RATE-001, QS-ESTIMATE-001, QS-CLAIMS-001
- **Total: 4 agents**

### JS Swarm Team
- None currently assigned

### DevForge Team
- None currently assigned

**Grand Total: 9 agents mapped to 6 skills**

---

*02025 Quantity Surveying Team Agent/Skill Mapping — Version 1.0 — Last Updated: 2026-03-31*