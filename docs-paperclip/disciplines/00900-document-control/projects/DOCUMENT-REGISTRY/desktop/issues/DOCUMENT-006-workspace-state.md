---
id: DOCUMENT-006
title: "00900 Workspace State — Document Registry & Approval Queue"
description: "Implement the Workspace state for the 00900 Document Control discipline with document registry dashboard, approval queue, and quick-action panels."
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
  agent_goal: "As domainforge-ai, implement the Workspace state with document registry and approval queue"
  task_goal: "Execute Workspace state implementation with 100% pass rate"
---

# DOCUMENT-006: 00900 Workspace State — Document Registry & Approval Queue

## Executive Summary

Implement the Workspace state serving as the main dashboard for document control management. It provides an overview of document metrics, pending approvals, recent activity, and quick-action panels for common tasks. This is the default landing page after login.

## Problem Statement / Scope

Document controllers and managers need a centralized dashboard showing key metrics, pending approvals, and document activity at a glance. Without a workspace view, users must navigate multiple screens to get an overview. The scope covers dashboard widgets, approval queue, and quick-action panels.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Metrics Cards | Display total documents, pending approvals, published count, and active reviews |
| 2 | Approval Queue | List of documents pending approval with reviewer, date, and priority |
| 3 | Recent Activity Feed | Chronological list of recent document actions and status changes |
| 4 | Document Type Breakdown | Pie/bar chart showing document distribution by type |
| 5 | Quick-Action Panel | Buttons for common tasks: New Document, Upload, View Approvals |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- Dashboard UI design patterns
- Data aggregation and visualization
- Real-time data fetching with polling or WebSocket
- Responsive grid layout

## Acceptance Criteria

- [ ] Metrics cards display accurate counts for total, pending, published, and review documents
- [ ] Approval queue shows pending documents with reviewer and priority
- [ ] Recent activity feed shows latest actions with timestamps
- [ ] Document type breakdown chart renders correctly
- [ ] Quick-action buttons navigate to correct states (Upsert, Agents, etc.)
- [ ] Dashboard data refreshes automatically at configurable intervals
- [ ] Loading skeleton displays during initial data fetch
- [ ] Error state displays with retry button on fetch failure
- [ ] Responsive layout adapts to different screen sizes

## Dependencies

- API endpoint `GET /api/v1/documents/dashboard` for aggregated metrics
- API endpoint `GET /api/v1/documents/pending-approvals` for approval queue
- API endpoint `GET /api/v1/documents/activity` for recent activity
- UI component library for cards, badges, and data display

## Estimated Duration

- **Development**: 2 days
- **Testing**: 1 day
- **Total**: 3 days

## Risk Level

**Low** — Standard dashboard pattern with multiple data sources.

## QC Team Checks

- [ ] All metrics cards display correct aggregated data
- [ ] Approval queue shows correct pending documents
- [ ] Activity feed shows most recent actions first
- [ ] Document type chart renders with correct data
- [ ] Quick-action buttons navigate to correct destinations
- [ ] Auto-refresh updates data without page flicker
- [ ] Responsive layout works on mobile and desktop
