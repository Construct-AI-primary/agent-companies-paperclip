---
id: CONTRACT-003
title: "00400 Contract Detail View — Header & Tabs"
description: "Implement the contract detail view with a header showing key metadata and a tabbed interface for Overview, Obligations, Variations, Payments, Documents, and Timeline sections."
labels: ["contracts", "00400", "1 — Foundation"]
blocked_by: []
depends_on: ["CONTRACT-001", "CONTRACT-002"]
para_section: contracts/projects/CONTRACT-LIFECYCLE/desktop/issues
phase: "1 — Foundation"
status: todo
priority: Critical
story_points: 3
due_date: "2026-05-15"
assignee: "domainforge-ai"
company: "domainforge-ai"
delegation:
  parent_goal_id: "CONTRACT-LIFECYCLE-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement 00400 contract lifecycle management"
  agent_goal: "As domainforge-ai, implement the contract detail view with header and tab navigation"
  task_goal: "Execute contract detail view implementation with 100% pass rate"
---

# CONTRACT-003: 00400 Contract Detail View — Header & Tabs

## Executive Summary

Build the contract detail view accessible by clicking a contract from the list. The view includes a header bar with key metadata (contract ID, title, supplier, value, status badge) and a tabbed content area with six tabs: Overview, Obligations, Variations, Payments, Documents, and Timeline.

## Problem Statement / Scope

Contract managers need a comprehensive detail view to review and manage individual contracts. The header provides at-a-glance information while tabs organize related data into logical sections. This issue covers the shell and tab navigation; tab content is implemented in subsequent issues.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Detail Header | Display contract ID, title, supplier, value, status badge, and action buttons |
| 2 | Tab Bar | Render six tabs: Overview, Obligations, Variations, Payments, Documents, Timeline |
| 3 | Tab Routing | Switch content area based on selected tab; support deep-linking to tabs |
| 4 | Loading State | Progressive loading — header first, then tab content |
| 5 | Error State | "Unable to load contract data" message with retry |
| 6 | Back Navigation | Breadcrumb or back button to return to contract list |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- React component composition
- Tab-based navigation with URL hash or query param sync
- Progressive loading patterns
- Responsive tab layout (accordion on mobile)

## Acceptance Criteria

- [ ] Header displays contract ID, title, supplier, value, and status badge
- [ ] Six tabs render and are clickable
- [ ] Clicking a tab switches the content area to the corresponding section
- [ ] Deep-linking works: navigating to `/contracts/:id?tab=obligations` opens the correct tab
- [ ] Header loads first, tab content loads progressively
- [ ] Error state displays with retry button on fetch failure
- [ ] Back button returns to the contract list with preserved filters
- [ ] Responsive: tabs collapse to accordion on mobile viewports

## Dependencies

- API endpoint `GET /api/v1/contracts/:id` returning full contract object
- Contract data model with all metadata fields
- UI tab component with animated transitions

## Estimated Duration

- **Development**: 2 days
- **Testing**: 1 day
- **Total**: 3 days

## Risk Level

**Low** — Standard detail view pattern; tab content is deferred.

## QC Team Checks

- [ ] Header renders all required metadata fields
- [ ] Tab switching is smooth with no page reload
- [ ] Deep-link URLs load the correct tab on initial render
- [ ] Progressive loading shows header before tab content
- [ ] Error state retry recovers from simulated failure
- [ ] Back navigation preserves list scroll position and filters
- [ ] Mobile accordion behavior works correctly
