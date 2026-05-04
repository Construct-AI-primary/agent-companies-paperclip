---
id: LAND-DESIGN-002
title: "Landscape Design Core — CAD Design Canvas, Plant Placement & Annotation Tools"
labels: ["landscaping", "design", "2 — Core Integration"]
phase: "2 — Core Integration"
status: todo
priority: High
story_points: 13
due_date: "2026-07-31"
assignee: devforge-ai
company: devforge-ai
blocked_by:
  - LAND-DESIGN-001
estimated_duration: 6 weeks
risk_level: High
---

# LAND-DESIGN-002: Landscape Design Core — CAD Design Canvas, Plant Placement & Annotation Tools

## Delegation

This issue is delegated to **devforge-ai** for full engineering implementation. Architectural guidance and schema references will be provided by **domainforge-ai** from the completed LAND-DESIGN-001 foundation.

## Goals

- Build a fully functional CAD-style design canvas with pan, zoom, grid, and snapping
- Implement plant placement tools with drag-and-drop from a searchable plant browser
- Create a comprehensive annotation tool suite including text, dimensions, callouts, and labels
- Develop a plant symbol library with plan view and elevation view representations
- Implement undo/redo system and measurement tools

## Executive Summary

LAND-DESIGN-002 delivers the core design experience for landscape architects. The CAD canvas serves as the primary workspace where designers create planting plans by placing plants from a searchable browser onto a scalable vector canvas. The annotation system enables dimensioning, labeling, and documentation directly on the plan. This phase transforms the foundation data models from LAND-DESIGN-001 into an interactive, production-ready design environment. Performance optimization is critical — the canvas must handle large plans (up to 100 acres) with thousands of plant symbols without degradation.

## Required Actions

| # | Action | Owner | Expected Outcome |
|---|--------|-------|-----------------|
| 1 | Implement scalable vector CAD canvas | devforge-ai | Canvas with smooth pan/zoom, grid, snap-to-grid |
| 2 | Build layer management system | devforge-ai | Create, rename, reorder, toggle visibility, lock layers |
| 3 | Implement undo/redo system | devforge-ai | Full undo/redo for all canvas operations |
| 4 | Build measurement tools | devforge-ai | Distance, area, and angle measurement tools |
| 5 | Build plant browser with search/filter | devforge-ai | Searchable, filterable plant browser from database |
| 6 | Implement drag-and-drop plant placement | devforge-ai | Drag plants from browser onto canvas with auto-scaling |
| 7 | Create plant group placement tools | devforge-ai | Mass planting, hedge rows, drifts, random scatter |
| 8 | Add plant rotation, scaling, mirroring | devforge-ai | Transform controls for placed plant symbols |
| 9 | Implement plant symbol library | devforge-ai | Plan view and elevation view symbols for all species |
| 10 | Build text annotation tool | devforge-ai | Configurable text styles, alignment, rotation |
| 11 | Create dimension line tools | devforge-ai | Linear, aligned, radial, angular dimensions |
| 12 | Implement callout and leader tools | devforge-ai | Callout bubbles with leader lines to design elements |
| 13 | Build plant label generation | devforge-ai | Auto-populated labels from plant database attributes |
| 14 | Create legend and key tools | devforge-ai | Auto-generated legends from placed plant symbols |

## Acceptance Criteria

- [ ] CAD canvas supports smooth pan and zoom with configurable grid and snap-to-grid
- [ ] Layer management allows creating, renaming, reordering, toggling visibility, and locking layers
- [ ] Undo/redo system captures all canvas operations with unlimited history
- [ ] Measurement tools accurately measure distance, area, and angle
- [ ] Plant browser loads from database with search by name, category, zone, and attributes
- [ ] Drag-and-drop plant placement works with auto-scaling to plan scale
- [ ] Group placement supports mass planting, hedge rows, drifts, and random scatter patterns
- [ ] Plant symbols can be rotated, scaled, and mirrored with transform handles
- [ ] Symbol library includes plan view and elevation view for all species
- [ ] Text annotation supports configurable font, size, color, alignment, and rotation
- [ ] Dimension tools support linear, aligned, radial, and angular measurements
- [ ] Callout and leader tools create linked annotations to design elements
- [ ] Plant labels auto-populate from database and update when plant attributes change
- [ ] Legends auto-generate from placed plants and update dynamically
- [ ] Canvas performance remains smooth with 10,000+ placed plant symbols

## Dependencies

**Blocked by:**
- LAND-DESIGN-001: Foundation (plant database schema, design data model, canvas architecture)

**Blocks:**
- LAND-DESIGN-003: Discipline Integration (hardscape, grading, coordination)
- LAND-DESIGN-MOBILE-001: iOS Field Tools
- LAND-DESIGN-MOBILE-002: Android Site Tools
- LAND-DESIGN-WEB-001: Web Dashboard

## Estimated Duration

**6 weeks**

## Risk Level

**High** — CAD canvas performance with large plans is a significant technical challenge. Plant placement and annotation tools must be intuitive for landscape architects accustomed to traditional CAD software.
