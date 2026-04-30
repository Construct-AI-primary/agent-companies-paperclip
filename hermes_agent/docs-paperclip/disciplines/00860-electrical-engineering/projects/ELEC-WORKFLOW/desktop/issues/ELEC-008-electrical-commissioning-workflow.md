---
id: ELEC-008
title: Electrical Commissioning and Acceptance Workflow Template
phase: Phase 4 — Operations and Testing
status: backlog
priority: high
assigneeAgentId: interface-devforge
parent: ELEC-007
project: ELEC-WORKFLOW
derivedFrom: UNIV-063
---

# ELEC-008: Electrical Commissioning and Acceptance Workflow Template

## Description

Create a comprehensive electrical commissioning workflow template that standardizes system verification, testing, and acceptance for electrical installations from pre-commissioning through final handover.

**Context**: Electrical commissioning ensures all systems are installed correctly, function properly, and meet design specifications before being placed in service. This template addresses the complete commissioning process.

**Objectives**:
- Create standardized pre-commissioning checklists
- Design system verification workflows
- Build functional performance testing templates
- Integrate with commissioning authorities
- Ensure code compliance verification

**Scope**:
- In Scope: Switchgear, transformers, generators, motors, protection systems, grounding
- Out of Scope: Mechanical systems, building automation, communication systems

## Acceptance Criteria

- [ ] Pre-commissioning preparation workflow
- [ ] Equipment inspection checklists templates
- [ ] Hi-pot and insulation testing workflows
- [ ] Protection relay calibration templates
- [ ] Generator paralleling and load testing
- [ ] System integration testing workflow
- [ ] Final acceptance documentation

## Assigned Company & Agent

- **Primary**: DevForge AI — interface-devforge
- **Supporting**: InfraForge AI — database-infraforge
- **Integration Support**: IntegrateForge AI — Electrical OpenCV Measurement connectors available

## Working Directory

`docs-paperclip/disciplines/00860-electrical-engineering/workflows/commissioning/`

## Required Skills

- Electrical Engineering
- Commissioning Management
- Power Systems Testing
- NFPA 70E/Arc Flash Safety

## Dependencies

- BLOCKED BY: ELEC-007 (Maintenance)
- BLOCKS: None (ELEC-WORKFLOW completion)

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 12-16 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### Commissioning Phases

1. **Pre-Commissioning**
   - Design review: Check specifications, one-lines
   - Submittals review: Verify equipment matches
   - Equipment inspection: Visual, nameplate verification
   - Punch list development: Deficiency list

2. **System Verification**
   - Visual inspection: Wiring, terminations
   - Continuity testing: Ground, bonding
   - Insulation testing: Megger, hi-pot
   - Phasing/rotation: Correct direction

3. **Functional Testing**
   - Protection system tests: Relay settings, coordination
   - Interlock verification: Sequence of operation
   - Control system tests: Local/remote, auto/manual
   - Alarm and monitoring: SCADA, BMS interface

4. **Performance Testing**
   - Load testing: Full load, stepped loading
   - Harmonic analysis: THD measurements
   - Power quality: Flicker, transients
   - Transient response: Generator/UPS

### Testing Procedures

1. **Transformers (IEEE C57)**
   - Ratio test: All tap positions
   - Polarity test: Verify connection
   - Winding resistance: Compare to factory
   - Bushing power factor: C57.19.1
   - No-load excitation: Current, harmonics
   - Insulation power factor: IEEE C57.12.90

2. **Switchgear**
   - Contact resistance: Millivolt drop per phase
   - Timing tests: Close, open, trip time
   - Hi-pot testing: 60% of factory test
   - Mechanical operation: Operating mechanism
   - Protection coordination: Verify settings

3. **Generators**
   - Megger windings: Stator, exciter
   - Polarization index: PI = R10min / R1min, >4
   - DGA: Pre-load sampling
   - Load rejection: Verify governor response
   - Synchronizing tests: Sync scope, sync check
   - Governor response: Droop, isochronous
   - Voltage regulator: Voltage build-up, stability

4. **Grounding Systems**
   - Ground resistance: <5 ohms typical
   - Step and touch potential: Safety verification
   - Bonding verification: Continuity test
   - Grid continuity: All joints tested

### Documentation Requirements

1. **Test Reports**
   - As-found/as-left data: Before and after adjustments
   - Pass/fail criteria: Based on standards
   - Deficiency log: Issues found and resolved
   - Corrective actions: What was done

2. **Certificates**
   - Certificate of Completion: Commissioning sign-off
   - Arc flash labels: Per NFPA 70E, NEC 110.16
   - One-line diagrams: Updated with settings
   - Equipment settings: Relay, VFD, PLC

### Safety Requirements (NFPA 70E)

1. **Arc Flash Analysis**
   - Incident energy calculation: IEEE 1584
   - PPE categories: 1-4 based on energy
   - Arc flash boundary: 0.5-365 cal/cm²
   - Warning labels: Required before energizing

2. **Work Practices**
   - Energized work permit: For hot work
   - Lockout/Tagout: Per OSHA 1910.147
   - PPE requirements: FR clothing, face shield
   - Safe approach distances: Table 130.4(C)

## Paperclip Task Schema

```yaml
task_schema:
  title: Electrical Commissioning and Acceptance Workflow Template
  phase: Phase 4 — Operations and Testing
  priority: high
  skills:
    - electrical-engineering
    - commissioning
    - testing
    - safety
```

## Success Validation

1. **Code Compliance**: All NEC/OSHA requirements met
2. **Functionality**: All systems perform as designed
3. **Documentation**: Complete test reports and certificates
4. **Safety**: Arc flash labels installed, PPE procedures documented

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-063 (Migrated to ELEC-WORKFLOW)