---
title: Agent Spend Dashboard — Findings & Analysis
description: Investigation into monthly spend tracking per agent and the non-functioning dashboard counter
author: Paperclip QA Team
date: 2026-04-28
version: 1.0
status: findings
related_projects:
  - PROCURE-TEST
  - PROCURE-013a
---

# Agent Spend Dashboard — Findings & Analysis

## Executive Summary

The monthly spend per agent dashboard counter is not currently functioning. This document captures what was found during investigation, what already exists in the codebase, and what would be needed to fix it.

## What Already Exists

### Activity Log (Audit Trail)
- **Schema**: `packages/shared/src/types/activity.ts` — `ActivityEvent` with fields: `actorType` (agent|user|system), `actorId`, `action`, `entityType`, `entityId`, `runId`, `details` (JSON blob)
- **Service**: `server/src/services/activity.ts` — `list()`, `forIssue()`, `runsForIssue()`, `issuesForRun()`, `create()`
- **Routes**: `GET /api/companies/:companyId/activity` — fully filterable by `agentId`, `entityType`, `entityId`
- **Live Events**: `activity.logged` published via WebSocket in real-time

### Budget Hard-Stop
- **Schema**: `CompanyBudget` in `packages/shared/src/types/` — `budgetLimit`, `budgetSpent`, `budgetAutoPause`
- **Behavior**: When `budgetSpent >= budgetLimit`, the company auto-pauses — this is the control-plane hard-stop, not a dashboard counter

### Run & Heartbeat Tracking
- **Schema**: `contextSnapshot` in activity log — captures tool calls, token usage, iteration counts per heartbeat run
- **API**: `GET /api/companies/:companyId/activity/runs/:runId/issues` — what issues a heartbeat run touched

## What's Missing

### No Monthly Spend Aggregation
| Gap | Details |
|-----|---------|
| **No `agent_monthly_spend` table** | No structured storage for spend by agent/month |
| **No cost mapping** | Token counts exist in `contextSnapshot` but are not mapped to dollar amounts (OpenAI/Anthropic API costs) |
| **No aggregation endpoint** | `GET /api/companies/:companyId/spend/monthly` does not exist |
| **No dashboard component** | `MonthlySpendCard.tsx` or equivalent does not exist |

### Why the Counter Doesn't Work
The dashboard counter likely attempts to aggregate spend from:
1. `activityLog` tool call records → no dollar mapping
2. `CompanyBudget.budgetSpent` → this is a company-level total, not per-agent
3. `contextSnapshot` token counts → not aggregated per agent/month

Without a dedicated aggregation service that joins token counts + model pricing, there is no data to display.

## What Would Fix It

### 1. Schema — New Table `agent_monthly_spend`
```sql
CREATE TABLE agent_monthly_spend (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  agent_id UUID NOT NULL REFERENCES agents(id),
  company_id UUID NOT NULL REFERENCES companies(id),
  month DATE NOT NULL,  -- first day of month
  total_cost DECIMAL(10,2) NOT NULL DEFAULT 0,
  total_tokens BIGINT NOT NULL DEFAULT 0,
  tool_call_count INT NOT NULL DEFAULT 0,
  run_count INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(agent_id, month)
);
```

### 2. Service — Spend Aggregation
- `server/src/services/spend.ts`
- Daily routine: read previous day's `activityLog` + `contextSnapshot` for each agent
- Map token counts to model pricing (from `agent_models` table)
- Upsert into `agent_monthly_spend`

### 3. API Endpoint
- `GET /api/companies/:companyId/spend/monthly?agentId=&month=&year=`
- Returns aggregated spend per agent, optionally filtered

### 4. Dashboard Component
- `ui/src/components/dashboard/MonthlySpendCard.tsx`
- Bar chart or table showing spend per agent for current month
- Color-coded: green (under budget), yellow (approaching limit), red (at limit/paused)

### 5. Heartbeat Routine
- Schedule a daily heartbeat that calculates previous day's spend
- If any agent exceeds configurable monthly threshold → auto-escalate

## Implementation Priority

| Component | Priority | Complexity | Dependencies |
|-----------|----------|------------|--------------|
| Schema table | High | Low | None |
| Service + API | High | Medium | Schema |
| Heartbeat routine | Medium | Medium | Service |
| Dashboard component | Medium | Medium | API |
| Model pricing mapping | High | Low | agent_models table |

## Recommendation

Implement as **PROCURE-015** after the main PROCURE-TEST phases are underway. The schema and service are relatively low-effort and would enable the feedback loop in PROCURE-013a to include cost data alongside activity tracking.

---

**Status**: Findings only — no implementation started
**Date**: 2026-04-28
**Author**: Paperclip QA Team