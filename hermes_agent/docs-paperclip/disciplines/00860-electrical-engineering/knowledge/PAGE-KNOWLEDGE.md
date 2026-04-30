---
title: Electrical Engineering Domain Knowledge
description: Comprehensive domain knowledge for electrical engineering workflows including power distribution, transmission, substations, generators, cables, traffic signals, maintenance, and commissioning
author: PaperclipForge AI
version: 1.0
memory_layer: durable_knowledge
para_section: docs_paperclip/disciplines/00860-electrical-engineering
gigabrain_tags: electrical-engineering, power-distribution, transmission, substations, generators, cables, traffic-signals, maintenance, commissioning
openstinger_context: electrical-engineering-domain-knowledge, electrical-engineering-workflows
last_updated: 2026-04-17
related_docs:
  - docs-paperclip/disciplines/00860-electrical-engineering/projects/ELEC-WORKFLOW/README.md
  - docs-paperclip/disciplines/00860-electrical-engineering/projects/ELEC-WORKFLOW/project/ELEC-WORKFLOW-implementation.md
  - docs-construct-ai/disciplines/00860_Electrical Engineering/agent-data/domain-knowledge/00860_DOMAIN-KNOWLEDGE.MD
---

# Electrical Engineering Domain Knowledge

## Overview

This document provides comprehensive domain knowledge for electrical engineering workflows, covering power distribution, transmission, substations, generators, cables, traffic signals, maintenance, and commissioning. This knowledge will be used to generate workflow templates and track implementation progress.

---

## Part 1: Electrical Power Distribution (ELEC-001)

### Voltage Classes

| Class | Voltage Range | Application |
|-------|--------------|-------------|
| Primary Distribution | 4.16kV-35kV | Radial, loop, network systems |
| Secondary Distribution | 120V-480V | Service, panel boards |
| Medium Voltage | 2.4kV-35kV | Industrial distribution |

### Distribution System Types

1. **Radial System**: Single source, simple protection, lower cost
2. **Loop System**: Primary loop with open point, improved reliability
3. **Network System**: Spot network for downtown areas, highest reliability

### Conductor Types

| Conductor | Material | Application |
|-----------|----------|-------------|
| AAC | 1350 Aluminum | Standard distribution |
| AAAC | 6201 Alloy | Better sag/tension properties |
| ACSR | Aluminum/Steel | Long spans, high tension |
| Copper | Solid/Stranded | High ampacity, corrosive areas |

### Transformer Sizing

| Type | Size Range | Loading |
|------|-----------|--------|
| Single-phase | 25-167 kVA | 80-90% nameplate |
| Three-phase | 75-2500 kVA | 80-90% nameplate |
| Impedance | 5-8% typical | Affects fault levels |

### Voltage Drop Limits

- **Branch circuits**: 3% maximum
- **Feeders**: 5% maximum
- **Combined**: 5% maximum (NEC 210.19)

---

## Part 2: Traffic Signals and ITS (ELEC-002)

### MUTCD Signal Warrants

| Warrant | Description | Requirements |
|---------|-------------|---------------|
| Warrant 1 | Eight-Hour Volume | 420 vph for 8 hrs |
| Warrant 2 | Four-Hour Volume | 480 vph for 4 hrs |
| Warrant 3 | Peak Hour | 150 vph + delay |
| Warrant 7 | Crash Experience | 5+ crashes + volume |

### Timing Calculations

| Parameter | Formula/Value |
|-----------|---------------|
| Lost time | 2-4 seconds/phase |
| Cycle length | 60-180 seconds |
| Yellow interval | V/2a + 1 (a=12 fps²) |
| All-red interval | 1-2 seconds |

### Phase Sequence

- Ring-and-barrier: Standard 2-ring, 8-phase
- Protected left turns: Leading/lagging phases
- Pedestrian intervals: Walk + FDW calculation

### Detection Systems

