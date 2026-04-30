---
title: PARA Memory System — Construct AI
description: Shared durable knowledge root for the Construct AI enterprise, mapping projects, areas, resources, and archives
author: Construct AI Memory System Team
version: 2.0
memory_layer: durable_knowledge
para_section: para-root
gigabrain_tags: para, knowledge-management, enterprise-knowledge, cross-discipline, agent-reference
openstinger_context: knowledge-organization, para-structure
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/para/README.md
  - docs_construct_ai/disciplines/
---

# PARA Memory System

**Shared durable knowledge root**: `docs-construct-ai/`

## Structure

| PARA Layer | Location | Content |
|-----------|----------|---------|
| **Pages** | `/para/pages/` | Active working documentation (codebase docs only; disciplines removed) |
| **Projects** | `/para/projects/` | System project documentation (contracts, logistics, procurement, safety) |
| **Resources** | `/para/resources/` | Cross-discipline reference (project typologies: 9 sector files + index) |
| **Areas** | *(Reserved)* | Ongoing responsibilities and operational domains |
| **Archives** | *(Reserved)* | Historical knowledge and completed work |

## Discipline Agent Data

Discipline-specific knowledge for AI agents lives outside the PARA structure, under `/docs-construct-ai/disciplines/`:

| Discipline | Location |
|-----------|----------|
| Civil Engineering | `/disciplines/00850_civil-engineering/agent-data/domain-knowledge/` |
| Procurement | `/disciplines/01900_procurement/agent-data/domain-knowledge/` |
| *(other disciplines follow same pattern)* | `/disciplines/[code]_[discipline]/agent-data/domain-knowledge/` |

## Rules
- Read `README.md` first in each directory.
- Store durable facts as atomic entries.
- Supersede outdated facts instead of deleting history.
- Never store secrets.

<!-- MEMORY-STACK-GIVEAWAY:START -->
## PARA conventions
- `README.md` is the cheap read.
- Durable knowledge belongs here, not in bootstrap files.
- Supersede outdated facts; do not silently delete history.
- Discipline content lives under `/disciplines/`, not under `/para/pages/disciplines/`.
<!-- MEMORY-STACK-GIVEAWAY:END -->