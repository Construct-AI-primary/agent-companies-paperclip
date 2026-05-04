---
title: "ESIGN — e-Signing UI/UX Specification (Mobile)"
description: "Mobile UI/UX specification for the e-Signing discipline — mobile-specific adaptations and notes"
author: "DomainForge AI — e-Signing Domain"
date: "2026-05-04"
version: "1.0"
status: "active"
platform: mobile
gigabrain_tags: e-signing, digital-signature, mobile, touch-signing, biometric
related_docs:
  - ../ui-ux/index.md
  - ../ui-ux/desktop.md
  - ../ui-ux/web.md
---

# ESIGN — e-Signing UI/UX Specification (Mobile)

## Platform Status

**Mobile implementation is handled by MobileForge AI separately.**

This document serves as a placeholder and reference for mobile-specific adaptations derived from the full e-Signing UI/UX specification.

## Mobile Adaptations (from Desktop Spec)

The following mobile-specific adaptations are noted in the full specification (see [desktop.md](desktop.md) for complete details):

### Screen Adaptations (< 768px)

- **Signature Canvas**: Optimized for touch input
- **Document Preview**: Hidden by default to maximize signing area
- **Signature Dashboard**: Rendered as a scrollable list (card layout)
- **Biometric Authentication**: Face ID / fingerprint support

### Signature Capture Methods

All four capture methods are supported on mobile:
- **Draw**: Touch-optimized canvas for finger/stylus drawing
- **Type**: Cursive font rendering of typed name
- **Upload**: Camera roll / file picker integration
- **PKI**: Certificate-based signing (with mobile certificate store)

### Signature States

| State | Description | Visual Indicator |
|-------|-------------|-----------------|
| **Pending** | Signature request sent, awaiting signer action | Amber badge, clock icon |
| **Viewed** | Signer has opened the document | Blue badge, eye icon |
| **Signed** | Signer has completed signing | Green badge, checkmark icon |
| **Declined** | Signer has declined to sign | Red badge, X icon |
| **Expired** | Signature deadline has passed | Dark red badge, warning icon |
| **Cancelled** | Request was cancelled by sender | Grey badge, ban icon |

## Mobile-Specific Considerations

- **Offline Support**: Signature capture should work offline with queue-based sync
- **Push Notifications**: Signature requests should trigger push notifications
- **Deep Linking**: Signature request links should open directly in the mobile app
- **Camera Integration**: For document scanning and signature upload
- **Touch Gestures**: Pinch-to-zoom on documents, swipe-to-dismiss modals
- **Responsive Layout**: Single-column layout with bottom-sheet modals

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-05-04 | Initial mobile placeholder for e-Signing UI/UX specification |

---

**Document Information**
- **Author**: DomainForge AI — e-Signing Domain
- **Date**: 2026-05-04
- **Status**: Active
