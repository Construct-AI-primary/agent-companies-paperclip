---
id: GOVERNANCE-002
title: "01300 Form Queue — Pipeline Status & Approval Levels"
description: "Implement the governance form queue view showing pipeline status, approval levels, and form processing stages."
labels: ["governance", "01300", "1 — Foundation"]
blocked_by: []
depends_on: ["GOVERNANCE-001"]
para_section: governance/projects/GOVERNANCE-FORMS/desktop/issues
phase: "1 — Foundation"
status: todo
priority: Critical
story_points: 3
due_date: "2026-05-20"
assignee: "domainforge-ai"
company: "domainforge-ai"
delegation:
  parent_goal_id: "GOVERNANCE-FORMS-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement 01300 governance form management"
  agent_goal: "As domainforge-ai, implement the form queue view with pipeline status and approval levels"
  task_goal: "Execute form queue implementation with 100% pass rate"
---

# GOVERNANCE-002: 01300 Form Queue — Pipeline Status & Approval Levels

## Executive Summary

Build the governance form queue view displayed in the Workspace state. Users can browse all governance forms in a sortable, filterable list showing pipeline status, current approval level, and processing stage.

## Problem Statement / Scope

Governance officers need a consolidated view of all forms in the approval pipeline with visibility into current stage, approval level, and processing status. The list must render efficiently with pagination for large datasets.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Form Queue Table | Render forms in a responsive table with columns: ID, Title, Type, Stage, Level, Status, Date |
| 2 | Stage Filters | Filter chips for Draft, In Review, Approved, Rejected, Withdrawn |
| 3 | Approval Level Indicator | Visual indicator showing current approval gate (Single, Dual, Multi) |
| 4 | Search Bar | Text search across form title, ID, and type |
| 5 | Pagination | Page-based navigation with configurable page size |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- React table/list rendering
- URL query parameter-based filtering
- Pipeline status visualization
- Pagination component implementation

## Acceptance Criteria

- [ ] Form queue renders with all required columns
- [ ] Stage filter chips filter the list correctly
- [ ] Approval level indicator shows current gate status
- [ ] Search bar filters by title, ID, and type with debounce
- [ ] Pagination controls appear when results exceed page size
- [ ] Empty state displays when no forms match filters
- [ ] Loading skeleton shows during initial data fetch
- [ ] Error state displays with retry button on fetch failure
- [ ] URL query params update to reflect current filters/page

## Dependencies

- API endpoint `GET /api/v1/governance/forms` with query params
- Form data model with stage, level, status fields
- UI component library for table, badges, pagination

## Estimated Duration

- **Development**: 2 days
- **Testing**: 1 day
- **Total**: 3 days

## Risk Level

**Low** — Standard CRUD list pattern with pipeline status display.

## QC Team Checks

- [ ] All filter combinations produce correct results
- [ ] Approval level indicators display correctly for each gate type
- [ ] Search is debounced and does not fire excessive API calls
- [ ] Pagination maintains state across filter changes
- [ ] Empty state renders correctly for zero results
- [ ] Loading skeleton matches final layout dimensions
- [ ] URL state is preserved on page refresh
