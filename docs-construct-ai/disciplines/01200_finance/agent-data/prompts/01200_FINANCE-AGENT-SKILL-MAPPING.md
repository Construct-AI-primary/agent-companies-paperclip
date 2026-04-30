---
title: 01200 Finance Team — Agent/Skill Mapping
description: Mapping of AI agents to skills for the 01200_finance discipline covering invoice processing, financial reporting, cash flow forecasting, tax compliance, and cost tracking
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/01200_finance/agent-data/prompts
gigabrain_tags: disciplines, 01200_finance, agent-skill-mapping, multi-agent-orchestration, invoice-processing, financial-reporting, cash-flow-forecasting, tax-compliance, cost-tracking
openstinger_context: finance-agent-skill-relationships
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/01200_finance/agent-data/domain-knowledge/01200_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/01200_finance/agent-data/domain-knowledge/01200_GLOSSARY.MD
  - docs_construct_ai/disciplines/01200_finance/agent-data/prompts/01200_AI-NATIVE-FINANCE-OPERATIONS-PROMPT.md
---

# 01200 Finance Team — Agent/Skill Mapping

## Overview

Maps 10 finance AI agents to their primary and supporting skills across 5 key skill areas: invoice processing, financial reporting, cash flow forecasting, tax compliance, and cost tracking.

---

## Agent Summary by Skill

### Skill: finance-invoice-processing
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | FIN-INVOICE-001 | OpenClaw | Invoice intake, OCR extraction, structured data parsing |
| Supporting | FIN-3WAY-001 | OpenClaw | Three-way match orchestration (PO, GRN, invoice) |
| Supporting | FIN-AUDIT-001 | OpenClaw | Audit trail maintenance for all match results and approvals |

### Skill: finance-financial-reporting
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | FIN-REPORT-001 | OpenClaw | Monthly financial report generation, data aggregation, variance analysis |
| Supporting | FIN-COST-001 | deep-agents | Budget vs actual computation, cost-to-complete estimates |
| Supporting | FIN-AUDIT-001 | OpenClaw | Report accuracy verification and audit trail |

### Skill: finance-cash-flow-forecasting
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | FIN-CASHFLOW-001 | deep-agents | Cash flow forecasting, historical pattern analysis, scenario modeling |
| Supporting | FIN-PAY-001 | OpenClaw | Payment schedule coordination, obligation tracking |

### Skill: finance-tax-compliance
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | FIN-TAX-001 | deep-agents | Tax calculation, return generation, filing preparation |
| Supporting | FIN-INVOICE-001 | OpenClaw | VAT/WHT-applicable transaction categorization |
| Supporting | FIN-AUDIT-001 | OpenClaw | Tax documentation maintenance for audit |

### Skill: finance-cost-tracking
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | FIN-COST-001 | deep-agents | Budget vs actual analysis, variance detection, cost-to-complete |
| Supporting | FIN-GL-001 | OpenClaw | GL posting, cost code verification, reconciliation |
| Supporting | FIN-3WAY-001 | OpenClaw | PO matching for committed cost tracking |

---

## Agent Capability Summary

| Agent | Primary Skill(s) | Supporting Skill(s) | Environments | Total Skills |
|-------|-----------------|---------------------|-------------|-------------|
| FIN-INVOICE-001 | finance-invoice-processing | finance-tax-compliance | OpenClaw | 2 |
| FIN-3WAY-001 | — | finance-invoice-processing, finance-cost-tracking | OpenClaw | 2 |
| FIN-REPORT-001 | finance-financial-reporting | — | OpenClaw | 1 |
| FIN-COST-001 | finance-cost-tracking | finance-financial-reporting | deep-agents | 2 |
| FIN-CASHFLOW-001 | finance-cash-flow-forecasting | — | deep-agents | 1 |
| FIN-PAY-001 | — | finance-cash-flow-forecasting | OpenClaw | 1 |
| FIN-TAX-001 | finance-tax-compliance | — | deep-agents | 1 |
| FIN-GL-001 | — | finance-cost-tracking | OpenClaw | 1 |

---

## Cross-Team Agent Assignments

### OpenClaw Team (Orchestration, Workflow, Processing)
- FIN-INVOICE-001, FIN-3WAY-001, FIN-REPORT-001, FIN-PAY-001, FIN-GL-001
- **Total: 5 agents**

### deep-agents Team (Complex Analysis, Specialized Functions)
- FIN-COST-001, FIN-CASHFLOW-001, FIN-TAX-001
- **Total: 3 agents**

### JS Swarm Team
- None currently assigned

### DevForge Team
- FIN-AUDIT-001 (supporting across all skills)
- **Total: 1 agent**

**Grand Total: 9 agents mapped to 5 skills**

---

*01200 Finance Team Agent/Skill Mapping — Version 1.0 — Last Updated: 2026-03-31*