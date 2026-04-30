---
title: LAND-WORKFLOW Workflows List
discipline: 03000
project: LAND-WORKFLOW
version: 1.0
date: 2026-04-17
---

# LAND-WORKFLOW — Workflows Catalog

## Overview

This document catalogs all workflows for the Landscaping/Sundry discipline (03000), derived from domain knowledge analysis. The landscaping discipline encompasses all exterior works including softworks (planting, turf, irrigation) and hardworks (paving, structures, water features).

## Workflows Summary

| ID | Workflow Name | Phase | Priority | Status | Complexity |
|----|---------------|-------|----------|--------|------------|
| LAND-001 | Landscape Design | Phase 1 | Critical | Pending | High |
| LAND-002 | Irrigation Design | Phase 1 | High | Pending | Medium |
| LAND-003 | Softworks | Phase 2 | High | Pending | Medium |
| LAND-004 | Hardworks | Phase 2 | High | Pending | Medium |

---

## Workflow Dependencies

```
LAND-001 (Landscape Design)
    ├── LAND-002 (Irrigation Design)
    │
    ├── LAND-003 (Softworks)
    │     └── Planting, turf, landscape maintenance
    │
    └── LAND-004 (Hardworks)
          └── Paving, walls, structures, water features

LAND-002 dependencies: LAND-001 (design inputs)
LAND-003 dependencies: LAND-001, LAND-002 (design complete)
LAND-004 dependencies: LAND-001 (site layout, grading)
```

---

## Detailed Workflow Descriptions

### LAND-001: Landscape Design

**Description**: Master planning and detailed design for all landscape works, including site analysis, concept development, planting design, and specification documentation.

**Key Activities**:
- Site analysis and inventory (existing vegetation, soil, topography)
- Concept design development with mood boards and preliminary layouts
- Design development for planting schemes, paths, and features
- Preparation of landscape specifications and plant schedules
- Coordination with architects and other disciplines
- Review and approval processes

**Deliverables**:
- Site analysis report
- Concept design drawings
- Design development package
- Landscape specification document
- Plant schedule and technical data sheets
- Material specifications
- Mood boards and visual presentations

**Standards**: NZS 4400 Series, AS 4419, Local council landscape guidelines, Project BEP

**Estimated Hours**: 60-80 hours (depending on project scope)

---

### LAND-002: Irrigation Design

**Description**: Design of efficient water management systems for landscape areas, including irrigation, drainage, and water feature circulation systems.

**Key Activities**:
- Water requirements assessment and irrigation zoning
- Irrigation system layout and pipe sizing
- Controller and system specification
- Drainage design for landscape areas
- Water feature circulation system design
- Coordination with hydraulic services
- Preparation of irrigation specifications

**Deliverables**:
- Irrigation layout drawings
- Pipe network design calculations
- System specification document
- Controller programming specifications
- Drainage plan
- Water balance calculations
- Material schedules

**Standards**: NZS ISO 3161, Irrigation Association standards, Local water authority requirements

**Estimated Hours**: 24-32 hours (depending on complexity)

---

### LAND-003: Softworks

**Description**: Implementation workflows for soft landscape elements including planting, turfing, and landscape maintenance establishment.

**Key Activities**:
- Soil preparation and amendment procedures
- Plant procurement and supply chain management
- Planting operations and quality standards
- Turf establishment (seed or turf)
- Bioswale and wetland establishment
- Landscape maintenance establishment period
- Plant replacement and defect management

**Deliverables**:
- Softworks methodology statement
- Plant delivery and inspection records
- Planting as-built records
- Turf establishment documentation
- Maintenance schedules and checklists
- Defect liability records

**Standards**: NZS 4400 Series, Landscape contractor standards, Project quality plan

**Estimated Hours**: 40-56 hours (project management)

---

### LAND-004: Hardworks

**Description**: Implementation workflows for hard landscape elements including paving, walls, structures, water features, and furniture.

**Key Activities**:
- Paving layout and edge restraint installation
- Concrete works (paths, slabs, kerbs)
- Retaining wall construction
- Water feature installation
- Furniture and fixture installation
- Surface drainage installation
- Linemarking and sign installation
- Practical completion inspection

**Deliverables**:
- Hardworks methodology statement
- As-built drawings
- Concrete placement records
- Water feature commissioning reports
- Furniture installation checklist
- Defects list and completion sign-off

**Standards**: NZS 3109, NZS 3114, Project quality plan, Structural specifications

**Estimated Hours**: 48-64 hours (project management)

---

## Cross-Discipline Integration

| Discipline | Interface Type | Key Handoff Points |
|------------|---------------|-------------------|
| 00825 (Architectural) | Site layout, building setbacks, entrance features | Design phase, DD, CD phases |
| 00850 (Civil) | Grading, drainage, storm water connections | Design phase, construction |
| 00860 (Electrical) | Landscape lighting, irrigation controllers | Design phase, CD phase |
| 00870 (Mechanical) | Water feature pumps, fountains | Design phase, CD phase |
| 00100 (User Login) | Landscape portal access, inspection workflows | All phases |
| 02200 (Quality Assurance) | QA inspections, defect management | Construction phase |
| 01700 (Logistics) | Plant and material delivery scheduling | Construction phase |

### Integration Matrix

| Workflow | Architectural | Civil | Electrical | Mechanical | QA | Logistics |
|----------|---------------|-------|------------|------------|-----|-----------|
| LAND-001 | Input provider | Grading inputs | Lighting coordination | N/A | N/A | N/A |
| LAND-002 | N/A | Drainage coordination | Controller power | Pump connections | N/A | N/A |
| LAND-003 | N/A | Drainage review | N/A | N/A | Inspection | Delivery scheduling |
| LAND-004 | Feature coordination | Drainage | Lighting install | Pump install | Inspection | Material delivery |

---

## Success Criteria

### Design Phase
- [ ] All landscape design documentation completed and approved
- [ ] Plant schedules validated against availability
- [ ] Irrigation design coordinated with civil drainage
- [ ] Specifications reviewed by quantity surveyor
- [ ] Integration with architectural site plan confirmed

### Construction Phase
- [ ] Softworks implemented per specification
- [ ] Plant survival rate meets contractual requirements (typically 90%+)
- [ ] Hardworks completed to quality standards
- [ ] All defects addressed during defect liability period
- [ ] As-built documentation submitted and approved

### General
- [ ] 80-95% cross-discipline reusability achieved
- [ ] All workflows documented and templated
- [ ] Integration with project management systems
- [ ] Landscape coordination schedule aligned with programme
- [ ] User acceptance testing completed

---

**Document Version**: 1.0  
**Last Updated**: 2026-04-17
