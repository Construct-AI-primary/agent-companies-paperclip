---
title: "Cross-Discipline Engineering Platform — UI/UX Specification (Mobile)"
description: "Mobile-specific UI/UX adaptations for the shared engineering platform — handled by MobileForge AI separately"
author: "PaperclipForge AI — UI/UX Design Coordination"
date: "2026-04-28"
version: "1.0"
status: "active"
gigabrain_tags: engineering, ui-ux, specification, mobile, cross-discipline
platform: mobile
viewport: "< 768px"
---

# Cross-Discipline Engineering Platform — UI/UX Specification (Mobile)

> **Viewport**: < 768px
> **Platform**: Mobile — handled by **MobileForge AI** separately

## Overview

The mobile implementation of the Cross-Discipline Engineering Platform is managed by **MobileForge AI** as a separate concern. This document serves as a placeholder and reference point for mobile-specific adaptations derived from the full desktop specification.

## Mobile Adaptations (from Desktop Spec)

The following mobile adaptations are extracted from the desktop specification (see [desktop.md](desktop.md) for full context):

### Navigation
- Three-state nav (Agents, Upsert, Workspace) rendered as a **bottom tab bar**
- Discipline selector as a full-screen picker or dropdown

### CAD Viewer
- Full-width viewer with tools as a **floating action button (FAB)**
- No side-by-side layout — tools panel slides up from bottom

### Agent Grid
- Single column layout (1 column instead of 3-4)

### Record Table
- **Card-based layout** instead of tabular rows
- Key fields only, expandable for details

### HITL Queue
- Single column, full-width action buttons
- Stacked layout (AI output above, human actions below)

### Touch Targets
- Minimum **48dp** touch targets (per Material Design guidelines)

## Responsibility

All mobile-specific UI/UX implementation, testing, and optimization is handled by **MobileForge AI**. Refer to MobileForge AI documentation for:

- Mobile-specific component library
- Responsive breakpoint implementation
- Touch interaction patterns
- Mobile performance budgets
- Offline capability requirements

## Related Documents

- [index.md](index.md) — Master index with platform links
- [desktop.md](desktop.md) — Full desktop specification (source of truth for all patterns)

---

**Document Information**
- **Author**: PaperclipForge AI — UI/UX Design Coordination
- **Date**: 2026-04-28
- **Status**: Active
