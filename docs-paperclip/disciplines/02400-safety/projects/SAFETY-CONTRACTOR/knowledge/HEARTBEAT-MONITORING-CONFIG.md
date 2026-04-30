---
title: Heartbeat Monitoring Configuration — SAFETY-CONTRACTOR Agent Feedback Loop
description: Configuration for real-time agent activity monitoring, stall detection, and escalation during SAFETY-CONTRACTOR execution
author: Paperclip QA Team
date: 2026-04-28
version: 1.0
---

# Heartbeat Monitoring Configuration — SAFETY-CONTRACTOR Agent Feedback Loop

## Overview

This document configures the agent feedback loop that enables real-time visibility into what agents are doing during SAFETY-CONTRACTOR execution. It leverages Paperclip's built-in ActivityEvent logging and heartbeat run tracking.

## Monitoring Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    SAFETY-CONTRACTOR Feedback Loop                │
│                                                                  │
│  Poller (15min)                                                  │
│  ├── GET /api/companies/qualityforge-ai/activity                │
│  │   └── ?entityType=issue&entityId=SAFETY-CONTRACTOR-*         │
│  │                                                              │
│  ├── Aggregate by agentId                                       │
│  │   ├── Last heartbeat timestamp                               │
│  │   ├── Current issue status                                   │
│  │   ├── Tool call count (from contextSnapshot)                  │
│  │   └── Sub-agent delegation count                              │
│  │                                                              │
│  ├── Stall detection                                            │
│  │   └── If no heartbeat >30min → escalate to CEO               │
│  │                                                              │
│  └── Generate status file                                       │
│      └── SAFETY-CONTRACTOR-FEEDBACK-LOOP.md                     │
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
        entityId: "SAFETY-CONTRACTOR-*"
        limit: 100
    issue_status:
      url: "GET /api/companies/{companyId}/issues"
      params:
        ids: ["SAFETY-CONTRACTOR-001", "SAFETY-CONTRACTOR-002", "SAFETY-CONTRACTOR-003",
              "SAFETY-CONTRACTOR-004", "SAFETY-CONTRACTOR-005",
              "SAFETY-CONTRACTOR-001-mobile", "SAFETY-CONTRACTOR-002-mobile",
              "SAFETY-CONTRACTOR-003-mobile", "SAFETY-CONTRACTOR-004-mobile",
              "SAFETY-CONTRACTOR-005-mobile"]
  output_file: "SAFETY-CONTRACTOR-FEEDBACK-LOOP.md"
  output_path: "desktop/learning/"
```

## Agent Status Dashboard Template

The poller generates a status dashboard that looks like this:

```markdown
# SAFETY-CONTRACTOR Agent Feedback Loop — {TIMESTAMP}

## Active Agents

| Agent | Issue | Status | Last Heartbeat | Tool Calls | Sub-Agents | Stall Risk |
|-------|-------|--------|----------------|------------|------------|------------|
| guardian-qualityforge | SAFETY-CONTRACTOR-001 | in_progress | 2min ago | 14 | 0 | ✅ OK |
| guardian-qualityforge | SAFETY-CONTRACTOR-002 | in_review | 8min ago | 7 | 1 | ✅ OK |
| infraforge-ai-integration-specialist | SAFETY-CONTRACTOR-002 | backlog | never | 0 | 0 | ⚠ NOT STARTED |
| domainforge-ai-architectural-integration | — | consulted | 22min ago | 3 | 0 | ✅ OK |

## Stall Warnings

| Agent | Issue | Last Heartbeat | Elapsed | Action Required |
|-------|-------|----------------|---------|-----------------|
| _(none)_ | | | | |

## Phase Gate Status

| Gate | Platform | Pass Rate | Critical Issues | Decision |
|------|----------|-----------|-----------------|----------|
| Gate 1 | Desktop | 0% (pending) | 0 | ⏳ IN PROGRESS |
| Gate 2 | Mobile | 0% (pending) | 0 | ⏳ PENDING |
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
      notify: "guardian-qualityforge"
    critical:
      action: "Create escalation sub-task"
      assignee: "qualityforge-ceo"
      priority: "critical"
    timeout:
      action: "Create blocker issue"
      assignee: "domainforge-ai-architectural-integration"
      priority: "critical"

  exempt_agents: []
  exempt_statuses: ["done", "cancelled"]
```

## Activity Log Query Examples

### Get all SAFETY-CONTRACTOR activity
```
GET /api/companies/qualityforge-ai/activity
  ?entityType=issue
  &entityId=SAFETY-CONTRACTOR-001
  &limit=50
```

### Get all runs for a specific issue
```
GET /api/companies/qualityforge-ai/activity/runs?entityId=SAFETY-CONTRACTOR-001
```

### Get all issues touched by a specific run
```
GET /api/companies/qualityforge-ai/activity/issues?runId={runId}
```

### Check agent's last heartbeat
```
GET /api/companies/qualityforge-ai/activity
  ?agentId=guardian-qualityforge
  &limit=1
  &sort=createdAt:desc
```

## Feedback Propagation Flow

```
DomainForge agent completes safety domain check
  ↓
Updates sub-task status → status propagates to parent (SAFETY-CONTRACTOR-XXX)
  ↓
guardian-qualityforge sees status update via heartbeat poll
  ↓
Updates SAFETY-CONTRACTOR-FEEDBACK-LOOP.md dashboard
  ↓
Phase gate evaluation triggered (if all sub-tasks done)
  ↓
Gate decision → proceed, review, or escalate
  ↓
CEO informed of phase completion
```

## Configuration Steps

### Before SAFETY-CONTRACTOR Execution

1. [ ] Ensure activity log API is accessible:
   ```bash
   curl http://localhost:3100/api/companies/qualityforge-ai/activity?limit=1
   ```
2. [ ] Verify SAFETY-CONTRACTOR-* issues exist in the system:
   ```bash
   curl http://localhost:3100/api/companies/qualityforge-ai/issues?search=SAFETY-CONTRACTOR
   ```
3. [ ] Configure heartbeat monitor script to poll every 15min
4. [ ] Create `SAFETY-CONTRACTOR-FEEDBACK-LOOP.md` initial file

### During SAFETY-CONTRACTOR Execution

5. [ ] Monitor feedback dashboard for stall warnings
6. [ ] Escalate stalled agents per escalation procedure
7. [ ] Document each phase gate decision in feedback dashboard

### After SAFETY-CONTRACTOR Completion

8. [ ] Archive feedback dashboard to `archive/`
9. [ ] Summarize agent activity metrics for post-mortem
10. [ ] Update learning tracker with feedback loop effectiveness

---

**Version**: 1.0
**Last Updated**: 2026-04-28