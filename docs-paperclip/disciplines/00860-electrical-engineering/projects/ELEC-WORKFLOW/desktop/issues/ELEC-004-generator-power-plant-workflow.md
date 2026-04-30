---
id: ELEC-004
title: Generator and Power Plant Workflow Template
phase: Phase 2 — Transmission and Generation
status: backlog
priority: high
assigneeAgentId: interface-devforge
parent: ELEC-003
project: ELEC-WORKFLOW
derivedFrom: UNIV-059
---

# ELEC-004: Generator and Power Plant Workflow Template

## Description

Create a comprehensive generator and power plant workflow template that standardizes standby/emergency generator design, power plant electrical systems, and generator interconnection.

**Context**: Generator systems range from small standby units to large power plants, requiring coordination of mechanical and electrical systems. This template addresses the complete design process for generation facilities.

**Objectives**:
- Create standardized generator sizing and selection workflows
- Design standby/emergency power system templates
- Build parallel generator system templates
- Integrate with utility interconnection requirements
- Ensure NEC Article 700/701/702 compliance

**Scope**:
- In Scope: Standby generators, emergency generators, parallel systems, microgrids
- Out of Scope: Utility-scale generation plants, renewable energy systems

## Acceptance Criteria

- [ ] Generator sizing workflow (load analysis, NFPA 110)
- [ ] Automatic transfer switch (ATS) selection templates
- [ ] Standby power system design workflow
- [ ] Parallel generator system templates
- [ ] Fuel system coordination templates
- [ ] Emissions and environmental compliance
- [ ] Utility interconnection requirements

## Assigned Company & Agent

- **Primary**: DevForge AI — interface-devforge
- **Supporting**: InfraForge AI — database-infraforge
- **Integration Support**: IntegrateForge AI — Electrical OpenCV Measurement connectors available

## Working Directory

`docs-paperclip/disciplines/00860-electrical-engineering/workflows/generators/`

## Required Skills

- Electrical Engineering
- Power Systems Analysis
- Generator/Switchgear Design
- NEC/NFPA Standards

## Dependencies

- BLOCKED BY: ELEC-001 (Power Distribution)
- BLOCKS: None (Phase 2 completion)

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 12-16 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### Generator Types (NFPA 110)

1. **Type 10 - Stationary**
   - Level 1 or Level 2 systems
   - 0-150 kW typical (Level 1)
   - 151-600 kW typical (Level 2)

2. **Type U - Mobile**
   - Portable generator sets
   - Quick-connect paralleling
   - Emergency applications

3. **Class Designations**
   - Class X: 0-150 kW
   - Class Y: 151-600 kW
   - Class Z: 601-3500 kW

4. **Type Designations**
   - Type 10: 10-second start
   - Type 60: 60-second start
   - Type 120: 120-second start

### NEC Articles for Generators

1. **NEC 700 - Emergency Systems**
   - Legally required standby
   - Essential for safety
   - Egress lighting, fire pumps

2. **NEC 701 - Legally Required Standby**
   - Similar to emergency
   - Different approval process
   - Life safety systems

3. **NEC 702 - Optional Standby**
   - Facility protection
   - Business continuity
   - Not required by code

### Sizing Considerations

1. **Load Analysis**
   - Connected load vs. demand factor
   - Motors: kVA = HP × 0.746 × SF / (η × PF)
   - Transformer inrush: 6-12x normal for 0.1 sec
   - Selective loads: Critical, essential, optional

2. **Motor Starting**
   - Direct-on-line (DOL): 6-7x FLA
   - Star-delta: 2-3x FLA
   - VFD: 1.0-1.15x FLA
   - Voltage dip: Limit to 15-25% for generators

3. **Derating Factors**
   - Altitude: 1% per 330m above 900m
   - Temperature: Based on ambient
   - Fuel: Natural gas vs. diesel output

### Transfer Switches

1. **Automatic Transfer Switches (ATS)**
   - Open transition: Break-before-make
   - Closed transition: Make-before-break (parallel)
   - In-phase transfer: For motors, no load shed
   - Delayed transfer: For stabilization

2. **Bypass/Isolation Switches**
   - Manual bypass: Maintenance without power loss
   - Automatic bypass: For ATS failure
   - Sequence of operation: ATS → bypass → restore

## Paperclip Task Schema

```yaml
task_schema:
  title: Generator and Power Plant Workflow Template
  phase: Phase 2 — Transmission and Generation
  priority: high
  skills:
    - electrical-engineering
    - power-systems
    - generator-design
```

## Success Validation

1. **NEC Compliance**: Article 700/701/702 requirements met
2. **NFPA 110**: Type and class requirements satisfied
3. **Capacity**: Adequate for all loads with growth
4. **Start-up**: Completes start sequence within required time

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-059 (Migrated to ELEC-WORKFLOW)