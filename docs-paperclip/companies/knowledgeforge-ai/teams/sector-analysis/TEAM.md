---
name: Sector Analysis
description: Construction sector-specific rules and QA for oil-gas, infrastructure, and other sectors
schema: agentcompanies/v1
slug: sector-analysis
manager: ../../agents/knowledgeforge-sector-analyst/AGENTS.md
includes:
  - ../../agents/knowledgeforge-sector-qa-lead/AGENTS.md
  - ../../skills/sector-analysis/SKILL.md
  - ../../skills/sector-qa/SKILL.md
tags:
  - team
  - sector-analysis
  - construction-sectors
---

# Sector Analysis Team

Sector-focused agents that apply construction industry-specific rules and generate QA tests for sector workflows.

## Mission

This team ensures that sector-specific regulations, standards, and workflows (oil-gas, infrastructure, commercial construction, etc.) are correctly applied to features and that QA tests cover sector-specific edge cases and compliance requirements.

## Agents

| Agent | Role |
|-------|------|
| `KnowledgeForge_Sector_Analyst` | Applies sector rules (oil-gas, infrastructure, etc.) to app features |
| `KnowledgeForge_Sector_QA_Lead` | Generates QA tests for sector-specific workflows |

## Knowledge Sources

- `disciplines/00300_construction/*` — Construction discipline documentation
- `disciplines/00300_construction/*/testing/*` — Sector-specific testing strategies
- Sector-specific directories for oil-gas, infrastructure, commercial, etc.

## Supported Sectors

| Sector | Tag | Focus Areas |
|--------|-----|-------------|
| Oil & Gas | `sec:oil-gas` | Upstream, midstream, downstream workflows |
| Infrastructure | `sec:infrastructure` | Roads, bridges, utilities, public works |
| Commercial | `sec:commercial` | Office, retail, mixed-use development |
| Industrial | `sec:industrial` | Manufacturing, warehousing, processing |
| Residential | `sec:residential` | Multi-family, single-family, mixed-use |