| Type | Application |
|------|-------------|
| Inductive loops | 6x6 ft to 40x6 ft |
| Video detection | VIVAR, Autoscope |
| Radar detection | RTMS, Blue Arrow |
| Bluetooth | Travel time collection |

---

## Part 3: High Voltage Transmission (ELEC-003)

### Voltage Classes

| Class | Range | Typical ROW |
|-------|-------|-------------|
| HV | 69kV-115kV | 80-100 ft |
| EHV | 115kV-345kV | 100-150 ft |
| UHV | 345kV-800kV+ | 150-250 ft |

### Tower Types

| Type | Application | Configuration |
|------|-------------|----------------|
| Lattice Steel | Self-supporting | A-frame, C-frame |
| Monopole | Single shaft | Steel or concrete |
| Guyed V | Angle structures | Reduced material |
| Deadend | High tension | Suspension vs. |

### Conductor Selection

| Conductor | Temperature | Application |
|-----------|-------------|-------------|
| ACSR | Standard | General use |
| ACSS | High temperature | Reduced sag |
| HTLS | 200-250°C | Upgrade paths |
| OPGW | Combined | Communication |

### Sag-Tension Analysis

- **Catenary equation**: H = T₀/w
- **Sag**: S = w×L²/(8×H)
- **NESC Loading**: Heavy, Medium, Light
- **Clearances**: Ground, buildings, crossings

---

## Part 4: Generator and Power Plant (ELEC-004)

### NFPA 110 Classifications

| Type | Start Time | Application |
|------|-----------|-------------|
| Type 10 | 10 seconds | Critical facilities |
| Type 60 | 60 seconds | Standard standby |
| Type 120 | 120 seconds | Extended start |

### NEC Articles

| Article | Application |
|---------|-------------|
| NEC 700 | Emergency systems |
| NEC 701 | Legally required standby |
| NEC 702 | Optional standby |

### Generator Sizing

| Factor | Calculation |
|--------|-------------|
| Motor starting | kVA = HP × 0.746 × SF / (η × PF) |
| DOL start | 6-7x FLA |
| Star-delta | 2-3x FLA |
| VFD | 1.0-1.15x FLA |

### Transfer Switches

| Type | Operation | Application |
|------|-----------|-------------|
| Open transition | Break-before-make | Standard |
| Closed transition | Make-before-break | Parallel |
| In-phase | No load shed | Motors |
| Delayed | Stabilization | Large loads |

---

## Part 5: Substation Design (ELEC-005)

### Substation Types

| Type | Voltage | Application |
|------|---------|-------------|
| Distribution | 34.5/13.8kV | Load serving |
| Transmission | 115-230kV | Bulk power |
| Switching | Various | Reliability |

### Bus Configurations

| Configuration | Reliability | Application |
|--------------|-------------|-------------|
| Single bus | Lowest | Simplest |
| Main + transfer | Medium | Improved |
| Breaker-and-a-half | High | Critical |
| Ring bus | High | 3-4 circuits |

### Protection Functions

| Function | Device | Application |
|----------|--------|-------------|
| 87T | Transformer diff | Primary protection |
| 87B | Bus diff | Zone protection |
| 21 | Distance | Line protection |
| 67 | Directional OC | Ground faults |

### Equipment Selection

| Equipment | Types | Application |
|----------|-------|-------------|
| Transformers | 2-winding, 3-winding, auto | Voltage transformation |
| Circuit breakers | SF6, vacuum, air | Switching |
| Disconnect | Load break, non-load | Isolation |

---

## Part 6: Cable Selection and Reticulation (ELEC-006)

### Cable Types

| Insulation | Voltage | Application |
|-----------|---------|-------------|
| XLPE | 600V-35kV | Standard power |
| EPR | 600V-35kV | Flexibility |
| PVC | 600V only | Lower cost |
| LSF | Fire rated | Critical areas |

### Ampacity Factors

