---
id: CIVIL-001
title: Stormwater Management Workflow Template
phase: Phase 1 — Foundation
status: backlog
priority: high
assigneeAgentId: interface-devforge
parent: CIVIL-WORKFLOW
project: CIVIL-WORKFLOW
derivedFrom: UNIV-050
---

# CIVIL-001: Stormwater Management Workflow Template

## Description

Create a universal stormwater management workflow template that standardizes the drainage design process across civil engineering projects.

**Context**: Stormwater management is critical for site development, environmental compliance, and flood prevention. This template addresses runoff calculations, detention/retention systems, and regulatory compliance.

**Objectives**:
- Create standardized stormwater calculation workflows
- Design detention/retention basin sizing templates
- Build storm sewer design automation
- Integrate with environmental compliance requirements
- Ensure 80-95% cross-discipline reusability

**Scope**:
- In Scope: Stormwater calculations, detention design, inlet/spacing design, stormwater quality
- Out of Scope: Detailed structural calculations, pump station design, receiving water analysis

## Acceptance Criteria

- [ ] Stormwater calculation workflow with runoff methods (Rational, SCS, Unit Hydrograph)
- [ ] Detention basin sizing template with outlet structure design
- [ ] Storm sewer network design workflow
- [ ] Stormwater quality BMP integration templates
- [ ] Floodplain/coastal storm surge considerations
- [ ] Integration with SWPPP requirements
- [ ] Post-development runoff comparison tools

## Assigned Company & Agent

- **Primary**: DevForge AI — interface-devforge
- **Supporting**: InfraForge AI — database-infraforge, DomainForge AI — Zara
- **Integration Support**: IntegrateForge AI — SWMM, HEC-RAS, Civil 3D, OpenCV Measurement connectors available

## Working Directory

`docs-paperclip/disciplines/00850-civil-engineering/workflows/stormwater/`

## Communication Framework

**Active Interfaces (CIVIL-WORKFLOW Project):**
- Civil ↔ Electrical: Utility coordination, stormwater integration
- Civil ↔ Mechanical: Equipment foundation requirements
- Civil ↔ Process: Tank foundation specifications
- BIM Coordination: Daily model updates, clash detection

**Communication Requirements:**
- Update BIM models daily by 5 PM
- Notify affected disciplines of design changes within 48 hours
- Participate in bi-weekly coordination meetings
- Escalate interface conflicts to BIM coordinator within 24 hours

## Required Skills

- Civil Engineering Design
- Hydrology and Hydraulics
- AutoCAD/ Civil 3D
- Environmental Compliance

## Dependencies

- BLOCKED BY: None (foundation workflow)
- RELATED TO: DESIGN-005 (Civil Engineering Integration Requirements)
- BLOCKS: CIVIL-002 (Road Design), CIVIL-004 (Utilities Infrastructure)

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 16-20 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### Stormwater Calculation Methods

1. **Rational Method** (Q = CiA)
   - Small watersheds (<200 acres)
   - Peak flow estimation
   - Time of concentration calculation
   - Used for: inlet spacing, pipe sizing, small catchments

2. **SCS Curve Number Method**
   - Larger watersheds (>200 acres)
   - Runoff volume estimation
   - lag time calculation
   - Used for: detention sizing, flood studies, watershed modeling

3. **Unit Hydrograph Method**
   - Complex watershed response
   - Channel routing capabilities
   - Used for: large projects, floodplain studies, EPA permit modeling

### Detention Basin Components

- forebay/energy dissipator: Pre-treatment cell, 10-15% of total volume
- primary detention cell: Main storage, designed for control volume
- emergency spillway: Safe passage of 100-year+ storms
- outlet structure (orifice/weir): Controlled release rate design
- maintenance access: 12-15ft wide gravel access road
- sediment forebay: 0.1-0.2 ac-ft per acre drained

### BMP Categories

- **Volume-based**: retention ponds (permanent pool), wetlands, infiltration trenches/basins
- **Rate-based**: detention ponds (no permanent pool), berms, weirs
- **Filtration**: bioretention (rain gardens), sand filters, permeable pavements
- **Treatment**: hydrodynamic separators (Vortechs, CDS), constructed wetlands

### Design Storm Events

| Return Period | Application |
|--------------|-------------|
| 1-year | Minor drainage, channel protection |
| 2-year | Minor culverts, local drainage |
| 5-year | Major drainage system |
| 10-year | Detention design minimum |
| 25-year | Regional detention |
| 100-year | Floodplain, emergency spillway |

### Key Standards

- **EPA** NPDES Phase II, SWPPP requirements
- **State/Local** stormwater ordinances
- **AASHTO** drainage guidelines
- **SCS** National Engineering Handbook
- **NRCS** runoff curve numbers by soil/hydrologic group

## Paperclip Task Schema

```yaml
task_schema:
  title: Stormwater Management Workflow Template
  phase: Phase 1 — Foundation
  priority: high
  skills:
    - civil-engineering
    - hydrology
    - environmental-compliance
```

## Success Validation

1. **Template Completeness**: All workflow sections populated
2. **Calculation Accuracy**: Spot-check against hand calculations
3. **Code Compliance**: Meets local stormwater ordinances
4. **Integration Testing**: Works with CAD and GIS platforms
5. **User Acceptance**: Reviewed by civil engineering team

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-050 (Migrated to CIVIL-WORKFLOW)