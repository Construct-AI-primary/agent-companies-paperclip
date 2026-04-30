---
id: PROCURE-008
title: 01900 Templates — Purchase/Service/Work Orders & SOW Appendices
description: Verify all 4 order templates (PO, SO, WO, SOW) and 6 appendices (A-F) populate correctly with compliance rules applied
labels: ["testing", "procurement", "3 — Integration"]
blocked_by: []
depends_on: ["PROCURE-001", "PROCURE-002", "PROCURE-007"]
para_section: testing/projects/PROCURE-TEST/desktop/issues
phase: 3 — Integration
status: todo
priority: High
story_points: 8
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
  agent_goal: "As procurement-domainforge-procurement-contracts, verify all 4 order templates (PO, SO, WO, SOW) and 6 appendices (A-F) populate correctly with compliance rules applied"
  task_goal: "Execute template population, appendix generation, and compliance validation with >90% pass rate"
---

# PROCURE-008: 01900 Templates — Purchase/Service/Work Orders & SOW Appendices

## Executive Summary

This issue validates all four order templates and six appendices on the 01900 procurement page. The templates — Purchase Order (PO), Service Order (SO), Work Order (WO), and Statement of Work (SOW) — must populate correctly with data from the procurement system. The six appendices (A through F) must generate with correct content and compliance rules applied. This is the final validation gate before production sign-off. A pass rate above 90% is required.

## Problem Statement / Scope

The 01900 page generates procurement documents using four distinct templates, each with specific field mappings, formatting rules, and compliance requirements. Additionally, six appendices (A-F) provide supplementary terms, conditions, and specifications. All templates and appendices must populate with correct data, apply compliance rules (e.g., required clauses, approval thresholds), and produce valid output documents. This issue covers template rendering, data population, appendix generation, and compliance rule enforcement. It depends on the workflow orchestrator (PROCURE-007) for data flow integration.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 8A | Purchase Order (PO) template | PO template populates with correct buyer/supplier info, line items, totals; compliance rules applied |
| 8B | Service Order (SO) template | SO template populates with correct service descriptions, rates, duration; compliance rules applied |
| 8C | Work Order (WO) template | WO template populates with correct scope, tasks, milestones; compliance rules applied |
| 8D | Statement of Work (SOW) template | SOW template populates with correct objectives, deliverables, timeline; compliance rules applied |
| 8E | Appendix A — General Terms | Appendix A generates with correct general terms and conditions |
| 8F | Appendix B — Payment Terms | Appendix B generates with correct payment schedule and terms |
| 8G | Appendix C — Compliance Requirements | Appendix C generates with correct regulatory and compliance clauses |
| 8H | Appendix D — Technical Specifications | Appendix D generates with correct technical specifications |
| 8I | Appendix E — Service Level Agreement | Appendix E generates with correct SLA targets and remedies |
| 8J | Appendix F — Data Protection | Appendix F generates with correct data protection and privacy clauses |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** procurement-domainforge-procurement-contracts
- **Sub-agents:** None

## Required Skills

- procurement-domain-knowledge
- template-validation

## Acceptance Criteria

- [ ] PO template: buyer/supplier information populates correctly
- [ ] PO template: line items render with correct quantities, prices, and totals
- [ ] PO template: compliance rules (approval thresholds, required clauses) are applied
- [ ] SO template: service descriptions, rates, and duration populate correctly
- [ ] SO template: compliance rules are applied
- [ ] WO template: scope, tasks, and milestones populate correctly
- [ ] WO template: compliance rules are applied
- [ ] SOW template: objectives, deliverables, and timeline populate correctly
- [ ] SOW template: compliance rules are applied
- [ ] Appendix A: General terms render correctly
- [ ] Appendix B: Payment terms render with correct schedule
- [ ] Appendix C: Compliance clauses render correctly
- [ ] Appendix D: Technical specifications render correctly
- [ ] Appendix E: SLA targets and remedies render correctly
- [ ] Appendix F: Data protection clauses render correctly
- [ ] All documents generate in the correct output format (PDF/DOCX)
- [ ] Document preview renders without layout issues

## Dependencies

- **Blocked by:** PROCURE-001 (page foundation), PROCURE-002 (database connectivity), PROCURE-007 (workflow orchestrator for data flow)
- **Depends on:** PROCURE-001, PROCURE-002, PROCURE-007
- **Blocks:** None (final validation gate)

## Estimated Duration

60 minutes

## Risk Level

**High** — Templates are the final output of the procurement system. Failures here produce incorrect or non-compliant procurement documents with potential legal and financial consequences.

## QC Team Checks

The following checks must be performed against the PAGE-KNOWLEDGE metadata for the 01900 page:

- [ ] **PO template:** Verify all fields populate: PO number, date, buyer, supplier, line items (description, qty, unit price, total), subtotal, tax, grand total
- [ ] **SO template:** Verify all fields populate: SO number, service description, rate type (fixed/hourly), duration, total cost
- [ ] **WO template:** Verify all fields populate: WO number, scope statement, task list with assignments, milestone dates
- [ ] **SOW template:** Verify all fields populate: SOW number, objectives, deliverables with acceptance criteria, timeline with phases
- [ ] **Appendix A:** Verify general terms include governing law, dispute resolution, confidentiality
- [ ] **Appendix B:** Verify payment terms include schedule, method, late payment penalties
- [ ] **Appendix C:** Verify compliance requirements include applicable regulations, certifications, audit rights
- [ ] **Appendix D:** Verify technical specifications include standards, performance requirements, testing criteria
- [ ] **Appendix E:** Verify SLA includes availability targets, response times, credits/remedies
- [ ] **Appendix F:** Verify data protection includes data classification, handling requirements, breach notification
- [ ] **Compliance rules:** Verify each template enforces required clauses based on order value and type
- [ ] **Output format:** Verify documents generate in the configured output format without corruption