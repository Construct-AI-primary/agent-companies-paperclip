---
id: ESIGN-002
title: e-Signature Core Integration — Signature Capture, Workflow Engine & API
description: Implement signature capture UI components, signature workflow engine, REST API endpoints, and webhook handling
labels: ["e-signing", "esign", "2 — Core Integration"]
blocked_by: ["ESIGN-001"]
depends_on: ["ESIGN-001"]
para_section: e-signing/projects/ESIGN-INTEGRATION/desktop/issues
phase: "2 — Core Integration"
status: todo
priority: High
story_points: 13
due_date: "2026-07-31"
assignee: devforge-ai
company: devforge-ai
delegation:
  parent_goal_id: "ESIGN-INTEGRATION-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: ["infraforge-ai"]
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement HITL e-Signature integration across all disciplines"
  agent_goal: "As devforge-ai, implement signature capture components, workflow engine, and API endpoints"
  task_goal: "Deliver working signature capture UI, workflow engine, and REST API with webhook handling"
---

# ESIGN-002: e-Signature Core Integration — Signature Capture, Workflow Engine & API

## Executive Summary

This issue implements the core e-Signature integration components: signature capture UI (draw, type, upload, PKI), signature workflow engine (sequential, parallel, hybrid), REST API endpoints, and webhook handling for provider events.

## Problem Statement / Scope

With the foundation design from ESIGN-001 complete, we must now implement the core components. This covers the signature capture UI components, the workflow engine that manages signing order, the REST API that discipline pages will call, and the webhook handler that receives events from the e-Signature provider.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1A | Implement SignatureCanvas component | Draw signature with mouse/touch, clear, undo, stroke customization |
| 2A | Implement SignatureType component | Type signature rendered in cursive font, font size/color options |
| 3A | Implement SignatureUpload component | Upload image, crop, resize, validate file type/size |
| 4A | Implement SignaturePKI component | Certificate selection, PIN entry, cryptographic signing |
| 5A | Implement SignatureModal | Tabbed interface for all 4 methods, document preview, additional fields |
| 6A | Implement workflow engine | Sequential, parallel, and hybrid signing order management |
| 7A | Implement REST API endpoints | All 10 endpoints from the UI/UX spec |
| 8A | Implement webhook handler | Receive and process provider events, update request status |
| 9A | Implement email notification system | Send signature requests, reminders, and completion notifications |

## Acceptance Criteria

- [ ] SignatureCanvas works on desktop (mouse) and mobile (touch)
- [ ] SignatureType renders cursive font correctly
- [ ] SignatureUpload accepts PNG, JPG, SVG; validates file size < 5MB
- [ ] SignaturePKI supports X.509 certificate selection
- [ ] SignatureModal renders all 4 methods with tab switching
- [ ] Workflow engine processes sequential, parallel, and hybrid orders
- [ ] All 10 API endpoints return correct responses
- [ ] Webhook handler processes provider events and updates status
- [ ] Email notifications are sent on request, completion, and expiry
- [ ] All components use `.ESIGN-*` CSS class prefix

## Dependencies

- **Blocked by:** ESIGN-001 (provider evaluation, architecture design)
- **Depends on:** ESIGN-001
- **Blocks:** ESIGN-003, ESIGN-004, ESIGN-005

## Estimated Duration

6 weeks
</write_to_file>