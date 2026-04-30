# Code and Documentation Placement Guide - Testing

This document defines the standard structure and placement for all code and documentation within the Testing discipline.

## Directory Structure

```
testing/
├── README.md                    # Discipline overview (this file's parent)
├── CODE-AND-DOC-PLACEMENT.md    # This guide
├── procedures/                  # Testing procedures
│   ├── test-strategy.md
│   ├── test-automation.md
│   ├── performance-testing.md
│   └── security-testing.md
├── plans/                       # Test plans
│   └── testing-operations-plan.md
├── trigger/                     # Discipline-level automation triggers
│   └── TEST-AUTO/            # Automated testing workflows
│       └── issues/
│           └── TEST-AUTO-000-testing-automation.md
├── knowledge/                   # Knowledge base
│   └── PAGE-KNOWLEDGE.md
└── projects/                    # Project implementations
    ├── PROD-TEST/             # Production Testing
    │   ├── trigger/            # Project-level triggers
    │   ├── desktop/            # Desktop platform
    │   ├── mobile/             # Mobile platform
    │   ├── web/                # Web platform
    │   └── shared/             # Shared resources
    └── MOBILE-TEST/          # Mobile Testing
        ├── trigger/            # Project-level triggers
        ├── desktop/            # Desktop platform
        ├── mobile/             # Mobile platform
        ├── web/                # Web platform
        └── shared/             # Shared resources
```

## Trigger Placement

### Discipline-Level Triggers
Location: `trigger/TEST-AUTO/issues/`
- Covers automation for all testing processes
- Includes test scheduling, result collection, and defect creation

### Project-Level Triggers
Location: `projects/{PROJECT}/trigger/`
- Covers project-specific testing automation needs
- Links to discipline-level triggers

## Content Guidelines

### procedures/
Testing procedures:
- `test-strategy.md` - Testing strategy development
- `test-automation.md` - Automation frameworks
- `performance-testing.md` - Performance validation
- `security-testing.md` - Security validation

### plans/
Testing planning documents:
- `testing-operations-plan.md` - Overall testing strategy

### knowledge/
Testing knowledge:
- `PAGE-KNOWLEDGE.md` - PARA index for testing knowledge

### projects/PROD-TEST/
Production testing:
- `trigger/` - Project testing triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

### projects/MOBILE-TEST/
Mobile testing:
- `trigger/` - Project testing triggers
- `desktop/` - Desktop-specific implementations
- `mobile/` - Mobile-specific implementations
- `web/` - Web-specific implementations
- `shared/` - Cross-platform shared resources

## File Naming Conventions

- Procedures: `kebab-case.md`
- Plans: `YYYY-MM-DD-descriptive-name.md`
- Triggers: `{PREFIX}-{NUMBER}-{slug}.md`
- Knowledge: `PAGE-KNOWLEDGE.md`
