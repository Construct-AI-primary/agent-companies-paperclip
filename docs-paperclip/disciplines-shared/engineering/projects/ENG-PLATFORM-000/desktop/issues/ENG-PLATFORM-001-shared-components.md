---
id: ENG-PLATFORM-001
title: "Shared Engineering Components Extraction"
description: "Extract engineering UI components into reusable shared modules for cross-discipline platform"
labels: ["engineering", "platform", "1 — Architecture"]
blocked_by: []
depends_on: []
para_section: engineering/projects/ENG-PLATFORM-000/desktop/issues
phase: "1 — Architecture"
status: backlog
priority: Critical
story_points: 8
due_date: "2026-05-04"
assignee: devcore-devforge
company: devforge-ai
delegation:
  parent_goal_id: "ENG-PLATFORM-000"
  delegation_prompt: "Extract and implement all shared engineering components per the platform architecture plan. Do not duplicate ENG-AUTO-010 shared components — extend or reference them instead."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Establish cross-discipline engineering platform foundation"
  agent_goal: "As devcore-devforge, extract and implement shared engineering components for all disciplines"
  task_goal: "Deliver 5 shared components, 4 services, 3 hooks, and 3 utilities in client/src/shared/engineering/"
---

# ENG-PLATFORM-001: Shared Engineering Components Extraction

## Executive Summary

This issue extracts engineering UI components into reusable shared modules that serve all 10 engineering disciplines. The shared component library establishes the foundation for the cross-discipline engineering platform, enabling consistent UI/UX across civil, structural, MEP, and other engineering disciplines.

## Problem Statement / Scope

The Paperclip ecosystem currently has discipline-specific engineering components that are not reusable across disciplines. This issue creates a shared component library that:
- Provides consistent UI/UX across all engineering disciplines
- Enables discipline-specific adaptations within a shared framework
- Reduces development duplication
- Establishes standards for future engineering components

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1A | Create directory structure | `client/src/shared/engineering/{components,services,hooks,utils}/` |
| 1B | Implement CADModelViewer | 3D model visualization with multi-CAD support |
| 1C | Implement EngineeringValidation | Real-time standards validation per discipline |
| 1D | Implement StandardsSelector | Jurisdiction-aware standards selection |
| 1E | Implement AnalysisResults | FEA/thermal/acoustic analysis display |
| 1F | Implement EngineeringAuditTrail | Design decision audit trail |
| 1G | Implement services | cadService, analysisService, validationService, auditService |
| 1H | Implement hooks | useEngineeringModel, useAnalysis, useStandards |
| 1I | Implement utils | cadUtils, analysisUtils, standardsUtils |

## Assigned Company & Agent

- **Company:** devforge-ai
- **Agent:** devcore-devforge
- **Sub-agents:** None

## Required Skills

- react-development
- engineering-standards
- component-architecture

## Acceptance Criteria

- [ ] CADModelViewer renders 3D models with zoom/pan/rotate
- [ ] EngineeringValidation applies discipline-specific rules
- [ ] StandardsSelector filters by jurisdiction
- [ ] AnalysisResults displays FEA/thermal results
- [ ] EngineeringAuditTrail captures all design changes
- [ ] All components work across 10 engineering disciplines
- [ ] Services handle CAD operations, analysis, validation, audit
- [ ] Hooks manage state for models, analysis, standards
- [ ] Utils provide calculation and conversion helpers

## Dependencies

- **Blocked by:** None
- **Depends on:** None
- **Blocks:** ENG-PLATFORM-010, ENG-PLATFORM-012, ENG-PLATFORM-013, ENG-PLATFORM-014

## Estimated Duration

2 days

## Risk Level

**Critical** — blocks all discipline pilots and accordion integration

## Post-Build Coordination: ENG-AUTO-000

⚠ **Important**: This issue must coordinate with ENG-AUTO-010 (Architectural Discipline Pilot):
- Do NOT duplicate shared components already created in ENG-AUTO-010
- Reference ENG-AUTO-010 components where applicable
- Extend the accordion structure from ENG-AUTO-010 rather than recreating it
- Coordinate with `devcore-devforge` on component boundaries

## QC Team Checks

The following checks must be performed against the PAGE-KNOWLEDGE metadata:

- [ ] All 5 shared components render correctly
- [ ] Component metadata matches METADATA-BUNDLE specifications
- [ ] CAD system support includes AutoCAD, Revit, Civil 3D
- [ ] Standards validation applies per discipline
- [ ] Audit trail captures design decisions
- [ ] Cross-discipline compatibility verified

---

**Version**: 1.0
**Last Updated**: 2026-04-28
