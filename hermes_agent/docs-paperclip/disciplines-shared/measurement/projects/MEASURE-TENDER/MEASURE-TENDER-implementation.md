---
title: MEASURE-TENDER Project Implementation — Multi-Type Procurement Tender System
description: Full implementation document consolidating all 7 structured issues for parallel-database procurement tendering
author: MeasureForge AI / DomainForge AI
date: 2026-04-28
version: 1.0
status: active
project_code: MEASURE-TENDER
discipline: Measurement — Procurement Tender System
parent_goal: MEASURE-ROOT-2026
---

# MEASURE-TENDER Project Implementation

## Project Overview

This project implements a **Multi-Type Procurement Tender System** using Option B (parallel tables) for builder procurement tendering across 4 distinct procurement types: Subcontracts (SUBCON), Purchase Orders (PO), Service Orders (SO), and Work Orders (WO). The implementation spans 7 structured issues across 4 phases with cross-company agent delegation and real-time agent feedback monitoring.

## Existing Resources

| Resource | Integration |
|----------|-------------|
| `01850_TENDER_INTEGRATION_SYSTEM.md` | Reusable patterns for integration service, API routes, health monitoring |
| `BUILDER-MEAS-009..013` | Workflow integration for BOQ disaggregation → subcontract award |
| `gov.za Tender Integration` | Proven architecture for portal sources, sync history, error logs, RLS policies |
| `01900-procurement/components/` | React component directory for subcontract-rfq UI |

## New Artifacts Generated

| Artifact | Path | Purpose |
|----------|------|---------|
| 7 issue files | `shared/issues/MEASURE-TENDER-001..005.md`, `web/issues/MEASURE-TENDER-006a..006b.md`, `desktop/issues/MEASURE-TENDER-004.md` | Structured implementation issues with delegation, goals, QC |
| 3 knowledge files | `knowledge/*.md` | Agent delegation, RACI, heartbeat monitoring |
| Project docs | `project.md`, `plan.md`, `MEASURE-TENDER-implementation.md` | Charter, execution plan, consolidated implementation doc |
| Status tracker | `desktop/issues/ISSUE-GENERATION-STATUS.md` | Issue inventory and status tracking |

## Cross-Company Integration

| Company | Integration Point |
|---------|------------------|
| **InfraForge AI** | Database schema, RLS policies, API routes (database-infraforge) |
| **DomainForge AI** | Integration service, UI domain logic, workflow orchestration, tender strategy |
| **Loopy AI** | External portal public pages and admin dashboard rendering |
| **QualityForge AI** | Cross-project coordination with PROCURE-TEST for UI component validation |

## 7 Issues Summary

### Phase 1: Infrastructure (2 issues, 26 story points)
| Issue | Title | Assignee | Priority | Story Points |
|-------|-------|----------|----------|--------------|
| MEASURE-TENDER-001 | Database Schema & RLS Policies | database-infraforge | Critical | 13 |
| MEASURE-TENDER-003 | API Routes & Authentication | database-infraforge | High | 13 |

### Phase 2: Core Services (1 issue, 21 story points)
| Issue | Title | Assignee | Priority | Story Points |
|-------|-------|----------|----------|--------------|
| MEASURE-TENDER-002 | Subcontract Integration Service | procurement-domainforge-procurement-contracts | High | 21 |

### Phase 3: UI & Integration (2 issues, 34 story points)
| Issue | Title | Assignee | Priority | Story Points |
|-------|-------|----------|----------|--------------|
| MEASURE-TENDER-004 | Sub-vendor Portal Manager UI | procurement-domainforge-procurement-contracts | Medium | 13 |
| MEASURE-TENDER-005 | BUILDER-MEAS Workflow Integration | procurement-domainforge-procurement-contracts | Critical | 21 |

### Phase 4: External Portal (2 issues, 34 story points)
| Issue | Title | Assignee | Priority | Story Points |
|-------|-------|----------|----------|--------------|
| MEASURE-TENDER-006a | External Portal — Public Pages | procurement-strategy-domainforge-procurement-strategy | High | 13 |
| MEASURE-TENDER-006b | External Portal — Admin Dashboard | loopy-ai | High | 21 |

