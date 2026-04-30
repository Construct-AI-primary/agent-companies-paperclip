---
title: Civil Engineering Domain Knowledge
description: Comprehensive domain knowledge for civil engineering workflows including hydrology, transportation, structures, utilities, earthworks, mining, pipelines, water systems, and tunnels
author: PaperclipForge AI
version: 1.0
memory_layer: durable_knowledge
para_section: docs_paperclip/disciplines/00850-civil-engineering
gigabrain_tags: civil-engineering, hydrology, transportation, structures, utilities, earthworks, mining, pipelines, water-systems, tunnels
openstinger_context: civil-engineering-domain-knowledge, civil-engineering-workflows
last_updated: 2026-04-17
related_docs:
  - docs-paperclip/disciplines/00850-civil-engineering/projects/CIVIL-WORKFLOW/README.md
  - docs-paperclip/disciplines/00850-civil-engineering/projects/CIVIL-WORKFLOW/project/CIVIL-WORKFLOW-implementation.md
  - docs-construct-ai/disciplines/00850_Civil Engineering/agent-data/domain-knowledge/00850_DOMAIN-KNOWLEDGE.MD
---

# Civil Engineering Domain Knowledge

## Overview

This document provides comprehensive domain knowledge for civil engineering workflows, covering hydrology, transportation, structures, utilities, earthworks, mining, pipelines, water systems, and tunnels. This knowledge will be used to generate workflow templates and track implementation progress.

---

## Part 1: Stormwater Management (CIVIL-001)

### Runoff Calculation Methods

1. **Rational Method** (Q = CiA)
   - Application: Small watersheds <200 acres
   - Peak flow estimation for inlet spacing and pipe sizing
   - Time of concentration: Kirpich, FAA, Kerby methods
   - C-value selection by land use and soil group

2. **SCS Curve Number Method**
   - Application: Larger watersheds, detention sizing
   - Runoff volume: P - 0.2S)² / (P + 0.8S)
   - CN values by soil/hydrologic group (A, B, C, D)
   - Lag time calculation for unit hydrograph

3. **Unit Hydrograph Methods**
   - Application: Complex watershed response, flood studies
   - Snyder, Clark, SCS unit hydrographs
   - Channel routing: Muskingum, Modified Puls

### Detention Basin Design

| Component | Design Criteria |
|-----------|----------------|
| Forebay | 10-15% of total volume, 0.1-0.2 ac-ft/acre |
| Primary Cell | Control volume based on runoff |
| Outlet Structure | Orifice/weir design for release rate |
| Emergency Spillway | 100-year storm capacity |
| Maintenance Access | 12-15 ft wide gravel road |

### BMP Categories and Selection

- **Volume-based**: Retention ponds (permanent pool), wetlands, infiltration basins
- **Rate-based**: Detention ponds (no permanent pool), berms, weirs
- **Filtration**: Bioretention (rain gardens), sand filters, permeable pavements
- **Treatment**: Hydrodynamic separators (Vortechs, CDS), constructed wetlands

### Design Storm Events

| Return Period | Application |
|--------------|-------------|
| 1-year | Minor drainage, channel protection |
| 2-year | Minor culverts, local drainage |
| 10-year | Detention design minimum |
| 100-year | Floodplain, emergency spillway |

---

## Part 2: Road and Highway Design (CIVIL-002)

### Geometric Design Elements

1. **Horizontal Alignment**
   - Minimum radius: R = V² / (15*(e+f))
   - Superelevation: Max 4-8% based on climate
   - Spiral transitions: Required for V > 40 mph

2. **Vertical Alignment**
   - Crest curves: K = SSD/Δ (sight distance)
   - Sag curves: K = LSSD/Δ (stopping sight)
   - Grade limits: Based on design speed and terrain

### Design Speed Selection

| Functional Classification | Design Speed Range |
|--------------------------|-------------------|
| Freeway | 60-80 mph |
| Arterial (Rural) | 50-70 mph |
| Collector (Urban) | 30-40 mph |
| Local (Urban) | 25-30 mph |

### Pavement Design

1. **Flexible (HMA)**
   - Surface: 1.5-2.5 in SM-9.5/SM-12.5
   - Binder: 1.5-3.0 in SM-9.5
   - Base: 4-8 in aggregate base (ABC)
   - Design: AASHTO 1993, layer coefficients

2. **Rigid (PCC)**
   - Slab thickness: 8-12 in based on traffic
   - Joint spacing: 15-20 ft based on thickness
   - Load transfer: 1.25-1.5 in dowels
   - Design: AASHTO 1993, PCA method

