---
title: 00886 Logistics Director - Code and Documentation Placement
---

# 00886 Logistics Director - Code and Documentation Placement

## Discipline Overview

This document defines the standardized location for all code and documentation within the 00886 Logistics Director discipline.

## Standard Structure


```
00886-logistics-director/
├── CODE-AND-DOC-PLACEMENT.md    ← This file
├── README.md                     ← Discipline overview
├── knowledge/                   ← Cross-project domain knowledge
│   └── PAGE-KNOWLEDGE.md
├── projects/                    ← All discipline projects
│   └── {PROJECT-CODE}/
│       ├── README.md            ← Project overview
│       ├── plan.md              ← Project plan
│       ├── AGENTS.md            ← Project-specific agent instructions
│       ├── trigger/             ← Project automation triggers
│       │   ├── README.md
│       │   └── {PROJECT}-000-project-automation.md
│       ├── {PROJECT}-workflows-list.md       ← Workflows catalog
│       ├── {PROJECT}-implementation.md       ← Implementation plan
│       ├── discipline_workflow_conversion_procedure.md
│       ├── research/            ← Research enhancement plans
│       │   └── {PROJECT}-research-enhancement-plan.md
│       ├── scripts/             ← Generator scripts
│       │   └── generate-issues.py
│       ├── desktop/             ← Desktop platform
│       │   ├── trigger/         ← Desktop-specific triggers
│       │   │   ├── README.md
│       │   │   └── {PROJECT}-000-project-automation.md
│       │   ├── issues/
│       │   │   ├── {ISSUE-ID}.md
│       │   │   └── ISSUE-GENERATION-STATUS.md
│       │   ├── learning/
│       │   └── orchestration/
│       ├── mobile/              ← Mobile platform
│       │   ├── trigger/         ← Mobile-specific triggers
│       │   │   ├── README.md
│       │   │   └── {PROJECT}-000-project-automation.md
│       │   ├── issues/
│       │   │   ├── {ISSUE-ID}.md
│       │   │   └── ISSUE-GENERATION-STATUS.md
│       │   ├── learning/
│       │   └── orchestration/
│       ├── web/                 ← Web platform
│       │   ├── trigger/         ← Web-specific triggers
│       │   │   ├── README.md
│       │   │   └── {PROJECT}-000-project-automation.md
│       │   ├── issues/
│       │   │   ├── {ISSUE-ID}.md
│       │   │   └── ISSUE-GENERATION-STATUS.md
│       │   ├── learning/
│       │   └── orchestration/
│       ├── shared/              ← Shared across platforms
│       │   ├── api/             ← API contracts
│       │   ├── business-logic/  ← Business logic docs
│       │   └── data-models/     ← Data model docs
│       └── knowledge/           ← Project-specific knowledge
│           └── PAGE-KNOWLEDGE.md
├── trigger/                     ← Discipline automation triggers
│   ├── README.md
│   └── {AUTO-PROJECT}/
│       └── issues/
│           └── {AUTO-PROJECT}-000-discipline-automation.md
├── procedures/
└── plans/
```


## Discipline-Specific Notes

- Logistics Director discipline for construction and engineering projects
- Desktop, mobile, and web platform support

## Related Documents

- [Code and Documentation Placement Procedure](../../procedures/workflows/code-and-doc-placement-procedure.md)
