---
title: Oil & Gas Project Typology
description: Reference documentation for AI agents working on oil & gas construction projects across upstream, midstream, and downstream sectors
author: Construct AI Memory System Team
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/para/resources/project-typologies
gigabrain_tags: resources, project-typologies, oil-and-gas, upstream, midstream, downstream, LNG, pipelines
openstinger_context: oil-gas-sector, project-classification
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/para/resources/project-typologies/0000_PROJECT-TYPOLOGIES-INDEX.MD
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/00850_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00871_process-engineering/para-index.md
  - docs_construct_ai/disciplines/02400_safety/para-index.md
---

# Oil & Gas Project Typology

## Sector Overview

Oil and gas projects encompass the full value chain from exploration and production through to refining and product distribution. These projects are characterized by extreme safety requirements, harsh operating environments, complex process engineering integration, and stringent regulatory oversight.

### Sub-Sectors

| Sub-Sector | Description | Examples |
|-----------|-------------|----------|
| **Upstream** | Exploration and production of hydrocarbons | Drilling platforms, wellheads, flow stations, early production facilities (EPF) |
| **Midstream** | Transportation and storage of hydrocarbons | Pipelines, pump stations, compressor stations, storage terminals, tank farms |
| **Downstream** | Refining and processing of hydrocarbons | Refineries, gas processing plants, petrochemical complexes, LNG terminals |
| **Offshore** | Marine-based exploration and production | Fixed platforms, floating production systems (FPSO), subsea systems, drilling rigs |
| **LNG** | Liquefied natural gas facilities | LNG liquefaction plants, regasification terminals, LNG storage tanks |

## Typical Project Scale and Budget

| Project Category | Typical Budget | Duration | Workforce Peak |
|-----------------|----------------|----------|----------------|
| Flow station / EPF | $50M – $500M | 12–36 months | 500–2,000 |
| Pipeline (onshore) | $1M – $10M per km | 12–48 months | 200–1,000 |
| Gas processing plant | $200M – $2B | 24–60 months | 1,000–5,000 |
| Refinery upgrade | $500M – $10B+ | 36–84 months | 2,000–10,000 |
| LNG liquefaction train | $2B – $10B+ | 48–96 months | 3,000–15,000 |
| Offshore platform | $500M – $5B+ | 36–72 months | 1,000–8,000 |
| Tank farm / terminal | $20M – $200M | 12–36 months | 200–1,000 |

## Regulatory and Compliance Regime

### Key Standards and Codes

| Category | Standards |
|----------|-----------|
| Process Safety | API RP 750, API 510/570/653, OSHA PSM (29 CFR 1910.119), COMAH |
| Pipeline Design | ASME B31.3, B31.4, B31.8, API 1104 |
| Pressure Systems | ASME Section VIII, PED (EU) |
| Offshore Structures | API RP 2A, ISO 19900 series, NORSOK |
| Electrical (Hazardous Areas) | IECEx, ATEX, API RP 500, NFPA 497 |
| Fire & Explosion | NFPA standards, API RP 14C, API RP 14J |
| Environmental | ISO 14001, EPA regulations, IFC Performance Standards |
| HSE Management | ISO 45001, IOGP guidelines, API RP 76 |

### Permitting Requirements

- Environmental Impact Assessment (EIA) — mandatory for most projects
- Air emissions permits (flaring, venting, combustion)
- Water use/discharge permits (produced water, wastewater)
- Hazardous materials handling and storage licenses
- Construction and operational safety case (offshore)
- Pipeline route approval and right-of-way permits

## Typical Project Delivery Methods

| Method | Typical Use | Pros | Cons |
|--------|-------------|------|------|
| **EPC (Engineering, Procurement, Construction)** | Defined scope projects, downstream facilities | Single point of responsibility, price certainty | Less owner flexibility, claims risk |
| **EPCM (Engineering, Procurement, Construction Management)** | Complex upstream, mega-projects | Owner control, flexibility | Owner carries more risk, multiple contracts |
| **Lump Sum Turnkey (LSTK)** | Well-defined scopes, modular packages | Fixed price, schedule certainty | Higher contractor price premium |
| **Reimbursable / Cost-Plus** | FEED, early works, undefined scope | Flexibility for scope changes | Cost uncertainty for owner |
| **Alliance / Integrated Project Delivery** | Major developments with repeat clients | Aligned incentives, collaboration | Complex to set up, requires trust |

