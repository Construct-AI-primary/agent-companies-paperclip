---
id: PROC-020
title: Execute Procurement E2E Tests
phase: 3 — Testing Execution
status: open
priority: High
---

# PROC-020: Execute Procurement E2E Tests

## Description

Execute comprehensive end-to-end tests for the 01900 procurement workflow using the shared `procurement-testing` skill. This covers the full order lifecycle: order creation → SOW generation → approval → delivery → invoicing → payment → closure.

## Test Scenarios

From the procurement-testing skill:
- Scenario 1: Standard Order Creation (<$25k single approval)
- Scenario 2: High-Value Order with Multi-Level Approval (>$100k)
- Scenario 3: Rejection and Rework
- Scenario 4: Compliance Boundary Testing (no budget, over limit, self-approval)

## Acceptance Criteria

- [ ] All 4 test scenarios execute successfully
- [ ] No workflow step fails with unexpected errors
- [ ] Order status transitions are correct throughout
- [ ] Audit trail log is complete and accurate
- [ ] Test results documented with pass/fail for each step

## Assigned Company & Agent

- **Company:** QualityForge AI
- **Agent:** e2e-qualityforge-end-to-end-testing
- **Supporting:** DomainForge AI (procurement-domainforge-procurement-contracts)

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **Target Files:**
  - `docs-construct-ai/disciplines/01900_procurement/testing/`
  - `ui/src/pages/01900-procurement/components/`
  - `server/src/routes/procurement-routes.js`
  - `server/src/services/procurementOrderService.js`
  - Test data and configuration files

## Required Skills

- `procurement-testing` (shared)
- `testing-verification` (shared)
- `e2e-qualityforge-end-to-end-testing` (QualityForge)

## Dependencies

- BLOCKED BY: PROC-001, PROC-002, PROC-003, PROC-010, PROC-011, PROC-012, PROC-013

## Paperclip Task Schema

```yaml
company: qualityforge-ai
agent: e2e-qualityforge-end-to-end-testing
toolsets:
  - file_tools
  - code_execution
  - terminal_tools
max_iterations: 75