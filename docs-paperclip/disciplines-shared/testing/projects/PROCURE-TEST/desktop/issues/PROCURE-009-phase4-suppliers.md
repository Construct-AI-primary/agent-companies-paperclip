---
id: PROCURE-009
title: 01900 Suppliers — Directory, Setup Modal, Contact Scraper & Card JSONs
description: Verify supplier directory pagination, setup modal CRUD, contact scraper extraction, and all 3 supplier card JSONs (STEELCO, CONCRETECO, ELECTRICO) function correctly
labels: ["testing", "procurement", "4 — Advanced Features"]
blocked_by: []
depends_on: ["PROCURE-001", "PROCURE-002"]
para_section: testing/projects/PROCURE-TEST/desktop/issues
phase: 4 — Advanced Features
status: todo
priority: Medium
story_points: 5
due_date: "2026-05-04"
assignee: supplier-management-domainforge-procurement
company: domainforge-ai
delegation:
  parent_goal_id: "QC-ROOT-PROCUREMENT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 01900 procurement page production readiness"
  agent_goal: "As supplier-management-domainforge-procurement, verify supplier directory, supplier setup modal, contact scraper, and all 3 supplier card JSONs function correctly"
  task_goal: "Execute supplier CRUD, contact scraping, card JSON validation with >85% pass rate"
---

# PROCURE-009: 01900 Suppliers — Directory, Setup Modal, Contact Scraper & Card JSONs

## Executive Summary
**Objective**: Validate all supplier-related components on the 01900 procurement page — directory pagination, setup modal CRUD, contact scraper extraction, and supplier card JSONs.

**Supplier Cards**: STEELCO_001, CONCRETECO_002, ELECTRICO_003
**Success Criteria**: >85% pass rate across all supplier components

## Required Actions

- **9A**: Supplier directory page loads and paginates correctly
- **9B**: Supplier setup modal — create, read, update, delete operations
- **9C**: Contact scraper — extraction from valid sources, error handling for invalid
- **9D**: Supplier card JSONs (STEELCO_001, CONCRETECO_002, ELECTRICO_003) load and render with correct data
- **9E**: Error handling for invalid supplier data (empty fields, duplicate names, invalid contact info)

## Assigned Company & Agent

- **Company:** DomainForge AI
- **Agent:** supplier-management-domainforge-procurement (Supplier Management Specialist)

## Required Skills

- `supplier-management-domain-knowledge` (DomainForge)
- `database-testing` (DomainForge)
- `api-testing` (DomainForge)

## Acceptance Criteria

- [ ] Supplier directory paginates and displays correctly
- [ ] Supplier CRUD operations persist to suppliers table
- [ ] Contact scraper extracts valid contact data
- [ ] All 3 supplier card JSONs load with correct fields
- [ ] Error states handled for invalid data
- [ ] No critical blocking issues identified

## Dependencies

- PROCURE-001 (Page Foundation) — page must load
- PROCURE-002 (Database Connectivity) — suppliers table must be accessible

## Estimated Duration

45 minutes

## Risk Level

Medium — suppliers are important but not blocking for other phases

## Post-Build Coordination (MEASURE-TENDER-004)

After MEASURE-TENDER-004 adds `SubcontractorDirectory.js` and `SubcontractorDetailModal.js` inside `01900-procurement/components/subcontract-rfq/`:

- [ ] Verify `SubcontractorDirectory.js` loads alongside existing supplier directory without conflicts
- [ ] Confirm subcontractor prequalification data (CIDB, B-BBEE, Safety) renders correctly alongside existing supplier card JSONs
- [ ] Check no duplicate data between `suppliers` table and `subcontractor_prequalification` table