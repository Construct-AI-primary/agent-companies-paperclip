# SAFETY-CONTRACTOR — Contractor Safety Management Workflow

**Discipline**: 02400 — Safety  
**Project Code**: SAFETY-CONTRACTOR  
**Status**: Active  
**Lead Company**: QualityForge AI  
**Lead Agent**: guardian-qualityforge  
**Timeline**: 7 weeks

---

## Overview

The Contractor Safety Management Workflow project delivers a comprehensive system for managing contractor safety across the full lifecycle — from prequalification through performance evaluation. The system spans both **desktop** (command center) and **mobile** (field operations) platforms.

## Project Structure

```
SAFETY-CONTRACTOR/
├── README.md                            ← This file
├── plan.md                              ← Implementation plan
├── project.md                           ← Project charter
├── AGENTS.md                            ← Agent instructions
├── UPLOAD-KNOWLEDGE-TO-DB-PROCEDURE.md  ← DB upload procedure
│
├── knowledge/                           ← Shared knowledge documents
│   ├── AGENT-DELEGATION-MAP.md          ← Agent hierarchy & delegation
│   ├── CROSS-COMPANY-RACI.md            ← RACI matrix
│   ├── HEARTBEAT-MONITORING-CONFIG.md   ← Feedback loop config
│   ├── METADATA-BUNDLE.md               ← JSON metadata bundle
│   └── PAGE-KNOWLEDGE.md               ← Component & page knowledge
│
├── desktop/
│   └── issues/
│       ├── ISSUE-GENERATION-STATUS.md   ← Desktop issue manifest
│       ├── SAFETY-CONTRACTOR-001.md     ← Core Workflow Dashboard
│       ├── SAFETY-CONTRACTOR-002.md     ← Data Model & API Layer
│       ├── SAFETY-CONTRACTOR-003.md     ← Reporting & Analytics
│       ├── SAFETY-CONTRACTOR-004.md     ← Record Management & Forms
│       └── SAFETY-CONTRACTOR-005.md     ← Integration & Notifications
│
└── mobile/
    └── issues/
        ├── ISSUE-GENERATION-STATUS.md   ← Mobile issue manifest
        ├── SAFETY-CONTRACTOR-001.md     ← Field Data Capture
        ├── SAFETY-CONTRACTOR-002.md     ← Offline Sync
        ├── SAFETY-CONTRACTOR-003.md     ← Push Notifications & Alerts
        ├── SAFETY-CONTRACTOR-004.md     ← List & Detail Views
        └── SAFETY-CONTRACTOR-005.md     ← UX Polish & Accessibility
```

## Issues

### Desktop (5 issues, 160 story points)

| ID | Title | Priority | Phase |
|----|-------|----------|-------|
| SAFETY-CONTRACTOR-001 | Core Workflow Dashboard | Critical | Core Implementation |
| SAFETY-CONTRACTOR-002 | Data Model & API Layer | High | Foundation |
| SAFETY-CONTRACTOR-003 | Reporting & Analytics | Medium | Enhancement |
| SAFETY-CONTRACTOR-004 | Record Management & Forms | High | Core Implementation |
| SAFETY-CONTRACTOR-005 | Integration & Notifications | Medium | Enhancement |

### Mobile (5 issues, 148 story points)

| ID | Title | Priority | Phase |
|----|-------|----------|-------|
| SAFETY-CONTRACTOR-001 | Field Data Capture | Critical | Core Implementation |
| SAFETY-CONTRACTOR-002 | Offline Sync | High | Core Implementation |
| SAFETY-CONTRACTOR-003 | Push Notifications & Alerts | Medium | Integration |
| SAFETY-CONTRACTOR-004 | List & Detail Views | High | Core Implementation |
| SAFETY-CONTRACTOR-005 | UX Polish & Accessibility | Medium | Refinement |

## Key Documents

| Document | Description |
|----------|-------------|
| [plan.md](./plan.md) | Detailed implementation plan with phases, dependencies, and risk mitigation |
| [project.md](./project.md) | Project charter with scope, objectives, and success criteria |
| [AGENTS.md](./AGENTS.md) | Agent instructions for project execution |
| [UPLOAD-KNOWLEDGE-TO-DB-PROCEDURE.md](./UPLOAD-KNOWLEDGE-TO-DB-PROCEDURE.md) | Procedure for uploading knowledge docs to Supabase |

### Knowledge Bundle

| Document | Description |
|----------|-------------|
| [knowledge/AGENT-DELEGATION-MAP.md](./knowledge/AGENT-DELEGATION-MAP.md) | Cross-company agent hierarchy and delegation flow |
| [knowledge/CROSS-COMPANY-RACI.md](./knowledge/CROSS-COMPANY-RACI.md) | Responsible/Accountable/Consulted/Informed matrix |
| [knowledge/HEARTBEAT-MONITORING-CONFIG.md](./knowledge/HEARTBEAT-MONITORING-CONFIG.md) | Feedback loop configuration and stall detection |
| [knowledge/METADATA-BUNDLE.md](./knowledge/METADATA-BUNDLE.md) | Complete JSON metadata bundle for all components |
| [knowledge/PAGE-KNOWLEDGE.md](./knowledge/PAGE-KNOWLEDGE.md) | Page architecture, component metadata, QC checklists |

## Quick Start

1. Start by reading the [project charter](./project.md) for scope and objectives
2. Review the [implementation plan](./plan.md) for the execution sequence
3. Check the [desktop issue manifest](./desktop/issues/ISSUE-GENERATION-STATUS.md) for all desktop issues
4. Check the [mobile issue manifest](./mobile/issues/ISSUE-GENERATION-STATUS.md) for all mobile issues
5. Upload knowledge documents to Supabase using the [upload procedure](./UPLOAD-KNOWLEDGE-TO-DB-PROCEDURE.md)

## Companies Involved

| Company | Role |
|---------|------|
| **QualityForge AI** | Lead — implementation, testing, quality assurance |
| **DomainForge AI** | Domain expertise — safety domain knowledge |
| **InfraForge AI** | Technical support — database, API, infrastructure |
| **KnowledgeForge AI** | Knowledge management — metadata, documentation |

## Related Safety Projects

- SAFETY-INCIDENTS — Incident reporting module
- SAFETY-INSPECTIONS — Site inspection module
- SAFETY-TRAINING — Training coordination module
- SAFETY-ALERTS — Alert and notification system

---

*Generated: 2026-04-28 | Version: 1.0*