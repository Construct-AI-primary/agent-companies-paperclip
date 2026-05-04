---
id: PREAWARD-005
title: "00425 Upsert State — Tender Creation & Pre-Qualification Form"
phase: "2 — State/Modals"
status: open
priority: High
blocked_by: []
depends_on: [PREAWARD-001, PREAWARD-002, PREAWARD-003]
---

# PREAWARD-005: 00425 Upsert State — Tender Creation & Pre-Qualification Form

## Executive Summary

Implement the Upsert state for the 00425 Pre-Award page. This state provides form interfaces for creating new tenders (from procurement requirements or blank), defining pre-qualification criteria, setting evaluation criteria and scoring matrices, and generating award recommendations.

## Problem Statement / Scope

Users need to create and manage tender packages, define pre-qualification criteria for supplier shortlisting, and configure evaluation frameworks. Currently there are no form interfaces for these operations. The Upsert state must provide multi-step forms with validation, draft saving, and submission workflows.

**Scope:**
- Tender creation form with fields for title, description, scope, value, type, dates
- Pre-qualification criteria form with compliance requirements
- Evaluation criteria and scoring matrix configuration form
- Award recommendation form with justification
- Multi-step wizard with progress indicator
- Draft auto-save and validation

## Required Actions

| # | Action | Agent Role | Expected Outcome |
|---|--------|------------|-----------------|
| 1 | Build tender creation form with all required fields | Codesmith DevForge | Users can create tenders with full details |
| 2 | Implement pre-qualification criteria form | DevCore DevForge | Users define supplier qualification requirements |
| 3 | Create evaluation criteria and scoring matrix form | Interface DevForge | Users configure weighted evaluation criteria |
| 4 | Build award recommendation form with justification | DomainForge AI | Users generate award recommendations |
| 5 | Implement multi-step wizard with progress indicator | Codesmith DevForge | Wizard guides users through form completion |

## Assigned Company & Agent

- **Company:** DevForge AI
- **Agent:** Codesmith (codesmith-devforge) — Tender form & wizard
- **Agent:** DevCore (devcore-devforge) — Pre-qualification form
- **Agent:** Interface (interface-devforge-api-integration) — Scoring matrix form
- **Supporting:** DomainForge AI (procurement-domainforge) — Award recommendation
- **Supporting:** QualityForge AI (validator-qualityforge) — Form validation

## Required Skills

- `form-development` (DevForge)
- `procurement-management` (DomainForge)
- `validation-logic` (DevForge)
- `scoring-matrix-design` (DomainForge)
- `pre-qualification` (DomainForge)

## Acceptance Criteria

- [ ] Tender creation form includes all required fields with validation
- [ ] Pre-qualification criteria form allows defining compliance requirements
- [ ] Evaluation criteria form supports weighted scoring with percentage allocation
- [ ] Scoring matrix validates that weights sum to 100%
- [ ] Award recommendation form includes justification text field
- [ ] Multi-step wizard shows progress indicator and navigates between steps
- [ ] Draft auto-save preserves form data on browser close
- [ ] Form validation displays inline error messages
- [ ] Successful submission creates/updates tender record in database
- [ ] Form can be pre-populated from procurement requirements (INT-001)

## Dependencies

- BLOCKED BY: PREAWARD-001, PREAWARD-002, PREAWARD-003
- BLOCKS: PREAWARD-007, PREAWARD-008, PREAWARD-009

## Estimated Duration

- **Estimated:** 6 days
- **Risk Level:** Medium

## QC Team Checks

- [ ] Code review completed by DomainForge AI
- [ ] Form validation tested with edge cases
- [ ] Draft auto-save reliability verified
- [ ] Cross-browser compatibility verified
- [ ] Unit tests for form validation logic
- [ ] Integration test for CRUD operations
