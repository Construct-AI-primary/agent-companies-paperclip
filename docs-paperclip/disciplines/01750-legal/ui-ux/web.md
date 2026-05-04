---
title: "01750 Legal — Web UI/UX Specification"
description: "Web UI/UX specification for the 01750 Legal discipline — browser-based legal management with dashboard, case management, and reporting"
author: "DomainForge AI — Legal Domain"
date: "2026-05-03"
version: "2.0"
status: "active"
platform: web
viewport: "768px–1280px"
tags: legal, ui-ux, web, specification, dashboard, case-management, reporting
parent: "ui-ux/index.md"
related_docs:
  - docs-paperclip/templates/mermaid/legal-contract-lifecycle.yaml
  - docs-paperclip/templates/mermaid/claims-resolution.yaml
  - docs-paperclip/templates/mermaid/compliance-monitoring.yaml
  - orchestration/INTEGRATION-REGISTRY.md
  - docs-paperclip/companies/shared/i18n-translation-management/
---

# 01750 Legal — Web UI/UX Specification

> **Parent**: [`ui-ux/index.md`](index.md) — Master Index
> **Platform**: Web (768px–1280px)
> **Language Support**: 9 languages — see [Language Support](index.md#language-support) in master index

## 1. Overview

The web interface for the 01750 Legal discipline provides browser-based legal management for users who need access without the full desktop application. It offers a responsive dashboard, case management views, and reporting capabilities optimized for tablet and smaller screen resolutions.

### 1.1 Key Capabilities
- Legal dashboard with KPIs and summary views
- Contract and claims case management
- Compliance status monitoring
- Legal reporting and analytics
- Document search and retrieval
- Governance record management

### 1.2 Target Users
- Legal Director
- Compliance Officer
- Contract Manager
- Document Controller
- External auditors and regulators

## 2. Web Navigation

### 2.1 Responsive Top Navigation

```
┌──────────────────────────────────────────────────┐
│ [☰] [Logo] [01750 Legal] [Search] [🔔] [Profile] │
├──────────────────────────────────────────────────┤
│ [Dashboard] [Contracts] [Claims] [Compliance]     │
│ [Documents] [Governance] [Reports]                │
├──────────────────────────────────────────────────┤
│                                                   │
│              Content Area                         │
│                                                   │
│                                                   │
└──────────────────────────────────────────────────┘
```

### 2.2 Navigation Sections

| Section | Description |
|---------|-------------|
| Dashboard | KPI summary, pending items, compliance status, recent activity |
| Contracts | Contract list, quick view, approval queue |
| Claims | Claims list, status overview, case management |
| Compliance | Compliance status, obligation register, alerts |
| Documents | Document search, repository, recent documents |
| Governance | Board records, policies, registers |
| Reports | Legal reports, analytics, exports |

## 3. Key Screens

### 3.1 Dashboard
- KPI cards: Active Contracts, Open Claims, Compliance Score, Pending Reviews
- Compliance status gauge with colour indicators (Green/Amber/Red)
- Recent activity feed with filterable categories
- Quick action toolbar: New Contract, Submit Claim, Generate Report
- Calendar widget with upcoming deadlines and hearings

### 3.2 Contract Management
- Contract list with sortable columns (ref, title, party, value, status, framework)
- Quick filter bar: status, framework (FIDIC/NEC/JCT), date range
- Contract detail panel with expandable sections
- Approval queue with batch actions
- Contract comparison view for amendments

### 3.3 Claims Case Management
- Claims list with status badges and priority indicators
- Claim detail view with 6-step progress tracker
- Timeline view with key events and documents
- Party information panel with contact details
- Document attachment panel with drag-and-drop

### 3.4 Compliance Monitoring
- Compliance dashboard by regulatory area (Labour, Environmental, H&S, Anti-Bribery, Data Protection)
- Obligation register with compliance status
- Alert list with acknowledge and escalate actions
- Compliance calendar with filing deadlines
- Report generation with template selection

### 3.5 Reporting
- Report library with templates (Compliance Report, Claims Summary, Contract Register, Governance Report)
- Report builder with date range, filters, and output format
- Scheduled report configuration
- Export options: PDF, CSV, Excel
- Report history and download archive

## 4. Web-Specific Considerations

### 4.1 Responsive Breakpoints
- **Desktop**: 1280px+ — Full layout with sidebar
- **Tablet Landscape**: 1024px–1279px — Condensed sidebar, reduced padding
- **Tablet Portrait**: 768px–1023px — Single column, collapsible navigation
- **Mobile**: <768px — Redirect to mobile-optimized interface

### 4.2 Performance
- Lazy loading for contract and document lists
- Pagination with 25 items per page default
- Debounced search with 300ms delay
- Cached API responses with 5-minute TTL
- Progressive image loading for document thumbnails

### 4.3 Accessibility
- WCAG 2.1 AA compliance
- Keyboard navigation with visible focus indicators
- Screen reader support with ARIA labels
- High contrast mode support
- Font size adjustment (100%–150%)

### 4.4 Browser Support
- Chrome 90+, Firefox 88+, Safari 14+, Edge 90+
- Progressive Web App (PWA) support for offline access
- Service worker for background sync
- IndexedDB for local data caching

## 5. Web API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/web/legal/dashboard` | Web dashboard data |
| GET | `/api/v1/web/legal/contracts` | Contract list for web |
| GET | `/api/v1/web/legal/claims` | Claims list for web |
| GET | `/api/v1/web/legal/compliance` | Compliance status for web |
| GET | `/api/v1/web/legal/reports` | Report list and templates |
| POST | `/api/v1/web/legal/reports/generate` | Generate report |
| GET | `/api/v1/web/legal/governance` | Governance records list |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 2.0 | 2026-05-03 | Initial web UI/UX specification for Legal discipline |
| 1.0 | 2026-05-03 | Initial UI/UX specification |

---

**Document Information**
- **Author**: DomainForge AI — Legal Domain
- **Date**: 2026-05-03
- **Status**: Active
