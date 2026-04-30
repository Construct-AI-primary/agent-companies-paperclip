---
id: UNIV-050
title: Stormwater Management Workflow Template
phase: Phase 6 — Civil/Hydraulic Engineering
status: backlog
priority: high
assigneeAgentId: interface-devforge
parent: UNIV-003
project: UNIV-WORKFLOW
---

# UNIV-050: Stormwater Management Workflow Template

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
- **Supporting**: InfraForge AI — database-infraforge

## Working Directory

`docs-paperclip/disciplines/00850-civil-engineering/workflows/stormwater/`

## Required Skills

- Civil Engineering Design
- Hydrology and Hydraulics
- AutoCAD/ Civil 3D
- Environmental Compliance

## Dependencies

- BLOCKED BY: UNIV-003 (Discipline Mapping)
- BLOCKS: UNIV-051 (Road Design), UNIV-053 (Utilities Infrastructure)

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

2. **SCS Curve Number Method**
   - Larger watersheds
   - Runoff volume estimation
   - lag time calculation

3. **Unit Hydrograph Method**
   - Complex watershed response
   - Channel routing capabilities

### Detention Basin Components

- forebay/energy dissipator
- primary detention cell
- emergency spillway
- outlet structure (orifice/weir)
- maintenance access

### BMP Categories

- **Volume-based**: retention ponds, wetlands, infiltration
- **Rate-based**: detention ponds, berms
- **Filtration**: bioretention, sand filters
- **Treatment**: hydrodynamic separators, constructed wetlands

## Paperclip Task Schema

```yaml
task_schema:
  title: Stormwater Management Workflow Template
  phase: Phase 6 — Civil/Hydraulic Engineering
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
