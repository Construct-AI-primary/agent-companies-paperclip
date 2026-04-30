---
title: Heartbeat Monitoring Configuration — MEASURE-TENDER Agent Feedback Loop
description: Configuration for real-time agent activity monitoring, stall detection, and escalation during MEASURE-TENDER execution
author: MeasureForge AI / DomainForge AI
date: 2026-04-28
version: 1.0
parent_goal_id: MEASURE-ROOT-2026
---

# Heartbeat Monitoring Configuration — MEASURE-TENDER Agent Feedback Loop

## Overview

This document configures the agent feedback loop that enables real-time visibility into what agents are doing during MEASURE-TENDER execution. It leverages Paperclip's built-in ActivityEvent logging and heartbeat run tracking. The parent goal for all MEASURE-TENDER activity is `MEASURE-ROOT-2026`.

## Monitoring Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    MEASURE-TENDER Feedback Loop                   │
│                                                                  │
│  Poller (15min)                                                  │
│  ├── GET /api/companies/{companyId}/activity                    │
│  │   └── ?entityType=issue&entityId=MEASURE-TENDER-*            │
│  │                                                              │
│  ├── Aggregate by agentId                                       │
│  │   ├── Last heartbeat timestamp                               │
│  │   ├── Current issue status                                   │
│  │   ├── Tool call count (from contextSnapshot)                 │
│  │   └── Sub-agent delegation count                             │
│  │                                                              │
│  ├── Stall detection                                            │
│  │   └── If no heartbeat >30min → escalate to CEO               │
│  │                                                              │
│  └── Generate status file                                       │
│      └── MEASURE-TENDER-FEEDBACK-LOOP.md                        │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## Parent Goal Configuration

```yaml
parent_goal:
  id: "MEASURE-ROOT-2026"
  description: "Root goal for all MEASURE-TENDER procurement tender system activities"
  propagation:
    - "All issue status updates propagate to MEASURE-ROOT-2026 via parentId chain"
    - "Phase gate decisions logged as activity events under MEASURE-ROOT-2026"
    - "Completion of final issue (MEASURE-TENDER-006b) marks root goal as done"
```

## Polling Configuration

```yaml
monitoring:
  poll_interval: "15min"
  endpoints:
    activity_log:
      url: "GET /api/companies/{companyId}/activity"
      params:
        entityType: "issue"
        entityId: "MEASURE-TENDER-*"
        limit: 100
    issue_status:
      url: "GET /api/companies/{companyId}/issues"
      params:
        ids: ["MEASURE-TENDER-001", "MEASURE-TENDER-002", "MEASURE-TENDER-003", "MEASURE-TENDER-004", "MEASURE-TENDER-005", "MEASURE-TENDER-006a", "MEASURE-TENDER-006b"]
  output_file: "MEASURE-TENDER-FEEDBACK-LOOP.md"
  output_path: "desktop/learning/"
```

## Agent Status Dashboard Template

The poller generates a status dashboard that looks like this:

```markdown
# MEASURE-TENDER Agent Feedback Loop — {TIMESTAMP}

## Active Agents

| Agent | Issue | Status | Last Heartbeat | Tool Calls | Sub-Agents | Stall Risk |
|-------|-------|--------|----------------|------------|------------|------------|
| database-infraforge | MEASURE-TENDER-001 | in_progress | 2min ago | 14 | 0 | ✅ OK |
| procurement-domainforge-...contracts | MEASURE-TENDER-002 | in_review | 8min ago | 7 | 0 | ✅ OK |
| procurement-strategy-domainforge-...strategy | MEASURE-TENDER-006a | backlog | never | 0 | 0 | ⚠ NOT STARTED |
| loopy-ai | MEASURE-TENDER-006b | backlog | never | 0 | 0 | ⚠ NOT STARTED |

## Stall Warnings

| Agent | Issue | Last Heartbeat | Elapsed | Action Required |
|-------|-------|----------------|---------|-----------------|
| _(none)_ | | | | |

## Phase Gate Status

| Gate | Phase | Pass Rate | Critical Issues | Decision |
|------|-------|-----------|-----------------|----------|
| Gate 1 | Phase 1 | 100% | 0 | ✅ PASSED |
| Gate 2 | Phase 2 | 0% (pending) | 0 | ⏳ IN PROGRESS |
```

## Stall Detection Rules

```yaml
stall_detection:
  thresholds:
    warning: "15min"       # Yellow flag
    critical: "30min"      # Red flag → escalate
    auto_escalate: "1hr"   # Auto-create escalation issue

  escalation_procedure:
    warning:
      action: "Flag agent in feedback dashboard"
      notify: "measurement-ceo"
    critical:
      action: "Create escalation sub-task"
      assignee: "measurement-ceo"
      priority: "critical"
    timeout:
      action: "Create blocker issue"
      assignee: "domainforge-ai-procurementdirector"
      priority: "critical"

  exempt_agents: []
  exempt_statuses: ["done", "cancelled"]
```

## Activity Log Query Examples

### Get all MEASURE-TENDER activity
```
GET /api/companies/domainforge-ai/activity
  ?entityType=issue
  &entityId=MEASURE-TENDER-002
  &limit=50
```

### Get all runs for a specific issue
```
GET /api/companies/infraforge-ai/activity/runs?entityId=MEASURE-TENDER-001
```

### Get all issues touched by a specific run
```
GET /api/companies/domainforge-ai/activity/issues?runId={runId}
```

### Check agent's last heartbeat
```
GET /api/companies/loopy-ai/activity
  ?agentId=loopy-ai
  &limit=1
  &sort=createdAt:desc
```

## Feedback Propagation Flow

```
DomainForge agent completes domain implementation
  ↓
Updates sub-task status → status propagates to parent (MEASURE-TENDER-XXX)
  ↓
measurement-ceo sees status update via heartbeat poll
  ↓
Updates MEASURE-TENDER-FEEDBACK-LOOP.md dashboard
  ↓
Phase gate evaluation triggered (if all sub-tasks done)
  ↓
Gate decision → proceed, review, or escalate
  ↓
CEO informed of phase completion
  ↓
Status propagates to parent goal: MEASURE-ROOT-2026
```

## Configuration Steps

### Before MEASURE-TENDER Execution

1. [ ] Ensure activity log API is accessible:
   ```bash
   curl http://localhost:3100/api/companies/infraforge-ai/activity?limit=1
   ```
2. [ ] Verify MEASURE-TENDER-* issues exist in the system:
   ```bash
   curl http://localhost:3100/api/companies/infraforge-ai/issues?search=MEASURE-TENDER
   ```
3. [ ] Configure heartbeat monitor script to poll every 15min
4. [ ] Create `MEASURE-TENDER-FEEDBACK-LOOP.md` initial file
5. [ ] Verify parent goal `MEASURE-ROOT-2026` exists in the system

### During MEASURE-TENDER Execution

5. [ ] Monitor feedback dashboard for stall warnings
6. [ ] Escalate stalled agents per escalation procedure
7. [ ] Document each phase gate decision in feedback dashboard
8. [ ] Ensure status propagation to MEASURE-ROOT-2026 parent goal

### After MEASURE-TENDER Completion

9. [ ] Archive feedback dashboard to `archive/`
10. [ ] Summarize agent activity metrics for post-mortem
11. [ ] Update learning tracker with feedback loop effectiveness
12. [ ] Close parent goal MEASURE-ROOT-2026

---

**Version**: 1.0
**Last Updated**: 2026-04-28
