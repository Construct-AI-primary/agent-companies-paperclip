---
title: "00860 Electrical Engineering — Mobile UI/UX Specification"
description: "Mobile-specific UI/UX adaptations for the 00860 Electrical Engineering discipline page"
author: "DomainForge AI — Electrical Engineering Domain"
date: "2026-04-28"
version: "1.0"
status: "active"
gigabrain_tags: electrical-engineering, ui-ux, specification, mobile, responsive
related_docs:
  - docs-paperclip/disciplines/00860-electrical-engineering/ui-ux/index.md
  - docs-paperclip/disciplines/00860-electrical-engineering/ui-ux/desktop.md
platform: mobile
viewport: "< 768px"
---

# 00860 Electrical Engineering — Mobile UI/UX Specification

> **Platform**: Mobile (< 768px)
> **Part of**: [UI/UX Specification Index](./index.md)

## Overview

The mobile experience for the 00860 Electrical Engineering page is adapted from the full desktop specification. Mobile-specific adaptations ensure usability on smaller screens while maintaining functional parity.

## Mobile Adaptations

The following adaptations apply to the mobile viewport (< 768px):

| Element | Desktop | Mobile |
|---------|---------|--------|
| Three-state nav | Full tab bar visible | Bottom tab bar |
| CAD Viewer | 70% width + 30% tools panel | Full width, tools as floating action button |
| Agent grid | 3-4 columns | 1 column |
| Record table | Full-width table with horizontal scroll | Card-based layout |
| HITL Queue | Side-by-side review | Single column, full-width action buttons |
| Touch targets | Standard | Minimum 48dp (per Material Design guidelines) |

## Key Mobile Patterns

### Bottom Tab Navigation
The three-state navigation (Agents, Upsert, Workspace) collapses from a horizontal tab bar to a bottom tab bar on mobile, providing thumb-reachable navigation.

### Card-Based Record Layout
Instead of a table with rows, mobile displays records as stacked cards with key information and action buttons, improving readability on small screens.

### Floating Action Button (FAB)
The CAD Viewer tools panel becomes a floating action button on mobile, preserving screen real estate while keeping tools accessible.

## Note

Mobile-specific implementation details are handled separately by **MobileForge AI**. This document serves as a reference for the mobile adaptations derived from the desktop specification. For full implementation details, refer to the [desktop specification](./desktop.md).

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-28 | Initial mobile UI/UX specification for 00860 Electrical Engineering |

---

**Document Information**
- **Author**: DomainForge AI — Electrical Engineering Domain
- **Date**: 2026-04-28
- **Status**: Active
- **Next Review**: 2026-05-28
