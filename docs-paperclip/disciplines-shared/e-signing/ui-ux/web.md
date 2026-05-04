---
title: "ESIGN — e-Signing UI/UX Specification (Web)"
description: "Web UI/UX specification for the e-Signing discipline — web platform adaptations"
author: "DomainForge AI — e-Signing Domain"
date: "2026-05-04"
version: "1.0"
status: "active"
platform: web
gigabrain_tags: e-signing, digital-signature, web, browser-signing
related_docs:
  - ../ui-ux/index.md
  - ../ui-ux/desktop.md
  - ../ui-ux/mobile.md
---

# ESIGN — e-Signing UI/UX Specification (Web)

## Platform Status

**Web implementation is handled via the construct_ai web platform.**

This document serves as a placeholder and reference for web-specific adaptations derived from the full e-Signing UI/UX specification.

## Web Adaptations (from Desktop Spec)

The following web-specific adaptations are noted in the full specification (see [desktop.md](desktop.md) for complete details):

### Screen Adaptations

- **Responsive Design**: Adapts to browser viewport sizes
- **Cross-Browser Support**: Chrome, Firefox, Safari, Edge
- **Web Authentication**: WebAuthn / FIDO2 for PKI signing
- **Canvas API**: HTML5 Canvas for draw-based signature capture
- **File API**: Drag-and-drop / file picker for signature upload

### Signature Capture Methods

All four capture methods are supported on web:
- **Draw**: HTML5 Canvas with mouse/touch input
- **Type**: CSS cursive font rendering of typed name
- **Upload**: File input with image preview
- **PKI**: Browser-based certificate selection (WebAuthn)

### Signature States

| State | Description | Visual Indicator |
|-------|-------------|-----------------|
| **Pending** | Signature request sent, awaiting signer action | Amber badge, clock icon |
| **Viewed** | Signer has opened the document | Blue badge, eye icon |
| **Signed** | Signer has completed signing | Green badge, checkmark icon |
| **Declined** | Signer has declined to sign | Red badge, X icon |
| **Expired** | Signature deadline has passed | Dark red badge, warning icon |
| **Cancelled** | Request was cancelled by sender | Grey badge, ban icon |

## Web-Specific Considerations

- **Browser Storage**: IndexedDB for offline signature queue
- **Service Workers**: Background sync for pending signature submissions
- **WebSockets**: Real-time signature request notifications
- **PDF.js**: In-browser document preview for signature placement
- **Accessibility**: WCAG 2.1 AA compliance for all signature methods
- **Responsive Breakpoints**: Desktop (1280px+), Tablet (768-1279px), Mobile (<768px)

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-05-04 | Initial web placeholder for e-Signing UI/UX specification |

---

**Document Information**
- **Author**: DomainForge AI — e-Signing Domain
- **Date**: 2026-05-04
- **Status**: Active
