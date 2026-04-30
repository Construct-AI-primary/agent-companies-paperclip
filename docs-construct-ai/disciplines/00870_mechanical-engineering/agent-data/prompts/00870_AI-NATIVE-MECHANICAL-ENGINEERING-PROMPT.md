---
title: 00870 Mechanical Engineering AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement mechanical engineering features including mechanical specifications, HVAC calculations, equipment schedules, piping design, and multi-agent orchestration
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00870_mechanical-engineering/agent-data/prompts
gigabrain_tags: disciplines, 00870_mechanical-engineering, ai-native-operations, mechanical-design, hvac, piping
openstinger_context: mechanical-ai-native-operations, automated-mechanical-documentation, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00870_mechanical-engineering/agent-data/domain-knowledge/00870_DOMAIN-KNOWLEDGE.MD
---

# 00870 Mechanical Engineering AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement mechanical engineering features including mechanical specifications, HVAC calculations, equipment schedules, piping design, and maintenance documentation.

**This prompt is for OpenClaw coding agents operating in dev mode.**

## Implementation Phases

### Phase 1: Foundation — Mechanical Data Architecture
- [ ] Classify data: text-native (calcs, specs) or geometry-native (isometrics, equipment layouts)
- [ ] Implement piping and equipment extraction pipeline
- [ ] Enforce guard rails: LLM cannot modify equipment ratings or piping specs

### Phase 2: Document Generation Pipeline
- [ ] Create template library — Equipment specs, piping schedules, HVAC calculations, maintenance procedures

### Phase 3: Multi-Agent Mechanical Orchestration
- [ ] Agents: Mechanical Coordinator, HVAC Design Agent, Equipment Specifier, Piping Coordinator

### Phase 4: Mechanical Intelligence
- [ ] Implement equipment sizing analysis, piping stress check support

### Phase 5: Natural Language Interface
- [ ] "What code applies to this piping system?" — ASME B31.3, B31.1, etc.

### Phase 6: Compliance Monitoring
- [ ] Implement compliance checking (ASHRAE, SMACNA, API, ASME)

### Phase 7: AI Safety Boundaries & Governance
- [ ] Non-delegable: Mechanical design requires professional engineer review
- [ ] AI must disclose when equipment data unverified
- [ ] Immutable audit trail for all changes

## Automation Spectrum

| Level | Examples |
|-------|----------|
| Full Automation | Equipment spec formatting, piping schedule generation, code reference retrieval |
| Augment | HVAC calculation drafting, equipment sizing recommendations, piping routing support |
| Human-Led | Mechanical design certification, equipment selection approval, code compliance sign-off |

## Behavioral Rules

1. **Design Certification:** Never certify mechanical design — always require professional engineer review
2. **No Fabrication:** Never invent equipment ratings, piping stresses, or HVAC loads without manufacturer data
3. **Code Verification:** Always verify against applicable codes (ASHRAE, SMACNA, ASME, API)
4. **Provenance:** All equipment and piping data must reference source drawings and calculations
5. **Authority Rule:** Never override mechanical engineer decisions or approvals
6. **Cross-Discipline:** Coordinate equipment and piping changes with structural, electrical, and process disciplines