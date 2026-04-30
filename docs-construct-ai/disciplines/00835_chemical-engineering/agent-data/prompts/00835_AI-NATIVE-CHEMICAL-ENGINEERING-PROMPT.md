---
title: 00835 Chemical Engineering AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement chemical engineering features including process flow diagrams, P&IDs, chemical calculations, equipment specifications, HAZOP reports, and process safety management
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00835_chemical-engineering/agent-data/prompts
gigabrain_tags: disciplines, 00835_chemical-engineering, ai-native-operations, process-design, hazop, pid-generation, equipment-specification, process-safety
openstinger_context: chemical-engineering-ai-native-operations, automated-documentation, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00835_chemical-engineering/agent-data/domain-knowledge/00835_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00835_chemical-engineering/agent-data/domain-knowledge/00835_GLOSSARY.MD
---

# 00835 Chemical Engineering AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement chemical engineering features including process flow diagrams, P&IDs, chemical calculations, equipment specifications, HAZOP reports, and process safety management.

**This prompt is for OpenClaw coding agents operating in dev mode.** Agents use this prompt to generate, modify, and validate code.

## Implementation Phases

### Phase 1: Foundation — Chemical Engineering Data Architecture
- [ ] Classify data as text-native (calculations, reports, HAZOP records) or geometry-native (PFDs, P&IDs, 3D models)
- [ ] Implement P&ID extraction pipeline
- [ ] Enforce guard rails: LLM cannot modify process safety-critical values

### Phase 2: Document Generation Pipeline
- [ ] Create template library — PFDs, P&IDs, equipment specs, HAZOP reports, process calculations

### Phase 3: Multi-Agent Chemical Engineering Orchestration
- [ ] Chemical Engineering Coordinator, Process Engineer, HAZOP Facilitator, Equipment Specifier agents

### Phase 4: Process Safety Intelligence
- [ ] Implement HAZOP automation support
- [ ] Develop process hazard analysis tools

### Phase 5: Natural Language Interface
- [ ] Implement code query assistant — "What NFPA standard applies to this material?"

### Phase 6: Compliance Monitoring
- [ ] Implement process code compliance (ASME, API, NFPA)
- [ ] Develop safety case documentation

### Phase 7: AI Safety Boundaries & Governance
- [ ] Non-delegable: Process safety analysis requires human verification
- [ ] AI must disclose when chemical property data unverified
- [ ] Immutable audit trail for all process changes

## Automation Spectrum

| Level | Examples |
|-------|----------|
| Full Automation | Equipment specification formatting, P&ID symbol checking, code reference retrieval |
| Augment | Process calculation drafting, equipment sizing recommendations, HAZOP report generation |
| Human-Led | Process safety certification, HAZOP approval, process design approval |

## Behavioral Rules

1. **Safety Analysis:** Never approve or certify process safety analysis — always require professional engineer review
2. **No Fabrication:** Never invent chemical properties, process parameters, or safety requirements
3. **Provenance:** All data must reference source documents and calculations
4. **Code Verification:** Always verify against applicable codes (ASME, API, NFPA)
5. **Authority Rule:** Never override process engineer decisions or approvals
6. **Cross-Discipline:** Coordinate process changes with mechanical, electrical, and safety disciplines