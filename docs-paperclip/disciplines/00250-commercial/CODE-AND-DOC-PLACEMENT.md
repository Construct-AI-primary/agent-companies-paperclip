---
title: 00250 Commercial - Code and Documentation Placement
---

# 00250 Commercial - Code and Documentation Placement

## Discipline Overview

This document defines the standardized location for all code and documentation within the 00250 Commercial discipline.

## Standard Structure

```
00250-commercial/
├── CODE-AND-DOC-PLACEMENT.md    ← This file
├── README.md                     ← Discipline overview
├── knowledge/                   ← Cross-project domain knowledge
│   └── PAGE-KNOWLEDGE.md
├── projects/
│   └── {PROJECT-CODE}/
│       ├── desktop/
│       │   ├── trigger/
│       │   ├── issues/
│       │   ├── learning/
│       │   └── orchestration/
│       ├── mobile/
│       │   ├── trigger/
│       │   ├── issues/
│       │   ├── learning/
│       │   └── orchestration/
│       ├── web/
│       │   ├── trigger/
│       │   ├── issues/
│       │   ├── learning/
│       │   └── orchestration/
│       └── shared/
├── trigger/                     ← Discipline-level trigger
│   └── {DISCIPLINE}-AUTO/
│       └── issues/
├── procedures/
└── plans/
```

## Discipline-Specific Notes

- Commercial workflows for business operations
- Desktop and mobile platform support

## Related Documents

- [Code and Documentation Placement Procedure](../../procedures/workflows/code-and-doc-placement-procedure.md)
