---
id: ELECTRICAL-009
title: "00860 Equipment Database — Asset Lookup & History"
description: "Implement equipment database integration for looking up electrical assets and viewing their inspection history within the inspection workflow."
labels: ["electrical", "00860", "3 — Integration"]
blocked_by: []
depends_on: ["ELECTRICAL-004", "ELECTRICAL-005", "ELECTRICAL-006"]
para_section: electrical-engineering/projects/ELECTRICAL-INSPECTIONS/desktop/issues
phase: "3 — Integration"
status: todo
priority: Medium
story_points: 3
due_date: "2026-05-20"
assignee: "domainforge-ai"
company: "domainforge-ai"
delegation:
  parent_goal_id: "ELECTRICAL-INSPECTIONS-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement 00860 electrical inspection management"
  agent_goal: "As domainforge-ai, implement equipment database integration for asset lookup"
  task_goal: "Execute equipment database integration with 100% pass rate"
---

# ELECTRICAL-009: 00860 Equipment Database — Asset Lookup & History

## Executive Summary

Implement the equipment database integration that allows inspectors to look up electrical assets, view their specifications, and review inspection history. This integration connects the inspection system with the equipment asset database for contextual inspection data.

## Problem Statement / Scope

Inspectors need quick access to equipment specifications and historical inspection data when performing inspections. Without this integration, inspectors must switch between systems to gather context. The scope covers asset lookup, specification display, and inspection history retrieval.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Asset Lookup Interface | Searchable interface for finding electrical assets by ID, name, or location |
| 2 | Asset Detail Panel | Display panel showing equipment specifications, ratings, and installation data |
| 3 | Inspection History | Chronological list of past inspections for the selected asset |
| 4 | Asset-Inspection Linking | Link inspections to specific assets during report creation |
| 5 | Equipment Status Tracking | Display current equipment status and maintenance schedule |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- Database integration and API consumption
- Search interface implementation
- Historical data aggregation
- Asset data model understanding

## Acceptance Criteria

- [ ] Asset lookup searches by ID, name, and location return correct results
- [ ] Asset detail panel displays all required specification fields
- [ ] Inspection history shows past inspections sorted by date descending
- [ ] Inspections can be linked to specific assets during creation
- [ ] Linked assets are displayed in the inspection detail view
- [ ] Equipment status indicator shows current operational status
- [ ] Loading states display during data fetch
- [ ] Error states handle asset not found and API failures
- [ ] Asset data is cached for performance on repeated lookups

## Dependencies

- Equipment asset database API
- Asset data model with specifications and status fields
- Inspection data model with asset reference field
- Search/indexing service for asset lookup

## Estimated Duration

- **Development**: 2 days
- **Testing**: 1 day
- **Total**: 3 days

## Risk Level

**Low** — Standard database lookup and history retrieval pattern.

## QC Team Checks

- [ ] Asset search returns correct results for all search criteria
- [ ] Asset detail panel displays all specification fields correctly
- [ ] Inspection history shows complete and correctly sorted data
- [ ] Asset linking works during inspection creation and editing
- [ ] Linked assets display correctly in inspection detail
- [ ] Loading and error states render correctly
- [ ] Cached data refreshes when underlying data changes
