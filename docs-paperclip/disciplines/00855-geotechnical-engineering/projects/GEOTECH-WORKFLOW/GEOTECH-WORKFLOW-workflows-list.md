---
title: GEOTECH-WORKFLOW Workflows List
discipline: 00855
project: GEOTECH-WORKFLOW
version: 1.0
date: 2026-04-17
---

# GEOTECH-WORKFLOW — Workflows Catalog

## Overview

This document catalogs all workflows for the Geotechnical Engineering discipline (00855), covering site investigation, foundation design, slope stability, earthworks, and construction support activities.

## Workflows Summary

| ID | Workflow Name | Phase | Priority | Status | Complexity |
|----|---------------|-------|----------|--------|------------|
| GEOTECH-001 | Foundation Design | Phase 1 | Critical | Existing | High |
| GEOTECH-002 | Site Investigation | Phase 1 | Critical | New | High |
| GEOTECH-003 | Slope Stability | Phase 2 | High | New | High |
| GEOTECH-004 | Earthworks | Phase 2 | High | New | Medium |
| GEOTECH-005 | Construction Support | Phase 3 | Medium | New | Medium |

---

## Workflow Dependencies

```
GEOTECH-002 (Site Investigation)
    │
    ├── GEOTECH-001 (Foundation Design)
    │
    ├── GEOTECH-003 (Slope Stability)
    │
    └── GEOTECH-004 (Earthworks)
              │
              └── GEOTECH-005 (Construction Support)
```

---

## Detailed Workflow Descriptions

### GEOTECH-001: Foundation Design

**Description**: Comprehensive foundation design workflow covering shallow foundations, deep foundations, and specialized foundation systems based on geotechnical investigation data.

**Key Activities**:
- Review geotechnical investigation reports and soil parameters
- Evaluate foundation options (shallow vs deep)
- Calculate bearing capacity and settlement
- Design foundation dimensions and reinforcement
- Prepare foundation construction drawings and specifications
- Coordinate with structural engineering team

**Deliverables**:
- Foundation design report
- Foundation construction drawings
- Foundation specifications
- Load summary for structural analysis
- Settlement predictions

**Standards**: Eurocode 7 (EN 1997), BS 8004, AASHTO LRFD

**Estimated Hours**: 40-60 hours

---

### GEOTECH-002: Site Investigation

**Description**: Systematic site investigation workflow covering desktop study, field investigation, laboratory testing, and geotechnical reporting for construction projects.

**Key Activities**:
- Conduct desktop study and historical data review
- Plan field investigation scope and methods
- Supervise borehole drilling and sampling
- Coordinate laboratory testing program
- Compile and interpret test results
- Prepare geotechnical baseline report
- Assess ground conditions and groundwater regime

**Deliverables**:
- Site investigation plan
- Borehole logs and field test data
- Laboratory test results
- Geotechnical baseline report (GBR)
- Ground conditions summary
- Contamination assessment

**Standards**: Eurocode 7 (EN 1997), BS 5930, AASHTO R 58

**Estimated Hours**: 60-80 hours

---

### GEOTECH-003: Slope Stability

**Description**: Slope stability analysis and design workflow for natural slopes, cut slopes, and engineered embankments, including seismic considerations.

**Key Activities**:
- Define slope geometry and ground conditions
- Determine soil/rock parameters from investigation data
- Perform stability analysis (limit equilibrium methods)
- Evaluate factor of safety for various loading conditions
- Design slope reinforcement and drainage measures
- Prepare slope stability report and monitoring requirements
- Assess seismic loading effects

**Deliverables**:
- Slope stability analysis report
- Factor of safety calculations
- Reinforcement design drawings
- Drainage system design
- Monitoring and instrumentation plan
- Emergency response procedures

**Standards**: Eurocode 7 (EN 1997), BS 6031, FHWA guidelines

**Estimated Hours**: 35-50 hours

---

### GEOTECH-004: Earthworks

**Description**: Earthworks design and supervision workflow covering excavation, fill, ground improvement, and compaction control for construction projects.

**Key Activities**:
- Assess existing ground conditions and proposed levels
- Design cut and fill sequences
- Specify ground improvement methods where required
- Define compaction specifications and testing frequency
- Prepare earthworks specification documents
- Supervise and monitor earthworks operations
- Manage spoil disposal and import requirements

**Deliverables**:
- Earthworks design report
- Cut and fill schedules
- Ground improvement specifications
- Compaction control procedures
- Earthworks as-built records
- Material balance calculations

**Standards**: Eurocode 7 (EN 1997), BS 6031, TRL guidelines

**Estimated Hours**: 30-45 hours

---

### GEOTECH-005: Construction Support

**Description**: Geotechnical construction support workflow covering works supervision, testing, inspection, and resolution of ground-related issues during construction.

**Key Activities**:
- Review contractor submissions for geotechnical works
- Conduct pre-works briefings and method statement reviews
- Supervise geotechnical construction activities
- Perform or witness field testing (compaction, pile, etc.)
- Respond to requests for information (RFIs)
- Monitor ground conditions and instrumentation
- Prepare progress reports and non-conformance reports
- Verify works against design intent

**Deliverables**:
- Geotechnical construction supervision reports
- Field test results and certificates
- RFI responses
- Non-conformance reports (NCRs)
- Instrumentation monitoring data
- Works completion statements
- As-built documentation review

**Standards**: Eurocode 7 (EN 1997), BS 5930, project specifications

**Estimated Hours**: 50-80 hours (depending on project duration)

---

## Cross-Discipline Integration

| Discipline | Interface Type | Key Handoff Points |
|------------|----------------|-------------------|
| 00800 (Design Management) | Design coordination, review | All phases |
| 00825 (Architectural) | Foundation loads, settlement | Foundation design phase |
| 00835 (Civil) | Earthworks, drainage | Earthworks phase |
| 00850 (Structural) | Foundation design coordination | Foundation design phase |
| 00860 (Electrical) | Ground conditions for earthing | Site investigation phase |
| 00870 (Mechanical) | Equipment foundations | Foundation design phase |
| 00871 (Process) | Equipment pads, sumps | Foundation design phase |

---

## Success Criteria

- [ ] All 5 workflows documented and templated
- [ ] Cross-discipline integration matrix completed
- [ ] Geotechnical standards compliance verified
- [ ] Integration with BIM coordination workflows
- [ ] Construction support procedures operational
- [ ] User acceptance testing completed

---

**Document Version**: 1.0  
**Last Updated**: 2026-04-17
