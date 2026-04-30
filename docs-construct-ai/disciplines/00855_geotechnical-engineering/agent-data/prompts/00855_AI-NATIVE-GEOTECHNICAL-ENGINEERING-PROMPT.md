---
title: 00855 Geotechnical Engineering AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement geotechnical engineering features including borehole analysis, foundation design, slope stability, ground investigation reports, and geotechnical risk management
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00855_geotechnical-engineering/agent-data/prompts
gigabrain_tags: disciplines, 00855_geotechnical-engineering, ai-native-operations, geotechnical-analysis, foundation-design, slope-stability
openstinger_context: geotechnical-ai-native-operations, automated-geotechnical-documentation, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00855_geotechnical-engineering/agent-data/domain-knowledge/00855_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00855_geotechnical-engineering/agent-data/domain-knowledge/00855_GLOSSARY.MD
---

# 00855 Geotechnical Engineering AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement geotechnical engineering features including borehole analysis, foundation design recommendations, slope stability analysis, ground investigation reports, and geotechnical risk management.

**This prompt is for OpenClaw coding agents operating in dev mode.** Agents use this prompt to generate, modify, and validate code.

## Implementation Phases

### Phase 1: Foundation — Geotechnical Data Architecture
- [ ] Classify data as text-native (reports, correspondence) or structured-data-native (borehole logs, laboratory test results)
- [ ] Implement borehole data extraction pipeline
- [ ] Enforce guard rails: LLM cannot modify soil parameters or test results

### Phase 2: Document Generation Pipeline
- [ ] Create template library — Ground investigation reports, foundation recommendations, slope stability reports

### Phase 3: Multi-Agent Geotechnical Orchestration
- [ ] Implement agents: Geotechnical Coordinator, Soil Investigation Agent, Foundation Design Agent, Slope Stability Analyst

### Phase 4: Geotechnical Intelligence
- [ ] Implement foundation type recommendation engine
- [ ] Develop slope stability analysis support

### Phase 5: Natural Language Interface
- [ ] Implement geotechnical query assistant — "What is the SPT value at depth X?"

### Phase 6: Compliance Monitoring
- [ ] Implement geotechnical code compliance checking
- [ ] Develop ground investigation specification verification

### Phase 7: AI Safety Boundaries & Governance
- [ ] Non-delegable: Geotechnical interpretation always requires geotechnical engineer sign-off
- [ ] AI must disclose when soil data is from interpolated locations
- [ ] Immutable audit trail for all geotechnical changes

## Automation Spectrum

| Level | Examples |
|-------|----------|
| Full Automation | Borehole log formatting, report generation, code reference retrieval |
| Augment | Foundation type recommendations, slope stability analysis support |
| Human-Led | Geotechnical interpretation sign-off, foundation design certification, slope stability approval |

## Behavioral Rules

1. **Certification:** Never certify geotechnical interpretation — always require geotechnical engineer sign-off
2. **No Fabrication:** Never invent soil properties, laboratory test results, or groundwater levels
3. **Interpolation Warning:** Always flag when data is from interpolated or extrapolated locations
4. **Provenance:** All geotechnical data must reference source borehole, sample depth, and test method
5. **Authority Rule:** Never override geotechnical engineer decisions or recommendations
6. **Cross-Discipline:** Coordinate foundation recommendations with structural and construction disciplines