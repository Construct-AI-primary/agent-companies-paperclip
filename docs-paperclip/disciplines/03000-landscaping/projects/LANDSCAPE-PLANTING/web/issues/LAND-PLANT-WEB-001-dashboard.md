---
id: LAND-PLANT-WEB-001
title: "Planting Operations Web — Planting Dashboard, Schedule Overview & Nursery Orders"
labels: ["landscaping", "planting", "web", "2 — Core Integration"]
phase: "2 — Core Integration"
status: todo
priority: High
story_points: 5
due_date: "2026-07-15"
assignee: devforge-ai
company: devforge-ai
blocked_by:
  - LAND-PLANT-002
platform: web
---

# LAND-PLANT-WEB-001: Planting Operations Web — Planting Dashboard, Schedule Overview & Nursery Orders

## Description

Build the web-based planting operations dashboard providing a comprehensive overview of planting schedules, progress tracking, quality inspection summaries, and nursery order status. This dashboard serves as the primary command centre for project managers and landscape supervisors to monitor and manage planting activities.

## Objectives

1. Create planting dashboard with schedule overview and progress tracking
2. Implement schedule view with filtering, search, and timeline display
3. Build nursery order status tracking and delivery schedule view
4. Provide quality inspection summary with pass rates and trends
5. Enable data export for reporting and stakeholder communication

## Requirements

### Planting Dashboard

- [ ] Schedule overview with Gantt-style timeline of planting activities
- [ ] Planting progress charts (quantities planted vs planned by species and zone)
- [ ] Quality inspection summary with pass rates and trend charts
- [ ] Establishment status overview (active, completed, at-risk counts)
- [ ] Nursery order status tracking with delivery schedule
- [ ] Key performance indicators (planting completion %, inspection pass rate, establishment health score)
- [ ] Role-based data visibility and customisable dashboard widgets

### Schedule Overview

- [ ] Plant schedule view with filtering by species, zone, status, date range
- [ ] Search functionality across schedule items
- [ ] Schedule item detail view with full specifications
- [ ] Status indicators with colour coding (Planned, In Progress, Completed, Inspected)
- [ ] Export to PDF and CSV formats
- [ ] Print-friendly view for site meetings

### Nursery Orders

- [ ] Order list with status indicators (Draft, Submitted, Confirmed, In Transit, Delivered)
- [ ] Delivery schedule view with date/time windows
- [ ] Order receipt confirmation and quality check results
- [ ] Supplier performance metrics (on-time delivery, quality rating)
- [ ] Order detail view with line items and delivery history

## Acceptance Criteria

- [ ] Dashboard displaying schedule, progress, and order data correctly
- [ ] Schedule view with filtering and search operational
- [ ] Nursery order status tracking functional
- [ ] Quality inspection summary with pass rates displayed
- [ ] Data export to PDF and CSV working
- [ ] Dashboard loads within acceptable performance thresholds
- [ ] Responsive design for desktop and tablet
- [ ] Integration tests passing with backend APIs

## Dependencies

- BLOCKED BY: LAND-PLANT-002 (Core workflow API)
- Requires: Web application framework (React)
- Requires: Charting library for progress visualisation
- Requires: API endpoints for schedule, orders, and inspections

## Notes

- Coordinate with LAND-PLANT-002 for API integration
- Dashboard should support real-time updates via WebSocket where available
- Consider saved views and dashboard customisation per user role
- Align with Paperclip platform design system for consistent look and feel
