---
id: SAFETY-005
title: "02400 Upsert State — Incident Report Creation Form"
phase: "Phase 2 — State/Modals"
status: open
priority: high
platform: desktop
blocked_by: []
depends_on: [SAFETY-001, SAFETY-002, SAFETY-003]
parent_goal: SAFETY-INCIDENTS-2026
due_date: 2026-05-20
---

# SAFETY-005: 02400 Upsert State — Incident Report Creation Form

## Executive Summary

Implement the Upsert state for the 02400 Safety discipline, providing the incident report creation form and supporting data entry workflows. This state enables safety managers and site supervisors to report new incidents with structured data capture.

## Problem Statement / Scope

Incident reporting must be fast, structured, and consistent to ensure regulatory compliance and accurate data for analysis. Without a dedicated Upsert state, users lack a standardized form for incident entry. Scope includes:

- ReportIncident modal (98vw, red gradient header): incident type, severity, location, description, date/time, involved parties, photo uploads
- Form validation per 0750 standard (green/gray/red borders)
- EditRecord modal for editing existing incidents with change tracking
- Delete confirmation modal with regulatory record retention warning
- Import modal for bulk importing safety documents (PDF safety plans, training certs)
- Loading/empty/error states per UI-UX spec

## Required Actions

| # | Action | Detail |
|---|--------|--------|
| 1 | Build Upsert state view | Tab bar with Report Incident, Import, and list of recent drafts |
| 2 | Implement ReportIncident modal | 98vw modal: incident type dropdown, severity selector (RAG), location autocomplete, date/time picker, rich text description, involved parties multi-select, photo upload with preview |
| 3 | Add form validation | Green border (valid), gray border (empty/required), red border (error) with red error text |
| 4 | Implement EditRecord modal | Pre-populated form with change tracking diff display |
| 5 | Implement Delete confirmation | Warning about regulatory record retention requirements before deletion |
| 6 | Implement Import modal | File upload (PDF, images), drag-and-drop zone, file type validation |
| 7 | Wire to API | POST /api/companies/:companyId/safety/incidents, PUT, DELETE, POST /import |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Supporting:** devforge-ai-workflow-developer, guardian-qualityforge

## Required Skills

- Complex form implementation with validation
- File upload with drag-and-drop
- Photo preview and thumbnail generation
- Modal implementation (98vw, red gradient header)
- Change tracking / diff display

## Acceptance Criteria

- [ ] ReportIncident modal opens with all specified form fields
- [ ] Form validation shows correct border colors per 0750 standard
- [ ] Photo upload supports drag-and-drop with preview thumbnails
- [ ] EditRecord modal pre-populates with existing data and shows changes
- [ ] Delete confirmation warns about regulatory retention requirements
- [ ] Import modal accepts PDF and image files with type validation
- [ ] Form submission creates incident via API and redirects to detail view
- [ ] Loading state shows spinner during submission
- [ ] Error state shows field-level validation errors

## Dependencies

- BLOCKED BY: SAFETY-001, SAFETY-002, SAFETY-003
- BLOCKS: SAFETY-006, SAFETY-007

## Estimated Duration

- **Estimated Hours:** 28 hours
- **Complexity:** High
- **Timeline:** 3.5 business days

## Risk Level

**Medium** — Data entry errors could lead to incomplete incident records; validation mitigates this risk.

## QC Team Checks

- [ ] All form fields validate correctly (green/gray/red borders)
- [ ] Photo upload handles files > 10MB with appropriate error message
- [ ] Delete action shows confirmation with regulatory warning
- [ ] Import modal validates file types before upload
- [ ] Form state persists on accidental navigation (unsaved changes warning)
- [ ] API error responses display user-friendly messages
