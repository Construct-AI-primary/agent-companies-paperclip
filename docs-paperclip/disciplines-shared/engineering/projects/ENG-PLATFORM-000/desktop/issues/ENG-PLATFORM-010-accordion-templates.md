---
id: ENG-PLATFORM-010
title: "Accordion Template Updates"
description: "Integrate engineering platform with existing discipline accordions and pages"
labels: ["engineering", "platform", "4 — Accordion"]
blocked_by: []
depends_on: ["ENG-PLATFORM-001"]
para_section: engineering/projects/ENG-PLATFORM-000/desktop/issues
phase: "4 — Accordion"
status: backlog
priority: High
story_points: 5
due_date: "2026-06-11"
assignee: interface-devforge
company: devforge-ai
delegation:
  parent_goal_id: "ENG-PLATFORM-000"
  delegation_prompt: "Update accordion templates for all 10 engineering disciplines. Extend the accordion structure from ENG-AUTO-010 rather than recreating it. Integrate Scope of Work and Technical Specifications pages."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Integrate engineering platform with accordion navigation"
  agent_goal: "As interface-devforge, update accordion templates for all disciplines"
  task_goal: "Deliver accordion updates for all 10 engineering disciplines"
---

# ENG-PLATFORM-010: Accordion Template Updates

## Executive Summary

This issue integrates the engineering platform with existing discipline accordions and pages. The accordion template updates add engineering sections for all 10 disciplines, extending the structure from ENG-AUTO-010.

## Problem Statement / Scope

The accordion navigation needs engineering sections for:
- Civil Engineering (00850)
- Electrical Engineering (00860)
- Mechanical Engineering (00870)
- Structural Engineering (00872)
- Architectural Engineering (00825)
- Chemical Engineering (00835)
- Geotechnical Engineering (00855)
- Process Engineering (00871)
- Environmental Engineering (01000)
- Landscaping Engineering (03000)

This issue extends the ENG-AUTO-010 accordion structure.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 10A | Extend accordion structure | Add engineering sections |
| 10B | Add Civil Engineering accordion | 00850 links and pages |
| 10C | Add Electrical Engineering accordion | 00860 links and pages |
| 10D | Add Mechanical Engineering accordion | 00870 links and pages |
| 10E | Add Structural Engineering accordion | 00872 links and pages |
| 10F | Add remaining 6 disciplines | 00825, 00835, 00855, 00871, 01000, 03000 |

## Assigned Company & Agent

- **Company:** devforge-ai
- **Agent:** interface-devforge
- **Sub-agents:** None

## Required Skills

- react-development
- ui-integration
- accordion-implementation

## Acceptance Criteria

- [ ] Accordion structure extends ENG-AUTO-010
- [ ] All 10 disciplines have accordion entries
- [ ] Links point to correct pages
- [ ] Scope of Work integration works
- [ ] Technical Specifications integration works

## Dependencies

- **Blocked by:** None
- **Depends on:** ENG-PLATFORM-001
- **Blocks:** None

## Estimated Duration

1 day

## Risk Level

**High** — enables platform navigation

## Post-Build Coordination: ENG-AUTO-000

⚠ **Important**: This issue extends the accordion structure from ENG-AUTO-010:
- Do NOT recreate the accordion from scratch
- Extend the existing ENG-AUTO-010 accordion
- Add engineering discipline sections to existing accordion
- Coordinate with `interface-devforge` on structure

## QC Team Checks

- [ ] All 10 disciplines accessible via accordion
- [ ] Links navigate to correct pages
- [ ] Accordion structure consistent
- [ ] Engineering sections display correctly

---

**Version**: 1.0
**Last Updated**: 2026-04-28
