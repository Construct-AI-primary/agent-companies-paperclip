---
title: Mining and Road Civils Code and Documentation Placement Standards
author: PaperclipForge AI
date: 2026-04-20
version: 1.0
status: active
---

# Mining and Road Civils Code and Documentation Placement Standards

## Overview

This document defines the standardized location for all code and documentation generated within the Mining and Road Civils cross-disciplinary project. This project spans multiple engineering disciplines and requires coordinated documentation placement across mining services, civil construction, and infrastructure development domains.

## Purpose

- **Cross-Discipline Consistency**: Ensure uniform file organization across all disciplines involved in mining and road civil projects
- **Multi-Domain Coordination**: Maintain clear separation between mining services, road construction, earthworks, logistics, safety, environmental, QA/QC, and security documentation
- **Integration Clarity**: Make it easy to find inter-discipline dependencies and interfaces
- **Lifecycle Coverage**: Support complete project lifecycle from feasibility through operations

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

## Mining and Road Civils Documentation Placement

### Discipline-Specific Documentation
```
docs-paperclip/disciplines-cross-sub/00002-mining-and-road-civils/
├── CODE-AND-DOC-PLACEMENT.md                    ← This placement standards document
├── DISCIPLINE-WORKFLOWS-CATALOG.md             ← Mining and road civil workflow catalog
├── DISCIPLINE-PLATFORM-STRUCTURE.md            ← Platform structure for mining/road projects
├── README.md                                   ← Mining and road civils overview
│
├── knowledge/
│   ├── PAGE-KNOWLEDGE.md                       ← Compiled mining and road civil knowledge base
│   ├── mining-services-knowledge.md            ← Mining-specific civil works knowledge
│   ├── road-construction-knowledge.md          ← Road/highway construction knowledge
│   ├── earthworks-knowledge.md                 ← Earthworks and ground preparation knowledge
│   ├── logistics-mining-knowledge.md           ← Mining logistics and supply chain knowledge
│   ├── safety-mining-road-knowledge.md          ← Safety requirements for mining and road
│   ├── environmental-mining-road-knowledge.md  ← Environmental impact knowledge
│   ├── qa-qc-mining-road-knowledge.md          ← Quality assurance/control knowledge
│   └── security-mining-road-knowledge.md        ← Security requirements for mining sites
│
├── procedures/
│   ├── mining-civil-works-procedures.md        ← General mining civil works procedures
│   ├── road-construction-procedures.md         ← Highway and urban road procedures
│   ├── earthworks-procedures.md                ← Earthworks and excavation procedures
│   ├── blasting-drilling-procedures.md        ← Drilling and blasting procedures
│   ├── haulage-logistics-procedures.md         ← Heavy equipment and logistics procedures
│   ├── hse-mining-road-procedures.md           ← HSE procedures for mining and road
│   └── maintenance-procedures.md               ← Operations and maintenance procedures
│
└── projects/
    └── MINROAD-INSTALL/
        ├── project.md                          ← Main mining/road project definition
        ├── workflows-list.md                   ← Mining/road workflow inventory
        ├── implementation.md                   ← Implementation status tracking
        │
        ├── knowledge/
        │   └── PAGE-KNOWLEDGE.md               ← Project-specific mining/road knowledge
        │
        ├── research/
        │   ├── mining-civil-research.md        ← Mining civil works research
        │   ├── road-construction-research.md  ← Road construction research
        │   ├── earthworks-research.md          ← Earthworks and ground improvement research
        │   ├── logistics-research.md           ← Mining logistics research
        │   ├── safety-research.md             ← Safety and compliance research
        │   ├── environmental-research.md      ← Environmental impact research
        │   ├── qa-research.md                  ← Quality assurance research
        │   └── security-research.md            ← Security requirements research
        │
        ├── desktop/
        │   ├── issues/                         ← Desktop/web application issues
        │   │   ├── MINROAD-001-site-assessment-feasibility.md
        │   │   ├── MINROAD-002-earthworks-planning.md
        │   │   ├── MINROAD-003-road-design-alignment.md
        │   │   ├── MINROAD-004-bridge-structure-design.md
        │   │   ├── MINROAD-005-haul-road-design.md
        │   │   ├── MINROAD-006-drilling-blasting-design.md
        │   │   ├── MINROAD-007-safety-compliance.md
        │   │   ├── MINROAD-008-environmental-assessment.md
        │   │   ├── MINROAD-009-qa-program-implementation.md
        │   │   ├── MINROAD-010-qc-inspection-testing.md
        │   │   ├── MINROAD-011-logistics-planning.md
        │   │   ├── MINROAD-012-security-systems.md
        │   │   ├── MINROAD-013-commissioning-testing.md
        │   │   ├── MINROAD-014-operations-maintenance.md
        │   │   └── MINROAD-015-project-closeout.md
        │   └── ISSUE-GENERATION-STATUS.md
        │
        ├── mobile/
        │   ├── issues/                         ← Mobile application issues
        │   │   ├── MOBILE-MINROAD-001-field-survey-app.md
        │   │   ├── MOBILE-MINROAD-002-inspection-app.md
        │   │   ├── MOBILE-MINROAD-003-maintenance-app.md
        │   │   └── MOBILE-MINROAD-004-equipment-tracking.md
        │   └── ISSUE-GENERATION-STATUS.md
        │
        └── web/
            ├── issues/                         ← Web portal issues
            │   ├── WEB-MINROAD-001-monitoring-dashboard.md
            │   ├── WEB-MINROAD-002-project-tracking.md
            │   ├── WEB-MINROAD-003-reporting-system.md
            │   └── WEB-MINROAD-004-alerts-notifications.md
            └── ISSUE-GENERATION-STATUS.md
```

