---
id: DESIGN-002
title: Interdisciplinary Design Review (IDR) Workflow Template
phase: Phase 1 — Foundation
status: backlog
priority: critical
assigneeAgentId: design-coordinator
parent: DESIGN-WORKFLOW
project: DESIGN-WORKFLOW
derivedFrom: UNIV-003
---

# DESIGN-002: Interdisciplinary Design Review (IDR) Workflow Template

## Description

Create a standardized IDR workflow template that defines the cross-discipline design review process, ensuring coordinated and clash-free design deliverables.

**Context**: IDR is the primary quality gate for multi-discipline coordination. Without structured review, design inconsistencies and interface errors go undetected until construction, when correction costs are orders of magnitude higher.

**Objectives**:
- Create standardized IDR process with defined review stages
- Design review checklist templates for each discipline interface
- Build comment and response tracking workflows
- Integrate with BIM coordination and clash detection
- Ensure 80-95% cross-discipline reusability

**Scope**:
- In Scope: IDR process, review checklists, comment tracking, approval gates
- Out of Scope: Internal discipline design checks, construction quality inspections

## Acceptance Criteria

- [ ] IDR process flow with defined review stages (IFR, IFA, IFC)
- [ ] Discipline-specific review checklist templates
- [ ] Comment categorization and response tracking system
- [ ] Design review meeting agenda and minutes templates
- [ ] Approval gate definitions with sign-off requirements
- [ ] Integration with document management systems
- [ ] Design maturity assessment criteria

## Assigned Company & Agent

- **Primary**: DesignForge AI — design-coordinator
- **Supporting**: InfraForge AI — database-infraforge

## Working Directory

`docs-paperclip/disciplines/00800-design/workflows/interdisciplinary-review/`

## Required Skills

- Design Management
- Interdisciplinary Coordination
- Quality Assurance
- BIM Review

## Dependencies

- BLOCKED BY: DESIGN-001 (Design Coordination)
- BLOCKS: DESIGN-005 (BIM Coordination), DESIGN-006 (Design QA)

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 14-18 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### Review Stages

| Stage | Code | Purpose | Reviewers |
|-------|------|---------|-----------|
| Issued for Review | IFR | Internal and cross-discipline review | All affected disciplines |
| Issued for Approval | IFA | Client and regulatory approval | Client, regulators, design manager |
| Issued for Construction | IFC | Final approved for construction use | Design manager sign-off |

### Comment Categories

- **A**: Critical — Must be resolved before proceeding
- **B**: Major — Should be resolved; may proceed with noted deviation
- **C**: Minor — Editorial or preference comments
- **Info**: Informational — No response required

### Key Standards

- **ISO 19650-2** — Delivery phase information management
- **PAS 1192-2** — BIM delivery phase
- **Client review procedures** — Project-specific requirements

## Paperclip Task Schema

```yaml
task_schema:
  title: Interdisciplinary Design Review Workflow Template
  phase: Phase 1 — Foundation
  priority: critical
  skills:
    - design-management
    - quality-assurance
    - review-coordination
```

## Success Validation

1. **Template Completeness**: All review stages and checklists populated
2. **Comment Tracking**: Full traceability from comment to resolution
3. **Integration Testing**: Works with Bluebeam, BIM 360
4. **User Acceptance**: Reviewed by design management team

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-003 (Migrated to DESIGN-WORKFLOW)
