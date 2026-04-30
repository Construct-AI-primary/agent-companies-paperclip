---
title: ARCH-WORKFLOW Workflows List
discipline: 00825
project: ARCH-WORKFLOW
version: 1.0
date: 2026-04-17
---

# ARCH-WORKFLOW — Workflows Catalog

## Overview

This document catalogs all workflows for the Architectural discipline (00825), covering spatial planning, building envelope, interior finishes, fire safety, accessibility, shop drawing review, and handover processes.

## Workflows Summary

| ID | Workflow Name | Phase | Priority | Status | Complexity |
|----|---------------|-------|----------|--------|------------|
| ARCH-001 | Spatial Planning | Phase 1 | Critical | Active | High |
| ARCH-002 | Building Envelope | Phase 1 | Critical | Active | High |
| ARCH-003 | Interior Finishes | Phase 2 | High | Active | Medium |
| ARCH-004 | Fire Safety | Phase 1 | Critical | Active | High |
| ARCH-005 | Accessibility | Phase 2 | High | Active | Medium |
| ARCH-006 | Shop Drawing Review | Phase 3 | High | Active | Medium |
| ARCH-007 | Handover | Phase 3 | Critical | Active | High |

---

## Workflow Dependencies

```
ARCH-001 (Spatial Planning)
    ├── ARCH-002 (Building Envelope)
    │    └── ARCH-004 (Fire Safety)
    ├── ARCH-003 (Interior Finishes)
    │    └── ARCH-005 (Accessibility)
    │
    └── ARCH-006 (Shop Drawing Review)
         └── ARCH-007 (Handover)

ARCH-005 (Accessibility) ← All phases (continuous compliance)
```

---

## Detailed Workflow Descriptions

### ARCH-001: Spatial Planning

**Description**: Comprehensive space programming and spatial arrangement workflow ensuring optimal utilization of building areas while meeting functional requirements and regulatory standards.

**Key Activities**:
- Conduct space requirements analysis with stakeholders
- Develop space allocation matrix by function and department
- Create stacking and zoning diagrams
- Coordinate with structural and MEP for column-free spaces
- Optimize circulation paths and wayfinding

**Deliverables**:
- Space programme document
- Area schedule (Gross/Net ratios)
- Stacking diagram
- Zoning plan
- Circulation diagram

**Standards**: BOMA 2017, Client briefing requirements, Local planning codes

**Estimated Hours**: 40-60 hours

---

### ARCH-002: Building Envelope

**Description**: Design and specification of the building exterior envelope including walls, windows, roofing, and waterproofing systems to ensure weather-tightness, thermal performance, and aesthetic quality.

**Key Activities**:
- Develop facade design concepts and materiality
- Specify window wall ratios and glazing systems
- Coordinate curtain wall/ window wall details
- Specify roofing and waterproofing systems
- Coordinate with structural for facade support systems
- Conduct thermal and moisture analysis

**Deliverables**:
- Facade concept drawings
- Envelope specification document
- Window schedule
- Detail drawings (1:5, 1:2, 1:1)
- Material specifications
- Thermal performance reports

**Standards**: ASTM E283, E331, AAMA 501, ASHRAE 90.1, Local building codes

**Estimated Hours**: 60-80 hours

---

### ARCH-003: Interior Finishes

**Description**: Selection and specification of interior finish materials, systems, and details for floors, walls, ceilings, and millwork to achieve design intent while meeting performance and budget requirements.

**Key Activities**:
- Develop finish schedule by space type
- Select finish materials with samples and mockups
- Specify acoustic wall and ceiling systems
- Coordinate millwork and built-in elements
- Specify ceiling systems and light fixtures integration
- Conduct finish coordination with MEP penetrations

**Deliverables**:
- Finish schedule
- Material specifications
- Finish samples and mockups
- Millwork drawings
- Ceiling plans with integration details
- Acoustic specifications

**Standards**: Specifiers' Reference, Material standards (UL, ASTM), Sustainable material ratings (LEED, BREEAM)

**Estimated Hours**: 35-50 hours

---

### ARCH-004: Fire Safety

**Description**: Comprehensive fire protection design workflow including egress design, fire compartmentation, fire-rated construction, and coordination with fire suppression and detection systems.

