---
id: LAND-PLANT-002
title: "Planting Operations Core — Planting Workflow, Quality Inspection & Establishment Tracking"
labels: ["landscaping", "planting", "2 — Core Integration"]
phase: "2 — Core Integration"
status: todo
priority: High
story_points: 13
due_date: "2026-07-31"
assignee: devforge-ai
company: devforge-ai
blocked_by:
  - LAND-PLANT-001
estimated_weeks: 6
---

# LAND-PLANT-002: Planting Operations Core — Planting Workflow, Quality Inspection & Establishment Tracking

## Description

Implement the core planting workflow engine, quality inspection system, and establishment period tracking for the Landscaping discipline (03000). This issue covers the end-to-end planting task lifecycle, pre- and post-planting quality inspections, and the establishment period monitoring workflow that tracks plant health during the defect liability period.

## Objectives

1. Build the planting workflow engine with task creation, assignment, and progress tracking
2. Implement quality inspection checklists for pre-planting and post-planting stages
3. Create establishment period tracking with scheduled health assessments
4. Develop the daily planting log with crew assignment and productivity tracking
5. Implement non-conformance reporting and corrective action workflows

## Requirements

### Planting Workflow Engine

- [ ] Task creation and assignment from plant schedule line items
- [ ] Planting progress tracking (planned vs actual quantities planted)
- [ ] Status transitions: Planned → In Progress → Completed → Inspected → Signed Off
- [ ] Crew assignment with crew member tracking and productivity metrics
- [ ] Daily planting log with date, location, species, quantities, and crew
- [ ] Task dependencies and sequencing (e.g., soil prep before planting)
- [ ] Reassignment and rescheduling capabilities
- [ ] Progress dashboard with real-time updates

### Quality Inspection System

- [ ] Pre-planting inspection checklists:
  - Plant health assessment (vigour, pests, diseases, damage)
  - Size verification against specification
  - Root condition assessment (root-bound, circling roots)
  - Soil preparation verification
- [ ] Post-planting inspection checklists:
  - Planting depth and alignment
  - Staking and guying installation
  - Watering and mulching quality
  - Tree protection measures
- [ ] Scoring system with pass/fail criteria and weighted scoring
- [ ] Photo evidence capture and attachment to inspection records
- [ ] Non-conformance reporting with severity levels
- [ ] Corrective action tracking with due dates and closure verification
- [ ] Re-inspection workflow for failed items

### Establishment Period Tracking

- [ ] Establishment period configuration (typical duration: 12-24 months)
- [ ] Scheduled health assessment visits with configurable frequency
- [ ] Plant health scoring dimensions:
  - Vigour (growth rate, leaf colour, canopy density)
  - Foliage condition (discolouration, necrosis, defoliation)
  - Pest and disease presence (type, severity, treatment)
  - Structural condition (trunk, branches, root stability)
- [ ] Watering and irrigation requirement tracking
- [ ] Maintenance intervention logging (fertilising, pruning, pest treatment)
- [ ] Establishment progress reporting with trend analysis
- [ ] Establishment sign-off workflow with certification

## Acceptance Criteria

- [ ] Planting workflow operational with end-to-end task lifecycle
- [ ] Quality inspection checklists functional with scoring and pass/fail
- [ ] Photo evidence capture and attachment working
- [ ] Non-conformance reporting with corrective action tracking
- [ ] Establishment period tracking with health assessment forms
- [ ] Daily planting log capturing all required field data
- [ ] Integration tests passing for all workflow operations
- [ ] API endpoints documented and accessible

## Dependencies

- BLOCKED BY: LAND-PLANT-001 (Foundation data model)
- Requires: Workflow engine framework from Paperclip platform
- Requires: Web application shell for dashboard integration

## Notes

- Coordinate with LAND-PLANT-WEB-001 for dashboard integration points
- Inspection checklists should be configurable per project requirements
- Consider integration with irrigation system for watering schedule generation
- Establishment period durations may vary by contract and species type
