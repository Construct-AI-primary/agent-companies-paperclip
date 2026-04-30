---
title: 00860 Electrical Engineering Agent Data
description: Entry point for all electrical engineering agent data, including domain knowledge, skills, prompts, and agent registry
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00860_electrical-engineering/agent-data
gigabrain_tags: electrical-engineering, agent-data, navigation, index
openstinger_context: electrical-engineering-agents
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/domain-knowledge/00860_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/domain-knowledge/00860_GLOSSARY.MD
  - docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/prompts/00860_AI-NATIVE-ELECTRICAL-ENGINEERING-PROMPT.md
  - docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/00860_AGENTS-REGISTRY-SUMMARY.MD
  - docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/00860_ELECTRICAL_AGENT_SKILL_MAPPING.MD
---

# 00860 Electrical Engineering Agent Data

## Overview

This directory contains all agent data for the Electrical Engineering discipline (00860), including domain knowledge, skills registry, AI-native prompts, agent definitions, and skill mappings.

---

## Directory Structure

```
agent-data/
├── README.md                                          # This file
├── 00860_AGENTS-REGISTRY-SUMMARY.MD                   # Agent registry and capabilities
├── 00860_ELECTRICAL_AGENT_SKILL_MAPPING.MD            # Agent-to-skill mapping
├── domain-knowledge/
│   ├── 00860_DOMAIN-KNOWLEDGE.MD                      # Domain knowledge (v2.0)
│   └── 00860_GLOSSARY.MD                              # Glossary of terms (v2.0)
└── prompts/
    └── 00860_AI-NATIVE-ELECTRICAL-ENGINEERING-PROMPT.md # AI-Native prompt template (v1.0)
```

## Related Skills

All 10 electrical engineering skills are located at `docs-construct-ai/skills/domainforge_ai/`:

| Skill | Primary Agent | Status |
|-------|--------------|--------|
| [electrical-sld-processing](../../../../skills/domainforge_ai/electrical-sld-processing/SKILL.md) | EE-DWG-001 | ✅ Complete |
| [electrical-load-analysis](../../../../skills/domainforge_ai/electrical-load-analysis/SKILL.md) | EE-LOAD-001 | ✅ Complete |
| [electrical-cable-sizing](../../../../skills/domainforge_ai/electrical-cable-sizing/SKILL.md) | EE-CABLE-001 | ✅ Complete |
| [electrical-protection-coordination](../../../../skills/domainforge_ai/electrical-protection-coordination/SKILL.md) | EE-PROT-001 | ✅ Complete |
| [electrical-arc-flash-analysis](../../../../skills/domainforge_ai/electrical-arc-flash-analysis/SKILL.md) | EE-ARC-001 | ✅ Complete |
| [electrical-short-circuit](../../../../skills/domainforge_ai/electrical-short-circuit/SKILL.md) | EE-SC-001 | ✅ Complete |
| [electrical-document-generation](../../../../skills/domainforge_ai/electrical-document-generation/SKILL.md) | EE-DOCS-001 | ✅ Complete |
| [electrical-loto-compliance](../../../../skills/domainforge_ai/electrical-loto-compliance/SKILL.md) | EE-LOTO-001 | ✅ Complete |
| [electrical-commissioning](../../../../skills/domainforge_ai/electrical-commissioning/SKILL.md) | EE-COMM-001 | ✅ Complete |
| [electrical-power-quality](../../../../skills/domainforge_ai/electrical-power-quality/SKILL.md) | EE-PROT-001 | ✅ Complete |

---

## Agent Registry Summary

**12 agents across 2 environments:**

| Environment | Agent Count | Agents |
|-------------|-------------|--------|
| OpenClaw | 8 | EE-ORCH-001, EE-LOAD-001, EE-CABLE-001, EE-DOCS-001, EE-LOTO-001, EE-COMM-001, EE-QA-001, EE-LIB-001 |
| deep-agents | 4 | EE-PROT-001, EE-ARC-001, EE-SC-001, EE-DWG-001 |

Full registry: [00860_AGENTS-REGISTRY-SUMMARY.MD](./00860_AGENTS-REGISTRY-SUMMARY.MD)
Agent-to-skill mapping: [00860_ELECTRICAL_AGENT_SKILL_MAPPING.MD](./00860_ELECTRICAL_AGENT_SKILL_MAPPING.MD)

---

## Workflow

Electrical engineering agents execute workflows through the AI-Native Operations Prompt:

**Flow:** Prompt → Skills → Agents → Domain Knowledge → Output
1. **Prompt** defines what needs to be done
2. **Skills** provide how to do it
3. **Agents** execute using domain knowledge
4. **Domain knowledge** provides the technical foundation

Full prompt: [00860_AI-NATIVE-ELECTRICAL-ENGINEERING-PROMPT.md](./prompts/00860_AI-NATIVE-ELECTRICAL-ENGINEERING-PROMPT.md)

---

*00860 Electrical Engineering Agent Data — Version 1.0*
*Last Updated: 2026-03-31*