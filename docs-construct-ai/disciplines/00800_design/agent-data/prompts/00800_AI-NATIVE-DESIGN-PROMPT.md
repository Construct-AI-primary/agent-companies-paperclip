---
title: 00800 Design AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement design management features with automation spectrum, document generation, and multi-agent orchestration
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00800_design/agent-data/prompts
gigabrain_tags: disciplines, 00800_design, ai-native-operations, document-generation, design-management, multi-agent-orchestration, code-generation
openstinger_context: design-ai-native-operations, automated-design-documentation, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00800_design/agent-data/domain-knowledge/00800_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00800_design/agent-data/domain-knowledge/00800_GLOSSARY.MD
---

# 00800 Design AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement design management features including design coordination, technical review, RFI management, design change control, and design documentation.

**This prompt is for OpenClaw coding agents operating in dev mode.** Agents use this prompt to generate, modify, and validate code. This prompt is NOT for the running application in production.

## Implementation Phases

### Phase 1: Foundation — Design Data Architecture
- [ ] Classify design data sources as text-native (design reports, calculations, correspondence) or geometry-native (DWG, RVT, IFC files)
- [ ] Implement geometry extraction pipeline for design models
- [ ] Enforce guard rails: LLM cannot modify geometry-derived design values

### Phase 2: Document Generation Pipeline
- [ ] Create template library — Design reports, calculation sheets, RFI responses, design change notices
- [ ] Implement structured data injection from design models and calculations

### Phase 3: Multi-Agent Design Orchestration
- [ ] Implement Design Coordinator Agent — Design coordination across disciplines
- [ ] Implement Technical Reviewer Agent — Design review, code compliance checking
- [ ] Implement RFI Agent — RFI processing, response drafting, tracking

### Phase 4: Design Intelligence
- [ ] Implement automated clash detection coordination
- [ ] Develop design optimization recommendations
- [ ] Implement code compliance verification

### Phase 5: Design Change Management
- [ ] Implement design change notification workflow
- [ ] Develop impact assessment automation
- [ ] Implement revision control and distribution management

### Phase 6: Natural Language Design Interface
- [ ] Implement design query assistant — "What codes apply to this element?"
- [ ] Develop RFI search and retrieval system

### Phase 7: Compliance Monitoring
- [ ] Implement design code compliance checking
- [ ] Develop design approval workflow tracking

### Phase 8: AI Safety Boundaries & Governance
- [ ] Implement non-delegable decision controls — Design certification requires registered engineer
- [ ] Develop uncertainty disclosure for design assumptions
- [ ] Implement immutable audit trail for all design changes

## Automation Spectrum

| Level | Definition | Examples |
|-------|-----------|----------|
| Full Automation | AI executes with review | RFI response drafting, design report formatting, code reference retrieval |
| Augment | AI drafts, specialist validates | Design calculations, technical specifications, design change assessments |
| Human-Led | AI supports, engineer decides | Design certification, structural approval, code interpretation |

## Behavioral Rules

1. **Design Certification:** Never approve or certify design work — always require registered professional review
2. **No Fabrication:** Never invent calculations, dimensions, or code requirements
3. **Provenance:** All derived design data must reference source drawings and calculations
4. **Code Verification:** Always verify code clauses against current editions
5. **No Assumptions:** Flag unclear design requirements as "needs clarification" — never assume
6. **Audit Trail:** All AI outputs must have full audit trail for design records
7. **Authority Rule:** Never override specialist design decisions or approvals
8. **Cross-Discipline:** Coordinate design changes with affected disciplines before finalizing