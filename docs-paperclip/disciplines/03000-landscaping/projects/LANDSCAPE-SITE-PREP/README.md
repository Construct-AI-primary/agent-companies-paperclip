# LANDSCAPE-SITE-PREP — Site Preparation & Earthworks

> **Discipline:** 03000 — Landscaping  
> **Project ID:** LANDSCAPE-SITE-PREP  
> **Status:** Planning  
> **Version:** 1.0.0

---

## Overview

LANDSCAPE-SITE-PREP delivers a comprehensive digital platform for **Site Preparation & Earthworks** within the Landscaping discipline. The project covers the full lifecycle of site preparation activities — from initial site assessment and soil analysis through grading plans, earthworks tracking, drainage design, erosion control, and compliance auditing.

The platform supports desktop, mobile (iOS & Android), and web interfaces, enabling field teams, engineers, and compliance officers to collaborate seamlessly across all phases of site preparation.

---

## Project Structure

```
LANDSCAPE-SITE-PREP/
├── README.md                                    # This file
├── LANDSCAPE-SITE-PREP-implementation.md        # Implementation plan
├── desktop/
│   ├── ISSUE-GENERATION-STATUS.md               # Desktop issue generation status
│   ├── issues/
│   │   ├── LAND-SITE-001-foundation.md          # Foundation — Site Assessment & Soil Analysis
│   │   ├── LAND-SITE-002-core-integration.md    # Core — Grading Plans & Earthworks
│   │   ├── LAND-SITE-003-discipline-integration.md  # Discipline — Drainage & Erosion Control
│   │   ├── LAND-SITE-004-mobile-offline.md      # Mobile & Offline readiness
│   │   └── LAND-SITE-005-compliance-audit.md    # Compliance & Audit
│   └── trigger/
│       └── .gitkeep
├── mobile/
│   ├── ISSUE-GENERATION-STATUS.md               # Mobile issue generation status
│   ├── issues/
│   │   ├── LAND-SITE-MOBILE-001-ios-siteprep.md     # iOS — Field Survey & Soil Sampling
│   │   ├── LAND-SITE-MOBILE-002-android-siteprep.md # Android — Earthworks & Photo Docs
│   │   └── LAND-SITE-MOBILE-003-cross-platform.md   # Cross-Platform — Dashboard & Progress
│   └── trigger/
│       └── .gitkeep
├── web/
│   ├── ISSUE-GENERATION-STATUS.md               # Web issue generation status
│   ├── issues/
│   │   ├── LAND-SITE-WEB-001-dashboard.md       # Dashboard — Soil Tests & Earthworks
│   │   ├── LAND-SITE-WEB-002-workflow-admin.md  # Admin — Grading Plans & Material Tracking
│   │   └── LAND-SITE-WEB-003-audit-trail.md     # Audit — Soil Records & Compliance
│   └── trigger/
│       └── .gitkeep
├── shared/
│   └── .gitkeep
└── trigger/
    └── .gitkeep
```

---

## Platforms

| Platform | Focus | Key Technologies |
|----------|-------|-----------------|
| **Desktop** | Core data model, compliance engine, audit trail | .NET / C#, PostgreSQL, REST APIs |
| **Mobile (iOS)** | Field survey, soil sample logging, GPS markers | Swift, Core Data, MapKit |
| **Mobile (Android)** | Earthworks progress, photo documentation, offline sync | Kotlin, Room, WorkManager |
| **Web** | Dashboards, workflow admin, compliance reports | React, TypeScript, Chart.js |

---

## Getting Started

### Prerequisites

- Git
- Access to the `agent-companies-core` monorepo
- Appropriate development environment for target platform(s)

### Clone & Navigate

```bash
git clone https://github.com/Construct-AI-primary/agent-companies-core.git
cd agent-companies-core/agent-companies-paperclip/docs-paperclip/disciplines/03000-landscaping/projects/LANDSCAPE-SITE-PREP
```

### Review Implementation Plan

Start by reading the full implementation plan:

```bash
cat LANDSCAPE-SITE-PREP-implementation.md
```

### Explore Issues

Issues are organized by platform and phase:

- **Desktop issues:** `desktop/issues/` — Foundation through Compliance & Audit
- **Mobile issues:** `mobile/issues/` — iOS, Android, and Cross-Platform
- **Web issues:** `web/issues/` — Dashboard, Admin, and Audit Trail

---

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Site assessment completion time | < 2 hours per site | Field app tracking |
| Soil analysis data accuracy | > 99% | Audit trail verification |
| Earthworks progress tracking | Real-time | Dashboard refresh rate |
| Erosion control compliance | 100% | Automated report generation |
| Offline field data sync | < 30 seconds on reconnect | Sync performance monitoring |
| Cross-discipline coordination | < 1 day response | Integration API latency |

---

## Phases

| Phase | Name | Duration | Issues |
|-------|------|----------|--------|
| 1 — Foundation | Site Assessment, Soil Analysis & Data Model | 4 weeks | LAND-SITE-001 |
| 2 — Core Integration | Grading Plans, Earthworks Tracking & Soil Management | 6 weeks | LAND-SITE-002, LAND-SITE-WEB-001 |
| 3 — Discipline Integration | Drainage Design, Erosion Control & Cross-Discipline Coordination | 4 weeks | LAND-SITE-003, LAND-SITE-WEB-002 |
| 4 — Mobile & Offline | Field Soil Testing, Site Photos & Offline Survey | 4 weeks | LAND-SITE-004, LAND-SITE-MOBILE-001, LAND-SITE-MOBILE-002, LAND-SITE-MOBILE-003 |
| 5 — Compliance & Audit | Soil Testing Records, Erosion Control Reports & Audit Trail | 3 weeks | LAND-SITE-005, LAND-SITE-WEB-003 |

---

## Contact

| Role | Name | Contact |
|------|------|---------|
| **Project Lead** | DomainForge AI | domainforge-ai |
| **Engineering Lead** | DevForge AI | devforge-ai |
| **Repository** | agent-companies-core | [GitHub](https://github.com/Construct-AI-primary/agent-companies-core) |

---

*Part of the **agent-companies-paperclip** documentation suite — Landscaping Discipline (03000)*
