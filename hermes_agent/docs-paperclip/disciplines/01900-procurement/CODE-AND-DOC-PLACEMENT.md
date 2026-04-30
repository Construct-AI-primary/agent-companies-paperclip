# Code and Documentation Placement Guide - 01900 Procurement

This document defines the standard structure and placement for all code and documentation within the Procurement discipline.

## Directory Structure

```
01900-procurement/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Procurement procedures
│   ├── procurement-strategy.md
│   ├── supplier-evaluation.md
│   ├── tendering.md
│   └── purchase-orders.md
├── plans/                       # Procurement plans
│   └── procurement-operations-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── PROC-AUTO/             # Automated procurement workflows
│       └── issues/
│           └── PROC-AUTO-000-procurement-automation.md
├── knowledge/                   # Knowledge base
│   └── PAGE-KNOWLEDGE.md
└── projects/                    # Project implementations
    └── PROC-001/               # Standard Procurement Workflow
        ├── trigger/            # Project-level triggers
        ├── desktop/            # Desktop platform
        ├── mobile/             # Mobile platform
        ├── web/                # Web platform
        └── shared/             # Shared resources
```

## Trigger Placement

### Discipline-Level Triggers
Location: `trigger/PROC-AUTO/issues/`
- Covers automation for procurement processes
- Includes supplier discovery, RFQ generation, and approval workflows

### Project-Level Triggers
Location: `projects/PROC-001/trigger/`
- Covers project-specific procurement automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Procurement procedures:
- `procurement-strategy.md` - Strategy development
- `supplier-evaluation.md` - Supplier assessment
- `tendering.md` - Tendering processes
- `purchase-orders.md` - PO management

### plans/
Procurement planning documents:
- `procurement-operations-plan.md` - Operations strategy

### knowledge/
Procurement knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for procurement knowledge

### projects/PROC-001/
Procurement workflow implementation:
- `trigger/` - Project procurement triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
