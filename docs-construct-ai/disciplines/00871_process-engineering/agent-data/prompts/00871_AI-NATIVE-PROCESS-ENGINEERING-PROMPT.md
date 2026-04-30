---
title: 00871 Process Engineering AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement process engineering features including PFDs, P&IDs, mass and energy balance, equipment sizing, and HAZOP support
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00871_process-engineering/agent-data/prompts
gigabrain_tags: disciplines, 00871_process-engineering, ai-native-operations, process-design, pfd, pid
openstinger_context: process-ai-native-operations, automated-process-documentation, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00871_process-engineering/agent-data/domain-knowledge/00871_DOMAIN-KNOWLEDGE.MD
---

# 00871 Process Engineering AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement process engineering features including process flow diagrams, P&IDs, mass and energy balance, equipment sizing, and HAZOP support.

**This prompt is for OpenClaw coding agents operating in dev mode.**

## Implementation Phases

### Phase 1: Foundation — Process Data Architecture
- [ ] Classify data: text-native (calculations, reports) or geometry-native (PFDs, P&IDs)
- [ ] Implement PFD/P&ID extraction pipeline
- [ ] Enforce guard rails: LLM cannot modify process parameters

### Phase 2: Document Generation Pipeline
- [ ] Create template library — PFDs, P&IDs, mass/energy balance sheets, equipment datasheets

### Phase 3: Multi-Agent Process Orchestration
- [ ] Agents: Process Coordinator, Process Simulation Agent, Equipment Sizing Agent, HAZOP Support Agent

### Phase 4: Process Intelligence
- [ ] Implement mass and energy balance verification
- [ ] Develop equipment sizing automation

### Phase 5: Natural Language Interface
- [ ] Implement process query assistant — "What is the design pressure of vessel X?"

### Phase 6: Compliance Monitoring
- [ ] Implement process code compliance (API, ASME, NFPA)

### Phase 7: AI Safety Boundaries & Governance
- [ ] Non-delegable: Process safety requires human verification
- [ ] AI must disclose when mass/energy balance unverified
- [ ] Immutable audit trail

## Automation Spectrum

| Level | Examples |
|-------|----------|
| Full Automation | Equipment datasheet formatting, P&ID symbol checking, code reference retrieval |
| Augment | Mass/energy balance drafting, equipment sizing support, HAZOP preparation |
| Human-Led | Process design certification, HAZOP approval, safety case review |

## Behavioral Rules

1. **Safety Analysis:** Never approve process safety analysis — always require professional engineer review
2. **No Fabrication:** Never invent chemical properties or process parameters
3. **Balance Verification:** Always verify mass and energy balance closure
4. **Code Verification:** Always verify against applicable codes (API, ASME, NFPA)
5. **Provenance:** All data must reference source process documents
6. **Authority Rule:** Never override process engineer decisions