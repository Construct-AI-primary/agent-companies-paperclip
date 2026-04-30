---
title: MECH-WORKFLOW Workflows List
discipline: 00870
project: MECH-WORKFLOW
version: 1.0
date: 2026-04-17
---

# MECH-WORKFLOW — Workflows Catalog

## Overview

This document catalogs all workflows for the Mechanical Engineering discipline (00870), covering HVAC, plumbing, fire protection, equipment selection, and construction support operations.

## Workflows Summary

| ID | Workflow Name | Phase | Priority | Status | Complexity |
|----|---------------|-------|----------|--------|------------|
| MECH-001 | HVAC System Design | Phase 1 | Critical | Partial | High |
| MECH-002 | Plumbing Systems Design | Phase 1 | High | Partial | Medium |
| MECH-003 | Fire Protection Systems | Phase 2 | High | Pending | Medium |
| MECH-004 | Equipment Selection & Sizing | Phase 2 | High | Pending | Medium |
| MECH-005 | Construction Support | Phase 3 | Medium | Pending | Medium |

---

## Workflow Dependencies

```
MECH-001 (HVAC Design)
    ├── MECH-002 (Plumbing)
    ├── MECH-003 (Fire Protection)
    └── MECH-004 (Equipment Selection)
         │
         └── MECH-005 (Construction Support)
```

---

## Detailed Workflow Descriptions

### MECH-001: HVAC System Design

**Description**: Comprehensive workflow for heating, ventilation, and air conditioning system design from load calculations through equipment selection and ductwork layout.

**Key Activities**:
- Load calculations (heating/cooling)
- HVAC system type selection
- Equipment sizing and selection
- Ductwork design and layout
- Energy efficiency optimization
- Commissioning and testing plans

**Deliverables**:
- Load calculation reports
- HVAC system schematics
- Equipment schedules
- Ductwork drawings
- Commissioning plans

**Standards**: ASHRAE 90.1, ASHRAE 62.1, SMACNA, SMACNA HVAC Systems Duct Design

**Estimated Hours**: 16-20 hours

---

### MECH-002: Plumbing Systems Design

**Description**: Workflow for domestic water, sanitary, and storm drainage system design including fixture counts, pipe sizing, and system layout.

**Key Activities**:
- Fixture unit calculations
- Water supply system design
- Sanitary drainage layout
- Storm water management
- Pipe sizing and material selection
- Coordination with architectural drawings

**Deliverables**:
- Plumbing riser diagrams
- Fixture schedules
- Pipe sizing calculations
- Water heater selection
- Isometric drawings

**Standards**: IPC, UPC, ASPE, ASME A17.1

**Estimated Hours**: 12-16 hours

---

### MECH-003: Fire Protection Systems

**Description**: Workflow for fire suppression and detection system design including sprinkler layout, fire pump sizing, and alarm system coordination.

**Key Activities**:
- Occupancy classification analysis
- Sprinkler system design (wet/dry)
- Fire pump and water supply calculations
- Fire alarm system layout
- Standpipe system design
- NFPA code compliance verification

**Deliverables**:
- Fire protection layout drawings
- Sprinkler head schedules
- Fire pump specifications
- Fire alarm riser diagrams
- Hydraulic calculations

**Standards**: NFPA 13, NFPA 14, NFPA 20, NFPA 72, NFPA 101

**Estimated Hours**: 14-18 hours

---

### MECH-004: Equipment Selection

**Description**: Workflow for mechanical equipment selection, sizing, and procurement support including chillers, boilers, air handlers, and terminal units.

**Key Activities**:
- Equipment load determination
- Efficiency requirements (ASHRAE 90.1)
- Manufacturer comparison analysis
- Equipment schedule development
- Submittal review procedures
- Delivery coordination

**Deliverables**:
- Equipment schedules
- Performance specifications
- Manufacturer comparison matrix
- Submittal tracking register
- Delivery milestones

**Standards**: ASHRAE 90.1, AHRI, AMCA, UL listings

**Estimated Hours**: 10-14 hours

---

### MECH-005: Construction Support

**Description**: Workflow for mechanical engineering support during construction including RFI responses, submittal review, and site observations.

**Key Activities**:
- RFI receipt and response
- Submittal review and approval
- Site observation reports
- Shop drawing review
- Change order impact assessment
- As-built documentation

**Deliverables**:
- RFI response register
- Submittal approval log
- Site observation reports
- Change order technical reviews
- As-built markups

**Standards**: Contract procedures, AIA G-series, project specifications

**Estimated Hours**: 8-12 hours

---

## Cross-Discipline Integration

| Discipline | Interface Type | Key Handoff Points |
|------------|----------------|-------------------|
| 00800 (Design) | Design coordination, reviews | Schematic, DD, CD phases |
| 00825 (Architectural) | Equipment rooms, shaft coordination | All phases |
| 00850 (Civil) | Site utilities, storm drainage | Site work phases |
| 00860 (Electrical) | Power, controls, fire alarm | All phases |
| 00300 (Construction) | RFI support, submittals | Construction phase |
| 00900 (Document Control) | Document management | All phases |

---

## Success Criteria

- [ ] All 5 workflows documented and templated
- [ ] ASHRAE/NFPA compliance verification
- [ ] Cross-discipline coordination procedures established
- [ ] Equipment selection criteria standardized
- [ ] Construction support processes defined
- [ ] User acceptance testing completed

---

**Document Version**: 1.0  
**Last Updated**: 2026-04-17