---

## Part 3: Bridge and Structural Design (CIVIL-003)

### Bridge Types and Selection

| Type | Span Range | Typical Application |
|------|------------|-------------------|
| Box Culvert | 6-12 ft | Small waterway, driveway |
| Concrete Slab | 20-40 ft | Short spans, minimal depth |
| Precast Beam | 30-60 ft | Standard spans, quick install |
| Steel Girder | 30-100 ft | Medium spans, flexibility |
| Segmental | 100-300+ ft | Long spans, complex sites |

### AASHTO LRFD Load Cases

| Load Case | Dead Loads | Live Loads | Other |
|-----------|-----------|-----------|-------|
| Strength I | DC, DW | LL+IM | - |
| Strength III | DC, DW | - | Wind |
| Service I | DC, DW | LL+IM | Crack control |
| Extreme I | DC, DW | - | Earthquake |

### Foundation Types

1. **Shallow Foundations**
   - Spread footings: Bearing capacity q_all = cN_c + qN_q + 0.5γBN_γ
   - Mat foundations: For differential settlement

2. **Deep Foundations**
   - Driven piles: H-pile, pipe pile, concrete pile
   - Drilled shafts: CIDH, large diameter (3-8 ft)
   - Capacity: Q_u = Q_s + Q_p (skin + tip)

### Scour Analysis

- **Long-term degradation**: Channel bed lowering over design life
- **Contraction scour**: Laursen method
- **Local scour**: CSU equation around piers
- **Design scour**: 100-year elevation for foundations

---

## Part 4: Utilities Infrastructure (CIVIL-004)

### Water Distribution Components

| Component | Design Criteria |
|-----------|----------------|
| Transmission Mains | 16-60 in, DIP Class 350/350H |
| Distribution Mains | 6-12 in, fire flow 1000-2500 gpm |
| Valve Spacing | 500-800 ft commercial, 800-1000 ft residential |
| Hydrant Spacing | 500 ft to structure, 1000 ft between |

### Sanitary Sewer Design

| Parameter | Design Value |
|-----------|-------------|
| Minimum Slope (8in) | 0.4% |
| Minimum Slope (12in) | 0.22% |
| Minimum Velocity | 2.0 fps at full flow |
| Design Depth Ratio | 0.4-0.6 of diameter |
| Manhole Diameter | 48-60 in |

### SUE Levels

- **Level A**: 1 in variance, vacuum excavation, test holes
- **Level B**: 1 ft variance, survey-based
- **Level C**: Visible utilities, limited accuracy
- **Level D**: Existing records only

---

## Part 5: Earthworks and Excavation (CIVIL-005)

### Cut/Fill Analysis Methods

1. **Grid Method**: V = (A1 + 4Am + A2)/6 × d
2. **Average End Area**: V = (A1 + A2)/2 × L
3. **3D Surface Method**: TIN-based calculations

### Shrink/Swell Factors

| Material | Shrink | Swell |
|----------|--------|-------|
| Common Earth | 0.80-0.85 | 1.25-1.35 |
| Sandy Clay | 0.85-0.90 | 1.15-1.25 |
| Clay | 0.75-0.85 | 1.30-1.45 |
| Rock (rippable) | 0.70-0.80 | 1.40-1.60 |
| Rock (blasted) | 0.65-0.75 | 1.50-1.70 |

### Compaction Requirements

| Application | Minimum Compaction |
|-------------|-------------------|
| Under pavement | 95% Proctor (modified) |
| Non-structural | 90% Proctor (modified) |
| Utility trench | 90-95% Proctor (modified) |
| Subgrade | 98% Proctor (modified) |

---

## Part 6: Mining and Surface Operations (CIVIL-006)

### Open Pit Design

| Parameter | Typical Value |
|-----------|--------------|
| Overall slope | 35-55° |
| Bench height | 30-50 ft |
| Catch bench width | 15-20 ft |
| Haul road width | 60-80 ft |
| Haul road grade | 8-10% loaded |

### Haul Road Design

- **Travelway width**: 3x truck width (60-80 ft for 240-ton trucks)
- **Safety berms**: 1/2 tire height minimum
- **Surfacing**: 12-24 in crushed rock
- **Subgrade CBR**: 80+ minimum

### Equipment Productivity

| Equipment | Typical Capacity |
|-----------|-----------------|
| Hydraulic excavator | 8-25 yd³ bucket |
| Rigid frame trucks | 100-400 ton |
| Front-end loader | 10-30 yd³ bucket |
| Dozer | D8-D11 size |

