---
id: ELEC-002
title: Traffic Signals and Intelligent Transportation Workflow Template
phase: Phase 1 — Distribution Systems
status: backlog
priority: high
assigneeAgentId: interface-devforge
parent: ELEC-001
project: ELEC-WORKFLOW
derivedFrom: UNIV-057
---

# ELEC-002: Traffic Signals and Intelligent Transportation Workflow Template

## Description

Create a comprehensive traffic signal and intelligent transportation system (ITS) workflow template that standardizes traffic signal design from warrant analysis through construction documents.

**Context**: Traffic signals require coordination of traffic engineering, electrical design, and ITS integration. This template addresses the complete design process for traffic signal systems and smart city applications.

**Objectives**:
- Create standardized traffic signal design workflows
- Design signal timing and phasing templates
- Build ITS and communication system templates
- Integrate with smart city infrastructure
- Ensure MUTCD and DOT compliance

**Scope**:
- In Scope: Traffic signals, pedestrian signals, ITS devices, communication systems
- Out of Scope: Freeway management, toll systems, transit priority

## Acceptance Criteria

- [ ] Traffic signal warrant analysis workflow
- [ ] Signal timing and phasing design templates
- [ ] Traffic signal plan production workflow
- [ ] Pedestrian and bicycle signal design templates
- [ ] ITS device placement templates (cameras, detectors)
- [ ] Communication system design workflow
- [ ] ADA accessibility compliance verification

## Assigned Company & Agent

- **Primary**: DevForge AI — interface-devforge
- **Supporting**: InfraForge AI — database-infraforge
- **Integration Support**: IntegrateForge AI — Electrical OpenCV Measurement connectors available

## Working Directory

`docs-paperclip/disciplines/00860-electrical-engineering/workflows/traffic-signals/`

## Required Skills

- Traffic Engineering
- Electrical Engineering
- ITS Design
- AutoCAD/ Synchro/ Traffic Software

## Dependencies

- BLOCKED BY: None (Phase 1 independent)
- BLOCKS: None (Phase 1 completion)

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 12-16 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### MUTCD Signal Warrants

1. **Warrant 1: Eight-Hour Vehicle Volume**
   - Part A: Minimum vehicle volume (420 vph for 8 hrs)
   - Part B: Interruption of continuous traffic (160 vph for 8 hrs)

2. **Warrant 2: Four-Hour Vehicle Volume**
   - 480 vph for 4 hours (one lane each approach)

3. **Warrant 3: Peak Hour**
   - 150 vph for 1 hour + signal delay conditions

4. **Warrant 4: Pedestrian Volume**
   - 100 ped/hr for 4 hours + vehicle volume requirements

5. **Warrant 5: School Crossings**
   - School age children + gap frequency

6. **Warrant 7: Crash Experience**
   - 5+ reported crashes in 12 months + volume warrants

### Timing and Phasing

1. **Phase Sequence Design**
   - Ring-and-barrier: Standard 2-ring, 8-phase controller
   - Protected/permitted left turns: Leading/lagging phases
   - Pedestrian intervals: Walk + flashing don't walk calculation
   - Clearance intervals: Yellow + all-red based on speed

2. **Timing Calculations**
   - Lost time per phase: 2-4 seconds typical
   - Cycle length: 60-120 seconds urban, up to 180 seconds arterials
   - Split: Proportion of cycle to each phase
   - Green interval: Split minus lost time

3. **Coordination**
   - Offset: Time difference between green beginnings
   - Cycle: Common cycle length for coordinated corridors
   - Time-Space diagram: Offset graphic for design

### Signal Equipment

1. **Signal Heads and Displays**
   - 12-inch vehicle indications: Red, yellow, green
   - 8-inch secondary/pedestrian indications
   - LED modules: Energy savings, long life
   - Backplates: Enhanced visibility, 24in x 18in typical

2. **Detection Systems**
   - Inductive loops: 6x6ft to 40x6ft, based on approach
   - Video detection: VIVAR, Autoscope
   - Radar detection: RTMS, Blue Arrow
   - Bluetooth detection: Travel time collection

3. **Controllers**
   - NEMA TS1/TS2: Standard cabinet, conflict monitoring
   - Advanced traffic management: ATMS software integration
   - Adaptive signal control: InSync, SCATS, RHODES

### ITS Communication

1. **Fiber Optic Backbone**
   - Single-mode fiber: 12-144 strand typical
   - Termination: Splice cases, patch panels
   - Equipment: OEO/Managed switches

2. **Wireless Mesh**
   - 4.9 GHz public safety band
   - 5.8 GHz ISM band for ITS
   - Point-to-multipoint or mesh topology

3. **Cellular**
   - Primary or backup connectivity
   - Cellular routers at field devices

## Paperclip Task Schema

```yaml
task_schema:
  title: Traffic Signals and Intelligent Transportation Workflow Template
  phase: Phase 1 — Distribution Systems
  priority: high
  skills:
    - traffic-engineering
    - electrical-engineering
    - its-design
```

## Success Validation

1. **Warrant Compliance**: Signal warrants satisfied with documentation
2. **Safety**: MUTCD requirements met
3. **ADA Compliance**: Countdown timers, APS installed
4. **Operational**: Timing optimized for traffic flow

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-057 (Migrated to ELEC-WORKFLOW)