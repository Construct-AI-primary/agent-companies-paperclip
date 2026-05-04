---
id: PREAWARD-002
title: "00425 Tender List — Basic Rendering & Filters"
phase: "1 — Foundation"
status: open
priority: Critical
blocked_by: []
depends_on: []
---

# PREAWARD-002: 00425 Tender List — Basic Rendering & Filters

## Executive Summary

Build the tender list view for the 00425 Pre-Award Workspace state. This provides a filterable, sortable list of all tenders with status badges, value indicators, and deadline tracking. The tender list is the primary entry point for users to access tender details and manage the pre-award lifecycle.

## Problem Statement / Scope

Users currently have no way to view or filter active tenders. The Workspace state requires a tender list component that displays key information at a glance and allows users to filter by status, type, value range, and deadline.

**Scope:**
- Tender list table/card view with columns: ID, Title, Status, Type, Value, Deadline, Actions
- Filter bar with status, type, value range, and date filters
- Sortable columns (by value, deadline, status)
- Status badges with color coding (Draft, Published, Under Evaluation, Awarded, Cancelled)
- Pagination for large tender lists
- Skeleton loading state while data loads

## Required Actions

| # | Action | Agent Role | Expected Outcome |
|---|--------|------------|-----------------|
| 1 | Build tender list component with data fetching | DevCore DevForge | Tenders render from API with loading skeleton |
| 2 | Implement filter bar with status/type/value/date filters | Codesmith DevForge | Filters update list in real-time |
| 3 | Add sortable column headers | Interface DevForge | Columns sort ascending/descending on click |
| 4 | Create status badge component with color coding | Codesmith DevForge | Status badges render with correct colors |
| 5 | Implement pagination with page size selector | DevCore DevForge | List paginates correctly with configurable page size |

## Assigned Company & Agent

- **Company:** DevForge AI
- **Agent:** DevCore (devcore-devforge) — Data fetching & pagination
- **Agent:** Codesmith (codesmith-devforge) — Filter bar & status badges
- **Agent:** Interface (interface-devforge-api-integration) — Sortable columns
- **Supporting:** DomainForge AI (procurement-domainforge) — Domain validation

## Required Skills

- `pre-award-workflow-development` (DevForge)
- `procurement-management` (DomainForge)
- `ui-component-development` (DevForge)
- `data-filtering` (DevForge)

## Acceptance Criteria

- [ ] Tender list renders with all required columns
- [ ] Status badges display correct colors (Draft=gray, Published=blue, Under Evaluation=orange, Awarded=green, Cancelled=red)
- [ ] Filter bar filters by status, type, value range, and deadline
- [ ] Column headers sort data ascending/descending
- [ ] Pagination displays correct page count and navigates properly
- [ ] Skeleton loading state shows while data is fetching
- [ ] Empty state displays "No active tenders" message when list is empty
- [ ] Error state displays on API failure with retry button
- [ ] Responsive layout switches to card view on tablet/mobile
- [ ] Filter state persists in URL query parameters

## Dependencies

- BLOCKED BY: PREAWARD-001
- BLOCKS: PREAWARD-003, PREAWARD-004, PREAWARD-005, PREAWARD-006

## Estimated Duration

- **Estimated:** 4 days
- **Risk Level:** Low

## QC Team Checks

- [ ] Code review completed by DomainForge AI
- [ ] Filter performance tested with 1000+ tenders
- [ ] Cross-browser compatibility verified
- [ ] Accessibility standards met (WCAG 2.1 AA)
- [ ] Unit tests for filter logic and sorting
- [ ] Integration test for API data flow
