---
title: Traffic Signals Code and Documentation Placement Standards
author: PaperclipForge AI
date: 2026-04-20
version: 1.0
status: active
---

# Traffic Signals Code and Documentation Placement Standards

## Overview

This document defines the standardized location for all code and documentation generated within the Traffic Signals cross-disciplinary project. This project spans multiple engineering disciplines and requires coordinated documentation placement across multiple domains.

## Purpose

- **Cross-Discipline Consistency**: Ensure uniform file organization across all disciplines involved in traffic signal installations
- **Multi-Domain Coordination**: Maintain clear separation between electrical, civil, geotechnical, ITS (Intelligent Transportation Systems), safety, environmental, QA/QC, and security documentation
- **Integration Clarity**: Make it easy to find inter-discipline dependencies and interfaces
- **Lifecycle Coverage**: Support complete traffic signal project lifecycle from feasibility through operations

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

## Traffic Signals Documentation Placement

### Discipline-Specific Documentation
```
docs-paperclip/disciplines-cross-sub/00002-traffic-signals/
├── CODE-AND-DOC-PLACEMENT.md                    ← This placement standards document
├── DISCIPLINE-WORKFLOWS-CATALOG.md             ← Traffic signal workflow catalog
├── DISCIPLINE-PLATFORM-STRUCTURE.md            ← Platform structure for traffic signal project
├── README.md                                   ← Traffic signals overview
│
├── knowledge/
│   ├── PAGE-KNOWLEDGE.md                       ← Compiled traffic signal knowledge base
│   ├── electrical-traffic-knowledge.md         ← Electrical-specific traffic signal knowledge
│   ├── civil-traffic-knowledge.md              ← Civil/geotechnical traffic signal knowledge
│   ├── its-traffic-knowledge.md                ← ITS and traffic control knowledge
│   ├── safety-traffic-knowledge.md             ← Safety requirements for traffic signals
│   ├── environmental-traffic-knowledge.md      ← Environmental impact knowledge
│   ├── qaqc-traffic-knowledge.md               ← Quality assurance/control knowledge
│   └── security-traffic-knowledge.md           ← Security requirements for traffic signals
│
├── procedures/
│   ├── traffic-signal-installation-procedures.md
│   ├── electrical-interconnection-procedures.md
│   ├── civil-works-procedures.md
│   ├── its-commissioning-procedures.md
│   └── maintenance-procedures.md
│
└── projects/
    └── TRAFFIC-SIGNALS/
        ├── project.md                          ← Main traffic signal project definition
        ├── workflows-list.md                   ← Traffic signal workflow inventory
        ├── implementation.md                   ← Implementation status tracking
        │
        ├── knowledge/
        │   └── PAGE-KNOWLEDGE.md               ← Project-specific traffic signal knowledge
        │
        ├── research/
        │   ├── traffic-electrical-research.md
        │   ├── traffic-civil-research.md
        │   ├── traffic-its-research.md
        │   ├── traffic-safety-research.md
        │   ├── traffic-environmental-research.md
        │   ├── traffic-qa-research.md
        │   └── traffic-security-research.md
        │
        ├── desktop/
        │   ├── issues/
        │   │   ├── TRAFFIC-001-site-assessment-feasibility.md
        │   │   ├── TRAFFIC-002-civil-infrastructure-design.md
        │   │   ├── TRAFFIC-003-electrical-system-design.md
        │   │   ├── TRAFFIC-004-its-controller-integration.md
        │   │   ├── TRAFFIC-005-safety-compliance.md
        │   │   ├── TRAFFIC-006-environmental-assessment.md
        │   │   ├── TRAFFIC-007-qa-program-implementation.md
        │   │   ├── TRAFFIC-008-qc-inspection-testing.md
        │   │   ├── TRAFFIC-009-security-systems.md
        │   │   ├── TRAFFIC-010-commissioning-testing.md
        │   │   ├── TRAFFIC-011-operations-maintenance.md
        │   │   └── TRAFFIC-012-project-closeout.md
        │   └── ISSUE-GENERATION-STATUS.md
        │
        ├── mobile/
        │   ├── issues/
        │   │   ├── MOBILE-TRAFFIC-001-field-survey-app.md
        │   │   ├── MOBILE-TRAFFIC-002-inspection-app.md
        │   │   ├── MOBILE-TRAFFIC-003-maintenance-app.md
        │   │   └── MOBILE-TRAFFIC-004-offline-monitoring.md
        │   └── ISSUE-GENERATION-STATUS.md
        │
        └── web/
            ├── issues/
            │   ├── WEB-TRAFFIC-001-monitoring-dashboard.md
            │   ├── WEB-TRAFFIC-002-client-portal.md
            │   ├── WEB-TRAFFIC-003-reporting-system.md
            │   └── WEB-TRAFFIC-004-alerts-notifications.md
            └── ISSUE-GENERATION-STATUS.md
```

