---
title: Agent Delegation Map — Multi-Type Procurement Tender System
description: Cross-company agent hierarchy, delegation flow, and capability mapping for MEASURE-TENDER
author: MeasureForge AI / DomainForge AI
date: 2026-04-28
version: 1.0
---

# Agent Delegation Map — Multi-Type Procurement Tender System

## Delegation Architecture

The MEASURE-TENDER project follows Paperclip's standard delegation model:
1. **CEO** creates root goal → decomposes into sub-tasks
2. **Lead agent** (measurement-ceo) receives assignment → further delegates to DomainForge and InfraForge specialists
3. **Domain experts** perform domain-specific implementation → report results back up
4. **Loopy AI** provides special-purpose automation and external portal support
5. **InfraForge** provides database/API infrastructure
6. **QualityForge** provides validation and cross-project coordination
7. **Results propagate upward** via status updates on `parentId` chain

## Agent Hierarchy

```
measurement-ceo (root goal owner — parent: MEASURE-ROOT-2026)
│
├── database-infraforge (InfraForge)
│   ├── MEASURE-TENDER-001: Database Schema & RLS Policies (solo)
│   ├── MEASURE-TENDER-003: API Routes & Authentication (sub-delegates route wiring)
│   └── MEASURE-TENDER-005: BUILDER-MEAS Workflow Integration (DB triggers)
│
├── procurement-domainforge-procurement-contracts (DomainForge)
│   ├── MEASURE-TENDER-002: Subcontract Integration Service (solo)
│   ├── MEASURE-TENDER-004: Sub-vendor Portal Manager UI (domain logic)
│   └── MEASURE-TENDER-005: Workflow Integration (contract orchestration)
│
├── procurement-strategy-domainforge-procurement-strategy (DomainForge)
│   └── MEASURE-TENDER-006a: External Portal — Public Pages (tender publication strategy)
│
├── loopy-ai (Loopy AI)
│   ├── MEASURE-TENDER-006a: External Portal — Public Pages (execution)
│   └── MEASURE-TENDER-006b: External Portal — Admin Dashboard (execution)
│
└── qualityforge-ai-validator (QualityForge AI)
    └── Cross-project coordination: PROCURE-TEST alignment for MEASURE-TENDER-004 UI components
```

## Issue-to-Agent Mapping

| Issue | Primary Agent | Sub-Agents | Delegation Pattern |
|-------|--------------|------------|-------------------|
| MEASURE-TENDER-001 | database-infraforge | — | Solo execution (DB schema + RLS) |
| MEASURE-TENDER-002 | procurement-domainforge-procurement-contracts | — | Domain expert solo (integration service) |
| MEASURE-TENDER-003 | database-infraforge | — | Solo execution (API routes + auth) |
| MEASURE-TENDER-004 | procurement-domainforge-procurement-contracts | loopy-ai | UI component domain logic + Loopy AI rendering |
| MEASURE-TENDER-005 | procurement-domainforge-procurement-contracts | database-infraforge | Domain orchestration + DB trigger support |
| MEASURE-TENDER-006a | procurement-strategy-domainforge-procurement-strategy | loopy-ai | Strategy + Loopy AI execution |
| MEASURE-TENDER-006b | loopy-ai | — | Solo execution (admin dashboard) |

## Delegation RPC Flow

For each issue, the delegation flow follows:

```
1. CEO creates MEASURE-TENDER-XXX with assigneeAgentId
2. Assignee's heartbeat loop detects new assignment
3. Assignee reads issue description (goals, delegation prompt, QC checklist)
4. If sub-delegation needed → create sub-task with parentId=MEASURE-TENDER-XXX
5. Sub-agent executes → updates status on sub-task → status propagates to parent
6. Assignee aggregates sub-results → updates MEASURE-TENDER-XXX status
7. Phase gate evaluation: pass rate + critical issues = gate decision
```

## Heartbeat Loop Configuration

Every agent involved in MEASURE-TENDER should have:

```yaml
heartbeat:
  frequency: "15min"
  poll_endpoint: "GET /api/issues?assigneeAgentId={self}&status=in_progress"
  on_assignment:
    - "Read issue description and goals"
    - "Extract QC checklist from knowledge bundle"
    - "Begin execution with first checklist item"
  status_updates:
    - "Set issue status to 'in_progress'"
    - "Log activity via POST /api/companies/{companyId}/activity"
    - "On completion: set status to 'in_review' or 'done'"
```

## Cross-Project Coordination: PROCURE-TEST Overlap

MEASURE-TENDER-004 creates 10 new React components inside `01900-procurement/components/subcontract-rfq/`. These share the same page directory as components tested by PROCURE-TEST.

**Coordination Strategy**: Build → Test Once
1. MEASURE-TENDER-004 builds first — New components are built inside the 01900 page directory
2. PROCURE-TEST runs once against the final combined page
3. No regression pass needed — Single test pass validates exactly what ships to production

**Agent Coordination**:
- procurement-domainforge-procurement-contracts (MEASURE-TENDER-004 primary) coordinates with validator-qualityforge (PROCURE-TEST lead)
- qualityforge-ai-validator monitors MEASURE-TENDER-004 completion via heartbeat before triggering PROCURE-TEST Phase 2 re-execution

---

**Version**: 1.0
**Last Updated**: 2026-04-28
