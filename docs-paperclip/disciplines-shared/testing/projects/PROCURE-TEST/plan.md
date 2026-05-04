---
title: PROCURE-TEST Implementation Plan
description: 5-phase test execution plan for 01900 Procurement page validation with cross-company agent delegation
author: QualityForge AI / DomainForge AI
date: 2026-04-28
version: 1.0
status: active
project_code: PROCURE-TEST
discipline: 01900 — Procurement
---

# PROCURE-TEST Implementation Plan

## Executive Summary

This plan details the systematic execution of 15 testing issues across 5 phases to validate the 01900 Procurement page for production readiness. Execution spans QualityForge AI (lead), DomainForge AI (domain expertise), InfraForge AI (database support), and KnowledgeForge AI (knowledge extraction).

**Goals:**
- Execute all 15 testing issues in proper dependency order
- Achieve Phase 1 100% pass rate, Phase 2-3 >90%, Phase 4 >85%, Phase 5 go/no-go
- Generate comprehensive testing reports and production readiness assessment
- Validate agent delegation heartbeat loop and feedback mechanisms

## Strategic Objectives

1. **Systematic Testing**: Execute all 15 issues in proper sequence across 5 phases
2. **Quality Validation**: Ensure all 01900 page components function correctly
3. **Production Readiness**: Validate page stability and identify any blocking issues
4. **Agent Visibility**: Implement real-time agent activity monitoring via feedback loop
5. **Cross-Company Collaboration**: Enforce DomainForge expertise in domain-specific checks

## 5-Phase Testing Framework

### Phase 1: Foundation (2 issues) — 100% pass threshold
**Purpose**: Establish page stability before any feature testing

| Issue | Title | Assignee | Duration | QC Focus |
|-------|-------|----------|----------|----------|
| PROCURE-001 | 01900 Page Foundation — Login, Nav & Logout | validator-qualityforge | 30min | Auth, nav container, state buttons, logout, background image |
| PROCURE-002 | 01900 Database & API Connectivity | database-infraforge | 30min | Supabase connectivity, schema, CRUD, hnsw indexes |

**Success criteria**: 100% pass rate, 0 critical issues
**Gate keeper**: validator-qualityforge

### Phase 2: State Buttons & Modals (3 issues) — >95% pass threshold
**Purpose**: Validate all interactive components across page states

| Issue | Title | Assignee | Duration | QC Focus |
|-------|-------|----------|----------|----------|
| PROCURE-003 | 01900 Agents State — Correspondence & Create Order | validator-qualityforge | 45min | 2 agents buttons, modal open/close, form validation, submission |
| PROCURE-004 | 01900 Upserts State — Cloud, URL & File | validator-qualityforge + database-infraforge | 45min | 3 upsert buttons, Cloud→insert, URL→fetch+insert, File→parse+insert |
| PROCURE-005 | 01900 Workspace State — All 7 Modals | validator-qualityforge | 60min | 7 workspace buttons, Timesheet validation, Supplier CRUD, Vector ops |

**Success criteria**: >95% pass rate, 0 critical issues
**Gate keeper**: validator-qualityforge

### Phase 3: Integration (3 issues) — >90% pass threshold
**Purpose**: Validate cross-component integrations, chatbot, workflows, templates

| Issue | Title | Assignee | Duration | QC Focus |
|-------|-------|----------|----------|----------|
| PROCURE-006 | 01900 Chatbot — HITL & Confidence Thresholds | validator-qualityforge | 45min | Chatbot theme, citations, HITL threshold=0.7, history persistence |
| PROCURE-007 | 01900 Workflow Orchestrator | procurement-domainforge-procurement-contracts | 45min | Approval chain, order workflow, SOW workflow, error handling |
| PROCURE-008 | 01900 Templates — PO/SO/WO/SOW + Appendices | procurement-domainforge-procurement-contracts | 60min | All 4 order templates, 6 appendices (A-F), compliance rules, JSON validation |

**Success criteria**: >90% pass rate, ≤1 critical issue
**Gate keeper**: procurement-domainforge-procurement-contracts

### Phase 4: Advanced Features (3 issues) — >85% pass threshold
**Purpose**: Validate domain-specific features and integrations

| Issue | Title | Assignee | Duration | QC Focus |
|-------|-------|----------|----------|----------|
| PROCURE-009 | 01900 Suppliers — Directory, Setup & Contact Scraper | supplier-management-domainforge-procurement | 45min | Supplier directory, setup modal, contact scraper, card JSONs (STEELCO, CONCRETECO, ELECTRICO) |
| PROCURE-010 | 01900 Tenders — Management & Search | procurement-strategy-domainforge-procurement-strategy | 45min | Tender creation, search, filters, document loading |
| PROCURE-011 | 01900 Integrations — VDB, Cross-Discipline Sharing, Doc Retrieval | validator-qualityforge + database-infraforge | 45min | Vector insert→hnsw query, permission matrix, doc retrieval, index policies |

