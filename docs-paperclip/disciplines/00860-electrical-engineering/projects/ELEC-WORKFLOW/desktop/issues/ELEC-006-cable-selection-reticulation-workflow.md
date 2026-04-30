---
id: ELEC-006
title: Cable Selection and Reticulation Workflow Template
phase: Phase 3 — Substations and Infrastructure
status: backlog
priority: medium
assigneeAgentId: interface-devforge
parent: ELEC-001
project: ELEC-WORKFLOW
derivedFrom: UNIV-061
---

# ELEC-006: Cable Selection and Reticulation Workflow Template

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
- **Integration Support**: IntegrateForge AI — Electrical OpenCV Measurement connectors available

## Working Directory

`docs-paperclip/disciplines/00860-electrical-engineering/workflows/cables/`

## Required Skills

- Electrical Engineering
- Cable System Design
- NEC/ICEA Standards
- Cable Tray/Conduit Software

## Dependencies

- BLOCKED BY: ELEC-001 (Power Distribution)
- BLOCKS: None (Phase 3 completion)

## Estimated Effort

- **Complexity**: Medium
- **Estimated Hours**: 10-14 hours
- **Timeline**: 2 weeks

## Technical Notes

### Cable Types

1. **Power Cables**
   - XLPE (cross-linked polyethylene): 600V-35kV, excellent thermal
   - EPR (ethylene propylene rubber): 600V-35kV, good flexibility
   - PVC insulation: 600V only, lower cost
   - LSF (low smoke fume): Fire rated areas

2. **Control Cables**
   - Multi-conductor: 16-12 AWG, individual shields
   - Shielded instrumentation: For analog signals
   - Thermocouple extension: Color coded by type
   - Fire alarm: FPL, FPLR, FPLP rated

3. **Construction Types**
   - Single conductor: THHN/THWN, XHHW
   - Multi-conductor (MC cable): Armor-clad, 600V
   - Armored (BX/AC): Older designation
   - Metal-clad (MC): New designation, insulated ground

### Sizing Criteria

1. **Ampacity (NEC Tables)**
   - Table 310.16: 75°C conductors in free air
   - Table 310.17: 75°C conductors in raceway
   - Adjustment factors: Temperature, bundling
   - Termination limits: 75°C for most equipment

2. **Voltage Drop**
   - Branch circuits: 3% maximum
   - Feeders: 5% maximum
   - Combined: 5% maximum (NEC 210.19)
   - Calculate: VD = (2 × K × I × L) / CM

3. **Short Circuit Withstand**
   - Time-current curve: I²t limit for insulation
   - Damage curves: PVC, XLPE, EPR
   - Shield short circuit: Based on cross-section
   - Protective device coordination

### Installation Methods

1. **Cable Tray**
   - Ladder type: For power cables, easy access
   - Solid bottom: For sensitive cables
   - Wire mesh (basket): For small cables, lightweight
   - Fill calculations: Per NEC 392

2. **Conduit**
   - EMT: Thin wall, common indoor
   - IMC: Intermediate, slightly heavier
   - RMC: Rigid metal, outdoor/industrial
   - PVC: Concrete encased, direct buried
   - Wire fill: 40-53% fill for 3+ conductors

3. **Duct Banks**
   - Concrete encased: 3in cover, 2ft min depth
   - Direct buried: Warning tape, sand bedding
   - Spacing: Thermal interaction considered
   - Splice boxes: Handholes, manholes

## Paperclip Task Schema

```yaml
task_schema:
  title: Cable Selection and Reticulation Workflow Template
  phase: Phase 3 — Substations and Infrastructure
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
**Derived From**: UNIV-061 (Migrated to ELEC-WORKFLOW)