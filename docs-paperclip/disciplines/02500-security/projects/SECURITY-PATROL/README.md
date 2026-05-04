# SECURITY-PATROL — Patrol & Guard Management

> **Discipline:** 02500 — Security  
> **Project:** Patrol & Guard Management  
> **Status:** 🚧 In Planning  
> **Version:** 1.0.0

---

## Overview

SECURITY-PATROL delivers a comprehensive Patrol & Guard Management system for the Security discipline. It enables organisations to plan, schedule, execute, and audit guard patrols with real-time tracking, checkpoint verification (QR/NFC), incident reporting, and performance analytics.

The system spans web dashboards for dispatchers and administrators, mobile apps for guards on the ground, and a robust backend for route optimisation, compliance auditing, and shift management.

---

## Project Structure

```
SECURITY-PATROL/
├── README.md
├── SECURITY-PATROL-implementation.md
├── desktop/
│   ├── issues/
│   │   ├── SEC-PATROL-001-foundation.md
│   │   ├── SEC-PATROL-002-core-integration.md
│   │   ├── SEC-PATROL-003-discipline-integration.md
│   │   ├── SEC-PATROL-004-mobile-offline.md
│   │   └── SEC-PATROL-005-compliance-audit.md
│   ├── trigger/
│   │   └── .gitkeep
│   └── ISSUE-GENERATION-STATUS.md
├── mobile/
│   ├── issues/
│   │   ├── SEC-PATROL-MOBILE-001-ios-patrol.md
│   │   ├── SEC-PATROL-MOBILE-002-android-patrol.md
│   │   └── SEC-PATROL-MOBILE-003-cross-platform.md
│   ├── trigger/
│   │   └── .gitkeep
│   └── ISSUE-GENERATION-STATUS.md
├── web/
│   ├── issues/
│   │   ├── SEC-PATROL-WEB-001-dashboard.md
│   │   ├── SEC-PATROL-WEB-002-workflow-admin.md
│   │   └── SEC-PATROL-WEB-003-audit-trail.md
│   ├── trigger/
│   │   └── .gitkeep
│   └── ISSUE-GENERATION-STATUS.md
├── shared/
│   └── .gitkeep
└── trigger/
    └── .gitkeep
```

---

## Platforms

| Platform | Scope | Key Technologies |
|----------|-------|------------------|
| **Desktop (Backend)** | Route planning, scheduling, data model, compliance, audit | Python/FastAPI, PostgreSQL, Redis |
| **Mobile — iOS** | Guard tour app, NFC checkpoints, route navigation | Swift, Core NFC, MapKit |
| **Mobile — Android** | QR checkpoint scanning, incident reporting, deviation alerts | Kotlin, CameraX, Google Maps |
| **Mobile — Cross-Platform** | Guard dashboard, shift schedule, performance metrics | React Native / Flutter |
| **Web** | Patrol dashboard, route planner, guard status, admin workflows | React, TypeScript, Mapbox |

---

## Getting Started

1. **Clone the repository** and navigate to the project root.
2. **Review the implementation plan** in `SECURITY-PATROL-implementation.md`.
3. **Explore the issue hierarchy** under `desktop/issues/`, `mobile/issues/`, and `web/issues/`.
4. **Phase 1 — Foundation** must be completed before dependent phases can begin.
5. **Refer to discipline documentation** under `docs-paperclip/disciplines/02500-security/` for domain context.

---

## Success Metrics

| Metric | Target |
|--------|--------|
| Patrol route adherence | ≥ 95% |
| Checkpoint verification rate | ≥ 99% |
| Incident reporting latency | ≤ 30 seconds |
| Shift scheduling accuracy | ≥ 98% |
| Mobile app uptime | ≥ 99.5% |
| Audit trail completeness | 100% |
| User adoption (guards) | ≥ 90% within 3 months |

---

## Contact

- **Project Lead:** domainforge-ai
- **Development Team:** devforge-ai
- **Discipline Owner:** Security (02500)
- **Repository:** `agent-companies-core`

---

*Part of the agent-companies-paperclip ecosystem — Security Discipline (02500)*
