---
title: CIVIL-WORKFLOW Workflows List
discipline: 00850
project: CIVIL-WORKFLOW
version: 1.0
date: 2026-04-17
---

# CIVIL-WORKFLOW — Workflows Catalog

## Overview

This document catalogs all workflows for the Civil Engineering discipline (00850), covering site development, infrastructure design, and construction support activities.

## Workflows Summary

| ID | Workflow Name | Phase | Priority | Status | Complexity |
|----|---------------|-------|----------|--------|------------|
| CIVIL-001 | Stormwater Management | Phase 1 | Critical | Pending | High |
| CIVIL-002 | Road/Highway Design | Phase 1 | Critical | Pending | High |
| CIVIL-003 | Earthworks | Phase 2 | High | Pending | Medium |
| CIVIL-004 | Retaining Structures | Phase 2 | High | Pending | Medium |
| CIVIL-005 | Pavement Design | Phase 3 | High | Pending | Medium |
| CIVIL-006 | Construction Support | Phase 3 | Medium | Pending | Low |

---

## Workflow Dependencies

```
CIVIL-001 (Stormwater)
    │
    ├── CIVIL-002 (Road/Highway)
    │     │
    │     ├── CIVIL-003 (Earthworks)
    │     │     │
    │     │     └── CIVIL-004 (Retaining)
    │     │
    │     └── CIVIL-005 (Pavement)
    │
    └── CIVIL-006 (Construction Support) ← All phases
```

---

## Detailed Workflow Descriptions

### CIVIL-001: Stormwater Management

**Description**: Comprehensive stormwater management workflow including drainage design, detention/retention systems, erosion control, and water quality management.

**Key Activities**:
- Stormwater collection system design (pipes, inlets, channels)
- Detention/retention pond design and sizing
- Water quality treatment features
- Erosion and sediment control planning
- Downstream analysis and flood routing
- Regulatory compliance (local, state, federal)

**Deliverables**:
- Stormwater drainage plan
- Detention facility design
- Erosion control plan
- Water quality calculations
- Stormwater management report

**Standards**: EPA Stormwater Regulations, State DOT Standards, Local Stormwater Ordinances, ASCE 7

**Estimated Hours**: 40-60 hours

---

### CIVIL-002: Road/Highway Design

**Description**: Complete road and highway design workflow covering geometric design, cross-sections, intersection design, and signage.

**Key Activities**:
- Horizontal and vertical alignment design
- Cross-section development
- Intersection and interchange design
- Pavement structural design inputs
- Traffic control device placement
- Utility coordination
- Right-of-way planning

**Deliverables**:
- Roadway plan and profile
- Cross-section drawings
- Intersection design drawings
- Traffic control plans
- Right-of-way exhibits
- Construction quantity estimates

**Standards**: AASHTO Policy on Geometric Design, State DOT Standards, MUTCD, ADA Requirements

**Estimated Hours**: 60-80 hours

---

### CIVIL-003: Earthworks

**Description**: Earthwork design and calculation workflow including cut/fill analysis, mass hauling, and site balancing.

**Key Activities**:
- Existing ground modeling
- Proposed grade modeling
- Cut/fill volume calculations
- Borrow and waste determination
- Mass diagram development
- Haul route planning
- Shrink/swell factor adjustments

**Deliverables**:
- Existing contours and digital terrain model
- Proposed grading plan
- Cut/fill volume reports
- Mass diagram
- Haul quantity calculations
- Balance report

**Standards**: State DOT Earthwork Standards, OSHAExcavation Standards, Professional Survey Requirements

**Estimated Hours**: 30-45 hours

---

### CIVIL-004: Retaining Structures

**Description**: Retaining wall and slope stabilization design workflow covering gravity walls, MSE walls, and soil nail systems.

**Key Activities**:
- Wall type selection and design
- Global stability analysis
- Drainage system design
- Foundation design
- Connection details
- Construction sequencing
- Monitoring and inspection planning

**Deliverables**:
- Retaining wall plans and sections
- Stability analysis reports
- Foundation design calculations
- Drainage details
- Construction specifications
- Inspection and maintenance plan

**Standards**: AASHTO LRFD Bridge Design, State DOT Retaining Wall Standards, NCPI Standards, UBC Requirements

**Estimated Hours**: 35-50 hours

---

### CIVIL-005: Pavement Design

**Description**: Pavement design workflow for flexible and rigid pavements including material selection, structural design, and maintenance planning.

**Key Activities**:
- Subgrade characterization
- Traffic loading analysis
- Pavement type selection
- Structural layer design
- Material specifications
- Life-cycle cost analysis
- Maintenance and rehabilitation planning

**Deliverables**:
- Pavement design report
- Mix design specifications
- Structural section drawings
- Construction specifications
- Life-cycle cost analysis
- Maintenance schedule

**Standards**: AASHTO Guide for Pavement Design, State DOT Pavement Standards, Asphalt Institute Guidelines, ACI Requirements

**Estimated Hours**: 25-35 hours

---

### CIVIL-006: Construction Support

**Description**: Construction support workflow covering staking, inspection, QA/QC, and submittal review throughout construction.

**Key Activities**:
- Construction staking
- Inspection coordination
- QA/QC documentation
- Submittal review
- RFI and shop drawing review
- As-built documentation
- Final acceptance inspection

**Deliverables**:
- Staking coordinates and notes
- Daily inspection reports
- QA/QC test results
- Submittal review comments
- RFI responses
- As-built drawings
- Final inspection checklist

**Standards**: State DOT Construction Standards, OSHA Requirements, Contract Specifications, Project QA Plan

**Estimated Hours**: 40-60 hours

---

## Cross-Discipline Integration

| Discipline | Interface Type | Key Handoff Points |
|------------|----------------|-------------------|
| 00800 (Design) | Design inputs, review coordination | Schematic through CD phases |
| 00825 (Architectural) | Site grading, accessibility | Site plan coordination |
| 00855 (Geotechnical) | Foundation design, stability | Foundation reports, recommendations |
| 00860 (Electrical) | Lighting, traffic signals | Power coordination |
| 00870 (Mechanical) | Utility connections | Plumbing coordination |
| 01000 (Environmental) | Stormwater, erosion control | Environmental permits |
| 00300 (Construction) | Staking, inspection | Construction phase support |

---

## Success Criteria

- [ ] All 6 workflows documented and templated
- [ ] Integration with Civil 3D/AutoCAD platforms
- [ ] Coordination with geotechnical and environmental disciplines
- [ ] Design schedule aligned with project milestones
- [ ] User acceptance testing completed
- [ ] 80% cross-discipline workflow efficiency improvement

---

**Document Version**: 1.0  
**Last Updated**: 2026-04-17
