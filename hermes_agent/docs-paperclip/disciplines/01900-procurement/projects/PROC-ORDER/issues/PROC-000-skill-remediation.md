---
id: PROC-000
title: Skill Remediation — Update DomainForge Procurement Skills
phase: 0 — Prerequisite
status: open
priority: Critical
---

# PROC-000: Skill Remediation — Update DomainForge Procurement Skills

## Description

Update the DomainForge procurement agent skills to explicitly reference the shared `procurement-testing` skill (located at `docs-paperclip/companies/domainforge-ai/shared/procurement-testing/SKILL.md`) and the 01900 workflow documentation.

## Problem

The following DomainForge procurement agents have generic skill descriptions that do not reference the 01900 workflow or the shared procurement-testing skill:

| Agent | Current Skill File | Issue |
|-------|-------------------|-------|
| `procurement-domainforge-procurement-contracts` | `procurement-domainforge-procurement-contracts/SKILL.md` | Generic — no 01900 reference |
| `procurement-analytics-domainforge-procurement-analytics` | `procurement-analytics-domainforge-procurement-analytics/SKILL.md` | Generic — no 01900 reference |
| `procurement-strategy-domainforge-procurement-strategy` | `procurement-strategy-domainforge-procurement-strategy/SKILL.md` | Generic — no 01900 reference |
| `supplier-management-domainforge-supplier-management` | `supplier-management-domainforge-supplier-management/SKILL.md` | Generic — no 01900 reference |

The shared `procurement-testing` skill is comprehensive (303 lines) but agents are not instructed to use it.

## Required Changes

For each of the 4 skill files above, update to include:
1. Reference to `shared/procurement-testing/SKILL.md` in the `related_skills` field
2. Reference to `docs-construct-ai/disciplines/01900_procurement/workflow_docs/` in the `related_docs` field
3. Updated description to mention 01900 procurement workflow testing

## Assigned Company & Agent

- **Company:** DevForge AI
- **Agent:** Devcore (devcore-devforge-core-development)
- **Supporting:** DomainForge AI (procurement-domainforge-procurement-contracts)

## Required Skills

- `systematic-debugging` (DevForge)
- `writing-skills` (DevForge)
- `procurement-testing` (shared — for reference only)

## Acceptance Criteria

- [ ] All 4 DomainForge procurement skill files updated with `procurement-testing` reference
- [ ] All 4 skill files include 01900 workflow documentation reference
- [ ] Skill descriptions explicitly mention 01900 procurement workflow testing context

## Related Issue Tickets

- **PROC-031:** Supplier Portal Integration (requires updated skills for implementation)
- **PROC-032:** Multi-Discipline Appendix Validation (requires updated skills for testing)
- **PROC-033:** Gantt Chart Integration Verification (requires updated skills for integration)
- **PROC-021:** Run Compliance Boundary Tests (requires updated skills for compliance testing)
- **PROC-011:** Verify HITL Manager Service Wiring (requires updated skills for HITL implementation)

## Dependencies

- BLOCKED BY: None (prerequisite task)
- BLOCKS: PROC-031, PROC-032, PROC-033, PROC-021, PROC-011

## Paperclip Task Schema

```yaml
company: devforge-ai
agent: devcore-devforge-core-development
toolsets:
  - file_tools
  - code_execution
max_iterations: 30
```

## Implementation Notes

1. **Skill File Structure:** Each DomainForge agent skill file should include:
   - `related_skills` array with path to `shared/procurement-testing/SKILL.md`
   - `related_docs` array with path to `docs-construct-ai/disciplines/01900_procurement/workflow_docs/`
   - Updated `description` field mentioning 01900 workflow context

2. **Shared Skill Reference:** The `procurement-testing` skill provides:
   - Comprehensive testing procedures for procurement workflows
   - Compliance boundary test scenarios
   - Integration testing patterns
   - HITL management guidelines

3. **Workflow Documentation:** The 01900 workflow docs provide:
   - Phase-based implementation guidance
   - Cross-company integration patterns
   - Compliance and approval workflows
   - Testing and validation procedures

## Verification Steps

1. Review each skill file for the required fields
2. Verify the shared skill path is correct and accessible
3. Confirm workflow documentation references are accurate
4. Test that agents can access and utilize the referenced skills
5. Validate that updated skills enable proper execution of related issue tickets

## Metrics

- **Success:** 4/4 skill files updated with proper references
- **Impact:** Enables implementation of 5+ related issue tickets (PROC-031, PROC-032, PROC-033, PROC-021, PROC-011)
- **Risk:** Low — prerequisite task with clear implementation steps

## Timeline

- **Estimated Duration:** 2-3 days
- **Priority:** Critical (blocks multiple other tickets)
- **Next Review:** After completion of all 4 skill file updates