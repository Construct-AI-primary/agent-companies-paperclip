---
id: ELECTRICAL-005
title: "00860 Upsert State — Inspection Report Creation Form"
description: "Implement the Upsert state for creating and editing electrical inspection reports with form fields for measurements, observations, and classification."
labels: ["electrical", "00860", "2 — State/Modals"]
blocked_by: []
depends_on: ["ELECTRICAL-001", "ELECTRICAL-002", "ELECTRICAL-003"]
para_section: electrical-engineering/projects/ELECTRICAL-INSPECTIONS/desktop/issues
phase: "2 — State/Modals"
status: todo
priority: High
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
  agent_goal: "As domainforge-ai, implement the Upsert state for inspection report creation"
  task_goal: "Execute Upsert state implementation with 100% pass rate"
---

# ELECTRICAL-005: 00860 Upsert State — Inspection Report Creation Form

## Executive Summary

Implement the Upsert state providing a comprehensive form for creating and editing electrical inspection reports. The form includes sections for inspection metadata, measurement recording, observation notes, and pass/fail classification with corrective action tracking.

## Problem Statement / Scope

Inspectors need a structured form to record inspection findings consistently. Without a standardized form, data quality suffers and compliance reporting becomes difficult. The scope covers the full inspection report creation and editing workflow.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Inspection Metadata Form | Fields for title, location, date, inspector assignment, and inspection type |
| 2 | Measurement Recording | Dynamic form sections for recording electrical measurements (voltage, current, resistance, etc.) |
| 3 | Observation Notes | Rich text area for inspector observations with photo attachment support |
| 4 | Pass/Fail Classification | Radio/select input for overall result with corrective action text field |
| 5 | Form Validation & Submit | Client-side validation with API submission and success/error handling |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- React form handling (Formik, React Hook Form)
- Dynamic form field generation
- File upload handling for photos
- Form validation library (Yup, Zod)

## Acceptance Criteria

- [ ] Metadata form captures all required inspection fields
- [ ] Measurement section allows adding multiple measurement entries with type, value, and unit
- [ ] Observation notes support rich text formatting and image attachments
- [ ] Pass/Fail classification includes required corrective action field when Failed
- [ ] Form validation prevents submission with missing required fields
- [ ] Edit mode pre-populates form with existing inspection data
- [ ] Successful submission redirects to inspection detail view
- [ ] Error state displays API errors with field-level messaging
- [ ] Unsaved changes prompt warning on navigation away

## Dependencies

- API endpoints `POST /api/v1/inspections` and `PUT /api/v1/inspections/:id`
- Inspection data model with all form fields
- File upload API endpoint for photo attachments
- Form validation schema

## Estimated Duration

- **Development**: 3 days
- **Testing**: 1 day
- **Total**: 4 days

## Risk Level

**Medium** — Complex form with dynamic fields and file uploads.

## QC Team Checks

- [ ] All form fields render and accept input correctly
- [ ] Dynamic measurement fields add/remove without issues
- [ ] File upload works for images and shows preview
- [ ] Form validation catches all required field omissions
- [ ] Edit mode loads existing data correctly
- [ ] Submit sends correct payload to API
- [ ] Unsaved changes warning triggers on navigation
