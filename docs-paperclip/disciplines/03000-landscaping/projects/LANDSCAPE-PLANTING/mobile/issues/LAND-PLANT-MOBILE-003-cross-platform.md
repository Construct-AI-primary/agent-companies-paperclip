---
id: LAND-PLANT-MOBILE-003
title: "Planting Operations Cross-Platform — Planting Dashboard, Schedule View & Establishment Tracking"
labels: ["landscaping", "planting", "mobile", "cross-platform", "4 — Mobile & Offline"]
phase: "4 — Mobile & Offline"
status: todo
priority: Medium
story_points: 3
due_date: "2026-09-30"
assignee: devforge-ai
company: devforge-ai
blocked_by:
  - LAND-PLANT-MOBILE-001
  - LAND-PLANT-MOBILE-002
platform: cross-platform
---

# LAND-PLANT-MOBILE-003: Planting Operations Cross-Platform — Planting Dashboard, Schedule View & Establishment Tracking

## Description

Develop cross-platform mobile components for planting operations dashboard, schedule viewing, and establishment tracking. This shared module provides a unified view of planting activities across iOS and Android using React Native or Flutter, enabling project managers and supervisors to monitor progress from their mobile devices.

## Objectives

1. Build unified planting dashboard with progress charts and status overview
2. Implement schedule view with filtering, search, and timeline display
3. Create establishment tracking view with health status indicators
4. Develop cross-platform shared components for code reuse
5. Ensure consistent user experience across iOS and Android

## Requirements

### Planting Dashboard

- [ ] Unified dashboard view with planting progress summary
- [ ] Progress charts (quantities planted vs planned)
- [ ] Quality inspection pass rate display
- [ ] Establishment status overview (active, completed, at-risk)
- [ ] Nursery order status summary
- [ ] Recent activity feed
- [ ] Role-based data visibility (project manager, supervisor, crew)

### Schedule View

- [ ] Plant schedule list with filtering by species, zone, status
- [ ] Search functionality across schedule items
- [ ] Timeline/Gantt view of planting activities
- [ ] Schedule item detail view with specifications
- [ ] Status indicators (Planned, In Progress, Completed, Inspected)
- [ ] Export and share schedule (PDF, image)

### Establishment Tracking

- [ ] Establishment list view with health status indicators
- [ ] Health score trends with visual charts
- [ ] Upcoming assessment reminders
- [ ] Intervention log view
- [ ] Establishment progress (percentage complete, time remaining)
- [ ] At-risk plantings alerting

### Cross-Platform Architecture

- [ ] Shared component library for consistent UI
- [ ] Platform-specific adaptations where needed (iOS vs Android)
- [ ] Shared state management and data fetching
- [ ] Responsive design for phone and tablet
- [ ] Offline data caching for dashboard views
- [ ] Push notification support for alerts and reminders

## Acceptance Criteria

- [ ] Planting dashboard functional with progress charts
- [ ] Schedule view with filtering and search operational
- [ ] Establishment tracking with health status indicators working
- [ ] Cross-platform components rendering correctly on iOS and Android
- [ ] Offline caching for dashboard data operational
- [ ] Push notifications for establishment reminders working
- [ ] Consistent UI/UX across both platforms
- [ ] Performance benchmarks met (load time, scroll performance)

## Dependencies

- BLOCKED BY: LAND-PLANT-MOBILE-001 (iOS app)
- BLOCKED BY: LAND-PLANT-MOBILE-002 (Android app)
- Requires: React Native or Flutter development environment
- Requires: API endpoints from LAND-PLANT-002 and LAND-PLANT-005
- Requires: Design system and component library

## Notes

- Evaluate React Native vs Flutter based on team expertise and performance requirements
- Prioritise dashboard performance for large projects with many schedule items
- Consider widget support for home screen quick views
- Coordinate with web dashboard (LAND-PLANT-WEB-001) for consistent visual design
