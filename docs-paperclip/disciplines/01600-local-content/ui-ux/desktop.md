# 01600 Local Content — Desktop UI/UX Specification

**Version:** 1.0  
**Last Updated:** 2026-05-18  
**Status:** Draft

## Overview

The desktop local content interface provides a comprehensive Local Content Management Center for local content administrators, managers, and compliance officers. It supports multi-monitor configurations, real-time data dashboards, and advanced analytics for local content performance tracking.

## Layout Structure

```
┌─────────────────────────────────────────────────────────────┐
│  Header: Local Content Logo | Status Bar | User Menu | Clock │
├──────────────────┬──────────────────────────────────────────┤
│  Left Sidebar    │  Main Content Area                       │
│  ┌──────────────┐│  ┌────────────────────────────────────┐ │
│  │ Employment   ││  │  Active View Panel                 │ │
│  │ Procurement  ││  │                                    │ │
│  │ Enterprise   ││  │  (Context-dependent content)       │ │
│  │ Skills       ││  │                                    │ │
│  │ Compliance   ││  └────────────────────────────────────┘ │
│  │ Reports      ││  ┌────────────────────────────────────┐ │
│  │ Audit Trail  ││  │  Activity Feed / Alerts Panel      │ │
│  └──────────────┘│  │                                    │ │
│                   │  └────────────────────────────────────┘ │
├──────────────────┴──────────────────────────────────────────┤
│  Footer: Connection Status | Sync Indicator | Version       │
└─────────────────────────────────────────────────────────────┘
```

## Common Components

### LC-LocalEmploymentDashboard
- Workforce localisation overview with headcount breakdown by department
- Localisation target tracking with progress bars and status indicators
- Employment equity metrics with demographic breakdown
- New hire and turnover analytics
- CSS class prefix: `.LC-`

### LC-ProcurementTracker
- Local procurement spend overview with category breakdown
- Supplier localisation status with certification levels
- Contract value distribution between local and foreign suppliers
- Spend trend charts with period-over-period comparison
- Supplier registration and verification workflow

### LC-EnterpriseDevelopmentManager
- Enterprise program portfolio overview with status indicators
- Participant tracking with milestone completion progress
- Budget utilisation and program ROI analytics
- Supplier development plan status and KPI tracking
- Program scheduling and resource allocation

### LC-SkillsTransferPlanner
- Skills transfer plan overview with department and role breakdown
- Training completion rates and competency assessment scores
- Skills gap analysis with priority indicators
- Certification tracking with expiry management
- Mentor-mentee assignment and progress tracking

### LC-ComplianceReporter
- Compliance checklist with status indicators and due dates
- Report generation interface with template selection
- Regulatory submission tracking with deadline alerts
- Audit trail viewer with filtering and search
- Compliance scorecard with trend analysis

## Screen States

| State | Implementation |
|-------|---------------|
| Loading | Skeleton layout with pulsing placeholders matching final component dimensions |
| Empty | "No local content data" illustration with contextual guidance text and action buttons |
| Error | Error banner with retry button, fallback to last known good data, offline mode indicator |
| Data | Full data presentation with real-time updates via WebSocket |

## Responsive Breakpoints

| Breakpoint | Width | Layout |
|------------|-------|--------|
| Desktop XL | >1920px | Full multi-column with expanded panels |
| Desktop | 1366-1920px | Standard layout with sidebar |
| Desktop Small | 1024-1366px | Collapsed sidebar, single-column content |

## Accessibility

- WCAG 2.1 AA compliance
- Keyboard navigation for all local content actions
- Screen reader announcements for compliance alerts
- High-contrast mode for outdoor/field use
- Focus indicators on all interactive elements
