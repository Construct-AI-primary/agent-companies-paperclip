---
title: "Heartbeat Monitoring Configuration — ENG-PLATFORM-000 Agent Feedback Loop"
description: "Configuration for real-time agent activity monitoring, stall detection, and escalation during ENG-PLATFORM-000 execution"
author: "DevForge AI / DomainForge AI"
date: "2026-04-28"
version: "1.0"
---

# Heartbeat Monitoring Configuration — ENG-PLATFORM-000 Agent Feedback Loop

## Overview

This document configures the agent feedback loop that enables real-time visibility into what agents are doing during ENG-PLATFORM-000 execution. It leverages Paperclip's built-in ActivityEvent logging and heartbeat run tracking.

## Monitoring Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│               ENG-PLATFORM-000 Feedback Loop                    │
│                                                                  │
│  Poller (15min)                                                  │
│  ├── GET /api/companies/devforge-ai/activity                   │
│  │   └── ?entityType=issue&entityId=ENG-PLATFORM-*             │
│  │                                                              │
│  ├── Aggregate by agentId                                       │
│  │   ├── Last heartbeat timestamp                               │
│  │   ├── Current issue status                                   │
│  │   ├── Tool call count (from contextSnapshot)                 │
│  │   └── Sub-agent delegation count                             │
│  │                                                              │
│  ├── Stall detection                                            │
│  │   └── If no heartbeat >30min → escalate to CEO              │
│  │                                                              │
│  └── Generate status file                                       │
│      └── ENG-PLATFORM-FEEDBACK-LOOP.md                          │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
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
        entityId: "ENG-PLATFORM-*"
        limit: 100
    issue_status:
      url: "GET /api/companies/{companyId}/issues"
      params:
        ids: ["ENG-PLATFORM-001", "ENG-PLATFORM-002", ..., "ENG-PLATFORM-017"]
  output_file: "ENG-PLATFORM-FEEDBACK-LOOP.md"
  output_path: "desktop/learning/"
```

## Agent Status Dashboard Template

The poller generates a status dashboard that looks like this:

```markdown
# ENG-PLATFORM-000 Agent Feedback Loop — {TIMESTAMP}

## Active Agents

| Agent | Issue | Status | Last Heartbeat | Tool Calls | Sub-Agents | Stall Risk |
|-------|-------|--------|----------------|------------|------------|------------|
| devcore-devforge | ENG-PLATFORM-001 | in_progress | 2min ago | 14 | 0 | ✅ OK |
| interface-devforge | ENG-PLATFORM-002 | in_review | 8min ago | 7 | 0 | ✅ OK |
| database-infraforge | ENG-PLATFORM-003 | backlog | never | 0 | 0 | ⚠ NOT STARTED |
| knowledge-manager | ENG-PLATFORM-004 | in_progress | 5min ago | 3 | 0 | ✅ OK |
| learningforge-ai-lead | ENG-PLATFORM-005 | backlog | never | 0 | 0 | ⚠ NOT STARTED |
| domainforge-ai-engineeringdirector | ENG-PLATFORM-006 | backlog | never | 0 | 0 | ⚠ NOT STARTED |
| codesmith-devforge | ENG-PLATFORM-008 | backlog | never | 0 | 0 | ⚠ NOT STARTED |
| civil-domainforge | ENG-PLATFORM-012 | backlog | never | 0 | 0 | ⚠ NOT STARTED |
| validator-qualityforge | ENG-PLATFORM-015 | backlog | never | 0 | 0 | ⚠ NOT STARTED |

## Stall Warnings

| Agent | Issue | Last Heartbeat | Elapsed | Action Required |
|-------|-------|----------------|---------|----------------|
| _(none)_ | | | | |

## Phase Gate Status

| Gate | Phase | Pass Rate | Critical Issues | Decision |
|------|-------|-----------|-----------------|----------|
| Gate 1 | Phase 1 | 0% (pending) | 0 | ⏳ IN PROGRESS |
| Gate 2 | Phase 2 | 0% (pending) | 0 | ⏳ NOT STARTED |
| Gate 3 | Phase 3 | 0% (pending) | 0 | ⏳ NOT STARTED |
| Gate 4 | Phase 4 | 0% (pending) | 0 | ⏳ NOT STARTED |
| Gate 5 | Phase 5 | 0% (pending) | 0 | ⏳ NOT STARTED |
| Gate 6 | Phase 6 | 0% (pending) | 0 | ⏳ NOT STARTED |
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
      notify: "devcore-devforge"
    critical:
      action: "Create escalation sub-task"
      assignee: "devforge-ceo"
      priority: "critical"
    timeout:
      action: "Create blocker issue"
      assignee: "domainforge-ai-engineeringdirector"
      priority: "critical"

  exempt_agents: []
  exempt_statuses: ["done", "cancelled"]
```

## Activity Log Query Examples

### Get all ENG-PLATFORM-000 activity
```
GET /api/companies/devforge-ai/activity
  ?entityType=issue
  &entityId=ENG-PLATFORM-001
  &limit=50
```

### Get all runs for a specific issue
```
GET /api/companies/devforge-ai/activity/runs?entityId=ENG-PLATFORM-001
```

### Get all issues touched by a specific run
```
GET /api/companies/devforge-ai/activity/issues?runId={runId}
```

### Check agent's last heartbeat
```
GET /api/companies/devforge-ai/activity
  ?agentId=devcore-devforge
  &limit=1
  &sort=createdAt:desc
```

## Feedback Propagation Flow

```
DomainForge agent completes discipline pilot
  ↓
Updates sub-task status → status propagates to parent (ENG-PLATFORM-XXX)
  ↓
validator-qualityforge sees status update via heartbeat poll
  ↓
Updates ENG-PLATFORM-FEEDBACK-LOOP.md dashboard
  ↓
Phase gate evaluation triggered (if all sub-tasks done)
  ↓
Gate decision → proceed, review, or escalate
  ↓
CEO informed of phase completion
```

## Configuration Steps

### Before ENG-PLATFORM-000 Execution

1. [ ] Ensure activity log API is accessible:
   ```bash
   curl http://localhost:3100/api/companies/devforge-ai/activity?limit=1
   ```
2. [ ] Verify ENG-PLATFORM-* issues exist in the system:
   ```bash
   curl http://localhost:3100/api/companies/devforge-ai/issues?search=ENG-PLATFORM
   ```
3. [ ] Configure heartbeat monitor script to poll every 15min
4. [ ] Create `ENG-PLATFORM-FEEDBACK-LOOP.md` initial file

### During ENG-PLATFORM-000 Execution

5. [ ] Monitor feedback dashboard for stall warnings
6. [ ] Escalate stalled agents per escalation procedure
7. [ ] Document each phase gate decision in feedback dashboard

### After ENG-PLATFORM-000 Completion

8. [ ] Archive feedback dashboard to `archive/`
9. [ ] Summarize agent activity metrics for post-mortem
10. [ ] Update learning tracker with feedback loop effectiveness

---

**Version**: 1.0
**Last Updated**: 2026-04-28
