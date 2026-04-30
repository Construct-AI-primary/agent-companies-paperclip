---
title: CIVIL-WORKFLOW Project
author: PaperclipForge AI
date: 2026-04-17
version: 1.0
status: active
discipline: 00850-civil-engineering
parent: UNIV-WORKFLOW
---

# CIVIL-WORKFLOW Project

## Overview

The **CIVIL-WORKFLOW** project provides civil engineering domain workflow templates derived from the UNIV-WORKFLOW universal templates. It covers stormwater, roads, bridges, utilities, earthworks, mining, pipelines, water reticulation, and tunnel design.

## Migration History

- **Created**: 2026-04-17
- **Source**: UNIV-WORKFLOW (Phase 6 issues)
- **Migration Method**: Discipline-specific project split per `discipline_workflow_conversion_procedure.md`

## Project Structure

```
CIVIL-WORKFLOW/
├── README.md                    ← This file
├── project/
│   └── CIVIL-WORKFLOW-implementation.md
├── issues/                      ← Phase 6 civil issues (CIVIL-001 to CIVIL-009)
│   ├── CIVIL-001-stormwater-management-workflow.md
│   ├── CIVIL-002-road-highway-design-workflow.md
│   ├── CIVIL-003-bridge-structural-design-workflow.md
│   ├── CIVIL-004-utilities-infrastructure-workflow.md
│   ├── CIVIL-005-earthworks-excavation-workflow.md
│   ├── CIVIL-006-mining-surface-operations-workflow.md
│   ├── CIVIL-007-pipeline-design-workflow.md
│   ├── CIVIL-008-water-reticulation-workflow.md
│   ├── CIVIL-009-tunnel-design-workflow.md
│   └── ISSUE-GENERATION-STATUS.md
├── knowledge/
│   └── PAGE-KNOWLEDGE.md        ← Domain knowledge for civil engineering
└── trigger/
    └── README.md
```

## Covered Disciplines

| Issue | Workflow | Domain Area |
|-------|----------|-------------|
| CIVIL-001 | Stormwater Management | Hydrology, detention, BMPs |
| CIVIL-002 | Road and Highway Design | Geometrics, pavement, AASHTO |
| CIVIL-003 | Bridge and Structural Design | Culverts, bridges, retaining walls |
| CIVIL-004 | Utilities Infrastructure | Water, sewer, utility coordination |
| CIVIL-005 | Earthworks and Excavation | Grading, cut/fill, compaction |
| CIVIL-006 | Mining and Surface Operations | Open pit, haul roads, MSHA |
| CIVIL-007 | Pipeline Design | Water, sewer, HDPE/DI/Steel |
| CIVIL-008 | Water Reticulation | Distribution networks, EPANET |
| CIVIL-009 | Tunnel Design | NATM, TBM, ground support |

## Related Documentation

- [UNIV-WORKFLOW Parent Project](../workflows-common/projects/UNIV-WORKFLOW/README.md)
- [00850 Civil Engineering Discipline Index](../../para-index.md)
- [Discipline Workflow Conversion Procedure](../../procedures/workflows/discipline_workflow_conversion_procedure.md)

---

**Project Version**: 1.0
**Last Updated**: 2026-04-17
**Author**: PaperclipForge AI