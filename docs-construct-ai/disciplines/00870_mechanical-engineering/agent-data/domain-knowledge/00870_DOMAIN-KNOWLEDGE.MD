---
title: Mechanical Engineering Team Domain Knowledge
description: Comprehensive domain knowledge for AI agents emulating a mechanical engineer on large engineering and architectural projects, covering mechanical systems, equipment, piping, HVAC, rotating equipment, and commissioning
author: Construct AI Memory System Team
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00870_mechanical-engineering/agent-data/domain-knowledge
gigabrain_tags: disciplines, 00870_mechanical-engineering, domain-knowledge, mechanical-engineer, rotating-equipment, piping, hvac, commissioning
openstinger_context: mechanical-engineering, agent-knowledge-base
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/00870_mechanical-engineering/agent-data/README.md
  - docs_construct_ai/disciplines/00870_mechanical-engineering/agent-data/domain-knowledge/00870_GLOSSARY.MD
---

# Mechanical Engineering Team Domain Knowledge

## Purpose and Scope

This document serves as the authoritative domain knowledge reference for AI agents emulating a **Mechanical Engineering Manager / Mechanical Engineer** on large-scale engineering, infrastructure, mining, and architectural projects. It codifies the role, responsibilities, competencies, and decision-making frameworks characteristic of a mechanical engineering professional managing mechanical systems, rotating equipment, piping, HVAC, and commissioning activities.

---

## Part 1: Role on Large Projects
### 1.2 Mechanical Engineering Team Structure and Roles

The Mechanical Engineering team on large projects consists of multiple roles working collaboratively:

| Role | Level | Primary Focus | Reports To |
|------|-------|--------------|-----------|
| **Mechanical Eng Manager** | Senior | Mechanical design authority | Engineering Director |
| **Mechanical Engineer** | Mid-level | Equipment sizing, piping design | Mechanical Eng Manager |

**Note:** Director-level roles are handled separately under discipline 00884. This document focuses on the operational mechanical engineering team.


### 1.1 Executive Summary

The mechanical engineering team is responsible for the design, specification, procurement support, installation supervision, testing, and commissioning of all mechanical systems and equipment on a project. This includes rotating equipment (pumps, compressors, turbines), static equipment (vessels, heat exchangers, tanks), piping systems, HVAC systems, materials handling systems, and fire protection mechanical systems.

### 1.2 Key Responsibilities

**Design and Engineering:**
- Develop mechanical design basis, specifications, and datasheets for equipment and piping
- Perform mechanical calculations: pressure drop, heat transfer, pump hydraulics, pipe stress
- Produce P&IDs, equipment layouts, piping general arrangements, and isometric drawings
- Coordinate with process, structural, electrical, and instrumentation disciplines
- Ensure compliance with applicable codes (ASME, API, EN, ISO, local regulations)

**Procurement Support:**
- Prepare technical bid evaluations for mechanical equipment and piping
- Review vendor drawings and proposals for technical compliance
- Conduct factory acceptance tests (FATs) for critical equipment
- Review material test reports and certification packages

**Installation Supervision and Commissioning:**
- Review contractor installation method statements for critical equipment
- Supervise installation of rotating and static equipment, piping, and HVAC
- Develop and execute commissioning and pre-commissioning procedures
- Conduct site acceptance tests (SATs) and performance guarantee testing
- Compile as-built mechanical documentation and O&M manuals

### 1.3 Applicable Codes and Standards

| Code / Standard | Subject |
|----------------|---------|
| ASME B31.3 | Process piping |
| ASME B31.1 | Power piping |
| ASME Section VIII | Pressure vessels |
| ASME Section IX | Welding and brazing qualifications |
| API 610 | Centrifugal pumps |
| API 617 | Centrifugal compressors |
| API 618 | Reciprocating compressors |
| ASCE 7 | Load design for structures (mechanical loads) |
| ISO 9906 | Rotodynamic pumps — Hydraulic performance |
| SMACNA | HVAC ductwork and systems |
| EN 13445 | Unfired pressure vessels (European) |

---

## Part 2: Piping Systems

### 2.1 Piping Design

Piping systems are the primary method for transporting fluids on engineering and construction projects. The mechanical team is responsible for piping design, material selection, and specification.

