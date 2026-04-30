---
id: MEASURE-001
title: "Shared UI Architecture"
description: "Design and implement shared UI components for IntegrateForge measurement platform"
labels: [issue, measurement, ui, architecture, shared-components]
blocked_by: []
depends_on: []
para_section: disciplines-non/02025-measurement/projects/MEASURE-COMM/desktop/issues
phase: 1
status: backlog
priority: Critical
story_points: 13
due_date: 2026-05-15
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "MEASURE-ROOT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees:
    - forge-devforge-system-architecture
    - interface-devforge-api-integration
    - engineering-ui-specialist
    - dev-loopy-technical-creative
  heartbeat_frequency: "15min"
goals:
  company_goal: "Deliver a reusable shared UI component library that standardizes the IntegrateForge measurement platform across all 21+ integrations, reducing per-integration UI development time by 60%."
  agent_goal: "Implement and validate all shared UI components (IntegrationCard, MeasurementGrid, AccuracyMeter, DisciplineBadge, ConnectionWizard, 4-Panel Layout) with full OAuth flow support and VS Code-style panel architecture."
  task_goal: "Complete the shared UI component library with AG Grid integration, responsive breakpoints, inter-panel communication protocol, and AI chat interface integration."
---

# MEASURE-001: Shared UI Architecture

## Executive Summary

Design and implement shared UI components that work across all IntegrateForge integrations (AutoCAD, Civil 3D, Revit, CostX, etc.). The architecture follows a VS Code-style panel layout with an activity bar, primary/secondary sidebars, editor area, bottom panel area, and status bar. This component library will serve as the foundation for all measurement workflows across 21+ design tool integrations.

## Required Actions

| # | Action | Owner | Status |
|---|--------|-------|--------|
| 1 | Design IntegrationCard component with OAuth flow | qualityforge-ai | ⏳ Pending |
| 2 | Implement MeasurementGrid with AG Grid spreadsheet | qualityforge-ai | ⏳ Pending |
| 3 | Build AccuracyMeter with 100% indicator | qualityforge-ai | ⏳ Pending |
| 4 | Create DisciplineBadge color-coded labels | qualityforge-ai | ⏳ Pending |
| 5 | Develop ConnectionWizard with 4-step OAuth | qualityforge-ai | ⏳ Pending |
| 6 | Implement 4-Panel UI Layout for measurement workflows | qualityforge-ai | ⏳ Pending |
| 7 | Integrate AI chat interface with measurement workflow | qualityforge-ai | ⏳ Pending |
| 8 | Implement inter-panel communication protocol | qualityforge-ai | ⏳ Pending |
| 9 | Add responsive behavior for tablet and mobile | qualityforge-ai | ⏳ Pending |

## Assigned Company & Agent

- **Company:** qualityforge-ai
- **Primary Agent:** validator-qualityforge
- **Supporting Agents:**
  - forge-devforge-system-architecture — Architecture review
  - interface-devforge-api-integration — UI/API integration
  - engineering-ui-specialist — Domain-specific UI validation
  - dev-loopy-technical-creative — Creative design and UX

## Required Skills

- `ui-component-development`
- `react-typescript`
- `ag-grid-integration`
- `oauth-flow-implementation`
- `responsive-design`
- `cross-application-integration`

## Acceptance Criteria

- [ ] IntegrationCard renders for all 21 integrations
- [ ] MeasurementGrid supports inline editing
- [ ] AccuracyMeter shows 100% accuracy
- [ ] DisciplineBadge updates based on discipline
- [ ] ConnectionWizard completes OAuth flow
- [ ] VS Code-style panel interface renders correctly on desktop
- [ ] AI chat interface integrates with measurement workflow
- [ ] Panel communication protocol functions properly
- [ ] Responsive behavior works on tablets and mobile

## Dependencies

- BLOCKED BY: None
- BLOCKS: MEASURE-003 (Discipline Integration)

## Estimated Duration

4 weeks (160 hours total)

## Risk Level

Medium — Shared UI is foundational but well-understood technology; risk is in scope management across 21 integrations.

## QC Team Checks

- [ ] Code review completed by qualityforge-ai
- [ ] UI/UX review completed by loopy-ai
- [ ] Integration tests pass for all 21 integrations
- [ ] Accessibility audit passed (WCAG 2.1 AA)
- [ ] Performance benchmarks met (< 2s initial load)
- [ ] Documentation complete

## Related Components

- `ui/src/components/integrateforge/common/`
- `ui/src/components/integrateforge/measurement/`
