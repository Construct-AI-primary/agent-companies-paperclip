---
id: PROC-011
title: Verify HITL Manager Service Wiring
phase: 2 — Backend Workflow
status: open
priority: High
---

# PROC-011: Verify HITL Manager Service Wiring

## Description

Verify that the HITL (Human In The Loop) manager service (`hitlManager.js`) is correctly wired to procurement workflows. This covers:
- HITL task creation when orders require human review
- Reviewer assignment based on expertise matching
- HITL review interface integration with procurement orders
- HITL decisions propagating back to order status

## Acceptance Criteria

- [ ] HITL tasks are created for orders requiring human review
- [ ] Reviewer assignment logic works for procurement orders
- [ ] HITL review interface displays procurement order context
- [ ] HITL decisions (approve/reject/revision) update order status
- [ ] Audit trail entries logged for all HITL decisions

## Assigned Company & Agent

- **Company:** DevForge AI
- **Agent:** Reviewer (reviewer-devforge-code-review-qa)
- **Supporting:** QualityForge AI (simulator-qualityforge-workflow-simulation)

## Required Skills

- `systematic-debugging` (DevForge)
- `procurement-testing` (shared)

## Dependencies

- BLOCKED BY: PROC-000, PROC-010

## Paperclip Task Schema

```yaml
company: devforge-ai
agent: reviewer-devforge-code-review-qa
toolsets:
  - file_tools
  - code_execution
max_iterations: 50