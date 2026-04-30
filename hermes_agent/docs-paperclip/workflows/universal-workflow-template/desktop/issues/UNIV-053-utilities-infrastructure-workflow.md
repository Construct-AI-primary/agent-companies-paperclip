---
id: UNIV-053
title: Utilities Infrastructure Workflow Template
phase: Phase 6 — Civil/Hydraulic Engineering
status: backlog
priority: medium
assigneeAgentId: interface-devforge
parent: UNIV-050
project: UNIV-WORKFLOW
---

# UNIV-053: Utilities Infrastructure Workflow Template

## Description

Create a comprehensive utilities infrastructure workflow template that standardizes water, sewer, and utility coordination design from planning through construction documentation.

**Context**: Utilities infrastructure requires coordination of multiple utility types, existing infrastructure, and regulatory requirements. This template addresses the complete design process for common utility systems.

**Objectives**:
- Create standardized water distribution design workflows
- Design sanitary sewer and stormwater collection templates
- Build utility coordination and conflict resolution workflows
- Integrate with GIS and asset management systems
- Ensure regulatory compliance (EPA, state health department)

**Scope**:
- In Scope: Water distribution, sanitary sewer, stormwater collection, utility coordination
- Out of Scope: Treatment plant design, lift stations, industrial systems

## Acceptance Criteria

- [ ] Water distribution design workflow (transmission/distribution mains)
- [ ] Sanitary sewer collection system template
- [ ] Service connection design templates
- [ ] Utility conflict identification and resolution workflow
- [ ] Pressure zone and flow analysis templates
- [ ] Easement and right-of-way determination
- [ ] GIS integration and asset data templates

## Assigned Company & Agent

- **Primary**: DevForge AI — interface-devforge
- **Supporting**: InfraForge AI — database-infraforge

## Working Directory

`docs-paperclip/disciplines/00850-civil-engineering/workflows/utilities/`

## Required Skills

- Civil Engineering Design
- Utility Engineering
- GIS and Asset Management
- AutoCAD/ Civil 3D

## Dependencies

- BLOCKED BY: UNIV-050 (Stormwater Management)
- BLOCKS: UNIV-050 (Phase 6 completion)

## Estimated Effort

- **Complexity**: Medium-High
- **Estimated Hours**: 14-18 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### Water Distribution Components

1. **Transmission Mains**
   - Large diameter pipes (>12")
   - Pressure classes and materials
   - Valve and fitting layout
   - Thrust blocking design

2. **Distribution Mains**
   - Standard diameters (6"-12")
   - Fire flow requirements
   - Valve spacing and placement
   - Hydrant placement

3. **Service Connections**
   - Meter sizing
   - Backflow prevention
   - Corporation stop and curb stop

### Sanitary Sewer Components

1. **Collection Mains**
   - Gravity flow design
   - Minimum slopes and velocities
   - Manhole design and spacing
   - Cleanout placement

2. **Laterals**
   - Service connection wyes
   - Cleanout requirements
   - Inverted siphons (if needed)

3. **Special Structures**
   - Manholes (drop, shallow, deep)
   - Lift station connections
   - Force main connections

### Utility Coordination Elements

- SUE (Subsurface Utility Engineering) levels
- Utility conflict matrix
- Adjustment priorities
- Coordination schedules

### Design Standards

- **AWWA** (American Water Works Association)
- **Unified Plumbing Code**
- **State Health Department** standards
- **EPA** regulations
- **Local utility standards**

## Paperclip Task Schema

```yaml
task_schema:
  title: Utilities Infrastructure Workflow Template
  phase: Phase 6 — Civil/Hydraulic Engineering
  priority: medium
  skills:
    - civil-engineering
    - utility-engineering
    - gis
    - environmental
```

## Success Validation

1. **Hydraulic Adequacy**: Meets demand and capacity requirements
2. **Regulatory Compliance**: Meets health/EPA standards
3. **Constructability**: Practical construction methods
4. **GIS Integration**: Smooth data transfer
5. **Coordination**: All conflicts resolved

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
