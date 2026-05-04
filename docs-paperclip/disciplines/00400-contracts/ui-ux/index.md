---
title: "00400 Contracts UI/UX Specification — Master Index"
description: "Master index for the 00400 Contracts discipline UI/UX specification, covering desktop, mobile, and web platform breakdowns"
author: "DomainForge AI — Contracts Domain"
date: "2026-05-03"
version: "2.0"
status: "active"
tags: contracts, ui-ux, specification, index, contract-lifecycle, compliance, variation-management
related_docs:
  - docs-paperclip/templates/mermaid/contract-lifecycle.yaml
  - docs-paperclip/templates/mermaid/approval-matrix.yaml
  - docs-paperclip/templates/mermaid/hitl-review.yaml
  - orchestration/INTEGRATION-REGISTRY.md
  - docs-paperclip/companies/shared/i18n-translation-management/
platforms:
  desktop: "ui-ux/desktop.md"
  mobile: "ui-ux/mobile.md"
  web: "ui-ux/web.md"
---

# 00400 Contracts UI/UX Specification — Master Index

## Platform Breakdown

This specification is split into three platform-specific documents:

| Platform | Document | Description |
|----------|----------|-------------|
| **Desktop** | [`ui-ux/desktop.md`](desktop.md) | Full desktop UI/UX specification — contract lifecycle, approval routing, document assembly, compliance monitoring |
| **Mobile** | [`ui-ux/mobile.md`](mobile.md) | Mobile-specific adaptations — handled separately by MobileForge AI |
| **Web** | [`ui-ux/web.md`](web.md) | Web platform notes — handled via construct_ai web platform |

## Quick Reference

- **Route**: `/contracts`
- **Three-State Navigation**: Agents, Upsert, Workspace
- **Integration**: INT-001/INT-009 (Procurement), INT-002 (Pre-Award), INT-003 (Post-Award)

## Language Support

This application supports **9 languages** via the i18n translation management system:

| # | Language | Locale Code |
|---|----------|-------------|
| 1 | English | `en` |
| 2 | Afrikaans | `af` |
| 3 | Zulu (isiZulu) | `zu` |
| 4 | Xhosa (isiXhosa) | `xh` |
| 5 | Swahili (Kiswahili) | `sw` |
| 6 | French | `fr` |
| 7 | Portuguese | `pt` |
| 8 | Mandarin Chinese (中文) | `zh-CN` |
| 9 | Arabic (العربية) | `ar` |

All UI text, labels, buttons, and notifications must use i18n translation keys rather than hardcoded strings. See:
- [`docs-paperclip/companies/shared/i18n-translation-management/`](../../../companies/shared/i18n-translation-management/) — Shared i18n framework

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 2.0 | 2026-05-03 | Split into platform-specific files (desktop, mobile, web). Added language support reference. |
| 1.0 | 2026-05-03 | Initial UI/UX specification |