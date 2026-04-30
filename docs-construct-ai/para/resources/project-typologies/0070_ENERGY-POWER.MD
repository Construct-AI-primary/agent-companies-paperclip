---
title: Energy & Power Project Typology
description: Reference documentation for AI agents working on energy and power generation construction projects
author: Construct AI Memory System Team
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/para/resources/project-typologies
gigabrain_tags: resources, project-typologies, energy, power, solar, wind, hydro, transmission, substations
openstinger_context: energy-power-sector, project-classification
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/para/resources/project-typologies/0000_PROJECT-TYPOLOGIES-INDEX.MD
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/00850_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00860_electrical-engineering/para-index.md
---

# Energy & Power Project Typology

## Sector Overview

Energy and power construction encompasses the infrastructure required to generate, transmit, and distribute electrical power. These projects range from utility-scale power plants and large transmission corridors to distributed generation systems and energy storage. They are characterized by high capital intensity, complex regulatory environments, grid integration requirements, and increasing emphasis on decarbonization.

### Sub-Sectors

| Sub-Sector | Description | Examples |
|-----------|-------------|----------|
| **Thermal Power** | Combustion-based electricity generation | Combined cycle gas turbine (CCGT), coal-fired, gas reciprocating engines |
| **Solar PV** | Photovoltaic electricity generation | Utility-scale solar farms, rooftop solar, floating PV, concentrated solar power (CSP) |
| **Wind Power** | Wind-driven electricity generation | Onshore wind farms, offshore wind farms |
| **Hydropower** | Water-driven electricity generation | Large dams, run-of-river, pumped storage |
| **Nuclear** | Nuclear fission-based electricity generation | Pressurized water reactors (PWR), SMRs (Small Modular Reactors) |
| **Energy Storage** | Grid-scale energy storage systems | Battery storage (BESS), pumped hydro, compressed air |
| **Transmission & Distribution** | Power delivery infrastructure | Substations, transmission lines, distribution networks |
| **Hydrogen** | Hydrogen production and utilization | Electrolysis plants, hydrogen storage, fuel cells |

## Typical Project Scale and Budget

| Project Category | Typical Budget | Duration | Workforce Peak |
|-----------------|----------------|----------|----------------|
| CCGT power plant (500 MW) | $400M – $1B | 30–48 months | 500–2,000 |
| Solar PV farm (50–200 MWdc) | $40M – $200M | 6–18 months | 100–500 |
| Concentrated Solar Power (100 MW) | $500M – $1.5B | 30–48 months | 500–1,500 |
| Onshore wind farm (50–200 MW) | $80M – $300M | 12–24 months | 200–600 |
| Offshore wind farm (400–1,000 MW) | $1B – $5B+ | 36–72 months | 1,000–3,000 |
| Large hydropower (100–1,000 MW) | $200M – $5B+ | 48–120 months | 1,000–5,000 |
| Pumped storage (1,000–2,000 MW) | $500M – $2B | 60–96 months | 500–2,000 |
| Nuclear power plant (1,000 MW) | $5B – $15B+ | 60–120 months | 2,000–8,000 |
| Battery Storage (100 MWh) | $30M – $100M | 6–12 months | 50–200 |
| Substation (HV / EHV) | $10M – $200M | 12–36 months | 100–500 |
| Transmission Line (per km) | $0.5M – $5M per km | 24–60 months | 100–400 |

## Regulatory and Compliance Regime

### Key Standards and Codes

| Category | Standards |
|----------|-----------|
| Power Generation | IEEE, IEC, NERC reliability standards, local grid codes |
| Solar PV | IEC 61215, IEC 61730, UL 1703, NEC (PV systems) |
| Wind Power | IEC 61400 series, GL/DNV-GL certification |
| Hydropower | ICOLD guidelines, FERC (US), local hydropower regulations |
| Nuclear | IAEA safety standards, NRC (US), ONR (UK), local nuclear regulations |
| Transmission | IEC, IEEE, CIGRE, NERC |
| Electrical Safety | NFPA 70 (NEC), IEC 60364, local electrical codes |
| Environmental | ISO 14001, IFC Performance Standards, local environmental laws |

### Permitting Requirements

