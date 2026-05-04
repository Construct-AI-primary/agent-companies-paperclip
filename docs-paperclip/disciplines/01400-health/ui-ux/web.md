# 01400 Health — Web UI/UX Specification

**Version:** 1.0
**Last Updated:** 2026-05-04
**Status:** Draft

## Overview

The web health interface provides browser-based health management for occupational health professionals, HSE managers, and administrators who need remote access to health surveillance data, incident reporting, fitness tracking, and compliance dashboards without installing desktop software.

## Layout Structure

```
┌─────────────────────────────────────────────────────────────┐
│  Top Navigation: Logo | Search | Quick Actions | Profile     │
├──────────────────┬──────────────────────────────────────────┤
│  Left Sidebar    │  Main Content Area                       │
│  ┌──────────────┐│  ┌────────────────────────────────────┐ │
│  │ Dashboard    ││  │  Data Table / Form / Dashboard     │ │
│  │ Surveillance ││  │                                    │ │
│  │ Incidents    ││  │  (Responsive, scrollable content)  │ │
│  │ Fitness      ││  │                                    │ │
│  │ Risk Assess  ││  └────────────────────────────────────┘ │
│  │ Reports      ││                                         │
│  │ Compliance   ││                                         │
│  └──────────────┘│                                         │
├──────────────────┴──────────────────────────────────────────┤
│  Footer: Status | Last Updated | Export Options              │
└─────────────────────────────────────────────────────────────┘
```

## Key Web Components

### Health Dashboard
- KPI cards (Active Incidents, Overdue Assessments, Workers Monitored, Compliance Rate)
- Trend charts with date range selector (surveillance completion rates, incident trends)
- Recent health incident feed with severity indicators
- Quick action toolbar (Record Health Check, Report Incident, Run Report)

### Medical Surveillance Manager
- Paginated table of surveillance programs and schedules
- Filter by program type, worker, date range, compliance status
- Test result entry and review interface
- Abnormal result flagging with referral workflow
- Export to CSV/PDF for medical records

### Health Incident Manager
- Table or card view of health incidents (toggle)
- Status workflow: Reported → Investigating → Managed → Closed
- Evidence attachment panel (photos, documents, test results)
- Assignment and escalation controls
- Regulatory report generation (RIDDOR, OSHA)

### Fitness for Work Tracker
- Worker fitness status table with color-coded categories
- Assessment scheduling and calendar view
- Pre-employment, periodic, and return-to-work workflows
- Medical restriction management with expiry tracking
- Drug and alcohol test result management

### Report Builder
- Pre-built report templates (Monthly Health Report, Surveillance Summary, Incident Report)
- Custom date range and filter configuration
- Chart and table preview
- Scheduled report delivery via email
- Regulatory compliance reports

### Compliance Dashboard
- Regulatory compliance status overview
- Surveillance compliance rates by program
- Incident reporting compliance (RIDDOR/OSHA)
- Fitness assessment compliance by department
- Audit trail and documentation management

## Screen States

| State | Implementation |
|-------|---------------|
| Loading | Skeleton table rows and card placeholders with wave animation |
| Empty | "No health data available" with contextual action button |
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
- IndexedDB for local health data cache
- Encrypted local storage for sensitive medical data

## Export & Reporting

- CSV export for all health data tables
- PDF generation with branded medical report templates
- Scheduled report delivery via email
- Print-optimized views for medical records
- Regulatory format exports (RIDDOR, OSHA 300, COSHH)
