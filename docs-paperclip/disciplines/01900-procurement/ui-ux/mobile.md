---
title: "01900 Procurement — Mobile UI/UX Specification"
description: "Mobile-specific UI/UX adaptations for the 01900 Procurement discipline page"
author: "DomainForge AI — Procurement Domain"
date: "2026-05-03"
version: "2.0"
status: "active"
platform: mobile
viewport: "< 768px"
tags: procurement, ui-ux, mobile, specification, mobileforge-ai
parent: "ui-ux/index.md"
---

# 01900 Procurement — Mobile UI/UX Specification

> **Parent**: [`ui-ux/index.md`](index.md) — Master Index
> **Platform**: Mobile (< 768px)
> **Language Support**: 9 languages — see [Language Support](index.md#language-support) in master index

## Overview

Mobile-specific adaptations for the 01900 Procurement page. Mobile implementation is handled separately by **MobileForge AI** using the `construct_ai-mobile` repository.

## Mobile Adaptations

| Desktop Feature | Mobile Adaptation |
|----------------|-------------------|
| Three-state nav (Agents/Upserts/Workspace) | Bottom tab bar with icons |
| Agent grid (3 columns) | Single column card list |
| Supplier table | Card-based layout with swipe actions |
| Modal (98vw) | Full-screen modal with slide-up transition |
| HITL Review Queue | Simplified queue with priority badges |
| Chatbot (z-index 1500) | Floating action button (FAB) |
| Import CSV/Excel | Camera-based document capture + file upload |
| Generate PO | Simplified form with autofill |

## Touch Targets

- All interactive elements: minimum **48dp** touch target
- Bottom tab bar: 56dp height
- Cards: 88dp minimum height
- FAB: 56dp diameter

## Mobile-Specific Patterns

1. **Bottom Tab Navigation**: Agents, Upserts, Workspace as persistent bottom tabs
2. **Swipe Actions**: Swipe left on supplier cards for Edit/Delete, swipe right for Approve/Reject
3. **Pull-to-Refresh**: Refresh procurement data
4. **Offline Support**: Cached supplier list, queued actions sync when online
5. **Push Notifications**: HITL review assignments, approval requests

## Related

- See [`ui-ux/desktop.md`](desktop.md) for full desktop specification
- Mobile implementation: `construct_ai-mobile` repository (MobileForge AI)