**Success criteria**: >85% pass rate, ≤2 critical issues
**Gate keeper**: DomainForge procurement lead

### Phase 5: Compliance & Sign-off (4 issues) — Go/No-go
**Purpose**: Final compliance validation, agent delegation testing, feedback loop, go/no-go

| Issue | Title | Assignee | Duration | QC Focus |
|-------|-------|----------|----------|----------|
| PROCURE-012 | 01900 UX/Compliance — CSS, EPCM, Accessibility | validator-qualityforge | 45min | CSS class names (A-01900-*), grid layout, page standardization, responsive breakpoints, ARIA labels |
| PROCURE-013 | 01900 Agent Delegation — CEO→Subordinate Heartbeat Validation | domainforge-ai-procurementdirector | 45min | CEO→subordinate delegation, heartbeat loop, status propagation, approval chain |
| PROCURE-013a | Agent Feedback Loop — Live Monitoring & Escalation | validator-qualityforge | 45min | Activity log polling, stall detection (30min), status aggregation, escalation |
| PROCURE-014 | 01900 Production Readiness — Final Sign-off | validator-qualityforge + ALL | 30min | Aggregate results, readiness dashboard, go/no-go recommendation |

**Success criteria**: Go/no-go recommendation with documented rationale
**Gate keeper**: CEO (domainforge-ai-procurementdirector + qualityforge-ceo)

## Timeline Estimate

| Phase | Issues | Est. Duration | Cumulative Time |
|-------|--------|---------------|-----------------|
| Phase 1: Foundation | 2 | 1 hour | 1 hour |
| Phase 2: State/Modals | 3 | 2.5 hours | 3.5 hours |
| Phase 3: Integration | 3 | 2.5 hours | 6 hours |
| Phase 4: Advanced | 3 | 2.25 hours | 8.25 hours |
| Phase 5: Compliance | 4 | 2.75 hours | 11 hours |
| **Total** | **15** | **~11 hours** | **(over 2-3 days)** |

## Risk Management

### Technical Risks
| Risk | Impact | Mitigation |
|------|--------|------------|
| Test environment instability | High | Automated provisioning, documented recovery steps |
| API service failures (OpenAI, Supabase) | High | Service mocking, retry mechanisms |
| Database connectivity issues | Critical | Connection pooling, failover strategies |
| Missing page components | Medium | Knowledge metadata extraction before Phase 1 |

### Operational Risks
| Risk | Impact | Mitigation |
|------|--------|------------|
| Timeline pressure | Medium | Phased approach, parallel execution where safe |
| Agent unavailability | High | Backup agents identified in RACI matrix |
| DomainForge procurement-director wrong content | High | Remediate before PROCURE-013 execution |
| Feedback loop not configured | Medium | PROCURE-013a creates config before Phase 5 |

## Dependencies

### Internal Dependencies
- **Agent Availability**: All assigned agents must be active
- **Environment Access**: Production testing environment properly configured
- **Metadata Extraction**: 8-field metadata extracted before Phase 1
- **Feedback Loop Setup**: Heartbeat config created before Phase 5

### External Dependencies
- **Service Availability**: OpenAI API, Supabase, external services operational
- **Browser Support**: Modern browser for testing
- **Network Connectivity**: Stable internet for API testing

## Phase Gates

| Gate | Entry Criteria | Pass Criteria | Gate Keeper |
|------|---------------|--------------|-------------|
| Gate 1 → Phase 2 | All Phase 1 issues resolved | 100% pass rate, 0 critical | validator-qualityforge |
| Gate 2 → Phase 3 | All Phase 2 issues resolved | >95% pass rate, 0 critical | validator-qualityforge |
| Gate 3 → Phase 4 | All Phase 3 issues resolved | >90% pass rate, ≤1 critical | procurement-domainforge-procurement-contracts |
| Gate 4 → Phase 5 | All Phase 4 issues resolved | >85% pass rate, ≤2 critical | DomainForge lead |
| Gate 5 → Complete | All Phase 5 issues resolved | Go/no-go recommendation | CEO |

---

## Status Tracking

### Pre-Execution Verification — API Health Check (2026-05-03)

**Objective**: Verify construct_ai app API endpoints are operational before executing PROCURE-TEST issues.

