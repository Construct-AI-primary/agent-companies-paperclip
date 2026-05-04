---
id: CONTRACT-014
title: "00400 Approval Routing — Multi-Level Approval Matrix"
description: "Implement the multi-level approval routing system with value-based routing tiers (Manager, Director, Executive, Board), compliance flag escalation, and approval/rejection workflow."
labels: ["contracts", "00400", "5 — Compliance"]
blocked_by: []
depends_on: ["CONTRACT-010", "CONTRACT-011", "CONTRACT-012"]
para_section: contracts/projects/CONTRACT-LIFECYCLE/desktop/issues
phase: "5 — Compliance"
status: todo
priority: Medium
story_points: 3
due_date: "2026-05-15"
assignee: "domainforge-ai"
company: "domainforge-ai"
delegation:
  parent_goal_id: "CONTRACT-LIFECYCLE-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement 00400 contract lifecycle management"
  agent_goal: "As domainforge-ai, implement the multi-level approval routing matrix with value-based and compliance-based routing"
  task_goal: "Execute approval routing implementation with 100% pass rate"
---

# CONTRACT-014: 00400 Approval Routing — Multi-Level Approval Matrix

## Executive Summary

Implement the multi-level approval routing system that determines the appropriate approval chain based on contract or variation value. The matrix supports four value-based tiers (Manager < $50K, Director $50K-$500K, Executive $500K-$5M, Board > $5M) plus compliance flag escalation. Each level can approve, reject, or forward to the next level.

## Problem Statement / Scope

Contracts and variations require approval based on their financial value and risk profile. The approval matrix must route items to the correct approval level, support sequential approval chains (higher levels must approve before lower levels), and handle compliance flags that trigger additional review. The system must track approval status and provide visibility into the approval chain.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Route Determination | Calculate approval route based on contract/variation value and compliance flags |
| 2 | Approval Chain | Display sequential approval chain with current status per level |
| 3 | Level 1 — Manager | Manager approval for items < $50K |
| 4 | Level 2 — Director | Director approval for $50K-$500K; requires Level 1 approval first |
| 5 | Level 3 — Executive | Executive approval for $500K-$5M; requires Level 2 approval first |
| 6 | Level 4 — Board | Board approval for > $5M; requires Level 3 approval first |
| 7 | Compliance Escalation | Compliance flags trigger additional compliance review before standard routing |
| 8 | Approval Actions | Approve, reject with reason, or request revision at each level |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- Configurable routing engine
- Sequential approval chain management
- Role-based access control integration
- Notification system for approval requests

## Acceptance Criteria

- [ ] Route determination correctly calculates approval level based on value thresholds
- [ ] Approval chain displays all required levels with current status indicators
- [ ] Level 1 (Manager) can approve items < $50K directly
- [ ] Level 2 (Director) approval requires Level 1 approval first
- [ ] Level 3 (Executive) approval requires Level 2 approval first
- [ ] Level 4 (Board) approval requires Level 3 approval first
- [ ] Compliance flags trigger compliance review before standard routing
- [ ] Approve action advances to next level or final approval
- [ ] Reject action returns item with rejection reason
- [ ] Request revision action returns item to submitter with revision notes
- [ ] Notifications sent to relevant approvers at each stage
- [ ] Approval history is recorded in the audit trail

## Dependencies

- Approval matrix configuration (value thresholds, roles)
- Role-based access control system
- Notification service for approval requests
- Audit logging service

## Estimated Duration

- **Development**: 4 days
- **Testing**: 2 days
- **Total**: 6 days

## Risk Level

**Medium** — Approval routing must be configurable and auditable; incorrect routing has governance implications.

## QC Team Checks

- [ ] Route determination matches expected level for test values at each threshold
- [ ] Sequential chain enforcement works correctly (cannot skip levels)
- [ ] Compliance escalation triggers additional review step
- [ ] Approve/reject/request-revision actions work at each level
- [ ] Notifications are sent to correct approvers
- [ ] Approval history is complete and accurate
- [ ] Configuration changes to thresholds take effect without deployment
- [ ] Edge case: zero-value items route to lowest level
