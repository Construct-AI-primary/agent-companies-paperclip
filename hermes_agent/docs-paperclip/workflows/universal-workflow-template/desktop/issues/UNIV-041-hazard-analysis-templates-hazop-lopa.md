---
id: UNIV-041
title: Hazard Analysis Templates (HAZOP, LOPA)
phase: Phase 5 — Safety & Finalization
status: open
priority: high
---

# UNIV-041: Hazard Analysis Templates (HAZOP, LOPA)

## Description

Develop comprehensive hazard analysis templates for HAZOP (Hazard and Operability Study) and LOPA (Layer of Protection Analysis).

**Context**: HAZOP and LOPA are industry-standard hazard analysis methods. Templates must support structured methodology while enabling automation where possible.

**Objectives**:
- Create HAZOP worksheet templates and workflows
- Develop LOPA analysis templates with risk matrices
- Build automated guide word generation for HAZOP
- Implement risk calculation and SIL determination
- Establish team collaboration features

**Scope**:
- In Scope: Develop comprehensive hazard analysis templates for HAZOP (Hazard and Operability Study) and LOPA (L...
- Out of Scope: Implementation details for other workflows

## Acceptance Criteria

- [ ] HAZOP templates with complete guide word library
- [ ] LOPA templates with risk matrices and SIL calculation
- [ ] Automated guide word suggestion operational
- [ ] Risk calculation accuracy validated by safety experts
- [ ] Team collaboration features functional
- [ ] Templates tested with real hazard analysis scenarios
- [ ] User training materials created

## Assigned Company & Agent

- **Company:** DevForge AI
- **Agent:** codesmith-devforge
- **Supporting:** DomainForge AI (safety-domainforge-safety-risk-management, process-engineering-domainforge)

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **Target Files:**
  - docs-paperclip/disciplines/workflows/templates/safety/hazop/worksheet-template.md
  - docs-paperclip/disciplines/workflows/templates/safety/lopa/analysis-template.md
  - server/src/services/safety/hazop-guide-words.ts
  - server/src/services/safety/lopa-risk-calculator.ts
  - ui/src/components/safety/HazopWorksheet.tsx

## Required Skills

- `safety-analysis` (shared)
- `process-safety` (shared)
- `risk-assessment` (shared)

## Dependencies

- BLOCKED BY: [UNIV-040] (Must complete UNIV-040 first)

## Estimated Effort

- **Complexity**: complex
- **Estimated Hours**: 32-40
- **Timeline**: 5-6 days

## Paperclip Task Schema

```yaml
company: devforge-ai
agent: codesmith-devforge
toolsets:
  - file_tools
  - code_execution
  - terminal_tools
max_iterations: 100
priority: 2
```

## Technical Notes

**Implementation Approach**:
HAZOP and LOPA are industry-standard hazard analysis methods. Templates must support structured methodology while enabling automation where possible.

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
