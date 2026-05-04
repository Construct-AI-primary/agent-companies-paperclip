---
id: LOGISTICS-004
title: 01700 Agents State — Field Validation & Anomaly Detection
description: Implement the agents state modal for the 01700 logistics page with AI-powered field validation and anomaly detection
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
  agent_goal: "As domainforge-ai, implement the agents state with field validation and anomaly detection"
  task_goal: "Execute agents state rendering, validation logic, and anomaly detection with 100% pass rate"
---

# LOGISTICS-004: 01700 Agents State — Field Validation & Anomaly Detection

## Executive Summary

This issue implements the Agents state modal for the 01700 logistics page. The agents state provides AI-powered field validation and anomaly detection capabilities, enabling automated verification of weighbridge and mobile-captured transaction data against expected thresholds and patterns.

## Problem Statement / Scope

Field-captured transaction data requires validation against multiple criteria: weight tolerance, geofence boundaries, duplicate detection, and temporal consistency. The agents state must provide a chat-like interface where agents can review flagged transactions, validate data, and trigger corrective actions.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 4A | Agents state modal rendering | Agents state modal opens from state button; displays agent chat interface |
| 4B | Field validation agent | Agent reviews transaction data against validation rules; flags anomalies |
| 4C | Anomaly detection display | Anomalies displayed with severity, description, and recommended action |
| 4D | Validation action triggers | Agent can approve, reject, or escalate flagged transactions |
| 4E | Validation history | Agent actions logged with timestamp, user, and outcome |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Sub-agents:** None

## Required Skills

- domain-knowledge
- ai-integration
- validation-logic

## Acceptance Criteria

- [ ] Agents state modal opens from Agents state button
- [ ] Modal displays agent chat interface with transaction context
- [ ] Field validation agent loads with correct validation rules
- [ ] Weight deviation anomalies detected against configured tolerance
- [ ] Geofence boundary violations detected against transaction location
- [ ] Duplicate transaction detection based on vehicle/material/timestamp
- [ ] Temporal anomalies detected (e.g., unrealistic transit times)
- [ ] Anomalies displayed with severity level (Info, Warning, Critical)
- [ ] Agent can approve transaction (clears anomaly flag)
- [ ] Agent can reject transaction (triggers corrective action workflow)
- [ ] Agent can escalate to human reviewer
- [ ] All agent actions logged with timestamp and user identity

## Dependencies

- **Blocked by:** None
- **Depends on:** LOGISTICS-001, LOGISTICS-002, LOGISTICS-003
- **Blocks:** LOGISTICS-007, LOGISTICS-008, LOGISTICS-009

## Estimated Duration

60 minutes

## Risk Level

**High** — core validation logic. Failure impacts data integrity across logistics workflow.

## QC Team Checks

- [ ] Agents state modal matches UI-UX spec design
- [ ] Validation rules match FSP-007 context validation specification
- [ ] Anomaly severity levels are correctly assigned
- [ ] Agent actions correctly update transaction status in database
- [ ] Validation history is queryable and filterable
- [ ] CSS class naming follows `A-01700-*` convention