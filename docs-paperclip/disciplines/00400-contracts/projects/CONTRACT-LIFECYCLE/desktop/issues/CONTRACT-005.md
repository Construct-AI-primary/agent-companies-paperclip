---
id: CONTRACT-005
title: "00400 Upsert State — Contract Creation Form (from PO, Award, Blank)"
description: "Implement the Upsert state with a contract creation form supporting three source paths: import from Purchase Order (INT-009), import from Award Recommendation (INT-002), or blank template."
labels: ["contracts", "00400", "2 — State/Modals"]
blocked_by: []
depends_on: ["CONTRACT-001", "CONTRACT-002", "CONTRACT-003"]
para_section: contracts/projects/CONTRACT-LIFECYCLE/desktop/issues
phase: "2 — State/Modals"
status: todo
priority: High
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
  agent_goal: "As domainforge-ai, implement the contract creation form with PO, award, and blank source paths"
  task_goal: "Execute upsert state implementation with 100% pass rate"
---

# CONTRACT-005: 00400 Upsert State — Contract Creation Form (from PO, Award, Blank)

## Executive Summary

Implement the Upsert state for contract creation. Users can create contracts from three sources: importing data from an approved Purchase Order (INT-009 integration), importing from an Award Recommendation (INT-002 integration), or starting from a blank template. The form guides users through template selection, terms definition, parties, scope, value, schedule, and clause configuration.

## Problem Statement / Scope

Contract creation is the primary data entry point for the contract lifecycle. The form must support three distinct creation paths while maintaining a consistent workflow. Data imported from PO or Award sources must pre-populate relevant fields. The form must validate all required fields before submission.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Source Selection | Three-option selector: From PO, From Award, Blank Template |
| 2 | PO Import | Fetch PO data via INT-009 and pre-populate contract fields |
| 3 | Award Import | Fetch award data via INT-002 and pre-populate contract fields |
| 4 | Template Selection | Choose contract template from clause library |
| 5 | Terms Definition | Form sections for contract terms, parties, scope, value, schedule |
| 6 | Clause Configuration | Select and configure clauses from the clause library |
| 7 | Review & Submit | Review draft summary and submit for signing workflow |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- Multi-step form implementation with validation
- Integration API consumption (INT-009, INT-002)
- Dynamic form fields based on source and template
- Form state management with draft persistence

## Acceptance Criteria

- [ ] Source selection screen shows three clear options with descriptions
- [ ] PO import fetches and displays PO data; user confirms before proceeding
- [ ] Award import fetches and displays award data; user confirms before proceeding
- [ ] Blank template starts with empty form fields
- [ ] Template selection filters available templates by contract type
- [ ] Terms form validates all required fields before allowing submission
- [ ] Clause configuration allows selection and parameterization of clauses
- [ ] Review screen shows complete contract draft before final submission
- [ ] Form state persists locally in case of browser refresh
- [ ] Successful submission creates contract and redirects to detail view

## Dependencies

- API endpoints: `POST /api/v1/contracts`, `GET /api/v1/contracts/templates`
- Integration endpoints: INT-009 PO data, INT-002 award data
- Clause library API for available clauses

## Estimated Duration

- **Development**: 3 days
- **Testing**: 1 day
- **Total**: 4 days

## Risk Level

**Medium** — Integration dependencies may introduce latency; form complexity requires thorough validation.

## QC Team Checks

- [ ] All three creation paths produce valid contracts
- [ ] PO import correctly maps PO fields to contract fields
- [ ] Award import correctly maps award fields to contract fields
- [ ] Form validation catches all missing required fields
- [ ] Draft persistence survives browser refresh
- [ ] Clause configuration correctly associates clauses with contract
- [ ] Review screen accurately reflects all entered data
- [ ] Submission creates contract and redirects correctly