**Total Story Points**: 115

## Key Innovations

1. **Delegation embedded in every issue**: Each issue YAML includes `delegation` block with `parent_goal_id`, `delegation_prompt`, `allowed_sub_assignees`, `heartbeat_frequency`
2. **Three-level goals**: Company goal → Agent goal → Task goal in every issue
3. **Option B parallel tables**: Security-separated database architecture with clean RLS policies from day 1
4. **Agent feedback loop**: Real-time agent monitoring, stall detection, and escalation via heartbeat polling
5. **Cross-company RACI**: Every issue has explicit R/A/C/I assignments across 4 companies
6. **Loopy AI integration**: External portal execution delegated to special-purpose automation agent

## Cross-Project Coordination: PROCURE-TEST

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
| PROCURE-015 | Dedicated issue for subcontract-rfq component testing with 13 sub-components |

### Execution Sequence

```
Step 1: MEASURE-TENDER-003 (API Routes) → Must complete first (prerequisite for integration)
Step 2: MEASURE-TENDER-001 (Database Schema) → Must complete before any data operations
Step 3: MEASURE-TENDER-002 (Integration Service) → Builds on database schema
Step 4: MEASURE-TENDER-004 builds → Subcontract-rfq components created in 01900 page directory
Step 5: MEASURE-TENDER-005 (Workflow Integration) → Connects BUILDER-MEAS workflows
Step 6: MEASURE-TENDER-006a (Public Portal) → External-facing tender publication
Step 7: MEASURE-TENDER-006b (Admin Dashboard) → Internal management interface
Step 8: PROCURE-TEST validates combined page → 01900 components + new subcontract-rfq
```

## Architecture Overview

### Parallel Tables Architecture (Option B)

```
┌─────────────────────────────────────────────────────────────────────┐
│ REUSABLE PATTERNS (Same Architecture, Parallel Tables)              │
├─────────────────────────────────────────────────────────────────────┤
│  procurement_portal_sources → subcontract_rfq_sync_history →        │
│  subcontract_rfq_error_logs → subcontract_rfqs →                    │
│  subcontractor_prequalification → quotation_comparisons             │
│                                                                     │
│  All tables follow naming convention: subcontract_* or              │
│  procurement_* for cross-type shared tables                        │
│                                                                     │
│  Security: Organization-scoped RLS policies on every table          │
│  Credential isolation: Separate encryption from gov.za portals      │
└─────────────────────────────────────────────────────────────────────┘
```

### Procurement Type Flow

| Type | Code | Key Tables | BUILDER-MEAS Link |
|------|------|------------|-------------------|
| Subcontracts | SUBCON | subcontract_rfqs, subcontractor_prequalification, quotation_comparisons | 009-013 |
| Purchase Orders | PO | procurement_portal_sources (shared), procurement-specific views | 001-004 |
| Service Orders | SO | procurement_portal_sources (shared), service-specific views | 003 |
| Work Orders | WO | procurement_portal_sources (shared), work-specific views | 004 |

## Pre-Execution Requirements

- [ ] Verify all 6 database tables accessible: procurement_portal_sources, subcontract_rfq_sync_history, subcontract_rfq_error_logs, subcontract_rfqs, subcontractor_prequalification, quotation_comparisons
- [ ] Configure all agent heartbeat loops at 15min frequency
- [ ] Verify activity log API at `/api/companies/{companyId}/activity`
- [ ] Upload knowledge bundle (agent delegation, RACI, heartbeat config) to knowledge directory
- [ ] Ensure MEASURE-ROOT-2026 parent goal exists in the system
- [ ] Coordinate with PROCURE-TEST team on MEASURE-TENDER-004 → PROCURE-TEST handoff sequence
- [ ] Verify Loopy AI agent is registered and accessible for MEASURE-TENDER-006b execution

---

**Version**: 1.0
**Date**: 2026-04-28
**Author**: MeasureForge AI / DomainForge AI
