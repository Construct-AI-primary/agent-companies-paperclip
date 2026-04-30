---
title: Process Design Engineering Procurement Typology
description: PO, SO, WO, services, and goods requirements specific to process simulations, P&IDs, equipment specification, and process safety
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00871_process_engineering/agent-data/domain-knowledge/project-typologies
gigabrain_tags: disciplines, 00871_process_engineering, process-design, project-typology, goods-services
openstinger_context: process-design-procurement, po-wo-so-typology
last_updated: 2026-04-30
related_docs: process-plant, mechanical, epc-contracts, power-systems
---

# Process Design Engineering Procurement Typology

## Sector Overview
Process design engineering procurement covers process simulations, P&ID development, equipment specification, control systems, process safety engineering, and operating procedures. Procurement involves specialized process equipment, control systems, analytical instruments, and engineering services for chemical, petrochemical, refining, and pharmaceutical processes.

## Common PO Types (Purchase Orders for Goods)

| PO Category | Typical Goods | Key Specifications | Lead Times |
|-------------|---------------|-------------------|------------|
| Process Equipment | Reactors, columns, heat exchangers, filters | Process duty spec, material selection, ASME design code | 20-50 weeks |
| Control Systems | DCS, PLC, SCADA, safety instrumented systems | IEC 61511, SIL rating, redundancy requirement, network topology | 16-30 weeks |
| Analytical Instruments | Online analyzers, GC, spectrometers, pH/conductivity | ATEX/IECEx, calibration requirements, sample conditioning | 10-20 weeks |
| Process Valves | Control valves, safety relief valves, rupture discs | API 526/527, relief capacity, set pressure, ASME VIII | 8-16 weeks |
| Heat Transfer | Heat exchangers, condensers, reboilers, coolers | TEMA type, heat duty, LMTD, fouling factor | 16-30 weeks |
| Packaged Units | Filter skids, chemical injection, utility stations | OEM package spec, interface control document, material certs | 16-30 weeks |

## Common SO Tracking Requirements

| Category | SO Focus Areas | Critical SO Verification Points |
|----------|---------------|--------------------------------|
| Process Columns | Tray/packing supply, vessel fabrication, internals | Tray layout, packing height, distributor test |
| DCS/PLC Systems | Hardware delivery, I/O assignment, graphics development | I/O check, control logic test, graphic acceptance |
| Safety Systems | SIF loop design, component selection, proof test | SIL verification, proof test interval, bypass management |
| Heat Exchangers | Tube bundle, shell fabrication, pressure test | Tube expansion test, hydro test, NDE requirements |

## Common WO Types (Work Orders for Services)

| WO Category | Typical Services | Compliance Requirements |
|-------------|-----------------|------------------------|
| Process Simulation | Mass/energy balance, Aspen/Hysys/Pro/II modeling | Steady-state/dynamic model, validated against plant data |
| HAZOP Studies | HAZOP facilitation, LOPA, SIL assignment | IEC 61882, IEC 61508/61511, team competency requirements |
| P&ID Development | P&ID generation, line list, valve schedule, tie-in schedule | ISO 15519, P&ID legend, line designation process |
| Equipment Specification | Data sheet preparation, vendor technical bid evaluation | TEMA/API/ASME design basis, material selection report |
| Operating Procedures | SOP development, startup/shutdown procedures, operating limits | Management of change compliance, procedure review cycle |
| Process Safety | Layer of protection analysis, safety case, hazardous area classification | DSEAR/OHSA PSM, facility siting, quantitative risk assessment |

## Key Goods vs Services Distinctions for Process Design

### Goods (PO Items)
- Process equipment with duty specification and material certification
- Control systems with functional safety compliance and I/O count compliance
- Analytical instruments with hazardous area certification and sample system design
- Packaged units with interface control documentation and OEM test certificates

### Services (WO/Service Order Items)
- Process simulation with model validation and design basis documentation
- HAZOP/LOPA studies with formal facilitation and action close-out management
- P&ID development with line designation and tie-in schedule coordination
- Process safety engineering with risk assessment and safety case preparation

## Project-Specific Procurement Considerations
- **Greenfield Design:** Feedstock specification, technology selection, process yield optimization
- **Debottlenecking:** Constraint identification, capacity increase evaluation, plant modification isolation
- **Process Safety Management:** Hazard identification, risk register, management of change procedures
- **Control Philosophy:** Process control narrative, alarm management, operator interface philosophy
- **Utilities Integration:** Steam balancing, cooling water optimization, hydrogen management, flare system design
- **Commissioning Sequence:** Process flushing, chemical cleaning, catalyst loading, system dry-out
