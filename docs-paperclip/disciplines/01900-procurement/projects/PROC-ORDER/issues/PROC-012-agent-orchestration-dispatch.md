---
id: PROC-012
title: Fix Agent Orchestration Service Dispatch for Procurement
phase: 2 — Backend Workflow
status: open
priority: High
---

# PROC-012: Fix Agent Orchestration Service Dispatch for Procurement

## Description

Ensure the agent orchestration service correctly dispatches procurement tasks to the appropriate specialist agents. The `agentOrchestrationService.js` must be configured to route SOW generation, appendix creation, and approval tasks to the correct domain agents.

## Acceptance Criteria

- [ ] Agent capability monitoring detects available procurement agents
- [ ] Task dispatcher routes SOW tasks to correct domain agents
- [ ] Sequence intelligence engine calculates optimal processing order for procurement
- [ ] Real-time agent status is displayed in orchestration dashboard
- [ ] Failed task dispatch triggers automatic reassignments

## Assigned Company & Agent

- **Company:** DevForge AI
- **Agent:** Forge (forge-devforge-system-architecture)
- **Supporting:** DomainForge AI (procurement-domainforge-procurement-contracts)

## Dependencies

- BLOCKED BY: PROC-000, PROC-010

## Paperclip Task Schema

```yaml
company: devforge-ai
agent: forge-devforge-system-architecture
toolsets:
  - file_tools
  - code_execution
max_iterations: 60