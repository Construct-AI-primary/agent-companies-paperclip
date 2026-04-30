---
title: 00860 Electrical Engineering Agent-to-Skill Mapping
description: Maps all 12 electrical engineering agents to their primary and supporting skills across the domainforge_ai skill set
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00860_electrical-engineering/agent-data
gigabrain_tags: electrical-engineering, agent-mapping, skill-assignments, domainforge-ai
openstinger_context: agent-skill-relationships
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/00860_AGENTS-REGISTRY-SUMMARY.MD
  - docs_construct_ai/skills/domainforge_ai/electrical-sld-processing/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/electrical-load-analysis/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/electrical-cable-sizing/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/electrical-protection-coordination/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/electrical-arc-flash-analysis/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/electrical-short-circuit/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/electrical-document-generation/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/electrical-loto-compliance/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/electrical-commissioning/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/electrical-power-quality/SKILL.md
---

# 00860 Electrical Engineering Agent-to-Skill Mapping

## Overview

Maps all 12 electrical engineering agents to their primary and supporting skills. Each skill has one primary agent responsible for execution and 2-4 supporting agents providing specialized capabilities.

---

## Agent Summary by Skill

### Skill: electrical-sld-processing
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | EE-DWG-001 | deep-agents | SLD symbol extraction, topology validation, power system modeling |
| Supporting | EE-PROT-001 | deep-agents | Protection device data extraction, relay verification |
| Supporting | EE-QA-001 | OpenClaw | Extraction validation and quality checking |
| Supporting | EE-LIB-001 | OpenClaw | Provenance tracking and knowledge base updates |

### Skill: electrical-load-analysis
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | EE-LOAD-001 | OpenClaw | Load estimation, demand factor calculation, diversity application |
| Supporting | EE-CABLE-001 | OpenClaw | Load verification against cable capacity |
| Supporting | EE-LIB-001 | OpenClaw | Equipment database management, reference data |

### Skill: electrical-cable-sizing
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | EE-CABLE-001 | OpenClaw | IEC 60364/NEC cable sizing, derating, voltage drop |
| Supporting | EE-LOAD-001 | OpenClaw | Load data provision, demand factor verification |
| Supporting | EE-SC-001 | deep-agents | Short-circuit withstand verification |
| Supporting | EE-QA-001 | OpenClaw | Size validation against standards |

### Skill: electrical-protection-coordination
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | EE-PROT-001 | deep-agents | Relay/fuse coordination, TCC curve analysis |
| Supporting | EE-ARC-001 | deep-agents | Arc flash boundary coordination |
| Supporting | EE-SC-001 | deep-agents | Fault current data provision, duty verification |
| Supporting | EE-QA-001 | OpenClaw | Coordination gap identification |

### Skill: electrical-arc-flash-analysis
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | EE-ARC-001 | deep-agents | IEEE 1584 incident energy calculation, PPE assignment |
| Supporting | EE-PROT-001 | deep-agents | Protection device clearing times |
| Supporting | EE-QA-001 | OpenClaw | Label and boundary verification |

### Skill: electrical-short-circuit
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | EE-SC-001 | deep-agents | Fault current calculation (3-phase, L-G, L-L, L-L-G) |
| Supporting | EE-CABLE-001 | OpenClaw | Cable impedance data provision |
| Supporting | EE-PROT-001 | deep-agents | Protection duty verification |
| Supporting | EE-QA-001 | OpenClaw | Calculation validation |

### Skill: electrical-document-generation
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | EE-DOCS-001 | OpenClaw | Template management, structured data injection, version control |
| Supporting | EE-LIB-001 | OpenClaw | Standards reference, code clause injection |
| Supporting | EE-QA-001 | OpenClaw | Quality validation, completeness checks |
| Supporting | EE-ORCH-001 | OpenClaw | Workflow orchestration, phase gates |

### Skill: electrical-loto-compliance
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | EE-LOTO-001 | OpenClaw | LOTO procedures, energy source mapping |
| Supporting | EE-QA-001 | OpenClaw | Isolation verification, audit compliance |
| Supporting | EE-LIB-001 | OpenClaw | Energy type reference, standard procedures |

### Skill: electrical-commissioning
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | EE-COMM-001 | OpenClaw | Test sequences, commissioning protocols |
| Supporting | EE-QA-001 | OpenClaw | Test validation, result verification |
| Supporting | EE-LOTO-001 | OpenClaw | Pre-energization safety checks |
| Supporting | EE-ORCH-001 | OpenClaw | Commissioning workflow coordination |

### Skill: electrical-power-quality
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | EE-PROT-001 | deep-agents | Harmonic analysis, power factor, voltage quality |
| Supporting | EE-LOAD-001 | OpenClaw | Non-linear load identification |
| Supporting | EE-QA-001 | OpenClaw | IEEE 519 compliance verification |

---

## Agent Capability Summary

| Agent | Primary Skill(s) | Supporting Skill(s) | Environments | Total Skills |
|-------|-----------------|---------------------|-------------|-------------|
| EE-ORCH-001 | — | electrical-document-generation, electrical-commissioning | OpenClaw | 2 |
| EE-DWG-001 | electrical-sld-processing | — | deep-agents | 1 |
| EE-LOAD-001 | electrical-load-analysis | electrical-cable-sizing, electrical-power-quality | OpenClaw | 3 |
| EE-CABLE-001 | electrical-cable-sizing | electrical-load-analysis, electrical-short-circuit | OpenClaw | 3 |
| EE-PROT-001 | electrical-protection-coordination, electrical-power-quality | electrical-sld-processing, electrical-arc-flash-analysis, electrical-short-circuit | deep-agents | 5 |
| EE-ARC-001 | electrical-arc-flash-analysis | electrical-protection-coordination | deep-agents | 2 |
| EE-SC-001 | electrical-short-circuit | electrical-cable-sizing, electrical-protection-coordination | deep-agents | 3 |
| EE-DOCS-001 | electrical-document-generation | — | OpenClaw | 1 |
| EE-LOTO-001 | electrical-loto-compliance | electrical-commissioning | OpenClaw | 2 |
| EE-COMM-001 | electrical-commissioning | — | OpenClaw | 1 |
| EE-QA-001 | — | electrical-sld-processing, electrical-cable-sizing, electrical-protection-coordination, electrical-arc-flash-analysis, electrical-short-circuit, electrical-document-generation, electrical-loto-compliance, electrical-commissioning, electrical-power-quality | OpenClaw | 9 |
| EE-LIB-001 | — | electrical-sld-processing, electrical-load-analysis, electrical-document-generation, electrical-loto-compliance | OpenClaw | 4 |

---

## Cross-Team Agent Assignments

### OpenClaw Team (Orchestration, Workflow, Processing)
- EE-ORCH-001, EE-LOAD-001, EE-CABLE-001, EE-DOCS-001, EE-LOTO-001, EE-COMM-001, EE-QA-001, EE-LIB-001
- **Total: 8 agents**

### deep-agents Team (Complex Analysis, Specialized Functions)
- EE-PROT-001, EE-ARC-001, EE-SC-001, EE-DWG-001
- **Total: 4 agents**

**Grand Total: 12 agents mapped to 10 skills**

---

*00860 Electrical Engineering Agent-to-Skill Mapping — Version 1.0*
*Last Updated: 2026-03-31*