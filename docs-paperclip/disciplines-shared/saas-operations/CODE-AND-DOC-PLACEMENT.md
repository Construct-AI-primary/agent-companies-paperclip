# Code and Documentation Placement Guide - SaaS Operations

This document defines the standard structure and placement for all code and documentation within the SaaS Operations discipline.

## Directory Structure

```
saas-operations/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # SaaS operations procedures
│   ├── platform-operations.md
│   ├── multi-tenant-management.md
│   ├── incident-response.md
│   └── deployment-management.md
├── plans/                       # SaaS operational plans
│   └── saas-operations-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── SAAS-AUTO/            # Automated SaaS operations workflows
│       └── issues/
│           └── SAAS-AUTO-000-saas-operations-automation.md
├── knowledge/                   # Knowledge base
│   └── PAGE-KNOWLEDGE.md
└── projects/                    # Project implementations
    └── SAAS-PROD-PREP/        # SaaS Production Preparation
        ├── trigger/            # Project-level triggers
        ├── desktop/            # Desktop platform
        ├── mobile/             # Mobile platform
        ├── web/                # Web platform
        └── shared/             # Shared resources
```

## Trigger Placement

### Discipline-Level Triggers
Location: `trigger/SAAS-AUTO/issues/`
- Covers automation for all SaaS operations
- Includes monitoring alerts, incident creation, and deployment workflows

### Project-Level Triggers
Location: `projects/SAAS-PROD-PREP/trigger/`
- Covers project-specific SaaS automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
SaaS operations procedures:
- `platform-operations.md` - Platform management
- `multi-tenant-management.md` - Multi-tenant oversight
- `incident-response.md` - Incident handling
- `deployment-management.md` - Deployment procedures

### plans/
SaaS operational planning documents:
- `saas-operations-plan.md` - Operations strategy

### knowledge/
SaaS operations knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for SaaS operations knowledge

### projects/SAAS-PROD-PREP/
SaaS production preparation:
- `trigger/` - Project SaaS triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
