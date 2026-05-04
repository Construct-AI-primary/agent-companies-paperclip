---
id: ESIGN-WEB-002
title: e-Signature Web — Workflow Configuration & Admin Interface
description: Implement web-based signature workflow configuration, approval matrix integration, and admin management interface
labels: ["e-signing", "esign", "web", "admin", "workflow"]
blocked_by: ["ESIGN-WEB-001"]
depends_on: ["ESIGN-WEB-001"]
para_section: e-signing/projects/ESIGN-INTEGRATION/web/issues
phase: "2 — Core Integration"
status: todo
priority: High
story_points: 5
due_date: "2026-07-31"
assignee: devforge-ai
company: devforge-ai
delegation:
  parent_goal_id: "ESIGN-INTEGRATION-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement HITL e-Signature integration across all disciplines"
  agent_goal: "As devforge-ai, implement web-based workflow configuration and admin interface"
  task_goal: "Deliver working workflow configuration and admin management interface"
---

# ESIGN-WEB-002: e-Signature Web — Workflow Configuration & Admin Interface

## Executive Summary

This issue implements the web-based signature workflow configuration and admin management interface. It covers the workflow configuration form for setting signing order per discipline/approval level, signer management, template configuration, and provider settings.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1A | Implement workflow configuration form | Form to configure sequential/parallel/hybrid signing order |
| 2A | Implement signer management | Add/remove signers, set signing order, assign groups |
| 3A | Implement template configuration | Configure signature field placement in document templates |
| 4A | Implement provider settings | Configure e-Signature provider API keys, webhook URLs |
| 5A | Implement approval matrix integration | Link workflow config to 01300 Governance approval matrix levels |
| 6A | Implement test workflow button | Send test signature request to verify configuration |

## Acceptance Criteria

- [ ] Workflow configuration form saves sequential/parallel/hybrid order
- [ ] Signer management adds/removes signers with order and groups
- [ ] Template configuration embeds signature fields in document templates
- [ ] Provider settings save API keys and webhook URLs
- [ ] Approval matrix integration links to 01300 Governance levels
- [ ] Test workflow sends test signature request successfully
- [ ] All components use `.ESIGN-*` CSS class prefix

## Dependencies

- **Blocked by:** ESIGN-WEB-001 (dashboard must be implemented first)
- **Depends on:** ESIGN-WEB-001
- **Blocks:** ESIGN-WEB-003

## Estimated Duration

3 weeks