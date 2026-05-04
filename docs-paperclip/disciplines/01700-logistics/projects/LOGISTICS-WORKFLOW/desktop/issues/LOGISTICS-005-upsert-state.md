---
id: LOGISTICS-005
title: 01700 Upsert State — Field Capture & Transport Assignment Forms
description: Implement the upsert state modal for the 01700 logistics page with field capture and transport assignment forms
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
  agent_goal: "As domainforge-ai, implement the upsert state with field capture and transport assignment forms"
  task_goal: "Execute upsert state rendering, form validation, and data submission with 100% pass rate"
---

# LOGISTICS-005: 01700 Upsert State — Field Capture & Transport Assignment Forms

## Executive Summary

This issue implements the Upsert state modal for the 01700 logistics page. The upsert state provides forms for capturing field transaction data (weighbridge readings, mobile captures) and assigning transport routes to deliveries. Successful completion enables field operators to record transactions and logistics managers to assign transport.

## Problem Statement / Scope

Field data capture requires structured forms for weighbridge readings (vehicle, material, gross/tare weight, timestamp) and mobile captures (QR/barcode scan, photo, GPS coordinates). Transport assignment requires route selection, driver assignment, and delivery scheduling. The upsert state must support both create and edit modes with validation.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 5A | Upsert state modal rendering | Upsert state modal opens from state button; displays form selection |
| 5B | Field capture form | Weighbridge and mobile capture forms render with correct fields and validation |
| 5C | Transport assignment form | Transport assignment form renders with route, driver, and schedule fields |
| 5D | Form validation | Required fields validated; business rules enforced before submission |
| 5E | Data submission | Form data submitted to API; success confirmation displayed |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Sub-agents:** None

## Required Skills

- domain-knowledge
- form-implementation
- validation

## Acceptance Criteria

- [ ] Upsert state modal opens from Upserts state button
- [ ] Modal displays form type selector (Field Capture, Transport Assignment)
- [ ] Field capture form includes: Vehicle (autocomplete), Material (autocomplete), Gross Weight, Tare Weight, Timestamp, Location (GPS/manual)
- [ ] Mobile capture form includes: QR/Barcode scan, Photo upload, GPS coordinates, Notes
- [ ] Transport assignment form includes: Route selector, Driver selector, Scheduled date/time, Priority
- [ ] All required fields marked with asterisk
- [ ] Form validation prevents submission with missing required fields
- [ ] Weight validation: Gross > Tare; Net weight within configured tolerance
- [ ] Duplicate check: Alert if similar transaction exists within time window
- [ ] Successful submission shows confirmation and closes modal
- [ ] Edit mode pre-populates form with existing data
- [ ] CSS class naming follows `A-01700-*` convention

## Dependencies

- **Blocked by:** None
- **Depends on:** LOGISTICS-001, LOGISTICS-002, LOGISTICS-003
- **Blocks:** LOGISTICS-007, LOGISTICS-008, LOGISTICS-009

## Estimated Duration

60 minutes

## Risk Level

**High** — primary data entry interface. Failure impacts field data capture capabilities.

## QC Team Checks

- [ ] Form fields match UI-UX spec specification
- [ ] Validation rules match FSP-001 field capture specification
- [ ] Autocomplete fields query correct data sources
- [ ] Duplicate check logic matches FSP-007 specification
- [ ] Form submission correctly creates/updates database records
- [ ] CSS class naming follows `A-01700-*` convention