**Piping Classes and Specifications:**
| Parameter | Description |
|-----------|-------------|
| Pipe material | Carbon steel, stainless steel, duplex, alloy, plastic |
| Size range | DN15 to DN1200+ (½" to 48"+) |
| Pressure class | ANSI 150, 300, 600, 900, 1500, 2500, 4500 |
| Schedule | SCH 10, 20, 30, 40, 80, 120, 160, XXS |
| End connection | Butt-weld, socket-weld, threaded, flanged |
| Specification | ASTM A106 (carbon steel), A312 (stainless steel) |

### 2.2 Pipe Stress Analysis

**Key Considerations:**
- Thermal expansion and contraction
- Dead weight and live loads
- Pressure and wind/seismic loads
- Support and anchor locations
- Flexibility analysis for critical lines
- Nozzle loads on rotating equipment

### 2.3 Piping Materials

| Material | Typical Use | Temperature Range |
|---------|-------------|-------------------|
| Carbon steel (ASTM A106) | General process, utilities | -29°C to 425°C |
| Stainless steel (304/316) | Corrosive service, food/pharma | -196°C to 870°C |
| Duplex stainless steel | High corrosion, offshore | -50°C to 300°C |
| PVC/CPVC | Low pressure, non-critical | -10°C to 95°C |
| FRP/GRP | Corrosive service, water | -40°C to 120°C |

---

## Part 3: Rotating Equipment

### 3.1 Pumps

**Pump Types:**
| Type | Application | Typical Efficiency |
|------|-------------|-------------------|
| Centrifugal | High flow, low-medium head | 70-85% |
| Positive displacement | High pressure, viscous fluids | 60-80% |
| Reciprocating | High pressure, low flow | 75-95% |
| Screw/multiphase | Oil & gas, slurry | 50-80% |

**Key Selection Parameters:**
- Flow rate (m³/h, GPM) and total dynamic head (m, ft)
- Fluid properties: viscosity, density, corrosiveness, solids content
- NPSH available vs. NPSH required
- Shaft seal type: mechanical seal, gland packing, magnetic drive
- Driver: electric motor, diesel engine, steam turbine
- Material of construction and corrosion allowances

### 3.2 Compressors

**Compressor Types:**
| Type | Application | Pressure Ratio |
|------|-------------|---------------|
| Centrifugal | High flow, gas compression | 2-8 per stage |
| Reciprocating | High pressure, low flow | Unlimited stages |
| Rotary screw | Pneumatic utilities, refrigeration | Continuous |
| Axial | Very high flow, low pressure ratio | Gas turbines |

### 3.3 Installation Requirements

- Foundations designed for dynamic loads and vibration isolation
- Alignment using laser or reverse dial methods (coupled equipment)
- Grouting per manufacturer specifications
- Piping connected with proper support to avoid nozzle loading on equipment
- Lubrication, cooling, and seal systems installed per design
- Pre-commissioning: alignment check, lubrication, solo run, coupled run

---

## Part 4: Static Equipment

### 4.1 Equipment Types

| Equipment | Purpose | Key Design Considerations |
|-----------|---------|--------------------------|
| Pressure vessels | Contain process fluids | Design pressure/temperature, corrosion allowance, NDE requirements |
| Heat exchangers | Heat transfer between fluids | Thermal performance, fouling factor, differential expansion |
| Storage tanks | Store liquids/bulk materials | Foundation settlement, wind/seismic loads, roof type |
| Columns/towers | Distillation, absorption | Height-to-diameter ratio, wind loads, internals installation |
| Reactors | Chemical reactions | Agitator design, heat transfer, internal fittings |

### 4.2 Inspection and Testing

**Common Tests:**
- Hydrostatic test: 1.3 × design pressure (per ASME VIII)
- Pneumatic test: 1.1 × design pressure
- Radiographic testing (RT) for weld quality
- Ultrasonic testing (UT) for wall thickness
- Dye penetrant testing (PT) for surface cracks
- Magnetic particle testing (MT) for subsurface defects

---

## Part 5: HVAC and Ventilation

### 5.1 HVAC System Design

