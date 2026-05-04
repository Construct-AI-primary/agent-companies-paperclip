---
id: SEC-PERIM-WEB-001
title: "Perimeter Security Web — Zone Map, Sensor Status Board & Alert History"
labels: ["security", "perimeter", "web", "dashboard", "2 — Core Integration"]
phase: "2 — Core Integration"
status: todo
priority: High
story_points: 5
assignee: devforge-ai
company: devforge-ai
created_date: 2026-04-16
due_date: 2026-07-15
estimated_hours: 40
blocked_by: ["SEC-PERIM-002"]
---

# SEC-PERIM-WEB-001: Perimeter Security Web — Zone Map, Sensor Status Board & Alert History

## Description

Build the web-based perimeter security dashboard providing an interactive zone map with real-time sensor status, a comprehensive sensor status board, and alert history viewer. This is the primary interface for security operations center personnel to monitor perimeter security across all protected sites.

**Phase:** 2 — Core Integration  
**Priority:** High  
**Story Points:** 5  
**Estimated Hours:** 40  
**Assignee:** devforge-ai  
**Company:** devforge-ai  
**Due Date:** 2026-07-15  

**Blocked By:** SEC-PERIM-002

## Acceptance Criteria

- [ ] Interactive zone map with real-time sensor status indicators
- [ ] Sensor status board showing online/offline/alert/maintenance states
- [ ] Alert history view with filtering by zone, severity, date range
- [ ] Zone heat map showing alert frequency and risk concentration
- [ ] Dashboard auto-refresh with WebSocket real-time updates
- [ ] Notification badges for active and unacknowledged alerts
- [ ] Responsive layout for various screen sizes (desktop focus)
- [ ] Export alert history to CSV/PDF

## Technical Details

- React/Next.js web application
- Map visualization using Leaflet or Mapbox
- WebSocket integration for real-time sensor data streaming
- RESTful API integration with backend services
- Responsive design with desktop-optimized layout
- Role-based access control for dashboard views

## Dependencies

- **SEC-PERIM-002** — Core intrusion detection, sensor monitoring, and alert dispatch

## Status

- [ ] To Do
- [ ] In Progress
- [ ] In Review
- [ ] Done

## Notes

_Add implementation notes, blockers, and resolution details here._
