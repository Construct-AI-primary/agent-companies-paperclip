---
title: 00885 HSE Director Agent Naming Map
description: Naming conventions and agent registry for HSE Director discipline
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00885_hse-director/agent-data
gigabrain_tags: disciplines, 00885_hse-director, agent-naming, agent-registry
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00885_hse-director/agent-data/domain-knowledge/00885_DOMAIN-KNOWLEDGE.MD
---

# 00885 HSE Director Agent Naming Map

## Agent Naming Convention

| Agent Code | Agent Name | Team | Purpose |
|-----------|------------|------|--------|
| HSE-SAF-001 | Safety Performance Agent | HSE Team | TRIFR/LTIFR calculation, incident trend analysis, leading indicator monitoring |
| HSE-ENV-001 | Environmental Compliance Agent | HSE Team | Permit compliance, monitoring data validation, exceedance detection |
| HSE-AUD-001 | HSE Audit Agent | HSE Team | Audit scheduling, finding tracking, compliance rate calculation |
| HSE-INC-001 | Incident Investigation Agent | HSE Team | Root cause analysis support, similar incident identification, corrective action recommendations |
| HSE-TRN-001 | HSE Training Compliance Agent | HSE Team | Training matrix tracking, certification expiry alerts, competency verification |
| HSE-REG-001 | Regulatory Reporting Agent | HSE Team | Automated regulatory notification, report compilation, submission tracking |
| HSE-RPT-001 | HSE Executive Reporting Agent | HSE Team | Executive HSE briefing compilation, KPI dashboard updates |

## Team Structure

```
HSE Director (00885)
├── Safety Performance Agent (HSE-SAF-001)
├── Environmental Compliance Agent (HSE-ENV-001)
├── HSE Audit Agent (HSE-AUD-001)
├── Incident Investigation Agent (HSE-INC-001)
├── HSE Training Compliance Agent (HSE-TRN-001)
├── Regulatory Reporting Agent (HSE-REG-001)
└── HSE Executive Reporting Agent (HSE-RPT-001)
```

## Reporting Structure

All HSE agents report to the HSE Director with escalation to PromptForge Sage for governance validation and critical HSE decision support.

## Agent Coordination Workflow

```
Source System Data Refresh (scheduled or event-triggered)
    → Safety Performance Agent (HSE-SAF-001) analyses incident data
    → Environmental Compliance Agent (HSE-ENV-001) analyses monitoring data
    → HSE Audit Agent (HSE-AUD-001) analyses audit findings
    → Training Compliance Agent (HSE-TRN-001) analyses training matrix
    → Incident Investigation Agent (HSE-INC-001) analyses incident patterns
    → HSE Executive Reporting Agent (HSE-RPT-001) compiles executive briefing
    → Director reviews and approves
    → Regulatory Reporting Agent (HSE-REG-001) prepares regulatory submissions (if required)
```
