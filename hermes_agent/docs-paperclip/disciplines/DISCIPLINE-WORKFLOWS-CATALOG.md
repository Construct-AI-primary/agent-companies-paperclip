---
title: Discipline Workflows Master Catalog
description: Comprehensive catalog of all discipline-specific workflows derived from domain knowledge analysis
author: Paperclip Workflow System
version: 1.0
date: 2026-04-17
---

# Discipline Workflows Master Catalog

## Overview

This document catalogs all discipline workflows derived from domain knowledge analysis of the specified engineering disciplines. Each workflow represents a core activity performed by discipline staff and will be implemented as a Paperclip project with associated issues.

## Disciplines Covered

| Code | Discipline | Workflows | Status |
|------|------------|----------|--------|
| 00800 | Design | 8 | ✅ Complete |
| 00825 | Architectural | 7 | ✅ Complete |
| 00835 | Chemical Engineering | 6 | ✅ Complete |
| 00850 | Civil Engineering | 6 | ✅ Complete |
| 00855 | Geotechnical Engineering | 5 | ✅ Complete |
| 00860 | Electrical Engineering | 6 | ✅ Complete |
| 00870 | Mechanical Engineering | 5 | ✅ Complete |
| 00871 | Process Engineering | 5 | ✅ Complete |
| 01000 | Environmental | 6 | ✅ Complete |
| 01700 | Logistics | 5 | ✅ Complete |
| 02400 | Safety | 5 | ✅ Complete |
| 02500 | Security | 4 | ✅ Complete |
| 03000 | Landscaping/Sundry | 4 | ✅ Complete |

---

## 00800 - Design Management

### Derived From
- Domain Knowledge: `docs-construct-ai/disciplines/00800_design/agent-data/domain-knowledge/00800_DOMAIN-KNOWLEDGE.MD`

### Staff Activities and Workflows

| Workflow ID | Workflow Name | Description | Key Deliverables |
|-------------|---------------|-------------|------------------|
| DESIGN-001 | Design Coordination & Interface Management | Multi-discipline interface management | Interface register, coordination meeting minutes, RACI matrix |
| DESIGN-002 | Interdisciplinary Design Review (IDR) | Structured cross-discipline review process | IDR reports, comment registers, approval records |
| DESIGN-003 | Design Programme & Deliverables | Schedule management and deliverable tracking | Design schedule, deliverable register, progress reports |
| DESIGN-004 | Design Change Control | Formal change management process | Change requests, impact assessments, revision logs |
| DESIGN-005 | Engineering Discipline Integration Matrix | Cross-discipline dependency mapping | Integration matrix, interface diagrams |
| DESIGN-006 | Multi-Discipline Clash Detection & Resolution | BIM-based spatial coordination | Clash reports, resolution logs, coordination drawings |
| DESIGN-007 | Design Team Communication & Collaboration | Communication protocol management | Meeting schedules, distribution lists, collaboration protocols |
| DESIGN-008 | RFI Response Management | Technical query handling | RFI register, response templates, turnaround tracking |

### Key Standards
- ISO 19650 (BIM Information Management)
- PAS 1192-2 (Capital/Delivery Phase)
- AIA E202 (BIM Protocol Exhibit)
- Client-specific DEP and BEP requirements

### Project Location
`docs-paperclip/disciplines/00800-design/projects/DESIGN-WORKFLOW/`

---

## 00825 - Architectural

### Derived From
- Domain Knowledge: `docs-construct-ai/disciplines/00825_architectural/agent-data/domain-knowledge/00825_DOMAIN-KNOWLEDGE.MD`

### Staff Activities and Workflows

