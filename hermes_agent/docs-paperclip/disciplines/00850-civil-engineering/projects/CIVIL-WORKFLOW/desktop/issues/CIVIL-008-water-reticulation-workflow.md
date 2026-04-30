---
id: CIVIL-008
title: Water Reticulation and Distribution Workflow Template
phase: Phase 4 — Utility Systems
status: backlog
priority: high
assigneeAgentId: interface-devforge
parent: CIVIL-007
project: CIVIL-WORKFLOW
derivedFrom: UNIV-065
---

# CIVIL-008: Water Reticulation and Distribution Workflow Template

## Description

Create a comprehensive water reticulation workflow template that standardizes urban water distribution network design from demand analysis through operational modeling.

**Context**: Water reticulation systems deliver potable water to end users through interconnected pipe networks. This template addresses the complete design process for urban water distribution systems.

**Objectives**:
- Create standardized water demand analysis workflows
- Design network layout and pressure zone templates
- Build hydraulic modeling templates (EPANET, WaterCAD)
- Integrate with SCADA and telemetry
- Ensure regulatory compliance (EPA, State Health)

**Scope**:
- In Scope: Potable water distribution, pressure zones, storage tanks, pump stations
- Out of Scope: Dam design, water treatment, industrial process water

## Acceptance Criteria

- [ ] Water demand and fire flow analysis workflow
- [ ] Network layout and pipe sizing templates
- [ ] Pressure zone design workflow
- [ ] Storage tank sizing and design templates
- [ ] Pump station design workflow
- [ ] Hydraulic modeling templates (EPANET, WaterCAD)
- [ ] Water quality and disinfectant decay analysis

## Assigned Company & Agent

- **Primary**: DevForge AI — interface-devforge
- **Supporting**: InfraForge AI — database-infraforge, DomainForge AI — Zara
- **Integration Support**: IntegrateForge AI — Civil 3D, GIS, OpenCV Measurement connectors available

## Working Directory

`docs-paperclip/disciplines/00850-civil-engineering/workflows/water-reticulation/`

## Communication Framework

**Active Interfaces (CIVIL-WORKFLOW Project):**
- Civil ↔ Electrical: Pump station power, SCADA systems
- Civil ↔ Mechanical: Pump equipment, valve actuators
- Civil ↔ Process: Water quality monitoring, treatment integration
- BIM Coordination: Daily model updates, clash detection

**Communication Requirements:**
- Update BIM models daily by 5 PM
- Notify affected disciplines of pressure zone changes within 48 hours
- Coordinate electrical requirements for pump stations
- Participate in bi-weekly coordination meetings
- Escalate interface conflicts to BIM coordinator within 24 hours

## Required Skills

- Civil/Environmental Engineering
- Water Resources Engineering
- Hydraulic Modeling (EPANET/WaterCAD)
- GIS and Asset Management

## Dependencies

- BLOCKED BY: CIVIL-007 (Pipeline)
- RELATED TO: DESIGN-005 (Civil Engineering Integration Requirements)
- BLOCKS: CIVIL-009 (Tunnels)

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 14-18 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### Water Demand Analysis

1. **Demand Categories**
   - Residential: 80-120 gpcd (gallons per capita per day), varies by region
   - Commercial: 0.1-0.5 gpm per 1000 sqft, based on type
   - Industrial: Per process requirements, meter-based
   - Institutional: Schools (15-25 gpcpd), hospitals (250-400 gpd/bed)
   - Public: Parks (0.1 ac-ft/acre/year), fire fighting

2. **Design Periods**
   - Average day: Annual average, for reservoir sizing
   - Maximum day: 1.2-1.8x average, for treatment and supply
   - Peak hour: 1.5-3.0x average, for pipe sizing and network
   - Fire flow: ISO/NFPA requirements, 500-4000 gpm

3. **Fire Flow Requirements**
   - Minimum: 500 gpm for 2 hours (residential)
   - Commercial: 1500-3000 gpm for 2-3 hours
   - Industrial: Based on hazard classification
   - Residual pressure: 20 psi minimum during fire flow

### Network Design

1. **Pipe Sizing**
   - Velocity limits: 2-5 fps normal, up to 8 fps for fire flow
   - Head loss: 3-5 ft per 1000 ft typical
   - Minimum diameter: 6in for dead ends, 8in for grid mains
   - Material selection: DIP (urban), PVC (suburban), HDPE (trenchless)

2. **Network Layout**
   - Grid/looped networks: Higher reliability, lower velocities
   - Branched networks: Lower cost, lower reliability
   - Critical links: Loops to key customers, hospitals, fire hydrants
   - Valving: Sectionalizing for maintenance, isolation

3. **Pressure Management**
   - Maximum pressure: 80-100 psi (avoid customer complaints)
   - Minimum pressure: 35-40 psi at furthest point under peak demand
   - Pressure reducing valves: Zone boundary, individual customers
   - Altitude valves: Storage tanks on hills, prevent overflow

### Storage Requirements

1. **Tank Types**
   - Ground storage: Welded steel, concrete, earth embankment
   - Elevated tanks: Standpipe, composite, spheroid
   - Standpipes: Tall and narrow, for height without volume
   - Composite tanks: Steel tank on concrete pedestal

2. **Sizing Criteria**
   - Equalization: 25-33% of average day demand
   - Fire storage: ISO requirement, 500 gpm for 2-4 hours
   - Emergency: 12-24 hours of average day for system failures
   - Operational: 10-15% additional for operational flexibility

### Pump Station Design

1. **Pump Selection**
   - Capacity: Design flow + firm capacity (N-1)
   - Head: Static head + friction losses + residual pressure
   - Pump curves: Best efficiency point at design flow
   - Variable frequency drives: Energy savings, pressure control

2. **System Configuration**
   - Firm capacity: All pumps except largest can meet demand
   - Parallel pumping: Multiple pumps for flexibility
   - Prime and standby: 1 standby for <4 pumps, 2 for ≥4
   - Control strategies: Fixed speed, setpoint, demand-based

## Paperclip Task Schema

```yaml
task_schema:
  title: Water Reticulation and Distribution Workflow Template
  phase: Phase 4 — Utility Systems
  priority: high
  skills:
    - civil-engineering
    - water-resources
    - hydraulic-modeling
    - environmental
```

## Success Validation

1. **Hydraulic Adequacy**: Pressure and flow at all points
2. **Fire Protection**: Adequate fire flow available
3. **Water Quality**: Age and disinfectant residuals adequate
4. **Regulatory**: EPA and health department approval

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-065 (Migrated to CIVIL-WORKFLOW)