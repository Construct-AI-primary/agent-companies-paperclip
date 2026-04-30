---
name: Discipline Operations
description: Multi-discipline workflow mapping and cross-discipline guardrails
schema: agentcompanies/v1
slug: discipline-operations
manager: ../../agents/knowledgeforge-discipline-strategist/AGENTS.md
includes:
  - ../../agents/knowledgeforge-cross-discipline-guardian/AGENTS.md
  - ../../agents/knowledgeforge-workflow-guardian/AGENTS.md
  - ../../skills/discipline-strategy/SKILL.md
  - ../../skills/cross-discipline-guard/SKILL.md
  - ../../skills/workflow-guard/SKILL.md
tags:
  - team
  - discipline-operations
  - workflow-guards
---

# Discipline Operations Team

Discipline-focused agents that map features to 50+ engineering workflows and guard against cross-discipline conflicts.

## Mission

This team ensures that new features and changes are correctly mapped to the appropriate discipline workflows, that cross-discipline conflicts are detected early, and that existing discipline-specific workflows are not broken by code changes.

## Agents

| Agent | Role |
|-------|------|
| `KnowledgeForge_Discipline_Strategist` | Maps features to 50+ discipline workflows |
| `KnowledgeForge_Cross_Discipline_Guardian` | Guards against multi-discipline conflicts |
| `KnowledgeForge_Workflow_Guardian` | Ensures discipline-specific workflows survive changes |

## Knowledge Sources

- `disciplines/*` — All 50+ engineering and construction discipline docs
- `disciplines/CROSS-DISCIPLINE.md` — Cross-discipline integration rules
- `disciplines/*/workflow_docs/*` — Discipline-specific workflow documentation
- `procedures/*` — Operational procedures and standards