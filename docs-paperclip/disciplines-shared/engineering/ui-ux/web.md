---
title: "Cross-Discipline Engineering Platform — UI/UX Specification (Web)"
description: "Web-specific UI/UX adaptations for the shared engineering platform — handled via construct_ai web platform"
author: "PaperclipForge AI — UI/UX Design Coordination"
date: "2026-04-28"
version: "1.0"
status: "active"
gigabrain_tags: engineering, ui-ux, specification, web, cross-discipline
platform: web
viewport: "768px - 1279px"
---

# Cross-Discipline Engineering Platform — UI/UX Specification (Web)

> **Viewport**: 768px - 1279px (Tablet)
> **Platform**: Web — handled via **construct_ai web platform**

## Overview

The web (tablet) implementation of the Cross-Discipline Engineering Platform is handled via the **construct_ai web platform**. This document serves as a placeholder and reference point for web/tablet-specific adaptations derived from the full desktop specification.

## Web/Tablet Adaptations (from Desktop Spec)

The following web/tablet adaptations are extracted from the desktop specification (see [desktop.md](desktop.md) for full context):

### Navigation
- Three-state nav collapses to a **dropdown selector**
- Discipline selector as a dropdown or slide-out panel

### CAD Viewer
- Full-width viewer, tools panel as a **slide-out drawer**
- No persistent side-by-side layout

### Agent Grid
- 2 columns (instead of 3-4 on desktop)

### Record Table
- Responsive table showing **key columns only**
- Additional columns accessible via expand/collapse

### HITL Queue
- **Stacked layout** (AI output above, human actions below)
- Full-width action buttons

## Responsibility

All web/tablet-specific UI/UX implementation, responsive design, and cross-browser testing is handled via the **construct_ai web platform**. Refer to construct_ai documentation for:

- Responsive CSS framework and breakpoint implementation
- Tablet-specific component adaptations
- Cross-browser compatibility requirements
- Web performance budgets
- Progressive enhancement patterns

## Related Documents

- [index.md](index.md) — Master index with platform links
- [desktop.md](desktop.md) — Full desktop specification (source of truth for all patterns)

---

**Document Information**
- **Author**: PaperclipForge AI — UI/UX Design Coordination
- **Date**: 2026-04-28
- **Status**: Active
