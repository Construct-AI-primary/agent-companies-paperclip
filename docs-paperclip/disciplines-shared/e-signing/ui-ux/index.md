---
title: "ESIGN — e-Signing UI/UX Specification Index"
description: "Master index for the e-Signing UI/UX specification — digital signature capture, signature workflow engine, document template field embedding, and cross-discipline HITL approval integration"
author: "DomainForge AI — e-Signing Domain"
date: "2026-05-04"
version: "1.0"
status: "active"
gigabrain_tags: e-signing, digital-signature, hitl, approval-workflow, doc-signing, signature-capture
related_docs:
  - docs-paperclip/disciplines/01300-governance/UI-UX-SPECIFICATION.md
  - docs-paperclip/disciplines/00900-document-control/UI-UX-SPECIFICATION.md
  - docs-paperclip/disciplines/01900-procurement/UI-UX-SPECIFICATION.md
  - docs-paperclip/disciplines/01700-logistics/UI-UX-SPECIFICATION.md
  - docs-paperclip/disciplines-shared/e-signing/projects/ESIGN-INTEGRATION/desktop/issues/ESIGN-001-foundation.md
  - orchestration/INTEGRATION-REGISTRY.md
platforms:
  desktop: disciplines-shared/e-signing/ui-ux/desktop.md
  mobile: disciplines-shared/e-signing/ui-ux/mobile.md
  web: disciplines-shared/e-signing/ui-ux/web.md
---

# ESIGN — e-Signing UI/UX Specification

## Platform Links

- [Desktop UI/UX Specification](desktop.md) — Full desktop specification including signature capture components, workflow diagrams, implementation standards, screen specs, and cross-discipline integration.
- [Mobile UI/UX Specification](mobile.md) — Mobile-specific adaptations and notes. Mobile implementation is handled by **MobileForge AI** separately.
- [Web UI/UX Specification](web.md) — Web platform adaptations. Web implementation is handled via the **construct_ai web platform**.

## Overview

The e-Signing discipline provides digital signature capabilities as a shared service consumed by all discipline pages. It does not have its own three-state page (Agents, Upserts, Workspace) but instead embeds signature capture components and workflow triggers into existing discipline pages.

### Integration Pattern

- **01300 Governance**: Signature routing embedded in approval matrix
- **00900 Document Control**: Signature fields embedded in document templates
- **01900 Procurement**: Signature capture in PO and tender approval modals
- **01700 Logistics**: Signature capture in delivery and weighbridge sign-off
- **02400 Safety**: Signature capture in SDS and incident report approval

### Information Architecture

- **Accordion Section**: Shared Services
- **Accordion Subsection**: e-Signing
- **Icon**: Pen / signature icon
- **Route**: `/e-signing`

### Color Scheme

```css
:root {
  --esign-primary: #2E7D32;
  --esign-secondary: #4CAF50;
  --esign-accent: #1B5E20;
  --esign-bg-gradient: linear-gradient(135deg, #f1f8e9 0%, #e8f5e9 100%);
  --esign-header-gradient: linear-gradient(135deg, #2E7D32 0%, #4CAF50 100%);
  --esign-text-primary: #000000;
  --esign-text-secondary: #6c757d;
  --esign-text-white: #ffffff;
  --esign-shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.05);
  --esign-shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
  --esign-shadow-lg: 0 8px 24px rgba(46, 125, 50, 0.3);
  --esign-signature-blue: #1565C0;
  --esign-signature-green: #2E7D32;
  --esign-signature-pending: #FFA000;
  --esign-signature-completed: #2E7D32;
  --esign-signature-expired: #C62828;
}
```

### Signature States

Every signature request passes through the following states:

| State | Description | Visual Indicator |
|-------|-------------|-----------------|
| **Pending** | Signature request sent, awaiting signer action | Amber badge, clock icon |
| **Viewed** | Signer has opened the document | Blue badge, eye icon |
| **Signed** | Signer has completed signing | Green badge, checkmark icon |
| **Declined** | Signer has declined to sign | Red badge, X icon |
| **Expired** | Signature deadline has passed | Dark red badge, warning icon |
| **Cancelled** | Request was cancelled by sender | Grey badge, ban icon |

### Signature Capture Methods

| Method | Description | Use Case | Accessibility |
|--------|-------------|----------|---------------|
| **Draw** | Signer draws signature on canvas using mouse/touch | Desktop & mobile signing | Requires fine motor control |
| **Type** | Signer types name, rendered in cursive font | Quick signing, accessibility | Screen reader compatible |
| **Upload** | Signer uploads an image of their signature | Reuse existing signature | Requires image file |
| **PKI** | Certificate-based digital signature | High-compliance signing | Requires digital certificate |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-05-04 | Initial UI/UX specification for e-Signing discipline |

---

**Document Information**
- **Author**: DomainForge AI — e-Signing Domain
- **Date**: 2026-05-04
- **Status**: Active
