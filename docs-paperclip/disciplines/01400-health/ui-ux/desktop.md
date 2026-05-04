# 01400 Health — Desktop UI/UX Specification

**Version:** 1.0
**Last Updated:** 2026-05-04
**Status:** Draft

## Overview

The desktop health interface provides a comprehensive Health Management Console for occupational health professionals, medical surveillance coordinators, health & safety managers, and medical officers. It supports multi-monitor configurations, real-time health data streaming, medical records management, and advanced health analytics.

## Layout Structure

```
┌─────────────────────────────────────────────────────────────┐
│  Header: Health Logo | Status Bar | User Menu | Clock        │
├──────────────────┬──────────────────────────────────────────┤
│  Left Sidebar    │  Main Content Area                       │
│  ┌──────────────┐│  ┌────────────────────────────────────┐ │
│  │ Dashboard    ││  │  Active View Panel                 │ │
│  │ Surveillance ││  │                                    │ │
│  │ Incidents    ││  │  (Context-dependent content)       │ │
│  │ Fitness      ││  │                                    │ │
│  │ Risk Assess  ││  └────────────────────────────────────┘ │
│  │ Emergency    ││  ┌────────────────────────────────────┐ │
│  │ Reports      ││  │  Health Activity Feed / Alerts     │ │
│  │ Compliance   ││  │                                    │ │
│  └──────────────┘│  └────────────────────────────────────┘ │
├──────────────────┴──────────────────────────────────────────┤
│  Footer: Connection Status | Sync Indicator | Last Updated   │
└─────────────────────────────────────────────────────────────┘
```

## Common Components

### HLTH-NavSidebar
- Icon + label navigation items with health-themed icons (stethoscope, heartbeat, clipboard)
- Active state highlighting with Health Blue (#0277bd) indicator
- Badge counts for pending assessments, open incidents
- Collapsible to icon-only mode
- CSS class prefix: `.HLTH-`

### HLTH-StatusBar
- Real-time health system status indicator
- Active health alerts count (color-coded by severity)
- Medical surveillance schedule indicator
- Last sync timestamp
- Upcoming assessment reminders

### HLTH-HealthAlertPanel
- Scrollable real-time health alert feed
- Color-coded severity levels (Critical, High, Medium, Low, Info)
- Alert categories: Medical Emergency, Exposure Alert, Abnormal Result, Overdue Assessment
- Click-to-acknowledge with response tracking
- Auto-scroll with pause on interaction

### HLTH-ActivityTimeline
- Chronological health event log (assessments, incidents, surveillance results)
- Filterable by event type, severity, date range, worker
- Expandable detail view with medical data attachments
- Export to CSV/PDF for medical records

## Screen States

| State | Implementation |
|-------|---------------|
| Loading | Skeleton layout with pulsing wave pattern placeholders matching final component dimensions |
| Empty | "No health records" illustration with contextual guidance text and action buttons |
| Error | Error banner with retry button, fallback to last known good health data, offline mode indicator |
| Data | Full data presentation with real-time updates via WebSocket, auto-refresh for critical data |

## Responsive Breakpoints

| Breakpoint | Width | Layout |
|------------|-------|--------|
| Desktop XL | >1920px | Full multi-column with expanded health panels |
| Desktop | 1366-1920px | Standard layout with sidebar |
| Desktop Small | 1024-1366px | Collapsed sidebar, single-column content |

## Key Desktop Components

### HLTH-MedicalSurveillanceDashboard
- Surveillance program overview with program status cards
- Schedule calendar with upcoming and overdue surveillance events
- Test result summary with trend indicators
- Worker compliance rates per surveillance program
- Quick access to audiometry, spirometry, and biological monitoring modules

### HLTH-HealthIncidentManager
- Incident list with filtering by type, severity, status, date
- Incident detail view with investigation timeline
- Root cause analysis documentation
- Exposure assessment data integration
- Regulatory report generation

### HLTH-FitnessForWorkTracker
- Worker fitness status dashboard with color-coded categories
- Assessment scheduling and tracking
- Pre-employment, periodic, and return-to-work workflows
- Medical restriction management
- Drug and alcohol testing management

### HLTH-RiskAssessmentTool
- Health risk assessment workspace with COSHH integration
- Hazard identification and exposure assessment forms
- OEL/TLV comparison and compliance tracking
- Control measure recommendation engine
- Assessment review and approval workflow

### HLTH-EmergencyResponsePlanner
- Emergency response plan management
- Medical resource inventory (AEDs, first aid kits, stretchers)
- First aider register with certification tracking
- Emergency drill scheduling and logging
- Emergency service contact management

## Accessibility

- WCAG 2.1 AA compliance
- Keyboard navigation for all health management actions
- Screen reader announcements for critical health alerts
- High-contrast mode for clinical environments
- Focus indicators on all interactive elements
- Medical terminology with tooltip explanations
