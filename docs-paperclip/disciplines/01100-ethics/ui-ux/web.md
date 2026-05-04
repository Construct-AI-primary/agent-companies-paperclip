# 01100 Ethics — Web Specification

**Version:** 1.0
**Last Updated:** 2026-05-04
**Status:** Draft

## Overview

The web platform provides browser-based ethics management for employees, managers, and external stakeholders. It supports self-service Code of Conduct acknowledgment, gift declaration, conflict of interest disclosure, whistleblower reporting, training access, and compliance dashboard viewing.

## Target Users

- Employees (self-service)
- Managers (approval workflows)
- External stakeholders (supplier code acknowledgment)
- Board members (oversight dashboard)
- Auditors (compliance review)

## Layout Structure

```
┌──────────────────────────────────────────────────────────────┐
│  [Org Logo]  Ethics Portal    [My Profile] [Help] [Logout]  │
├──────────────────────────────────────────────────────────────┤
│  ┌─────────┐ ┌──────────────────────────────────────────────┐│
│  │ Dashboard│ │  Content Area                               ││
│  │          │ │                                              ││
│  │ My Tasks │ │  - Compliance Dashboard                     ││
│  │          │ │  - Code of Conduct Viewer                   ││
│  │ Code of  │ │  - Whistleblower Report Form                ││
│  │ Conduct  │ │  - Gift Declaration Form                    ││
│  │          │ │  - Conflict of Interest Form                ││
│  │ Training │ │  - Training Portal                          ││
│  │          │ │  - Case Status Tracker                      ││
│  │ Reports  │ │  - Reports & Analytics                      ││
│  │          │ │                                              ││
│  │ Settings │ │                                              ││
│  └─────────┘ └──────────────────────────────────────────────┘│
├──────────────────────────────────────────────────────────────┤
│  Footer: Privacy | Terms | Contact Ethics Office             │
└──────────────────────────────────────────────────────────────┘
```

## Key Features

### Compliance Dashboard
- **Compliance score** with trend indicators
- **Task summary** (pending acknowledgments, training due, declarations)
- **Case status overview** (open, in progress, resolved)
- **Calendar view** of compliance deadlines
- **Department compliance** comparison

### Code of Conduct
- **Policy viewer** with search and navigation
- **Acknowledgment workflow** with digital signature
- **Version history** and change summary
- **Downloadable PDF** versions
- **Multi-language** toggle

### Whistleblower Reporting
- **Anonymous report submission** form
- **Category selection** with guided questions
- **File attachment** (up to 25MB)
- **Secure case reference** for follow-up
- **Status check** using reference number

### Gift & Hospitality Declaration
- **Declaration form** with auto-calculated values
- **Threshold indicators** (green/amber/red)
- **Manager approval** routing
- **Annual limit** tracking
- **Donation request** form

### Conflict of Interest Disclosure
- **Annual disclosure** form
- **Project-specific** disclosure
- **Relationship declaration** (family, business, financial)
- **Review status** tracking
- **Mitigation plan** viewer

### Training Portal
- **Course catalog** with search and filter
- **Enrollment** and self-registration
- **Course completion** tracking
- **Certificate** download
- **Training history** and transcripts

### Case Management
- **Case list** with status filters
- **Case detail** view with timeline
- **Document attachment** viewer
- **Status updates** and notifications
- **Escalation** requests

## Screen States

### Loading State
- Skeleton loaders for dashboard widgets
- Progress indicators for form submissions
- Spinner for data-heavy operations

### Empty State
- "No pending tasks" for task list
- "All policies acknowledged" for Code of Conduct
- "No declarations needed" for gifts/conflicts
- "No training due" for training portal

### Error State
- "Unable to load dashboard" with retry
- "Form submission failed" with draft save
- "Session expired" with re-login prompt

### Data State
- Widget-based dashboard with KPI cards
- Form layouts with validation indicators
- Table views with sort and filter
- Timeline view for case history

## Interaction Patterns

- **Left Navigation:** Collapsible sidebar with section grouping
- **Breadcrumbs:** Location indicator for deep navigation
- **Wizard Forms:** Step-by-step for complex submissions (whistleblower, COI)
- **Inline Validation:** Real-time form field validation
- **Toast Notifications:** For submission confirmations and alerts
- **Modal Dialogs:** For confirmations and detail views
- **Progress Stepper:** For multi-step workflows

## Responsive Breakpoints

- **Full Desktop:** 1200px+ — Full layout with sidebar
- **Tablet:** 768px-1199px — Collapsed sidebar, adjusted content
- **Mobile:** <768px — Single column, stacked layout

## Security Considerations

- HTTPS enforced for all pages
- Session timeout after 15 minutes of inactivity
- Two-factor authentication for sensitive actions
- Audit logging for all submissions and approvals
- Data encryption for whistleblower reports
- Role-based access control for all features
