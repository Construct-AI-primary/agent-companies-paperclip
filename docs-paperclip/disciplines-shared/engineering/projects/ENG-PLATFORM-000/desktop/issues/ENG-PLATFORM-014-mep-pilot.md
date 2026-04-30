---
id: ENG-PLATFORM-014
title: "MEP Engineering Pilot (00870/00860)"
description: "Implement MEP engineering discipline pilot following ENG-AUTO-010 pattern"
labels: ["engineering", "platform", "5 — Disciplines"]
blocked_by: []
depends_on: ["ENG-PLATFORM-001", "ENG-PLATFORM-002", "ENG-PLATFORM-007"]
para_section: engineering/projects/ENG-PLATFORM-000/desktop/issues
phase: "5 — Disciplines"
status: backlog
priority: Medium
story_points: 8
due_date: "2026-06-29"
assignee: mep-domainforge
company: domainforge-ai
delegation:
  parent_goal_id: "ENG-PLATFORM-000"
  delegation_prompt: "Implement MEP engineering (00870/00860) discipline pilot. Follow the ENG-AUTO-010 pattern. Implement HVAC, plumbing, power distribution, and lighting design."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Enable MEP engineering disciplines on platform"
  agent_goal: "As mep-domainforge, implement MEP engineering pilot"
  task_goal: "Deliver MEP engineering pilot with HVAC, plumbing, electrical, and automation features"
---

# ENG-PLATFORM-014: MEP Engineering Pilot (00870/00860)

## Executive Summary

This issue implements the MEP (Mechanical and Electrical) engineering discipline pilot, following the ENG-AUTO-010 pattern. The pilot enables HVAC system design, plumbing and fire protection, power distribution, lighting design, and building automation.

## Problem Statement / Scope

MEP engineering requires:
- HVAC system design
- Plumbing and fire protection
- Power distribution systems
- Lighting design
- Building automation

This issue implements the MEP engineering pilot.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 14A | Implement HVAC system design | Heating, cooling, ventilation |
| 14B | Implement plumbing features | Plumbing and drainage layouts |
| 14C | Implement fire protection | Fire suppression systems |
| 14D | Implement power distribution | Electrical load calculations |
| 14E | Implement lighting design | Lighting layouts and calculations |
| 14F | Implement building automation | BMS integration |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** mep-domainforge
- **Sub-agents:** None

## Required Skills

- mechanical-engineering
- electrical-engineering
- hvac-design
- building-automation

## Acceptance Criteria

- [ ] HVAC system design functional
- [ ] Plumbing features work
- [ ] Fire protection features work
- [ ] Power distribution works
- [ ] Lighting design works
- [ ] Building automation works
- [ ] Standards (ASHRAE, SMACNA, SANS-10142) applied
- [ ] CAD integration (Revit, Inventor) works

## Dependencies

- **Blocked by:** None
- **Depends on:** ENG-PLATFORM-001, ENG-PLATFORM-002, ENG-PLATFORM-007
- **Blocks:** None

## Estimated Duration

3 days

## Risk Level

**Medium** — discipline pilot

## Post-Build Coordination: ENG-AUTO-000

⚠ **Important**: This issue follows the ENG-AUTO-010 pattern:
- Use shared components from ENG-PLATFORM-001
- Follow accordion structure from ENG-PLATFORM-010
- Apply same UI/UX standards as ENG-AUTO-010

## QC Team Checks

- [ ] All MEP features work
- [ ] Standards validation applies
- [ ] CAD integration works
- [ ] UI matches platform standards

---

**Version**: 1.0
**Last Updated**: 2026-04-28
