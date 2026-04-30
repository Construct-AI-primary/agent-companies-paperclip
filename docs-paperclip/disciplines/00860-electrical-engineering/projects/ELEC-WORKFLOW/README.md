---
title: ELEC-WORKFLOW Project
author: PaperclipForge AI
date: 2026-04-17
version: 1.0
status: active
discipline: 00860-electrical-engineering
parent: UNIV-WORKFLOW
---

# ELEC-WORKFLOW Project

## Overview

The **ELEC-WORKFLOW** project provides electrical engineering domain workflow templates derived from the UNIV-WORKFLOW universal templates. It covers power distribution, transmission, substations, generators, cables, traffic signals, maintenance, and commissioning.

## Migration History

- **Created**: 2026-04-17
- **Source**: UNIV-WORKFLOW (Phase 7 issues)
- **Migration Method**: Discipline-specific project split per `discipline_workflow_conversion_procedure.md`

## Project Structure

```
ELEC-WORKFLOW/
├── README.md                    ← This file
├── project/
│   └── ELEC-WORKFLOW-implementation.md
├── issues/                      ← Phase 7 electrical issues (ELEC-001 to ELEC-008)
│   ├── ELEC-001-electrical-power-distribution-workflow.md
│   ├── ELEC-002-traffic-signals-intelligent-transportation-workflow.md
│   ├── ELEC-003-high-voltage-transmission-workflow.md
│   ├── ELEC-004-generator-power-plant-workflow.md
│   ├── ELEC-005-substation-design-workflow.md
│   ├── ELEC-006-cable-selection-reticulation-workflow.md
│   ├── ELEC-007-electrical-maintenance-workflow.md
│   ├── ELEC-008-electrical-commissioning-workflow.md
│   └── ISSUE-GENERATION-STATUS.md
├── knowledge/
│   └── PAGE-KNOWLEDGE.md        ← Domain knowledge for electrical engineering
└── trigger/
    └── README.md
```

## Covered Disciplines

| Issue | Workflow | Domain Area |
|-------|----------|-------------|
| ELEC-001 | Electrical Power Distribution | 4.16-35kV, transformers, NEC/NESC |
| ELEC-002 | Traffic Signals and ITS | MUTCD, timing, CCTV, fiber |
| ELEC-003 | High Voltage Transmission | 69kV-500kV, lattice/monopole towers |
| ELEC-004 | Generator and Power Plant | NFPA 110, ATS, paralleling |
| ELEC-005 | Substation Design | P&C, SCADA, breaker-and-a-half |
| ELEC-006 | Cable Selection and Reticulation | XLPE/EPR, ampacity, NEC/ICEA |
| ELEC-007 | Electrical Maintenance | Thermography, CMMS, NETA |
| ELEC-008 | Electrical Commissioning | Hi-pot, relay calibration, NFPA 70E |

## Related Documentation

- [UNIV-WORKFLOW Parent Project](../workflows-common/projects/UNIV-WORKFLOW/README.md)
- [00860 Electrical Engineering Discipline Index](../../para-index.md)
- [Discipline Workflow Conversion Procedure](../../procedures/workflows/discipline_workflow_conversion_procedure.md)

---

**Project Version**: 1.0
**Last Updated**: 2026-04-17
**Author**: PaperclipForge AI