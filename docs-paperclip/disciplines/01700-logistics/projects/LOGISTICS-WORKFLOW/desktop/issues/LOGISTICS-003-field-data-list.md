---
id: LOGISTICS-003
title: 01700 Field Data List — Transaction Records & Verification Status
description: Implement and verify the field data list view showing transaction records with verification status for the 01700 logistics page
labels: ["logistics", "01700", "1 — Foundation"]
blocked_by: []
depends_on: ["LOGISTICS-001", "LOGISTICS-002"]
para_section: logistics/projects/LOGISTICS-WORKFLOW/desktop/issues
phase: "1 — Foundation"
status: todo
priority: High
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
  agent_goal: "As domainforge-ai, implement the field data list with transaction records and verification status"
  task_goal: "Execute list rendering, status indicators, and pagination with 100% pass rate"
---

# LOGISTICS-003: 01700 Field Data List — Transaction Records & Verification Status

## Executive Summary

This issue implements the field data list view for the 01700 logistics page. The list displays transaction records captured from field operations (weighbridge, mobile) with verification status indicators. Successful completion enables field operators and managers to review and verify transaction data.

## Problem Statement / Scope

Field data must be captured, stored, and displayed for verification. The list view must show transaction records with key fields (transaction ID, timestamp, weight, vehicle, material, status), provide filtering and sorting, and support pagination for large datasets.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 3A | List view rendering | Field data list renders with correct columns and row data |
| 3B | Status indicators | Verification status (Pending, Verified, Flagged, Rejected) displayed with correct colors |
| 3C | Filter controls | Date, status, vehicle, and material filters function correctly |
| 3D | Sorting | Clickable column headers sort data ascending/descending |
| 3E | Pagination | Pagination controls work correctly; configurable page size |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Sub-agents:** None

## Required Skills

- domain-knowledge
- ui-implementation
- data-grid

## Acceptance Criteria

- [ ] List renders with columns: Transaction ID, Date/Time, Weight, Vehicle, Material, Status
- [ ] Status indicators use correct colors (Pending=amber, Verified=green, Flagged=red, Rejected=gray)
- [ ] Date range filter restricts displayed records
- [ ] Status filter (All, Pending, Verified, Flagged, Rejected) works correctly
- [ ] Vehicle filter autocompletes from registered vehicles
- [ ] Material filter autocompletes from material catalog
- [ ] Clicking column header sorts data (ascending/descending toggle)
- [ ] Pagination displays correct page count and record range
- [ ] Page size selector (10/25/50/100) works correctly
- [ ] Row click navigates to transaction detail view
- [ ] CSS class naming follows `A-01700-*` convention

## Dependencies

- **Blocked by:** None
- **Depends on:** LOGISTICS-001, LOGISTICS-002
- **Blocks:** LOGISTICS-004, LOGISTICS-005, LOGISTICS-006

## Estimated Duration

45 minutes

## Risk Level

**High** — primary data review interface. Failure impacts field data verification workflow.

## QC Team Checks

- [ ] List columns match UI-UX spec specification
- [ ] Status indicator colors match design system
- [ ] Filter combinations produce correct results
- [ ] Pagination maintains state across sort/filter changes
- [ ] Large dataset (1000+ records) renders without performance issues
- [ ] CSS class naming follows `A-01700-*` convention