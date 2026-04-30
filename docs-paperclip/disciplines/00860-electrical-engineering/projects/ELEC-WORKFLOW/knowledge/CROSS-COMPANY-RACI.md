---
title: Cross-Company RACI Matrix — ELEC-WORKFLOW
description: Responsible, Accountable, Consulted, Informed matrix for all 8 electrical engineering workflow issues
author: Paperclip QA Team
date: 2026-04-28
version: 1.0
---

# Cross-Company RACI Matrix — ELEC-WORKFLOW

## RACI Key

| Letter | Meaning | Description |
|--------|---------|-------------|
| **R** | Responsible | Does the work |
| **A** | Accountable | Answers for the outcome (one per row) |
| **C** | Consulted | Provides input/knowledge |
| **I** | Informed | Receives progress updates |

## Platform-Level RACI

| Platform | DomainForge AI | DevForge AI | InfraForge AI | QualityForge AI | KnowledgeForge AI | CEO |
|----------|----------------|-------------|---------------|-----------------|-------------------|-----|
| **Desktop** | R/A | C | C | C | C | I |

## Issue-Level RACI

| Issue | Primary Agent (Company) | Accountable | DevForge | InfraForge | QualityForge | KnowledgeForge |
|-------|------------------------|-------------|----------|------------|--------------|----------------|
| ELEC-001 (Power Distribution) | electrical-domainforge (DF) | DF | C | C | C | C |
| ELEC-002 (Traffic Signals/ITS) | electrical-domainforge (DF) | DF | C | I | C | C |
| ELEC-003 (HV Transmission) | electrical-domainforge (DF) | DF | C | C | C | C |
| ELEC-004 (Generator/Power Plant) | electrical-domainforge (DF) | DF | C | C | C | I |
| ELEC-005 (Substation Design) | electrical-domainforge (DF) | DF | C | C | C | C |
| ELEC-006 (Cable/Reticulation) | electrical-domainforge (DF) | DF | C | I | C | I |
| ELEC-007 (Electrical Maintenance) | electrical-domainforge (DF) | DF | C | I | C | I |
| ELEC-008 (Electrical Commissioning) | electrical-domainforge (DF) | DF | C | I | C | I |

**Key**: DF=DomainForge AI, DV=DevForge AI, IF=InfraForge AI, QF=QualityForge AI, KF=KnowledgeForge AI

## Cross-Discipline Consultation

| Issue | Civil (00850) | Structural (00872) | Mechanical (00870) | Construction (00300) | HSE (01100) |
|-------|---------------|-------------------|--------------------|---------------------|-------------|
| ELEC-001 | C | I | I | C | C |
| ELEC-002 | C | I | I | C | C |
| ELEC-003 | C | C | I | C | C |
| ELEC-004 | I | C | C | C | C |
| ELEC-005 | C | C | C | C | C |
| ELEC-006 | C | I | I | C | I |
| ELEC-007 | I | I | I | I | C |
| ELEC-008 | I | I | C | C | C |

## Escalation Path

```
Issue blocker → Primary Agent → Company Lead → Cross-Company CEO → Board
   15min        30min           1hr             4hrs            24hrs
```

- **Level 1** (15min): Agent tries alternate approach, consults knowledge bundle
- **Level 2** (30min): Escalate to company lead agent (electrical-domainforge)
- **Level 3** (1hr): Cross-company escalation (domainforge-ai-architectural-integration)
- **Level 4** (4hrs): CEO escalation (domainforge-ceo)
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