- Environmental Impact Assessment (EIA) for all major power projects
- Construction and generation permits from energy regulator
- Grid connection approval and interconnection agreement
- Land use / right-of-way for solar, wind, and transmission
- Water use permits (thermal power cooling, hydropower)
- Aviation clearance (wind farms, tall structures)
- Noise permits (especially for wind)
- Nuclear licensing (extensive multi-stage regulatory process)

## Typical Project Delivery Methods

| Method | Typical Use | Pros | Cons |
|--------|-------------|------|------|
| **EPC** | Most common for thermal, solar, wind, storage | Single-point responsibility, guaranteed performance | Less owner flexibility, claims risk |
| **EPCM** | Custom thermal, nuclear, pumped storage | Owner control, flexibility | Owner carries cost and schedule risk |
| **Build-Own-Operate (BOO) / IPP** | Independent power producers, renewables | Private financing, life-cycle focus | Complex commercial agreements |
| **Design-Build** | Transmission lines, substations | Fast delivery, single responsibility | Limited owner design input |
| **Alliancing** | Complex, ground-uncertain projects | Shared risk, collaborative | Requires trust and cultural alignment |

## Key Disciplines Involved

| Discipline | Prominence | Typical Scope |
|------------|-----------|---------------|
| **Electrical / Power Systems** | ★★★★★ | Generation equipment, transformers, switchgear, protection systems, grid code compliance |
| **Civil / Structural** | ★★★★☆ | Foundations (turbines, panels, structures), site drainage, access roads |
| **Geotechnical** | ★★★☆☆ | Foundation design, slope stability (hydro), site characterization |
| **Mechanical** | ★★★★☆ | Turbines, generators, compressors, cooling systems, piping |
| **Control / SCADA** | ★★★★★ | Plant control system, protection relay coordination, communications |
| **Environmental** | ★★★★★ | EIA, biodiversity (birds, bats), noise, water quality, decommissioning |
| **Civil / Hydraulic** | ★★★★☆ | Dam design, penstocks, spillways, tailraces (hydropower) |
| **Marine** | ★★★☆☆ | Offshore foundations, subsea cables, vessel logistics (offshore wind) |
| **Structural (Wind)** | ★★★★☆ | Tower design, foundation structures, crane lifts |

## Typical Project Lifecycle

```
1. RESOURCE ASSESSMENT AND FEASIBILITY
   ├── Resource study (wind, solar irradiation, hydrological data)
   ├── Preliminary site selection
   ├── Grid interconnection study
   └── Financial modeling and tariff structuring

2. DEVELOPMENT AND PERMITTING
   ├── Environmental assessment (EIA)
   ├── Land acquisition / rights-of-way
   ├── Permits and approvals
   ├── Grid connection agreement
   └── Financial close (for IPP projects)

3. DETAILED DESIGN AND ENGINEERING
   ├── Site layout optimization
   ├── Electrical system design
   ├── Structural/geotechnical design
   ├── SCADA and control system design
   └── Construction documents and specifications

4. PROCUREMENT
   ├── Major equipment ordering (turbines, panels, transformers)
   ├── Construction materials and balance of plant
   ├── Subcontractor selection
   └── Transportation and logistics planning

5. CONSTRUCTION
   ├── Site access roads and temporary facilities
   ├── Foundations, structures, and site works
   ├── Equipment delivery and installation
   ├── Electrical cabling and collection systems
   ├── Substation construction
   ├── Grid interconnection and communication systems
   └── Erection, commissioning, and performance testing

6. COMMISSIONING AND COD
   ├── Performance testing
   ├── Grid code compliance verification
   └── Commercial Operation Date (COD)

7. OPERATIONS (25–60 year design life)
   └── Maintenance, monitoring, asset management, repowering
```

## Risk Profile

### Primary Risk Categories

