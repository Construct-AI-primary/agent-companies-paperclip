# 01400 Health — UI/UX Specification Index

**Version:** 1.0
**Last Updated:** 2026-05-04
**Status:** Draft

## Overview

This UI/UX specification defines the user interface and user experience for the Health discipline (01400) within the Paperclip ecosystem. The health system covers medical surveillance, health incident management, fitness for work tracking, health risk assessment, and medical emergency response across desktop, mobile, and web platforms.

## Color Scheme

| Role | Color | Hex | Usage |
|------|-------|-----|-------|
| Primary | Health Blue | `#0277bd` | Headers, primary buttons, navigation, medical surveillance |
| Secondary | Medical Green | `#2e7d32` | Fit for work status, cleared health checks, medical clearance |
| Alert | Alert Red | `#c62828` | Health alerts, incident criticality, unfit for work |
| Warning | Caution Amber | `#f57f17` | Pending health assessments, review required |
| Info | Surveillance Teal | `#00838f` | System status, informational, health screening |
| Danger | Medical Red | `#b71c1c` | Emergency response, critical health incidents |
| Neutral | Stone Gray | `#607d8b` | Secondary text, disabled states, form labels |

## Screen States

Every health screen supports four states:
1. **Loading** — Skeleton screens with health-themed placeholders (pulsing EKG-style animation)
2. **Empty** — "No health records" / "All clear" illustrations with guidance text
3. **Error** — Error state with retry action and fallback to last known good data
4. **Data** — Full data presentation with real-time health monitoring updates

## Platform Specifications

- [Desktop Specification](desktop.md) — Full-featured health management workstation
- [Mobile Specification](mobile.md) — Field health officer interface for on-site checks
- [Web Specification](web.md) — Browser-based health management and reporting

## Design Principles

1. **Health First** — All interactions prioritize patient/worker health outcomes and data accuracy
2. **Clinical Accuracy** — Medical data displayed with precision and clarity, no ambiguity
3. **Rapid Response** — One-click emergency actions for critical health events
4. **Confidentiality** — HIPAA/GDPR-compliant data handling with role-based access
5. **Continuity of Care** — Seamless data flow across surveillance, incidents, and assessments
6. **Offline Resilience** — Field health checks continue without connectivity, sync when online
7. **Evidence-Based** — All health data linked to regulatory standards and medical guidelines