## Key Disciplines Involved

| Discipline | Prominence | Typical Scope |
|------------|-----------|---------------|
| **Process Engineering** | ★★★★★ | PFDs, P&IDs, hydraulics, process simulation, relief system design |
| **Piping / Pipeline** | ★★★★★ | Pipe stress analysis, material selection, routing, supports |
| **Civil / Structural** | ★★★★☆ | Foundations, pipe racks, structural steel, drainage, roads |
| **Electrical** | ★★★★☆ | HV/LV distribution, hazardous area classification, cathodic protection |
| **Instrumentation & Control** | ★★★★☆ | DCS/SCADA, SIS, fire and gas detection, telemetry |
| **HSE / Process Safety** | ★★★★★ | HAZOP, HAZID, LOPA, SIL assessment, QRA |
| **Geotechnical** | ★★★☆☆ | Soil investigations, foundation design, slope stability (pipelines) |
| **Mechanical / Equipment** | ★★★★☆ | Pressure vessels, pumps, compressors, heat exchangers |
| **Corrosion / Materials** | ★★★☆☆ | Material selection, corrosion management, coating specification |
| **Marine / Offshore** | ★★☆☆☆ | Mooring, subsea, riser systems (offshore only) |

## Typical Project Lifecycle

```
1. OPPORTUNITY IDENTIFICATION
   └── Resource appraisal, acreage evaluation, concept screening

2. APPRAISAL / FEED
   ├── Appraisal drilling, resource estimation
   ├── FEED (Front-End Engineering Design) — 10–20% engineering
   ├── Technology selection, site selection
   └── Class 3 cost estimate, gate review

3. SANCTION (FID)
   ├── Final Investment Decision
   ├── EPC/EPCM contractor selection
   └── Long-lead item identification and ordering

4. DETAILED ENGINEERING
   ├── 3D model review (HADOP/HAZID in model)
   ├── Detailed piping stress, structural analysis
   ├── Procurement of bulk materials
   └── Construction planning and method statements

5. PROCUREMENT AND FABRICATION
   ├── Structural steel, pipe, equipment procurement
   ├── Modular fabrication (often offshore or overseas)
   ├── Expediting and quality surveillance
   └── Transportation and logistics

6. CONSTRUCTION / INSTALLATION
   ├── Site preparation, earthworks, piling
   ├── Structural erection, pipe rack placement
   ├── Mechanical completion (pre-commissioning)
   └── Onshore: stick-build or modular; Offshore: platform installation

7. COMMISSIONING AND START-UP
   ├── System completion verification
   ├── Pre-commissioning (hydrotest, flush, dry)
   ├── Commissioning (introductions of hydrocarbon)
   ├── Performance testing and handover to operations
   └── Defect liability period

8. OPERATIONS (25–40 year design life)
   └── Maintenance, integrity management, production optimization
```

## Risk Profile

### Primary Risk Categories

| Risk Category | Examples | Typical Mitigation |
|---------------|---------|-------------------|
| **Process Safety** | Explosion, fire, toxic release, BLEVE | Layers of Protection Analysis (LOPA), SIS, hazard studies |
| **Geopolitical / Country** | Expropriation, political instability, sanctions | MIGA insurance, political risk analysis, local content |
| **Supply Chain** | Long-lead equipment, single-source suppliers | Early ordering, dual sourcing, strategic agreements |
| **HSE** | Major accident hazard, hazardous materials | Safety case process, QRA, emergency response planning |
| **Design / Interface** | Design errors, interface between packages | Robust FEED, interface management, model reviews |
| **Environmental** | Spills, emissions, produced water | Containment systems, treatment, monitoring |
| **Schedule** | Weather windows (offshore), permit delays | Buffer in schedule, early permit submission |
| **Commodity Price** | Oil/gas price volatility affecting project economics | Hedging, staged investment, flexible design |

