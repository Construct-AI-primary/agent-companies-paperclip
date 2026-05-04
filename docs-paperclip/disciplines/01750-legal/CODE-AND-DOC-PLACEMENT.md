---
title: 01750 Legal - Code and Documentation Placement
---

# 01750 Legal - Code and Documentation Placement

## Discipline Overview

This document defines the standardized location for all code and documentation within the 01750 Legal discipline.

## Standard Structure

```
01750-legal/
├── CODE-AND-DOC-PLACEMENT.md    ← This file
├── README.md                     ← Discipline overview
├── UI-UX-SPECIFICATION.md        ← Redirect to ui-ux/ directory
├── knowledge/                   ← Cross-project domain knowledge
│   └── PAGE-KNOWLEDGE.md
├── ui-ux/                       ← UI/UX specifications
│   ├── index.md                 ← Master index with color scheme
│   ├── desktop.md               ← Desktop spec
│   ├── mobile.md                ← Mobile spec
│   └── web.md                   ← Web spec
├── projects/                    ← All discipline projects
│   ├── LEGAL-CONTRACTS/         ← Contract Management & Administration
│   │   ├── README.md            ← Project overview
│   │   ├── LEGAL-CONTRACTS-implementation.md ← Implementation plan
│   │   ├── trigger/             ← Project automation triggers
│   │   │   └── .gitkeep
│   │   ├── shared/              ← Shared resources
│   │   │   └── .gitkeep
│   │   ├── desktop/             ← Desktop platform
│   │   │   ├── issues/          ← Desktop-specific issues
│   │   │   │   ├── LEGAL-CONT-001-foundation.md
│   │   │   │   ├── LEGAL-CONT-002-core-integration.md
│   │   │   │   ├── LEGAL-CONT-003-discipline-integration.md
│   │   │   │   ├── LEGAL-CONT-004-mobile-offline.md
│   │   │   │   ├── LEGAL-CONT-005-compliance-audit.md
│   │   │   │   └── ISSUE-GENERATION-STATUS.md
│   │   │   └── trigger/         ← Desktop platform triggers
│   │   │       └── .gitkeep
│   │   ├── mobile/              ← Mobile platform
│   │   │   ├── issues/          ← Mobile-specific issues
│   │   │   │   ├── LEGAL-CONT-MOBILE-001-ios.md
│   │   │   │   ├── LEGAL-CONT-MOBILE-002-android.md
│   │   │   │   ├── LEGAL-CONT-MOBILE-003-cross-platform.md
│   │   │   │   └── ISSUE-GENERATION-STATUS.md
│   │   │   └── trigger/         ← Mobile platform triggers
│   │   │       └── .gitkeep
│   │   └── web/                 ← Web platform
│   │       ├── issues/          ← Web-specific issues
│   │       │   ├── LEGAL-CONT-WEB-001-dashboard.md
│   │       │   ├── LEGAL-CONT-WEB-002-admin.md
│   │       │   ├── LEGAL-CONT-WEB-003-audit.md
│   │       │   └── ISSUE-GENERATION-STATUS.md
│   │       └── trigger/         ← Web platform triggers
│   │           └── .gitkeep
│   ├── LEGAL-CLAIMS/            ← Claims & Dispute Resolution
│   │   ├── README.md
│   │   ├── LEGAL-CLAIMS-implementation.md
│   │   ├── trigger/
│   │   │   └── .gitkeep
│   │   ├── shared/
│   │   │   └── .gitkeep
│   │   ├── desktop/
│   │   │   ├── issues/
│   │   │   │   ├── LEGAL-CLAIM-001-foundation.md
│   │   │   │   ├── LEGAL-CLAIM-002-core-integration.md
│   │   │   │   ├── LEGAL-CLAIM-003-discipline-integration.md
│   │   │   │   ├── LEGAL-CLAIM-004-mobile-offline.md
│   │   │   │   ├── LEGAL-CLAIM-005-compliance-audit.md
│   │   │   │   └── ISSUE-GENERATION-STATUS.md
│   │   │   └── trigger/
│   │   │       └── .gitkeep
│   │   ├── mobile/
│   │   │   ├── issues/
│   │   │   │   ├── LEGAL-CLAIM-MOBILE-001-ios.md
│   │   │   │   ├── LEGAL-CLAIM-MOBILE-002-android.md
│   │   │   │   ├── LEGAL-CLAIM-MOBILE-003-cross-platform.md
│   │   │   │   └── ISSUE-GENERATION-STATUS.md
│   │   │   └── trigger/
│   │   │       └── .gitkeep
│   │   └── web/
│   │       ├── issues/
│   │       │   ├── LEGAL-CLAIM-WEB-001-dashboard.md
│   │       │   ├── LEGAL-CLAIM-WEB-002-admin.md
│   │       │   ├── LEGAL-CLAIM-WEB-003-audit.md
│   │       │   └── ISSUE-GENERATION-STATUS.md
│   │       └── trigger/
│   │           └── .gitkeep
│   ├── LEGAL-COMPLIANCE/        ← Regulatory Compliance & Legal Risk
│   │   ├── README.md
│   │   ├── LEGAL-COMPLIANCE-implementation.md
│   │   ├── trigger/
│   │   │   └── .gitkeep
│   │   ├── shared/
│   │   │   └── .gitkeep
│   │   ├── desktop/
│   │   │   ├── issues/
│   │   │   │   ├── LEGAL-COMP-001-foundation.md
│   │   │   │   ├── LEGAL-COMP-002-core-integration.md
│   │   │   │   ├── LEGAL-COMP-003-discipline-integration.md
│   │   │   │   ├── LEGAL-COMP-004-mobile-offline.md
│   │   │   │   ├── LEGAL-COMP-005-compliance-audit.md
│   │   │   │   └── ISSUE-GENERATION-STATUS.md
│   │   │   └── trigger/
│   │   │       └── .gitkeep
│   │   ├── mobile/
│   │   │   ├── issues/
│   │   │   │   ├── LEGAL-COMP-MOBILE-001-ios.md
│   │   │   │   ├── LEGAL-COMP-MOBILE-002-android.md
│   │   │   │   ├── LEGAL-COMP-MOBILE-003-cross-platform.md
│   │   │   │   └── ISSUE-GENERATION-STATUS.md
│   │   │   └── trigger/
│   │   │       └── .gitkeep
│   │   └── web/
│   │       ├── issues/
│   │       │   ├── LEGAL-COMP-WEB-001-dashboard.md
│   │       │   ├── LEGAL-COMP-WEB-002-admin.md
│   │       │   ├── LEGAL-COMP-WEB-003-audit.md
│   │       │   └── ISSUE-GENERATION-STATUS.md
│   │       └── trigger/
│   │           └── .gitkeep
│   └── LEGAL-DOCUMENTS/         ← Legal Document Management & Governance
│       ├── README.md
│       ├── LEGAL-DOCUMENTS-implementation.md
│       ├── trigger/
│       │   └── .gitkeep
│       ├── shared/
│       │   └── .gitkeep
│       ├── desktop/
│       │   ├── issues/
│       │   │   ├── LEGAL-DOC-001-foundation.md
│       │   │   ├── LEGAL-DOC-002-core-integration.md
│       │   │   ├── LEGAL-DOC-003-discipline-integration.md
│       │   │   ├── LEGAL-DOC-004-mobile-offline.md
│       │   │   ├── LEGAL-DOC-005-compliance-audit.md
│       │   │   └── ISSUE-GENERATION-STATUS.md
│       │   └── trigger/
│       │       └── .gitkeep
│       ├── mobile/
│       │   ├── issues/
│       │   │   ├── LEGAL-DOC-MOBILE-001-ios.md
│       │   │   ├── LEGAL-DOC-MOBILE-002-android.md
│       │   │   ├── LEGAL-DOC-MOBILE-003-cross-platform.md
│       │   │   └── ISSUE-GENERATION-STATUS.md
│       │   └── trigger/
│       │       └── .gitkeep
│       └── web/
│           ├── issues/
│           │   ├── LEGAL-DOC-WEB-001-dashboard.md
│           │   ├── LEGAL-DOC-WEB-002-admin.md
│           │   ├── LEGAL-DOC-WEB-003-audit.md
│           │   └── ISSUE-GENERATION-STATUS.md
│           └── trigger/
│               └── .gitkeep
├── trigger/                     ← Discipline automation triggers
│   ├── README.md
│   └── LEGAL-AUTO/
│       └── issues/
│           └── LEGAL-AUTO-000-discipline-automation.md
├── procedures/
└── plans/
```

## Discipline-Specific Notes

- Legal discipline for construction and engineering projects
- Covers contract law (FIDIC, NEC, JCT), claims & dispute resolution, regulatory compliance, legal documentation, and corporate governance
- Desktop, mobile, and web platform support

## Related Documents

- [Code and Documentation Placement Procedure](../../procedures/workflows/code-and-doc-placement-procedure.md)
