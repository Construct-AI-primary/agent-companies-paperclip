---
id: DOCUMENT-005
title: "00900 Upsert State — Document Creation & Upload Forms"
description: "Implement the Upsert state for creating and uploading documents with form fields for metadata, content, and file attachments."
labels: ["document-control", "00900", "2 — State/Modals"]
blocked_by: []
depends_on: ["DOCUMENT-001", "DOCUMENT-002", "DOCUMENT-003"]
para_section: document-control/projects/DOCUMENT-REGISTRY/desktop/issues
phase: "2 — State/Modals"
status: todo
priority: High
story_points: 3
due_date: "2026-05-20"
assignee: "domainforge-ai"
company: "domainforge-ai"
delegation:
  parent_goal_id: "DOCUMENT-REGISTRY-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement 00900 document control management"
  agent_goal: "As domainforge-ai, implement the Upsert state for document creation and upload"
  task_goal: "Execute Upsert state implementation with 100% pass rate"
---

# DOCUMENT-005: 00900 Upsert State — Document Creation & Upload Forms

## Executive Summary

Implement the Upsert state providing forms for creating new documents and uploading existing documents. The forms include metadata fields, content editor, file upload, and document numbering integration.

## Problem Statement / Scope

Document controllers need a standardized interface for creating and uploading documents with consistent metadata capture. Without a structured form, document quality and discoverability suffer. The scope covers document creation, file upload, and metadata management.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Document Metadata Form | Fields for title, type, discipline, author, and description |
| 2 | Content Editor | Rich text editor for creating document content inline |
| 3 | File Upload | Drag-and-drop file upload with preview for supported formats |
| 4 | Document Numbering | Auto-assignment of document number with manual override option |
| 5 | Form Validation & Submit | Client-side validation with API submission and success/error handling |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- React form handling (Formik, React Hook Form)
- Rich text editor integration
- File upload handling with drag-and-drop
- Form validation library (Yup, Zod)

## Acceptance Criteria

- [ ] Metadata form captures all required document fields
- [ ] Rich text editor supports formatting, images, and tables
- [ ] File upload supports PDF, DOCX, and image formats with preview
- [ ] Document number is auto-assigned with manual override option
- [ ] Form validation prevents submission with missing required fields
- [ ] Edit mode pre-populates form with existing document data
- [ ] Successful submission redirects to document detail view
- [ ] Error state displays API errors with field-level messaging
- [ ] Unsaved changes prompt warning on navigation away

## Dependencies

- API endpoints `POST /api/v1/documents` and `PUT /api/v1/documents/:id`
- Document data model with all form fields
- File upload API endpoint
- Document numbering service

## Estimated Duration

- **Development**: 3 days
- **Testing**: 1 day
- **Total**: 4 days

## Risk Level

**Medium** — Complex form with rich text editor and file uploads.

## QC Team Checks

- [ ] All form fields render and accept input correctly
- [ ] Rich text editor supports all required formatting
- [ ] File upload works for all supported formats with preview
- [ ] Document numbering assigns correct sequence numbers
- [ ] Form validation catches all required field omissions
- [ ] Edit mode loads existing data correctly
- [ ] Submit sends correct payload to API