| Workflow ID | Workflow Name | Description | Key Deliverables |
|-------------|---------------|-------------|------------------|
| ARCH-001 | Spatial Planning & Programming | Functional space layout and adjacencies | Space program, adjacencies matrix, occupancy calculations |
| ARCH-002 | Building Envelope Design | Façade, roofing, glazing specification | Envelope details, thermal calculations, material specs |
| ARCH-003 | Interior Finishes Specification | Floor, wall, ceiling treatment selection | Finish schedules, material specs, sample boards |
| ARCH-004 | Fire Safety & Compartmentation | Fire rating and egress design | Fire compartment drawings, means of egress plans |
| ARCH-005 | Accessibility Compliance | ADA/universal design implementation | Accessible route plans, fixture schedules |
| ARCH-006 | Shop Drawing & Submittal Review | Contractor submission management | Review registers, approval stamps, comment logs |
| ARCH-007 | Architectural Handover & Documentation | As-built documentation compilation | As-built drawings, O&M manuals, warranty registers |

### Key Standards
- ISO 21542 (Accessibility and Usability)
- NFPA 101 (Life Safety Code)
- LEED/Green Star (Sustainability)
- Local building codes

### Project Location
`docs-paperclip/disciplines/00825-architectural/projects/ARCH-WORKFLOW/`

---

## 00835 - Chemical Engineering

### Derived From
- Domain Knowledge: `docs-construct-ai/disciplines/00835_chemical-engineering/agent-data/domain-knowledge/00835_DOMAIN-KNOWLEDGE.MD`

### Staff Activities and Workflows

| Workflow ID | Workflow Name | Description | Key Deliverables |
|-------------|---------------|-------------|------------------|
| CHEM-001 | Process Safety Management | PSM program implementation | PHA reports, MI programs, operating procedures |
| CHEM-002 | Process Flow Diagram Development | PFD creation and validation | PFDs, material/energy balance sheets |
| CHEM-003 | P&ID Development | Piping and instrumentation design | P&IDs, instrument index, loop diagrams |
| CHEM-004 | Equipment Sizing & Specification | Reactors, columns, heat exchangers | Equipment datasheets, specifications |
| CHEM-005 | HAZOP Study Facilitation | Hazard and operability analysis | HAZOP reports, action registers |
| CHEM-006 | Commissioning & Start-up | Pre-commissioning through handover | Commissioning procedures, performance test reports |

### Key Standards
- API 520/521 (Pressure Relief)
- API 650 (Storage Tanks)
- ASME B31.3 (Process Piping)
- ANSI/ISA 84 (SIS)
- OSHA PSM 1910.119

### Project Location
`docs-paperclip/disciplines/00835-chemical-engineering/projects/CHEMICAL-WORKFLOW/`

---

## 00850 - Civil Engineering

### Derived From
- Domain Knowledge: `docs-construct-ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/00850_DOMAIN-KNOWLEDGE.MD`

### Staff Activities and Workflows

| Workflow ID | Workflow Name | Description | Key Deliverables |
|-------------|---------------|-------------|------------------|
| CIVIL-001 | Stormwater Management Design | Drainage and runoff control | Stormwater calculations, drainage layouts |
| CIVIL-002 | Road & Highway Design | Pavement and alignment design | Road layouts, cross-sections, pavement designs |
| CIVIL-003 | Earthworks Specification | Cut/fill planning and compaction | Earthworks specs, swell/shrink calculations |
| CIVIL-004 | Retaining Structure Design | Wall and slope stabilization | Retaining wall calcs, stability analysis |
| CIVIL-005 | Pavement Design | Flexible and rigid pavement systems | Pavement designs, traffic loading analysis |
| CIVIL-006 | Civil Works Construction Support | Shop drawing review and inspection | NCRs, inspection reports, test results |

### Key Standards
- AASHTO (Pavement Design)
- ASTM D series (Testing)
- Local road authority requirements
- Project specifications

### Project Location
`docs-paperclip/disciplines/00850-civil-engineering/projects/CIVIL-WORKFLOW/`

---

## 00855 - Geotechnical Engineering

### Derived From
- Domain Knowledge: `docs-construct-ai/disciplines/00855_geotechnical-engineering/agent-data/domain-knowledge/00855_DOMAIN-KNOWLEDGE.MD`

### Staff Activities and Workflows

