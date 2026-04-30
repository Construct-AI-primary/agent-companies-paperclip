---
id: CIVIL-007
title: Pipeline Design and Construction Workflow Template
phase: Phase 4 — Utility Systems
status: backlog
priority: high
assigneeAgentId: interface-devforge
parent: CIVIL-004
project: CIVIL-WORKFLOW
derivedFrom: UNIV-064
---

# CIVIL-007: Pipeline Design and Construction Workflow Template

## Description

Create a comprehensive pipeline design workflow template that standardizes water, sewer, and process pipeline design from route selection through construction and hydrostatic testing.

**Context**: Pipeline systems transport water, wastewater, and process fluids across municipalities and industrial facilities. This template addresses the complete design process for various pipeline types and materials.

**Objectives**:
- Create standardized pipeline design workflows
- Design pipe material selection templates
- Build hydraulic analysis templates
- Integrate with civil infrastructure
- Ensure AWWA and industry compliance

**Scope**:
- In Scope: Water transmission mains, force mains, process pipelines, pump stations
- Out of Scope: Oil/gas pipelines, large diameter transmission (>60 inch), offshore pipelines

## Acceptance Criteria

- [ ] Pipeline route selection workflow
- [ ] Pipe material selection templates (DI, PVC, HDPE, Steel)
- [ ] Hydraulic analysis workflow (Hazen-Williams, Darcy-Weisbach)
- [ ] Thrust block and anchor design templates
- [ ] Pipe cover and bedding design workflow
- [ ] Hydrostatic testing templates
- [ ] Cathodic protection design

## Assigned Company & Agent

- **Primary**: DevForge AI — interface-devforge
- **Supporting**: InfraForge AI — database-infraforge, DomainForge AI — Zara
- **Integration Support**: IntegrateForge AI — Civil 3D, GIS, OpenCV Measurement connectors available

## Working Directory

`docs-paperclip/disciplines/00850-civil-engineering/workflows/pipelines/`

## Communication Framework

**Active Interfaces (CIVIL-WORKFLOW Project):**
- Civil ↔ Electrical: Cathodic protection, electrical tracing
- Civil ↔ Mechanical: Pump station foundations, valve access
- Civil ↔ Process: Process piping coordination, material compatibility
- BIM Coordination: Daily model updates, clash detection

**Communication Requirements:**
- Update BIM models daily by 5 PM
- Notify affected disciplines of pipeline routing within 48 hours
- Coordinate electrical requirements for cathodic protection
- Participate in bi-weekly coordination meetings
- Escalate interface conflicts to BIM coordinator within 24 hours

## Required Skills

- Civil Engineering
- Pipeline Engineering
- Hydraulic Analysis
- AutoCAD/ Civil 3D

## Dependencies

- BLOCKED BY: CIVIL-004 (Utilities)
- RELATED TO: DESIGN-005 (Civil Engineering Integration Requirements)
- BLOCKS: CIVIL-008 (Water Reticulation)

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 12-16 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### Pipe Materials

1. **Ductile Iron (DI)**
   - Push-on joints: Bell and spigot, Tyton or similar
   - Mechanical joints: MJ glands, bolt-type
   - Flanged joints: For above-ground or appurtenances
   - Linings: Cement mortar (AWWA C104), fusion bonded epoxy (FBE)
   - Pressure classes: Class 150, 200, 250, 300, 350, 350H
   - Typical sizes: 3-64 inch diameter

2. **PVC/HDPE**
   - gasketed joints: Integral bell, elastomeric gasket
   - Fusion (HDPE): Butt fusion, electrofusion for joints
   - Pressure classes: DR11 to DR32 based on pressure rating
   - PVC standards: AWWA C900 (4-12in), C905 (14-48in)
   - HDPE standards: AWWA C906, ASTM F714
   - Typical sizes: PVC 4-48in, HDPE 1-63in

3. **Steel**
   - Welded joints: Butt weld, spiral weld, ERW
   - External coating: 3LPE (3-layer PE), FBE, coal tar enamel
   - Internal lining: Cement mortar, epoxy, polyurethane
   - High pressure: API 5L grades B-X80
   - Typical sizes: 4-144 inch diameter

### Design Criteria

1. **Cover Requirements**
   - Minimum cover: 3ft residential, 4ft commercial/industrial
   - Traffic loads: AASHTO HL-93 for highway crossing, H-20 for lighter
   - Frost depth: Varies by location, design to below frost line
   - Utility separation: 18in minimum horizontal, 12in vertical

2. **Bedding Classes**
   - Class A: Crushed rock, well-graded, 90° embedment angle
   - Class B: Granular material, native with shaping, 30° embedment angle
   - Class C: Native soil, hand shaping, minimal compaction
   - Class D: Unsuitable material, imported granular required
   - Load factors: Table in AWWA C150 for various conditions

3. **Thrust Restraint**
   - Thrust blocks: Concrete, sized for soil bearing and pipe pressure
   - Restrained joints: Megalug, grip ring, or factory restrained
   - Tie rods: Through-bolts for tees and bends, with backing plates
   - Reaction saddles: For tees and tapping sleeves on rock

### Hydraulic Analysis

1. **Hazen-Williams Formula**
   - Q = 0.442 × C × D^2.63 × S^0.54
   - C = Hazen-Williams roughness coefficient
   - D = Inside diameter (ft)
   - S = Head loss/foot
   - Valid for: Water at 60°F, turbulent flow in smooth pipes

2. **Darcy-Weisbach Formula**
   - hf = f × (L/D) × (V²/2g)
   - f = friction factor (Moody diagram, Colebrook equation)
   - L = Pipe length
   - V = Velocity
   - g = 32.2 ft/s²
   - More general: Applicable to all fluids and conditions

3. **Surge Analysis**
   - Steady state: Normal operating conditions
   - Transient: Water hammer, valve closure, pump trips
   - Design: Air chambers, surge tanks, slow-closing valves
   - Allowable: Check for pipe burst, joint separation

## Paperclip Task Schema

```yaml
task_schema:
  title: Pipeline Design and Construction Workflow Template
  phase: Phase 4 — Utility Systems
  priority: high
  skills:
    - civil-engineering
    - pipeline-engineering
    - hydraulic-analysis
```

## Success Validation

1. **Hydraulic Adequacy**: Flow and pressure requirements met
2. **Structural Adequacy**: Pipe and bedding properly designed
3. **Code Compliance**: AWWA requirements satisfied
4. **Testing**: Hydrostatic test passed (per AWWA C600)

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-064 (Migrated to CIVIL-WORKFLOW)