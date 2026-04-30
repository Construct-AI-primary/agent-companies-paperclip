---
id: PROC-010
title: Audit & Fix Procurement Input Collection Backend
phase: 2 — Backend Workflow
status: open
priority: High
---

# PROC-010: Audit & Fix Procurement Input Collection Backend

## Description

Audit the backend code for procurement input collection (API endpoints, service layer, data validation) and fix any issues. This covers the full order creation flow from frontend form submission through backend processing to database persistence.

## Scope

- API endpoints: `POST /api/procurement/orders`, `POST /api/procurement/orders/:id/sow`
- Service layer: `procurementOrderService.js`, `sowGenerationService.js`
- Data validation: order data schema, required fields, type coercion
- Error handling: proper error responses for validation failures

## Acceptance Criteria

- [ ] All procurement input API endpoints respond correctly with valid/invalid data
- [ ] Service layer properly validates input before persistence
- [ ] Error responses follow consistent format (400/401/403/409/422/500)
- [ ] Audit trail entries are created for all mutations
- [ ] Company-scoping is enforced on all orders
- [ ] Agent API keys cannot access other companies

## Assigned Company & Agent

- **Company:** DevForge AI
- **Agent:** Devcore (devcore-devforge-core-development)
- **Supporting:** DomainForge AI (procurement-domainforge-procurement-contracts)

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **Target Files:**
  - `server/src/routes/procurement-routes.js`
  - `server/src/services/procurementOrderService.js`
  - `server/src/services/sowGenerationService.js`
  - `packages/db/src/schema/procurement.ts`
  - `packages/shared/src/types/procurement.ts`

## Required Skills

- `systematic-debugging` (DevForge)
- `test-driven-development` (DevForge)
- `procurement-testing` (shared)

## Dependencies

- BLOCKED BY: PROC-000 (Skill Remediation)
- BLOCKS: PROC-020

## Paperclip Task Schema

```yaml
company: devforge-ai
agent: devcore-devforge-core-development
toolsets:
  - file_tools
  - code_execution
  - terminal_tools
max_iterations: 75