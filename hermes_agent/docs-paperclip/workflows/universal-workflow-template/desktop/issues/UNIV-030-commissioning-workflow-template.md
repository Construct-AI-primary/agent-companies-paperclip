---
id: UNIV-030
title: Commissioning Workflow Template
phase: Phase 4 — Commissioning & Handover
status: open
priority: high
---

# UNIV-030: Commissioning Workflow Template

## Description

Create universal commissioning workflow template covering testing, verification, documentation, and system handover processes.

**Context**: Commissioning ensures installed systems meet design specifications. Template must support various system types across all disciplines.

**Objectives**:
- Design commissioning workflow structure
- Create testing protocol templates
- Build verification and acceptance workflows
- Establish documentation requirements
- Enable 80-90% reusability across system types

**Scope**:
- In Scope: Create universal commissioning workflow template covering testing, verification, documentation, and ...
- Out of Scope: Implementation details for other workflows

## Acceptance Criteria

- [ ] Complete commissioning workflow template
- [ ] Testing protocol templates for major system types
- [ ] Verification workflow with acceptance criteria
- [ ] Documentation automation for commissioning reports
- [ ] Template tested with 3 different system types
- [ ] Reusability metric >80%
- [ ] Integration with quality management systems

## Assigned Company & Agent

- **Company:** QualityForge AI
- **Agent:** validator-qualityforge
- **Supporting:** DomainForge AI (mechanical-engineering-domainforge) for commissioning expertise

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **Target Files:**
  - docs-paperclip/disciplines/workflows/templates/commissioning/base-template.md
  - docs-paperclip/disciplines/workflows/templates/commissioning/testing-protocols.yaml
  - docs-paperclip/disciplines/workflows/templates/commissioning/verification-workflow.yaml
  - docs-paperclip/procedures/workflows/commissioning-procedure.md

## Required Skills

- `commissioning` (shared)
- `quality-validation` (shared)
- `testing-protocols` (shared)

## Dependencies

- BLOCKS: [UNIV-031] (This must complete before UNIV-031)
- BLOCKS: [UNIV-032] (This must complete before UNIV-032)
- BLOCKS: [UNIV-033] (This must complete before UNIV-033)

## Estimated Effort

- **Complexity**: complex
- **Estimated Hours**: 28-36
- **Timeline**: 5-6 days

## Paperclip Task Schema

```yaml
company: qualityforge-ai
agent: validator-qualityforge
toolsets:
  - file_tools
  - code_execution
  - terminal_tools
max_iterations: 100
priority: 2
```

## Technical Notes

**Implementation Approach**:
Commissioning ensures installed systems meet design specifications. Template must support various system types across all disciplines.

**Key Requirements**:
- Follow established patterns from previous workflows
- Ensure integration with existing systems
- Maintain consistency with universal workflow standards
- Document all customizations and configurations

## Success Validation

**How to verify completion**:
1. Review all acceptance criteria
2. Validate functionality with test scenarios
3. Collect feedback from stakeholders
4. Confirm integration with other workflows

**Expected Outcomes**:
- All acceptance criteria met
- Quality standards achieved
- Stakeholder approval received
- Ready for next workflow phase

---

**Created**: 2026-04-13
**Updated**: 2026-04-13
