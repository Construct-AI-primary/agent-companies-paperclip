# LAND-MAINT-MOBILE-003 — Maintenance Cross-Platform: Maintenance Dashboard, Schedule View & Performance Metrics

## Metadata

| Field | Value |
|-------|-------|
| **id** | LAND-MAINT-MOBILE-003 |
| **title** | Maintenance Cross-Platform — Maintenance Dashboard, Schedule View & Performance Metrics |
| **labels** | `landscaping`, `maintenance`, `4 — Mobile & Offline`, `cross-platform` |
| **phase** | 4 — Mobile & Offline |
| **status** | todo |
| **priority** | Medium |
| **story_points** | 3 |
| **due_date** | 2026-09-30 |
| **assignee** | devforge-ai |
| **company** | devforge-ai |

## Dependencies

- **Blocks:** None
- **Blocked By:** LAND-MAINT-MOBILE-001, LAND-MAINT-MOBILE-002

## Description

Build a cross-platform mobile dashboard for landscape maintenance management. This app provides a maintenance dashboard with key performance metrics, schedule view with day/week/month toggle, performance metrics charts, notification center for task alerts, and responsive design for both phone and tablet form factors.

## Technical Requirements

### Maintenance Dashboard
- Key metrics display (tasks due today, completion rate, crew utilization)
- Real-time metric updates via API polling or WebSocket
- Metric trend indicators (up/down vs previous period)
- Customizable metric cards with drag-to-reorder
- Drill-down from metrics to detailed views

### Schedule View
- Day/week/month calendar toggle
- Task density visualization on calendar
- Color-coded task status indicators
- Tap to view task details
- Schedule export and sharing

### Performance Metrics
- Charts for completion rate over time
- Crew utilization bar charts
- Task type distribution pie charts
- Seasonal comparison charts
- Export metrics as PDF or CSV

### Notifications
- Push notification integration
- In-app notification center
- Notification categories (task assigned, task due, completion verified)
- Notification preferences and quiet hours

## Acceptance Criteria

- [ ] Dashboard displays key metrics with real-time updates
- [ ] Metric trend indicators show direction of change
- [ ] Schedule view with day/week/month toggle functional
- [ ] Calendar shows task density with color-coded status
- [ ] Performance charts render with accurate data
- [ ] Charts support export as PDF or CSV
- [ ] Push notifications delivered and actionable
- [ ] Notification center shows history with categories
- [ ] Responsive design works on phone and tablet
- [ ] App performance tested with dashboard data for 50+ properties

## Notes

Built with React Native and TypeScript. This cross-platform app provides a management overview that complements the native iOS and Android field apps. It depends on both native apps being functional since it aggregates data from the same backend APIs.
