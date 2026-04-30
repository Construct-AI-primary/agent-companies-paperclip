---
delegation:
  parent_goal_id: "MEASURE-ROOT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Deliver MEASURE-TENDER subcontractor integration system"
title: "MEASURE-TENDER-002: Subcontract Integration Service"
description: "Implement subcontract-integration-service.js following the proven tender-integration-service.js pattern with parallel architecture"
gigabrain_tags: issue, measurement, tender, integration-service, nodejs, tender-integration, parallel-pattern
labels: ["measurement", "tender", "backend", "service"]
blocked_by: []
depends_on: ["MEASURE-TENDER-001"]
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/shared/issues
last_updated: 2026-04-25
status: backlog
phase: "2 — Core Development"
priority: High
story_points: 21
due_date: "2026-05-03"
assignee: procurement-domainforge-procurement-contracts
company: domainforge-ai
team: engineering
---

# MEASURE-TENDER-002: Subcontract Integration Service

## Executive Summary

Implement `subcontract-integration-service.js` — a parallel integration service for managing subcontractor portal sources and RFQ synchronization. This service follows the **same proven pattern** as `tender-integration-service.js` from the gov.za integration but operates on separate tables to maintain security isolation. The service handles four integration types (API, Email, Portal Scraping, Manual Entry) with a robust sync engine, health monitoring, and error recovery.

## Required Actions

| Action | Details |
|--------|---------|
| Implement service class | Create `SubcontractIntegrationService` with full lifecycle management |
| Source management | Add/update/remove subcontractor portal sources |
| Health monitoring | Continuous health checks for all configured sources |
| Sync management | Scheduled and on-demand RFQ synchronization |
| Error recovery | Retry logic with exponential backoff and circuit breaker |
| Metrics collection | Track sync performance and success rates |
| Create connectors | Build 4 connector types: API, Email, Portal Scraping, Manual Entry |
| Write unit tests | Core functionality coverage |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Assignee**: procurement-domainforge-procurement-contracts
- **Team**: engineering

## Required Skills

- Node.js / JavaScript
- REST API patterns and OAuth
- Database operations (PostgreSQL)
- Error handling and retry strategies
- Testing (Jest or similar)

## Acceptance Criteria

- [ ] Service initialized and health checks passing
- [ ] Source registration working (all 4 integration types)
- [ ] Sync operations complete without data loss
- [ ] Error recovery with retry logic functional
- [ ] Metrics collection for monitoring dashboards
- [ ] Integration with `subcontract_portal_sources` table
- [ ] Integration with `subcontract_rfqs` table
- [ ] Unit tests covering core functionality

## Dependencies

- MEASURE-TENDER-001: Database Schema must be complete
- References: `tender-integration-service.js` for pattern reference
- Node.js service (not React component)

## Estimated Duration

- **Story Points**: 21
- **Estimated Hours**: 16–20 hours
- **Due Date**: 2026-05-03

## Risk Level

Medium — follows established pattern from `tender-integration-service.js` but requires new connector types and parallel table architecture.

## QC Team Checks

- [ ] Code follows project patterns (tender-integration-service.js)
- [ ] All 4 connector types implemented
- [ ] Unit tests pass and cover edge cases
- [ ] Error recovery and circuit breaker verified
- [ ] No security isolation breaches via shared tables

---

**Issue Type**: Backend Service  
**Estimated Hours**: 16–20 hours  
**Agent Assignment**: procurement-domainforge-procurement-contracts (domainforge-ai)
