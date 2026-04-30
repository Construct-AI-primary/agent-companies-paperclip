---
title: "02025-Measurement Code and Documentation Placement Guide"
description: "Comprehensive guide for placing code and documentation in the cross-discipline measurement platform"
gigabrain_tags: cross-discipline, 02025-measurement, documentation, code-placement, guide
para_section: disciplines-shared/measurement
last_updated: 2026-04-20
---

# 02025-Measurement Code and Documentation Placement Guide

## Overview

This guide defines the standard locations for all code and documentation related to the IntegrateForge AI cross-discipline measurement platform.

## Documentation Placement

### Root Level Files

| File | Location | Purpose |
|------|----------|---------|
| Platform Structure | `./DISCIPLINE-PLATFORM-STRUCTURE.md` | Platform architecture overview |
| Workflows Catalog | `./DISCIPLINE-WORKFLOWS-CATALOG.md` | All workflow definitions |
| This Guide | `./CODE-AND-DOC-PLACEMENT.md` | Placement standards |

### Subdirectories

```
disciplines-shared/measurement/
├── DISCIPLINE-PLATFORM-STRUCTURE.md    # Platform overview
├── DISCIPLINE-WORKFLOWS-CATALOG.md     # Workflow catalog
├── CODE-AND-DOC-PLACEMENT.md          # This guide
│
├── knowledge/                         # Knowledge base
│   └── PAGE-KNOWLEDGE.md             # Main knowledge entry
│
├── plans/                            # Planning documents
│   └── (Architecture, implementation plans)
│
├── procedures/                       # Operational procedures
│   └── (Procedure files)
│
└── projects/                        # Project implementations
    └── MEASURE-COMM/                 # Measurement Communication Project
        ├── project.md
        ├── implementation.md
        └── desktop/
            └── issues/
```

## Code Placement

### Frontend Components

```
ui/src/components/integrateforge/
├── common/
│   ├── IntegrationCard.tsx
│   ├── StatusBadge.tsx
│   ├── ConnectionWizard.tsx
│   └── SyncStatus.tsx
│
├── measurement/
│   ├── MeasurementGrid.tsx
│   ├── AccuracyMeter.tsx
│   ├── CalibrationPanel.tsx
│   └── StandardsValidator.tsx
│
├── file-handler/
│   ├── FileUploader.tsx
│   └── FilePreview.tsx
│
└── results/
    ├── ResultsTable.tsx
    └── ResultsExport.tsx
```

### Backend Services

```
server/src/
├── controllers/
│   └── integrateController.js      # Integration API endpoints
│
├── services/
│   ├── integrateService.js         # Integration business logic
│   └── opencvService.js           # OpenCV processing
│
└── routes/
    └── integrate.js                # Integration routes
```

### Agent Code

```
docs-construct-ai/codebase/agents/
├── integrateforge/
│   ├── ada-autocad/
│   ├── cash-costx/
│   └── [other integration agents]
│
└── swarm-02025-qs-dwg/
    ├── coordinator/
    ├── agents/
    └── opencv-engine/
```

## Related Discipline Documentation

### QS Discipline (Primary)
```
disciplines/02025-quantity-surveying/
├── plans/ui-ux/
│   └── 2026-04-20-integrateforge-shared-ui-ux-specification.md
│
└── projects/PROC-001/
    └── QS-DWG-SWARM-ENTERPRISE/
```

### Civil Engineering (Cross-reference)
```
disciplines/00850-civil-engineering/
└── projects/CIVIL-WORKFLOW/
```

### Voice Communication (Pattern Reference)
```
disciplines-non/voice-communication/
```

## Integration Checklist

When adding a new integration:

- [ ] Add agent to `docs-paperclip/companies/integrateforge-ai/agents/`
- [ ] Add UI component to `ui/src/components/integrateforge/`
- [ ] Add API endpoint to `server/src/routes/integrate.js`
- [ ] Update workflow catalog in `DISCIPLINE-WORKFLOWS-CATALOG.md`
- [ ] Add integration agent to cross-reference documentation
- [ ] Update PAGE-KNOWLEDGE.md with new integration

---

**Document Version**: 1.0
**Last Updated**: 2026-04-20
