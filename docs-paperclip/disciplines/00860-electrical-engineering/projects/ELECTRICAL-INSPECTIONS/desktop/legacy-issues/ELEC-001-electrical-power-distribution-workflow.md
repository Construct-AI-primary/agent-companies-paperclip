---
id: ELEC-001
title: Electrical Power Distribution Workflow Template
phase: Phase 1 — Distribution Systems
status: backlog
priority: high
assignee: interface-devforge
company: devforge-ai
created_date: 2026-04-17
due_date: 2026-05-17
estimated_hours: 20
parent: ELEC-WORKFLOW
project: ELEC-WORKFLOW
derivedFrom: UNIV-056
---

# ELEC-001: Electrical Power Distribution Workflow Template

## Description

Create a comprehensive electrical power distribution workflow template that standardizes utility power distribution design from substation through service connections.

**Context**: Electrical distribution requires coordination of utility requirements, load calculations, and code compliance. This template addresses the complete design process for power distribution systems.

**Objectives**:
- Create standardized power distribution design workflows
- Design medium voltage system templates (4.16kV-35kV)
- Build transformer sizing and protection templates
- Integrate with civil infrastructure planning
- Ensure NEC and utility compliance

**Scope**:
- In Scope: Overhead/underground distribution, transformer sizing, protection coordination
- Out of Scope: Substation design, transmission lines, generation

## Acceptance Criteria

- [ ] Medium voltage distribution design workflow
- [ ] Transformer sizing and loading templates
- [ ] Overhead line design (poles, conductors, guying)
- [ ] Underground duct bank design templates
- [ ] Protection coordination templates
- [ ] Voltage drop and short circuit analysis
- [ ] Utility coordination documents

## Assigned Company & Agent

- **Primary**: DevForge AI — interface-devforge
- **Supporting**: InfraForge AI — database-infraforge
- **Integration Support**: IntegrateForge AI — Electrical OpenCV Measurement connectors available

## Working Directory

`docs-paperclip/disciplines/00860-electrical-engineering/workflows/distribution/`

## Required Skills

- Electrical Engineering
- Power Systems Analysis
- Utility Coordination
- AutoCAD/ Electrical Software

## Dependencies

- BLOCKED BY: None (Phase 1 independent)
- BLOCKS: ELEC-002 (Traffic Signals), ELEC-003 (Transmission)

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 14-18 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### Voltage Classes

1. **Primary Distribution** (4.16kV-35kV)
   - Radial systems: Single source, simple protection
   - Loop systems: Primary loop, open point for switching
   - Network systems: Spot network for downtown areas
   - Switching: Sectionalizing switches, line reclosers
   - Protection: Fuses, reclosers, sectionizers

2. **Secondary Distribution** (120V-480V)
   - Single-phase: 120/240V residential
   - Three-phase: 208Y/120V, 480Y/277V commercial
   - Network protectors: For spot network
   - Transformer secondary fusing

### Overhead System Components

1. **Pole Classes and Spacing**
   - Class B (Southern Pine), Class C (Western Red Cedar)
   - Spacing: 100-150ft typical, based on conductor and grade
   - Guying: Angle guying, dead-end guying, side guy

2. **Conductor Sizing**
   - AAC (All Aluminum Conductor): 1350 alloy, common for distribution
   - AAAC (All Aluminum Alloy Conductor): 6201 alloy, better sag/tension
   - ACSR (Aluminum Conductor Steel Reinforced): For long spans, high tension
   - Ampacity: Based on conductor size, material, installation conditions

3. **Transformer Sizing**
   - Single-phase: 25-167 kVA typical
   - Three-phase: 75-2500 kVA typical
   - Loading: 80-90% of nameplate for normal, 100% for emergency
   - Impedance: 5-8% typical for distribution transformers

### Underground System Components

1. **Duct Bank Design**
   - PVC conduits: Schedule 40 or 80, 2-4in typical
   - Concrete encasement: 3in minimum cover, 2ft minimum depth
   - Spacing: Maintain separation from other utilities
   - Sweeps: 36-48in radius for terminations

2. **Cable Sizing**
   - XLPE or EPR insulation, 600V or 5kV
   - Shielded vs. unshielded based on voltage and installation
   - Ampacity: NEC Tables or utility requirements
   - Pulling tension: Limit to 600-1000 lbs typical

3. **Termination and Splices**
   - Heat-shrink terminations: Indoor/outdoor rated
   - Cold-shrink terminations: Pre-expanded rubber
   - Splice kits: Resin or heat-shrink style

### Design Standards

- **NEC** Article 200, 210, 220, 230 (Services and feeders)
- **NESC** Part 2 (Ground supply distribution)
- **IEEE** 1015 (Pad-mounted transformers)
- **IEEE** 141 (Red Book) - Power distribution

## Paperclip Task Schema

```yaml
task_schema:
  title: Electrical Power Distribution Workflow Template
  phase: Phase 1 — Distribution Systems
  priority: high
  skills:
    - electrical-engineering
    - power-systems
    - utility-coordination
```

## Success Validation

1. **Code Compliance**: NEC/NESC requirements met
2. **Voltage Drop**: Within 3% branch, 5% feeder limits
3. **Protection**: Coordination verified with utility
4. **Utility Approval**: Design accepted by utility

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-056 (Migrated to ELEC-WORKFLOW)