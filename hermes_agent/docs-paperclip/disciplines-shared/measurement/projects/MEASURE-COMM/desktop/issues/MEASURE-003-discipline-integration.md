---
id: MEASURE-003
title: "Discipline Integration"
description: "Implement discipline-specific measurement dashboards and workflows"
labels: [issue, measurement, discipline-integration, dashboards, workflows, cross-discipline]
blocked_by: [MEASURE-001, MEASURE-002]
depends_on: [MEASURE-001, MEASURE-002]
para_section: disciplines-non/02025-measurement/projects/MEASURE-COMM/desktop/issues
phase: 3
status: backlog
priority: High
story_points: 21
due_date: 2026-06-15
assignee: procurement-strategy-domainforge-procurement-strategy
company: domainforge-ai
delegation:
  parent_goal_id: "MEASURE-ROOT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees:
    - forge-devforge-system-architecture
    - engineering-ui-specialist
    - interface-devforge-api-integration
  heartbeat_frequency: "15min"
goals:
  company_goal: "Deliver discipline-specific measurement dashboards and workflows for Civil, Electrical, Mechanical, and Structural engineering that integrate with the shared UI and OpenCV engine."
  agent_goal: "Implement four discipline-specific dashboard layouts with tailored measurement tools, workflow templates, and standards compliance per discipline."
  task_goal: "Complete all four discipline dashboards with working measurement tools, template loading, and cross-discipline coordination features."
---

# MEASURE-003: Discipline Integration

## Executive Summary

Create discipline-specific measurement dashboards and workflows for Civil Engineering (00850), Electrical Engineering (00860), Mechanical Engineering (00870), and Structural Engineering integration. Each discipline receives tailored measurement tools, workflow templates, and standards compliance configurations that integrate with the shared UI architecture and OpenCV processing engine.

## Required Actions

| # | Action | Owner | Status |
|---|--------|-------|--------|
| 1 | Build Civil Engineering dashboard with earthworks and road measurement tools | domainforge-ai | ⏳ Pending |
| 2 | Build Electrical Engineering dashboard with cable and equipment layouts | domainforge-ai | ⏳ Pending |
| 3 | Build Mechanical Engineering dashboard with HVAC and piping systems | domainforge-ai | ⏳ Pending |
| 4 | Build Structural Engineering dashboard with concrete and steel elements | domainforge-ai | ⏳ Pending |
| 5 | Implement discipline-specific measurement templates | domainforge-ai | ⏳ Pending |
| 6 | Create cross-discipline coordination features | domainforge-ai | ⏳ Pending |
| 7 | Integrate discipline dashboards with shared UI components | domainforge-ai | ⏳ Pending |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Primary Agent:** procurement-strategy-domainforge-procurement-strategy
- **Supporting Agents:**
  - forge-devforge-system-architecture — System architecture and integration
  - engineering-ui-specialist — Discipline-specific UI validation
  - interface-devforge-api-integration — API integration and data flow

## Required Skills

- `discipline-specific-ui`
- `civil-engineering-measurement`
- `electrical-engineering-measurement`
- `mechanical-engineering-measurement`
- `structural-engineering-measurement`
- `workflow-template-design`
- `cross-discipline-coordination`

## Acceptance Criteria

- [ ] Civil Engineering dashboard with earthworks and road measurement tools
- [ ] Electrical Engineering dashboard with cable and equipment layouts
- [ ] Mechanical Engineering dashboard with HVAC and piping systems
- [ ] Structural Engineering dashboard with concrete and steel elements
- [ ] Discipline-specific measurement templates load correctly
- [ ] Cross-discipline coordination features functional
- [ ] All dashboards integrate with shared UI components

## Dependencies

- BLOCKED BY: MEASURE-001 (Shared UI Architecture), MEASURE-002 (OpenCV Processing Engine)
- BLOCKS: MEASURE-004 (Standards Compliance)

## Estimated Duration

5 weeks (200 hours total)

## Risk Level

Medium — Discipline-specific workflows are well-understood; integration complexity is the primary risk factor.

## QC Team Checks

- [ ] Code review completed by domainforge-ai
- [ ] Discipline-specific validation by domain experts
- [ ] Cross-discipline integration tests pass
- [ ] Template loading and rendering verified
- [ ] Performance benchmarks met
- [ ] Documentation complete

## Related Components

- `ui/src/components/disciplines/`
- `ui/src/templates/measurement/`
- `server/src/discipline-handlers/`
