---
id: PROCURE-007
title: 01900 Workflow Orchestrator — Comprehensive Workflows
description: Verify ProcurementWorkflowOrchestrator loads and all workflow paths (approval chains, order creation, SOW generation) execute correctly
labels: ["testing", "procurement", "3 — Integration"]
blocked_by: []
depends_on: ["PROCURE-001", "PROCURE-002", "PROCURE-003"]
para_section: testing/projects/PROCURE-TEST/desktop/issues
phase: 3 — Integration
status: todo
priority: High
story_points: 5
due_date: "2026-05-03"
assignee: procurement-domainforge-procurement-contracts
company: domainforge-ai
delegation:
  parent_goal_id: "QC-ROOT-PROCUREMENT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 01900 procurement page production readiness"
  agent_goal: "As procurement-domainforge-procurement-contracts, verify ProcurementWorkflowOrchestrator loads and all workflow paths (approval chains, order creation, SOW generation) execute correctly"
  task_goal: "Execute end-to-end workflow validation with >90% pass rate"
---

# PROCURE-007: 01900 Workflow Orchestrator — Comprehensive Workflows

## Executive Summary

This issue validates the ProcurementWorkflowOrchestrator component on the 01900 page. The workflow orchestrator manages end-to-end procurement processes including approval chains, purchase order creation, and Statement of Work (SOW) generation. Each workflow path must execute correctly from initiation through completion, with proper state transitions, data persistence, and error handling. A pass rate above 90% is required.

## Problem Statement / Scope

The ProcurementWorkflowOrchestrator is the engine that drives structured procurement processes. It must load correctly, render complete approval chains with all required approvers, execute the create order workflow end-to-end (from form to database persistence), generate SOW documents with correct content, and handle error states gracefully with user-friendly messaging. This issue covers all workflow paths defined in the 01900 page configuration. It depends on the Agents state modals (PROCURE-003) for order creation data entry.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 7A | Workflow orchestrator loads | ProcurementWorkflowOrchestrator component renders on the page without errors |
| 7B | Approval chain renders complete | All required approvers are listed in the correct order; chain is visually complete |
| 7C | Create order workflow executes end-to-end | Full order creation flow: form → validation → submission → confirmation → database persistence |
| 7D | SOW workflow generates document | SOW generation flow: input → template population → document preview → download/save |
| 7E | Error states handled gracefully | Invalid inputs, network failures, and missing data show user-friendly error messages; no crashes |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** procurement-domainforge-procurement-contracts
- **Sub-agents:** None

## Required Skills

- procurement-domain-knowledge
- workflow-testing

## Acceptance Criteria

- [ ] ProcurementWorkflowOrchestrator component loads without errors
- [ ] Approval chain displays all required approvers in correct order
- [ ] Approval chain status indicators render correctly (pending, approved, rejected)
- [ ] Create order workflow: form renders with all required fields
- [ ] Create order workflow: form validation enforces required fields
- [ ] Create order workflow: valid submission creates order record in database
- [ ] Create order workflow: confirmation message displays after submission
- [ ] SOW workflow: input form renders with required fields
- [ ] SOW workflow: template populates with correct data
- [ ] SOW workflow: document preview renders correctly
- [ ] SOW workflow: download/save function works
- [ ] Error states: invalid input shows validation error
- [ ] Error states: network failure shows retry option
- [ ] Error states: missing data shows appropriate message
- [ ] Workflow state persists correctly across steps

## Dependencies

- **Blocked by:** PROCURE-001 (page foundation), PROCURE-002 (database connectivity), PROCURE-003 (Agents state modals for order creation)
- **Depends on:** PROCURE-001, PROCURE-002, PROCURE-003
- **Blocks:** None

## Estimated Duration

45 minutes

## Risk Level

**High** — Workflow orchestrator is the core business logic component. Failures here prevent users from completing procurement processes.

## QC Team Checks

The following checks must be performed against the PAGE-KNOWLEDGE metadata for the 01900 page:

- [ ] **Workflow orchestrator loads:** Confirm ProcurementWorkflowOrchestrator component renders without console errors
- [ ] **Approval chain complete:** Verify all configured approvers appear in the chain; confirm order and status indicators
- [ ] **Create order workflow:** Execute full flow: open modal → fill form → submit → verify database row → confirm success message
- [ ] **SOW workflow:** Execute full flow: input data → generate SOW → preview document → verify download
- [ ] **Error handling:** Test each error case (invalid input, network failure, missing data); confirm graceful handling
- [ ] **State persistence:** Navigate through multi-step workflows; verify state is maintained between steps
