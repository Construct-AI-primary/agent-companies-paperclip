---
id: SEC-PATROL-WEB-002
title: "Patrol Management Web — Shift Scheduling, Route Configuration & Guard Assignment"
labels: ["security", "patrol", "web", "3 — Discipline Integration"]
phase: "3 — Discipline Integration"
status: todo
priority: High
story_points: 5
due_date: "2026-08-15"
assignee: devforge-ai
company: devforge-ai
blocked_by: [SEC-PATROL-WEB-001]
estimated_weeks: 3
---

# SEC-PATROL-WEB-002: Patrol Management Web — Shift Scheduling, Route Configuration & Guard Assignment

## Description

Build the web-based administration interface for managing shift schedules, configuring patrol routes, and assigning guards to shifts. This interface empowers dispatchers and supervisors to efficiently manage patrol operations.

## Objectives

- Develop shift scheduling interface with calendar and drag-and-drop assignment
- Build route configuration interface with visual checkpoint management
- Implement guard assignment workflow with availability checking
- Add shift swap request and approval workflow
- Create guard availability management interface

## Technical Approach

### Technology Stack

- React with TypeScript
- FullCalendar for shift schedule calendar
- Mapbox GL JS for route configuration
- React DnD for drag-and-drop guard assignment
- React Hook Form for form management

### Shift Scheduling

- **Calendar View**: Monthly/weekly/daily views showing all shifts
- **Drag-and-Drop**: Assign guards to shifts by dragging onto calendar slots
- **Shift Details**: Start/end time, route assignment, guard assignment, recurrence pattern
- **Conflict Detection**: Alert when guard is double-booked or unavailable
- **Shift Swap**: Request workflow with supervisor approval

### Route Configuration

- **Route List**: Table of all routes with status, checkpoint count, assigned guards
- **Route Editor**: Map-based editor with checkpoint markers, drag to reorder
- **Checkpoint Management**: Add/edit/remove checkpoints with geolocation
- **Route Templates**: Save routes as templates for recurring use

### Guard Assignment

- **Guard List**: Table of guards with status, certifications, availability
- **Assignment Matrix**: Grid view of guards × shifts for bulk assignment
- **Availability Calendar**: Guard availability with time-off requests
- **Certification Tracking**: Required certifications per route type

## Acceptance Criteria

- [ ] Shift schedule displays in calendar view with guard assignments
- [ ] Guards can be assigned to shifts via drag-and-drop
- [ ] Route configuration allows visual checkpoint editing on map
- [ ] Shift swap requests can be submitted and approved
- [ ] Guard availability is displayed and respected during assignment
- [ ] Conflict detection prevents double-booking

## Dependencies

- Blocked by: SEC-PATROL-WEB-001

## Estimated Effort

3 weeks | 5 story points
