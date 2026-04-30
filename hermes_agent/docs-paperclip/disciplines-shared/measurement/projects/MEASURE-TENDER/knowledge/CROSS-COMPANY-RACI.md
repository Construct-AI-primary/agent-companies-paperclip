---
title: Cross-Company RACI Matrix — MEASURE-TENDER
description: Responsible, Accountable, Consulted, Informed matrix for all 4 implementation phases
author: MeasureForge AI / DomainForge AI
date: 2026-04-28
version: 1.0
---

# Cross-Company RACI Matrix — MEASURE-TENDER

## RACI Key

| Letter | Meaning | Description |
|--------|---------|-------------|
| **R** | Responsible | Does the work |
| **A** | Accountable | Answers for the outcome (one per row) |
| **C** | Consulted | Provides input/knowledge |
| **I** | Informed | Receives progress updates |

## Phase-Level RACI

| Phase | InfraForge AI | DomainForge AI | Loopy AI | QualityForge AI | CEO |
|-------|---------------|----------------|----------|-----------------|-----|
| **Phase 1: Infrastructure** | R | C | I | I | A |
| **Phase 2: Core Services** | C | R | I | C | A |
| **Phase 3: UI & Integration** | I | R | R | C | A |
| **Phase 4: External Portal** | I | C | R | I | A |

## Issue-Level RACI

| Issue | Primary Agent (Company) | Accountable | InfraForge | DomainForge | Loopy AI | QualityForge |
|-------|------------------------|-------------|------------|-------------|----------|--------------|
| MEASURE-TENDER-001 | database-infraforge (IF) | IF | A | I | I | I |
| MEASURE-TENDER-002 | procurement-domainforge-procurement-contracts (DF) | DF | C | A | I | I |
| MEASURE-TENDER-003 | database-infraforge (IF) | IF | A | I | I | I |
| MEASURE-TENDER-004 | procurement-domainforge-procurement-contracts (DF) | DF | I | A | R | C |
| MEASURE-TENDER-005 | procurement-domainforge-procurement-contracts (DF) | DF | C | A | I | C |
| MEASURE-TENDER-006a | procurement-strategy-domainforge-procurement-strategy (DF) | DF | I | A | R | I |
| MEASURE-TENDER-006b | loopy-ai (LA) | LA | I | C | A | I |

**Key**: IF=InfraForge AI, DF=DomainForge AI, LA=Loopy AI, QF=QualityForge AI

## Escalation Path

```
Issue blocker → Primary Agent → Company Lead → Cross-Company CEO → Board
   15min        30min           1hr             4hrs            24hrs
```

- **Level 1** (15min): Agent tries alternate approach, consults knowledge bundle
- **Level 2** (30min): Escalate to company lead agent (measurement-ceo)
- **Level 3** (1hr): Cross-company escalation (domainforge-ai-procurementdirector)
- **Level 4** (4hrs): CEO escalation (measurement-ceo)
- **Level 5** (24hrs): Board-level decision needed

## Communication Channels

| Communication Type | Method | Frequency |
|-------------------|--------|-----------|
| Phase gate decisions | Issue status update | Per phase |
| Blocker escalation | Activity log + status change | As needed |
| Daily status | Aggregated activity report | Daily |
| Final sign-off | MEASURE-TENDER-006b issue close | End of project |

## Cross-Project Coordination: PROCURE-TEST

| Issue | QualityForge (PROCURE-TEST) | Coordination Requirement |
|-------|----------------------------|------------------------|
| MEASURE-TENDER-004 | C | UI components shared with 01900 page — coordinate build → test sequence |
| MEASURE-TENDER-005 | C | Workflow integration may affect existing procurement tests |

---

**Version**: 1.0
**Last Updated**: 2026-04-28