**Key Parameters:**
- Indoor design conditions (temperature, humidity) per applicable standards (ASHRAE)
- Outdoor design conditions (max/min temperature, humidity)
- Ventilation rates per ASHRAE 62.1 or local code
- Heat load calculations: sensible, latent, total
- Equipment sizing: chillers, AHUs, FCUs, ductwork

**HVAC Equipment:**
| Equipment | Purpose | Typical Application |
|-----------|---------|---------------------|
| Chillers | Cooling water for air handling | Central plant |
| Air Handling Units (AHUs) | Condition and distribute air | Building HVAC |
| Fan Coil Units (FCUs) | Zone-level conditioning | Offices, rooms |
| Cooling towers | Reject heat to atmosphere | Chiller cooling |
| Pumps | Circulate chilled/heating water | Primary/secondary loops |
| Ductwork | Distribute conditioned air | Distribution network |

---

## Part 6: Commissioning and Handover

### 6.1 Commissioning Phases

```
1. PRE-COMMISSIONING (Cold): 
   - Piping flushing and hydrotesting
   - Equipment alignment, lubrication, and solo runs
   - Electrical and instrumentation loop checks
   
2. COMMISSIONING (Hot):
   - Introduction of process fluids/energy
   - System start-up and functional testing
   - Performance testing to guaranteed parameters
   
3. INTEGRATION TESTING:
   - Full system operation with all disciplines
   - Control system and interlock testing
   - Emergency shutdown testing
   
4. PERFORMANCE TESTING:
   - Verify equipment meets guaranteed performance
   - 72-hour continuous run test
   - Documentation and handover to operations
```

### 6.2 Commissioning Documentation

- Commissioning procedure (approved)
- Pre-commissioning checklists and certificates
- Test reports (hydrotest, performance, functional)
- Red-lined P&IDs and as-built drawings
- Operation & maintenance (O&M) manuals
- Spare parts lists and recommended consumables

---

## Part 7: AI Agent Persona Definition

### 7.1 Core Identity

```
You are a Mechanical Engineering Manager with 10+ years of experience on 
large-scale engineering, oil & gas, mining, and construction projects.
You specialize in rotating equipment, piping systems, static equipment, HVAC,
and commissioning of mechanical systems.

Your primary goals are: TECHNICAL ACCURACY, SAFETY, RELIABILITY, and CODE COMPLIANCE.
You ensure mechanical systems are designed, installed, tested, and commissioned
to meet performance requirements reliably and safely.
```

### 7.2 Key Behaviors

**The agent should:**
- Verify mechanical calculations before approving designs
- Ensure all equipment specifications reference appropriate codes
- Check that piping systems are designed for correct pressure class and material
- Verify NDT/testing requirements are complete and adequate
- Ensure commissioning procedures are developed before equipment starts
- Track vendor deliverables and technical submittals
- Identify and resolve mechanical interface issues early (piping-to-equipment, structural-to-equipment)

**The agent should NOT:**
- Approve equipment without proper technical datasheets and specifications
- Allow commissioning without pre-commissioning checks being completed
- Accept equipment without FAT results or material certifications
- Overlook nozzle loads and piping flexibility in equipment piping design
- Handover systems without complete as-built documentation

### 7.3 Probing Questions

- "What is the design basis for this equipment specification?"
- "Has the piping been stress analyzed for thermal expansion?"
- "What NDE requirements apply to these welds?"
- "Has the factory acceptance test been witnessed and documented?"
- "Is the commissioning procedure approved and personnel trained?"

---

## Part 8: Appendices

### Appendix A: Common Mechanical Equipment Abbreviations

| Abbreviation | Full Term |
|-------------|-----------|
| P&ID | Piping and Instrumentation Diagram |
| GA | General Arrangement |
| ISO | Isometric Drawing |
| FAT | Factory Acceptance Test |
| SAT | Site Acceptance Test |
| NPSH | Net Positive Suction Head |
| MOC | Material of Construction |
| MAWP | Maximum Allowable Working Pressure |
| NDE/NDT | Non-Destructive Exams/Testing |
| RT | Radiographic Testing |
| UT | Ultrasonic Testing |
| PT | Penetrant Testing |
| MT | Magnetic Particle Testing |
| MDR | Manufacturer's Data Report |
| BOM | Bill of Materials |

---

*Mechanical Engineering Team Domain Knowledge — Version 1.0*
*Last Updated: 2026-03-31*