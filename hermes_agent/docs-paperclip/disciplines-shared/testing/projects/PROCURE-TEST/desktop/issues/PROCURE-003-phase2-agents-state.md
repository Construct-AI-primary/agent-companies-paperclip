---
id: PROCURE-003
title: 01900 Agents State — Correspondence Reply & Create Procurement Order
description: Verify Agents state button and both associated modals (Correspondence Reply, Create Procurement Order) open, validate, and submit correctly
labels: ["testing", "procurement", "2 — State Buttons & Modals"]
blocked_by: []
depends_on: ["PROCURE-001", "PROCURE-002"]
para_section: testing/projects/PROCURE-TEST/desktop/issues
phase: 2 — State Buttons & Modals
status: backlog
priority: High
story_points: 5
due_date: "2026-05-02"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-PROCUREMENT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 01900 procurement page production readiness"
  agent_goal: "As validator-qualityforge, verify Agents state button and both associated modals (Correspondence Reply, Create Procurement Order) open, validate, and submit correctly"
  task_goal: "Execute modal open/close, form validation, data persistence for both agents modals with >95% pass rate"
---

# PROCURE-003: 01900 Agents State — Correspondence Reply & Create Procurement Order

## Executive Summary

This issue validates the Agents state button and its two associated modals: Correspondence Reply and Create Procurement Order. The Agents state is the first of three page states and controls the procurement correspondence and order creation workflows. All modal open/close behavior, form field validation, data submission, and persistence must be verified. A pass rate above 95% is required.

## Problem Statement / Scope

When the user clicks the Agents state button, the page must transition to the Agents state, displaying two buttons in alphabetical order: Correspondence Reply and Create Procurement Order. Each button opens a distinct modal with specific form fields, validation rules, and submission targets. This issue covers the full lifecycle of both modals: rendering, interaction, validation, submission, and data persistence to the database. The Correspondence Reply modal must receive the correct category context, and the Create Procurement Order modal fields must match the procurement_orders table schema.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 3A | Agents button click sets correct state | Clicking Agents button highlights it; page state transitions to Agents; 2 buttons render in alphabetical order |
| 3B | Correspondence Reply modal open/close | Clicking Correspondence Reply opens modal; close button / backdrop click dismisses modal |
| 3C | Create Procurement Order modal open/close | Clicking Create Procurement Order opens modal; close button / backdrop click dismisses modal |
| 3D | Form field validation | All required fields enforce validation; invalid input shows error messages; valid input enables submit |
| 3E | Submission persistence | Submitted data persists in the corresponding database table; confirmation message displayed |

## Assigned Company & Agent

- **Company:** qualityforge-ai
- **Agent:** validator-qualityforge
- **Sub-agents:** None

## Required Skills

- quality-assurance
- ui-validation
- form-testing

## Acceptance Criteria

- [ ] Agents state button renders and is clickable
- [ ] Clicking Agents button highlights it and transitions page state
- [ ] Exactly 2 buttons render in Agents state: Correspondence Reply, Create Procurement Order
- [ ] Buttons are sorted alphabetically
- [ ] CorrespondenceReplyModal opens on button click
- [ ] CorrespondenceReplyModal closes via close button and backdrop click
- [ ] CorrespondenceReplyModal receives correct category context
- [ ] Create Procurement Order (ProcureInputAgentModal) opens on button click
- [ ] Create Procurement Order modal closes via close button and backdrop click
- [ ] Order form fields match procurement_orders table schema
- [ ] Required field validation shows error messages for empty required fields
- [ ] Valid form submission succeeds
- [ ] Submitted data persists in the database
- [ ] Confirmation message displays after successful submission
- [ ] Modal closes after successful submission

## Dependencies

- **Blocked by:** PROCURE-001 (page foundation), PROCURE-002 (database connectivity)
- **Depends on:** PROCURE-001, PROCURE-002
- **Blocks:** None

## Estimated Duration

45 minutes

## Risk Level

**High** — Agents state is the primary procurement interaction point. Failures here directly impact user ability to manage correspondence and create orders.

## QC Team Checks

The following checks must be performed against the PAGE-KNOWLEDGE metadata for the 01900 page:

- [ ] **2 buttons render in Agents state:** Confirm exactly two buttons appear: Correspondence Reply and Create Procurement Order
- [ ] **Alphabetical sort correct:** Verify buttons are sorted A-Z (Correspondence Reply before Create Procurement Order)
- [ ] **CorrespondenceReplyModal opens:** Confirm modal renders with correct title and form fields
- [ ] **Category context passed:** Verify the modal receives the correct correspondence category from page state
- [ ] **ProcureInputAgentModal opens:** Confirm modal renders with order creation form fields
- [ ] **Order form fields match schema:** Verify each form field maps to a column in `procurement_orders` table
- [ ] **Data persists:** After submission, query the database to confirm the row was inserted
- [ ] **Modal closes:** Confirm modal dismisses after successful submission
