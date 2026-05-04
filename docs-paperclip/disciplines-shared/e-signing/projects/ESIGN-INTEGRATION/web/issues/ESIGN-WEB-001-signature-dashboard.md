---
id: ESIGN-WEB-001
title: e-Signature Web — Signature Dashboard & Request Management
description: Implement web-based signature request dashboard, request creation interface, and signature request management for desktop browsers
labels: ["e-signing", "esign", "web", "dashboard"]
blocked_by: ["ESIGN-002"]
depends_on: ["ESIGN-002"]
para_section: e-signing/projects/ESIGN-INTEGRATION/web/issues
phase: "2 — Core Integration"
status: todo
priority: High
story_points: 5
due_date: "2026-07-15"
assignee: devforge-ai
company: devforge-ai
delegation:
  parent_goal_id: "ESIGN-INTEGRATION-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement HITL e-Signature integration across all disciplines"
  agent_goal: "As devforge-ai, implement web-based signature dashboard and request management"
  task_goal: "Deliver working web signature dashboard with request creation and management"
---

# ESIGN-WEB-001: e-Signature Web — Signature Dashboard & Request Management

## Executive Summary

This issue implements the web-based signature request dashboard and request management interface. It covers the main signature dashboard showing all pending/completed/expired requests, the request creation form for sending documents for signature, and request management actions (remind, cancel, resend).

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1A | Implement signature request dashboard | Table view of all requests with filters, sort, search |
| 2A | Implement request creation form | Form to select document, assign signers, configure workflow |
| 3A | Implement request detail view | Detailed view of request with signer status, timeline, actions |
| 4A | Implement request management actions | Remind, cancel, resend, delegate actions |
| 5A | Implement signature status badges | Visual indicators for pending, viewed, signed, declined, expired |
| 6A | Implement email notification preferences | User settings for signature notification preferences |

## Acceptance Criteria

- [ ] Dashboard shows all requests with status badges
- [ ] Filters work for status, date range, discipline
- [ ] Request creation form selects document and assigns signers
- [ ] Request detail view shows signer status and timeline
- [ ] Remind, cancel, resend actions work correctly
- [ ] Status badges render with correct colors and icons
- [ ] All components use `.ESIGN-*` CSS class prefix

## Dependencies

- **Blocked by:** ESIGN-002 (core components must be implemented)
- **Depends on:** ESIGN-002
- **Blocks:** ESIGN-WEB-002, ESIGN-WEB-003

## Estimated Duration

3 weeks