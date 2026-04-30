---
title: PROC-LONG Project - Long-Lead Item Procurement Workflow
description: Long-Lead Item Procurement Workflow project documentation
author: Paperclip Orchestration System
date: 2026-04-08
version: 1.0
status: active
project_code: PROC-LONG
discipline: 01900-procurement
---

# PROC-LONG - Long-Lead Item Procurement Workflow

## Overview

This directory contains documentation, issues, and orchestration for the Long-Lead Item Procurement Workflow project within the Procurement discipline.

## Repository Structure

```
docs-paperclip/disciplines/01900-procurement/projects/PROC-LONG/
├── README.md                    ← This file
├── project.md                   ← Project charter
├── plan.md                      ← Project plan
├── AGENTS.md                    ← Project-specific agent instructions
├── PROC-LONG-workflows-list.md ← Workflows catalog
├── PROC-LONG-implementation.md ← Implementation plan
├── discipline_workflow_conversion_procedure.md
├── trigger/                     ← Project automation triggers
│   └── PROC-LONG-000-project-automation.md
├── issues/                     ← Project issues and requirements
├── knowledge/                   ← Project-specific knowledge
│   └── PAGE-KNOWLEDGE.md
├── learning/                    ← Learning tracker
├── orchestration/              ← Workflow orchestration
├── training/                   ← Training curriculum
├── research/                   ← Research artifacts
│   └── PROC-LONG-research-enhancement-plan.md
├── scripts/                    ← Automation scripts
│   └── generate-issues.py
├── desktop/                    ← Desktop platform implementation
│   ├── trigger/
│   ├── issues/
│   ├── learning/
│   └── orchestration/
├── mobile/                     ← Mobile platform implementation
│   ├── trigger/
│   ├── issues/
│   ├── learning/
│   └── orchestration/
├── web/                        ← Web platform implementation
│   ├── trigger/
│   ├── issues/
│   ├── learning/
│   └── orchestration/
└── shared/                    ← Shared components
    ├── api/
    ├── business-logic/
    └── data-models/
```

## Key Files

- **README.md**: This overview document
- **project.md**: Project charter with scope and objectives
- **plan.md**: Project timeline and milestones
- **AGENTS.md**: Agent assignments and responsibilities
- **PROC-LONG-workflows-list.md**: Catalog of all workflows
- **PROC-LONG-implementation.md**: Detailed implementation plan
- **discipline_workflow_conversion_procedure.md**: Workflow conversion guide
- **trigger/**: Project automation trigger files
- **issues/**: Project issues and requirements
- **knowledge/**: Project-specific knowledge base
- **learning/**: Learning tracker and artifacts
- **orchestration/**: Workflow orchestration documentation
- **training/**: Training curriculum and materials
- **research/**: Research and enhancement plans
- **scripts/**: Automation scripts
- **desktop/**: Desktop platform implementation
- **mobile/**: Mobile platform implementation
- **web/**: Web platform implementation
- **shared/**: Shared API, business logic, and data models

## Project Scope

### In Scope
- Long-lead item identification and planning
- Early procurement initiation and scheduling
- Critical path integration and monitoring
- Supplier relationship management for long-term items
- Inventory and staging coordination

### Out of Scope
- Invoice processing and payment (covered in PROC-INV)
- Supplier qualification and onboarding
- Standard procurement order processing

## Success Metrics

- **Item Identification Accuracy**: >95% target
- **Procurement Initiation Timeliness**: >90% target
- **Critical Path Integration**: >98% target
- **Supplier Relationship Management**: >85% target

---

**Document Version**: 1.0
**Last Updated**: 2026-04-08
