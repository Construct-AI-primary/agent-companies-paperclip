---
id: SEC-PATROL-WEB-001
title: "Patrol Management Web — Patrol Dashboard, Route Planner & Guard Status Board"
labels: ["security", "patrol", "web", "2 — Core Integration"]
phase: "2 — Core Integration"
status: todo
priority: High
story_points: 5
due_date: "2026-07-15"
assignee: devforge-ai
company: devforge-ai
blocked_by: [SEC-PATROL-002]
estimated_weeks: 3
---

# SEC-PATROL-WEB-001: Patrol Management Web — Patrol Dashboard, Route Planner & Guard Status Board

## Description

Build the web-based patrol operations dashboard that provides real-time visibility into active patrols, guard locations, and checkpoint status. Includes a route planner interface for creating and editing patrol routes with visual checkpoint placement on a map.

## Objectives

- Develop real-time patrol dashboard with map view
- Display active patrols with guard locations and checkpoint status
- Build route planner with visual checkpoint placement on map
- Create guard status board showing online/offline/on-patrol status
- Implement alert feed for route deviations and missed checkpoints

## Technical Approach

### Technology Stack

- React with TypeScript
- Mapbox GL JS for interactive maps
- WebSocket for real-time updates
- React Query for server state management
- Tailwind CSS for styling

### Dashboard Features

- **Map View**: Interactive map showing all active patrols, guard locations, checkpoint markers
- **Patrol List**: Sidebar list of active patrols with status, progress, guard name
- **Guard Status Board**: Grid of guards with status indicators (online, on-patrol, on-break, offline)
- **Alert Feed**: Real-time feed of route deviations, missed checkpoints, incident reports
- **Filter Controls**: Filter by guard, route, status, date range

### Route Planner

- Map-based checkpoint placement (click to add, drag to reorder)
- Checkpoint properties: name, description, geofence radius
- Route properties: name, type, estimated duration
- Save and publish workflow

## Acceptance Criteria

- [ ] Dashboard shows real-time patrol locations on map
- [ ] Guard status board reflects current guard states
- [ ] Alert feed displays recent events with timestamps
- [ ] Route planner allows visual checkpoint placement on map
- [ ] Routes can be saved and published from planner
- [ ] Dashboard updates in real-time via WebSocket

## Dependencies

- Blocked by: SEC-PATROL-002

## Estimated Effort

3 weeks | 5 story points