| Risk Category | Examples | Typical Mitigation |
|---------------|---------|-------------------|
| **Resource Risk** | Lower-than-expected wind/solar production | Long-term resource monitoring, conservative design |
| **Grid Integration** | Grid connection delays, interconnection issues | Early engagement with grid operator, parallel design tracking |
| **Equipment Delivery** | Turbine, panel, transformer delays | Multiple suppliers, performance bonds, milestone tracking |
| **Cost Escalation** | Raw material price volatility, logistics | Fixed-price EPC, hedging, price escalation clauses |
| **Regulatory / Permitting** | Permit delays, regulatory changes | Early permitting, political risk mitigation |
| **Weather / Construction** | Offshore weather windows, flood risk | Buffer in schedule, weather monitoring, contingency plans |
| **Performance** | Underperformance, equipment failure | Warranty management, O&M contracts, spare parts strategy |
| **Cybersecurity** | SCADA system vulnerabilities, grid threats | Network security, isolation, compliance with NERC/CIP |

### Insurance and Bonding

- Construction All Risk (CAR)
- Delay in Start-Up (DSU) / Advance Loss of Profits
- Equipment breakdown insurance
- Performance bonds for EPC contractor
- Professional indemnity for designers
- Operational all risk (after COD)
- Political risk insurance (cross-border projects)

## Commercial and Contractual Models

| Aspect | Common Practice |
|--------|----------------|
| Owner | Utility, IPP (independent power producer), government, community cooperative |
| Contract Forms | FIDIC Yellow/Silver (modified), bespoke EPC, NEC, LOGIC |
| Revenue Model | Power Purchase Agreement (PPA), merchant pricing, capacity payments |
| Payment Milestones | Progress-based for construction, PPA-based for operations |
| Retention | 5–10%, released after COD or defects liability period |
| Financing | Project finance (non-recourse), corporate finance, green bonds, multilateral funding |

## Environmental and Social Considerations

- **Wildlife Impact:** Bird/bat mortality (wind turbines), fish passage (hydro), habitat disruption
- **Land Use:** Large land footprint (solar farms), competing land uses (agriculture, conservation)
- **Water Consumption:** Thermal power cooling water use, hydrological flow alteration
- **Noise:** Turbine noise (wind), construction noise, substation hum
- **Visual Impact:** Landscape alteration, tourism impact, community opposition
- **Carbon Footprint:** Life-cycle emissions analysis, manufacturing emissions, decommissioning
- **Community Benefits:** Local employment, community funds, benefit-sharing arrangements
- **Decommissioning:** End-of-life planning, recycling (solar panels, turbine blades), site restoration

## Technology and Innovation Trends

- **Floating Solar PV:** Panels on water bodies, reducing land use and improving cooling efficiency
- **Offshore Wind:** Larger turbines (15+ MW), floating offshore platforms in deep water
- **Hybrid Systems:** Solar + wind + storage combinations for more consistent output
- **Green Hydrogen:** Electrolysis coupled with renewable generation for energy storage and fuel
- **Grid-Scale Storage:** Battery cost reduction, long-duration storage (flow batteries, compressed air)
- **Smart Grids:** Advanced metering, distributed energy resources, demand response
- **Small Modular Reactors (SMRs):** Factory-built nuclear for smaller-scale deployment
- **AI-Assisted Operations:** Predictive maintenance, forecast optimization, asset performance management
- **Agrivoltaics:** Combining solar generation with agricultural production on the same land

## Appendix: Typical Document Types for This Sector

| Document Type | Description | Discipline |
|---------------|-------------|------------|
| Resource Assessment Report | Wind/solar/hydro resource data, P50/P90/P99 estimates | Resource / Engineering |
| Grid Interconnection Study | Grid capacity, stability, power quality analysis | Electrical / Power Systems |
| Plant Layout and Optimization | Site layout, spacing optimization, access routes | Various |
| Electrical Single-Line Diagram | Power system configuration, protection zones | Electrical |
| Foundation Design Report | Structural/geotechnical design for turbines, panels, towers | Geotechnical / Structural |
| Environmental Impact Assessment | Biodiversity, noise, visual, water impact analysis | Environmental |
| SCADA / Control Philosophy | Control strategy, protection coordination | Control / Electrical |
| Commissioning Procedure | Performance testing, grid code verification | Project Management |
| O&M Manual | Operations and maintenance requirements | Various |
| Battery Energy Storage Specification | BESS sizing, cycle life, thermal management | Electrical / Mechanical |

---

*Energy & Power Project Typology — Version 1.0*
*Cross-Discipline Reference for AI Agents on Energy & Power Construction Projects*
*Last Updated: 2026-03-31*