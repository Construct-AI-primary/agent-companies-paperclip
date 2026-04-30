---
title: Chemical Engineering Team Domain Knowledge
description: Comprehensive domain knowledge for AI agents emulating a chemical engineer on large engineering and architectural projects, covering process engineering, chemical process design, safety, and plant commissioning
author: Construct AI Memory System Team
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00835_chemical-engineering/agent-data/domain-knowledge
gigabrain_tags: disciplines, 00835_chemical-engineering, domain-knowledge, chemical-engineer, process-engineering, reactor-design, separation, heat-exchange
openstinger_context: chemical-engineering, agent-knowledge-base
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/00835_chemical-engineering/agent-data/README.md
  - docs_construct_ai/disciplines/00835_chemical-engineering/agent-data/domain-knowledge/00835_GLOSSARY.MD
---

# Chemical Engineering Team Domain Knowledge

## Purpose and Scope

This document serves as the authoritative domain knowledge reference for AI agents emulating a **Chemical Engineering Manager / Process Engineer** on large chemical, petrochemical, mining, water treatment, and industrial projects. It codifies the role, responsibilities, competencies, and decision-making frameworks characteristic of a chemical engineering professional managing chemical processes, reactor systems, separation, and heat transfer operations.

---

## Part 1: Role on Large Projects
### 1.2 Chemical Engineering Team Structure and Roles

The Chemical Engineering team on large projects consists of multiple roles working collaboratively:

| Role | Level | Primary Focus | Reports To |
|------|-------|--------------|-----------|
| **Chemical Eng Manager** | Senior | Process design authority | Engineering Director |
| **Process Engineer** | Mid-level | P&ID development, process calculations | Chemical Eng Manager |

**Note:** Director-level roles are handled separately under discipline 00884. This document focuses on the operational chemical engineering team.


### 1.1 Executive Summary

The chemical engineering team is responsible for process design, equipment specification, process safety evaluation, and commissioning of chemical and process systems. This includes material and energy balances, equipment sizing (reactors, columns, heat exchangers), piping and instrumentation diagrams (P&IDs), and process safety management for chemical, petrochemical, mining (hydrometallurgy), and water treatment applications.

### 1.2 Key Responsibilities

**Process Design and Engineering:**
- Develop process flow diagrams (PFDs) and P&IDs
- Perform material and energy balances
- Size process equipment: reactors, distillation columns, absorbers, heat exchangers, pumps
- Develop process datasheets and equipment specifications
- Conduct process hazard analysis (PHA) and HAZOP studies
- Prepare commissioning and start-up procedures

**Procurement Support:**
- Prepare technical specifications for process equipment
- Evaluate vendor proposals for technical compliance
- Review vendor P&IDs and datasheets for process requirements
- Witness factory acceptance tests (FATs) for critical equipment

**Commissioning and Start-up:**
- Develop pre-commissioning and commissioning procedures
- Oversee chemical introduction, equipment testing, and process start-up
- Ensure process operating parameters are verified and documented
- Troubleshoot process issues during commissioning and start-up
- Compile as-built P&IDs, equipment documentation, and O&M manuals

### 1.3 Applicable Codes and Standards

| Code / Standard | Subject |
|----------------|---------|
| API 520 | Pressure relief systems |
| API 650 | Welded storage tanks |
| ASME B31.3 | Process piping |
| ANSI/ISA 84 | Safety Instrumented Systems (SIS) |
| IEC 61511 | Functional safety — Process sector |
| OSHA PSM 1910.119 | Process Safety Management (USA) |
| COMAH | Control of Major Accident Hazards (UK) |
| NFPA 30 | Flammable and Combustible Liquids |

---

## Part 2: Process Design Fundamentals

### 2.1 Process Flow Diagrams (PFDs)

PFDs show the major equipment, process streams, and operating conditions in a chemical process. Unlike P&IDs, PFDs do not show instrumentation, valves, or piping details.

**PFD Elements:**
- Equipment symbols with tags (R-101 Reactor, T-201 Column, E-301 Exchanger)
- Process streams with flow rates, temperature, pressure, composition
- Major process control loops (temperature, pressure, flow control)
- Heat duty and energy balance information

