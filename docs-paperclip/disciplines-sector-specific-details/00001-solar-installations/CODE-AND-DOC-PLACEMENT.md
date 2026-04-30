---
title: Solar Installations Code and Documentation Placement Standards
author: PaperclipForge AI
date: 2026-04-18
version: 1.0
status: active
---

# Solar Installations Code and Documentation Placement Standards

## Overview

This document defines the standardized location for all code and documentation generated within the Solar Installations cross-disciplinary project. This project spans 11 engineering disciplines and requires coordinated documentation placement across multiple domains.

## Purpose

- **Cross-Discipline Consistency**: Ensure uniform file organization across all 11 disciplines involved in solar installations
- **Multi-Domain Coordination**: Maintain clear separation between electrical, civil, geotechnical, architectural, safety, environmental, QA/QC, and security documentation
- **Integration Clarity**: Make it easy to find inter-discipline dependencies and interfaces
- **Lifecycle Coverage**: Support complete solar project lifecycle from feasibility through operations

## Repository Structure

The Paperclip ecosystem uses **two repositories**:

| Repository | URL | Purpose |
|------------|-----|---------|
| **paperclip-render** | `https://github.com/Construct-AI-primary/paperclip-render.git` | Implementation code only |
| **docs-paperclip** | `https://github.com/Construct-AI-primary/docs-paperclip.git` | Documentation, plans, issues, procedures |

### Critical Rule
> ⚠️ **Never put implementation code in docs-paperclip**
> ⚠️ **Never put documentation in paperclip-render**
> ⚠️ **Never put code in docs-paperclip**
> ⚠️ **Never put docs in paperclip-render**

## Solar Installations Documentation Placement

### Discipline-Specific Documentation
```
docs-paperclip/disciplines-cross-sub/00001-solar-installations/
├── CODE-AND-DOC-PLACEMENT.md                    ← This placement standards document
├── DISCIPLINE-WORKFLOWS-CATALOG.md             ← Solar workflow catalog (11 disciplines)
├── DISCIPLINE-PLATFORM-STRUCTURE.md            ← Platform structure for solar project
├── README.md                                   ← Solar installations overview
│
├── knowledge/
│   ├── PAGE-KNOWLEDGE.md                       ← Compiled solar knowledge base
│   ├── electrical-solar-knowledge.md           ← Electrical-specific solar knowledge
│   ├── civil-solar-knowledge.md               ← Civil/geotechnical solar knowledge
│   ├── architectural-solar-knowledge.md       ← Building integration knowledge
│   ├── safety-solar-knowledge.md              ← Safety requirements for solar
│   ├── environmental-solar-knowledge.md       ← Environmental impact knowledge
│   ├── qa-qc-solar-knowledge.md              ← Quality assurance/control knowledge
│   └── security-solar-knowledge.md            ← Security requirements for solar
│
├── procedures/
│   ├── solar-installation-procedures.md        ← General solar installation procedures
│   ├── electrical-interconnection-procedures.md ← Grid interconnection procedures
│   ├── structural-mounting-procedures.md      ← Mounting system procedures
│   ├── commissioning-procedures.md            ← Testing and commissioning procedures
│   └── maintenance-procedures.md              ← Operations and maintenance procedures
│
└── projects/
    └── SOLAR-INSTALL/
        ├── project.md                          ← Main solar project definition
        ├── workflows-list.md                   ← Solar workflow inventory
        ├── implementation.md                   ← Implementation status tracking
        │
        ├── knowledge/
        │   └── PAGE-KNOWLEDGE.md               ← Project-specific solar knowledge
        │
        ├── research/
        │   ├── solar-electrical-research.md    ← Electrical system research
        │   ├── solar-structural-research.md    ← Mounting and foundation research
        │   ├── solar-integration-research.md   ← Building/architectural research
        │   ├── solar-safety-research.md        ← Safety and compliance research
        │   ├── solar-environmental-research.md ← Environmental impact research
        │   ├── solar-qa-research.md            ← Quality assurance research
        │   └── solar-security-research.md      ← Security requirements research
        │
        ├── desktop/
        │   ├── issues/                         ← Desktop/web application issues
        │   │   ├── SOLAR-001-site-assessment-feasibility.md
        │   │   ├── SOLAR-002-structural-design-mounting.md
        │   │   ├── SOLAR-003-electrical-system-design.md
        │   │   ├── SOLAR-004-architectural-integration.md
        │   │   ├── SOLAR-005-safety-compliance.md
        │   │   ├── SOLAR-006-environmental-assessment.md
        │   │   ├── SOLAR-007-qa-program-implementation.md
        │   │   ├── SOLAR-008-qc-inspection-testing.md
        │   │   ├── SOLAR-009-security-systems.md
        │   │   ├── SOLAR-010-commissioning-testing.md
        │   │   ├── SOLAR-011-operations-maintenance.md
        │   │   └── SOLAR-012-project-closeout.md
        │   └── ISSUE-GENERATION-STATUS.md
        │
        ├── mobile/
        │   ├── issues/                         ← Mobile application issues
        │   │   ├── MOBILE-SOLAR-001-field-survey-app.md
        │   │   ├── MOBILE-SOLAR-002-inspection-app.md
        │   │   ├── MOBILE-SOLAR-003-maintenance-app.md
        │   │   └── MOBILE-SOLAR-004-offline-monitoring.md
        │   └── ISSUE-GENERATION-STATUS.md
        │
        └── web/
            ├── issues/                         ← Web portal issues
            │   ├── WEB-SOLAR-001-monitoring-dashboard.md
            │   ├── WEB-SOLAR-002-client-portal.md
            │   ├── WEB-SOLAR-003-reporting-system.md
            │   └── WEB-SOLAR-004-alerts-notifications.md
            └── ISSUE-GENERATION-STATUS.md
```

