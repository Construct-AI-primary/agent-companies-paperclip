---
id: PROCURE-015
title: 01900 Subcontract RFQ Components — Portal Source Manager, Quotation Comparison & Subcontractor Directory
description: Verify all 10 new subcontract-rfq components added by MEASURE-TENDER-004 render, function, and comply with 01900 page standards
labels: ["testing", "procurement", "regression", "subcontract-rfq"]
blocked_by: []
depends_on: ["PROCURE-001", "PROCURE-005", "MEASURE-TENDER-004"]
para_section: testing/projects/PROCURE-TEST/desktop/issues
phase: 5 — Compliance & Sign-off
status: todo
priority: High
story_points: 8
due_date: "2026-05-06"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-PROCUREMENT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign subcontractor-specific checks to supplier-management-domainforge-procurement."
  allowed_sub_assignees: ["supplier-management-domainforge-procurement"]
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 01900 procurement page production readiness with subcontract-rfq components"
  agent_goal: "As validator-qualityforge, verify all 10 subcontract-rfq components added by MEASURE-TENDER-004 render, function, and follow 01900 page patterns"
  task_goal: "Execute subcontract-rfq component validation with >90% pass rate across all 10 new components"
---

# PROCURE-015: 01900 Subcontract RFQ Components — Regression & Validation

## Executive Summary
**Objective**: Validate all 10 new React components added by MEASURE-TENDER-004 inside `01900-procurement/components/subcontract-rfq/`. Verify they render correctly, follow 01900 page patterns (CSS, grid layout, button sorting), integrate with MEASURE-TENDER-003 API routes, and do not break existing page functionality.

**Component Count**: 10 new components + 1 CSS file + 1 service file
**Success Criteria**: >90% pass rate across all subcontract-rfq components

## Components to Test

| # | Component | Path | Primary Focus |
|---|-----------|------|--------------|
| 15A | SubcontractRFQPage.js | `subcontract-rfq/` | Main page integration with 01900 page state |
| 15B | SubcontractPortalManager.js | `subcontract-rfq/` | Portal source CRUD |
| 15C | PortalSourceCard.js | `subcontract-rfq/` | Source card rendering, status badges, quick actions |
| 15D | PortalSourceModal.js | `subcontract-rfq/` | Add/Edit source form validation |
| 15E | RFQListTable.js | `subcontract-rfq/` | RFQ listing, sorting, filtering, pagination |
| 15F | RFQDetailModal.js | `subcontract-rfq/` | RFQ view/edit |
| 15G | CreateRFQModal.js | `subcontract-rfq/` | New RFQ form, all 4 tender types |
| 15H | QuotationComparison.js | `subcontract-rfq/` | Side-by-side comparison, scoring, award recommendation |
| 15I | SubcontractorDirectory.js | `subcontract-rfq/` | Prequalified subcontractor listing |
| 15J | SubcontractorDetailModal.js | `subcontract-rfq/` | Subcontractor view/edit |
| 15K | SyncStatusPanel.js | `subcontract-rfq/` | Real-time sync status |
| 15L | subcontract-rfq.css | `css/` | CSS class compliance |
| 15M | subcontract-rfq-service.js | `services/` | API client integration |

## Required Actions

- **15A**: Verify SubcontractRFQPage.js integrates with 01900 page state management — page loads without breaking existing state buttons or modals
- **15B**: Portal Source Manager — CRUD operations for portal sources, health status indicators, test/sync/edit/delete actions
- **15C**: Portal Source Card — status badges (Active/Inactive/Error), stats display (last sync, RFQs synced, success rate), quick action buttons
- **15D**: Portal Source Modal — add/edit source form validation, credential encryption, integration type selection
- **15E**: RFQ List Table — sortable columns, filter by status/trade category/tender type, pagination, bulk actions (publish/close)
- **15F**: RFQ Detail Modal — view full RFQ details, edit support, status transitions
- **15G**: Create RFQ Modal — form for all 4 tender types (SUBCON/PO/SO/WO), trade category selection, CIDB grading, closing date
- **15H**: Quotation Comparison — side-by-side comparison matrix, technical/commercial score bars, award recommendation button, PDF/Excel export
- **15I**: Subcontractor Directory — prequalified list with compliance badges (CIDB, B-BBEE, Safety), trade category filter, performance history
- **15J**: Subcontractor Detail Modal — full subcontractor profile, status management (pending/approved/suspended/rejected)
- **15K**: Sync Status Panel — real-time sync status, last sync timestamps, success rates per source
- **15L**: CSS Compliance — verify prefixed classes follow EPCM naming (A-01900-subcontract-*), responsive design, consistent card/modal styling
- **15M**: API Integration — all endpoints from SubcontractRFQService respond correctly, error handling, loading states

