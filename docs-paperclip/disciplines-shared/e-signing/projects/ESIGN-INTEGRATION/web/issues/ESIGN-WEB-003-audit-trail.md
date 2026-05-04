---
id: ESIGN-WEB-003
title: e-Signature Web — Audit Trail Viewer & Compliance Reports
description: Implement web-based audit trail viewer, compliance report generation (eIDAS, ESIGN Act), and signature certificate download
labels: ["e-signing", "esign", "web", "audit", "compliance"]
blocked_by: ["ESIGN-WEB-002"]
depends_on: ["ESIGN-WEB-002"]
para_section: e-signing/projects/ESIGN-INTEGRATION/web/issues
phase: "5 — Compliance & Audit"
status: todo
priority: Medium
story_points: 3
due_date: "2026-10-15"
assignee: domainforge-ai
company: domainforge-ai
delegation:
  parent_goal_id: "ESIGN-INTEGRATION-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement HITL e-Signature integration across all disciplines"
  agent_goal: "As domainforge-ai, implement web-based audit trail viewer and compliance reports"
  task_goal: "Deliver working audit trail viewer with compliance report generation"
---

# ESIGN-WEB-003: e-Signature Web — Audit Trail Viewer & Compliance Reports

## Executive Summary

This issue implements the web-based audit trail viewer and compliance report generation. It covers the timeline view of all signature events, filters and search, export capabilities (PDF, CSV, JSON), compliance report generation for eIDAS and ESIGN Act, and signature certificate download.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1A | Implement audit trail timeline view | Chronological view of all signature events with icons |
| 2A | Implement audit trail filters | Filter by date range, signer, event type, discipline |
| 3A | Implement audit trail export | Export as PDF, CSV, JSON |
| 4A | Implement eIDAS compliance report | Generate eIDAS-compliant report with all required fields |
| 5A | Implement ESIGN Act compliance report | Generate ESIGN Act-compliant report with consent records |
| 6A | Implement signature certificate download | Download signature completion certificate with cryptographic proof |

## Acceptance Criteria

- [ ] Audit trail shows timeline with all signature events
- [ ] Filters work for date range, signer, event type, discipline
- [ ] Export produces valid PDF, CSV, and JSON files
- [ ] eIDAS report includes signer identity, timestamp, signature method, consent
- [ ] ESIGN Act report includes electronic consent record and audit trail
- [ ] Signature certificate includes cryptographic hash and timestamp
- [ ] All components use `.ESIGN-*` CSS class prefix

## Dependencies

- **Blocked by:** ESIGN-WEB-002 (workflow admin must be implemented)
- **Depends on:** ESIGN-WEB-002
- **Blocks:** None

## Estimated Duration

2 weeks