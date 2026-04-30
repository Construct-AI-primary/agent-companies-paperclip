---
title: MEASURE-TENDER Implementation Plan
description: 4-phase implementation plan for Multi-Type Procurement Tender System with cross-company agent delegation
author: MeasureForge AI / DomainForge AI
date: 2026-04-28
version: 1.0
status: active
project_code: MEASURE-TENDER
discipline: Measurement — Procurement Tender System
parent_goal: MEASURE-ROOT-2026
---

# MEASURE-TENDER Implementation Plan

## Executive Summary

This plan details the systematic implementation of 7 issues across 4 phases to build a Multi-Type Procurement Tender System using Option B (parallel tables) architecture. Execution spans InfraForge AI (database infrastructure), DomainForge AI (domain expertise and integration), Loopy AI (external portal), and QualityForge AI (cross-project coordination).

**Goals:**
- Implement all 6 parallel database tables with organization-scoped RLS policies
- Build subcontract integration service with health monitoring
- Create API routes with authentication for all procurement types
- Develop sub-vendor portal manager UI within the 01900 procurement page
- Integrate with BUILDER-MEAS workflows (009–013)
- Deploy external tender portal (public pages + admin dashboard)
- Coordinate with PROCURE-TEST for combined page validation

## Strategic Objectives

1. **Secure Database Foundation**: Implement parallel tables with credential isolation and clean RLS
2. **Robust Integration Layer**: Build reusable integration service pattern from proven gov.za architecture
3. **Comprehensive UI**: Create sub-vendor portal manager with full CRUD capabilities
4. **Workflow Automation**: Connect BUILDER-MEAS workflows for end-to-end tender lifecycle
5. **External Access**: Deploy public portal for subcontractor registration and tender search

## 4-Phase Implementation Framework

### Phase 1: Infrastructure (2 issues) — Gate 1: Schema validated, API endpoints responding

**Purpose**: Establish database foundation and API layer before any service logic

| Issue | Title | Assignee | Duration | QC Focus |
|-------|-------|----------|----------|----------|
| MEASURE-TENDER-001 | Database Schema & RLS Policies | database-infraforge | 2-3 hours | 6 parallel tables, RLS policies, indexes, credential isolation |
| MEASURE-TENDER-003 | API Routes & Authentication | database-infraforge | 2-3 hours | RESTful endpoints, JWT auth, rate limiting, error handling |

**Success criteria**: 100% schema validation, all RLS policies tested, API health check passes
**Gate keeper**: database-infraforge

### Phase 2: Core Services (1 issue) — Gate 2: Service operational with health monitoring

**Purpose**: Build the core integration service that connects portal sources to the database

| Issue | Title | Assignee | Duration | QC Focus |
|-------|-------|----------|----------|----------|
| MEASURE-TENDER-002 | Subcontract Integration Service | procurement-domainforge-procurement-contracts | 3-4 hours | Sync engine, error handling, retry logic, health monitoring, metrics |

**Success criteria**: Service starts successfully, sync cycle completes, error logging works
**Gate keeper**: procurement-domainforge-procurement-contracts

### Phase 3: UI & Integration (2 issues) — Gate 3: UI operational with workflow integration

**Purpose**: Build the user interface and connect BUILDER-MEAS workflows

| Issue | Title | Assignee | Duration | QC Focus |
|-------|-------|----------|----------|----------|
| MEASURE-TENDER-004 | Sub-vendor Portal Manager UI | procurement-domainforge-procurement-contracts + loopy-ai | 3-4 hours | React components, CRUD operations, data tables, responsive design |
| MEASURE-TENDER-005 | BUILDER-MEAS Workflow Integration | procurement-domainforge-procurement-contracts | 3-4 hours | BOQ disaggregation → RFQ generation, trade package mapping, award flow |

**Success criteria**: UI renders all data, workflows trigger correctly, no regression on 01900 page
**Gate keeper**: procurement-domainforge-procurement-contracts

### Phase 4: External Portal (2 issues) — Gate 4: Portal live, admin dashboard functional

**Purpose**: Deploy external-facing portal and internal admin dashboard