## Assigned Company & Agent

- **Company:** QualityForge AI (primary) + DomainForge AI (supplier support)
- **Agent:** validator-qualityforge (primary), supplier-management-domainforge-procurement (consulted for subcontractor-specific checks)
- **Sub-agents:** supplier-management-domainforge-procurement (for SubcontractorDirectory/DetailModal domain validation)

## Required Skills

- quality-assurance
- ui-validation
- api-testing
- database-testing
- supplier-management-domain-knowledge

## Acceptance Criteria

- [ ] All 13 subcontract-rfq components (10 React, 1 CSS, 1 service, 1 page) render without errors
- [ ] Portal sources CRUD operations persist to subcontract_portal_sources table
- [ ] RFQ list supports sorting, filtering, and pagination
- [ ] RFQ creation supports all 4 tender types (SUBCON/PO/SO/WO) with correct trade categories
- [ ] Quotation comparison renders side-by-side with scoring visualization
- [ ] Award recommendation creates record in quotation_comparisons
- [ ] Subcontractor directory loads with correct compliance badges
- [ ] Sync status panel shows real-time sync data
- [ ] CSS classes follow A-01900-* naming convention
- [ ] Existing 7 workspace modals are unaffected (cross-check with PROCURE-005 results)
- [ ] API endpoints integrate correctly with MEASURE-TENDER-003 routes
- [ ] Error states and loading states handled gracefully
- [ ] Responsive at mobile/tablet/desktop breakpoints

## Dependencies

- **PROCURE-001**: 01900 page foundation must be verified
- **PROCURE-005**: Workspace state baseline must be established (to confirm existing modals are unaffected)
- **MEASURE-TENDER-004**: The subcontract-rfq components must be built and deployed
- **MEASURE-TENDER-003**: API routes must be operational
- **PROCURE-012 (post-build)**: CSS compliance baseline provides styling constraints

## Estimated Duration

60 minutes (including cross-check with existing workspace modals)

## Risk Level

High — subcontract-rfq components share the 01900 page directory and could conflict with existing components

## QC Team Checks

- [ ] **15A Page integration**: SubcontractRFQPage.js loads without breaking Agents/Upserts/Workspace state buttons
- [ ] **15B-15D Portal Sources**: Create/read/update/delete sources, test connection, sync now, error handling
- [ ] **15E-15G RFQ Management**: List loads, filters work, create RFQ with all tender types, status transitions
- [ ] **15H Quotation Comparison**: Matrix renders, score bars display correctly, award recommendation works
- [ ] **15I-15J Subcontractor Directory**: List loads, filters work, detail modal shows all fields, compliance badges correct
- [ ] **15K Sync Status**: Real-time indicators show correct status
- [ ] **15L CSS**: Class names follow `A-01900-subcontract-*` pattern, responsive at all breakpoints
- [ ] **15M API**: All endpoints respond correctly, error handling for 400/401/403/404/500
- [ ] **Existing modal check**: All 7 workspace modals still open and function correctly alongside new components

## Regression Note

This issue should be executed **after** MEASURE-TENDER-004 has deployed the subcontract-rfq components. Run it alongside the re-execution of PROCURE-005 (Workspace State) and PROCURE-012 (CSS Compliance) to form a complete regression pass against the final combined page.