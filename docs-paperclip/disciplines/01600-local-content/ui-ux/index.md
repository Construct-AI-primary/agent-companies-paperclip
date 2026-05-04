# 01600 Local Content — UI/UX Specification Index

**Version:** 1.0  
**Last Updated:** 2026-05-18  
**Status:** Draft

## Overview

This UI/UX specification defines the user interface and user experience for the Local Content discipline (01600) within the Paperclip ecosystem. The local content system covers local employment tracking, procurement management, enterprise development, skills transfer, and compliance reporting across desktop, mobile, and web platforms.

## Color Scheme

| Role | Color | Hex | Usage |
|------|-------|-----|-------|
| Primary | Local Blue | `#1565c0` | Headers, primary buttons, navigation |
| Secondary | Development Green | `#2e7d32` | Local content targets met, compliance passed |
| Warning | Compliance Gold | `#f9a825` | Pending compliance items, approaching targets |
| Danger | Alert Red | `#d32f2f` | Missed targets, compliance failures |
| Info | Skills Teal | `#00838f` | Skills transfer data, training information |

## Screen States

Every local content screen supports four states:
1. **Loading** — Skeleton screens with local content themed placeholders
2. **Empty** — "No data" illustrations with guidance for first-time setup
3. **Error** — Error state with retry action and fallback procedures
4. **Data** — Full data presentation with real-time updates

## Platform Specifications

- [Desktop Specification](desktop.md) — Full-featured local content management center
- [Mobile Specification](mobile.md) — Field local content officer interface
- [Web Specification](web.md) — Browser-based local content management

## Design Principles

1. **Compliance First** — Regulatory requirements drive UI priorities and data visibility
2. **Target Tracking** — Clear visual indicators of localisation targets vs actual performance
3. **Audit Ready** — All data presented with source verification and audit trail access
4. **Multi-Platform** — Consistent experience across desktop, mobile, and web
5. **Role-Based Views** — Tailored interfaces for local content officers, managers, and administrators
