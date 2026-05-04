# 01600 Local Content — Web UI/UX Specification

**Version:** 1.0  
**Last Updated:** 2026-05-18  
**Status:** Draft

## Overview

The web local content interface provides browser-based local content management for supervisors, managers, and administrators who need remote access to local content dashboards, compliance reporting, and configuration management without installing desktop software.

## Layout Structure

```
┌─────────────────────────────────────────────────────────────┐
│  Top Navigation: Logo | Search | Quick Actions | Profile    │
├──────────────────┬──────────────────────────────────────────┤
│  Left Sidebar    │  Main Content Area                       │
│  ┌──────────────┐│  ┌────────────────────────────────────┐ │
│  │ Dashboard    ││  │  Data Table / Form / Dashboard     │ │
│  │ Employment   ││  │                                    │ │
│  │ Procurement  ││  │  (Responsive, scrollable content)  │ │
│  │ Enterprise   ││  │                                    │ │
│  │ Skills       ││  └────────────────────────────────────┘ │
│  │ Compliance   ││                                         │
│  │ Reports      ││                                         │
│  └──────────────┘│                                         │
├──────────────────┴──────────────────────────────────────────┤
│  Footer: Status | Last Updated | Export Options             │
└─────────────────────────────────────────────────────────────┘
```

## Key Web Components

### Local Content Dashboard
- KPI cards (Local Employment %, Local Spend %, Programs Active, Skills Transfer Rate)
- Trend charts with date range selector
- Compliance status overview with color-coded indicators
- Quick action toolbar (Generate Report, Add Record, Configure)

### Employment Manager
- Paginated table of local employees with filtering
- Localisation target tracking with progress indicators
- Workforce analytics with demographic breakdown
- Export to CSV/PDF
- Detail drawer on row click

### Procurement Manager
- Local procurement records with supplier details
- Spend analysis with category breakdown
- Supplier registration and certification management
- Contract value tracking with local content percentage
- Approval workflow integration

### Enterprise Development Manager
- Program portfolio with status tracking
- Participant management with milestone tracking
- Budget utilisation and program analytics
- Supplier development plan management
- KPI dashboard with target vs actual

### Skills Transfer Manager
- Skills transfer plan overview with department breakdown
- Training record management with certification tracking
- Skills gap analysis with priority indicators
- Mentor-mentee program management
- Competency assessment tracking

### Compliance Reporter
- Compliance checklist with status and evidence management
- Report generation with template selection and scheduling
- Regulatory submission tracking with deadline management
- Audit trail viewer with comprehensive search
- Compliance scorecard with trend analysis

## Screen States

| State | Implementation |
|-------|---------------|
| Loading | Skeleton table rows and card placeholders |
| Empty | "No data available" with contextual action button |
| Error | Error toast + banner with retry, auto-refresh on reconnect |
| Data | Interactive data with inline editing and bulk actions |

## Responsive Behavior

| Breakpoint | Layout |
|------------|--------|
| >1200px | Full sidebar + main content |
| 768-1200px | Collapsible sidebar, stacked cards |
| <768px | Bottom navigation, single column |

## Browser Support

- Chrome 90+, Firefox 90+, Safari 15+, Edge 90+
- Progressive Web App (PWA) with offline support
- Service worker for background sync
- IndexedDB for local data cache

## Export & Reporting

- CSV export for all data tables
- PDF generation with branded templates
- Scheduled report delivery via email
- Print-optimized views for compliance reports
