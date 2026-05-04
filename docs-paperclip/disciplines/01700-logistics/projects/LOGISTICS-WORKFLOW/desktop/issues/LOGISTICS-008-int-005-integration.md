---
id: LOGISTICS-008
title: 01700 INT-005 Integration — Field Transaction → Document Registry
description: Implement INT-005 integration chain linking field transactions from logistics to document generation in 00900 Document Control
labels: ["logistics", "01700", "3 — Integration"]
blocked_by: []
depends_on: ["LOGISTICS-004", "LOGISTICS-005", "LOGISTICS-006"]
para_section: logistics/projects/LOGISTICS-WORKFLOW/desktop/issues
phase: "3 — Integration"
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
  agent_goal: "As domainforge-ai, implement INT-005 integration linking field transactions to document registry"
  task_goal: "Execute integration chain with document generation, numbering, and registry with 100% pass rate"
---

# LOGISTICS-008: 01700 INT-005 Integration — Field Transaction → Document Registry

## Executive Summary

This issue implements the INT-005 cross-discipline integration chain. When a field transaction is completed in the 01700 logistics workflow, the transaction data must flow to the 00900 Document Control module for automatic document generation and registry. This implements FSP-001 (Field Data Capture with Mobile Validation) and FSP-003 (Universal Transaction Correlation Pattern).

## Problem Statement / Scope

Field transactions (weighbridge readings, mobile captures) generate documents that must be registered in the document control system. The integration must pass transaction data to the document generation service, which creates the appropriate document type, assigns a document number, and registers it in the document registry.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 8A | Field transaction completion trigger | Transaction completion event fires INT-005 integration |
| 8B | Document generation request | Transaction data sent to document generation service |
| 8C | Document numbering | Document receives unique number from auto-sequence |
| 8D | Document registry update | Document registered in 00900 document registry |
| 8E | Correlation key linking | transaction_id linked to document_id in both systems |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Sub-agents:** None

## Required Skills

- domain-knowledge
- api-integration
- cross-discipline

## Acceptance Criteria

- [ ] Field transaction completion triggers INT-005 integration
- [ ] Data payload includes: transaction_id, transaction_type, vehicle, material, weight, timestamp, location
- [ ] Document generation service creates correct document type based on transaction type
- [ ] Document receives unique number from auto-sequence
- [ ] Document registered in 00900 document registry with status "Pending Approval"
- [ ] Correlation key (transaction_id) links logistics and document records
- [ ] Integration result logged with timestamp and status
- [ ] Failed integrations retried up to 3 times
- [ ] Integration respects FSP-003 correlation pattern
- [ ] CSS class naming follows `A-01700-*` convention

## Dependencies

- **Blocked by:** None
- **Depends on:** LOGISTICS-004, LOGISTICS-005, LOGISTICS-006
- **Blocks:** LOGISTICS-010, LOGISTICS-011, LOGISTICS-012

## Estimated Duration

60 minutes

## Risk Level

**High** — cross-discipline integration. Failure impacts document generation pipeline.

## QC Team Checks

- [ ] Integration chain matches INT-005 specification in integration registry
- [ ] Document types map correctly to transaction types
- [ ] Document numbering follows 00900 auto-sequence rules
- [ ] Correlation key is consistent across both systems
- [ ] Integration logging is queryable for audit purposes