### Insurance and Bonding

- Construction All Risk (CAR) insurance
- Erection All Risk (EAR) insurance
- Delay in Start-Up (DSU) / Advance Loss of Profits
- Professional indemnity for design engineers
- Performance bonds and advance payment guarantees from contractors

## Commercial and Contractual Models

| Aspect | Common Practice |
|--------|----------------|
| Owner | NOC or IOC (national oil company or international oil company) |
| Contract Forms | FIDIC Yellow/Silver (modified), bespoke EPC, LOGIC, AACE |
| Payment Milestones | Often tied to engineering deliverables, delivery, and construction progress |
| Retention | 5–10% retention, often released after mechanical completion or commissioning |
| Liquidated Damages | Schedule LDs (e.g., 0.5% per week, capped 10%) and performance LDs |
| Change Control | Strict change order process; variation orders require approval |

## Environmental and Social Considerations

- **Gas Flaring and Venting:** Subject to World Bank Zero Routine Flaring commitments in many jurisdictions
- **Produced Water:** Must be treated to discharge/disposal standards; reinjection where feasible
- **Greenhouse Gas Emissions:** Increasingly subject to carbon pricing and emissions trading
- **Biodiversity:** Pipeline route selection avoids sensitive habitats; compensatory measures
- **Spill Prevention:** Secondary containment, pipeline leak detection, emergency response planning
- **Local Content:** Host-country employment, procurement, and skills transfer requirements
- **Community Impact:** Noise, traffic, air quality during construction; permanent employment for operations

## Technology and Innovation Trends

- **Digital Twin and Intelligent Operations:** Real-time asset monitoring and predictive maintenance
- **Modular and Standardized Design:** Repeatable designs, modular construction for schedule reduction
- **Unmanned/Minimal Platforms:** Remotely operated facilities and autonomous systems offshore
- **CCUS (Carbon Capture, Utilization and Storage):** Integration of CO₂ capture and injection
- **Hydrogen Production:** Blue hydrogen (gas + CCS) and green hydrogen (electrolysis with renewables)
- **AI-Assisted Process Optimization:** Machine learning models for yield optimization, anomaly detection
- **Robotics and Drones:** Pipeline inspection, tank inspection, flare monitoring
- **Advanced Materials:** Corrosion-resistant alloys, composite piping for subsea and chemical service

## Appendix: Typical Document Types for This Sector

| Document Type | Description | Discipline |
|---------------|-------------|------------|
| Process Flow Diagram (PFD) | High-level process description with major equipment | Process |
| Piping & Instrumentation Diagram (P&ID) | Detailed process and instrumentation representation | Process / Piping |
| Equipment Data Sheets | Technical specifications for pumps, vessels, exchangers | Mechanical |
| Pipeline Route Survey | Topographic and geotechnical survey along pipeline route | Civil / Survey |
| Pipeline Stress Analysis | CAESAR II or equivalent pipe stress analysis | Piping |
| Hazard Operability Study (HAZOP) | Systematic hazard identification workshop | HSE / Process |
| Quantitative Risk Assessment (QRA) | Numerical risk analysis for major accident hazards | HSE |
| Safety Instrumented System (SIS) Design | SIL-rated safety system architecture | I&C / HSE |
| Plot Plan | Facility layout with equipment locations, safety distances | Civil / Process |
| Material Take-Off (MTO) | Quantity take-off for piping, structural steel, electrical | Various |
| Cathodic Protection Design | Pipeline / structure corrosion protection system | Materials / Electrical |
| Commissioning Procedure | Step-by-step start-up and handover procedure | Commissioning |
| Operations and Maintenance Manual | Facility O&M instructions, spare parts list | Operations |

---

*Oil & Gas Project Typology — Version 1.0*
*Cross-Discipline Reference for AI Agents on Oil & Gas Construction Projects*
*Last Updated: 2026-03-31*