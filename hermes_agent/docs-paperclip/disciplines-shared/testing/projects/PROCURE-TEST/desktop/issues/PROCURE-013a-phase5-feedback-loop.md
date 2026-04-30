---
id: PROCURE-013a
title: Agent Feedback Loop — Live Monitoring, Stall Detection & Escalation
description: Configure and test the agent feedback loop — poll activity log every 15min, detect stalled agents, and escalate via CEO
labels: ["testing", "procurement", "5 — Compliance & Sign-off"]
blocked_by: []
depends_on: ["PROCURE-013"]
para_section: testing/projects/PROCURE-TEST/desktop/issues
phase: 5 — Compliance & Sign-off
status: backlog
priority: High
story_points: 5
due_date: "2026-05-05"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-PROCUREMENT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 01900 procurement page production readiness"
  agent_goal: "As validator-qualityforge, configure and test the agent feedback loop — poll activity log, detect stalled agents, escalate via CEO"
  task_goal: "Execute feedback loop end-to-end — polling, stall detection, escalation, dashboard"
---

# PROCURE-013a: Agent Feedback Loop — Live Monitoring, Stall Detection & Escalation

## Executive Summary
**Objective**: Configure and validate the agent feedback loop that provides real-time visibility into what agents are doing during PROCURE-TEST execution. This answers the question "what are the agents doing?" by polling Paperclip's ActivityEvent API.

**Success Criteria**: All feedback loop components configured and tested — polling endpoint, stall detection threshold, escalation procedure, status dashboard.

## Required Actions

- **13aA**: Configure polling routine calling `GET /api/companies/qualityforge-ai/activity?entityType=issue&entityId=PROCURE-*`
- **13aB**: Generate agent status dashboard template (showing agent, issue, status, last heartbeat, tool calls, sub-agents, stall risk)
- **13aC**: Verify stall detection triggers warning at 15min and critical flag at 30min
- **13aD**: Test escalation by simulating a stalled agent (no heartbeat for >30min → auto-create escalation issue)
- **13aE**: Verify sub-agent completion → status propagates to parent issue
- **13aF**: Generate post-phase activity report using `runsForIssue()` aggregation

## Acceptance Criteria

- [ ] Polling routine configured at 15min interval
- [ ] Agent status dashboard generated with all fields
- [ ] Stall detection warning triggers at 15min
- [ ] Stall detection critical triggers at 30min with escalation
- [ ] Escalation creates issue assigned to CEO
- [ ] Post-phase activity report generates correctly
- [ ] All feedback loop components documented

## Dependencies

- PROCURE-013 (Agent Delegation) — feedback loop monitors delegation results
- Activity log API must be accessible

## Risk Level

High — critical for answering "what are agents doing?"