### Cross-Discipline Integration Points

#### Mining Services Integration
- **Mining Civil Works**: `docs-paperclip/disciplines/00850-civil-engineering/projects/CIVIL-WORKFLOW/`
- **Haul Road Design**: Local mining-specific road documentation
- **Drilling and Blasting**: Integration with geotechnical and safety disciplines

#### Road Construction Integration
- **Highway Design**: `docs-paperclip/disciplines/00850-civil-engineering/projects/ROAD-WORKFLOW/`
- **Bridge Design**: `docs-paperclip/disciplines/00872-structural/projects/STRUCTURAL-WORKFLOW/`
- **Pavement Design**: Integration with materials engineering

#### Earthworks and Geotechnical Integration
- **Ground Improvement**: `docs-paperclip/disciplines/00855-geotechnical-engineering/projects/GEOTECH-WORKFLOW/`
- **Excavation Support**: Local earthworks specifications
- **Slope Stability**: Integration with geotechnical analysis

#### Safety/Security Integration
- **Safety Requirements**: `docs-paperclip/disciplines/02400-safety/projects/SAFETY-WORKFLOW/`
- **Security Systems**: `docs-paperclip/disciplines/02500-security/projects/SEC-WORKFLOW/`
- **HSE Monitoring**: Mining and road-specific HSE protocols

#### QA/QC Integration
- **Quality Programs**: `docs-paperclip/disciplines/02200-quality-assurance/projects/QA-WORKFLOW/`
- **Quality Control**: `docs-paperclip/disciplines/02250-quality-control/projects/QC-WORKFLOW/`
- **Compliance Auditing**: Mining and road-specific quality requirements

### Implementation Code Placement (paperclip-render)

```
paperclip-render/
├── packages/
│   └── mining-road-civil/           ← Mining and road civil shared components
│       ├── src/
│       │   ├── earthworks/          ← Earthworks calculation libraries
│       │   ├── road-design/         ← Road alignment and design tools
│       │   ├── logistics/           ← Fleet optimization and logistics
│       │   └── monitoring/          ← Progress monitoring utilities
│       └── package.json
│
├── server/
│   └── routes/
│       └── mining-road/             ← Mining/road specific API endpoints
│           ├── assessment.js        ← Site assessment APIs
│           ├── design.js            ← Design calculation APIs
│           └── monitoring.js        ← Progress monitoring APIs
│
└── ui/
    └── src/
        └── mining-road/             ← Mining/road UI components
            ├── assessment/          ← Site assessment components
            ├── design/              ← Design tools
            ├── monitoring/         ← Progress dashboards
            └── reporting/          ← Report generation
```

## File Naming Conventions

### Issue Files
- **Format**: `MINROAD-{NNN}-{descriptive-name}.md`
- **Platform Prefix**: `MOBILE-MINROAD-`, `WEB-MINROAD-` for platform-specific issues
- **Examples**:
  - `MINROAD-001-site-assessment-feasibility.md`
  - `MOBILE-MINROAD-001-field-survey-app.md`
  - `WEB-MINROAD-001-monitoring-dashboard.md`

### Knowledge Files
- **Format**: `{discipline}-mining-road-knowledge.md`
- **Examples**:
  - `mining-services-knowledge.md`
  - `road-construction-knowledge.md`
  - `earthworks-knowledge.md`

### Research Files
- **Format**: `mining-road-{topic}-research.md`
- **Examples**:
  - `mining-civil-research.md`
  - `road-construction-research.md`
  - `earthworks-research.md`

## Quality Assurance

### Documentation Standards
- All documents must include YAML frontmatter with title, author, date, version, status
- Cross-references must use relative paths within the mining and road civils directory
- External references must use full paths to other discipline directories

### Review Requirements
- All mining and road civil documentation must be reviewed by subject matter experts from relevant disciplines
- Cross-discipline interfaces must be validated by all affected disciplines
- Implementation documents must align with the workflows catalog

## Maintenance

### Version Control
- Major updates to placement standards require version increment
- Changes must be documented in the version history
- Breaking changes require migration plans

### Updates
- Annual review of placement standards
- Updates required when new disciplines are added to mining/road projects
- Continuous improvement based on project execution feedback

---

**Document Version**: 1.0
**Last Updated**: 2026-04-20
**Next Review**: 2027-04-20
**Contact**: Mining and Road Civils Project Team