### Cross-Discipline Integration Points

#### Electrical Integration
- **Power Distribution**: `docs-paperclip/disciplines/00860-electrical-engineering/projects/ELEC-WORKFLOW/`
- **Traffic Signal Electrical**: Local traffic-specific electrical documentation
- **Protection Coordination**: Integration with utility protection schemes

#### Civil/Geotechnical Integration
- **Foundation Design**: `docs-paperclip/disciplines/00855-geotechnical-engineering/projects/GEOTECH-WORKFLOW/`
- **Roadway Civil Works**: `docs-paperclip/disciplines/00850-civil-engineering/projects/CIVIL-WORKFLOW/`
- **Pole Foundations**: Local foundation specifications

#### ITS Integration
- **Traffic Control Systems**: Local ITS documentation
- **Central Management**: Integration with traffic management centers
- **Communication Networks**: Fiber, wireless, and cellular integration

#### Safety/Security Integration
- **Safety Requirements**: `docs-paperclip/disciplines/02400-safety/projects/SAFETY-WORKFLOW/`
- **Security Systems**: `docs-paperclip/disciplines/02500-security/projects/SEC-WORKFLOW/`
- **Work Zone Safety**: Traffic control during construction

### Implementation Code Placement (paperclip-render)

```
paperclip-render/
├── packages/
│   └── traffic-signals/           ← Traffic signal-specific shared components
│       ├── src/
│       │   ├── electrical/        ← Electrical calculation libraries
│       │   ├── civil/             ← Civil design components
│       │   ├── its/               ← ITS integration utilities
│       │   └── monitoring/        ← Performance monitoring utilities
│       └── package.json
│
├── server/
│   └── routes/
│       └── traffic/               ← Traffic signal-specific API endpoints
│           ├── assessment.js
│           ├── design.js
│           └── monitoring.js
│
└── ui/
    └── src/
        └── traffic/               ← Traffic signal UI components
            ├── assessment/
            ├── design/
            ├── monitoring/
            └── reporting/
```

## File Naming Conventions

### Issue Files
- **Format**: `TRAFFIC-{NNN}-{descriptive-name}.md`
- **Platform Prefix**: `MOBILE-TRAFFIC-`, `WEB-TRAFFIC-` for platform-specific issues
- **Examples**:
  - `TRAFFIC-001-site-assessment-feasibility.md`
  - `MOBILE-TRAFFIC-001-field-survey-app.md`
  - `WEB-TRAFFIC-001-monitoring-dashboard.md`

### Knowledge Files
- **Format**: `{discipline}-traffic-knowledge.md`
- **Examples**:
  - `electrical-traffic-knowledge.md`
  - `civil-traffic-knowledge.md`
  - `its-traffic-knowledge.md`

### Research Files
- **Format**: `traffic-{topic}-research.md`
- **Examples**:
  - `traffic-electrical-research.md`
  - `traffic-civil-research.md`
  - `traffic-its-research.md`

## Quality Assurance

### Documentation Standards
- All documents must include YAML frontmatter with title, author, date, version, status
- Cross-references must use relative paths within the traffic signals directory
- External references must use full paths to other discipline directories

### Review Requirements
- All traffic signal-specific documentation must be reviewed by subject matter experts from relevant disciplines
- Cross-discipline interfaces must be validated by all affected disciplines
- Implementation documents must align with the workflows catalog

## Maintenance

### Version Control
- Major updates to placement standards require version increment
- Changes must be documented in the version history
- Breaking changes require migration plans

### Updates
- Annual review of placement standards
- Updates required when new disciplines are added to traffic signal projects
- Continuous improvement based on project execution feedback

---

**Document Version**: 1.0
**Last Updated**: 2026-04-20
**Next Review**: 2027-04-20
**Contact**: Traffic Signals Project Team