| Workflow ID | Workflow Name | Description | Key Deliverables |
|-------------|---------------|-------------|------------------|
| GEOTECH-001 | Foundation Design | Shallow and deep foundation analysis | Foundation calcs, bearing capacity reports |
| GEOTECH-002 | Site Investigation Management | Boreholes, CPT, laboratory testing | SI report, geotechnical model |
| GEOTECH-003 | Slope Stability Analysis | Limit equilibrium and factor of safety | Stability reports, monitoring plans |
| GEOTECH-004 | Earthworks & Ground Improvement | Fill specification, improvement methods | Earthworks specs, treatment plans |
| GEOTECH-005 | Geotechnical Construction Support | Foundation inspection, monitoring | Inspection reports, monitoring data |

### Key Standards
- EN 1997 (Eurocode 7)
- ASTM D series
- BS 5930 (Site Investigation)

### Project Location
`docs-paperclip/disciplines/00855-geotechnical-engineering/projects/GEOTECH-WORKFLOW/`

---

## 00860 - Electrical Engineering

### Derived From
- Domain Knowledge: `docs-construct-ai/disciplines/00860_electrical-engineering/agent-data/domain-knowledge/00860_DOMAIN-KNOWLEDGE.MD`

### Staff Activities and Workflows

| Workflow ID | Workflow Name | Description | Key Deliverables |
|-------------|---------------|-------------|------------------|
| ELEC-001 | Electrical Power Distribution | HV/LV distribution design | Single-line diagrams, cable schedules |
| ELEC-002 | Traffic Signals & ITS | Intelligent transportation systems | Traffic signal designs, ITS layouts |
| ELEC-003 | Lighting Design | Interior and exterior illumination | Lighting calcs, luminaire schedules |
| ELEC-004 | Protection & Coordination | Relay settings and selectivity | Coordination studies, protection diagrams |
| ELEC-005 | Generator & UPS Systems | Standby power design | Generator specs, UPS calcs |
| ELEC-006 | Electrical Construction Support | Inspection and testing oversight | ITPs, test results, commissioning reports |

### Key Standards
- IEC 60364 (Electrical Installations)
- NFPA 70 (NEC)
- IEEE Buff Book (Protection)
- Local utility requirements

### Project Location
`docs-paperclip/disciplines/00860-electrical-engineering/projects/ELEC-WORKFLOW/`

---

## 00870 - Mechanical Engineering

### Derived From
- Domain Knowledge: `docs-construct-ai/disciplines/00870_mechanical-engineering/agent-data/domain-knowledge/00870_DOMAIN-KNOWLEDGE.MD`

### Staff Activities and Workflows

| Workflow ID | Workflow Name | Description | Key Deliverables |
|-------------|---------------|-------------|------------------|
| MECH-001 | HVAC System Design | Heating, ventilation, air conditioning | HVAC calcs, system layouts |
| MECH-002 | Plumbing & Drainage | Water supply and waste systems | Plumbing layouts, pipe sizing calcs |
| MECH-003 | Fire Protection Systems | Sprinkler and suppression design | Sprinkler calcs, system layouts |
| MECH-004 | Equipment Selection & Specification | Mechanical equipment procurement | Equipment specs, datasheets |
| MECH-005 | Mechanical Construction Support | Installation oversight and testing | NCRs, testing reports, commissioning docs |

### Key Standards
- ASHRAE Standards
- NFPA 13/14/20 (Fire Protection)
- UPC/UPC (Plumbing)
- SMACNA (Ductwork)

### Project Location
`docs-paperclip/disciplines/00870-mechanical-engineering/projects/MECH-WORKFLOW/`

---

## 00871 - Process Engineering

### Derived From
- Domain Knowledge: `docs-construct-ai/disciplines/00871_process-engineering/agent-data/domain-knowledge/00871_DOMAIN-KNOWLEDGE.MD`

### Staff Activities and Workflows

