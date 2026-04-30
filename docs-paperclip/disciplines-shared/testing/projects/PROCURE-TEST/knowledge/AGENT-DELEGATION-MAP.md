---
title: Agent Delegation Map — 01900 Procurement Testing
description: Cross-company agent hierarchy, delegation flow, and capability mapping for PROCURE-TEST
author: QualityForge AI / DomainForge AI
date: 2026-04-28
version: 1.0
---

# Agent Delegation Map — 01900 Procurement Testing

## Delegation Architecture

The PROCURE-TEST project follows Paperclip's standard delegation model:
1. **CEO** creates root goal → decomposes into sub-tasks
2. **Lead agent** (validator-qualityforge) receives assignment → further delegates to DomainForge specialists
3. **Domain experts** perform domain-specific checks → report results back up
4. **KnowledgeForge** provides metadata lookups on demand
5. **InfraForge** provides database/API support
6. **Results propagate upward** via status updates on `parentId` chain

## Agent Hierarchy

```
qualityforge-ceo (root goal owner)
├── validator-qualityforge (test execution lead)
│   ├── PROCURE-001: Page Foundation (solo)
│   ├── PROCURE-002: Database (delegates to database-infraforge)
│   ├── PROCURE-003: Agents State (solo)
│   ├── PROCURE-004: Upserts State (delegates DB checks)
│   ├── PROCURE-005: Workspace State (solo)
│   ├── PROCURE-006: Chatbot (solo)
│   ├── PROCURE-011: Integrations (delegates DB/API checks)
│   ├── PROCURE-012: UX/Compliance (solo)
│   ├── PROCURE-013a: Feedback Loop (solo)
│   └── PROCURE-014: Final Sign-off (aggregates all)
│
├── domainforge-ai-procurementdirector (DomainForge CEO)
│   ├── procurement-domainforge-procurement-contracts
│   │   ├── PROCURE-007: Workflow Orchestrator
│   │   └── PROCURE-008: Templates
│   ├── procurement-strategy-domainforge-procurement-strategy
│   │   └── PROCURE-010: Tenders
│   ├── supplier-management-domainforge-procurement
│   │   └── PROCURE-009: Suppliers
│   ├── procurement-analytics-domainforge-procurement-analytics
│   │   └── support role (consulted for data validation)
│   └── buyer-specialist-domainforge-procurement-specialist
│       └── support role (consulted for order validation)
│
├── database-infraforge (InfraForge)
│   └── Support: PROCURE-002, PROCURE-004, PROCURE-011
│
└── knowledge-manager (KnowledgeForge)
    └── Support: metadata extraction, schema validation
```

## Issue-to-Agent Mapping

| Issue | Primary Agent | Sub-Agents | Delegation Pattern |
|-------|--------------|------------|-------------------|
| PROCURE-001 | validator-qualityforge | — | Solo execution |
| PROCURE-002 | database-infraforge | — | Solo execution |
| PROCURE-003 | validator-qualityforge | — | Solo execution |
| PROCURE-004 | validator-qualityforge | database-infraforge | DB checks delegated |
| PROCURE-005 | validator-qualityforge | — | Solo execution (7 modals) |
| PROCURE-006 | validator-qualityforge | — | Solo execution |
| PROCURE-007 | procurement-domainforge-procurement-contracts | — | Domain expert solo |
| PROCURE-008 | procurement-domainforge-procurement-contracts | — | Domain expert solo |
| PROCURE-009 | supplier-management-domainforge-procurement | — | Domain expert solo |
| PROCURE-010 | procurement-strategy-domainforge-procurement-strategy | — | Domain expert solo |
| PROCURE-011 | validator-qualityforge | database-infraforge | DB checks delegated |
| PROCURE-012 | validator-qualityforge | — | Solo execution |
| PROCURE-013 | domainforge-ai-procurementdirector | All | CEO delegates to test delegation flow |
| PROCURE-013a | validator-qualityforge | All | Monitors all agents' activity |
| PROCURE-014 | validator-qualityforge | ALL | Aggregates results from all agents |

## Delegation RPC Flow

For each issue, the delegation flow follows:

```
1. CEO creates PROCURE-XXX with assigneeAgentId
2. Assignee's heartbeat loop detects new assignment
3. Assignee reads issue description (goals, delegation prompt, QC checklist)
4. If sub-delegation needed → create sub-task with parentId=PROCURE-XXX
5. Sub-agent executes → updates status on sub-task → status propagates to parent
6. Assignee aggregates sub-results → updates PROCURE-XXX status
7. Phase gate evaluation: pass rate + critical issues = gate decision
```

## Heartbeat Loop Configuration

Every agent involved in PROCURE-TEST should have:

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

## Risk: DomainForge Procurement Director

⚠ **Issue found**: The `domainforge-ai-procurementdirector` agent directory contains content referencing a "Dependency Manager" role, not a Procurement Director. This must be remediated before PROCURE-013 is executed. Suggested fix: update agent content to reflect Procurement Director role with delegation capabilities.

---

**Version**: 1.0
**Last Updated**: 2026-04-28