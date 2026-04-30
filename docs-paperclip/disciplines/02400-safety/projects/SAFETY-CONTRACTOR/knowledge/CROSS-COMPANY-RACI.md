---
title: Cross-Company RACI Matrix — SAFETY-CONTRACTOR
description: Responsible, Accountable, Consulted, Informed matrix for all 10 issues across desktop and mobile platforms
author: Paperclip QA Team
date: 2026-04-28
version: 1.0
---

# Cross-Company RACI Matrix — SAFETY-CONTRACTOR

## RACI Key

| Letter | Meaning | Description |
|--------|---------|-------------|
| **R** | Responsible | Does the work |
| **A** | Accountable | Answers for the outcome (one per row) |
| **C** | Consulted | Provides input/knowledge |
| **I** | Informed | Receives progress updates |

## Platform-Level RACI

| Platform | QualityForge AI | DomainForge AI | InfraForge AI | KnowledgeForge AI | CEO |
|----------|----------------|----------------|---------------|-------------------|-----|
| **Desktop** | R/A | C | C | C | I |
| **Mobile** | R/A | C | C | C | I |

## Issue-Level RACI

### Desktop Issues

| Issue | Primary Agent (Company) | Accountable | DomainForge | InfraForge | KnowledgeForge |
|-------|------------------------|-------------|-------------|------------|----------------|
| SAFETY-CONTRACTOR-001 (Desktop) | guardian-qualityforge (QF) | QF | C | I | C |
| SAFETY-CONTRACTOR-002 (Desktop) | guardian-qualityforge (QF) | QF | C | A | C |
| SAFETY-CONTRACTOR-003 (Desktop) | guardian-qualityforge (QF) | QF | C | I | I |
| SAFETY-CONTRACTOR-004 (Desktop) | guardian-qualityforge (QF) | QF | C | I | I |
| SAFETY-CONTRACTOR-005 (Desktop) | guardian-qualityforge (QF) | QF | C | C | I |

### Mobile Issues

| Issue | Primary Agent (Company) | Accountable | DomainForge | InfraForge | KnowledgeForge |
|-------|------------------------|-------------|-------------|------------|----------------|
| SAFETY-CONTRACTOR-001 (Mobile) | guardian-qualityforge (QF) | QF | C | I | I |
| SAFETY-CONTRACTOR-002 (Mobile) | guardian-qualityforge (QF) | QF | C | A | I |
| SAFETY-CONTRACTOR-003 (Mobile) | guardian-qualityforge (QF) | QF | C | C | I |
| SAFETY-CONTRACTOR-004 (Mobile) | guardian-qualityforge (QF) | QF | C | I | I |
| SAFETY-CONTRACTOR-005 (Mobile) | guardian-qualityforge (QF) | QF | C | I | I |

**Key**: QF=QualityForge AI, DF=DomainForge AI, IF=InfraForge AI, KF=KnowledgeForge AI

## Escalation Path

```
Issue blocker → Primary Agent → Company Lead → Cross-Company CEO → Board
   15min        30min           1hr             4hrs            24hrs
```

- **Level 1** (15min): Agent tries alternate approach, consults knowledge bundle
- **Level 2** (30min): Escalate to company lead agent (guardian-qualityforge)
- **Level 3** (1hr): Cross-company escalation (domainforge-ai-architectural-integration)
- **Level 4** (4hrs): CEO escalation (qualityforge-ceo)
- **Level 5** (24hrs): Board-level decision needed

## Communication Channels

| Communication Type | Method | Frequency |
|-------------------|--------|-----------|
| Phase gate decisions | Issue status update | Per phase |
| Blocker escalation | Activity log + status change | As needed |
| Daily status | Aggregated activity report | Daily |
| Final sign-off | Issue close | End of project |

---

**Version**: 1.0
**Last Updated**: 2026-04-28