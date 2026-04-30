---
id: UNIV-063
title: Electrical Commissioning and Acceptance Workflow Template
phase: Phase 7 — Electrical Engineering
status: backlog
priority: high
assigneeAgentId: interface-devforge
parent: UNIV-062
project: UNIV-WORKFLOW
---

# UNIV-063: Electrical Commissioning and Acceptance Workflow Template

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

## Working Directory

`docs-paperclip/disciplines/00860-electrical-engineering/workflows/commissioning/`

## Required Skills

- Electrical Engineering
- Commissioning Management
- Power Systems Testing
- NFPA 70E/Arc Flash

## Dependencies

- BLOCKED BY: UNIV-062 (Maintenance)
- BLOCKS: None (Phase 7 completion)

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 12-16 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### Commissioning Phases

1. **Pre-Commissioning**
   - Design review
   - Submittals review
   - Equipment inspection
   - Punch list development

2. **System Verification**
   - Visual inspection
   - Wiring verification
   - Grounding testing
   - Insulation resistance

3. **Functional Testing**
   - Protection system tests
   - Interlock verification
   - Control system tests
   - Alarm and monitoring tests

4. **Performance Testing**
   - Load testing
   - Harmonic analysis
   - Power quality
   - Transient response

### Testing Procedures

1. **Transformers**
   - Ratio test
   - Polarity test
   - Winding resistance
   - Bushing power factor
   - Insulation power factor
   - No-load excitation current

2. **Switchgear**
   - Contact resistance
   - Timing tests
   - Hi-pot testing
   - Mechanical operation
   - Protection coordination

3. **Generators**
   - Megger windings
   - Polarization index
   - Load rejection
   - Synchronizing tests
   - Governor response
   - Voltage regulator

4. **Grounding Systems**
   - Ground resistance
   - Step and touch potential
   - Bonding verification
   - Grid continuity

### Documentation Requirements

1. **Test Reports**
   - As-found/as-left data
   - Pass/fail criteria
   - Deficiency log
   - Corrective actions

2. **Certificates**
   - Certificate of Completion
   - Arc flash labels
   - One-line diagrams
   - Equipment settings

### Standards and Codes

- **NFPA** 70 (NEC)
- **NFPA** 70E (Electrical Safety)
- **IEEE** 3000 series
- **NETA** ATS (Acceptance Testing)
- **OSHA** regulations
- **Authority Having Jurisdiction** (AHJ) requirements

### Safety Requirements

- Lockout/Tagout procedures
- Arc flash protection
- Safety briefing requirements
- PPE requirements
- Energized work permits

## Paperclip Task Schema

```yaml
task_schema:
  title: Electrical Commissioning and Acceptance Workflow Template
  phase: Phase 7 — Electrical Engineering
  priority: high
  skills:
    - electrical-engineering
    - commissioning
    - testing
    - safety
```

## Success Validation

1. **Code Compliance**: All NEC/ OSHA requirements met
2. **Functionality**: All systems perform as designed
3. **Documentation**: Complete test reports and certificates
4. **Safety**: Arc flash labels installed, PPE provided

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