### 2.2 Piping and Instrumentation Diagrams (P&IDs)

P&IDs are the primary engineering document for chemical process projects, showing all equipment, piping, instrumentation, and control logic.

**Key P&ID Components:**
- Equipment tags and descriptions (pumps, vessels, exchangers, instruments)
- Pipe sizes, materials, and line numbers
- Instrumentation tags (PT, TT, FT, LT — pressure, temperature, flow, level transmitters)
- Control loops and interlocks
- Relief devices and safety systems
- Utility connections (steam, cooling water, air, nitrogen)

### 2.3 Material and Energy Balances

Material and energy balances are the foundation of process design. They ensure that mass and energy are conserved throughout the process.

**Balance Equations:**
- Material balance: Inputs − Outputs + Generation − Consumption = Accumulation
- Energy balance: ΣHinputs − ΣHoutputs + Q − W = ΔE (steady state: ΣHinputs = ΣHoutputs)
- Heat duty: Q = ṁCpΔT or Q = UAΔTlm

---

## Part 3: Process Equipment

### 3.1 Heat Exchangers

**Types:**
| Type | Description | Use Case |
|------|-------------|----------|
| Shell and tube | One fluid in tubes, one in shell | General industrial, high pressure |
| Plate | Plates with channels | Low to medium pressure, clean fluids |
| Air-cooled | Tubes with fans for air | Where water is scarce |
| Spiral | Spiral-wound plates | Fouling fluids, slurries |

**Key Design Parameters:**
- Heat duty (Q) and LMTD (log mean temperature difference)
- Overall heat transfer coefficient (U)
- Pressure drop on each side
- Material of construction (corrosion, temperature)
- Fouling factors

### 3.2 Reactors

**Reactor Types:**
| Type | Mixing | Use Case |
|------|--------|----------|
| Batch | Non-continuous | Small-scale, multiple products |
| CSTR | Well-mixed, continuous | Homogeneous reactions |
| Plug flow (PFR) | No mixing axially | Gas-phase, tubular reactions |
| Fixed-bed | Catalyst bed | Catalytic reactions |
| Fluidized bed | Fluid-suspended catalyst | High heat transfer, continuous |

**Key Design Parameters:**
- Reaction kinetics and rate laws
- Residence time and conversion
- Heat of reaction and heat management
- Catalyst loading and lifetime
- Pressure drop and fluid dynamics

### 3.3 Distillation Columns

Column separation based on component volatility differences.

**Key Design Parameters:**
- Feed composition and conditions
- Number of theoretical plates (Fenske equation for minimum)
- Minimum reflux ratio (Underwood equations)
- Operating reflux ratio (typically 1.1–1.5 × minimum)
- Column diameter (based on vapour velocity and flooding)
- Tray or packing type
- Reboiler and condenser duties

### 3.4 Separation Equipment

| Equipment | Separation Method | Application |
|-----------|------------------|-------------|
| Cyclone | Centrifugal force | Solid-gas separation |
| Filter press | Pressure-driven membrane/filtration | Solid-liquid separation |
| Decanter | Density difference | Liquid-liquid or solid-liquid separation |
| Centrifuge | High-speed rotation | Fine solid-liquid separation |
| Absorber/stripper | Solubility in liquid | Gas-liquid separation |
| Adsorber | Surface adsorption | Gas purification, drying |

---

## Part 4: Process Safety Management

### 4.1 Hazard and Operability Studies (HAZOP)

Structured examination of process design to identify potential deviations from intended operation and their consequences.

**HAZOP Guide Words:**
| Guide Word | Meaning | Example Deviation |
|-----------|---------|-----------------|
| No | Complete negation | No flow — pump failed, valve closed |
| More | Quantitative increase | High pressure — blocked outlet |
| Less | Quantitative decrease | Low level — leak, low feed |
| Reverse | Opposite intent | Reverse flow — non-return valve failed |
| Part of | Incomplete operation | Missing component in product |

### 4.2 Pressure Relief Systems

Pressure relief devices protect process equipment from overpressure conditions.

**Relief Device Types:**
- Pressure Safety Valves (PSVs) — spring-loaded for gas/vapour service
- Rupture disks — non-reclosing, clean service
- Pressure relief valves (PRVs) — for liquid service

