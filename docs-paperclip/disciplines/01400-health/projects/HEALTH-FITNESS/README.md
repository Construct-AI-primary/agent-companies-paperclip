# HEALTH-FITNESS — Fitness for Work & Health Assessments

> Comprehensive fitness-for-work assessment system covering pre-employment medicals, periodic health assessments, return-to-work evaluations, health clearance, and medical restrictions management.

## Project Overview

HEALTH-FITNESS provides a complete digital platform for managing occupational health and fitness-for-work processes. The system enables health professionals to conduct medical assessments, track worker fitness status, manage medical restrictions, and ensure compliance with workplace health regulations.

### Core Capabilities

- **Pre-Employment Medicals** — Health screening and fitness determination for new hires
- **Periodic Health Assessments** — Scheduled recurring health evaluations for existing workers
- **Return-to-Work Evaluations** — Post-illness/injury fitness clearance workflows
- **Health Clearance** — Formal clearance certification with expiry tracking
- **Medical Restrictions Management** — Categorisation, assignment, and expiry monitoring of work restrictions
- **Drug & Alcohol Testing** — Test administration, result recording, and compliance tracking

## Project Structure

```
HEALTH-FITNESS/
├── README.md                                    # Project overview (this file)
├── HEALTH-FITNESS-implementation.md             # Implementation plan
├── desktop/
│   ├── issues/                                  # Desktop platform issues
│   │   ├── HLTH-FIT-001-foundation.md           # Foundation — Assessment Framework
│   │   ├── HLTH-FIT-002-core.md                 # Core — Assessment Management
│   │   ├── HLTH-FIT-003-integration.md          # Integration — HR & Provider Links
│   │   ├── HLTH-FIT-004-mobile-offline.md       # Mobile & Offline — Field Assessments
│   │   ├── HLTH-FIT-005-compliance.md           # Compliance & Audit — Reporting
│   │   └── ISSUE-GENERATION-STATUS.md
│   └── trigger/                                 # Desktop automation triggers
│       └── .gitkeep
├── mobile/
│   ├── issues/                                  # Mobile platform issues
│   │   ├── HLTH-FIT-MOBILE-001-ios-fitness.md   # iOS fitness assessment app
│   │   ├── HLTH-FIT-MOBILE-002-android-fitness.md # Android fitness assessment app
│   │   ├── HLTH-FIT-MOBILE-003-cross-platform.md # Cross-platform shared components
│   │   └── ISSUE-GENERATION-STATUS.md
│   └── trigger/                                 # Mobile automation triggers
│       └── .gitkeep
├── shared/
│   └── .gitkeep                                 # Shared domain models & utilities
├── trigger/                                     # Cross-platform automation triggers
│   └── .gitkeep
└── web/
    ├── issues/                                  # Web platform issues
    │   ├── HLTH-FIT-WEB-001-dashboard.md        # Fitness dashboard
    │   ├── HLTH-FIT-WEB-002-workflow-admin.md   # Workflow administration
    │   ├── HLTH-FIT-WEB-003-audit-trail.md      # Audit trail & compliance
    │   └── ISSUE-GENERATION-STATUS.md
    └── trigger/                                 # Web automation triggers
        └── .gitkeep
```

## Platforms

| Platform | Technology | Purpose |
|----------|-----------|---------|
| **Desktop** | .NET / WPF (Windows) | Health officer assessment management, medical records, compliance reporting |
| **Mobile** | iOS (Swift) / Android (Kotlin) | Field assessments, health questionnaires, offline operations |
| **Web** | React / TypeScript | Worker dashboard, workflow administration, audit trail |

## Getting Started

### Prerequisites

- Access to the project repository
- Appropriate development environment for target platform(s)
- Understanding of occupational health and fitness-for-work domain

### Development Setup

1. Clone the repository and navigate to the project:
   ```bash
   cd agent-companies-paperclip/docs-paperclip/disciplines/01400-health/projects/HEALTH-FITNESS
   ```
2. Review the implementation plan (`HEALTH-FITNESS-implementation.md`) for phase details
3. Begin with Phase 1 — Foundation issues (`HLTH-FIT-001`)
4. Follow the dependency chain: Foundation → Core → Integration → Mobile & Offline → Compliance & Audit

### Issue Tracking

Issues are organised by platform and phase:

- **Desktop Issues**: `desktop/issues/HLTH-FIT-001` through `HLTH-FIT-005`
- **Mobile Issues**: `mobile/issues/HLTH-FIT-MOBILE-001` through `-003`
- **Web Issues**: `web/issues/HLTH-FIT-WEB-001` through `-003`

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Assessment Turnaround | < 48 hours | Time from referral to clearance decision |
| Fitness Status Accuracy | 100% | Correct fitness categorisation |
| Restriction Compliance | 100% | No expired restrictions active |
| Offline Sync Reliability | > 99.5% | Successful sync rate for field assessments |
| Audit Trail Completeness | 100% | All fitness actions logged |
| Regulatory Compliance | Full | Adherence to health & safety regulations |

## Contact

- **Project Owner**: domainforge-ai
- **Development Team**: devforge-ai
- **Repository**: Construct-AI-primary / agent-companies-core
