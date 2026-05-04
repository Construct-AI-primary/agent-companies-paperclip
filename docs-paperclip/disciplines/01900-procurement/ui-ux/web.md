---
title: "01900 Procurement — Web UI/UX Specification"
description: "Web-specific UI/UX notes for the 01900 Procurement discipline page"
author: "DomainForge AI — Procurement Domain"
date: "2026-05-03"
version: "2.0"
status: "active"
platform: web
viewport: "responsive"
tags: procurement, ui-ux, web, specification, construct-ai
parent: "ui-ux/index.md"
---

# 01900 Procurement — Web UI/UX Specification

> **Parent**: [`ui-ux/index.md`](index.md) — Master Index
> **Platform**: Web (responsive)
> **Language Support**: 9 languages — see [Language Support](index.md#language-support) in master index

## Overview

Web platform notes for the 01900 Procurement page. Web implementation is handled via the `construct_ai` web platform.

## Web-Specific Considerations

| Aspect | Detail |
|--------|--------|
| **Routing** | `/procurement` route via construct_ai router |
| **State Management** | Shared state with desktop via construct_ai state layer |
| **Component Library** | Reuses construct_ai web component library |
| **Responsive Breakpoints** | 1280px+ (desktop), 768-1279px (tablet), <768px (mobile) |
| **Browser Support** | Modern browsers (Chrome, Firefox, Safari, Edge) |

## Related

- See [`ui-ux/desktop.md`](desktop.md) for full desktop specification
- Web implementation: `construct_ai` web platform