---
name: Knowledge Engineering
description: App-focused knowledge management and QA strategy
schema: agentcompanies/v1
slug: knowledge-engineering
manager: ../../agents/knowledgeforge-doc-analyzer/AGENTS.md
includes:
  - ../../agents/knowledgeforge-qa-strategist/AGENTS.md
  - ../../agents/knowledgeforge-arch-refactorer/AGENTS.md
  - ../../agents/knowledgeforge-failure-learner/AGENTS.md
  - ../../agents/knowledgeforge-clinet-integrator/AGENTS.md
  - ../../agents/knowledgeforge-app-guardian/AGENTS.md
  - ../../skills/doc-analysis/SKILL.md
  - ../../skills/qa-strategy/SKILL.md
  - ../../skills/arch-refactor/SKILL.md
  - ../../skills/failure-learning/SKILL.md
  - ../../skills/clinet-integration/SKILL.md
  - ../../skills/app-guardian/SKILL.md
tags:
  - team
  - knowledge-engineering
  - qa
---

# Knowledge Engineering Team

App-focused agents that manage institutional memory, QA strategy, and codebase quality.

## Mission

This team ensures that the codebase remains aligned with architectural standards, that QA strategies are comprehensive and executable, and that failures are converted into reusable skills for continuous improvement.

## Agents

| Agent | Role |
|-------|------|
| `KnowledgeForge_DocAnalyzer` | Ingests 5k tagged MDs, aligns structure, validates tags |
| `KnowledgeForge_QA_Strategist` | Drafts QA test strategies for prod-ready runs |
| `KnowledgeForge_Arch_Refactorer` | Proposes architecture-aligned refactors |
| `KnowledgeForge_Failure_Learner` | Turns QA test failures into reusable skills |
| `KnowledgeForge_ClieNT_Integrator` | Imports Cline task history, turns runs into skills |
| `KnowledgeForge_App_Guardian` | Ensures PRs conform to app-policy docs |

## Knowledge Sources

- `codebase/*` — Architecture, security, and audit documentation
- `testing/*` — Testing strategies, results, and coverage reports
- `error-tracking/*` — Failure analysis and incident reports
- `standards/*` — Coding standards and quality guidelines