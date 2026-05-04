---
id: CONTRACT-006
title: "00400 Workspace State — Contract Dashboard & Compliance View"
description: "Implement the Workspace state with a contract dashboard showing key metrics, compliance status overview, and quick-action widgets for contract management."
labels: ["contracts", "00400", "2 — State/Modals"]
blocked_by: []
depends_on: ["CONTRACT-001", "CONTRACT-002", "CONTRACT-003"]
para_section: contracts/projects/CONTRACT-LIFECYCLE/desktop/issues
phase: "2 — State/Modals"
status: todo
priority: High
story_points: 3
due_date: "2026-05-15"
assignee: "domainforge-ai"
company: "domainforge-ai"
delegation:
  parent_goal_id: "CONTRACT-LIFECYCLE-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement 00400 contract lifecycle management"
  agent_goal: "As domainforge-ai, implement the workspace dashboard with compliance overview and quick-action widgets"
  task_goal: "Execute workspace state implementation with 100% pass rate"
---

# CONTRACT-006: 00400 Workspace State — Contract Dashboard & Compliance View

## Executive Summary

Implement the Workspace state as the default landing view after login. The dashboard displays key contract metrics (total contracts, active, pending, value at risk), compliance status overview with alert counts, and quick-action widgets for common tasks like creating contracts, reviewing approvals, and checking compliance.

## Problem Statement / Scope

Contract managers need a centralized dashboard for at-a-glance awareness of contract portfolio health. The workspace must surface critical metrics, compliance alerts, and provide quick access to common actions. The compliance view must integrate with the Post-Award compliance monitoring system.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Metrics Cards | Display total contracts, active count, pending actions, value at risk |
| 2 | Compliance Overview | Summary widget showing compliant, non-compliant, and pending checks |
| 3 | Quick Actions | Action buttons: Create Contract, Review Approvals, Check Compliance, View Reports |
| 4 | Recent Activity | Timeline of recent contract events (creation, signing, variation, closeout) |
| 5 | Alert Banner | Prominent banner for critical compliance alerts requiring immediate attention |
| 6 | Loading State | Skeleton dashboard with placeholder metric cards |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- Dashboard layout and data visualization
- Metric aggregation from multiple API endpoints
- Real-time alert polling or WebSocket integration
- Responsive widget grid layout

## Acceptance Criteria

- [ ] Metrics cards display accurate aggregated data from the API
- [ ] Compliance overview shows counts for compliant, non-compliant, and pending statuses
- [ ] Quick-action buttons navigate to the correct states (Upsert, detail views)
- [ ] Recent activity timeline shows latest events with timestamps
- [ ] Alert banner displays for critical compliance issues with dismiss action
- [ ] Dashboard loads with skeleton placeholders during data fetch
- [ ] Error state shows with retry option on dashboard load failure
- [ ] Widgets are responsive and reflow on smaller viewports
- [ ] Data auto-refreshes at configurable intervals

## Dependencies

- Dashboard API endpoint aggregating metrics
- Compliance status API endpoint
- Activity feed API endpoint
- WebSocket or polling mechanism for real-time alerts

## Estimated Duration

- **Development**: 3 days
- **Testing**: 1 day
- **Total**: 4 days

## Risk Level

**Medium** — Multiple data sources must aggregate correctly; real-time alerts add complexity.

## QC Team Checks

- [ ] All metric values match backend aggregation results
- [ ] Compliance overview correctly reflects current compliance data
- [ ] Quick actions navigate to correct destinations
- [ ] Activity timeline shows events in correct chronological order
- [ ] Alert banner appears and dismisses correctly
- [ ] Skeleton loader matches final layout dimensions
- [ ] Auto-refresh updates data without visual disruption
- [ ] Responsive layout works on tablet and mobile viewports
