---
id: SAFETY-003
title: "02400 Incident Detail View — Header & Tabs"
phase: "Phase 1 — Foundation"
status: open
priority: critical
platform: desktop
blocked_by: []
depends_on: [SAFETY-001, SAFETY-002]
parent_goal: SAFETY-INCIDENTS-2026
due_date: 2026-05-20
---

# SAFETY-003: 02400 Incident Detail View — Header & Tabs

## Executive Summary

Build the incident detail view that opens when a user clicks on an incident row from the list. This view provides a comprehensive breakdown of a single incident, organized into tabbed sections for incident details, investigation findings, corrective actions, and audit history.

## Problem Statement / Scope

Safety managers need to drill into individual incidents to review full details, track investigation progress, and verify closure. Without a dedicated detail view, users cannot access the depth of information required for proper incident management. Scope includes:

- Incident header: ID, title, severity RAG badge, status badge, date reported
- Tab navigation: Details | Investigation | Corrective Actions | Audit Trail
- Details tab: full description, location, contractor, reporter, involved parties, photos
- Loading skeleton for detail view
- Error state with retry
- Back navigation to incident list

## Required Actions

| # | Action | Detail |
|---|--------|--------|
| 1 | Build IncidentDetail page component | Route: /safety/safetyincidents/:incidentId |
| 2 | Create incident header | ID, title, severity RAG badge, status badge, date, back button |
| 3 | Implement tab navigation | Details, Investigation, Corrective Actions, Audit Trail tabs |
| 4 | Build Details tab content | Description, location, contractor, reporter, involved parties, photo attachments |
| 5 | Add loading skeleton | Shimmer layout matching detail view structure |
| 6 | Add error state | Red banner with retry on fetch failure |
| 7 | Wire to API | GET /api/companies/:companyId/safety/incidents/:incidentId |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Supporting:** devforge-ai-workflow-developer, guardian-qualityforge

## Required Skills

- React tab component implementation
- Dynamic route handling (React Router)
- API data fetching with loading states
- CSS tab styling with safety theme
- Responsive detail layout

## Acceptance Criteria

- [ ] Clicking an incident row navigates to /safety/safetyincidents/:incidentId
- [ ] Incident header displays ID, title, severity RAG badge, status badge, and date
- [ ] Four tabs render: Details, Investigation, Corrective Actions, Audit Trail
- [ ] Details tab shows full incident information
- [ ] Back button returns to incident list preserving filter/pagination state
- [ ] Loading skeleton displays during data fetch
- [ ] Error state shows red banner with retry
- [ ] Tab state persists in URL query param for direct linking

## Dependencies

- BLOCKED BY: SAFETY-001, SAFETY-002
- BLOCKS: SAFETY-004, SAFETY-005, SAFETY-006

## Estimated Duration

- **Estimated Hours:** 18 hours
- **Complexity:** Medium
- **Timeline:** 2.5 business days

## Risk Level

**Low** — Read-only detail view; no data mutations.

## QC Team Checks

- [ ] Tab switching does not trigger full page reload
- [ ] Back button preserves list scroll position
- [ ] Photo attachments render correctly (thumbnails + lightbox)
- [ ] RAG badge colors match spec
- [ ] URL reflects active tab for bookmarking
