---
title: PROCURE-TEST Project Implementation — 01900 Procurement Page Testing
description: Full implementation document consolidating all existing 01900 test resources with 15 new structured issues
author: QualityForge AI / DomainForge AI
date: 2026-04-28
version: 1.0
status: active
project_code: PROCURE-TEST
discipline: 01900 — Procurement
---

# PROCURE-TEST Project Implementation

## Project Overview

This project implements comprehensive quality assurance testing for the **01900 Procurement discipline page**, consolidating 7 existing test documents into a unified 5-phase framework with 15 structured issues, cross-company agent delegation, and real-time agent feedback monitoring.

## Existing Resources Consolidated

| Document | Source | Integration |
|----------|--------|-------------|
| `1900_PROCUREMENT_SYSTEM_TEST_REPORT.MD` | 01900 testing/ | Phase 5 baseline reference |
| `1900_TESTING_GUIDE_PROCUREMENT_ORDER_MODAL.MD` | 01900 testing/ | PROCURE-003, PROCURE-008 |
| `1900_LANGUAGE_TESTING_PLAN.MD` | 01900 testing/ | PROCURE-012 |
| `1900_TESTING_GUIDE_HANDOFF_SYSTEM.MD` | 01900 testing/ | PROCURE-011 |
| `1900_PROCUREMENT_WORKFLOW_TROUBLESHOOTING.MD` | 01900 testing/ | PROCURE-007 |
| `1900_PROCUREMENT_READINESS_DASHBOARD.MD` | 01900 testing/ | PROCURE-013a |
| `1900_PROCUREMENT_SKILLS_VALIDATION_REPORT.MD` | 01900 testing/ | PROCURE-013 |

## New Artifacts Generated

| Artifact | Path | Purpose |
|----------|------|---------|
| 15 issue files | `desktop/issues/PROCURE-001..014.md` | Structured test issues with delegation, goals, QC |
| 5 knowledge files | `knowledge/*.md` | Page metadata, agent delegation, RACI, heartbeat, bundle |
| Procedure | `procedures/testing/discipline-page-testing-procedure.md` | Reusable testing procedure for any discipline page |
| Findings doc | `doc/plans/2026-04-28-agent-spend-dashboard-findings.md` | Spend tracking analysis |
| Project docs | `README.md, project.md, plan.md` | Project overview, charter, execution plan |

## Cross-Company Integration

| Company | Integration Point |
|---------|------------------|
| **QualityForge AI** | Primary test execution (validator-qualityforge) |
| **DomainForge AI** | Subject matter expertise for procurement-specific issues |
| **InfraForge AI** | Database and API support (database-infraforge) |
| **KnowledgeForge AI** | Knowledge extraction and metadata bundle |

## Key Innovations

1. **Delegation embedded in every issue**: Each issue YAML includes `delegation` block with `parent_goal_id`, `delegation_prompt`, `allowed_sub_assignees`, `heartbeat_frequency`
2. **Three-level goals**: Company goal → Agent goal → Task goal in every issue
3. **8-field metadata extraction**: Per-component metadata (page_id, template_score, ui_buttons, supabase_schema, qc_checklist)
4. **Agent feedback loop**: PROCURE-013a uses Paperclip's ActivityEvent API for real-time agent monitoring, stall detection, and escalation
5. **Cross-company RACI**: Every issue has explicit R/A/C/I assignments across 4 companies

## Cross-Project Coordination: MEASURE-TENDER-004

### Interaction Issue
MEASURE-TENDER-004 creates 10 new React components inside `01900-procurement/components/subcontract-rfq/`. These share the same page directory as all components tested by PROCURE-TEST.

### Coordination Strategy: Build → Test Once

1. **MEASURE-TENDER-004 builds first** — New components are built inside the 01900 page directory
2. **PROCURE-TEST runs once** against the **final combined page** (existing 01900 components + new subcontract-rfq)
3. **No regression pass needed** — Single test pass validates exactly what ships to production

### Coordination Changes Made

| File | Change |
|------|--------|
| MEASURE-TENDER-004 issue | Added `depends_on: ["PROCURE-001"]` + Post-Build Coordination section |
| PROCURE-005 (Workspace) | Added Post-Build Coordination section for subcontract-rfq regression checks |
| PROCURE-009 (Suppliers) | Added Post-Build Coordination section for SubcontractorDirectory.js coexistence |
| PROCURE-012 (CSS Compliance) | Added Post-Build Coordination section for new component CSS verification |
| **PROCURE-015 (NEW)** | Dedicated issue for subcontract-rfq component testing with 13 sub-components |

### Execution Sequence
```
Step 1: MEASURE-TENDER-003 (API Routes) → Must complete first
Step 2: MEASURE-TENDER-004 builds → Subcontract-rfq components created
Step 3: PROCURE-001 through PROCURE-014 execute → All 01900 page + subcontract-rfq tested together
Step 4: PROCURE-015 executes → Dedicated subcontract-rfq validation
Step 5: PROCURE-014 captures results → Final sign-off on complete combined page
```

## Pre-Execution Requirements

- [ ] Remediate DomainForge procurement-director agent content (currently Dependency Manager)
- [ ] Verify activity log API at `/api/companies/qualityforge-ai/activity`
- [ ] Upload metadata bundle to QC-ROOT-PROCUREMENT-2026 issue
- [ ] Configure all agent heartbeat loops at 15min frequency
- [ ] Verify all 6 supabase tables accessible (correspondence, procurement_orders, vectors, timesheets, suppliers, tenders)
- [ ] MEASURE-TENDER-003 API routes must be operational before PROCURE-015
- [ ] MEASURE-TENDER-004 must complete before PROCURE-005 re-execution and PROCURE-015
