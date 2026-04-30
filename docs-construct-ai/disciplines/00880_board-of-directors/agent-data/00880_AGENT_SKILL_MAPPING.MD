---
title: 00880 Board of Directors Agent-Skill Mapping
description: Maps Board of Directors agents to their primary and supporting skills
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00880_board-of-director/agent-data
gigabrain_tags: disciplines, 00880_board-of-director, agent-skill-mapping
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00880_board-of-director/agent-data/domain-knowledge/00880_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00880_board-of-director/agent-data/prompts/00880_AI-NATIVE-BOARD-OF-DIRECTORS-PROMPT.md
---

# 00880 Board of Directors Agent-Skill Mapping

## Agent to Skill Mapping

| Agent Code | Primary Skill | Supporting Skills | Environment |
|-----------|--------------|------------------|-------------|
| BOARD-FIN-001 | board-governance | financial-analytics | Production |
| BOARD-RSK-001 | board-governance | risk-assessment | Production |
| BOARD-STR-001 | board-governance | strategic-planning | Production |
| BOARD-CMP-001 | board-governance | compliance-monitoring | Production |
| BOARD-RPT-001 | board-governance | document-generation | Production |

## Skill Coverage Matrix

| Skill | Primary Agent | Coverage % | Status |
|-------|--------------|------------|--------|
| board-governance | BOARD-FIN-001 | 100% | ✅ Complete |

## Cross-Team Coordination

- **Finance Director (00889)**: Financial data feeds to BOARD-FIN-001
- **HSE Director (00885)**: HSE metrics to BOARD-RPT-001
- **Governance (01300)**: Compliance data to BOARD-CMP-001
- **Risk Management**: Risk register to BOARD-RSK-001