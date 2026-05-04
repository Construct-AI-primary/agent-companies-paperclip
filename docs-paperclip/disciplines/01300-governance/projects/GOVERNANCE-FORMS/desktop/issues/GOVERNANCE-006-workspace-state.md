---
id: GOVERNANCE-006
title: "01300 Workspace State — Compliance Board & Audit Viewer"
description: "Implement the Workspace state for the 01300 Governance discipline with compliance board, audit viewer, and quick-action panels."
labels: ["governance", "01300", "2 — State/Modals"]
blocked_by: []
depends_on: ["GOVERNANCE-001", "GOVERNANCE-002", "GOVERNANCE-003"]
para_section: governance/projects/GOVERNANCE-FORMS/desktop/issues
phase: "2 — State/Modals"
status: todo
priority: High
story_points: 3
due_date: "2026-05-20"
assignee: "domainforge-ai"
company: "domainforge-ai"
delegation:
  parent_goal_id: "GOVERNANCE-FORMS-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement 01300 governance form management"
  agent_goal: "As domainforge-ai, implement the Workspace state with compliance board and audit viewer"
  task_goal: "Execute Workspace state implementation with 100% pass rate"
---

# GOVERNANCE-006: 01300 Workspace State — Compliance Board & Audit Viewer

## Executive Summary

Implement the Workspace state serving as the main dashboard for governance management. It provides an overview of compliance metrics, pending approvals, audit activity, and quick-action panels for common tasks.

## Problem Statement / Scope

Governance officers and compliance managers need a centralized dashboard showing key metrics, pending approvals, and compliance status at a glance. The scope covers dashboard widgets, compliance board, audit viewer, and quick-action panels.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Metrics Cards | Display total forms, pending approvals, compliance rate, and open audits |
| 2 | Compliance Board | Widget showing compliance status across policies and disciplines |
| 3 | Recent Audit Activity | Chronological list of recent audit events and compliance actions |
| 4 | Approval Pipeline Overview | Visual pipeline showing forms at each approval stage |
| 5 | Quick-Action Panel | Buttons for common tasks: New Form, View Queue, Compliance Report |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- Dashboard UI design patterns
- Data aggregation and visualization
- Real-time data fetching with polling or WebSocket
- Responsive grid layout

## Acceptance Criteria

- [ ] Metrics cards display accurate counts for total, pending, compliance, and audit items
- [ ] Compliance board shows pass/fail breakdown by policy
- [ ] Recent audit activity shows latest events with timestamps
- [ ] Approval pipeline overview shows forms at each stage
- [ ] Quick-action buttons navigate to correct states (Upsert, Agents, etc.)
- [ ] Dashboard data refreshes automatically at configurable intervals
- [ ] Loading skeleton displays during initial data fetch
- [ ] Error state displays with retry button on fetch failure
- [ ] Responsive layout adapts to different screen sizes

## Dependencies

- API endpoint `GET /api/v1/governance/dashboard` for aggregated metrics
- API endpoint `GET /api/v1/governance/audit/recent` for recent activity
- API endpoint `GET /api/v1/governance/pipeline` for pipeline overview
- UI component library for cards, badges, and data display

## Estimated Duration

- **Development**: 2 days
- **Testing**: 1 day
- **Total**: 3 days

## Risk Level

**Low** — Standard dashboard pattern with multiple data sources.

## QC Team Checks

- [ ] All metrics cards display correct aggregated data
- [ ] Compliance board renders correctly with color coding
- [ ] Audit activity shows most recent events first
- [ ] Pipeline overview shows correct stage counts
- [ ] Quick-action buttons navigate to correct destinations
- [ ] Auto-refresh updates data without page flicker
- [ ] Responsive layout works on mobile and desktop
