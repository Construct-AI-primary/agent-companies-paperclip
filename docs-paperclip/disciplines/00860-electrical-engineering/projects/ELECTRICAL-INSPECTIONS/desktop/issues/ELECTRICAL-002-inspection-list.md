---
id: ELECTRICAL-002
title: "00860 Inspection List — Basic Rendering & Filters"
description: "Implement the inspection list view in the Workspace state with table/card rendering, status filters, search, and pagination."
labels: ["electrical", "00860", "1 — Foundation"]
blocked_by: []
depends_on: ["ELECTRICAL-001"]
para_section: electrical-engineering/projects/ELECTRICAL-INSPECTIONS/desktop/issues
phase: "1 — Foundation"
status: todo
priority: Critical
story_points: 3
due_date: "2026-05-20"
assignee: "domainforge-ai"
company: "domainforge-ai"
delegation:
  parent_goal_id: "ELECTRICAL-INSPECTIONS-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement 00860 electrical inspection management"
  agent_goal: "As domainforge-ai, implement the inspection list view with filtering and search"
  task_goal: "Execute inspection list implementation with 100% pass rate"
---

# ELECTRICAL-002: 00860 Inspection List — Basic Rendering & Filters

## Executive Summary

Build the inspection list view displayed in the Workspace state. Users can browse all electrical inspections in a sortable, filterable list with search, status badges, and pagination. This is the primary entry point for inspection management.

## Problem Statement / Scope

Electrical inspectors need a consolidated view of all inspections with the ability to filter by status, type, date range, and assigned inspector. The list must render efficiently with pagination for large datasets. Empty and error states must be handled gracefully.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Inspection Table | Render inspections in a responsive table with columns: ID, Title, Location, Status, Inspector, Date |
| 2 | Status Filters | Filter chips for Scheduled, In Progress, Passed, Failed, Closed |
| 3 | Search Bar | Text search across inspection title, ID, and location |
| 4 | Pagination | Page-based navigation with configurable page size |
| 5 | Empty State | "No inspections yet" message with CTA to create first inspection |
| 6 | Loading State | Skeleton placeholder cards during data fetch |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- React table/list rendering
- URL query parameter-based filtering
- Debounced search input
- Pagination component implementation

## Acceptance Criteria

- [ ] Inspection list renders with all required columns
- [ ] Status filter chips filter the list correctly (single and multi-select)
- [ ] Search bar filters by title, ID, and location with debounce
- [ ] Pagination controls appear when results exceed page size
- [ ] Empty state displays when no inspections match filters
- [ ] Loading skeleton shows during initial data fetch
- [ ] Error state displays with retry button on fetch failure
- [ ] URL query params update to reflect current filters/page
- [ ] Responsive: card layout on mobile, table on desktop

## Dependencies

- API endpoint `GET /api/v1/inspections` with query params for filters, search, pagination
- Inspection data model with status, type, location, inspector fields
- UI component library for table, badges, pagination

## Estimated Duration

- **Development**: 2 days
- **Testing**: 1 day
- **Total**: 3 days

## Risk Level

**Low** — Standard CRUD list pattern; well-understood implementation.

## QC Team Checks

- [ ] All filter combinations produce correct results
- [ ] Search is debounced and does not fire excessive API calls
- [ ] Pagination maintains state across filter changes
- [ ] Empty state renders correctly for zero results
- [ ] Loading skeleton matches final layout dimensions
- [ ] Error state retry button re-fetches data
- [ ] URL state is preserved on page refresh