| Factor | Adjustment |
|--------|------------|
| Temperature | NEC Table 310.16 |
| Bundling | 0.50-0.80 |
| Multiple conduits | 0.50-0.65 |

### Installation Methods

| Method | Application |
|--------|-------------|
| Cable tray (ladder) | Power cables |
| Cable tray (solid) | Sensitive cables |
| EMT/IMC/RMC | Conduit systems |
| Duct bank | Underground |

### Voltage Drop Formula

- **VD** = (2 × K × I × L) / CM
- K = 12.9 (copper), 21.2 (aluminum)
- I = Load current (amps)
- L = One-way length (ft)
- CM = Wire circular mils

---

## Part 7: Electrical Maintenance (ELEC-007)

### Maintenance Strategies

| Strategy | Basis | Application |
|----------|-------|-------------|
| Preventive | Time-based | Fixed intervals |
| Predictive | Condition | CBM, PdM |
| RCM | Reliability | Critical equipment |

### Transformer Testing (IEEE 62)

| Test | Purpose |
|------|---------|
| Turn ratio | Verify connections |
| Winding resistance | Loose connections |
| DGA | Gas analysis |
| Power factor | Insulation |

### Switchgear Testing

| Test | Standard |
|------|----------|
| Contact resistance | Millivolt drop |
| Timing | Operation verification |
| Hi-pot | 60% factory test |
| Mechanical | Function test |

### CMMS Integration

- Work order generation
- Asset hierarchy
- KPI reporting (MTBF, MTTR)
- Preventive schedules

---

## Part 8: Electrical Commissioning (ELEC-008)

### Commissioning Phases

1. **Pre-commissioning**: Design review, submittals, inspection
2. **System verification**: Continuity, insulation, phasing
3. **Functional testing**: Protection, interlocks, controls
4. **Performance testing**: Load, harmonic, power quality

### Transformer Tests (IEEE C57)

| Test | Acceptance Criteria |
|------|-------------------|
| Ratio test | ±0.5% of nameplate |
| Polarity | Correct connection |
| Winding resistance | ±2% factory |
| No-load current | ±10% factory |

### Safety Requirements (NFPA 70E)

| Requirement | Application |
|-------------|-------------|
| Arc flash analysis | IEEE 1584 |
| PPE categories | 1-4 based on energy |
| LOTO | OSHA 1910.147 |
| Safe approach | Table 130.4(C) |

### Documentation

- As-found/as-left data
- Pass/fail criteria
- Deficiency log
- Certificates of completion

---

## Standards and References

### Primary Standards

| Standard | Application |
|----------|-------------|
| NEC (NFPA 70) | Electrical installation |
| NESC (IEEE C2) | Safety code |
| IEEE 1584 | Arc flash |
| NFPA 70E | Electrical safety |
| NFPA 110 | Generators |
| NETA MTS | Maintenance testing |

### Design Software

| Software | Application |
|----------|-------------|
| SKM PowerTools | Load flow, fault |
| ETAP | System analysis |
| EasyPower | Arc flash |
| EDSA | Distribution |
| CDEGS | Grounding |

---

## Workflow Coverage Map

| Issue ID | Workflow | Coverage Status |
|----------|----------|-----------------|
| ELEC-001 | Electrical Power Distribution | ✅ Implemented |
| ELEC-002 | Traffic Signals and ITS | ✅ Implemented |
| ELEC-003 | High Voltage Transmission | ✅ Implemented |
| ELEC-004 | Generator and Power Plant | ✅ Implemented |
| ELEC-005 | Substation Design | ✅ Implemented |
| ELEC-006 | Cable Selection and Reticulation | ✅ Implemented |
| ELEC-007 | Electrical Maintenance | ✅ Implemented |
| ELEC-008 | Electrical Commissioning | ✅ Implemented |

---

**Version**: 1.0
**Last Updated**: 2026-04-17
**Author**: PaperclipForge AI
**Status**: Active - All workflows implemented