**Key Activities**:
- Develop fire compartmentation strategy
- Design egress routes and exit configurations
- Specify fire-rated wall, floor, and ceiling assemblies
- Coordinate with fire suppression systems
- Coordinate with fire detection and alarm systems
- Prepare fire safety justification report

**Deliverables**:
- Fire compartmentation plan
- Egress diagram
- Fire-rated assembly schedule
- Door schedule with fire ratings
- Firestopping detail drawings
- Fire safety report

**Standards**: NFPA 101, NFPA 80, Local fire code, Building code section on fire safety, IBC occupancy requirements

**Estimated Hours**: 45-65 hours

---

### ARCH-005: Accessibility

**Description**: Universal design and accessibility compliance workflow ensuring all spaces and elements meet applicable accessibility codes and promote inclusive design for all users.

**Key Activities**:
- Conduct accessibility code analysis
- Design accessible routes and wayfinding
- Specify accessible fixtures and fittings
- Coordinate accessible parking and drop-off
- Design accessible vertical transportation
- Conduct accessibility review and gap analysis

**Deliverables**:
- Accessibility narrative
- Accessible route drawings
- Accessible fixture schedule
- Accessible parking layout
- Elevator/lift specifications
- Accessibility compliance matrix

**Standards**: ADA Standards, ABA Accessibility Guidelines, Local accessibility codes, Universal Design principles

**Estimated Hours**: 30-45 hours

---

### ARCH-006: Shop Drawing Review

**Description**: Review and approval workflow for architectural shop drawings, mockups, and sample submittals ensuring alignment with design intent and specification requirements.

**Key Activities**:
- Establish submittal schedule and log
- Review shop drawings for compliance
- Conduct mockup reviews
- Verify finish samples against specifications
- Track submittal revisions and resubmissions
- Issue approval/rejection with comments

**Deliverables**:
- Submittal register
- Shop drawing review comments
- Mockup approval reports
- Sample approval log
- Submittal transmittal records
- Revision tracking log

**Standards**: Project specifications, AIA G201/G202, Submittal procedures, Contract requirements

**Estimated Hours**: 25-40 hours

---

### ARCH-007: Handover

**Description**: Project completion and handover workflow including punch list management, commissioning support, O&M manual coordination, and final documentation for building ownership transition.

**Key Activities**:
- Conduct architectural punch list inspection
- Coordinate deficiency resolution
- Review O&M manuals for architectural items
- Compile warranty documentation
- Conduct pre-handover walkthrough
- Facilitate building ownership transition
- Archive project documentation

**Deliverables**:
- Punch list report
- Deficiency resolution log
- O&M manual (architectural sections)
- Warranty documentation
- As-built drawings confirmation
- Handover certificate
- Project archive

**Standards**: Project closeout requirements, Contract closeout procedures, AIA G901/G902, Local occupancy requirements

**Estimated Hours**: 30-45 hours

---

## Cross-Discipline Integration

| Discipline | Interface Type | Key Handoff Points | Coordination Notes |
|------------|----------------|-------------------|---------------------|
| 00800 (Design) | Design inputs, design review | All phases | Primary coordination for design intent |
| 00850 (Civil) | Site boundary, grading | Site plan phases | Building footprint coordination |
| 00860 (Electrical) | Lighting, power, controls | All phases | Fixture integration, emergency lighting |
| 00870 (Mechanical) | HVAC, plumbing | MEP coordination phases | Shaft sizing, ceiling space coordination |
| 00300 (Construction) | Shop drawings, construction | CD, CA phases | Submittal review, site visits |
| 00250 (Commercial) | Cost management | All phases | Budget tracking, value engineering |
| 00400 (Contracts) | Contract compliance | All phases | Scope verification |
| 00900 (Document Control) | Document management | All phases | Drawing and specification control |

---

## Success Criteria

- [ ] 100% design documentation completion per phase
- [ ] All cross-discipline coordination completed with sign-off
- [ ] All regulatory approvals obtained (building permit, occupancy)
- [ ] All shop drawings reviewed and approved within contract timeframes
- [ ] Punch list completion with 95%+ first-pass resolution rate
- [ ] Complete handover documentation package delivered
- [ ] All workflows documented and templated for reuse
- [ ] User acceptance testing completed for all ARCH workflows
- [ ] Integration with BIM coordination platform (Revit, BIM 360)
- [ ] Accessibility compliance verification completed

---

**Document Version**: 1.0  
**Last Updated**: 2026-04-17
