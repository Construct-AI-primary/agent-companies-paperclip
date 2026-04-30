---
title: Agent Delegation Map — 00860 Electrical Engineering Workflows
description: Cross-company agent hierarchy, delegation flow, and capability mapping for ELEC-WORKFLOW
author: DomainForge AI / QualityForge AI
date: 2026-04-28
version: 1.0
---

# Agent Delegation Map — 00860 Electrical Engineering Workflows

## Delegation Architecture

The ELEC-WORKFLOW project follows Paperclip's standard delegation model:
1. **CEO** creates root goal → decomposes into sub-tasks
2. **Lead agent** (electrical-domainforge) receives assignment → further delegates to DomainForge electrical specialists
3. **Domain experts** perform domain-specific electrical engineering workflow automation → report results back up
4. **DevForge** provides UI/component implementation
5. **InfraForge** provides database/API support
6. **QualityForge** validates workflow correctness and compliance
7. **KnowledgeForge** provides metadata lookups on demand
8. **Results propagate upward** via status updates on `parentId` chain

## Agent Hierarchy

```
domainforge-ceo (root goal owner)
├── electrical-domainforge (electrical engineering execution lead)
│   │
│   ├── DESKTOP PLATFORM
│   │   ├── ELEC-001: Electrical Power Distribution Workflow (solo)
│   │   ├── ELEC-002: Traffic Signals & ITS Workflow (solo)
│   │   ├── ELEC-003: High Voltage Transmission Workflow (delegates to civil/structural specialists)
│   │   ├── ELEC-004: Generator & Power Plant Workflow (delegates to mechanical specialists)
│   │   ├── ELEC-005: Substation Design Workflow (delegates to civil/structural specialists)
│   │   ├── ELEC-006: Cable Selection & Reticulation Workflow (solo)
│   │   ├── ELEC-007: Electrical Maintenance Workflow (solo)
│   │   └── ELEC-008: Electrical Commissioning Workflow (solo)
│   │
│   ├── domainforge-ai-architectural-integration (DomainForge AI)
│   │   └── Electrical engineering coordination — consulted for cross-discipline integration
│   │
│   ├── devforge-ai-ui-implementation (DevForge AI)
│   │   └── Support: UI component implementation for all 8 workflow pages
│   │
│   ├── infraforge-ai-integration-specialist (InfraForge AI)
│   │   └── Support: Database schema, API endpoints for workflow data
│   │
│   ├── guardian-qualityforge (QualityForge AI)
│   │   └── Support: Workflow validation, compliance testing
│   │
│   └── knowledge-manager (KnowledgeForge AI)
│       └── Support: metadata extraction, standards reference lookups
```

## Issue-to-Agent Mapping

| Issue | Primary Agent | Sub-Agents | Delegation Pattern |
|-------|--------------|------------|-------------------|
| ELEC-001 | electrical-domainforge | — | Solo execution |
| ELEC-002 | electrical-domainforge | — | Solo execution |
| ELEC-003 | electrical-domainforge | civil-domainforge, structural-domainforge | Foundation/tower design delegated |
| ELEC-004 | electrical-domainforge | mechanical-domainforge | Generator mechanical systems delegated |
| ELEC-005 | electrical-domainforge | civil-domainforge, structural-domainforge | Substation civil/structural delegated |
| ELEC-006 | electrical-domainforge | — | Solo execution |
| ELEC-007 | electrical-domainforge | — | Solo execution |
| ELEC-008 | electrical-domainforge | — | Solo execution |

## Delegation RPC Flow

For each issue, the delegation flow follows:

```
1. CEO creates ELEC-XXX with assigneeAgentId
2. Assignee's heartbeat loop detects new assignment
3. Assignee reads issue description (goals, delegation prompt, QC checklist)
4. If sub-delegation needed → create sub-task with parentId=ELEC-XXX
5. Sub-agent executes → updates status on sub-task → status propagates to parent
6. Assignee aggregates sub-results → updates ELEC-XXX status
7. Phase gate evaluation: pass rate + critical issues = gate decision
```

## Heartbeat Loop Configuration

Every agent involved in ELEC-WORKFLOW should have:

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

## Cross-Discipline Delegation

| Issue | Cross-Discipline Dependency | Delegated To |
|-------|---------------------------|--------------|
| ELEC-003 | Tower foundation design | civil-domainforge (00850) |
| ELEC-003 | Structural analysis for transmission towers | structural-domainforge (00872) |
| ELEC-004 | Generator mechanical systems | mechanical-domainforge (00870) |
| ELEC-005 | Substation foundation design | civil-domainforge (00850) |
| ELEC-005 | Bus support structural analysis | structural-domainforge (00872) |
| ELEC-008 | Commissioning mechanical checks | mechanical-domainforge (00870) |

## Risk: DomainForge Electrical Agent Content

⚠ **Potential issue**: The `electrical-domainforge` and `domainforge-ai-architectural-integration` agent directories should be verified for correct role content before ELEC-WORKFLOW execution. If these agents contain content referencing other roles (similar to the procurement-director issue found in PROCURE-TEST), they must be remediated before domain-specific delegation occurs.

---

**Version**: 1.0
**Last Updated**: 2026-04-28