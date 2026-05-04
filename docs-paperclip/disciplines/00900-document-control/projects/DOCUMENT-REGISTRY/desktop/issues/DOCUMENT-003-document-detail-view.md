---
id: DOCUMENT-003
title: "00900 Document Detail View — Content, Versions, Approvals Tabs"
description: "Implement the document detail view with header information and tabbed content sections for document content, version history, and approval tracking."
labels: ["document-control", "00900", "1 — Foundation"]
blocked_by: []
depends_on: ["DOCUMENT-001", "DOCUMENT-002"]
para_section: document-control/projects/DOCUMENT-REGISTRY/desktop/issues
phase: "1 — Foundation"
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
  agent_goal: "As domainforge-ai, implement the document detail view with header and tabs"
  task_goal: "Execute document detail view implementation with 100% pass rate"
---

# DOCUMENT-003: 00900 Document Detail View — Content, Versions, Approvals Tabs

## Executive Summary

Build the document detail view accessible from the document registry. The view includes a header with key metadata and a tabbed interface for Content, Versions, Approvals, and Governance sections. This is the central workspace for reviewing and managing individual documents.

## Problem Statement / Scope

Document controllers need a detailed view of each document with organized sections for content viewing, version history, approval status, and governance information. The scope covers the header display and tabbed content switching.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Document Header | Display document ID, title, type, status badge, version, and date |
| 2 | Tab Navigation | Build tab bar with Content, Versions, Approvals, Governance tabs |
| 3 | Tab Content Shell | Create placeholder content areas for each tab |
| 4 | Back Navigation | Implement back button to return to document registry |
| 5 | Loading State | Show skeleton loader during document data fetch |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- React component composition
- Tab navigation UI pattern
- URL-based tab routing
- Responsive layout design

## Acceptance Criteria

- [ ] Document header displays all required metadata fields
- [ ] Status badge color matches document status (Draft=gray, Approved=green, etc.)
- [ ] Tab bar renders with Content, Versions, Approvals, Governance tabs
- [ ] Clicking a tab switches the content area without page reload
- [ ] Active tab is visually highlighted
- [ ] Back button returns to the document registry with preserved filters
- [ ] Loading skeleton displays during data fetch
- [ ] Error state displays with retry button on fetch failure
- [ ] URL reflects the active tab for direct linking

## Dependencies

- API endpoint `GET /api/v1/documents/:id` for document detail
- Document data model with all section fields
- UI component library for tabs, badges, and skeleton loaders

## Estimated Duration

- **Development**: 2 days
- **Testing**: 1 day
- **Total**: 3 days

## Risk Level

**Low** — Standard detail view pattern with tabbed navigation.

## QC Team Checks

- [ ] All header fields render with correct data
- [ ] Tab switching works correctly for all tabs
- [ ] Back navigation preserves list state (filters, page)
- [ ] Loading skeleton renders during data fetch
- [ ] Error state displays and retry works
- [ ] URL updates correctly on tab change
- [ ] Responsive layout adapts to mobile viewports
