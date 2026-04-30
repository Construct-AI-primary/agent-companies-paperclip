---
id: PROC-001
title: Verify 01900 UI Modal E2E Flow
phase: 1 — UI/Coding
status: open
priority: Critical
---

# PROC-001: Verify 01900 UI Modal E2E Flow

## Description

Audit and fix the CreateOrderModal component to ensure the full 5-phase wizard works correctly end-to-end. This covers: Phase 1 (basic order info), Phase 2 (SOW template selection), Phase 3 (discipline assignment), Phase 4 (approval config), and Phase 5 (review/create).

## Current State

The modal implementation exists with test data injection capability. Testing guide available at `docs-construct-ai/disciplines/01900_procurement/testing/1900_TESTING_GUIDE_PROCUREMENT_ORDER_MODAL.MD`. Known issues to verify and fix:
- Projects not loading in dropdown
- Suppliers not loading
- SOW templates not filtering by order type
- Disciplines not loading in Phase 3
- Order creation failing on Phase 5 submission

## Acceptance Criteria

- [ ] All 5 phases of the modal navigate correctly
- [ ] Project dropdown populates with active projects
- [ ] Supplier dropdown populates with approved suppliers
- [ ] SOW templates load and filter by selected order type
- [ ] Discipline assignment works in Phase 3
- [ ] Approval matrix auto-generates based on order value
- [ ] Order creation succeeds with valid data
- [ ] Error feedback is displayed on failure
- [ ] Test data button populates form correctly

## Assigned Company & Agent

- **Company:** DevForge AI
- **Agent:** Forge (forge-devforge-system-architecture) — Architecture review
- **Agent:** Interface (interface-devforge-api-integration) — UI/API fix
- **Supporting:** QualityForge AI (e2e-qualityforge-end-to-end-testing) — E2E test execution
- **Supporting:** DomainForge AI (procurement-domainforge-procurement-contracts) — Domain validation

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **GitHub Repositories:** [GITHUB_EDIT: true]
  - **Primary Repository:** `https://github.com/Construct-AI-primary/construct_ai.git`
  - **Mobile Repository:** `https://github.com/Construct-AI-primary/construct_ai-mobile.git`
  - **Documentation Repository:** `https://github.com/Construct-AI-primary/docs-paperclip.git`
  - **Construct AI Docs Repository:** `https://github.com/Construct-AI-primary/construct_ai_docs.git`
- **Target Files:**
  - `ui/src/pages/01900-procurement/components/CreateOrderModal.jsx`
  - `ui/src/pages/01900-procurement/components/01900-procurement-page.js`
  - `server/src/routes/procurement-routes.js`
  - `server/src/services/procurementOrderService.js`

## Required Skills

- `systematic-debugging` (DevForge)
- `executing-plans` (DevForge)
- `procurement-testing` (shared)
- `e2e-qualityforge-end-to-end-testing` (QualityForge)

## Dependencies

- BLOCKED BY: PROC-000 (Skill Remediation)
- BLOCKS: PROC-020, PROC-040

## Paperclip Task Schema

```yaml
company: devforge-ai
agents:
  - forge-devforge-system-architecture
  - interface-devforge-api-integration
toolsets:
  - file_tools
  - code_execution
  - terminal_tools
max_iterations: 75