| Workflow ID | Workflow Name | Description | Key Deliverables |
|-------------|---------------|-------------|------------------|
| PROCESS-001 | Control System Design | DCS/SIS architecture and configuration | Control narratives, loop descriptions |
| PROCESS-002 | Piping Design | Pipe routing and support design | Piping layouts, support calcs |
| PROCESS-003 | Plant Layout Design | Equipment and infrastructure arrangement | Plot plans, layout drawings |
| PROCESS-004 | Utility Systems Design | Steam, compressed air, cooling water | Utility balance diagrams, specs |
| PROCESS-005 | Process Construction Support | Pre-commissioning and commissioning | P&ID checkouts, loop verification |

### Key Standards
- ISA 5.1 (Instrumentation Symbols)
- ISA 84 (Safety Instrumented Systems)
- ASME B31.3 (Process Piping)
- Project specifications

### Project Location
`docs-paperclip/disciplines/00871-process-engineering/projects/PROCESS-WORKFLOW/`

---

## 01000 - Environmental Management

### Derived From
- Domain Knowledge: `docs-construct-ai/disciplines/01000_environmental/agent-data/domain-knowledge/01000_DOMAIN-KNOWLEDGE.MD`

### Staff Activities and Workflows

| Workflow ID | Workflow Name | Description | Key Deliverables |
|-------------|---------------|-------------|------------------|
| ENV-001 | Environmental Impact Assessment | EIA compliance and documentation | EIA reports, impact registers |
| ENV-002 | EMP Development | Environmental management plan creation | EMP documents, aspect registers |
| ENV-003 | Waste Management | Waste minimization and disposal tracking | Waste registers, disposal certificates |
| ENV-004 | Environmental Monitoring | Air, water, noise monitoring programs | Monitoring reports, trend analysis |
| ENV-005 | Rehabilitation Planning | Progressive and final rehabilitation | Rehab plans, planting schedules |
| ENV-006 | Environmental Compliance Auditing | Regulatory compliance verification | Audit reports, NCR registers |

### Key Standards
- ISO 14001 (EMS)
- IFC EHS Guidelines
- Local environmental regulations
- Project-specific EIA requirements

### Project Location
`docs-paperclip/disciplines/01000-environmental/projects/ENV-WORKFLOW/`

---

## 01700 - Logistics

### Derived From
- Domain Knowledge: `docs-construct-ai/disciplines/01700_logistics/agent-data/domain-knowledge/01700_DOMAIN-KNOWLEDGE.MD`

### Staff Activities and Workflows

| Workflow ID | Workflow Name | Description | Key Deliverables |
|-------------|---------------|-------------|------------------|
| LOG-001 | Material Management | Procurement through delivery tracking | MRs, delivery schedules, receipt records |
| LOG-002 | Equipment Mobilization | Plant and equipment deployment | Mobilization plans, inspection reports |
| LOG-003 | Warehousing & Inventory | Storage and stock management | Stock registers, bin cards |
| LOG-004 | Transport & Haulage | Equipment and material movement | Haulage schedules, route assessments |
| LOG-005 | Demobilization Planning | Equipment and material removal | Demob plans, close-out checklists |

### Key Standards
- ISO 9001 (Quality Management)
- Project logistics procedures
- Local transport regulations
- Site access requirements

### Project Location
`docs-paperclip/disciplines/01700-logistics/projects/LOG-WORKFLOW/`

---

## 02400 - Safety

### Derived From
- Domain Knowledge: `docs-construct-ai/disciplines/02400_safety/agent-data/domain-knowledge/02400_DOMAIN-KNOWLEDGE.MD`

### Staff Activities and Workflows

| Workflow ID | Workflow Name | Description | Key Deliverables |
|-------------|---------------|-------------|------------------|
| SAFETY-001 | Hazard Identification & Risk Assessment | JHA, JSA, risk register development | Risk assessments, hazard registers |
| SAFETY-002 | Permit to Work System | PTW administration and control | Permit registers, PTW procedures |
| SAFETY-003 | Incident Investigation | Accident/incident analysis and reporting | Investigation reports, corrective actions |
| SAFETY-004 | Emergency Response Planning | ERP development and drills | ERP documents, drill records |
| SAFETY-005 | Safety Compliance Auditing | Regulatory and procedural compliance | Audit reports, non-conformance registers |

