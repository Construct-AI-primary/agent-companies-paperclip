# 03000 Landscaping — Desktop UI/UX Specification

**Version:** 1.0  
**Last Updated:** 2026-05-04  
**Status:** Draft

## Overview

The desktop landscaping interface provides a comprehensive landscape design and management experience for landscape architects, designers, and project managers. It supports CAD-like design tools, planting plan creation, irrigation system design, and maintenance scheduling.

## Layout Structure

```
┌─────────────────────────────────────────────────────────────┐
│  Header: Landscape Logo | Project Name | User Menu          │
├──────────────────┬──────────────────────────────────────────┤
│  Left Toolbar    │  Main Content Area                       │
│  ┌──────────────┐│  ┌────────────────────────────────────┐ │
│  │ Select       ││  │  Design Canvas / Data View         │ │
│  │ Draw         ││  │                                    │ │
│  │ Plant        ││  │  (CAD canvas, planting plan,       │ │
│  │ Hardscape    ││  │   irrigation layout, or data grid) │ │
│  │ Measure      ││  │                                    │ │
│  │ Label        ││  └────────────────────────────────────┘ │
│  └──────────────┘│  ┌────────────────────────────────────┐ │
├──────────────────┤  │  Properties / Details Panel        │ │
│  Right Properties│  │  (Context-dependent)               │ │
│  Panel           │  └────────────────────────────────────┘ │
├──────────────────┴──────────────────────────────────────────┤
│  Footer: Scale | Coordinates | Layer | Status               │
└─────────────────────────────────────────────────────────────┘
```

## Common Components

### LAND-Toolbar
- Drawing tools (line, rectangle, circle, polygon, freehand)
- Plant selection palette with search and filters
- Hardscape material selector
- Measurement and annotation tools
- CSS class prefix: `.LAND-`

### LAND-PlantPalette
- Searchable plant database with filters (type, height, spread, sun, water)
- Visual thumbnails with key attributes
- Drag-to-canvas placement
- Favorites and recent selections

### LAND-PropertiesPanel
- Context-sensitive properties for selected elements
- Plant specifications (species, size, quantity, spacing)
- Hardscape materials (type, dimensions, finish, color)
- Layer management and visibility controls

### LAND-ScheduleView
- Gantt-style timeline for planting and maintenance
- Seasonal task calendar
- Resource allocation and crew assignment
- Weather-dependent task rescheduling

## Screen States

| State | Implementation |
|-------|---------------|
| Loading | Skeleton toolbar and canvas placeholder |
| Empty | "Start a new design" with template gallery |
| Error | Error banner with retry, auto-save recovery |
| Data | Full design canvas with layers and properties |

## Responsive Breakpoints

| Breakpoint | Width | Layout |
|------------|-------|--------|
| Desktop XL | >1920px | Full toolbar + dual monitor support |
| Desktop | 1366-1920px | Standard layout with side panels |
| Desktop Small | 1024-1366px | Collapsed tool panels, single inspector |

## Accessibility

- WCAG 2.1 AA compliance
- Keyboard shortcuts for all drawing tools
- Screen reader support for plant data and measurements
- High-contrast mode for outdoor site use
- Scalable canvas for zoom-dependent detail levels