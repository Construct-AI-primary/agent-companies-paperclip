---
title: Heartbeat Monitoring Configuration — ELEC-WORKFLOW
description: Agent feedback loop configuration for real-time monitoring during ELEC-WORKFLOW execution
author: QualityForge AI
date: 2026-04-28
version: 1.0
---

# Heartbeat Monitoring Configuration — ELEC-WORKFLOW

## Overview

This document configures the agent feedback loop for real-time monitoring during ELEC-WORKFLOW execution. The heartbeat system polls agent activity, detects stalls, and escalates issues through the defined escalation path.

## Polling Configuration

```yaml
heartbeat:
  project: "ELEC-WORKFLOW"
  discipline: "00860-electrical-engineering"
  frequency: "15min"
  poller:
    endpoint: "GET /api/companies/domainforge-ai/activity"
    params:
      since: "last_poll_timestamp"
      limit: 100
    aggregation:
      group_by: "agentId"
      metrics: ["issue_count", "status_changes", "activity_count"]
  stall_detection:
    warning_threshold: "15min"
    critical_threshold: "30min"
    timeout_threshold: "1hr"
    escalation:
      warning: "Log to activity feed"
      critical: "Notify electrical-domainforge lead"
      timeout: "Escalate to domainforge-ceo"
```

## Agent Activity Polling

### Polling Endpoint

```bash
# Poll all activity for DomainForge AI
curl -X GET "/api/companies/domainforge-ai/activity?since=2026-04-28T00:00:00Z&limit=100"

# Poll activity for specific agent
curl -X GET "/api/companies/domainforge-ai/activity?agentId=electrical-domainforge&since=2026-04-28T00:00:00Z"
```

### Activity Aggregation

```sql
SELECT
  a.name AS agent_name,
  COUNT(al.id) AS activity_count,
  MAX(al.created_at) AS last_activity
FROM agents a
LEFT JOIN activity_log al ON al.actor_id = a.id
  AND al.created_at > NOW() - INTERVAL '30 minutes'
WHERE a.company_id = '<domainforge-company-uuid>'
  AND a.name LIKE '%electrical%'
GROUP BY a.name
ORDER BY last_activity DESC;
```

## Issue Status Dashboard

### Dashboard Template

```markdown
# ELEC-WORKFLOW Execution Dashboard
**Generated**: {{timestamp}}
**Period**: {{start_time}} — {{end_time}}

## Overall Status
| Metric | Value |
|--------|-------|
| Total Issues | 8 |
| In Progress | {{count_in_progress}} |
| Completed | {{count_done}} |
| Blocked | {{count_blocked}} |
| Stall Warnings | {{count_stalled}} |

## Issue Status Breakdown
| Issue | Status | Agent | Last Activity | Stall Risk |
|-------|--------|-------|---------------|------------|
| ELEC-001 | {{status}} | electrical-domainforge | {{last_activity}} | {{risk}} |
| ELEC-002 | {{status}} | electrical-domainforge | {{last_activity}} | {{risk}} |
| ELEC-003 | {{status}} | electrical-domainforge | {{last_activity}} | {{risk}} |
| ELEC-004 | {{status}} | electrical-domainforge | {{last_activity}} | {{risk}} |
| ELEC-005 | {{status}} | electrical-domainforge | {{last_activity}} | {{risk}} |
| ELEC-006 | {{status}} | electrical-domainforge | {{last_activity}} | {{risk}} |
| ELEC-007 | {{status}} | electrical-domainforge | {{last_activity}} | {{risk}} |
| ELEC-008 | {{status}} | electrical-domainforge | {{last_activity}} | {{risk}} |

## Stall Detection
| Agent | Last Activity | Time Since | Threshold | Action |
|-------|---------------|------------|-----------|--------|
| {{agent}} | {{time}} | {{duration}} | {{threshold}} | {{action}} |
```

## Stall Detection Thresholds

| Level | Time Since Last Activity | Action |
|-------|-------------------------|--------|
| Warning | > 15 minutes | Log warning to activity feed |
| Critical | > 30 minutes | Notify electrical-domainforge lead |
| Timeout | > 1 hour | Escalate to domainforge-ceo |

## Feedback Propagation Flow

```
Heartbeat Poller (15min)
    │
    ├── Activity found → Update dashboard → Continue
    │
    └── No activity detected
        │
        ├── >15min → Warning: Log to activity feed
        │
        ├── >30min → Critical: Notify electrical-domainforge
        │   └── electrical-domainforge investigates
        │       ├── Agent busy → Acknowledge, continue
        │       └── Agent stuck → Unblock, reassign
        │
        └── >60min → Timeout: Escalate to domainforge-ceo
            └── CEO intervenes → Reassign or remediate
```

## API Query Examples

### Check issue status

```bash
curl -X GET "/api/issues?assigneeAgentId=electrical-domainforge&status=in_progress"
```

### Log activity

```bash
curl -X POST "/api/companies/domainforge-ai/activity" \
  -H "Content-Type: application/json" \
  -d '{
    "actor_id": "electrical-domainforge",
    "action": "status_update",
    "description": "ELEC-001: Power distribution workflow in progress",
    "issue_id": "<elec-001-issue-uuid>"
  }'
```

### Update issue status

```bash
curl -X PATCH "/api/issues/<elec-001-issue-uuid>" \
  -H "Content-Type: application/json" \
  -d '{"status": "in_review"}'
```

## Execution Checklist

### Pre-Execution
- [ ] All 8 ELEC issues created in Paperclip with correct assigneeAgentId
- [ ] Knowledge bundle uploaded to EE-ROOT-ELEC-WORKFLOW-2026 issue
- [ ] Agent heartbeat configured with 15min frequency
- [ ] DomainForge AI company UUID verified
- [ ] electrical-domainforge agent verified in DomainForge AI company

### During Execution
- [ ] Monitor dashboard for stall warnings every 30 minutes
- [ ] Log all status changes via activity API
- [ ] Escalate blockers within defined thresholds
- [ ] Update ISSUE-GENERATION-STATUS.md with progress

### Post-Execution
- [ ] Verify all 8 issues completed (status = done)
- [ ] Archive execution dashboard
- [ ] Document lessons learned in project knowledge
- [ ] Close EE-ROOT-ELEC-WORKFLOW-2026 issue

---

**Version**: 1.0
**Last Updated**: 2026-04-28