---

## Part 7: Pipeline Design (CIVIL-007)

### Pipe Materials

| Material | Pressure Class | Size Range |
|----------|---------------|------------|
| DIP | Class 150-350H | 3-64 in |
| PVC (AWWA C900) | DR14-DR32 | 4-12 in |
| HDPE | DR11-DR17 | 1-63 in |
| Steel | API 5L B-X80 | 4-144 in |

### Bedding Classes

- **Class A**: Crushed rock, 90° embedment
- **Class B**: Granular, 30° embedment
- **Class C**: Native soil with shaping
- **Class D**: Imported granular required

### Hydraulic Formulas

1. **Hazen-Williams**: Q = 0.442 × C × D^2.63 × S^0.54
2. **Darcy-Weisbach**: hf = f × (L/D) × (V²/2g)
3. **Design velocity**: 2-5 fps normal, 8 fps fire flow

---

## Part 8: Water Reticulation (CIVIL-008)

### Demand Categories

| Category | Demand Factor |
|----------|--------------|
| Residential | 80-120 gpcd |
| Commercial | 0.1-0.5 gpm/1000 sqft |
| Institutional (schools) | 15-25 gpcd |
| Fire flow | 500-4000 gpm for 2-4 hours |

### Storage Sizing

| Component | Sizing Criteria |
|-----------|----------------|
| Equalization | 25-33% of average day |
| Fire storage | ISO requirement |
| Emergency | 12-24 hours average day |
| Operational | 10-15% additional |

### Pressure Requirements

| Parameter | Design Value |
|-----------|-------------|
| Maximum pressure | 80-100 psi |
| Minimum pressure | 35-40 psi at critical point |
| Fire flow residual | 20 psi minimum |

---

## Part 9: Tunnel Design (CIVIL-009)

### Excavation Methods

| Method | Application | Ground Condition |
|--------|-------------|-----------------|
| NATM | Sequential, 10-50 ft diameter | Rock, soft ground |
| TBM | Continuous, 10-30 ft diameter | Soft ground, mixed face |
| Drill & Blast | Sequential, any size | Rock |
| Cut & Cover | Shallow, 20-100+ ft width | Soils |

### Ground Support Design

1. **Rock Support**: RMR/Q-system based support selection
2. **NATM**: Shotcrete 4-12 in + rock bolts 10-20 ft
3. **Segmental**: Concrete segments 1-2m width
4. **Lattice girders**: For poor ground conditions

### Safety Systems

- Emergency egress shafts and cross passages
- Longitudinal/transverse ventilation
- Fire detection and suppression
- Drainage and pump stations

---

## Standards and References

### Primary Standards

| Standard | Application |
|----------|-------------|
| AASHTO LRFD Bridge Design | Bridge, culvert, retaining walls |
| AASHTO Geometric Design Guide | Roadway design |
| AWWA Standards | Water pipelines and systems |
| EPA NPDES | Stormwater management |
| OSHA 29 CFR 1926 | Excavation and tunnel safety |
| MSHA 30 CFR | Surface mining |
| NFPA 502 | Road tunnels |

### Design Software

| Software | Application |
|----------|-------------|
| Civil 3D | Alignment, grading, corridors |
| EPANET/WaterCAD | Water distribution modeling |
| HEC-RAS | Hydrology and hydraulics |
| PLAXIS/FLAC | Geotechnical analysis |
| LPILE | Foundation design |
| AutoCAD | Drafting and plans |

---

## Workflow Coverage Map

| Issue ID | Workflow | Coverage Status |
|----------|----------|-----------------|
| CIVIL-001 | Stormwater Management | ✅ Implemented |
| CIVIL-002 | Road and Highway Design | ✅ Implemented |
| CIVIL-003 | Bridge and Structural Design | ✅ Implemented |
| CIVIL-004 | Utilities Infrastructure | ✅ Implemented |
| CIVIL-005 | Earthworks and Excavation | ✅ Implemented |
| CIVIL-006 | Mining and Surface Operations | ✅ Implemented |
| CIVIL-007 | Pipeline Design | ✅ Implemented |
| CIVIL-008 | Water Reticulation | ✅ Implemented |
| CIVIL-009 | Tunnel Design | ✅ Implemented |

---

**Version**: 1.0
**Last Updated**: 2026-04-17
**Author**: PaperclipForge AI
**Status**: Active - All workflows implemented