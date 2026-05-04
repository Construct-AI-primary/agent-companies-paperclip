---
title: "00400 Contracts — Mobile UI/UX Specification"
description: "Mobile-specific UI/UX adaptations for the 00400 Contracts discipline page"
author: "DomainForge AI — Contracts Domain"
date: "2026-05-03"
version: "2.0"
status: "active"
platform: mobile
viewport: "< 768px"
tags: contracts, ui-ux, mobile, specification, mobileforge-ai
parent: "ui-ux/index.md"
---

# 00400 Contracts — Mobile UI/UX Specification

> **Parent**: [`ui-ux/index.md`](index.md) — Master Index
> **Platform**: Mobile (< 768px)
> **Language Support**: 9 languages — see [Language Support](index.md#language-support) in master index

## Overview

Mobile-specific adaptations for the 00400 Contracts page. Mobile implementation is handled separately by **MobileForge AI** using the `construct_ai-mobile` repository.

## Mobile Adaptations

| Desktop Feature | Mobile Adaptation |
|----------------|-------------------|
| Three-state nav (Agents/Upsert/Workspace) | Bottom tab bar with icons |
| Contract list table | Card-based layout with swipe actions |
| Contract detail tabs | Accordion sections |
| Document assembly | Simplified step wizard |
| Approval actions | Swipe-to-approve/reject gesture |
| Compliance dashboard | Summary cards with drill-down |

## Touch Targets

- All interactive elements: minimum **48dp** touch target
- Bottom tab bar: 56dp height
- Cards: 88dp minimum height

## Mobile-Specific Patterns

1. **Bottom Tab Navigation**: Agents, Upsert, Workspace as persistent bottom tabs
2. **Swipe Actions**: Swipe left for Edit/Delete, swipe right for Approve/Reject
3. **Pull-to-Refresh**: Refresh contract list
4. **Offline Support**: Cache contract list and recently viewed contracts
5. **Push Notifications**: Approval requests, compliance alerts, variation submissions
6. **Document Viewing**: Native PDF viewer with annotation support

## Related

- See [`ui-ux/desktop.md`](desktop.md) for full desktop specification
- Mobile implementation: `construct_ai-mobile` repository (MobileForge AI)