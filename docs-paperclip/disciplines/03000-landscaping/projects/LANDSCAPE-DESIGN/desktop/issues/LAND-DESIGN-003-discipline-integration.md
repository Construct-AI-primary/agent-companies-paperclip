---
id: LAND-DESIGN-003
title: "Landscape Design Integration — Hardscape Design, Grading Plans & Cross-Discipline Coordination"
labels: ["landscaping", "design", "3 — Discipline Integration"]
phase: "3 — Discipline Integration"
status: todo
priority: High
story_points: 8
due_date: "2026-08-31"
assignee: devforge-ai
company: devforge-ai
blocked_by:
  - LAND-DESIGN-002
estimated_duration: 4 weeks
risk_level: High
---

# LAND-DESIGN-003: Landscape Design Integration — Hardscape Design, Grading Plans & Cross-Discipline Coordination

## Delegation

This issue is delegated to **devforge-ai** for engineering implementation. Coordination with other discipline teams (civil, structural) will be facilitated by **domainforge-ai**.

## Goals

- Build hardscape design tools for paths, patios, walls, water features, and lighting
- Implement grading plan tools with contour editing, slope analysis, and cut/fill calculations
- Create cross-discipline coordination system with overlay viewing and conflict detection
- Develop design review and comment threading system

## Executive Summary

LAND-DESIGN-003 extends the core CAD canvas from LAND-DESIGN-002 with discipline-specific tools for hardscape design and grading plans. Hardscape tools enable designers to incorporate non-plant elements like paths, patios, walls, water features, and lighting into their landscape designs. Grading plan tools provide contour editing, slope analysis, and cut/fill calculations essential for site preparation and drainage planning. The cross-discipline coordination system allows landscape designers to overlay plans from civil, structural, and other disciplines, detect conflicts, and collaborate through threaded comments and markups.

## Required Actions

| # | Action | Owner | Expected Outcome |
|---|--------|-------|-----------------|
| 1 | Build hardscape element library | devforge-ai | Library of pavers, stone, concrete, wood, metal elements |
| 2 | Implement path and patio drawing tools | devforge-ai | Freeform, geometric, and patterned path/patio tools |
| 3 | Create wall and fence design tools | devforge-ai | Retaining wall, privacy screen, fence design tools |
| 4 | Add water feature design tools | devforge-ai | Pond, fountain, waterfall design and editing tools |
| 5 | Build lighting layout tools | devforge-ai | Path light, spotlight, ambient lighting placement tools |
| 6 | Implement contour line drawing/editing | devforge-ai | Contour creation, editing, and interpolation tools |
| 7 | Build slope analysis and visualization | devforge-ai | Slope gradient visualization with color mapping |
| 8 | Create cut/fill calculation engine | devforge-ai | Earthwork volume calculations with visual indicators |
| 9 | Add drainage pattern design tools | devforge-ai | Drainage arrows, swales, and basin design tools |
| 10 | Build discipline overlay system | devforge-ai | Overlay other discipline plans with opacity control |
| 11 | Implement conflict detection | devforge-ai | Auto-detect overlapping elements across disciplines |
| 12 | Create coordination markup tools | devforge-ai | Comments, flags, revision clouds for coordination |
| 13 | Build design review and comment threading | devforge-ai | Threaded comments with @mentions and status tracking |

## Acceptance Criteria

- [ ] Hardscape element library includes pavers, stone, concrete, wood, and metal material types
- [ ] Path and patio tools support freeform, geometric, and patterned designs
- [ ] Wall and fence tools support retaining walls, privacy screens, and fences with configurable heights
- [ ] Water feature tools support ponds, fountains, and waterfalls with water volume calculations
- [ ] Lighting layout tools support path lights, spotlights, and ambient lighting with photometric data
- [ ] Contour tools allow creation, editing, and interpolation of contour lines
- [ ] Slope analysis displays gradient with color mapping and percentage labels
- [ ] Cut/fill engine calculates earthwork volumes with accuracy within 5%
- [ ] Drainage tools support drainage arrows, swales, and basin design
- [ ] Discipline overlay system supports loading and viewing plans from other disciplines
- [ ] Conflict detection identifies overlapping elements and generates reports
- [ ] Coordination markup includes comments, flags, and revision clouds
- [ ] Design review system supports threaded comments with @mentions and status tracking

## Dependencies

**Blocked by:**
- LAND-DESIGN-002: Core Integration (CAD canvas, plant placement, annotation)

**Blocks:**
- LAND-DESIGN-WEB-002: Web Admin (plant DB management, template library, approval workflows)

## Estimated Duration

**4 weeks**

## Risk Level

**High** — Cross-discipline coordination requires integration with external discipline systems. Cut/fill calculations must be accurate for regulatory compliance.
