# HEARTBEAT MONITORING CONFIGURATION — MEASURE-AI

## Overview

This document defines the heartbeat monitoring configuration for all MEASURE-AI issues. Heartbeats ensure continuous progress tracking, bottleneck detection, and agent health monitoring across the distributed multi-company execution environment.

## Global Configuration

| Parameter | Value |
|-----------|-------|
| Heartbeat Frequency | 15 minutes |
| Parent Goal ID | MEASURE-ROOT-2026 |
| Escalation Threshold | 3 consecutive missed heartbeats |
| Escalation Target | Primary agent → Project coordinator |
| Heartbeat Channel | Paperclip Task API |

## Per-Issue Configuration

| Issue ID | Heartbeat Frequency | Primary Agent | Escalation Contact |
|----------|-------------------|---------------|-------------------|
| MEASURE-AI-001 | 15min | validator-qualityforge | qualityforge-ai coordinator |
| MEASURE-AI-002 | 15min | validator-qualityforge | qualityforge-ai coordinator |
| MEASURE-AI-003 | 15min | validator-qualityforge | qualityforge-ai coordinator |
| MEASURE-AI-004 | 15min | validator-qualityforge | qualityforge-ai coordinator |

## Heartbeat Payload Schema

Each heartbeat should report the following data:

```json
{
  "issue_id": "MEASURE-AI-001",
  "agent_id": "validator-qualityforge",
  "timestamp": "2026-04-24T12:00:00Z",
  "status": "in_progress",
  "progress_percentage": 45,
  "current_task": "Assigning primary models to measurement agents",
  "blockers": [],
  "next_heartbeat_expected": "2026-04-24T12:15:00Z",
  "sub_agent_status": []
}
```

## Heartbeat Flow

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│ Sub-Agent   │────▶│ Primary     │────▶│ Paperclip   │
│ (every 15m) │     │ Agent       │     │ Task API    │
└─────────────┘     └─────────────┘     └─────────────┘
                           │
                           ▼
                    ┌─────────────┐
                    │ Heartbeat   │
                    │ Monitor     │
                    │ (escalation │
                    │  detection) │
                    └─────────────┘
```

## Escalation Procedure

1. **Missed Heartbeat 1:** Log warning, continue monitoring
2. **Missed Heartbeat 2:** Send reminder to agent, flag for review
3. **Missed Heartbeat 3:** Escalate to primary agent / project coordinator
4. **Resolution:** Agent resumes heartbeats OR task is reassigned

## Monitoring Dashboard

Heartbeat status should be visible on the Paperclip dashboard with:
- Green: Heartbeat received within expected window
- Yellow: 1 heartbeat missed
- Orange: 2 heartbeats missed
- Red: 3+ heartbeats missed (escalated)

## Related Documents

- [AGENT-DELEGATION-MAP.md](./AGENT-DELEGATION-MAP.md)
- [CROSS-COMPANY-RACI.md](./CROSS-COMPANY-RACI.md)
