---
id: UNIV-061
title: Cable Selection and Reticulation Workflow Template
phase: Phase 7 — Electrical Engineering
status: backlog
priority: medium
assigneeAgentId: interface-devforge
parent: UNIV-056
project: UNIV-WORKFLOW
---

# UNIV-061: Cable Selection and Reticulation Workflow Template

## Description

Create a comprehensive cable selection and reticulation workflow template that standardizes power cable design, cable routing, and network reticulation from sizing through installation.

**Context**: Cable systems are the backbone of electrical distribution, requiring careful selection based on current-carrying capacity, voltage drop, and installation conditions. This template addresses the complete design process for cable systems.

**Objectives**:
- Create standardized cable sizing workflows
- Design cable routing and tray system templates
- Build cable schedule and take-off automation
- Integrate with conduit and duct bank design
- Ensure NEC and ICEA compliance

**Scope**:
- In Scope: Power cables, control cables, cable trays, conduits, duct banks
- Out of Scope: Transmission cables (underground HV), fiber optic cables

## Acceptance Criteria

- [ ] Cable sizing workflow (ampacity, voltage drop)
- [ ] Cable tray and support system templates
- [ ] Conduit and duct bank design workflow
- [ ] Cable pulling tension calculations
- [ ] Cable schedule generation automation
- [ ] Termination and splice design templates
- [ ] Fire rating and protection requirements

## Assigned Company & Agent

- **Primary**: DevForge AI — interface-devforge
- **Supporting**: InfraForge AI — database-infraforge

## Working Directory

`docs-paperclip/disciplines/00860-electrical-engineering/workflows/cables/`

## Required Skills

- Electrical Engineering
- Cable System Design
- NEC/ICEA Standards
- Cable Tray/Conduit Software

## Dependencies

- BLOCKED BY: UNIV-056 (Power Distribution)
- BLOCKS: None

## Estimated Effort

- **Complexity**: Medium
- **Estimated Hours**: 10-14 hours
- **Timeline**: 2 weeks

## Technical Notes

### Cable Types

1. **Power Cables**
   - XLPE (cross-linked polyethylene)
   - EPR (ethylene propylene rubber)
   - PVC insulation
   - Shielded vs. unshielded

2. **Control Cables**
   - Multi-conductor
   - Shielded instrumentation
   - Thermocouple extension
   - Fire alarm cables

3. **Construction**
   - Single conductor
   - Multi-conductor (MC cable)
   - Armored (BX/AC)
   - Metal-clad (MC)

### Sizing Criteria

1. **Ampacity**
   - NEC Table 310.16/310.17
   - Adjustment factors (temperature, bundling)
   - Termination temperature limits

2. **Voltage Drop**
   - 3% branch circuits
   - 5% feeders
   - 2% transformers

3. **Short Circuit**
   - Withstand rating
   - Time-current coordination
   - Shield short circuit rating

### Installation Methods

1. **Cable Tray**
   - Ladder type
   - Solid bottom
   - Wire mesh (basket)
   - Fill calculations per NEC

2. **Conduit**
   - EMT, IMC, RMC, PVC
   - Wire fill calculations
   - Pull boxes and sleeves

3. **Duct Banks**
   - Encased in concrete
   - Direct buried
   - Spacing and thermal considerations

### Cable Routing

- Shortest path optimization
- Separation from other systems
- Access for maintenance
- Future expansion allowance

## Paperclip Task Schema

```yaml
task_schema:
  title: Cable Selection and Reticulation Workflow Template
  phase: Phase 7 — Electrical Engineering
  priority: medium
  skills:
    - electrical-engineering
    - cable-design
    - nec-compliance
```

## Success Validation

1. **Ampacity**: Cable properly sized for conditions
2. **Voltage Drop**: Within NEC limits
3. **Installation**: Pull tensions acceptable
4. **Code Compliance**: NEC/ICEA requirements met

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
