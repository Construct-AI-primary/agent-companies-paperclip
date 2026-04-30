---
id: PROC-TEST-001
title: 01900 Procurement Workflow Testing Master Plan
phase: Phase 5 — Production Readiness
status: in_progress
priority: critical
assigneeAgentId: validator-qualityforge
parent: PROC-043
project: PROC-ORDER
---

# 01900 Procurement Workflow Testing Master Plan

## Executive Summary

This plan defines the structured testing approach for the **01900 Procurement Order Workflow**, orchestrated through the **Paperclip control plane** using the company ecosystem (Hermes agents via `hermes_local` adapter). The workflow spans the full procurement order lifecycle: UI modal interaction, SOW template selection, discipline assignment, approval routing, HITL review, compliance validation, and logistics processing.

**Current State:** The procurement domain is declared **10/10 ready** at the agent/skill level (readiness dashboard, 2026-03-31). All 12 skills are mapped, agents deployed, and domain knowledge validated. However, **no coordinated production-level workflow testing has been orchestrated** through Paperclip. This plan fills that gap.

## Workflow Phases Under Test

1. **Phase 1 — UI Modal Foundation**: CreateOrderModal (5-phase wizard: basic info, SOW template, discipline assignment, approval config, review/create)
2. **Phase 2 — SOW Generation**: AI-enhanced content creation with pre-selected template variations
3. **Phase 3 — Collaborative Development**: Multi-user appendix contributions with agent-aware task distribution
4. **Phase 4 — Approval & Finalization**: Integration with 01300 Approval Matrix, automated routing, document assembly
5. **Phase 5 — Logistics Processing**: Supply chain integration, supplier acknowledgment, GRN, invoicing

## Testing Phases

### Phase 0: Prerequisite — Skill Remediation
- **Issue:** PROC-000
- **Goal:** Update DomainForge procurement agent skills to reference the shared `procurement-testing` skill and 01900 workflow documentation
- **Lead:** DevForge AI (Devcore)
- **Why:** DomainForge procurement agents (`procurement-domainforge-procurement-contracts`, `procurement-analytics`, `procurement-strategy`, `supplier-management`) have generic skill descriptions that do not explicitly reference the 01900 workflow or the shared procurement-testing skill. The shared skill (303 lines) is excellent but agents need to be instructed to use it.

### Phase 1: UI/Coding Fixes (Critical Path)
- **Issues:** PROC-001, PROC-002, PROC-003
- **Goal:** Ensure the 01900 UI modal works correctly end-to-end, SOW template selection is aligned with Document Ordering Management, and Approval Matrix (01300) integration is complete
- **Lead:** DevForge AI (Forge, Interface, Devcore)
- **Supporting:** QualityForge (e2e testing), DomainForge (procurement validation)

### Phase 2: Backend Workflow Code Alignment (High Priority)
- **Issues:** PROC-010, PROC-011, PROC-012, PROC-013
- **Goal:** Audit and fix procurement input collection backend code, HITL manager wiring, agent orchestration service dispatch, and database schema alignment for procurement order extensions
- **Lead:** DevForge AI (Devcore, Forge, Automata, Reviewer)
- **Supporting:** DomainForge (procurement workflows)

### Phase 3: Testing Execution (High Priority)
- **Issues:** PROC-020, PROC-021, PROC-022, PROC-023
- **Goal:** Execute comprehensive testing using the shared `procurement-testing` skill — E2E workflows, compliance boundary tests, integration tests (order→approval→budget→audit), and data extraction accuracy
- **Lead:** QualityForge AI (e2e, validator, integration)
- **Supporting:** DomainForge (procurement domain expertise)

### Phase 4: Cross-Company Integration (High Priority)
- **Issues:** PROC-030, PROC-031, PROC-032, PROC-033
- **Goal:** KnowledgeForge indexing, supplier portal integration, multi-discipline appendix validation, and Gantt chart integration verification
- **Lead:** Mixed (KnowledgeForge, DomainForge, DevForge)
- **Supporting:** InfraForge (supply chain), QualityForge (simulation)

### Phase 5: Production Readiness (Critical)
- **Issues:** PROC-040, PROC-041, PROC-042, PROC-043
- **Goal:** Full end-to-end procurement simulation across all companies, testing summary report, readiness dashboard update, and UX copy review
- **Lead:** QualityForge AI (simulation), KnowledgeForge AI (reporting)
- **Supporting:** DevForge (dashboard), Loopy AI (UX copy)

## Company Distribution Summary

| Company | Lead Issues | Supporting Issues | Agents |
|---------|-------------|-------------------|--------|
| **DevForge AI** | 8 (PROC-000, 001-003, 010-013) + PROC-042 | 4 (PROC-022, 033, etc.) | Forge, Devcore, Interface, Automata, Reviewer |
| **QualityForge AI** | 5 (PROC-020, 021, 022, 023, 040) | 5 | e2e, validator, integration, simulator, reporter |
| **DomainForge AI** | 3 (PROC-010, 031, 032) | 9 | procurement, procurement-analytics, supplier-mgmt |
| **KnowledgeForge AI** | 2 (PROC-030, 041) | 0 | Doc Analyzer, Doc Reporter |
| **InfraForge AI** | 1 (PROC-031) | 1 | Supply Chain Integration specialist |
| **Loopy AI** | 1 (PROC-043) | 0 | Maya (content strategist), Dev (technical creative) |

## Key Skills Referenced

| Skill | Source | Purpose |
|-------|--------|---------|
| `procurement-testing` | DomainForge (shared) | Comprehensive procurement workflow testing (303 lines) |
| `testing-verification` | Construct AI (shared) | General testing methodology |
| `workflow-implementation` | Construct AI (shared) | Workflow implementation patterns |
| `construct-ai-workflow` | Construct AI (shared) | Construct-AI workflow orchestration |
| `systematic-debugging` | Construct AI (shared) | Structured debugging (DevForge) |
| `test-driven-development` | Construct AI (shared) | TDD implementation (DevForge) |

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| DomainForge procurement skills not updated before testing | High — agents lack context | PROC-000 blocks all Phase 1-3 issues |
| 01300 Approval Matrix integration not complete | Critical — workflow cannot proceed | PROC-003 must pass before Phase 3 |
| HITL manager not wired to procurement workflow | High — compliance gaps | PROC-011 must pass before Phase 3 |
| No test data available for procurement scenarios | Medium | Shared procurement-testing skill includes test data templates |

## Success Criteria

- [ ] All 24 issues completed with acceptance criteria met
- [ ] Zero compliance bypasses found in procurement workflow
- [ ] 100% workflow path coverage tested
- [ ] Authority limits, budget blocks, and audit trail logging verified
- [ ] Procurement Readiness Dashboard updated to reflect new test results
- [ ] Full testing summary report published by KnowledgeForge AI

## Next Steps

1. Paperclip board operator creates all 24 issues from the issue files in `issues/`
2. PROC-000 is assigned to DevForge and executed first
3. Phase 1-5 issues are released according to dependency graph
4. QualityForge executes testing in Phase 3
5. Full simulation in Phase 5 validates end-to-end readiness