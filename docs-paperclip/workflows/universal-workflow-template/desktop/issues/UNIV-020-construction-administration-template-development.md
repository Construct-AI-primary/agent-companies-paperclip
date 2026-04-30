---
id: UNIV-020
title: Construction Administration Template Development
phase: Phase 3 — Construction Administration
status: open
priority: high
---

# UNIV-020: Construction Administration Template Development

## Description

Create universal construction administration workflow template covering RFI management, submittal review, site observation, and change order processing.

**Context**: Construction administration is the 3rd universal workflow. All disciplines require CA capabilities during construction phase.

**Objectives**:
- Design CA workflow structure (RFI, submittals, observations, changes)
- Create template for each CA activity type
- Build routing and escalation logic
- Establish documentation standards
- Ensure 85-90% reusability across disciplines

**Scope**:
- In Scope: Create universal construction administration workflow template covering RFI management, submittal re...
- Out of Scope: Implementation details for other workflows

## Acceptance Criteria

- [ ] Complete CA workflow template with all activity types
- [ ] RFI response workflow with <48 hour target
- [ ] Submittal review workflow with approval tracking
- [ ] Site observation documentation templates
- [ ] Change order processing workflow
- [ ] Template tested with 3 discipline scenarios
- [ ] Reusability metric >85%

## Assigned Company & Agent

- **Company:** DevForge AI
- **Agent:** devcore-devforge
- **Supporting:** DomainForge AI (architectural-domainforge) for CA expertise

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **Target Files:**
  - docs-paperclip/disciplines/workflows/templates/construction-administration/base-template.md
  - docs-paperclip/disciplines/workflows/templates/construction-administration/rfi-workflow.yaml
  - docs-paperclip/disciplines/workflows/templates/construction-administration/submittal-workflow.yaml
  - docs-paperclip/procedures/workflows/construction-administration-procedure.md

## Required Skills

- `construction-administration` (shared)
- `workflow-design` (shared)

## Dependencies

- BLOCKS: [UNIV-021] (This must complete before UNIV-021)
- BLOCKS: [UNIV-022] (This must complete before UNIV-022)
- BLOCKS: [UNIV-023] (This must complete before UNIV-023)

## Estimated Effort

- **Complexity**: complex
- **Estimated Hours**: 28-36
- **Timeline**: 5-6 days

## Paperclip Task Schema

```yaml
company: devforge-ai
agent: devcore-devforge
toolsets:
  - file_tools
  - code_execution
  - terminal_tools
max_iterations: 100
priority: 2
```

## Technical Notes

**Implementation Approach**:
Construction administration is the 3rd universal workflow. All disciplines require CA capabilities during construction phase.

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
