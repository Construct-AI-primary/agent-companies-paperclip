# LAND-MAINT-WEB-001 — Maintenance Web: Maintenance Dashboard, Schedule Calendar & Task Overview

## Metadata

| Field | Value |
|-------|-------|
| **id** | LAND-MAINT-WEB-001 |
| **title** | Maintenance Web — Maintenance Dashboard, Schedule Calendar & Task Overview |
| **labels** | `landscaping`, `maintenance`, `2 — Core Integration`, `web` |
| **phase** | 2 — Core Integration |
| **status** | todo |
| **priority** | High |
| **story_points** | 5 |
| **due_date** | 2026-07-15 |
| **assignee** | devforge-ai |
| **company** | devforge-ai |

## Dependencies

- **Blocks:** LAND-MAINT-WEB-002
- **Blocked By:** LAND-MAINT-002

## Description

Build the web-based maintenance dashboard for landscape operations management. This provides a real-time dashboard with key metrics (tasks due, completion rate, crew utilization), a schedule calendar view with monthly/weekly/daily toggles, a task overview with filtering and search, and responsive design for desktop and tablet use.

## Technical Requirements

### Maintenance Dashboard
- Key metrics display: tasks due today, completion rate, crew utilization, on-time delivery
- Real-time updates via WebSocket connection
- Metric trend indicators with period comparison
- Customizable widget layout
- Drill-down from metrics to detailed task lists

### Schedule Calendar
- Monthly, weekly, and daily calendar views
- Task density visualization with color coding by status
- Drag-and-drop task rescheduling
- Calendar export (PDF, iCal)
- Crew availability overlay on calendar

### Task Overview
- Task list with filtering by status, priority, property, crew, date range
- Full-text search across task descriptions and notes
- Bulk task operations (assign, reschedule, complete)
- Task detail panel with full information
- Task creation from template

## Acceptance Criteria

- [ ] Dashboard displays key metrics with real-time WebSocket updates
- [ ] Metric trend indicators show period-over-period changes
- [ ] Calendar supports monthly, weekly, and daily views
- [ ] Task density visualization with color-coded status
- [ ] Drag-and-drop task rescheduling functional
- [ ] Calendar export generates valid PDF and iCal files
- [ ] Task list filters by status, priority, property, crew, date range
- [ ] Full-text search returns relevant results
- [ ] Bulk task operations functional
- [ ] Responsive design works on desktop and tablet

## Notes

Built with React, TypeScript, and Next.js. This is the primary web interface for maintenance managers and supervisors. The dashboard should provide at-a-glance operational status with the ability to drill into details. Real-time updates are critical for active monitoring.
