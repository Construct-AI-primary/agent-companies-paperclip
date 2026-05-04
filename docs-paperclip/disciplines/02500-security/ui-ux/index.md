# 02500 Security — UI/UX Specification Index

**Version:** 1.0  
**Last Updated:** 2026-05-04  
**Status:** Draft

## Overview

This UI/UX specification defines the user interface and user experience for the Security discipline (02500) within the Paperclip ecosystem. The security system covers access control, surveillance, incident management, patrol operations, perimeter security, and emergency response across desktop, mobile, and web platforms.

## Color Scheme

| Role | Color | Hex | Usage |
|------|-------|-----|-------|
| Primary | Security Blue | `#1a237e` | Headers, primary buttons, navigation |
| Secondary | Alert Red | `#d32f2f` | Alerts, warnings, critical notifications |
| Success | Secure Green | `#2e7d32` | Authorized access, secure status |
| Warning | Caution Amber | `#f57f17` | Pending actions, warnings |
| Info | Surveillance Teal | `#00838f` | System status, informational |
| Danger | Intrusion Red | `#b71c1c` | Breach alerts, intrusion detection |

## Screen States

Every security screen supports four states:
1. **Loading** — Skeleton screens with security-themed placeholders
2. **Empty** — "No incidents" / "All clear" illustrations with guidance
3. **Error** — Error state with retry action and fallback procedures
4. **Data** — Full data presentation with real-time updates

## Platform Specifications

- [Desktop Specification](desktop.md) — Full-featured security operations center
- [Mobile Specification](mobile.md) — Field security personnel interface
- [Web Specification](web.md) — Browser-based security management

## Design Principles

1. **Situational Awareness** — Real-time status at a glance with color-coded indicators
2. **Rapid Response** — One-click actions for critical security events
3. **Chain of Custody** — Immutable audit trails for all security actions
4. **Offline Resilience** — Field operations continue without connectivity
5. **Role-Based Views** — Tailored interfaces for security officers, supervisors, and administrators