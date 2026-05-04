---
title: "Cross-Discipline Measurement Platform — UI/UX Specification (Web)"
description: "Web platform UI/UX notes for the shared measurement platform — construct_ai web platform integration, responsive adaptations, browser-based measurement tools"
author: "MeasureForge AI — UI/UX Design Coordination"
date: "2026-04-28"
version: "1.0"
status: "active"
platform: "web"
gigabrain_tags: measurement, ui-ux, specification, web, construct-ai, responsive, browser
related_docs:
  - docs-construct-ai/standards/0000_VISUAL_DESIGN_STANDARDS.md
  - docs-construct-ai/standards/0000_PAGE_ARCHITECTURE_GUIDE.md
  - docs-construct-ai/standards/0000_ALL_PAGES_ONLY.md
  - docs-construct-ai/codebase/guides/styling/0000_CSS_STANDARDIZATION_GUIDE.md
  - docs-construct-ai/codebase/audits/0950_ACCORDION_MANAGEMENT_AUDIT.md
  - docs-construct-ai/codebase/guides/developer/0170_MODAL_DOCUMENTATION_MASTER_GUIDE.md
  - docs-construct-ai/codebase/guides/developer/0750_DROPDOWN_MASTER_GUIDE.md
  - docs-construct-ai/codebase/guides/developer/1300_PAGES_CHATBOT_MASTER_GUIDE.md
  - docs-construct-ai/codebase/guides/developer/1500_MERMAID_MASTER_GUIDE.md
---

# Cross-Discipline Measurement Platform — UI/UX Specification (Web)

> **Platform**: Web (browser-based)
> **Source**: Derived from the master UI-UX-SPECIFICATION.md
> **Note**: Web platform is handled via the **construct_ai web platform**. This document covers web-specific integration notes, responsive adaptations, and browser-based measurement tooling.

## Table of Contents

1. [Web Platform Integration](#web-platform-integration)
2. [Responsive Adaptations](#responsive-adaptations)
3. [Browser-Based Measurement Tools](#browser-based-measurement-tools)
4. [Related Specifications](#related-specifications)

---

## Web Platform Integration

### construct_ai Web Platform

The measurement platform is delivered through the **construct_ai web platform**, which provides:

- **Accordion Navigation**: Measurement section (display_order: 2025) with per-function measurement pages
- **Route Structure**: `/#/drawing-measurements`, `/#/technical-drawings`, and future routes `/#/transmittals`, `/#/clash-detection`
- **Template B Architecture**: Three-state navigation (Agents, Upsert, Workspace) with state-aware AI assistance
- **Chatbot Integration**: Template B chatbot with z-index 1500, state-aware behavior adapting to measurement context
- **Modal System**: 98vw modals with teal gradient headers per the 0170 standard

### CSS Architecture

```css
/* 1. Template A Standard (master template) */
@import "../../templates/template-a-standard.css";

/* 2. Measurement Shared Components */
@import "../../shared/measurement/components/core.css";

/* 3. Page-Specific Measurement Styles */
@import "02025-measurement-page-style.css";
```

### Key Web Technologies

- **CAD Viewer**: Browser-based DWG/DXF/PDF/IFC rendering via WebGL/Canvas
- **PWA Support**: Offline-capable progressive web app for on-site measurement
- **Web Workers**: Background processing for CAD parsing and OCR
- **WebAssembly**: High-performance CAD geometry processing
- **IndexedDB**: Offline storage for measurement queue and site inventory

## Responsive Adaptations

### Desktop (1280px+)

- Full three-state navigation visible
- CAD Takeoff: 60% viewer, 40% measurement panel (side-by-side)
- Measurement Grid: full width with horizontal scroll
- BOQ Composer: full width with trade package sidebar
- Tender Portal: bid table with evaluation panel

### Tablet (768px - 1279px)

- Three-state nav collapses to dropdown
- CAD Takeoff: full width, measurement panel as slide-out drawer
- Measurement Grid: responsive, key columns only
- BOQ Composer: stacked layout
- Tender Portal: bid list with expandable details

### Mobile (< 768px)

- Three-state nav as bottom tab bar
- CAD Takeoff: full width, measurement tools as floating action button
- Measurement Grid: card-based layout
- BOQ Composer: single column
- Tender Portal: swipeable bid cards
- Touch targets: minimum 48dp

## Browser-Based Measurement Tools

### CAD File Import

Supported formats: DWG, DXF, PDF, IFC, RVT
Browser-based upload with format detection and preview.

### AI-Assisted Takeoff

Automatic detection of areas, lengths, volumes, and counts using AI vision models running in-browser or via API.

### Scale Calibration

Set drawing scale, calibrate measurements, handle viewport scaling — all within the browser CAD viewer.

### Manual Takeoff Tools

Polyline area measurement, linear measurement, count tool, hatch area detection — browser-based drawing tools.

### Standards Compliance

Real-time validation against SANS 1200, NRM2, SMM7, CESMM4 — results displayed in-browser with pass/fail per line item.

## Related Specifications

For the full specification including all parts (A–J), see:

- [Desktop Specification](desktop.md) — Full specification for desktop (1280px+)
- [Mobile Specification](mobile.md) — Mobile-specific on-site measurement (MobileForge AI)

---

## Version History

| Version | Date       | Changes                                                               |
| ------- | ---------- | --------------------------------------------------------------------- |
| 1.0     | 2026-04-28 | Initial web UI/UX specification for Cross-Discipline Measurement Platform |

---

**Document Information**

- **Author**: MeasureForge AI — UI/UX Design Coordination
- **Date**: 2026-04-28
- **Status**: Active
- **Next Review**: 2026-05-28
