---
id: ELEC-005
title: Substation Design and Equipment Workflow Template
phase: Phase 3 — Substations and Infrastructure
status: backlog
priority: high
assigneeAgentId: interface-devforge
parent: ELEC-003
project: ELEC-WORKFLOW
derivedFrom: UNIV-060
---

# ELEC-005: Substation Design and Equipment Workflow Template

## Description

Create a comprehensive substation design workflow template that standardizes distribution and transmission substation design from site selection through commissioning.

**Context**: Substations are critical nodes in the electrical grid, transforming voltage levels and providing switching/protection functions. This template addresses the complete design process for various substation types and sizes.

**Objectives**:
- Create standardized substation design workflows
- Design major equipment selection templates
- Build protection and control system templates
- Integrate with SCADA and communication systems
- Ensure IEEE and utility compliance

**Scope**:
- In Scope: Distribution substations, transmission substations, switching stations, pad-mounted equipment
- Out of Scope: Major utility-scale substations, HVDC converter stations

## Acceptance Criteria

- [ ] Substation site selection and layout workflow
- [ ] Transformer selection and sizing templates
- [ ] Switchgear and circuit breaker templates
- [ ] Bus work and conductor design workflow
- [ ] Protection and control system templates
- [ ] SCADA and communication integration
- [ ] Grounding and lightning protection design

## Assigned Company & Agent

- **Primary**: DevForge AI — interface-devforge
- **Supporting**: InfraForge AI — database-infraforge
- **Integration Support**: IntegrateForge AI — Electrical OpenCV Measurement connectors available

## Working Directory

`docs-paperclip/disciplines/00860-electrical-engineering/workflows/substations/`

## Required Skills

- Electrical Engineering (Substation specialization)
- Power Systems Analysis
- Protection and Control
- Substation Design Software

## Dependencies

- BLOCKED BY: ELEC-003 (Transmission)
- BLOCKS: ELEC-007 (Maintenance), ELEC-008 (Commissioning)

## Estimated Effort

- **Complexity**: Very High
- **Estimated Hours**: 16-20 hours
- **Timeline**: 3-4 weeks

## Technical Notes

### Substation Types

1. **Distribution Substations**
   - Typical: 34.5kV to 13.8kV transformation
   - Load serving: Residential, commercial, industrial
   - Size: 5-50 MVA transformers, 2-4 feeders

2. **Transmission Substations**
   - Typical: 115kV to 69kV or 230kV to 115kV
   - Bulk power transfer: System substation
   - Size: 50-500 MVA transformers, multiple lines

3. **Switching Stations**
   - Voltage transformation minimal
   - System switching and isolation
   - Reliability improvement
   - Loop or section transmission lines

### Equipment Selection

1. **Power Transformers**
   - Two-winding: Most common
   - Three-winding: For three-voltage level substations
   - Auto-transformers: For close voltage ratios
   - Impedance: 8-12% typical, affects fault levels
   - Cooling: ONAN, ONAF, OAF (oil, forced air, forced oil)

2. **Circuit Breakers**
   - SF6 gas insulated: 72.5-800kV, high reliability
   - Vacuum breakers: Up to 145kV, lower maintenance
   - Air magnetic: Older, up to 72.5kV
   - Ratings: Continuous, interrupting, dynamic recovery

3. **Disconnect Switches**
   - Load break: Visible break, motor operated
   - Non-load break: For de-energized switching
   - Grounding switches: For maintenance grounding

### Bus Configurations

1. **Common Arrangements**
   - Single bus: Simplest, lowest reliability
   - Main and transfer bus: Improved reliability
   - Breaker-and-a-half: High reliability, 3 breakers per 2 circuits
   - Ring bus: 3-4 circuit, high reliability, lower cost
   - Double bus double breaker: Highest reliability

2. **Bus Types**
   - Rigid bus (aluminum tube): 1.5-3in diameter, 10-20ft spans
   - Strain bus (cable): Lower cost, larger sag
   - Gas insulated (GIB): Compact, for high voltage

### Protection Systems

1. **Transformer Protection**
   - Differential (87T): Primary protection, 15-100% tap
   - Overcurrent backup (51/50): Secondary protection
   - Sudden pressure relay (63): Mechanical faults
   - Gas analysis (DGA): Online monitoring

2. **Bus Protection**
   - Zone differential (87B): Bus differential protection
   - Breaker failure (50BF): Trip adjacent breakers
   - Overcurrent backup (51): Zone backup

3. **Line Protection**
   - Distance (21): 80-120% reach, backup 51
   - Directional overcurrent (67): For ground faults
   - Pilot schemes (Pott): High-speed clearing

## Paperclip Task Schema

```yaml
task_schema:
  title: Substation Design and Equipment Workflow Template
  phase: Phase 3 — Substations and Infrastructure
  priority: high
  skills:
    - electrical-engineering
    - substation-design
    - protection-systems
    - power-systems
```

## Success Validation

1. **Equipment Adequacy**: All equipment properly rated
2. **Protection Coordination**: Selectivity verified
3. **Safety**: OSHA and utility requirements met
4. **Reliability**: N-1 contingencies addressed

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-060 (Migrated to ELEC-WORKFLOW)