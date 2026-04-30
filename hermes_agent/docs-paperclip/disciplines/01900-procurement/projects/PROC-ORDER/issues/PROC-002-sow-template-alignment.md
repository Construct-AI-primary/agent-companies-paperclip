---
id: PROC-002
title: Align SOW Template Selection Code with Document Ordering Management
phase: 1 — UI/Coding
status: open
priority: Critical
---

# PROC-002: Align SOW Template Selection Code with Document Ordering Management

## Description

Ensure the SOW template selection in Phase 2 of the CreateOrderModal is correctly aligned with the Document Ordering Management page configuration. The system should auto-select templates based on order type and complexity level, rather than requiring manual selection.

## Problem

The workflow docs indicate that template variations are selected during order creation, but the current implementation may have a gap between the Document Ordering Management configuration and the SOW generation step. Redundant template selection may occur — once during order creation (new flow) and once during SOW generation (legacy flow).

## Acceptance Criteria

- [ ] SOW template auto-selection based on order type works correctly
- [ ] Complexity level (simple/standard/complex/emergency/compliance) is preserved through order creation
- [ ] No duplicate template selection prompts between order creation and SOW generation
- [ ] Template metadata (complexity_level, workflow_metadata) is stored with the order
- [ ] Template validation against declared complexity level passes

## Assigned Company & Agent

- **Company:** DevForge AI
- **Agent:** Devcore (devcore-devforge-core-development)
- **Supporting:** DomainForge AI (procurement-domainforge-procurement-contracts)

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **Target Files:**
  - `docs-construct-ai/disciplines/01900_procurement/templates/`
  - `ui/src/pages/01900-procurement/components/CreateOrderModal.jsx`
  - `server/src/services/sowGenerationService.js`
  - Document ordering management integration files

## Required Skills

- `systematic-debugging` (DevForge)
- `writing-plans` (DevForge)
- `procurement-testing` (shared)

## Dependencies

- BLOCKED BY: PROC-000 (Skill Remediation)
- BLOCKS: PROC-010, PROC-020

## Paperclip Task Schema

```yaml
company: devforge-ai
agent: devcore-devforge-core-development
toolsets:
  - file_tools
  - code_execution
max_iterations: 60