---
title: "Cross-Company RACI Matrix — ENG-PLATFORM-000"
description: "Responsible, Accountable, Consulted, Informed matrix for all 6 engineering platform phases"
author: "DevForge AI / DomainForge AI"
date: "2026-04-28"
version: "1.0"
---

# Cross-Company RACI Matrix — ENG-PLATFORM-000

## RACI Key

| Letter | Meaning | Description |
|--------|---------|-------------|
| **R** | Responsible | Does the work |
| **A** | Accountable | Answers for the outcome (one per row) |
| **C** | Consulted | Provides input/knowledge |
| **I** | Informed | Receives progress updates |

## Phase-Level RACI

| Phase | DevForge AI | DomainForge AI | KnowledgeForge AI | IntegrateForge AI | QualityForge AI | InfraForge AI | CEO |
|-------|------------|---------------|------------------|-------------------|----------------|---------------|-----|
| **Phase 1: Architecture** | R | C | I | I | I | A | I |
| **Phase 2: Knowledge** | C | C | R | I | I | I | A |
| **Phase 3: CAD** | R | C | I | C | I | I | A |
| **Phase 4: Accordion** | R | C | I | I | I | I | A |
| **Phase 5: Disciplines** | C | R | C | I | I | I | A |
| **Phase 6: Testing** | I | C | I | I | R | I | A |

## Issue-Level RACI

| Issue | Primary Agent (Company) | Accountable | DevForge | DomainForge | KnowledgeForge | IntegrateForge | QualityForge | InfraForge |
|-------|------------------------|-------------|----------|-------------|---------------|---------------|-------------|-----------|
| ENG-PLATFORM-001 | devcore-devforge (DF) | DF | A | I | I | I | I | I |
| ENG-PLATFORM-002 | interface-devforge (DF) | DF | A | I | I | I | I | I |
| ENG-PLATFORM-003 | database-infraforge (IF) | IF | C | I | I | I | I | A |
| ENG-PLATFORM-004 | knowledge-manager (KF) | KF | I | I | A | I | I | I |
| ENG-PLATFORM-005 | learningforge-ai-lead (LF) | LF | I | I | C | I | I | I |
| ENG-PLATFORM-006 | domainforge-ai-engineeringdirector (DF) | DF | I | A | C | I | I | I |
| ENG-PLATFORM-007 | devcore-devforge (DF) | DF | A | I | I | C | I | I |
| ENG-PLATFORM-008 | codesmith-devforge (DF) | DF | A | I | I | I | I | I |
| ENG-PLATFORM-009 | devcore-devforge (DF) | DF | A | I | I | C | I | I |
| ENG-PLATFORM-010 | interface-devforge (DF) | DF | A | I | I | I | I | I |
| ENG-PLATFORM-011 | interface-devforge (DF) | DF | A | I | I | I | I | I |
| ENG-PLATFORM-012 | civil-domainforge (DF) | DF | C | A | I | I | I | I |
| ENG-PLATFORM-013 | structural-domainforge (DF) | DF | C | A | I | I | I | I |
| ENG-PLATFORM-014 | mep-domainforge (DF) | DF | C | A | I | I | I | I |
| ENG-PLATFORM-015 | validator-qualityforge (QF) | QF | I | C | I | I | A | I |
| ENG-PLATFORM-016 | validator-qualityforge (QF) | QF | I | I | I | I | A | I |
| ENG-PLATFORM-017 | validator-qualityforge (QF) | QF | I | C | I | I | A | I |

**Key**: DF=DevForge, DF(Domain)=DomainForge, KF=KnowledgeForge, LF=LearningForge, IF=InfraForge, QF=QualityForge

## Escalation Path

```
Issue blocker → Primary Agent → Company Lead → Cross-Company CEO → Board
   15min           30min           1hr             4hrs            24hrs
```

- **Level 1** (15min): Agent tries alternate approach, consults knowledge bundle
- **Level 2** (30min): Escalate to company lead agent
- **Level 3** (1hr): Cross-company escalation to domain director
- **Level 4** (4hrs): CEO escalation (devforge-ceo)
- **Level 5** (24hrs): Board-level decision needed

## Communication Channels

| Communication Type | Method | Frequency |
|-------------------|--------|-----------|
| Phase gate decisions | Issue status update | Per phase |
| Blocker escalation | Activity log + status change | As needed |
| Daily status | Aggregated activity report | Daily |
| Final sign-off | ENG-PLATFORM-017 issue close | End of project |

## Cross-Project RACI: ENG-AUTO-000 Coordination

| Activity | ENG-PLATFORM-000 Owner | ENG-AUTO-000 Owner | Coordination Type |
|----------|----------------------|-------------------|-------------------|
| Shared components | devcore-devforge | devcore-devforge | Must not duplicate |
| Accordion templates | interface-devforge | interface-devforge | Extension |
| Discipline pilots | civil/structural/mep-domainforge | devcore-devforge | Pattern follow |
| CAD integration | codesmith-devforge | codesmith-devforge | Shared framework |

---

**Version**: 1.0
**Last Updated**: 2026-04-28
