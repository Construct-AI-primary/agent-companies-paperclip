---
title: Agent Delegation Map — 02400 Contractor Safety Management
description: Cross-company agent hierarchy, delegation flow, and capability mapping for SAFETY-CONTRACTOR
author: QualityForge AI / DomainForge AI
date: 2026-04-28
version: 1.0
---

# Agent Delegation Map — 02400 Contractor Safety Management

## Delegation Architecture

The SAFETY-CONTRACTOR project follows Paperclip's standard delegation model:
1. **CEO** creates root goal → decomposes into sub-tasks
2. **Lead agent** (guardian-qualityforge) receives assignment → further delegates to DomainForge safety specialists
3. **Domain experts** perform domain-specific safety checks → report results back up
4. **KnowledgeForge** provides metadata lookups on demand
5. **InfraForge** provides database/API support
6. **Results propagate upward** via status updates on `parentId` chain

## Agent Hierarchy

```
qualityforge-ceo (root goal owner)
├── guardian-qualityforge (safety execution lead)
│   │
│   ├── DESKTOP PLATFORM
│   │   ├── SAFETY-CONTRACTOR-001: Core Workflow Dashboard (solo)
│   │   ├── SAFETY-CONTRACTOR-002: Data Model & API (delegates to infraforge-ai-integration-specialist)
│   │   ├── SAFETY-CONTRACTOR-003: Reporting & Analytics (solo)
│   │   ├── SAFETY-CONTRACTOR-004: Record Management & Forms (solo)
│   │   └── SAFETY-CONTRACTOR-005: Integration & Notifications (delegates API checks)
│   │
│   ├── MOBILE PLATFORM
│   │   ├── SAFETY-CONTRACTOR-001: Field Data Capture (solo)
│   │   ├── SAFETY-CONTRACTOR-002: Offline Sync (delegates to infraforge-ai-integration-specialist)
│   │   ├── SAFETY-CONTRACTOR-003: Push Notifications & Alerts (solo)
│   │   ├── SAFETY-CONTRACTOR-004: List & Detail Views (solo)
│   │   └── SAFETY-CONTRACTOR-005: UX Polish & Accessibility (solo)
│   │
│   ├── domainforge-ai-architectural-integration (DomainForge AI)
│   │   └── Safety coordination — consulted for cross-module safety integration
│   │
│   ├── safety-domainforge (DomainForge AI)
│   │   └── Safety workflow automation — consulted for domain-specific workflows
│   │
│   ├── infraforge-ai-integration-specialist (InfraForge AI)
│   │   └── Support: SAFETY-CONTRACTOR-002 (desktop), SAFETY-CONTRACTOR-002 (mobile)
│   │
│   └── knowledge-manager (KnowledgeForge AI)
│       └── Support: metadata extraction, schema validation
```

## Issue-to-Agent Mapping

| Issue | Primary Agent | Sub-Agents | Delegation Pattern |
|-------|--------------|------------|-------------------|
| **DESKTOP** | | | |
| SAFETY-CONTRACTOR-001 | guardian-qualityforge | — | Solo execution |
| SAFETY-CONTRACTOR-002 | guardian-qualityforge | infraforge-ai-integration-specialist | DB/API design delegated |
| SAFETY-CONTRACTOR-003 | guardian-qualityforge | — | Solo execution |
| SAFETY-CONTRACTOR-004 | guardian-qualityforge | — | Solo execution |
| SAFETY-CONTRACTOR-005 | guardian-qualityforge | infraforge-ai-integration-specialist | Integration checks delegated |
| **MOBILE** | | | |
| SAFETY-CONTRACTOR-001 | guardian-qualityforge | — | Solo execution |
| SAFETY-CONTRACTOR-002 | guardian-qualityforge | infraforge-ai-integration-specialist | Sync engine delegated |
| SAFETY-CONTRACTOR-003 | guardian-qualityforge | — | Solo execution |
| SAFETY-CONTRACTOR-004 | guardian-qualityforge | — | Solo execution |
| SAFETY-CONTRACTOR-005 | guardian-qualityforge | — | Solo execution |

## Delegation RPC Flow

For each issue, the delegation flow follows:

```
1. CEO creates SAFETY-CONTRACTOR-XXX with assigneeAgentId
2. Assignee's heartbeat loop detects new assignment
3. Assignee reads issue description (goals, delegation prompt, QC checklist)
4. If sub-delegation needed → create sub-task with parentId=SAFETY-CONTRACTOR-XXX
5. Sub-agent executes → updates status on sub-task → status propagates to parent
6. Assignee aggregates sub-results → updates SAFETY-CONTRACTOR-XXX status
7. Phase gate evaluation: pass rate + critical issues = gate decision
```

## Heartbeat Loop Configuration

Every agent involved in SAFETY-CONTRACTOR should have:

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

## Risk: DomainForge Safety Agent Content

⚠ **Potential issue**: The `domainforge-ai-architectural-integration` and `safety-domainforge` agent directories should be verified for correct role content before SAFETY-CONTRACTOR execution. If these agents contain content referencing other roles (similar to the procurement-director issue found in PROCURE-TEST), they must be remediated before domain-specific delegation occurs.

---

**Version**: 1.0
**Last Updated**: 2026-04-28