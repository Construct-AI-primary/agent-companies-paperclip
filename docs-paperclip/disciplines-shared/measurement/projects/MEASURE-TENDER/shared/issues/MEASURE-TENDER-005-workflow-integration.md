---
delegation:
  parent_goal_id: "MEASURE-ROOT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Deliver MEASURE-TENDER subcontractor integration system"
title: "MEASURE-TENDER-005: BUILDER-MEAS Workflow Integration"
description: "Integrate Subcontract Tender System with BUILDER-MEAS-009 to 013 workflows for seamless BOQ to subcontract award"
gigabrain_tags: issue, measurement, tender, workflow-integration, builder-meas, boq-disaggregation, trade-packages
labels: ["measurement", "tender", "integration", "workflow"]
blocked_by: []
depends_on: ["MEASURE-TENDER-001", "MEASURE-TENDER-002", "MEASURE-TENDER-003", "MEASURE-TENDER-004"]
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/shared/issues
last_updated: 2026-04-25
status: backlog
phase: "3 — Enhancement & Optimization"
priority: Critical
story_points: 21
due_date: "2026-05-10"
assignee: procurement-strategy-domainforge-procurement-strategy
company: domainforge-ai
team: engineering
---

# MEASURE-TENDER-005: BUILDER-MEAS Workflow Integration

## Executive Summary

Integrate the Subcontract Tender System (MEASURE-TENDER) with the existing BUILDER-MEAS workflows (009–013) to create a seamless pipeline from BOQ extraction through subcontract award. This is the **critical glue** that connects measurement → disaggregation → trade packages → RFQ → quotation → award. The integration spans five workflow touchpoints with bidirectional data flow between MEASURE-TENDER database tables and BUILDER-MEAS orchestration.

## Required Actions

| Action | Details |
|--------|---------|
| BUILDER-MEAS-009 integration | Create `subcontract_rfqs` records with `boq_reference_id` on BOQ disaggregation complete |
| BUILDER-MEAS-010 integration | Update `subcontract_rfqs` with full scope details on trade package formulation |
| BUILDER-MEAS-011 integration | Publish RFQ and trigger sub-vendor notifications on tender document generation |
| BUILDER-MEAS-012 integration | Insert into `quotation_comparisons` on quotation received |
| BUILDER-MEAS-013 integration | Update RFQ status and set `best_bid_id` on subcontract award |
| Scoring algorithm | Implement technical (40%), commercial (40%), B-BBEE (20%) weighted scoring |
| Workflow state machine | Manage RFQ state transitions: draft → published → closed → awarded |
| Variance tracking | Track BOQ value vs RFQ value variance |
| Integration test cases | End-to-end tests for BOQ→RFQ and quotation→award flows |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Assignee**: procurement-strategy-domainforge-procurement-strategy
- **Team**: engineering

## Required Skills

- Workflow orchestration / event-driven architecture
- Node.js / JavaScript
- Database operations (PostgreSQL)
- Scoring algorithm implementation
- Integration testing

## Acceptance Criteria

- [ ] BOQ reference linkage implemented (MEASURE-TENDER ↔ BUILDER-MEAS-009)
- [ ] Trade category mapping working correctly
- [ ] RFQ auto-creation from trade packages
- [ ] Quotation collection feeding into comparison matrix
- [ ] Scoring algorithm calculating overall scores
- [ ] Award workflow updating RFQ status
- [ ] Variance tracking between BOQ value and RFQ value
- [ ] Complete audit trail for compliance
- [ ] Error handling for failed integrations

## Dependencies

- MEASURE-TENDER-001: Database Schema complete
- MEASURE-TENDER-002: Integration Service complete
- MEASURE-TENDER-003: API Routes complete
- MEASURE-TENDER-004: UI Dashboard complete
- BUILDER-MEAS-009 to 013 workflows in MeasureForge AI

## Estimated Duration

- **Story Points**: 21
- **Estimated Hours**: 16–20 hours
- **Due Date**: 2026-05-10

## Risk Level

High — critical integration path touching 5 existing workflows; failure blocks the entire BOQ-to-award pipeline.

## QC Team Checks

- [ ] All 5 BUILDER-MEAS integration points wired correctly
- [ ] BOQ reference linkage verified end-to-end
- [ ] Scoring algorithm produces correct weighted scores
- [ ] RFQ state machine transitions match spec
- [ ] Variance tracking values are accurate
- [ ] Error handling covers workflow failure scenarios
- [ ] Integration tests pass for BOQ→RFQ and quotation→award flows

---

**Issue Type**: Integration / Flow Orchestration  
**Estimated Hours**: 16–20 hours  
**Agent Assignment**: procurement-strategy-domainforge-procurement-strategy (domainforge-ai)
