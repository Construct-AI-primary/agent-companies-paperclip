---
id: SAFETY-009
title: "02400 Corrective Actions — CAPA Workflow & Tracking"
phase: "Phase 3 — Integration"
status: open
priority: high
platform: desktop
blocked_by: []
depends_on: [SAFETY-004, SAFETY-005, SAFETY-006]
parent_goal: SAFETY-INCIDENTS-2026
due_date: 2026-05-20
---

# SAFETY-009: 02400 Corrective Actions — CAPA Workflow & Tracking

## Executive Summary

Implement the Corrective and Preventive Actions (CAPA) workflow for safety incidents, enabling safety managers to define, assign, track, and verify corrective actions resulting from incident investigations.

## Problem Statement / Scope

After an incident is investigated, corrective actions must be defined and tracked to closure. Without a structured CAPA workflow, actions may be missed, delayed, or inadequately verified. Scope includes:

- CAPA creation: action description, assigned owner, due date, priority, category
- CAPA assignment and notification to responsible parties
- CAPA status tracking: Open → In Progress → Completed → Verified → Closed
- CAPA verification workflow: reviewer confirms action effectiveness before closure
- CAPA dashboard showing overdue, at-risk, and completed actions
- Integration with incident detail view (Corrective Actions tab)
- CAPA history and audit trail

## Required Actions

| # | Action | Detail |
|---|--------|--------|
| 1 | Design CAPA data model | Action ID, description, owner, due date, priority, category, status, verification notes |
| 2 | Build CAPA creation form | Modal with action fields, owner assignment, due date picker, priority selector |
| 3 | Implement CAPA status workflow | Open → In Progress → Completed → Verified → Closed with transition rules |
| 4 | Build CAPA dashboard | List view with status filters, overdue highlighting, completion % |
| 5 | Implement verification workflow | Reviewer marks action as verified or requests revision |
| 6 | Add notifications | Owner notified on assignment, due date reminders, verification requests |
| 7 | Wire to incident detail | Corrective Actions tab shows CAPA list for the incident |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Supporting:** devforge-ai-workflow-developer, guardian-qualityforge

## Required Skills

- Workflow engine implementation
- State machine design (CAPA status transitions)
- Notification system integration
- Dashboard and list view implementation
- Deadline management and overdue alerts

## Acceptance Criteria

- [ ] CAPA can be created with all required fields
- [ ] CAPA status transitions follow defined workflow rules
- [ ] Assigned owner receives notification on creation
- [ ] Due date reminders trigger at configurable intervals
- [ ] Verification workflow requires reviewer approval before closure
- [ ] CAPA dashboard shows overdue items highlighted in red
- [ ] Corrective Actions tab on incident detail shows linked CAPAs
- [ ] CAPA history is immutable and audit-trailed

## Dependencies

- BLOCKED BY: SAFETY-004, SAFETY-005, SAFETY-006
- BLOCKS: SAFETY-010, SAFETY-011, SAFETY-012

## Estimated Duration

- **Estimated Hours:** 28 hours
- **Complexity:** High
- **Timeline:** 3.5 business days

## Risk Level

**Medium** — Incomplete corrective actions could lead to recurring incidents; tracking mitigates this risk.

## QC Team Checks

- [ ] CAPA status transitions are enforced (no invalid transitions)
- [ ] Overdue highlighting triggers correctly based on due date
- [ ] Verification workflow prevents self-verification
- [ ] Notification delivery is reliable
- [ ] CAPA history is append-only and timestamped
- [ ] Dashboard filters work correctly across statuses
