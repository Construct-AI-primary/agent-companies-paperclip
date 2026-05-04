---
id: SAFETY-006
title: "02400 Workspace State — Safety Dashboard & Compliance View"
phase: "Phase 2 — State/Modals"
status: open
priority: high
platform: desktop
blocked_by: []
depends_on: [SAFETY-001, SAFETY-002, SAFETY-003]
parent_goal: SAFETY-INCIDENTS-2026
due_date: 2026-05-20
---

# SAFETY-006: 02400 Workspace State — Safety Dashboard & Compliance View

## Executive Summary

Implement the Workspace state for the 02400 Safety discipline, providing the safety operations dashboard with KPI widgets, compliance monitoring, and HITL review queue. This is the primary command center for safety managers.

## Problem Statement / Scope

Safety managers need a centralized dashboard showing real-time safety metrics, compliance status, and pending review items. Without a Workspace state, users must navigate between multiple views to get an operational picture. Scope includes:

- KPI widgets: Open Incidents (🔴), Days Since LTI (🟢), Compliance % (🟡), Training Up-to-Date % (🔵)
- HITL Review Queue: incidents pending manager review with Approve/Escalate/Reject actions
- Compliance Dashboard: RAG status overview, compliance by category chart
- Approval modal (98vw): confirm incident close with corrective actions documented
- Escalate modal (98vw): escalation reason, higher authority selection
- Rejection modal (98vw): required corrective action notes
- Assign Investigator modal (98vw): investigator selector, investigation scope
- Export modal (98vw): report type selection (incident summary, compliance status)
- Loading/empty/error states per UI-UX spec

## Required Actions

| # | Action | Detail |
|---|--------|--------|
| 1 | Build Workspace state view | Dashboard layout with KPI row, HITL queue, compliance section |
| 2 | Implement KPI widgets | Open Incidents count, Days Since LTI, Compliance %, Training % with RAG indicators |
| 3 | Build HITL Review Queue | List of incidents pending review with Approve/Escalate/Reject buttons |
| 4 | Implement Approval modal | 98vw modal: confirm close, corrective actions summary, manager signature |
| 5 | Implement Escalate modal | 98vw modal: escalation reason, higher authority dropdown, priority override |
| 6 | Implement Rejection modal | 98vw modal: required corrective action notes, return to AI agent feedback |
| 7 | Implement Assign Investigator modal | 98vw modal: investigator search/select, investigation scope, deadline |
| 8 | Implement Export modal | 98vw modal: report type, date range, format (PDF/CSV) |
| 9 | Wire to API | GET /api/companies/:companyId/safety/dashboard, POST /approve, POST /escalate, POST /reject |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Supporting:** devforge-ai-workflow-developer, guardian-qualityforge

## Required Skills

- Dashboard KPI widget implementation
- Chart library integration (compliance charts)
- HITL workflow implementation
- Modal implementation (98vw, red gradient header)
- Real-time data polling or WebSocket updates

## Acceptance Criteria

- [ ] KPI widgets display with correct RAG status colors
- [ ] HITL Review Queue shows pending incidents with action buttons
- [ ] Approval modal confirms close with corrective actions documented
- [ ] Escalate modal allows reason and authority selection
- [ ] Rejection modal requires corrective action notes before submission
- [ ] Assign Investigator modal allows search and selection
- [ ] Export modal generates report in selected format
- [ ] Loading skeleton displays during dashboard data fetch
- [ ] Empty state shows "No items to review" for HITL queue
- [ ] Error state shows red banner with retry

## Dependencies

- BLOCKED BY: SAFETY-001, SAFETY-002, SAFETY-003
- BLOCKS: SAFETY-007, SAFETY-008, SAFETY-009

## Estimated Duration

- **Estimated Hours:** 30 hours
- **Complexity:** High
- **Timeline:** 4 business days

## Risk Level

**Medium** — Dashboard data accuracy is critical for safety decision-making.

## QC Team Checks

- [ ] KPI values update in real-time or on refresh
- [ ] HITL queue actions update incident status correctly
- [ ] Escalation routes to correct higher authority
- [ ] Export generates valid PDF/CSV files
- [ ] Dashboard layout matches UI-UX spec wireframe
- [ ] All modals use 98vw width with red gradient header
