---
id: DOCUMENT-002
title: "00900 Document Registry — Basic Rendering & Filters"
description: "Implement the document registry list view in the Workspace state with table/card rendering, status filters, search, and pagination."
labels: ["document-control", "00900", "1 — Foundation"]
blocked_by: []
depends_on: ["DOCUMENT-001"]
para_section: document-control/projects/DOCUMENT-REGISTRY/desktop/issues
phase: "1 — Foundation"
status: todo
priority: Critical
story_points: 3
due_date: "2026-05-20"
assignee: "domainforge-ai"
company: "domainforge-ai"
delegation:
  parent_goal_id: "DOCUMENT-REGISTRY-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement 00900 document control management"
  agent_goal: "As domainforge-ai, implement the document registry list view with filtering and search"
  task_goal: "Execute document registry implementation with 100% pass rate"
---

# DOCUMENT-002: 00900 Document Registry — Basic Rendering & Filters

## Executive Summary

Build the document registry list view displayed in the Workspace state. Users can browse all documents in a sortable, filterable list with search, status badges, and pagination. This is the primary entry point for document management.

## Problem Statement / Scope

Document controllers need a consolidated view of all documents with the ability to filter by status, type, discipline, and date. The list must render efficiently with pagination for large datasets. Empty and error states must be handled gracefully.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Document Table | Render documents in a responsive table with columns: ID, Title, Type, Status, Version, Date |
| 2 | Status Filters | Filter chips for Draft, In Review, Approved, Published, Archived, Withdrawn |
| 3 | Search Bar | Text search across document title, ID, and document number |
| 4 | Pagination | Page-based navigation with configurable page size |
| 5 | Empty State | "No documents yet" message with CTA to create first document |
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

- [ ] Document list renders with all required columns
- [ ] Status filter chips filter the list correctly (single and multi-select)
- [ ] Search bar filters by title, ID, and document number with debounce
- [ ] Pagination controls appear when results exceed page size
- [ ] Empty state displays when no documents match filters
- [ ] Loading skeleton shows during initial data fetch
- [ ] Error state displays with retry button on fetch failure
- [ ] URL query params update to reflect current filters/page
- [ ] Responsive: card layout on mobile, table on desktop

## Dependencies

- API endpoint `GET /api/v1/documents` with query params for filters, search, pagination
- Document data model with status, type, discipline, version fields
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
