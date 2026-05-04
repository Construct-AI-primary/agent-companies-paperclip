---
id: ELECTRICAL-006
title: "00860 Workspace State — Inspection Dashboard & Compliance View"
description: "Implement the Workspace state for the 00860 Electrical Engineering discipline with an inspection dashboard, compliance overview, and quick-action panels."
labels: ["electrical", "00860", "2 — State/Modals"]
blocked_by: []
depends_on: ["ELECTRICAL-001", "ELECTRICAL-002", "ELECTRICAL-003"]
para_section: electrical-engineering/projects/ELECTRICAL-INSPECTIONS/desktop/issues
phase: "2 — State/Modals"
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
  agent_goal: "As domainforge-ai, implement the Workspace state with dashboard and compliance view"
  task_goal: "Execute Workspace state implementation with 100% pass rate"
---

# ELECTRICAL-006: 00860 Workspace State — Inspection Dashboard & Compliance View

## Executive Summary

Implement the Workspace state serving as the main dashboard for electrical inspection management. It provides an overview of inspection metrics, compliance status, upcoming inspections, and quick-action panels for common tasks. This is the default landing page after login.

## Problem Statement / Scope

Inspectors and managers need a centralized dashboard showing key metrics, pending actions, and compliance status at a glance. Without a workspace view, users must navigate multiple screens to get an overview. The scope covers dashboard widgets, compliance summary, and quick-action panels.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Metrics Cards | Display total inspections, pass rate, fail rate, and pending reviews |
| 2 | Compliance Summary | Widget showing compliance status across inspected equipment categories |
| 3 | Upcoming Inspections | List of scheduled inspections for the current week |
| 4 | Recent Activity Feed | Chronological list of recent inspection actions and status changes |
| 5 | Quick-Action Panel | Buttons for common tasks: New Inspection, View Reports, Export Data |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- Dashboard UI design patterns
- Data aggregation and visualization
- Real-time data fetching with polling or WebSocket
- Responsive grid layout

## Acceptance Criteria

- [ ] Metrics cards display accurate counts for total, pass, fail, and pending inspections
- [ ] Compliance summary widget shows pass/fail breakdown by equipment category
- [ ] Upcoming inspections list shows scheduled inspections with date and location
- [ ] Recent activity feed shows latest actions with timestamps
- [ ] Quick-action buttons navigate to correct states (Upsert, Agents, etc.)
- [ ] Dashboard data refreshes automatically at configurable intervals
- [ ] Loading skeleton displays during initial data fetch
- [ ] Error state displays with retry button on fetch failure
- [ ] Responsive layout adapts to different screen sizes

## Dependencies

- API endpoint `GET /api/v1/inspections/dashboard` for aggregated metrics
- API endpoint `GET /api/v1/inspections/upcoming` for scheduled inspections
- API endpoint `GET /api/v1/inspections/activity` for recent activity
- UI component library for cards, badges, and data display

## Estimated Duration

- **Development**: 2 days
- **Testing**: 1 day
- **Total**: 3 days

## Risk Level

**Low** — Standard dashboard pattern with multiple data sources.

## QC Team Checks

- [ ] All metrics cards display correct aggregated data
- [ ] Compliance summary widget renders correctly with color coding
- [ ] Upcoming inspections list shows correct date-sorted data
- [ ] Activity feed shows most recent actions first
- [ ] Quick-action buttons navigate to correct destinations
- [ ] Auto-refresh updates data without page flicker
- [ ] Responsive layout works on mobile and desktop
