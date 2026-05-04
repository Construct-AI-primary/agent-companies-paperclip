---
id: ELECTRICAL-003
title: "00860 Inspection Detail View — Header & Tabs"
description: "Implement the inspection detail view with header information and tabbed content sections for inspection results, measurements, equipment, and compliance."
labels: ["electrical", "00860", "1 — Foundation"]
blocked_by: []
depends_on: ["ELECTRICAL-001", "ELECTRICAL-002"]
para_section: electrical-engineering/projects/ELECTRICAL-INSPECTIONS/desktop/issues
phase: "1 — Foundation"
status: todo
priority: High
story_points: 3
due_date: "2026-05-20"
assignee: "domainforge-ai"
company: "domainforge-ai"
delegation:
  parent_goal_id: "ELECTRICAL-INSPECTIONS-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement 00860 electrical inspection management"
  agent_goal: "As domainforge-ai, implement the inspection detail view with header and tabs"
  task_goal: "Execute inspection detail view implementation with 100% pass rate"
---

# ELECTRICAL-003: 00860 Inspection Detail View — Header & Tabs

## Executive Summary

Build the inspection detail view accessible from the inspection list. The view includes a header with key metadata and a tabbed interface for Results, Measurements, Equipment, and Compliance sections. This is the central workspace for reviewing and managing individual inspections.

## Problem Statement / Scope

Inspectors need a detailed view of each inspection with organized sections for different aspects of the inspection data. The current lack of a detail view forces users to navigate between multiple screens. The scope covers the header display and tabbed content switching.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Inspection Header | Display inspection ID, title, location, status badge, inspector, and date |
| 2 | Tab Navigation | Build tab bar with Results, Measurements, Equipment, Compliance tabs |
| 3 | Tab Content Shell | Create placeholder content areas for each tab |
| 4 | Back Navigation | Implement back button to return to inspection list |
| 5 | Loading State | Show skeleton loader during inspection data fetch |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- React component composition
- Tab navigation UI pattern
- URL-based tab routing
- Responsive layout design

## Acceptance Criteria

- [ ] Inspection header displays all required metadata fields
- [ ] Status badge color matches inspection status (Passed=green, Failed=red, etc.)
- [ ] Tab bar renders with Results, Measurements, Equipment, Compliance tabs
- [ ] Clicking a tab switches the content area without page reload
- [ ] Active tab is visually highlighted
- [ ] Back button returns to the inspection list with preserved filters
- [ ] Loading skeleton displays during data fetch
- [ ] Error state displays with retry button on fetch failure
- [ ] URL reflects the active tab for direct linking

## Dependencies

- API endpoint `GET /api/v1/inspections/:id` for inspection detail
- Inspection data model with all section fields
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
