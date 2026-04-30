---
title: Data Center Procurement Typology
description: PO, SO, WO, services, and goods requirements specific to data center infrastructure, cooling, power, rack systems, and cabling projects
version: 1.0
memory_layer: durable_knowledge
para_section: docs_paperclip/knowledge-disciplines/02050-information-technology
gigabrain_tags: disciplines, 02050-information-technology, data-center, project-typology, goods-services
openstinger_context: data-center-procurement, po-wo-so-typology
last_updated: 2026-04-30
related_docs:
  - docs_paperclip/knowledge-disciplines/02050-information-technology/0010_ENTERPRISE-IT.MD
  - docs_paperclip/knowledge-disciplines/PROJECT-TYPOLOGIES-INDEX.MD
---

# Data Center Project Procurement Typology

## Sector Overview
Data center projects encompass facility construction, power infrastructure, cooling systems, rack layouts, structured cabling, fire suppression, and DCIM deployment. Procurement involves long-lead mechanical and electrical equipment with strict redundancy and uptime requirements.

## Common PO Types (Purchase Orders for Goods)

| PO Category | Typical Goods | Key Specifications | Lead Times |
|-------------|---------------|-------------------|------------|
| UPS Systems | UPS modules, batteries, switchgear, PDU, STS | N+1 redundancy, runtime minutes, efficiency %, footprint | 16-30 weeks |
| Cooling Equipment | CRAC/CRAH units, chillers, cooling towers, in-row coolers | Cooling capacity (kW), airflow CFM, redundancy, efficiency | 12-24 weeks |
| Server Racks | Server cabinets, hot/cold aisle containment, cable management | Size (42U/48U), load capacity, lock types, airflow management | 6-12 weeks |
| Power Distribution | MV/LV switchgear, transformers, generators, ATS | kVA rating, voltage, transfer time, fuel capacity | 20-40 weeks |
| Structured Cabling | Fiber optic (OM3/OM4/OS2), CAT6A/8, patch panels, MPO cassettes | Insertion loss, bandwidth rating, fire rating, polarity | 4-8 weeks |
| Fire Suppression | FM-200/Novec systems, VESDA, pre-action sprinklers | Suppression agent, detection zones, discharge time, certifications | 12-20 weeks |
| DCIM/Monitoring | DCIM software, sensors (temp/humidity/power), BMS | Sensor accuracy, integration APIs, scalability, reporting | 4-12 weeks |

## Common SO Tracking Requirements

| Category | SO Focus Areas | Critical SO Verification Points |
|----------|---------------|--------------------------------|
| UPS/Battery Systems | Equipment manufacturing, battery formation | FAT, battery load test, warranty registration |
| Cooling Equipment | Factory testing, refrigerant charging | Factory witness test, refrigerant compliance, pressure test |
| Generators | Engine testing, load bank testing | EPA emissions cert, load bank test report, fuel consumption curves |
| Cabling | Cable manufacturing, termination | Fluke test results, insertion loss, return loss |

## Common WO Types (Work Orders for Services)

| WO Category | Typical Services | Compliance Requirements |
|-------------|-----------------|------------------------|
| Installation | Rack installation, cabling, equipment commissioning | OEM procedures, change management, labeling standards |
| Commissioning | Integrated systems testing, load bank testing, BMS verification | Commissioning plan, witness testing, handover documentation |
| Migration | Server migration, storage migration, network cutover | Migration plan, rollback procedures, downtime approval |
| Maintenance | PM on UPS/CRAC/generators, battery testing, cable management | OEM maintenance schedules, safety procedures, documentation |
| Auditing | Energy efficiency audit, capacity planning, compliance audit | TIA-942, Uptime Institute, SOC2, ISO 27001 |

## Key Goods vs Services Distinctions for Data Center

### Goods (PO Items)
- UPS with battery lifecycle management and warranty requirements
- Cooling equipment with redundancy and efficiency specifications
- Structured cabling with performance testing and certification
- Fire suppression systems with code compliance and inspection requirements

### Services (WO/Service Order Items)
- Installation with OEM-certified technicians and quality assurance
- Commissioning with integrated systems testing against design specifications
- Migration with change management and rollback procedures
- Maintenance with SLA commitments (response time, parts availability)

## Project-Specific Procurement Considerations
- **Greenfield Data Center:** Power utility lead times, cooling system selection, redundancy design (2N/N+1), security perimeter
- **Colocation Deployment:** Cross-connect lead times, cage installation, power circuit provisioning, meet-me-room access
- **Data Center Retrofit:** Existing infrastructure compatibility, phased deployment, hot/cold aisle containment retrofit, raised floor loading
- **Tier III/IV Facilities:** Fault-tolerant design, concurrent maintainability, generator testing, battery bank sizing
- **Edge Data Centers:** Compact UPS, remote monitoring, modular cooling, limited space optimization