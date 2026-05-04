---
id: GOVERNANCE-005
title: "01300 Upsert State — Form Creation & Template Management"
description: "Implement the Upsert state for creating and editing governance forms with template selection, field configuration, and policy assignment."
labels: ["governance", "01300", "2 — State/Modals"]
blocked_by: []
depends_on: ["GOVERNANCE-001", "GOVERNANCE-002", "GOVERNANCE-003"]
para_section: governance/projects/GOVERNANCE-FORMS/desktop/issues
phase: "2 — State/Modals"
status: todo
priority: High
story_points: 3
due_date: "2026-05-20"
assignee: "domainforge-ai"
company: "domainforge-ai"
delegation:
  parent_goal_id: "GOVERNANCE-FORMS-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement 01300 governance form management"
  agent_goal: "As domainforge-ai, implement the Upsert state for form creation and template management"
  task_goal: "Execute Upsert state implementation with 100% pass rate"
---

# GOVERNANCE-005: 01300 Upsert State — Form Creation & Template Management

## Executive Summary

Implement the Upsert state providing forms for creating and editing governance forms. The forms include template selection, dynamic field configuration, policy assignment, and approval routing configuration.

## Problem Statement / Scope

Governance officers need a standardized interface for creating forms with consistent structure, policy alignment, and approval routing. Without a structured form builder, governance processes become inconsistent. The scope covers form creation, template management, and policy assignment.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Form Metadata Form | Fields for title, type, discipline, and description |
| 2 | Template Selection | Select from available form templates with preview |
| 3 | Dynamic Field Configuration | Configure form fields based on selected template |
| 4 | Policy Assignment | Assign governance policies and compliance rules to the form |
| 5 | Form Validation & Submit | Client-side validation with API submission and success/error handling |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- React form handling (Formik, React Hook Form)
- Dynamic form field generation
- Template selection and preview
- Form validation library (Yup, Zod)

## Acceptance Criteria

- [ ] Metadata form captures all required form fields
- [ ] Template selection shows available templates with preview
- [ ] Dynamic fields render based on selected template configuration
- [ ] Policy assignment allows selecting applicable governance policies
- [ ] Form validation prevents submission with missing required fields
- [ ] Edit mode pre-populates form with existing form data
- [ ] Successful submission redirects to form detail view
- [ ] Error state displays API errors with field-level messaging
- [ ] Unsaved changes prompt warning on navigation away

## Dependencies

- API endpoints `POST /api/v1/governance/forms` and `PUT /api/v1/governance/forms/:id`
- Form template data model
- Policy reference data
- Form validation schema

## Estimated Duration

- **Development**: 3 days
- **Testing**: 1 day
- **Total**: 4 days

## Risk Level

**Medium** — Complex form with dynamic fields and template integration.

## QC Team Checks

- [ ] All form fields render and accept input correctly
- [ ] Template selection loads correct template configuration
- [ ] Dynamic fields render correctly for each template
- [ ] Policy assignment selects correct policies
- [ ] Form validation catches all required field omissions
- [ ] Edit mode loads existing data correctly
- [ ] Submit sends correct payload to API
