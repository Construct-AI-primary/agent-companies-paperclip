---
id: PROCURE-005
title: 01900 Workspace State — All 7 Modals
description: Verify Workspace state button and all 7 associated modals (Timesheet, Access Permissions, Contact Scraper, Cross-Discipline Sharing, Manage Workspaces, Supplier Setup, Vector Data Manager)
labels: ["testing", "procurement", "2 — State Buttons & Modals"]
blocked_by: []
depends_on: ["PROCURE-001", "PROCURE-002"]
para_section: testing/projects/PROCURE-TEST/desktop/issues
phase: 2 — State Buttons & Modals
status: todo
priority: High
story_points: 8
due_date: "2026-05-02"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-PROCUREMENT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 01900 procurement page production readiness"
  agent_goal: "As validator-qualityforge, verify Workspace state button and all 7 associated modals (Timesheet, Access Permissions, Contact Scraper, Cross-Discipline Sharing, Manage Workspaces, Supplier Setup, Vector Data Manager)"
  task_goal: "Execute all 7 modal validations with >95% pass rate"
---

# PROCURE-005: 01900 Workspace State — All 7 Modals

## Executive Summary

This issue validates the Workspace state button and all seven associated modals. The Workspace state is the most feature-rich of the three page states, encompassing timesheet management, access control, contact discovery, cross-discipline collaboration, workspace administration, supplier configuration, and vector data management. Each modal must open, render correctly, validate input, and persist data where applicable. A pass rate above 95% is required.

## Problem Statement / Scope

When the user clicks the Workspace state button, the page must transition to the Workspace state, displaying seven buttons corresponding to the seven workspace modals. Each modal has distinct form fields, validation rules, and data persistence requirements. This issue covers the full lifecycle of all seven modals: rendering, interaction, validation, submission, and data persistence. Given the scope (7 modals), this issue has the highest story point estimate (8) in the PROCURE-TEST suite.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 5A | Workspace button click | Clicking Workspace button highlights it; page state transitions to Workspace; 7 buttons render |
| 5B | Timesheet modal | Modal opens; time entry fields render; submission persists to timesheets table |
| 5C | Access Permissions modal | Modal opens; permission toggles render; changes persist to database |
| 5D | Contact Scraper modal | Modal opens; scrape target input accepted; results displayed |
| 5E | Cross-Discipline Sharing modal | Modal opens; sharing configuration renders; settings persist |
| 5F | Manage Workspaces modal | Modal opens; workspace CRUD operations function correctly |
| 5G | Supplier Setup modal | Modal opens; supplier form fields match suppliers table schema; submission persists |
| 5H | Vector Data Manager modal | Modal opens; vector data management operations function correctly |

## Assigned Company & Agent

- **Company:** qualityforge-ai
- **Agent:** validator-qualityforge
- **Sub-agents:** None

## Required Skills

- quality-assurance
- ui-validation
- database-testing

## Acceptance Criteria

- [ ] Workspace state button renders and is clickable
- [ ] Clicking Workspace button highlights it and transitions page state
- [ ] Exactly 7 buttons render in Workspace state
- [ ] Timesheet modal opens, accepts time entries, and persists to timesheets table
- [ ] Access Permissions modal opens, permission toggles function, changes persist
- [ ] Contact Scraper modal opens, accepts scrape target, displays results
- [ ] Cross-Discipline Sharing modal opens, sharing config renders, settings persist
- [ ] Manage Workspaces modal opens, workspace CRUD operations succeed
- [ ] Supplier Setup modal opens, supplier form fields match suppliers table schema, submission persists
- [ ] Vector Data Manager modal opens, vector management operations function correctly
- [ ] Each modal closes via close button and backdrop click
- [ ] Form validation shows error messages for invalid input
- [ ] Successful submissions show confirmation messages

## Dependencies

- **Blocked by:** PROCURE-001 (page foundation), PROCURE-002 (database connectivity)
- **Depends on:** PROCURE-001, PROCURE-002
- **Blocks:** None

## Estimated Duration

60 minutes (plus 15min for subcontract-rfq regression after MEASURE-TENDER-004)

## Risk Level

**High** — Workspace state contains the largest surface area of any page state. Failures here impact timesheet management, access control, supplier configuration, and data management workflows.

## QC Team Checks

The following checks must be performed against the PAGE-KNOWLEDGE metadata for the 01900 page:

- [ ] **7 buttons render in Workspace state:** Confirm exactly seven buttons appear: Timesheet, Access Permissions, Contact Scraper, Cross-Discipline Sharing, Manage Workspaces, Supplier Setup, Vector Data Manager
- [ ] **Timesheet modal:** Verify time entry fields (date, hours, description, project) render; submission inserts row into timesheets table
- [ ] **Access Permissions modal:** Verify permission toggles for each access level; changes persist on reload
- [ ] **Contact Scraper modal:** Verify scrape target URL input; results display in a list or table format
- [ ] **Cross-Discipline Sharing modal:** Verify sharing configuration options (discipline select, permission level); settings persist
- [ ] **Manage Workspaces modal:** Verify workspace list renders; create, rename, delete operations succeed
- [ ] **Supplier Setup modal:** Verify supplier form fields match suppliers table schema; submission inserts row
- [ ] **Vector Data Manager modal:** Verify vector data browsing, filtering, and deletion operations function correctly

## Post-Build Coordination (MEASURE-TENDER-004)

After MEASURE-TENDER-004 adds subcontract-rfq components to `01900-procurement/components/`, re-run this issue to verify:

- [ ] All 7 existing workspace modals still open and function correctly alongside new subcontract-rfq components
- [ ] Grid layout (`calculateGridLayout()`) still accommodates both old and new button counts
- [ ] No CSS conflicts between existing `A-01900-*` classes and new subcontract-rfq classes
- [ ] `sortButtonsAlphabetically()` still sorts correctly after new component registration