---
title: 00886 Logistics Director Agent Naming Map
description: Naming conventions and agent registry for Logistics Director discipline
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00886_logistics-director/agent-data
gigabrain_tags: disciplines, 00886_logistics-director, agent-naming, agent-registry
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00886_logistics-director/agent-data/domain-knowledge/00886_DOMAIN-KNOWLEDGE.MD
---

# 00886 Logistics Director Agent Naming Map

## Agent Naming Convention

| Agent Code | Agent Name | Team | Purpose |
|-----------|------------|------|--------|
| LOG-SUP-001 | Supplier Performance Agent | Logistics Team | Delivery tracking, quality monitoring, lead time analysis, supplier scorecarding |
| LOG-TRN-001 | Transportation Management Agent | Logistics Team | Route optimization, fleet tracking, freight cost analysis, carrier performance |
| LOG-WHS-001 | Warehouse Operations Agent | Logistics Team | Inventory management, space utilization, receiving/dispatch operations, stock rotation |
| LOG-INV-001 | Inventory Control Agent | Logistics Team | Stock level monitoring, reorder point calculation, slow-moving inventory identification |
| LOG-CST-001 | Freight Cost Agent | Logistics Team | Freight cost tracking, budget variance, cost optimization opportunities |
| LOG-CUS-001 | Customs and Compliance Agent | Logistics Team | Import/export documentation, customs clearance, regulatory compliance |
| LOG-RPT-001 | Logistics Executive Reporting Agent | Logistics Team | Executive logistics briefing compilation, KPI dashboard updates |

## Team Structure

```
Logistics Director (00886)
├── Supplier Performance Agent (LOG-SUP-001)
├── Transportation Management Agent (LOG-TRN-001)
├── Warehouse Operations Agent (LOG-WHS-001)
├── Inventory Control Agent (LOG-INV-001)
├── Freight Cost Agent (LOG-CST-001)
├── Customs and Compliance Agent (LOG-CUS-001)
└── Logistics Executive Reporting Agent (LOG-RPT-001)
```

## Reporting Structure

All Logistics agents report to the Logistics Director with escalation to PromptForge Sage for governance validation and critical logistics decision support.

## Agent Coordination Workflow

```
Source System Data Refresh (scheduled or event-triggered)
    → Supplier Performance Agent (LOG-SUP-001) analyses delivery data and quality metrics
    → Transportation Management Agent (LOG-TRN-001) analyses route performance and freight costs
    → Warehouse Operations Agent (LOG-WHS-001) analyses inventory levels and space utilization
    → Inventory Control Agent (LOG-INV-001) analyses stock levels and reorder requirements
    → Freight Cost Agent (LOG-CST-001) analyses costs and budget variance
    → Customs and Compliance Agent (LOG-CUS-001) verifies import/export compliance
    → Logistics Executive Reporting Agent (LOG-RPT-001) compiles executive briefing
    → Director reviews and approves
    → Stakeholder communications distributed (if required)
```
