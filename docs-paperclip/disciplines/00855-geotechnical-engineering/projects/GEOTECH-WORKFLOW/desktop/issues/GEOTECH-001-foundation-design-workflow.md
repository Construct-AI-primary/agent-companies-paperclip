---
id: GEOTECH-001
title: Foundation Design and Analysis Workflow Template
phase: Phase 1 — Site Investigation & Foundation Design
status: backlog
priority: critical
assignee: geotech-domainforge
company: domainforge-ai
created_date: 2026-04-17
due_date: 2026-05-17
estimated_hours: 20
parent: GEOTECH-WORKFLOW
project: GEOTECH-WORKFLOW
derivedFrom: UNIV-005
---

# GEOTECH-001: Foundation Design and Analysis Workflow Template

## Description

Create a comprehensive foundation design and analysis workflow template that standardizes geotechnical foundation engineering from soil investigation through foundation design and construction.

**Context**: Foundation design is critical for structural stability and requires comprehensive geotechnical analysis. This template addresses the complete foundation engineering process.

**Objectives**:
- Create standardized foundation design workflows
- Design bearing capacity analysis templates
- Build settlement analysis procedures
- Integrate with structural engineering requirements
- Ensure geotechnical standards compliance

**Scope**:
- In Scope: Shallow foundations, deep foundations, settlement analysis, bearing capacity
- Out of Scope: Structural design, construction methods

## Acceptance Criteria

- [ ] Soil investigation data analysis workflows
- [ ] Bearing capacity calculation templates
- [ ] Settlement analysis procedures
- [ ] Foundation type selection criteria
- [ ] Geotechnical report generation
- [ ] Construction monitoring plans

## Assigned Company & Agent

- **Primary**: DomainForge AI — geotech-domainforge
- **Supporting**: InfraForge AI — database-infraforge
- **Integration Support**: IntegrateForge AI — Geotechnical OpenCV Measurement connectors available

## Working Directory

`docs-paperclip/disciplines/00855-geotechnical-engineering/workflows/foundation-design/`

## Required Skills

- Geotechnical Engineering
- Foundation Design
- Soil Mechanics
- Structural Analysis

## Dependencies

- BLOCKED BY: None (Phase 1 independent)
- BLOCKS: GEOTECH-002 (Retaining Structures), GEOTECH-003 (Slope Stability)

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 18-22 hours
- **Timeline**: 3-4 weeks

## Technical Notes

### Foundation Types and Selection

1. **Shallow Foundations**
   - Spread footings: Individual, combined, continuous
   - Mat foundations: For heavy loads or poor soils
   - Selection criteria: Bearing capacity, settlement, cost

2. **Deep Foundations**
   - Driven piles: Displacement and non-displacement
   - Drilled shafts: Bored piles, caissons
   - Selection criteria: Load capacity, soil conditions, constructability

3. **Special Foundations**
   - Raft foundations: For variable soil conditions
   - Compensated foundations: For expansive soils
   - Vibration-sensitive applications

### Bearing Capacity Analysis

1. **Ultimate Bearing Capacity (Terzaghi)**
   ```
   qu = cNc + γDF Nq + 0.5γBNγ
   ```
   - c: cohesion
   - γ: unit weight
   - DF: depth of foundation
   - B: foundation width
   - Nc, Nq, Nγ: bearing capacity factors

2. **Allowable Bearing Capacity**
   - Factor of safety: 2.5-3.0 for ultimate limit state
   - Settlement considerations: Additional reduction
   - Eccentric loading effects

3. **Field Testing Methods**
   - Standard Penetration Test (SPT): N-values
   - Cone Penetration Test (CPT): Tip resistance, sleeve friction
   - Pressuremeter Test (PMT): Limit pressure, creep parameters
   - Plate Load Test: Direct measurement

### Settlement Analysis

1. **Immediate Settlement (Elastic)**
   ```
   ρi = (qB(1-ν²))/E * If
   ```
   - q: applied pressure
   - B: foundation width
   - ν: Poisson's ratio
   - E: modulus of elasticity
   - If: influence factor

2. **Consolidation Settlement**
   - Primary consolidation: Time-dependent settlement
   - Secondary compression: Long-term creep
   - Rate of consolidation: Time for 90% settlement

3. **Differential Settlement**
   - Tolerance criteria: L/300 for buildings
   - Structural implications: Additional moments
   - Mitigation strategies: Stiffening, compensation grouting

### Soil Investigation Requirements

1. **Exploratory Borings**
   - Depth: 1.5-2x foundation width minimum
   - Spacing: 1-3 foundation widths apart
   - Sampling: Continuous for critical areas

2. **Laboratory Testing**
   - Index properties: Moisture content, density, Atterberg limits
   - Strength parameters: Triaxial, direct shear, unconfined compression
   - Compressibility: Consolidation, swell potential

3. **In-Situ Testing**
   - SPT: Standard penetration resistance
   - CPT: Continuous profiling
   - Vane shear: Undrained strength
   - Pressuremeter: Deformation modulus

## Paperclip Task Schema

```yaml
task_schema:
  title: Foundation Design and Analysis Workflow Template
  phase: Phase 1 — Site Investigation & Foundation Design
  priority: critical
  skills:
    - geotechnical-engineering
    - foundation-design
    - soil-mechanics
    - structural-analysis
```

## Success Validation

1. **Bearing Capacity**: Adequate for all load cases
2. **Settlement**: Within acceptable limits
3. **Stability**: No bearing capacity failures
4. **Cost Effectiveness**: Optimal foundation selection

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-005 (Migrated to GEOTECH-WORKFLOW)