---
id: DESIGN-003
title: Design Programme and Deliverables Management Workflow Template
phase: Phase 2 — Core
status: backlog
priority: high
assigneeAgentId: design-coordinator
parent: DESIGN-WORKFLOW
project: DESIGN-WORKFLOW
derivedFrom: UNIV-001
---

# DESIGN-003: Design Programme and Deliverables Management Workflow Template

## Description

Create a standardized design programme and deliverables management workflow template for tracking design deliverables across all disciplines from concept through IFC.

**Context**: Design programme management ensures that all design deliverables are produced in the correct sequence, on schedule, and to the required quality standards. It links directly to procurement and construction schedules.

**Objectives**:
- Create design deliverable tracking and milestone management templates
- Design document register and transmittal workflows
- Build design schedule integration with project controls
- Ensure 80-95% cross-discipline reusability

**Scope**:
- In Scope: Design schedule, deliverable register, transmittals, milestone tracking
- Out of Scope: Construction scheduling, procurement tracking, cost management

## Acceptance Criteria

- [ ] Design deliverable register template with discipline breakdown
- [ ] Design schedule template integrated with P6/MSP
- [ ] Document transmittal and revision tracking workflow
- [ ] Design milestone and hold point definitions
- [ ] Deliverable completion and approval tracking
- [ ] Design progress measurement and reporting templates
- [ ] Integration with document management systems (Aconex, ProjectWise)

## Assigned Company & Agent

- **Primary**: DesignForge AI — design-coordinator
- **Supporting**: ProjectForge AI — project-controls

## Working Directory

`docs-paperclip/disciplines/00800-design/workflows/design-programme/`

## Required Skills

- Design Management
- Project Scheduling
- Document Control
- Progress Measurement

## Dependencies

- BLOCKED BY: DESIGN-001 (Design Coordination)
- BLOCKS: DESIGN-007 (Construction Support)

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 14-18 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### Design Deliverable Categories

| Category | Examples | Typical Review Cycle |
|----------|----------|---------------------|
| Calculations | Structural, hydraulic, electrical | Internal + IDR |
| Drawings | General arrangements, details, isometrics | IFR → IFA → IFC |
| Specifications | Technical specifications, data sheets | Internal + Client |
| Reports | Design reports, geotechnical reports | Internal + Client |
| 3D Models | BIM models, coordination models | IDR + Clash detection |
| Schedules | Equipment lists, line lists, I/O lists | Internal + Procurement |

### Progress Measurement Methods

- **0/100**: Not started / Complete
- **50/50**: 50% on start, 50% on completion
- **Weighted milestones**: Percentage at defined milestones
- **Earned value**: Physical progress measurement against baseline

### Key Standards

- **PMBOK** — Schedule management
- **AACE RP 25R-03** — Estimating lost labor productivity
- **ISO 19650** — Information management

## Paperclip Task Schema

```yaml
task_schema:
  title: Design Programme and Deliverables Management Workflow Template
  phase: Phase 2 — Core
  priority: high
  skills:
    - design-management
    - project-scheduling
    - document-control
```

## Success Validation

1. **Template Completeness**: All deliverable tracking sections populated
2. **Schedule Integration**: Links with P6/MSP validated
3. **Progress Measurement**: Consistent with EVM methodology
4. **User Acceptance**: Reviewed by design and project controls teams

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-001 (Migrated to DESIGN-WORKFLOW)
