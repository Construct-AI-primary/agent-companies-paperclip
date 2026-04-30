---
id: PROCURE-013
title: 01900 Agent Delegation — CEO→Subordinate Heartbeat Validation
description: Verify CEO→subordinate delegation flow creates sub-tasks via assigneeAgentId+parentId, heartbeat detects assignments, and status propagates upward
labels: ["testing", "procurement", "5 — Compliance & Sign-off"]
blocked_by: ["AGENT-CONTENT-REMEDIATION"]
depends_on: ["PROCURE-001"]
para_section: testing/projects/PROCURE-TEST/desktop/issues
phase: 5 — Compliance & Sign-off
status: todo
priority: High
story_points: 5
due_date: "2026-05-05"
assignee: domainforge-ai-procurementdirector
company: domainforge-ai
delegation:
  parent_goal_id: "QC-ROOT-PROCUREMENT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Verify all subordinate agents receive assignments and report back."
  allowed_sub_assignees: ["validator-qualityforge", "procurement-domainforge-procurement-contracts", "supplier-management-domainforge-procurement"]
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 01900 procurement page production readiness"
  agent_goal: "As domainforge-ai-procurementdirector, verify CEO→subordinate delegation flow creates sub-tasks via assigneeAgentId+parentId, heartbeat detects assignments, and status propagates upward"
  task_goal: "Execute delegation flow test and verify heartbeat loop integrity"
---

# PROCURE-013: 01900 Agent Delegation — CEO→Subordinate Heartbeat Validation

## Executive Summary
**Objective**: Test the full Paperclip delegation pipeline — CEO creates root goal, decomposes into sub-tasks, assigns via heartbeat, and status propagates upward through the hierarchy.

**⚠ Pre-requisite**: The DomainForge procurement-director agent content must be remediated before execution (currently references Dependency Manager role, not Procurement Director).

**Success Criteria**: All delegation steps execute correctly with no breaks in the heartbeat chain.

## Required Actions

- **13A**: CEO creates root goal "QC-ROOT-PROCUREMENT-2026" with delegation prompt
- **13B**: CEO decomposes into sub-tasks — sets assigneeAgentId for each subordinate, sets parentId to QC-ROOT
- **13C**: Sub-agent heartbeat loop detects assigned sub-task (polling GET /api/issues?assigneeAgentId={self})
- **13D**: Sub-agent executes sub-task, updates status to "in_progress" → "in_review" → "done"
- **13E**: Status change propagates upward to parent issue (CEO sees aggregate status)
- **13F**: Approval request routes correctly through the hierarchy

## Acceptance Criteria

- [ ] CEO creates root goal with delegation prompt
- [ ] Sub-tasks created with correct assigneeAgentId and parentId
- [ ] Sub-agent heartbeat detects assigned task
- [ ] Sub-task status transitions work (backlog→in_progress→in_review→done)
- [ ] Status propagates upward to parent issue
- [ ] Approval requests route correctly

## Risk Level

High — tests the core Paperclip delegation mechanism