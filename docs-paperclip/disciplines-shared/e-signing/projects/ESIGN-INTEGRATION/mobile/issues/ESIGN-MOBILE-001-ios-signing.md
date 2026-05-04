---
id: ESIGN-MOBILE-001
title: e-Signature iOS — Native Signature Capture, Biometric Auth & Push Notifications
description: Implement and test native iOS e-Signature experience including touch-optimized signature canvas, Face ID authentication, and push notifications
labels: ["e-signing", "esign", "mobile", "ios"]
blocked_by: ["ESIGN-002"]
depends_on: ["ESIGN-002"]
para_section: e-signing/projects/ESIGN-INTEGRATION/mobile/issues
phase: "4 — Mobile & Offline"
status: todo
priority: High
story_points: 5
due_date: "2026-09-15"
assignee: devforge-ai
company: devforge-ai
delegation:
  parent_goal_id: "ESIGN-INTEGRATION-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement HITL e-Signature integration across all disciplines"
  agent_goal: "As devforge-ai, implement native iOS e-Signature experience"
  task_goal: "Deliver working iOS signature capture with Face ID auth and push notifications"
---

# ESIGN-MOBILE-001: e-Signature iOS — Native Signature Capture, Biometric Auth & Push Notifications

## Executive Summary

This issue implements the native iOS e-Signature experience. It covers touch-optimized signature canvas with Apple Pencil support, Face ID / Touch ID biometric authentication before signing, push notifications for signature requests, and deep linking from notifications directly to the signature request.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1A | Implement iOS touch signature canvas | Signature canvas works with finger and Apple Pencil, pressure sensitivity, palm rejection |
| 2A | Implement Face ID / Touch ID authentication | Biometric authentication required before signing; fallback to passcode |
| 3A | Implement iOS push notifications | Push notification received on new request, reminder, completion |
| 4A | Implement deep linking | Push notification opens directly to signature request in app |
| 5A | Implement iOS signature dashboard | Native list view of signature requests with swipe actions |
| 6A | Implement offline download-and-upload | Document downloaded as PDF, signed offline, uploaded with signature |

## Acceptance Criteria

- [ ] Signature canvas works with finger and Apple Pencil
- [ ] Face ID / Touch ID authenticates before signing
- [ ] Push notifications received for request, reminder, completion
- [ ] Deep linking opens correct signature request
- [ ] Signature dashboard renders correctly on all iOS screen sizes
- [ ] Offline download produces valid PDF
- [ ] Offline upload validates signature and resumes workflow
- [ ] All components use `.ESIGN-*` CSS class prefix

## Dependencies

- **Blocked by:** ESIGN-002 (core components must be implemented)
- **Depends on:** ESIGN-002
- **Blocks:** ESIGN-MOBILE-003

## Estimated Duration

3 weeks