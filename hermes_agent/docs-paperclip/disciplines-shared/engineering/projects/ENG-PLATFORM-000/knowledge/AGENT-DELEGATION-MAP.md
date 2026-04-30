---
title: "Agent Delegation Map — ENG-PLATFORM-000 Cross-Discipline Engineering Platform"
description: "Cross-company agent hierarchy, delegation flow, and capability mapping for ENG-PLATFORM-000"
author: "DevForge AI / DomainForge AI"
date: "2026-04-28"
version: "1.0"
---

# Agent Delegation Map — ENG-PLATFORM-000 Cross-Discipline Engineering Platform

## Delegation Architecture

The ENG-PLATFORM-000 project follows Paperclip's standard delegation model:
1. **CEO** (devforge-ceo) creates root goal → decomposes into sub-tasks
2. **Lead agent** per phase receives assignment → further delegates to specialists
3. **Domain experts** perform domain-specific work → report results back up
4. **KnowledgeForge** provides metadata lookups on demand
5. **InfraForge** provides database/API support
6. **Results propagate upward** via status updates on `parentId` chain

## Agent Hierarchy

```
devforge-ceo (root goal owner)
├── devcore-devforge (Platform Lead)
│   ├── ENG-PLATFORM-001: Shared Components (solo)
│   ├── ENG-PLATFORM-003: Database Schema (delegates to database-infraforge)
│   ├── ENG-PLATFORM-007: Multi-CAD Framework (solo)
│   └── ENG-PLATFORM-009: BIM 360 Sync (solo)
│
├── interface-devforge (UI/UX Lead)
│   ├── ENG-PLATFORM-002: Discipline Config (solo)
│   ├── ENG-PLATFORM-010: Accordion Templates (solo)
│   └── ENG-PLATFORM-011: Shared Routing (solo)
│
├── codesmith-devforge (CAD Lead)
│   └── ENG-PLATFORM-008: Discipline CAD Agents (solo)
│
├── domainforge-ai-engineeringdirector (DomainForge CEO)
│   ├── civil-domainforge
│   │   └── ENG-PLATFORM-012: Civil Engineering Pilot
│   ├── structural-domainforge
│   │   └── ENG-PLATFORM-013: Structural Engineering Pilot
│   └── mep-domainforge
│       └── ENG-PLATFORM-014: MEP Engineering Pilot
│
├── knowledge-manager (KnowledgeForge)
│   ├── ENG-PLATFORM-004: KnowledgeForge AI Integration (solo)
│   └── Support: metadata extraction, standards indexing
│
├── learningforge-ai-lead (LearningForge)
│   └── ENG-PLATFORM-005: LearningForge AI Integration (solo)
│
├── integrateforge-ai-lead (IntegrateForge)
│   └── Support: API coordination for ENG-PLATFORM-007, 008, 009
│
├── database-infraforge (InfraForge)
│   └── Support: ENG-PLATFORM-003, schema validation
│
└── validator-qualityforge (QualityForge QA)
    ├── ENG-PLATFORM-015: Integration Testing (solo)
    ├── ENG-PLATFORM-016: Performance Testing (solo)
    └── ENG-PLATFORM-017: User Acceptance Testing (solo)
```

## Issue-to-Agent Mapping

| Issue | Primary Agent | Company | Sub-Agents | Delegation Pattern |
|-------|--------------|---------|------------|-------------------|
| ENG-PLATFORM-001 | devcore-devforge | devforge-ai | — | Solo execution |
| ENG-PLATFORM-002 | interface-devforge | devforge-ai | — | Solo execution |
| ENG-PLATFORM-003 | database-infraforge | infraforge-ai | — | Solo execution |
| ENG-PLATFORM-004 | knowledge-manager | knowledgeforge-ai | — | Solo execution |
| ENG-PLATFORM-005 | learningforge-ai-lead | learningforge-ai | — | Solo execution |
| ENG-PLATFORM-006 | domainforge-ai-engineeringdirector | domainforge-ai | — | Solo execution |
| ENG-PLATFORM-007 | devcore-devforge | devforge-ai | — | Solo execution |
| ENG-PLATFORM-008 | codesmith-devforge | devforge-ai | — | Solo execution |
| ENG-PLATFORM-009 | devcore-devforge | devforge-ai | integrateforge-ai-lead | API coordination |
| ENG-PLATFORM-010 | interface-devforge | devforge-ai | — | Solo execution |
| ENG-PLATFORM-011 | interface-devforge | devforge-ai | — | Solo execution |
| ENG-PLATFORM-012 | civil-domainforge | domainforge-ai | — | Domain expert solo |
| ENG-PLATFORM-013 | structural-domainforge | domainforge-ai | — | Domain expert solo |
| ENG-PLATFORM-014 | mep-domainforge | domainforge-ai | — | Domain expert solo |
| ENG-PLATFORM-015 | validator-qualityforge | qualityforge-ai | — | Solo execution |
| ENG-PLATFORM-016 | validator-qualityforge | qualityforge-ai | — | Solo execution |
| ENG-PLATFORM-017 | validator-qualityforge | qualityforge-ai | — | Solo execution |

## Delegation RPC Flow

For each issue, the delegation flow follows:

```
1. CEO creates ENG-PLATFORM-XXX with assigneeAgentId
2. Assignee's heartbeat loop detects new assignment
3. Assignee reads issue description (goals, delegation prompt, QC checklist)
4. If sub-delegation needed → create sub-task with parentId=ENG-PLATFORM-XXX
5. Sub-agent executes → updates status on sub-task → status propagates to parent
6. Assignee aggregates sub-results → updates ENG-PLATFORM-XXX status
7. Phase gate evaluation: pass rate + critical issues = gate decision
```

## Heartbeat Loop Configuration

Every agent involved in ENG-PLATFORM-000 should have:

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

## Cross-Company Coordination

| Phase | Lead Company | Supporting Companies | Coordination Method |
|-------|-------------|---------------------|---------------------|
| Phase 1 | DevForge AI | InfraForge AI | Database schema coordination |
| Phase 2 | KnowledgeForge AI | DevForge AI, DomainForge AI | API integration points |
| Phase 3 | DevForge AI | IntegrateForge AI | BIM 360 sync |
| Phase 4 | DevForge AI | — | Internal accordion updates |
| Phase 5 | DomainForge AI | DevForge AI | Component usage |
| Phase 6 | QualityForge AI | All | Testing coordination |

## Risk: Agent Availability

⚠ **Note**: Some agents referenced in this delegation map may not yet exist in the Paperclip system. Before execution:
- Verify `civil-domainforge`, `structural-domainforge`, `mep-domainforge` directories exist
- Verify `learningforge-ai-lead` exists in LearningForge AI
- Verify `integrateforge-ai-lead` exists in IntegrateForge AI
- Create missing agents or reassign issues to existing agents as needed

---

**Version**: 1.0
**Last Updated**: 2026-04-28