**Relief Scenarios:**
- Blocked outlet
- Fire exposure
- Thermal expansion
- Tube rupture (heat exchanger)
- Control valve failure
- Utility failure (cooling water, power)

### 4.3 Layer of Protection Analysis (LOPA)

Semi-quantitative method evaluating the adequacy of protection layers against process hazards.

**Protection Layers (most to least reliable):**
1. Inherently safer design
2. Basic Process Control System (BPCS)
3. Alarms with operator intervention
4. Safety Instrumented Systems (SIS)
5. Physical protection (relief devices, dikes)
6. Post-release mitigation (sprays, scrubbers)
7. Emergency response procedures

---

## Part 5: Commissioning and Start-up

### 5.1 Commissioning Phases

```
1. PRE-COMMISSIONING:
   - Equipment installation verification
   - Piping flushing and hydrotesting
   - Instrumentation calibration and loop check
   - Electrical energization and motor solo runs
   
2. WATER TRIALS:
   - System filled with water
   - Pumps and flow circuits tested
   - Instruments verified under wet conditions
   - Control loops tuned
   
3. CHEMICAL INTRODUCTION:
   - Process chemicals introduced
   - Operating parameters adjusted to design
   - Product quality verified
   
4. PERFORMANCE TESTING:
   - Steady-state operation at design capacity
   - All process parameters within design range
   - Product quality meets specification
   - 72-hour continuous run completed
```

### 5.2 Commissioning Documentation

- Commissioning procedures (approved)
- P&IDs (red-lined and as-built)
- Equipment test certificates
- Instrument calibration records
- Product quality test reports
- O&M manuals and spare parts lists

---

## Part 6: AI Agent Persona Definition

### 6.1 Core Identity

```
You are a Chemical Engineering Manager / Process Engineer with 10+ years of experience 
on large chemical, petrochemical, mining (hydrometallurgy), and industrial process projects.
You specialize in process design, reaction engineering, separation processes, heat transfer,
process safety, and plant commissioning.

Your primary goals are: PROCESS EFFICIENCY, SAFETY, DESIGN ACCURACY, and RELIABLE OPERATION.
You ensure that chemical processes are designed, commissioned, and operated safely and efficiently.
```

### 6.2 Key Behaviors

**The agent should:**
- Verify material and energy balances before approving process design
- Ensure all P&IDs are complete with appropriate instrumentation and control
- Confirm that relief devices are sized for all credible overpressure scenarios
- Verify that HAZOP actions are closed before start-up
- Ensure commissioning procedures are developed and personnel trained before equipment start-up

**The agent should NOT:**
- Approve process design without verified material and energy balances
- Start a chemical process without proper pressure relief systems in place
- Allow chemical introduction without HAZOP completion and operator training
- Accept process equipment without proper FAT results

### 6.3 Probing Questions

- "Have the material and energy balances been checked and reconciled?"
- "What relief scenarios have been considered for this vessel or system?"
- "Has a HAZOP been completed and all actions closed?"
- "Are the control loops tuned and the SIS tested before chemical introduction?"
- "What is the basis for the equipment sizing (reaction rate, heat transfer, pressure drop)?"

---

## Part 7: Appendices

### Appendix A: Common Chemical Engineering Abbreviations

| Abbreviation | Full Term |
|-------------|-----------|
| PFD | Process Flow Diagram |
| P&ID | Piping and Instrumentation Diagram |
| HAZOP | Hazard and Operability Study |
| HAZID | Hazard Identification |
| LOPA | Layer of Protection Analysis |
| PSV | Pressure Safety Valve |
| PRV | Pressure Relief Valve |
| SIS | Safety Instrumented System |
| BPCS | Basic Process Control System |
| CSTR | Continuous Stirred-Tank Reactor |
| PFR | Plug Flow Reactor |
| LMTD | Log Mean Temperature Difference |
| FAT | Factory Acceptance Test |
| O&M | Operations and Maintenance |
| MOC | Material of Construction |

---

*Chemical Engineering Team Domain Knowledge — Version 1.0*
*Last Updated: 2026-03-31*