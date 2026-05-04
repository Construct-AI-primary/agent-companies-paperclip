# HEALTH-INCIDENT — Health Incident Management

> **Part of the [01400 — Health](../../README.md) discipline.**
> Manages occupational health incident recording, investigation, reporting, and regulatory compliance for construction and engineering organizations.

## Overview

The Health Incident Management system provides a comprehensive platform for recording, investigating, and reporting health-related incidents including occupational illnesses, disease tracking, first aid events, medical emergencies, and RIDDOR-reportable occurrences. The system supports end-to-end incident lifecycle management from initial reporting through investigation, corrective action, and regulatory submission.

### Key Capabilities

- **Health Incident Recording** — Capture and classify health incidents with severity, type, and regulatory reporting flags
- **Occupational Disease Tracking** — Monitor and manage occupational illnesses, exposures, and long-term health conditions
- **First Aid Management** — Record first aid treatments, track first aid kit inventories, and manage first aider certifications
- **Medical Emergency Response** — Coordinate emergency medical services, document response actions, and track outcomes
- **Incident Investigation** — Root cause analysis, evidence collection, timeline management, and corrective action tracking
- **RIDDOR Reporting** — Generate and submit RIDDOR-reportable incident reports with full regulatory compliance
- **Health Incident Statistics** — Dashboards and trend analysis for incident patterns, KPIs, and management reporting

## Project Structure

```
HEALTH-INCIDENT/
├── README.md                          ← This file — Project overview
├── HEALTH-INCIDENT-implementation.md  ← Implementation plan (5 phases)
├── desktop/                           ← Desktop application (Electron)
│   ├── issues/                        ← Desktop-specific implementation issues
│   │   ├── HLTH-INCI-001-foundation.md
│   │   ├── HLTH-INCI-002-core.md
│   │   ├── HLTH-INCI-003-integration.md
│   │   ├── HLTH-INCI-004-mobile-offline.md
│   │   ├── HLTH-INCI-005-compliance.md
│   │   └── ISSUE-GENERATION-STATUS.md
│   └── trigger/                       ← Desktop automation triggers
│       └── .gitkeep
├── mobile/                            ← Mobile applications (iOS / Android)
│   ├── issues/                        ← Mobile-specific implementation issues
│   │   ├── HLTH-INCI-MOBILE-001-ios-incident.md
│   │   ├── HLTH-INCI-MOBILE-002-android-incident.md
│   │   ├── HLTH-INCI-MOBILE-003-cross-platform.md
│   │   └── ISSUE-GENERATION-STATUS.md
│   └── trigger/                       ← Mobile automation triggers
│       └── .gitkeep
├── web/                               ← Web application (React)
│   ├── issues/                        ← Web-specific implementation issues
│   │   ├── HLTH-INCI-WEB-001-dashboard.md
│   │   ├── HLTH-INCI-WEB-002-workflow-admin.md
│   │   ├── HLTH-INCI-WEB-003-audit-trail.md
│   │   └── ISSUE-GENERATION-STATUS.md
│   └── trigger/                       ← Web automation triggers
│       └── .gitkeep
├── shared/                            ← Shared domain models, types, and utilities
│   └── .gitkeep
└── trigger/                           ← Project-level automation triggers
    └── .gitkeep
```

## Platforms

| Platform | Technology | Purpose |
|----------|-----------|---------|
| **Desktop** | Electron / React | Full-featured incident management for health officers and administrators |
| **Mobile** | iOS (SwiftUI) / Android (Jetpack Compose) | Field incident reporting, evidence capture, offline operations |
| **Web** | React / TypeScript | Dashboard, workflow administration, audit trail, reporting |

## Getting Started

### Prerequisites

- Node.js 18+ (for web and desktop applications)
- Xcode 14+ (for iOS mobile application)
- Android Studio Hedgehog+ (for Android mobile application)
- PostgreSQL 15+ (for incident data storage)
- Access to the [01400 — Health](../../README.md) discipline knowledge base

### Development Setup

1. **Clone the repository** and navigate to the project root:
   ```bash
   cd agent-companies-paperclip/docs-paperclip/disciplines/01400-health/projects/HEALTH-INCIDENT
   ```

2. **Review the implementation plan** to understand the phased approach:
   ```bash
   cat HEALTH-INCIDENT-implementation.md
   ```

3. **Explore the issue files** for each phase to understand specific requirements:
   ```bash
   # Foundation phase
   cat desktop/issues/HLTH-INCI-001-foundation.md

   # Core phase
   cat desktop/issues/HLTH-INCI-002-core.md
   ```

4. **Review mobile and web issues** for platform-specific requirements:
   ```bash
   cat mobile/issues/HLTH-INCI-MOBILE-001-ios-incident.md
   cat web/issues/HLTH-INCI-WEB-001-dashboard.md
   ```

### Issue Lifecycle

Each issue follows a standard workflow:
1. **To Do** — Issue is defined and ready for implementation
2. **In Progress** — Active development underway
3. **In Review** — Implementation complete, awaiting review
4. **Done** — Issue completed and verified

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Incident Recording Time | < 5 minutes per incident | Time from incident occurrence to system entry |
| Investigation Completion | 90% within 30 days | Percentage of investigations closed within target |
| RIDDOR Compliance | 100% on-time reporting | All RIDDOR-reportable incidents submitted within legal timeframe |
| Mobile Adoption | > 80% of field reports via mobile | Percentage of incidents recorded via mobile platform |
| Data Accuracy | > 95% classification accuracy | Audit of incident classification against review outcomes |
| System Uptime | 99.9% availability | Platform availability excluding planned maintenance |
| User Satisfaction | > 4.0 / 5.0 | Quarterly user satisfaction survey score |

## Phases

| Phase | Name | Issues | Timeline |
|-------|------|--------|----------|
| 1 | Foundation | HLTH-INCI-001 | 2026-06 — 2026-07 (4 weeks) |
| 2 | Core | HLTH-INCI-002 | 2026-07 — 2026-08 (6 weeks) |
| 3 | Integration | HLTH-INCI-003 | 2026-09 — 2026-09 (4 weeks) |
| 4 | Mobile & Offline | HLTH-INCI-004, MOBILE-001–003 | 2026-10 — 2026-10 (4 weeks) |
| 5 | Compliance & Audit | HLTH-INCI-005, WEB-003 | 2026-11 — 2026-11 (3 weeks) |

## Dependencies

- **[01400 — Health](../../README.md)** — Parent discipline providing health domain context
- **[02400 — Safety](../../../02400-safety/README.md)** — Shared incident data, safety observation integration
- **HR Systems** — Personnel data for incident reporting and investigation
- **Regulatory Bodies** — RIDDOR, OSHA 300, and local health regulation compliance

## Related Documents

- [Implementation Plan](./HEALTH-INCIDENT-implementation.md) — Detailed phased implementation plan
- [01400 Health README](../../README.md) — Health discipline overview
- [UI/UX Specification](../../ui-ux/index.md) — Platform-specific UI/UX guidelines
- [Knowledge Base](../../knowledge/PAGE-KNOWLEDGE.md) — Health domain knowledge and references

## Contact

| Role | Contact |
|------|---------|
| **Discipline Lead** | Health Discipline Team |
| **Domain Architecture** | domainforge-ai |
| **Development** | devforge-ai |
| **Issue Tracking** | GitHub Issues (HLTH-INCI-* labels) |

---

*Part of the [Agent Companies Paperclip](https://github.com/Construct-AI-primary/agent-companies-core) project.*
