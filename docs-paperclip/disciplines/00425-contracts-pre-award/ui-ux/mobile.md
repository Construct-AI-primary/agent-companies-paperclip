---
title: "00425 Contracts Pre-Award — Mobile UI/UX Specification"
description: "Mobile-specific UI/UX adaptations for the 00425 Contracts Pre-Award discipline page"
author: "DomainForge AI — Contracts Pre-Award Domain"
date: "2026-05-03"
version: "1.0"
status: "active"
gigabrain_tags: contracts, pre-award, ui-ux, specification, mobile, responsive, tender-management
related_docs:
  - docs-paperclip/disciplines/00425-contracts-pre-award/ui-ux/index.md
  - docs-paperclip/disciplines/00425-contracts-pre-award/ui-ux/desktop.md
platform: mobile
viewport: "< 768px"
---

# 00425 Contracts Pre-Award — Mobile UI/UX Specification

> **Platform**: Mobile (< 768px)
> **Part of**: [UI/UX Specification Index](./index.md)

## Overview

The mobile experience for the 00425 Contracts Pre-Award page is adapted from the full desktop specification. Mobile-specific adaptations ensure usability on smaller screens while maintaining functional parity for tender management, bid evaluation, and award recommendation workflows.

## Mobile Adaptations

The following adaptations apply to the mobile viewport (< 768px):

| Element | Desktop | Mobile |
|---------|---------|--------|
| Three-state nav | Full tab bar visible | Bottom tab bar |
| Tender list | Table with rows and filters | Card-based layout with status badges |
| Bid submission | Full document upload form | Simplified upload with camera capture option |
| Evaluation scoring | Full scoring matrix table | Simplified scoring input per criterion |
| Award recommendation | Multi-panel review | Single column, full-width action buttons |
| Touch targets | Standard | Minimum 48dp (per Material Design guidelines) |

## Key Mobile Patterns

### Bottom Tab Navigation
The three-state navigation (Agents, Upsert, Workspace) collapses from a horizontal tab bar to a bottom tab bar on mobile, providing thumb-reachable navigation.

### Card-Based Tender Layout
Instead of a table with rows, tenders display as stacked cards with key information (title, status, deadline, value) and action buttons, improving readability on small screens.

### Simplified Scoring Input
The evaluation scoring matrix is simplified on mobile — evaluators see one criterion at a time with a slider or numeric input, rather than the full matrix view.

### Notification-Driven Interactions
Mobile users receive push notifications for:
- Deadline reminders for upcoming tender submissions
- New bid submission alerts
- Evaluation assignment notifications
- Approval routing requests

## Note

Mobile-specific implementation details are handled separately by **MobileForge AI**. This document serves as a reference for the mobile adaptations derived from the desktop specification. For full implementation details, refer to the [desktop specification](./desktop.md).

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-05-03 | Initial mobile UI/UX specification for 00425 Contracts Pre-Award |

---

**Document Information**
- **Author**: DomainForge AI — Contracts Pre-Award Domain
- **Date**: 2026-05-03
- **Status**: Active
- **Next Review**: 2026-06-03
