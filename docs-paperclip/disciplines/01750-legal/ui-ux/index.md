---
title: "01750 Legal UI/UX Specification — Master Index"
description: "Master index for the 01750 Legal discipline UI/UX specification, covering desktop, mobile, and web platform breakdowns"
author: "DomainForge AI — Legal Domain"
date: "2026-05-03"
version: "2.0"
status: "active"
tags: legal, ui-ux, specification, index, contracts, claims, compliance, governance
related_docs:
  - docs-paperclip/templates/mermaid/legal-contract-lifecycle.yaml
  - docs-paperclip/templates/mermaid/claims-resolution.yaml
  - docs-paperclip/templates/mermaid/compliance-monitoring.yaml
  - orchestration/INTEGRATION-REGISTRY.md
  - docs-paperclip/companies/shared/i18n-translation-management/
platforms:
  desktop: "ui-ux/desktop.md"
  mobile: "ui-ux/mobile.md"
  web: "ui-ux/web.md"
---

# 01750 Legal UI/UX Specification — Master Index

## Color Scheme

| Role | Color | Hex Code | Usage |
|------|-------|----------|-------|
| **Legal Navy** | Primary | `#1a237e` | Primary headers, navigation, main branding |
| **Contract Blue** | Secondary | `#1565c0` | Contract management UI elements, action buttons |
| **Dispute Amber** | Warning | `#ff8f00` | Claims & dispute resolution indicators, alerts |
| **Compliance Green** | Success | `#2e7d32` | Compliance status, approved items, positive indicators |
| **Risk Red** | Danger | `#c62828` | Legal risk indicators, critical alerts, violations |
| **Document Grey** | Neutral | `#546e7a` | Document management, secondary text, metadata |
| **Governance Purple** | Accent | `#6a1b9a` | Corporate governance, board-related UI elements |
| **Background Light** | Surface | `#f5f5f5` | Page backgrounds, card surfaces |
| **Text Dark** | Text | `#212121` | Primary text, headings |

## Screen States

All legal management screens support the following states:

| State | Description | Visual Indicator |
|-------|-------------|-----------------|
| **Loading** | Initial data fetch or processing | Skeleton loaders with Legal Navy shimmer animation |
| **Empty** | No data available | Illustration with contextual message and CTA |
| **Error** | Failed operation | Error banner with retry option, Risk Red accent |
| **Success** | Operation completed | Success toast with Compliance Green checkmark |
| **Offline** | Network unavailable | Offline indicator bar with cached data notice |
| **Warning** | Non-critical issue | Warning banner with Dispute Amber icon |

## Design Principles

1. **Clarity & Precision** — Legal information must be presented with absolute clarity. Use precise terminology, unambiguous labels, and structured layouts that mirror legal document conventions.

2. **Hierarchy & Structure** — Organize information hierarchically: contract summaries → clause details → supporting documents. Use progressive disclosure to manage complexity.

3. **Traceability** — Every action must be traceable. Display audit trails, version histories, and approval chains prominently. Users must be able to see who did what and when.

4. **Risk Visibility** — Legal risks must be immediately visible. Use color-coded indicators (Amber for disputes, Green for compliance, Red for violations) to surface critical information at a glance.

5. **Consistency** — Maintain consistent terminology, layout patterns, and interaction models across all legal modules (contracts, claims, compliance, documents).

6. **Accessibility** — Meet WCAG 2.1 AA standards. Ensure sufficient color contrast, keyboard navigation, screen reader support, and focus indicators.

## Platform Breakdown

This specification is split into three platform-specific documents:

| Platform | Document | Description |
|----------|----------|-------------|
| **Desktop** | [`ui-ux/desktop.md`](desktop.md) | Full desktop UI/UX specification — legal management with contract lifecycle, claims dashboard, dispute resolution tracker, compliance monitor, document manager |
| **Mobile** | [`ui-ux/mobile.md`](mobile.md) | Mobile-specific adaptations for legal counsel — contract approvals, claims intake, document review |
| **Web** | [`ui-ux/web.md`](web.md) | Web platform notes for browser-based legal management — dashboard, case management, reporting |

## Quick Reference

- **Route**: `/legal`
- **Three-State Navigation**: Agents, Upsert, Workspace
- **Integration**: INT-LEGAL-001 (Contracts), INT-LEGAL-002 (Claims), INT-LEGAL-003 (Compliance), INT-LEGAL-004 (Documents)

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
| 2.0 | 2026-05-03 | Split into platform-specific files (desktop, mobile, web). Added color scheme, screen states, design principles. |
| 1.0 | 2026-05-03 | Initial UI/UX specification |
