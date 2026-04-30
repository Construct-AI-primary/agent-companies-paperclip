---
title: 00860 Electrical Engineering Agents Registry Summary
description: Comprehensive registry of all electrical engineering agents, their capabilities, environments, and reporting structure
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00860_electrical-engineering/agent-data
gigabrain_tags: electrical-engineering, agent-registry, capabilities, environments, team-structure
openstinger_context: electrical-engineering-agent-staffing
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/prompts/00860_AI-NATIVE-ELECTRICAL-ENGINEERING-PROMPT.md
  - docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/domain-knowledge/00860_DOMAIN-KNOWLEDGE.MD
---

# 00860 Electrical Engineering Agents Registry Summary

## Overview

This document provides the comprehensive registry of all electrical engineering agents required to execute the AI-Native Electrical Engineering Operations Prompt. Each agent is documented with their ID, name, role, assigned skills, environment, and reporting structure.

---

## Agent Registry

### OpenClaw Team (Orchestration, Workflow, Processing)

| Agent ID | Agent Name | Role | Primary Skills | Environment | Reports To |
|----------|-----------|------|---------------|-------------|------------|
| EE-ORCH-001 | Electrical Orchestrator | Lead coordinator, workflow management, phase gates | All (orchestration) | OpenClaw | Lead Engineer |
| EE-LOAD-001 | Load Analysis Agent | Load estimation, demand calculation, diversity factors | electrical-load-analysis | OpenClaw | Lead Engineer |
| EE-CABLE-001 | Cable Sizing Agent | Cable sizing per IEC 60364/NEC | electrical-cable-sizing | OpenClaw | Lead Engineer |
| EE-DOCS-001 | Document Generation Agent | Template-based document generation | electrical-document-generation | OpenClaw | Lead Engineer |
| EE-LOTO-001 | LOTO Compliance Agent | LOTO procedures, energy source mapping | electrical-loto-compliance | OpenClaw | Safety Lead |
| EE-COMM-001 | Commissioning Agent | Test sequences, commissioning protocols | electrical-commissioning | OpenClaw | Lead Engineer |
| EE-QA-001 | Electrical QA Agent | Quality assurance, code compliance verification | All (QA) | OpenClaw | Quality Lead |
| EE-LIB-001 | Electrical Library Agent | Reference data, code databases, standards | All (reference) | OpenClaw | — |

### deep-agents Team (Complex Analysis, Specialized Functions)

| Agent ID | Agent Name | Role | Primary Skills | Environment | Reports To |
|----------|-----------|------|---------------|-------------|------------|
| EE-PROT-001 | Protection Coordination Agent | Relay/fuse coordination, TCC analysis | electrical-protection-coordination | deep-agents | Lead Engineer |
| EE-ARC-001 | Arc Flash Agent | IEEE 1584 arc flash analysis | electrical-arc-flash-analysis | deep-agents | Safety Lead |
| EE-SC-001 | Short Circuit Agent | Fault current calculation per IEC 60909/IEEE | electrical-short-circuit | deep-agents | Lead Engineer |
| EE-DWG-001 | SLD Processing Agent | SLD extraction, topology validation | electrical-sld-processing | deep-agents | Lead Engineer |

## Total Agents: 12

| Environment | Agent Count |
|-------------|-------------|
| OpenClaw | 8 |
| deep-agents | 4 |

---

## Agent Capabilities Matrix

| Agent | Core Capabilities | Supporting Capabilities |
|-------|-------------------|----------------------|
| EE-ORCH-001 | Workflow orchestration, phase gates, dependency management, status tracking | Agent coordination, error handling, escalation |
| EE-LOAD-001 | Load estimation, demand factor application, diversity calculation, feeder sizing | Equipment database management, load categorization |
| EE-CABLE-001 | IEC 60364 cable sizing, NEC ampacity, voltage drop, short-circuit withstand | Derating factor application, installation method selection |
| EE-PROT-001 | Relay coordination, TCC curve analysis, fuse coordination, selective tripping | Protection device library management, setting recommendations |
| EE-ARC-001 | IEEE 1584 incident energy, arc flash boundaries, PPE categories | Label generation, hazard assessment |
| EE-SC-001 | 3-phase fault, L-G fault, L-L fault, L-L-G fault calculations | Equipment duty verification, impedance data management |
| EE-DWG-001 | SLD symbol extraction, topology validation, power system modeling | Provenance tracking, data quality validation |
| EE-DOCS-001 | Template management, structured data injection, version control | Quality validation, format export (PDF/DOCX/JSON/Excel) |
| EE-LOTO-001 | Equipment inventory, energy source mapping, procedure generation | Isolation verification, audit trail management |
| EE-COMM-001 | Test sequence generation, pre-commissioning checklists, functional testing | Commissioning report generation, handover documentation |
| EE-QA-001 | Code compliance verification, completeness checks, audit logging | Standards monitoring, quality reporting |
| EE-LIB-001 | Code reference management, standard updates, precedent research | Cross-reference validation, knowledge base maintenance |

---

## Reporting Structure

```
Lead Electrical Engineer
├── EE-ORCH-001 (Electrical Orchestrator) - Team Lead
│   ├── EE-LOAD-001 (Load Analysis Agent)
│   ├── EE-CABLE-001 (Cable Sizing Agent)
│   ├── EE-PROT-001 (Protection Coordination Agent) [deep-agents]
│   ├── EE-ARC-001 (Arc Flash Agent) [deep-agents]
│   ├── EE-SC-001 (Short Circuit Agent) [deep-agents]
│   ├── EE-DWG-001 (SLD Processing Agent) [deep-agents]
│   ├── EE-DOCS-001 (Document Generation Agent)
│   ├── EE-LOTO-001 (LOTO Compliance Agent)
│   └── EE-COMM-001 (Commissioning Agent)
├── EE-QA-001 (Electrical QA Agent) - Reports to Quality Lead
└── EE-LIB-001 (Electrical Library Agent) - Reports to Knowledge Lead
```

---

## Agent-to-Skill Relationship Summary

| Skill | Primary Agent | Supporting Agents | Count |
|-------|--------------|-------------------|-------|
| electrical-sld-processing | EE-DWG-001 | EE-PROT-001, EE-QA-001, EE-LIB-001 | 4 |
| electrical-load-analysis | EE-LOAD-001 | EE-CABLE-001, EE-LIB-001 | 3 |
| electrical-cable-sizing | EE-CABLE-001 | EE-LOAD-001, EE-SC-001, EE-QA-001 | 4 |
| electrical-protection-coordination | EE-PROT-001 | EE-ARC-001, EE-SC-001, EE-QA-001 | 4 |
| electrical-arc-flash-analysis | EE-ARC-001 | EE-PROT-001, EE-QA-001 | 3 |
| electrical-short-circuit | EE-SC-001 | EE-CABLE-001, EE-PROT-001, EE-QA-001 | 4 |
| electrical-document-generation | EE-DOCS-001 | EE-LIB-001, EE-QA-001, EE-ORCH-001 | 4 |
| electrical-loto-compliance | EE-LOTO-001 | EE-QA-001, EE-LIB-001 | 3 |
| electrical-commissioning | EE-COMM-001 | EE-QA-001, EE-LOTO-001, EE-ORCH-001 | 4 |
| electrical-power-quality | EE-PROT-001 | EE-LOAD-001, EE-QA-001 | 3 |

---

*00860 Electrical Engineering Agents Registry Summary — Version 1.0*
*Last Updated: 2026-03-31*