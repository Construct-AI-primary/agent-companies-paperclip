# 03000 Landscaping — Web UI/UX Specification

**Version:** 1.0  
**Last Updated:** 2026-05-04  
**Status:** Draft

## Overview

The web landscaping interface provides browser-based landscape management for project managers, clients, and administrators who need remote access to design reviews, project status, plant schedules, and reporting dashboards.

## Layout Structure

```
┌─────────────────────────────────────────────────────────────┐
│  Top Navigation: Logo | Search | Quick Actions | Profile    │
├──────────────────┬──────────────────────────────────────────┤
│  Left Sidebar    │  Main Content Area                       │
│  ┌──────────────┐│  ┌────────────────────────────────────┐ │
│  │ Dashboard    ││  │  Data Table / Design Viewer        │ │
│  │ Projects     ││  │                                    │ │
│  │ Designs      ││  │  (Responsive, scrollable content)  │ │
│  │ Plants       ││  │                                    │ │
│  │ Schedule     ││  └────────────────────────────────────┘ │
│  │ Reports      ││                                         │
│  │ Settings     ││                                         │
│  └──────────────┘│                                         │
├──────────────────┴──────────────────────────────────────────┤
│  Footer: Status | Last Updated | Export Options             │
└─────────────────────────────────────────────────────────────┘
```

## Key Web Components

### Landscape Dashboard
- KPI cards (Active Projects, Plants Ordered, Tasks Due, Irrigation Alerts)
- Seasonal calendar with planting windows
- Recent design activity feed
- Weather forecast integration

### Design Reviewer
- Browser-based planting plan and hardscape drawing viewer
- Layer toggle and measurement tools
- Comment and markup capabilities
- Version comparison and approval workflow

### Plant Schedule Manager
- Searchable plant database with filters
- Plant ordering and delivery tracking
- Planting schedule with seasonal guidance
- Nursery and supplier management

### Report Builder
- Pre-built report templates (Planting Summary, Maintenance Log, Irrigation Report)
- Custom date range and filter configuration
- Chart and table preview
- Scheduled report delivery via email

### Configuration Manager
- Plant database management
- Maintenance template configuration
- Irrigation zone definitions
- User role and permission settings

## Screen States

| State | Implementation |
|-------|---------------|
| Loading | Skeleton table rows and card placeholders |
| Empty | "No projects" with create new action |
| Error | Error toast + banner with retry |
| Data | Interactive data with inline editing |

## Responsive Behavior

| Breakpoint | Layout |
|------------|--------|
| >1200px | Full sidebar + main content |
| 768-1200px | Collapsible sidebar, stacked cards |
| <768px | Bottom navigation, single column |

## Browser Support

- Chrome 90+, Firefox 90+, Safari 15+, Edge 90+
- PWA with offline access to plant database
- Service worker for background sync
- IndexedDB for local data cache

## Export & Reporting

- CSV export for plant schedules and task lists
- PDF generation with branded templates
- Print-optimized views for planting plans
- Scheduled report delivery via email