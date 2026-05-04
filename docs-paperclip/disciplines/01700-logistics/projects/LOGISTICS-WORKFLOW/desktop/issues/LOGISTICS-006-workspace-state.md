---
id: LOGISTICS-006
title: 01700 Workspace State — Transport Tracking Board & Delivery Queue
description: Implement the workspace state modal for the 01700 logistics page with transport tracking board and delivery queue
labels: ["logistics", "01700", "2 — State/Modals"]
blocked_by: []
depends_on: ["LOGISTICS-001", "LOGISTICS-002", "LOGISTICS-003"]
para_section: logistics/projects/LOGISTICS-WORKFLOW/desktop/issues
phase: "2 — State/Modals"
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
  agent_goal: "As domainforge-ai, implement the workspace state with transport tracking board and delivery queue"
  task_goal: "Execute workspace state rendering, tracking board, and queue management with 100% pass rate"
---

# LOGISTICS-006: 01700 Workspace State — Transport Tracking Board & Delivery Queue

## Executive Summary

This issue implements the Workspace state modal for the 01700 logistics page. The workspace state provides a transport tracking board showing active deliveries with real-time status and a delivery queue for managing pending assignments. Successful completion enables logistics managers to monitor and manage transport operations.

## Problem Statement / Scope

Transport operations require real-time visibility into active deliveries, driver assignments, and delivery status. The workspace state must provide a kanban-style tracking board with status columns (Assigned, In Transit, Delivered, Exception) and a delivery queue for pending assignments.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 6A | Workspace state modal rendering | Workspace state modal opens from state button; displays tracking board |
| 6B | Transport tracking board | Kanban board renders with status columns and delivery cards |
| 6C | Delivery queue | Queue displays pending deliveries with priority sorting |
| 6D | Drag-and-drop status updates | Cards can be dragged between status columns; status updates in database |
| 6E | Real-time updates | Board updates in real-time as delivery statuses change |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Sub-agents:** None

## Required Skills

- domain-knowledge
- ui-implementation
- real-time-updates

## Acceptance Criteria

- [ ] Workspace state modal opens from Workspace state button
- [ ] Tracking board displays columns: Assigned, In Transit, Delivered, Exception
- [ ] Each column shows delivery cards with key info (ID, vehicle, driver, ETA)
- [ ] Delivery queue shows pending assignments sorted by priority
- [ ] Cards can be dragged between status columns
- [ ] Drag-and-drop triggers status update API call
- [ ] Status update reflects in database within 2 seconds
- [ ] Board auto-refreshes every 15 seconds
- [ ] Exception column highlights deliveries with issues
- [ ] Clicking delivery card opens detail view
- [ ] Queue items can be assigned to drivers
- [ ] CSS class naming follows `A-01700-*` convention

## Dependencies

- **Blocked by:** None
- **Depends on:** LOGISTICS-001, LOGISTICS-002, LOGISTICS-003
- **Blocks:** LOGISTICS-007, LOGISTICS-008, LOGISTICS-009

## Estimated Duration

60 minutes

## Risk Level

**High** — primary operations view. Failure impacts transport management capabilities.

## QC Team Checks

- [ ] Workspace state modal matches UI-UX spec design
- [ ] Kanban board columns match transport workflow stages
- [ ] Drag-and-drop works correctly across all browsers
- [ ] Real-time updates do not cause visual flicker
- [ ] Exception handling correctly identifies delayed or problematic deliveries
- [ ] CSS class naming follows `A-01700-*` convention