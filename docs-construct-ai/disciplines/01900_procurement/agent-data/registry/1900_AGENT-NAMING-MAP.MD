---
title: 01900 Procurement Agent Naming Reconciliation
description: Mapping between legacy OpenClaw agent naming (PROC-XXX-NNN) and new specialist agent naming scheme with UUIDs
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/01900_procurement/agent-data
gigabrain_tags: disciplines, 01900_procurement, agent-naming, naming-standards, agent-registry
openstinger_context: agent-management, naming-convention, agent-standardization
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/01900_procurement/agent-data/1900_AGENTS-REGISTRY-SUMMARY.MD
  - docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/1900_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/codebase/agents/openclaw-teams/PROCUREMENT_WORKFLOW_TEAM_STAFFING_ANALYSIS.MD
  - docs_construct_ai/disciplines/01900_procurement/agent-data/01900_AGENT_SKILL_MAPPING.MD
---

# 01900 Procurement Agent Naming Reconciliation

**See also:** [01900_AGENT_SKILL_MAPPING.MD](./01900_AGENT_SKILL_MAPPING.MD) for skill assignments and cross-team coordination.

## Overview

This document reconciles the two naming schemes that existed for procurement agents:

1. **OpenClaw Naming (Legacy):** `PROC-ORD-001`, `PROC-SUP-001`, `PROC-REC-001`, `PROC-COST-001`, `PROC-RFQ-001` — domain knowledge file convention
2. **UUID Specialist Naming (Current):** UUID-based agents with descriptive names — specialist agent team convention

This document provides a definitive mapping so all systems and documentation reference the same agents consistently.

---

## Naming Convention Comparison

### Legacy OpenClaw Naming Scheme

| Legacy Name | Role | Description |
|-------------|------|-------------|
| `PROC-ORD-001` | Order Management Agent | Creates, approves, and tracks POs, WOs, and service orders |
| `PROC-SUP-001` | Supplier Coordination Agent | Tracks SO acknowledgments, delivery confirmations, supplier performance |
| `PROC-REC-001` | GRN / Service Entry Agent | Manages goods and service receipt verification |
| `PROC-COST-001` | Spend Tracking Agent | Monitors committed cost vs. budget, flags overspend |
| `PROC-RFQ-001` | RFQ / Quotation Agent | Processes RFQs and compares supplier quotations |

### Current UUID Specialist Naming Scheme

| Agent Name | ID | Role | Primary Skills |
|------------|----|------|---------------|
| Procurement Strategy | a1a1a1a1-1111-1111-1111-111111111111 | specialist | procurement-order-management, template-management |
| Supplier Management | b2b2b2b2-2222-2222-2222-222222222222 | specialist | supplier-evaluation |
| Contract Administration | c3c3c3c3-3333-3333-3333-333333333333 | specialist | sow-generation |
| Procurement Analytics | d4d4d4d4-4444-4444-4444-444444444444 | specialist | analytics and reporting |
| Mobile Workflow Designer | e5e5e5e5-5555-5555-5555-555555555555 | specialist | voice-command, gps-approval, offline-procurement |
| Mobile Testing | f6f6f6f6-6666-6666-6666-666666666666 | specialist | mobile testing and validation |
| Financial Compliance | c9c9c9c9-9999-9999-9999-999999999999 | specialist | approval-routing |
| Mobile API Integration | a7a7a7a7-7777-7777-7777-777777777777 | engineer | API integration, offline sync |
| Supply Chain Integration | b8b8b8b8-8888-8888-8888-888888888888 | engineer | supply-chain-integration |

---

## Definitive Mapping

| Legacy OpenClaw Name | Current UUID Agent(s) | Coverage Notes |
|---------------------|----------------------|---------------|
| `PROC-ORD-001` (Order Management) | Procurement Strategy (a1a1a1a1), Contract Administration (c3c3c3c3) | Order management split between Procurement Strategy (order creation) and Contract Admin (SOW generation) |
| `PROC-SUP-001` (Supplier Coordination) | Supplier Management (b2b2b2b2), Supply Chain Integration (b8b8b8b8) | Supplier coordination split between Supplier Management (qualification/performance) and Supply Chain Integration (portal/tracking) |
| `PROC-REC-001` (GRN / Service Entry) | Supplier Management (b2b2b2b2) | Receipt verification integrated into Supplier Management performance monitoring |
| `PROC-COST-001` (Spend Tracking) | Procurement Analytics (d4d4d4d4), Financial Compliance (c9c9c9c9) | Spend tracking split between Procurement Analytics (spend analysis/reporting) and Financial Compliance (budget validation) |
| `PROC-RFQ-001` (RFQ / Quotation) | Procurement Strategy (a1a1a1a1), Supplier Management (b2b2b2b2) | RFQ processing handled by Procurement Strategy (RFQ issuance/quotation comparison) and Supplier Management (supplier selection for RFQ) |

---

## Naming Standard — Going Forward

All procurement agents will be referenced using the **Current UUID Specialist Naming Scheme**. The legacy OpenClaw names are deprecated and should only be used when referencing historical documentation.

**Standard Reference Format:**
- **Full Reference:** `Agent Name (UUID)` — e.g., `Procurement Strategy (a1a1a1a1-1111-1111-1111-111111111111)`
- **Short Reference:** `Agent Name` — e.g., `Procurement Strategy` (when context is clear)
- **Code Reference:** UUID only — e.g., `a1a1a1a1-1111-1111-1111-111111111111` (in SQL, API calls, configuration)

---

## Files Requiring Updates

The following files reference the legacy OpenClaw naming and should be updated when the naming standardization task is completed:

| File | Legacy Reference | Update Required |
|------|-----------------|-----------------|
| `1900_DOMAIN-KNOWLEDGE.MD` Section 7.1 | PROC-ORD-001, PROC-SUP-001, etc. | Replace with current agent names |

---

## Rationale for Split

The legacy OpenClaw naming assigned one agent per functional area. The specialist naming scheme provides greater granularity for complex procurement workflows:

- **Order Management** → 2 agents (Procurement Strategy + Contract Administration)
- **Supplier Coordination** → 2 agents (Supplier Management + Supply Chain Integration)
- **Spend Tracking** → 2 agents (Procurement Analytics + Financial Compliance)
- **RFQ Processing** → 2 agents (Procurement Strategy + Supplier Management)

This split allows parallel processing, better skill specialization, and clearer accountability for each procurement workflow component.