**Method**: 6 batches of automated curl tests against `http://localhost:3060` covering ~110+ endpoints across all route modules.

**Result**: 5 of 8 pre-existing bugs fixed via migration. 3 pre-existing issues remain (non-blocking for Phase 1).

#### ✅ Fixed (5) — Migration `20260503_fix_missing_tables.sql`

| # | Endpoint | Before | After | Fix |
|---|----------|--------|-------|-----|
| 1 | `GET /api/agent-names` | ❌ 500 | ✅ 200 | Created `agent_names` table |
| 2 | `GET /api/hsse-evaluations` | ❌ 500 | ✅ 200 | Created `hsse_supplier_evaluations` table |
| 3 | `GET /api/privacy/preferences` | ❌ 500 | ✅ 200 | Created `privacy_user_preferences` table |
| 4 | `GET /api/privacy/consent` | ❌ 500 | ✅ 200 | Created `privacy_consent_records` table |
| 5 | `GET /api/privacy/jurisdiction` | ❌ 500 | ✅ 200 | Created `privacy_jurisdiction_settings` table |

#### ⚠️ Remaining (3) — Pre-existing, Non-Blocking

| # | Endpoint | Status | Root Cause | Workaround |
|---|----------|--------|------------|------------|
| 6 | `GET /api/agent-modal` | ❌ 500 | Uses Supabase join syntax (`agent_names(name)`, `modal_configurations(display_name)`, `pages(page_name)`) requiring FK relationships to tables that may not exist | Not blocking Phase 1; address before Phase 2 if agent-modal testing required |
| 7 | `POST /api/contractor-auth/login` | ❌ 500 | `authenticate_contractor()` function references `external_party_users` table which doesn't exist in this Supabase project. Migration `02401_external_party_users.sql` exists but hasn't been run | Not blocking Phase 1; run migration before contractor auth testing |
| 8 | `GET /api/schema/policies` | ❌ 500 | Uses `supabase.rpc('exec_sql', ...)` to query `pg_policies` system catalog. The `exec_sql` RPC function is not available in this Supabase project | Not blocking Phase 1; schema policies are informational only |

#### ✅ Verified Working — Core Routes for Phase 1

| Route Group | Status | Notes |
|-------------|--------|-------|
| Auth (`/api/auth/login`, `/api/auth/me`) | ✅ 200 | Login + session verification operational |
| Pages (`/api/pages`) | ✅ 200 | Page listing and metadata available |
| Document Management | ✅ 200 | CRUD operations operational |
| Procurement | ✅ 200 | All procurement routes operational |
| Suppliers | ✅ 200 | Supplier directory and CRUD operational |
| Approvals | ✅ 200 | Approval chain operational |
| Chatbot | ✅ 200 | Chat and streaming operational |
| Tender Integration | ✅ 200 | Tender routes operational |
| Security Dashboard (×5) | ✅ 200 | All security endpoints operational |
| AI Monitoring (×6) | ✅ 200 | All monitoring endpoints operational |
| Testing Dashboard | ✅ 200 | Test-runner, test-metadata, workflow-tests operational |
| Workflows | ✅ 200 | Workflow orchestration operational |
| Unified Templates/History | ✅ 200 | Template and history routes operational |

#### Migration Details

**File**: `/Users/PROC-TEST/construct_ai/database/migrations/20260503_fix_missing_tables.sql`
**Target**: `construct-ai-project` Supabase (`mseizswoiwyewsidknta.supabase.co`)
**Created**: 2026-05-03
**Contents**: 11 objects — `agent_names`, `agent_modal_assignments`, `privacy_user_preferences`, `privacy_consent_records`, `privacy_jurisdiction_settings`, `privacy_audit_log`, `privacy_data_subject_requests`, `privacy_breach_incidents`, `authenticate_contractor()` function, `hsse_supplier_evaluations`, `vetting_workflow_weights` — all with RLS policies.

#### Supabase Project Architecture

| Project | URL | Purpose |
|---------|-----|---------|
| **construct-ai-project** | `mseizswoiwyewsidknta.supabase.co` | Main app database — all construct_ai tables |
| **paperclip-ai** | (separate project) | Paperclip agent orchestration, testing, coding workflows |

The construct_ai app connects to **construct-ai-project**. Paperclip/OpenClaw agents are organized in **paperclip-ai** for testing and coding workflows. Future re-organization of agents in construct-ai-project may be needed.

---

**Plan Version**: 1.1
**Date**: 2026-05-03
**Author**: Paperclip QA Team
**Last Updated**: 2026-05-03 — Added Status Tracking section with API verification results
