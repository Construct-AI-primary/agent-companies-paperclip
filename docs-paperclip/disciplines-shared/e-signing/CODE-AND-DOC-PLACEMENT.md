# e-Signing — Code and Document Placement

## Purpose

This document defines where code and documentation for the e-Signing discipline should be placed within the project structure.

## Directory Structure

```
e-signing/
├── CODE-AND-DOC-PLACEMENT.md   # This file
├── README.md                    # Discipline overview
├── knowledge/                   # Shared knowledge artifacts
├── plans/                       # Planning documents
├── procedures/                  # Standard operating procedures
├── projects/                    # Project directories
│   └── ESIGN-INTEGRATION/       # HITL e-Signature integration project
│       ├── README.md
│       ├── ESIGN-INTEGRATION-implementation.md
│       ├── plan.md
│       ├── AGENTS.md
│       ├── desktop/
│       │   ├── issues/          # Desktop-specific issues
│       │   └── trigger/         # Desktop automation triggers
│       ├── mobile/
│       │   └── trigger/         # Mobile automation triggers
│       ├── shared/              # Shared components
│       ├── trigger/             # Project-level automation triggers
│       └── web/
│           └── trigger/         # Web automation triggers
└── trigger/                     # Discipline-level automation triggers
    └── ESIGN-AUTO/
        └── issues/
```

## Code Placement

- **Signature capture UI components**: `client/src/common/components/e-signing/`
- **Signature workflow engine**: `server/src/services/e-signing/`
- **API integration layer**: `server/src/integrations/e-signing/`
- **Database schema**: `schema/e-signing/`
- **Tests**: `tests/e-signing/`