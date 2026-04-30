---
id: DESIGN-001
title: Design Coordination and Interface Management Workflow Template
phase: Phase 1 — Foundation
status: backlog
priority: critical
assigneeAgentId: design-coordinator
parent: DESIGN-WORKFLOW
project: DESIGN-WORKFLOW
derivedFrom: UNIV-003
---

# DESIGN-001: Design Coordination and Interface Management Workflow Template

## Description

Create a universal design coordination workflow template that standardizes the interface management process across all engineering disciplines on large projects.

**Context**: Design coordination is the backbone of successful multi-discipline project delivery. Without structured interface management, design gaps and clashes propagate into construction, causing rework, delays, and cost overruns.

**Objectives**:
- Create standardized design coordination workflow with interface register
- Design interdisciplinary meeting and action tracking templates
- Build interface matrix definition and management tools
- Integrate with BIM coordination workflows
- Ensure 80-95% cross-discipline reusability

**Scope**:
- In Scope: Interface register, coordination meeting templates, action tracking, design deliverable matrix
- Out of Scope: Discipline-specific design calculations, procurement coordination, construction supervision

## Acceptance Criteria

- [ ] Design interface register template with discipline interface points
- [ ] Coordination meeting agenda, minutes, and action tracking templates
- [ ] Design deliverable matrix (who produces what, when, for whom)
- [ ] Interface responsibility matrix (RACI for each interface point)
- [ ] Design coordination schedule integration with P6/MSP
- [ ] Issue escalation and resolution workflow
- [ ] Digital collaboration platform integration (BIM 360, Aconex)

## Assigned Company & Agent

- **Primary**: DesignForge AI — design-coordinator
- **Supporting**: InfraForge AI — database-infraforge

## Working Directory

`docs-paperclip/disciplines/00800-design/workflows/coordination/`

## Required Skills

- Design Management
- Multi-discipline Coordination
- BIM Management
- Project Scheduling

## Dependencies

- BLOCKED BY: None (foundation workflow)
- BLOCKS: DESIGN-002 (IDR), DESIGN-003 (Design Programme), DESIGN-005 (BIM Coordination)

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 16-20 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### Interface Categories

1. **Physical Interfaces**: Spatial clashes between discipline elements (structural vs. MEP, civil vs. piping)
2. **Data Interfaces**: Information flow between disciplines (loads, sizes, levels, coordinates)
3. **Sequential Interfaces**: Dependency relationships (foundation design before superstructure, process before piping)
4. **Regulatory Interfaces**: Code compliance that spans multiple disciplines

### Coordination Meeting Structure

| Meeting | Frequency | Attendees | Purpose |
|---------|-----------|-----------|---------|
| Design Kick-off | Once | All discipline leads | Establish coordination framework |
| Weekly Coordination | Weekly | Discipline leads + design manager | Track progress, resolve interfaces |
| IDR Sessions | Bi-weekly | Affected disciplines | Cross-discipline design review |
| Design Freeze | Milestone | All disciplines + client | Confirm design readiness for IFC |

### Key Standards

- **ISO 19650** — Information management using BIM
- **PAS 1192-2** — Capital/delivery phase
- **AIA E202** — BIM protocol exhibit
- **Client-specific** DEP and BEP requirements

## Paperclip Task Schema

```yaml
task_schema:
  title: Design Coordination and Interface Management Workflow Template
  phase: Phase 1 — Foundation
  priority: critical
  skills:
    - design-management
    - coordination
    - bim-management
```

## Success Validation

1. **Template Completeness**: All workflow sections populated
2. **Interface Coverage**: All discipline interfaces identified and assigned
3. **Integration Testing**: Works with BIM 360 and Aconex platforms
4. **User Acceptance**: Reviewed by design management team

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-003 (Migrated to DESIGN-WORKFLOW)
