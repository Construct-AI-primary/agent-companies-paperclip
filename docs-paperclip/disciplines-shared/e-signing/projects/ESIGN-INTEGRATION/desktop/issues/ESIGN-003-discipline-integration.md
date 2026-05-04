---
id: ESIGN-003
title: e-Signature Discipline Integration — Governance, Document Control & Procurement
description: Integrate e-Signature with 01300 Governance approval routing, 00900 Document Control lifecycle, and 01900 Procurement PO/tender workflows
labels: ["e-signing", "esign", "3 — Discipline Integration"]
blocked_by: ["ESIGN-002"]
depends_on: ["ESIGN-002"]
para_section: e-signing/projects/ESIGN-INTEGRATION/desktop/issues
phase: "3 — Discipline Integration"
status: todo
priority: High
story_points: 8
due_date: "2026-08-31"
assignee: integrateforge-ai
company: integrateforge-ai
delegation:
  parent_goal_id: "ESIGN-INTEGRATION-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: ["devforge-ai", "domainforge-ai"]
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement HITL e-Signature integration across all disciplines"
  agent_goal: "As integrateforge-ai, integrate e-Signature with Governance, Document Control, and Procurement workflows"
  task_goal: "Deliver working e-Signature integration in 01300, 00900, and 01900 discipline pages"
---

# ESIGN-003: e-Signature Discipline Integration — Governance, Document Control & Procurement

## Executive Summary

This issue integrates the e-Signature service with discipline-specific approval workflows. The signature capture components and workflow engine from ESIGN-002 are embedded into 01300 Governance approval routing, 00900 Document Control lifecycle management, and 01900 Procurement PO/tender workflows.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1A | Integrate with 01300 Governance approval matrix | Signature request created when approval gate reached; audit trail recorded on completion |
| 2A | Integrate with 00900 Document Control lifecycle | Signature fields embedded in document templates; document version locked on signing complete |
| 3A | Integrate with 01900 Procurement PO workflow | Signature capture in PO approval modal; PO issued on signing complete |
| 4A | Integrate with 01900 Procurement tender workflow | Signature capture in tender award modal; contract awarded on signing complete |
| 5A | Add signature status badges to discipline dashboards | Pending/completed/expired badges visible in approval queue views |

## Acceptance Criteria

- [ ] 01300 Governance approval gates trigger e-Signature requests
- [ ] 00900 Document Control embeds signature fields in document templates
- [ ] 00900 Document Control locks document version on signing complete
- [ ] 01900 Procurement PO modal includes signature capture
- [ ] 01900 Procurement tender award modal includes signature capture
- [ ] Signature status badges render in all discipline dashboards
- [ ] Audit trail events recorded in 01300 Governance on signing complete

## Dependencies

- **Blocked by:** ESIGN-002 (core components must be implemented first)
- **Depends on:** ESIGN-002
- **Blocks:** ESIGN-004, ESIGN-005

## Estimated Duration

4 weeks