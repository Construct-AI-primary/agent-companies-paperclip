---
id: CIVIL-004
title: Utilities Infrastructure Workflow Template
phase: Phase 2 — Core Structures
status: backlog
priority: medium
assigneeAgentId: interface-devforge
parent: CIVIL-001
project: CIVIL-WORKFLOW
derivedFrom: UNIV-053
---

# CIVIL-004: Utilities Infrastructure Workflow Template

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
- **Supporting**: InfraForge AI — database-infraforge, DomainForge AI — Zara
- **Integration Support**: IntegrateForge AI — Civil 3D, GIS, OpenCV Measurement connectors available

## Working Directory

`docs-paperclip/disciplines/00850-civil-engineering/workflows/utilities/`

## Communication Framework

**Active Interfaces (CIVIL-WORKFLOW Project):**
- Civil ↔ Electrical: Utility coordination, service connections
- Civil ↔ Mechanical: Utility routing, equipment access
- Civil ↔ Process: Process utility requirements
- BIM Coordination: Daily model updates, clash detection

**Communication Requirements:**
- Update BIM models daily by 5 PM
- Notify affected disciplines of utility conflicts within 48 hours
- Coordinate utility crossings with electrical discipline
- Participate in bi-weekly coordination meetings
- Escalate interface conflicts to BIM coordinator within 24 hours

## Required Skills

- Civil Engineering Design
- Utility Engineering
- GIS and Asset Management
- AutoCAD/ Civil 3D

## Dependencies

- BLOCKED BY: CIVIL-001 (Stormwater Management)
- RELATED TO: DESIGN-005 (Civil Engineering Integration Requirements)
- BLOCKS: None (Phase 2 completion)

## Estimated Effort

- **Complexity**: Medium-High
- **Estimated Hours**: 14-18 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### Water Distribution Components

1. **Transmission Mains**
   - Large diameter pipes: 16-60 inch diameter
   - Pressure classes: Based on working + surge pressure
   - Materials: DIP (Class 350/350H), PCCP, HDPE (DR11-17)
   - Valve and fitting layout: Air release valves at high points, blow-off valves at low points
   - Thrust blocking design: Based on pipe pressure, fitting type, soil bearing

2. **Distribution Mains**
   - Standard diameters: 6-12 inch common
   - Fire flow requirements: 1000-2500 gpm based on ISO classification
   - Valve spacing: 500-800ft in commercial/industrial, 800-1000ft residential
   - Hydrant placement: Within 500ft of any structure, 1000ft spacing

3. **Service Connections**
   - Meter sizing: 5/8-2 inch for residential, compound or turbine for commercial
   - Backflow prevention: RPZ or DCVA based on hazard classification
   - Corporation stop: 3/4-2 inch copper or brass
   - Curb stop: In meter box, with tracer wire

### Sanitary Sewer Components

1. **Collection Mains**
   - Gravity flow design: Design full flow at 0.4-0.6 depth ratio
   - Minimum slopes: 0.4% for 8in, 0.25% for 10in, 0.22% for 12in, 0.15% for 15in+
   - Minimum velocity: 2.0 fps at full flow, 3.0 fps preferred
   - Manhole design: Inside diameter 48-60in, drop inlets for >2ft difference
   - Cleanout placement: At end of lines, at 90° bends, at property line

2. **Laterals**
   - Service connection wyes: Factory wye at 45-60° angle
   - Cleanout requirements: At property line, 2ft from building foundation
   - Inverted siphons: Only when gravity routing impossible, 2-barrel minimum

3. **Special Structures**
   - Manholes (drop): When inlet >24in above outlet
   - Manholes (shallow): <5ft depth to invert
   - Manholes (deep): >15ft depth, safety provisions required
   - Lift station connections: Force main discharge, emergency storage

### Utility Coordination Elements

1. **SUE (Subsurface Utility Engineering) Levels**
   - Level A (Designating): 1in variance, vacuum excavation, test holes
   - Level B (Locating): GIS/mapping accuracy, 1ft variance, survey-based
   - Level C (Visible): Surface utilities visible, limited accuracy
   - Level D (Records): Existing records only, unknown accuracy

2. **Utility Conflict Matrix**
   - Horizontal separation: 18in minimum between utilities, 10ft preferred
   - Vertical separation: 18in minimum, crossing utilities should approach at 90°
   - Cover requirements: Based on traffic loads, frost depth, utility type
   - Adjustment priorities: Lower priority utility moves for higher

### Design Standards

- **AWWA** C100 (DI), C900/C905 (PVC), M11 (Steel Pipe)
- **Unified Plumbing Code** / IPC
- **State Health Department** standards
- **EPA** 40 CFR Part 136 (wastewater sampling)
- **Local utility** standards and standard drawings

## Paperclip Task Schema

```yaml
task_schema:
  title: Utilities Infrastructure Workflow Template
  phase: Phase 2 — Core Structures
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
**Derived From**: UNIV-053 (Migrated to CIVIL-WORKFLOW)