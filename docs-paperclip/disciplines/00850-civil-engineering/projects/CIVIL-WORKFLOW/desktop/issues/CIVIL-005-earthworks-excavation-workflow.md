---
id: CIVIL-005
title: Earthworks and Excavation Workflow Template
phase: Phase 3 — Site Development
status: backlog
priority: medium
assigneeAgentId: interface-devforge
parent: CIVIL-002
project: CIVIL-WORKFLOW
derivedFrom: UNIV-054
---

# CIVIL-005: Earthworks and Excavation Workflow Template

## Description

Create a comprehensive earthworks and excavation workflow template that standardizes site grading, cut/fill analysis, and soil management across civil engineering projects.

**Context**: Earthworks is fundamental to site development, requiring precise quantity calculations, soil characterization, and construction sequencing. This template addresses the complete earthwork process from site investigation through construction.

**Objectives**:
- Create standardized site grading workflows
- Design cut/fill analysis and balancing templates
- Build earthwork quantity calculation automation
- Integrate geotechnical considerations
- Ensure erosion control and environmental compliance

**Scope**:
- In Scope: Site grading, cut/fill analysis, mass haul diagrams, retaining wall design
- Out of Scope: Tunneling, mining operations, deep excavation shoring

## Acceptance Criteria

- [ ] Site grading design workflow with slope optimization
- [ ] Cut/fill analysis template with balance point calculations
- [ ] Mass haul diagram generation workflow
- [ ] Earthwork quantity take-off automation
- [ ] Compaction control and testing templates
- [ ] Erosion and sediment control (ESC) design
- [ ] Temporary shoring design templates

## Assigned Company & Agent

- **Primary**: DevForge AI — interface-devforge
- **Supporting**: InfraForge AI — database-infraforge, DomainForge AI — Zara
- **Integration Support**: IntegrateForge AI — Civil 3D, GIS, OpenCV Measurement connectors available

## Working Directory

`docs-paperclip/disciplines/00850-civil-engineering/workflows/earthworks/`

## Communication Framework

**Active Interfaces (CIVIL-WORKFLOW Project):**
- Civil ↔ Electrical: Underground electrical routing, grounding
- Civil ↔ Mechanical: Equipment foundations, excavation coordination
- Civil ↔ Process: Tank foundations, excavation requirements
- BIM Coordination: Daily model updates, clash detection

**Communication Requirements:**
- Update BIM models daily by 5 PM
- Notify affected disciplines of grade changes within 48 hours
- Coordinate excavation sequencing with all disciplines
- Participate in bi-weekly coordination meetings
- Escalate interface conflicts to BIM coordinator within 24 hours

## Required Skills

- Civil Engineering Design
- Geotechnical Engineering
- Survey and GIS
- AutoCAD/ Civil 3D

## Dependencies

- BLOCKED BY: CIVIL-001 (Stormwater), CIVIL-002 (Roads)
- RELATED TO: DESIGN-005 (Civil Engineering Integration Requirements)
- BLOCKS: CIVIL-006 (Mining)

## Estimated Effort

- **Complexity**: Medium-High
- **Estimated Hours**: 12-16 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### Grading Design Elements

1. **Surface Modeling**
   - Existing ground terrain: 10-20ft grid for preliminary, 50-100ft for desktop study
   - Proposed finish grade: Design surface with drainage patterns, slopes, grades
   - Datum and benchmarks: NAVD88, local assumed if needed, minimum 2 benchmarks

2. **Slope Design**
   - Maximum slope recommendations: 3:1 (H:V) for maintained slopes, 2:1 in stable rock
   - Terrace and level spreader design: For runoff dispersion on long slopes
   - Drainage swale integration: Grassed swales at 2-4% grade, 18-36in bottom width

3. **Retaining Structures**
   - Gravity wall design: Cantilever concrete, bin walls, gabion baskets
   - MSE wall design: Segmental block or wrapped-face with geosynthetic
   - Soil nail wall design: For steep cuts, shotcrete facing with soil nails

### Cut/Fill Analysis

1. **Grid Method**
   - Elevation differences: Proposed - existing at grid intersections
   - Cell volumes (prismoidal formula): V = (A1 + 4Am + A2)/6 × d, where d = grid spacing
   - Accuracy: 1-3% for 50ft grid, improves with 25ft grid

2. **Average End Area Method**
   - Cross-section volumes: V = (A1 + A2)/2 × L, where L = station spacing
   - Station-by-station calculation: Use for road alignments, channels
   - Prismoidal correction: Apply for transitions between cut and fill

3. **3D Surface Method**
   - TIN-based calculations: Triangulate existing and proposed surfaces
   - Digital terrain models: Use CAD software volume calculation tools
   - Accuracy: Best method for irregular surfaces

### Earthwork Balancing

- **Free haul distance**: Typically 500-1000ft, no additional compensation
- **Overhaul**: Compensated beyond free haul, measured in station-yards
- **Mass Haul Diagram**: Plot cumulative bank yards vs. station, minimize haul distance
- **Shrink/swell factors**: Convert between bank, loose, and compacted volumes

| Material Type | Shrink Factor | Swell Factor |
|---------------|---------------|--------------|
| Common Earth | 0.80-0.85 | 1.25-1.35 |
| Sandy Clay | 0.85-0.90 | 1.15-1.25 |
| Clay | 0.75-0.85 | 1.30-1.45 |
| Rock (rippable) | 0.70-0.80 | 1.40-1.60 |
| Rock (blasted) | 0.65-0.75 | 1.50-1.70 |

### Compaction Requirements

| Application | Minimum Compaction |
|-------------|-------------------|
| Structural fill (under pavement) | 95% Proctor (modified) |
| Non-structural fill | 90% Proctor (modified) |
| Backfill (utility trench) | 90-95% Proctor (modified) |
| Embankment | 95% Proctor (modified) |
| Subgrade (subbase) | 98% Proctor (modified) |

### Design Standards

- **State DOT** standard specifications
- **ASTM D698/D1557** (Proctor tests)
- **EPA** stormwater regulations (SWPPP)
- **OSHA** excavation safety (29 CFR 1926 Subpart P)
- **AASHTO** soil classification and compaction

## Paperclip Task Schema

```yaml
task_schema:
  title: Earthworks and Excavation Workflow Template
  phase: Phase 3 — Site Development
  priority: medium
  skills:
    - civil-engineering
    - geotechnical
    - surveying
```

## Success Validation

1. **Balance Analysis**: Cut/fill within acceptable tolerance (typically ±5%)
2. **Quantity Accuracy**: Verified against hand calculations
3. **Constructability**: Practical equipment selection
4. **Environmental**: ESC measures adequate
5. **Safety**: OSHA shoring/sloping requirements met

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-054 (Migrated to CIVIL-WORKFLOW)