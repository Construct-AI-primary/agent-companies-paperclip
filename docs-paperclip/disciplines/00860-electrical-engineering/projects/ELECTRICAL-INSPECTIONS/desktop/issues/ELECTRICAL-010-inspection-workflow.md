---
id: ELECTRICAL-010
title: "00860 Inspection Workflow — Pass/Fail Classification & Corrective Actions"
description: "Implement the inspection workflow engine for pass/fail classification, corrective action tracking, and re-inspection scheduling."
labels: ["electrical", "00860", "4 — Advanced"]
blocked_by: []
depends_on: ["ELECTRICAL-007", "ELECTRICAL-008", "ELECTRICAL-009"]
para_section: electrical-engineering/projects/ELECTRICAL-INSPECTIONS/desktop/issues
phase: "4 — Advanced"
status: todo
priority: Medium
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
  agent_goal: "As domainforge-ai, implement inspection workflow with pass/fail classification"
  task_goal: "Execute inspection workflow implementation with 100% pass rate"
---

# ELECTRICAL-010: 00860 Inspection Workflow — Pass/Fail Classification & Corrective Actions

## Executive Summary

Implement the inspection workflow engine that manages pass/fail classification, corrective action assignment, and re-inspection scheduling. This workflow ensures failed inspections are tracked through resolution and re-verification.

## Problem Statement / Scope

Inspections that fail require structured follow-up with corrective actions, assignment to responsible parties, and re-inspection to verify resolution. Without a workflow engine, failed inspections may not be properly tracked to closure. The scope covers classification, corrective action management, and re-inspection workflow.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Pass/Fail Classification Logic | Implement classification rules based on measurement thresholds and observation criteria |
| 2 | Corrective Action Assignment | Form for creating and assigning corrective actions to responsible parties |
| 3 | Corrective Action Tracking | Dashboard for tracking open, in-progress, and completed corrective actions |
| 4 | Re-Inspection Scheduling | Workflow for scheduling re-inspections after corrective actions are completed |
| 5 | Workflow Status Transitions | State machine for inspection status transitions (Passed, Failed, Re-Inspection Scheduled, Closed) |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- Workflow/state machine implementation
- Task assignment and tracking patterns
- Notification integration
- Status transition management

## Acceptance Criteria

- [ ] Pass/Fail classification is automatically determined from measurement thresholds
- [ ] Manual override of classification is available with reason logging
- [ ] Corrective actions can be created with description, assignee, and due date
- [ ] Corrective action status is tracked and visible in inspection detail
- [ ] Re-inspection is scheduled automatically when corrective actions are completed
- [ ] Workflow status transitions follow the defined state machine
- [ ] Notifications are sent on status changes and corrective action assignments
- [ ] Dashboard shows count of open corrective actions by priority
- [ ] Audit log records all status transitions and actions taken

## Dependencies

- Workflow engine or state machine library
- Task/action data model
- Notification service API
- Inspection data model with status field

## Estimated Duration

- **Development**: 3 days
- **Testing**: 1 day
- **Total**: 4 days

## Risk Level

**Medium** — Workflow logic with multiple state transitions and dependencies.

## QC Team Checks

- [ ] Classification logic produces correct results for all threshold scenarios
- [ ] Corrective action creation and assignment works end-to-end
- [ ] Status transitions follow the defined workflow rules
- [ ] Re-inspection scheduling triggers correctly after corrective action completion
- [ ] Notifications are sent on all required events
- [ ] Dashboard counts reflect actual open actions
- [ ] Audit log captures all status transitions with timestamps