### Key Standards
- OSHA 1926/1910 (Construction/General Industry)
- ISO 45001 (OH&S Management)
- NFPA 70E (Electrical Safety)
- Project SHEQ requirements

### Project Location
`docs-paperclip/disciplines/02400-safety/projects/SAFETY-WORKFLOW/`

---

## 02500 - Security

### Derived From
- Domain Knowledge: `docs-construct-ai/disciplines/02500_security/agent-data/domain-knowledge/02500_DOMAIN-KNOWLEDGE.MD`

### Staff Activities and Workflows

| Workflow ID | Workflow Name | Description | Key Deliverables |
|-------------|---------------|-------------|------------------|
| SEC-001 | Threat & Risk Assessment | Security vulnerability analysis | Risk assessments, threat registers |
| SEC-002 | Access Control Management | Personnel and vehicle access | Access control procedures, visitor logs |
| SEC-003 | Security Systems Design | CCTV, alarms, barriers | Security system specs, layouts |
| SEC-004 | Security Operations | Patrol and surveillance management | Patrol schedules, incident reports |

### Key Standards
- ISO 22301 (Business Continuity)
- ASIS/SHRM guidelines
- Local security regulations
- Project security requirements

### Project Location
`docs-paperclip/disciplines/02500-security/projects/SEC-WORKFLOW/`

---

## 03000 - Landscaping/Sundry

### Derived From
- Domain Knowledge: `docs-construct-ai/disciplines/03000_landscaping/agent-data/domain-knowledge/03000_DOMAIN-KNOWLEDGE.MD`

### Staff Activities and Workflows

| Workflow ID | Workflow Name | Description | Key Deliverables |
|-------------|---------------|-------------|------------------|
| LAND-001 | Landscape Design | Planting and hardworks design | Landscape plans, plant schedules |
| LAND-002 | Irrigation System Design | Watering system planning | Irrigation calcs, system layouts |
| LAND-003 | Softworks Implementation | Plant installation and establishment | Planting specs, maintenance plans |
| LAND-004 | Hardworks Construction | Paving, structures, water features | Construction details, specs |

### Key Standards
- Local landscaping standards
- Native plant guidelines
- Irrigation efficiency standards
- Project specifications

### Project Location
`docs-paperclip/disciplines/03000-landscaping/projects/LAND-WORKFLOW/`

---

## Document Generation Templates

Each discipline workflow project contains:

### Directory Structure
```
{PROJECT}/
├── project.md                           ← Project definition
├── workflows-list.md                     ← Workflows catalog
├── implementation.md                     ← Implementation plan
├── discipline_workflow_conversion_procedure.md  ← Desktop/Mobile procedures
├── knowledge/
│   └── PAGE-KNOWLEDGE.md                 ← Discipline knowledge base
├── research/
│   └── {WORKFLOW}-research.md            ← Per-workflow research
├── desktop/
│   ├── issues/
│   │   └── {CODE}-{workflow-name}.md     ← Individual workflow issues
│   └── ISSUE-GENERATION-STATUS.md
└── mobile/
    ├── issues/
    └── ISSUE-GENERATION-STATUS.md
```

### File Templates

1. **{PROJECT}-workflows-list.md** - Workflows catalog with descriptions and dependencies
2. **{PROJECT}-implementation.md** - Implementation plan with phases and timelines
3. **discipline_workflow_conversion_procedure.md** - Desktop/Mobile conversion procedures
4. **{CODE}-{workflow-name}.md** - Individual workflow issue template

---

## Implementation Notes

### Cross-Discipline Dependencies
- Design (00800) coordinates all discipline workflows
- Safety (02400) interfaces with all field activities
- Environmental (01000) interfaces with construction and commissioning
- Geotechnical (00855) provides input to Civil (00850) and Foundation design

### Workflow Integration Points
Each workflow documents:
- Upstream inputs required
- Downstream outputs provided
- Cross-discipline interfaces
- Key handoff points

---

**Document Version**: 1.0  
**Last Updated**: 2026-04-17  
**Generated By**: Paperclip Workflow System
