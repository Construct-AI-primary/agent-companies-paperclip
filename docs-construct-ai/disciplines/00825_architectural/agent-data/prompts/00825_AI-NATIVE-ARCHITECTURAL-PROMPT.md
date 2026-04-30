---
title: 00825 Architectural AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement architectural management features with automation spectrum, document generation, and multi-agent orchestration
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00825_architectural/agent-data/prompts
gigabrain_tags: disciplines, 00825_architectural, ai-native-operations, document-generation, architectural-management, multi-agent-orchestration, code-generation
openstinger_context: architectural-ai-native-operations, automated-architectural-documentation, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00825_architectural/agent-data/domain-knowledge/00825_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00825_architectural/agent-data/domain-knowledge/00825_GLOSSARY.MD
---

# 00825 Architectural AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement architectural management features including architectural coordination, material specifications, finish schedules, building code compliance, and design documentation.

**This prompt is for OpenClaw coding agents operating in dev mode.** Agents use this prompt to generate, modify, and validate code. This prompt is NOT for the running application in production.

## Implementation Phases

### Phase 1: Foundation — Architectural Data Architecture
- [ ] Classify data as text-native (specifications, reports, correspondence) or geometry-native (RVT, IFC, DWG files)
- [ ] Implement BIM extraction pipeline for architectural models
- [ ] Enforce guard rails: LLM cannot modify geometry-derived architectural values

### Phase 2: Document Generation Pipeline
- [ ] Create template library — Material schedules, finish schedules, specifications, architectural reports

### Phase 3: Multi-Agent Architectural Orchestration
- [ ] Implement Architectural Coordinator Agent — Coordination with all disciplines
- [ ] Implement Material Specifier Agent — Material selection, specification drafting
- [ ] Implement BIM Coordinator Agent — Model coordination, clash resolution

### Phase 4: Code Compliance Intelligence
- [ ] Implement building code compliance checking
- [ ] Develop accessibility compliance verification
- [ ] Implement fire safety coordination verification

### Phase 5: Design Change Management
- [ ] Implement architectural revision control
- [ ] Develop material change impact assessment

### Phase 6: Natural Language Interface
- [ ] Implement material query assistant — "What finish is specified for corridor floor?"
- [ ] Develop code query system — "What are the fire rating requirements for this wall?"

### Phase 7: Compliance Monitoring
- [ ] Implement architectural quality verification from model data
- [ ] Develop material compliance tracking

### Phase 8: AI Safety Boundaries & Governance
- [ ] Design certification requires registered architect
- [ ] AI must disclose when design assumptions are unverified
- [ ] Immutable audit trail for all architectural changes

## Automation Spectrum

| Level | Examples |
|-------|----------|
| Full Automation | Finish schedule generation, material specification formatting, code reference retrieval |
| Augment | Material selection recommendations, architectural drawings coordination |
| Human-Led | Design certification, code compliance sign-off, material approval |

## Behavioral Rules

1. **Design Certification:** Never certify architectural work — always require registered architect review
2. **No Fabrication:** Never invent dimensions, material properties, or code requirements
3. **Provenance:** All data must reference source models, drawings, and schedules
4. **Material Verification:** Always verify material specifications against current manufacturer data
5. **Authority Rule:** Never override registered architect decisions or approvals
6. **Cross-Discipline:** Coordinate all material and finish changes with affected disciplines