| Issue | Title | Assignee | Duration | QC Focus |
|-------|-------|----------|----------|----------|
| MEASURE-TENDER-006a | External Portal — Public Pages | procurement-strategy-domainforge-procurement-strategy + loopy-ai | 2-3 hours | Tender listing, search, registration, document download |
| MEASURE-TENDER-006b | External Portal — Admin Dashboard | loopy-ai | 2-3 hours | Source management, sync controls, metrics, user management |

**Success criteria**: Public pages accessible externally, admin dashboard operational, metrics displayed
**Gate keeper**: measurement-ceo

## Timeline Estimate

| Phase | Issues | Est. Duration | Cumulative Time |
|-------|--------|---------------|-----------------|
| Phase 1: Infrastructure | 2 | 5 hours | 5 hours |
| Phase 2: Core Services | 1 | 4 hours | 9 hours |
| Phase 3: UI & Integration | 2 | 7 hours | 16 hours |
| Phase 4: External Portal | 2 | 5 hours | 21 hours |
| **Total** | **7** | **~21 hours** | **(over 3-4 days)** |

## Phase Gates

| Gate | Entry Criteria | Pass Criteria | Gate Keeper |
|------|---------------|--------------|-------------|
| Gate 1 → Phase 2 | All Phase 1 issues resolved | Schema validated, API endpoints responding | database-infraforge |
| Gate 2 → Phase 3 | Phase 2 issue resolved | Service operational with health monitoring | procurement-domainforge-procurement-contracts |
| Gate 3 → Phase 4 | All Phase 3 issues resolved | UI operational, workflows integrated | procurement-domainforge-procurement-contracts |
| Gate 4 → Complete | All Phase 4 issues resolved | Portal live, admin dashboard functional | measurement-ceo |

## Risk Management

### Technical Risks
| Risk | Impact | Mitigation |
|------|--------|------------|
| Schema migration conflicts with existing tables | High | Naming convention review, parallel table isolation |
| API service failures (Supabase, external portals) | High | Service mocking, retry mechanisms, timeout config |
| RLS policy leakage across tender types | Critical | Clean RLS from day 1, audit logging |
| Loopy AI agent unavailability | Medium | Fallback to manual deployment, documented recovery steps |

### Operational Risks
| Risk | Impact | Mitigation |
|------|--------|------------|
| Timeline pressure | Medium | Phased approach with clear gate criteria |
| Cross-project dependency on PROCURE-TEST | Medium | Build → Test Once coordination strategy documented |
| DomainForge procurement-director wrong content | High | Remediate before Phase 3 execution |
| External portal rate limiting from tender sources | Medium | Configurable rate limits per source |

## Dependencies

### Internal Dependencies
- **Phase 1 → Phase 2**: Database schema must be deployed before integration service
- **Phase 2 → Phase 3**: Integration service must be operational before UI can display data
- **Phase 3 → Phase 4**: BUILDER-MEAS workflows must be integrated before external portal can reference RFQs
- **Agent Availability**: All assigned agents must be active
- **Environment Access**: Development/QA environment properly configured

### External Dependencies
- **Service Availability**: Supabase, external portal APIs operational
- **Browser Support**: Modern browser for UI testing
- **Network Connectivity**: Stable internet for API testing
- **PROCURE-TEST Coordination**: MEASURE-TENDER-004 build completed before PROCURE-TEST Phase 2 re-execution

## Execution Order

```
Phase 1 ──────────────────────┐
  MEASURE-TENDER-001 (DB) ────┤
  MEASURE-TENDER-003 (API) ───┤
                               ▼
Phase 2 ──────────────────────┐
  MEASURE-TENDER-002 (Svc) ───┤
                               ▼
Phase 3 ──────────────────────┐
  MEASURE-TENDER-004 (UI) ────┤──── PROCURE-TEST coordination
  MEASURE-TENDER-005 (WF) ────┤
                               ▼
Phase 4 ──────────────────────┐
  MEASURE-TENDER-006a (Pub) ──┤
  MEASURE-TENDER-006b (Admin) ─┤
                               ▼
                    MEASURE-ROOT-2026 Complete
```

---

**Plan Version**: 1.0
**Date**: 2026-04-28
**Author**: MeasureForge AI / DomainForge AI
