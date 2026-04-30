---
delegation:
  parent_goal_id: "MEASURE-ROOT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Deliver MEASURE-TENDER subcontractor integration system"
title: "MEASURE-TENDER-003: API Routes & Authentication"
description: "Create RESTful API routes for subcontractor RFQ management following the proven /api/tender-integration pattern"
gigabrain_tags: issue, measurement, tender, api-routes, restful, authentication, express
labels: ["measurement", "tender", "backend", "api"]
blocked_by: []
depends_on: ["MEASURE-TENDER-001", "MEASURE-TENDER-002"]
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/shared/issues
last_updated: 2026-04-25
status: backlog
phase: "2 — Core Development"
priority: High
story_points: 13
due_date: "2026-05-04"
assignee: procurement-domainforge-procurement-contracts
company: domainforge-ai
team: engineering
---

# MEASURE-TENDER-003: API Routes & Authentication

## Executive Summary

Create the RESTful API routes for the Subcontract Tender Integration System following the proven pattern from `/api/tender-integration/*`. These routes will enable frontend clients and agents to manage subcontractor portal sources, RFQs, and quotations with Bearer token authentication, organization scoping, and role-based access control.

## Required Actions

| Action | Details |
|--------|---------|
| Implement API route structure | 20+ endpoints under `/api/subcontract-rfq/*` |
| Bearer token auth | All routes require valid `Authorization: Bearer <token>` |
| Organization scoping | All queries filtered by `organization_id` from token |
| Role-based access | `procurement_officer`, `procurement_manager`, `admin` roles |
| Rate limiting | General: 100 req/min, Sync: 10 req/min, Bulk: 5 req/min |
| Error handling | Standardized error response format |
| Request validation | Joi/Zod schemas for all inputs |
| API documentation | OpenAPI/Swagger spec |
| Route handler pattern | Consistent try/catch with status codes |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Assignee**: procurement-domainforge-procurement-contracts
- **Team**: engineering

## Required Skills

- Express.js / Node.js
- RESTful API design
- JWT / Bearer token authentication
- Role-based access control (RBAC)
- Request validation (Joi / Zod)
- Rate limiting middleware

## Acceptance Criteria

- [ ] All 20+ API endpoints implemented
- [ ] Bearer token authentication enforced
- [ ] Organization scoping applied to all queries
- [ ] Role-based access control implemented
- [ ] Rate limiting configured
- [ ] Error responses standardized
- [ ] Request validation with Joi/Zod schemas
- [ ] API documentation (OpenAPI/Swagger)
- [ ] Unit tests for route handlers

## Dependencies

- MEASURE-TENDER-001: Database Schema complete
- MEASURE-TENDER-002: Integration Service must be complete
- Express.js server infrastructure
- Authentication middleware

## Estimated Duration

- **Story Points**: 13
- **Estimated Hours**: 12–16 hours
- **Due Date**: 2026-05-04

## Risk Level

Low — follows established `/api/tender-integration/*` pattern with standard Express.js middleware.

## QC Team Checks

- [ ] All 20+ routes respond correctly
- [ ] Bearer token rejection verified for unauthenticated requests
- [ ] Organization scoping tested with multi-tenant data
- [ ] Role-based access enforced for each role level
- [ ] Rate limiter triggers at configured thresholds
- [ ] Error responses match standard format
- [ ] Swagger/OpenAPI spec is current and accurate

---

**Issue Type**: Backend API  
**Estimated Hours**: 12–16 hours  
**Agent Assignment**: procurement-domainforge-procurement-contracts (domainforge-ai)
