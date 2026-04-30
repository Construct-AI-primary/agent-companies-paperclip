---
id: MECH-001
title: HVAC System Design Workflow Template
phase: Phase 1 — System Design & Analysis
status: backlog
priority: critical
assignee: mechanical-domainforge
company: domainforge-ai
created_date: 2026-04-17
due_date: 2026-05-17
estimated_hours: 18
parent: MECH-WORKFLOW
project: MECH-WORKFLOW
derivedFrom: UNIV-006
---

# MECH-001: HVAC System Design Workflow Template

## Description

Create a comprehensive HVAC system design workflow template that standardizes heating, ventilation, and air conditioning system design from load calculations through equipment selection.

**Context**: HVAC systems are critical for occupant comfort and building performance. This template addresses the complete HVAC design process per ASHRAE standards.

**Objectives**:
- Create standardized HVAC load calculation workflows
- Design system selection and optimization templates
- Build equipment sizing and selection procedures
- Integrate with architectural and electrical systems
- Ensure ASHRAE compliance and energy efficiency

**Scope**:
- In Scope: Load calculations, system design, equipment selection, ductwork layout
- Out of Scope: Plumbing systems, electrical distribution, construction

## Acceptance Criteria

- [ ] ASHRAE load calculation procedures
- [ ] HVAC system type selection criteria
- [ ] Equipment sizing and selection templates
- [ ] Ductwork design and layout workflows
- [ ] Energy efficiency optimization
- [ ] Commissioning and testing plans

## Assigned Company & Agent

- **Primary**: DomainForge AI — mechanical-domainforge
- **Supporting**: DevForge AI — interface-devforge
- **Integration Support**: IntegrateForge AI — Mechanical OpenCV Measurement connectors available

## Working Directory

`docs-paperclip/disciplines/00870-mechanical-engineering/workflows/hvac-design/`

## Required Skills

- HVAC System Design
- Load Calculations
- Energy Analysis
- ASHRAE Standards

## Dependencies

- BLOCKED BY: None (Phase 1 independent)
- BLOCKS: MECH-002 (Plumbing Systems), MECH-003 (Fire Protection)

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 16-20 hours
- **Timeline**: 3 weeks

## Technical Notes

### Load Calculation Methods (ASHRAE Fundamentals)

1. **Heat Loss/Gain Components**
   - Transmission: Walls, roofs, floors, windows
   - Infiltration: Air leakage through cracks
   - Ventilation: Required outdoor air
   - Internal loads: People, lights, equipment
   - Solar radiation: Direct and diffuse components

2. **Calculation Procedures**
   - Manual calculations: Detailed component analysis
   - Computer programs: EnergyPlus, HAP, TRACE
   - Rules of thumb: Quick estimates for preliminary design

3. **Design Conditions**
   - Summer: 2.5% design dry-bulb temperature
   - Winter: 99% design dry-bulb temperature
   - Humidity: Design dew-point temperatures
   - Indoor: ASHRAE Standard 55 comfort zones

### HVAC System Types

1. **All-Air Systems**
   - Single-zone constant air volume (CAV)
   - Multi-zone CAV systems
   - Variable air volume (VAV) systems
   - Dual-duct systems

2. **Air-Water Systems**
   - Fan-coil systems
   - Induction systems
   - Radiant panel systems
   - Water-source heat pump systems

3. **All-Water Systems**
   - Two-pipe systems
   - Four-pipe systems
   - Radiant heating/cooling
   - Snow melting systems

### Equipment Selection

1. **Air-Handling Units**
   - Capacity: CFM based on load calculations
   - Efficiency: ASHRAE 90.1 minimum requirements
   - Configuration: Draw-through vs. blow-through
   - Components: Filters, coils, fans, controls

2. **Chillers and Boilers**
   - Capacity: Tons for cooling, MBH for heating
   - Efficiency: COP, IPLV for chillers; AFUE for boilers
   - Type: Centrifugal, screw, scroll chillers
   - Fuel: Natural gas, electric, steam

3. **Terminal Units**
   - VAV boxes: Pressure independent vs. dependent
   - Fan-powered boxes: Series vs. parallel
   - Radiant panels: Ceiling, floor, wall installation
   - Displacement ventilation diffusers

### Ductwork Design (SMACNA Standards)

1. **Sizing Methods**
   - Equal friction: Constant pressure drop per foot
   - Static regain: VAV system optimization
   - Velocity reduction: High velocity systems
   - T-method: Simplified manual calculations

2. **Pressure Classes**
   - Low pressure: 0.5-2 in. wg (office buildings)
   - Medium pressure: 2-6 in. wg (hospitals, labs)
   - High pressure: 6+ in. wg (industrial, clean rooms)

3. **Duct Construction**
   - Materials: Galvanized steel, aluminum, fiberglass
   - Sealing: UL 181 rated sealants
   - Insulation: R-values per climate zone
   - Vibration isolation: Flexible connections

## Paperclip Task Schema

```yaml
task_schema:
  title: HVAC System Design Workflow Template
  phase: Phase 1 — System Design & Analysis
  priority: critical
  skills:
    - hvac-system-design
    - load-calculations
    - energy-analysis
    - ashrae-standards
```

## Success Validation

1. **Load Accuracy**: Within 5% of actual measured loads
2. **Energy Efficiency**: Meets ASHRAE 90.1 requirements
3. **System Performance**: Maintains design conditions
4. **Cost Effectiveness**: Optimal first-cost vs. operating cost

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-006 (Migrated to MECH-WORKFLOW)