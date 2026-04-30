---
name: QA Review Loop
assignee: knowledgeforge-qa-strategist
project: null
recurring: true
metadata:
  paperclip:
    tags:
      - qa
      - review-loop
      - recurring
---

# QA Review Loop Task

## Purpose

This recurring task orchestrates the KnowledgeForge QA review loop, coordinating multiple agents to review PRs, generate tests, run linters, and gate deployments.

## Workflow

### 1. QA Strategy Phase (QA Strategist)

- Analyze the changes in the PR
- Identify affected components and risk areas
- Create or update the test strategy
- Assign test creation tasks

### 2. Architecture Review Phase (Arch Refactorer)

- Review code against architectural standards
- Identify pattern violations or technical debt
- Propose refactoring if needed
- Verify testability of changes

### 3. Discipline Mapping Phase (Discipline Strategist)

- Map changes to affected discipline workflows
- Identify cross-discipline impacts
- Flag any workflow-breaking changes

### 4. Sector Compliance Phase (Sector Analyst + Sector QA Lead)

- Apply sector-specific rules if applicable
- Generate sector compliance tests
- Verify regulatory requirements are met

### 5. Guardian Approval Phase (App Guardian)

- Run full compliance check
- Verify all tests pass
- Check documentation is complete
- Make approve/reject decision

### 6. Learning Phase (Failure Learner + ClieNT Integrator)

- Capture any failures for learning
- Extract successful patterns as skills
- Update knowledge base

## Assignment Chain

```
QA Strategist (primary)
  → Arch Refactorer (if architectural concerns)
  → Discipline Strategist (if workflow changes)
  → Sector Analyst (if sector-specific)
  → Sector QA Lead (if sector tests needed)
  → App Guardian (final approval)
  → Failure Learner (if failures occurred)
  → ClieNT Integrator (if patterns to extract)
```

## Triggers

- New PR created
- Significant code changes pushed
- Before scheduled releases
- After test failures

## Output

- QA review report with pass/fail decision
- Test strategy document
- Architecture compliance report
- Sector compliance verification (if applicable)
- List of extracted skills (if any)

## Approval Gate

This task includes an approval gate:
- **Auto-approve**: All checks pass, no sector compliance issues, low-risk changes
- **Require human review**: Sector compliance issues, high-risk changes, guardian rejection
- **Auto-reject**: Critical security issues, workflow-breaking changes, compliance failures