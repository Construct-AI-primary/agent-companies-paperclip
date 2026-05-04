---
id: LOGISTICS-002
title: 01700 Transaction Dashboard — Real-Time Map & Status Cards
description: Implement and verify the transaction dashboard with real-time map view and status cards for the 01700 logistics page
labels: ["logistics", "01700", "1 — Foundation"]
blocked_by: []
depends_on: ["LOGISTICS-001"]
para_section: logistics/projects/LOGISTICS-WORKFLOW/desktop/issues
phase: "1 — Foundation"
status: todo
priority: Critical
story_points: 3
due_date: "2026-05-20"
assignee: domainforge-ai
company: domainforge-ai
delegation:
  parent_goal_id: "LOGISTICS-WORKFLOW-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement 01700 logistics workflow management"
  agent_goal: "As domainforge-ai, implement the transaction dashboard with real-time map and status cards"
  task_goal: "Execute dashboard rendering, map integration, and status card verification with 100% pass rate"
---

# LOGISTICS-002: 01700 Transaction Dashboard — Real-Time Map & Status Cards

## Executive Summary

This issue implements the transaction dashboard for the 01700 logistics page. The dashboard provides a real-time map view showing active transactions and status cards displaying key metrics (active deliveries, pending verifications, completed transactions, flagged anomalies). Successful completion enables operational visibility into logistics workflows.

## Problem Statement / Scope

The logistics dashboard is the primary operational view for logistics managers. It must render a real-time map with transaction markers, display status cards with live counts, and provide filtering capabilities. This issue covers the dashboard layout, map integration, status card rendering, and data refresh mechanism.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 2A | Dashboard layout rendering | Dashboard loads with map panel and status card panel in correct layout |
| 2B | Real-time map integration | Map renders with transaction markers; markers update on data refresh |
| 2C | Status card rendering | Status cards display correct counts for active, pending, completed, flagged |
| 2D | Data refresh mechanism | Dashboard auto-refreshes every 30s; manual refresh button works |
| 2E | Filter controls | Date range, status, and region filters function correctly |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Sub-agents:** None

## Required Skills

- domain-knowledge
- ui-implementation
- map-integration

## Acceptance Criteria

- [ ] Dashboard loads within 3 seconds
- [ ] Map panel occupies left 60% of viewport
- [ ] Status card panel occupies right 40% of viewport
- [ ] Map renders with correct tile layer and zoom controls
- [ ] Transaction markers appear on map with correct status colors
- [ ] Status cards display: Active Deliveries, Pending Verification, Completed, Flagged
- [ ] Status card counts update on data refresh
- [ ] Auto-refresh interval is configurable (default 30s)
- [ ] Manual refresh button triggers immediate data reload
- [ ] Date range filter restricts displayed transactions
- [ ] Status filter (All, Active, Pending, Completed, Flagged) works correctly
- [ ] Region filter restricts map markers to selected area

## Dependencies

- **Blocked by:** None
- **Depends on:** LOGISTICS-001
- **Blocks:** LOGISTICS-003, LOGISTICS-004, LOGISTICS-005, LOGISTICS-006

## Estimated Duration

45 minutes

## Risk Level

**Critical** — primary operational view. Failure impacts all logistics monitoring capabilities.

## QC Team Checks

- [ ] Dashboard layout matches UI-UX spec wireframe
- [ ] Map tile layer loads without errors
- [ ] Status card counts match database query results
- [ ] Auto-refresh does not cause page flicker
- [ ] Filter controls reset correctly
- [ ] CSS class naming follows `A-01700-*` convention