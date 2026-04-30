---
id: UNIV-060
title: Substation Design and Equipment Workflow Template
phase: Phase 7 — Electrical Engineering
status: backlog
priority: high
assigneeAgentId: interface-devforge
parent: UNIV-058
project: UNIV-WORKFLOW
---

# UNIV-060: Substation Design and Equipment Workflow Template

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

## Working Directory

`docs-paperclip/disciplines/00860-electrical-engineering/workflows/substations/`

## Required Skills

- Electrical Engineering (Substation specialization)
- Power Systems Analysis
- Protection and Control
- Substation Design Software

## Dependencies

- BLOCKED BY: UNIV-058 (Transmission)
- BLOCKS: None

## Estimated Effort

- **Complexity**: Very High
- **Estimated Hours**: 16-20 hours
- **Timeline**: 3-4 weeks

## Technical Notes

### Substation Types

1. **Distribution Substations**
   - Typical: 34.5kV to 13.8kV
   - Load serving substations
   - Urban and rural applications

2. **Transmission Substations**
   - Typical: 115kV to 500kV
   - System voltage transformation
   - Bulk power transfer

3. **Switching Stations**
   - Voltage transformation minimal
   - System switching and isolation
   - Reliability improvement

### Equipment Selection

1. **Power Transformers**
   - Two-winding and three-winding
   - Auto-transformers
   - Phase shift transformers
   - Rating and impedance selection

2. **Circuit Breakers**
   - SF6 gas insulated
   - Vacuum breakers
   - Air magnetic
   - Ratings (continuous, interrupting)

3. **Disconnect Switches**
   - Load break and non-load break
   - Motor operated
   - Grounding switches

### Bus Configurations

1. **Common Arrangements**
   - Single bus
   - Main and transfer bus
   - Breaker-and-a-half
   - Ring bus
   - Double bus double breaker

2. **Bus Types**
   - Rigid bus (aluminum tube)
   - Strain bus (cable)
   - Gas insulated (GIB)

### Protection Systems

1. **Transformer Protection**
   - Differential protection
   - Overcurrent backup
   - Sudden pressure relay
   - Gas analysis

2. **Bus Protection**
   - Zone differential
   - Breaker failure
   - Overcurrent backup

3. **Line Protection**
   - Distance protection (21)
   - Directional overcurrent (67)
   - Pilot schemes

## Paperclip Task Schema

```yaml
task_schema:
  title: Substation Design and Equipment Workflow Template
  phase: Phase 7 — Electrical Engineering
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