### Cross-Discipline Integration Points

#### Electrical Integration
- **Grid Interconnection**: `docs-paperclip/disciplines/00860-electrical-engineering/projects/ELEC-WORKFLOW/`
- **Solar Electrical Systems**: Local solar-specific electrical documentation
- **Protection Coordination**: Integration with utility protection schemes

#### Civil/Geotechnical Integration
- **Foundation Design**: `docs-paperclip/disciplines/00855-geotechnical-engineering/projects/GEOTECH-WORKFLOW/`
- **Structural Mounting**: Local mounting system specifications
- **Site Preparation**: Integration with civil earthworks

#### Architectural Integration
- **Building Integration**: `docs-paperclip/disciplines/00825-architectural/projects/ARCH-WORKFLOW/`
- **BIPV Systems**: Building-integrated photovoltaic specifications
- **Aesthetic Coordination**: Visual integration requirements

#### Safety/Security Integration
- **Safety Requirements**: `docs-paperclip/disciplines/02400-safety/projects/SAFETY-WORKFLOW/`
- **Security Systems**: `docs-paperclip/disciplines/02500-security/projects/SEC-WORKFLOW/`
- **Emergency Planning**: Solar farm safety protocols

#### QA/QC Integration
- **Quality Programs**: `docs-paperclip/disciplines/02200-quality-assurance/projects/QA-WORKFLOW/`
- **Quality Control**: `docs-paperclip/disciplines/02250-quality-control/projects/QC-WORKFLOW/`
- **Compliance Auditing**: Solar-specific quality requirements

### Implementation Code Placement (paperclip-render)

```
paperclip-render/
├── packages/
│   └── solar-integration/           ← Solar-specific shared components
│       ├── src/
│       │   ├── electrical/          ← Electrical calculation libraries
│       │   ├── structural/          ← Structural analysis components
│       │   ├── environmental/       ← Environmental impact tools
│       │   └── monitoring/          ← Performance monitoring utilities
│       └── package.json
│
├── server/
│   └── routes/
│       └── solar/                   ← Solar-specific API endpoints
│           ├── assessment.js        ← Site assessment APIs
│           ├── design.js            ← Design calculation APIs
│           └── monitoring.js        ← Performance monitoring APIs
│
└── ui/
    └── src/
        └── solar/                   ← Solar UI components
            ├── assessment/          ← Site assessment components
            ├── design/              ← Design tools
            ├── monitoring/          ← Performance dashboards
            └── reporting/           ← Report generation
```

## File Naming Conventions

### Issue Files
- **Format**: `SOLAR-{NNN}-{descriptive-name}.md`
- **Platform Prefix**: `MOBILE-SOLAR-`, `WEB-SOLAR-` for platform-specific issues
- **Examples**:
  - `SOLAR-001-site-assessment-feasibility.md`
  - `MOBILE-SOLAR-001-field-survey-app.md`
  - `WEB-SOLAR-001-monitoring-dashboard.md`

### Knowledge Files
- **Format**: `{discipline}-solar-knowledge.md`
- **Examples**:
  - `electrical-solar-knowledge.md`
  - `civil-solar-knowledge.md`
  - `architectural-solar-knowledge.md`

### Research Files
- **Format**: `solar-{topic}-research.md`
- **Examples**:
  - `solar-electrical-research.md`
  - `solar-structural-research.md`
  - `solar-environmental-research.md`

## Quality Assurance

### Documentation Standards
- All documents must include YAML frontmatter with title, author, date, version, status
- Cross-references must use relative paths within the solar installations directory
- External references must use full paths to other discipline directories

### Review Requirements
- All solar-specific documentation must be reviewed by subject matter experts from relevant disciplines
- Cross-discipline interfaces must be validated by all affected disciplines
- Implementation documents must align with the workflows catalog

## Maintenance

### Version Control
- Major updates to placement standards require version increment
- Changes must be documented in the version history
- Breaking changes require migration plans

### Updates
- Annual review of placement standards
- Updates required when new disciplines are added to solar projects
- Continuous improvement based on project execution feedback

---

**Document Version**: 1.0
**Last Updated**: 2026-04-18
**Next Review**: 2027-04-18
**Contact**: Solar Installations Project Team