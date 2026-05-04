---
id: SAFETY-002
title: "02400 Incident List — Basic Rendering & Filters"
phase: "Phase 1 — Foundation"
status: open
priority: critical
platform: desktop
blocked_by: []
depends_on: [SAFETY-001]
parent_goal: SAFETY-INCIDENTS-2026
due_date: 2026-05-20
---

# SAFETY-002: 02400 Incident List — Basic Rendering & Filters

## Executive Summary

Build the primary incident list view for the 02400 Safety discipline, displaying all reported safety incidents in a sortable, filterable data grid. This is the main data browsing surface for safety managers and site supervisors.

## Problem Statement / Scope

Safety managers need a comprehensive, real-time view of all incidents across their operations. The current lack of a centralized incident list forces users to navigate through disparate records. This issue delivers:

- Incident data grid with columns: ID, Title, Contractor, Severity (RAG), Status, Date Reported, Assigned Investigator
- Filter bar: severity (High/Med/Low), status (Open/Investigating/Closed), date range, contractor name
- Sortable columns (ascending/descending)
- Pagination (20 items per page, page navigation)
- Loading skeleton state while data fetches
- Empty state with CTA to report first incident
- Error state with red banner and retry button

## Required Actions

| # | Action | Detail |
|---|--------|--------|
| 1 | Build IncidentTable component | Data grid with sortable columns, severity RAG badges, status badges |
| 2 | Implement filter bar | Severity dropdown, status dropdown, date range picker, contractor autocomplete |
| 3 | Add pagination | Server-side pagination with page size selector (10/20/50) |
| 4 | Create loading skeleton | Shimmer placeholder rows while API call is in-flight |
| 5 | Create empty state | Illustration + "Report First Incident" CTA button |
| 6 | Create error state | Red banner with error message + Retry button |
| 7 | Wire to API endpoint | GET /api/companies/:companyId/safety/incidents with query params for filters/pagination |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Supporting:** devforge-ai-workflow-developer, infraforge-ai-integration-specialist

## Required Skills

- React data grid implementation
- API integration with query parameters
- CSS RAG status badge styling
- Pagination logic (offset/limit)
- Loading/empty/error state management

## Acceptance Criteria

- [ ] Incident table renders with all specified columns
- [ ] Severity column shows RAG badges (🔴 High / 🟡 Med / 🟢 Low)
- [ ] Status column shows appropriate status badges
- [ ] Filter bar filters incidents by severity, status, date range, and contractor
- [ ] Columns are sortable by clicking column headers
- [ ] Pagination controls appear at bottom of table
- [ ] Loading skeleton displays while data is fetching
- [ ] Empty state displays when no incidents match filters
- [ ] Error state displays red banner with retry on API failure
- [ ] All text uses safety red/amber/green palette per UI-UX spec

## Dependencies

- BLOCKED BY: SAFETY-001 (page foundation)
- BLOCKS: SAFETY-003, SAFETY-004

## Estimated Duration

- **Estimated Hours:** 20 hours
- **Complexity:** Medium
- **Timeline:** 2.5 business days

## Risk Level

**Low** — Data display only; no mutations involved.

## QC Team Checks

- [ ] Filters clear and reset correctly
- [ ] Pagination maintains filter state across pages
- [ ] Sort indicators show active sort column and direction
- [ ] RAG badge colors match UI-UX spec exactly (#E53935, #FFB300, #43A047)
- [ ] Empty state CTA navigates to Upsert state
- [ ] Error retry re-fetches data successfully
