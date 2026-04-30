---
title: 00300 Construction AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement construction management features including method statements, progress tracking, site management, quality control, and safety compliance
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00300_construction/agent-data/prompts
gigabrain_tags: disciplines, 00300_construction, ai-native-operations, document-generation, multi-agent-orchestration, construction-management, site-monitoring, code-generation
openstinger_context: construction-ai-native-operations, automated-construction-documentation, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00300_construction/agent-data/domain-knowledge/00300_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00300_construction/agent-data/domain-knowledge/00300_GLOSSARY.MD
---

# 00300 Construction AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement construction management features including method statements, progress tracking, site management, quality control, and safety compliance automation.

**This prompt is for OpenClaw coding agents operating in dev mode.** Agents use this prompt to generate, modify, and validate code. This prompt is NOT for the running application in production.

## Phase 1: Foundation — Text-Native vs Structured-Data Architecture
- [ ] **Classify all construction data sources** — Tag each input as text-native (method statements, site reports, correspondence) or structured-data-native (progress schedules, quality checklists)
- [ ] **Implement construction document pipeline** — Document ingestion → extraction → structured data generation
- [ ] **Enforce guard rails** — LLM cannot create/edit safety-critical values; must use verified structured data

## Phase 2: Document Generation Pipeline
- [ ] **Create template library** — Method statements, ITPs, inspection reports, daily/weekly reports, site instructions
- [ ] **Implement structured data injection** — Template engine fills placeholders from schedules, quality data, site observations

## Phase 3: Multi-Agent Construction Orchestration
- [ ] **Implement Construction Coordinator Agent** — Orchestrates site operations and cross-discipline coordination
- [ ] **Implement Site Engineer Agent** — Site setting-out, quality verification, RFI processing
- [ ] **Implement Quality Inspector Agent** — ITP execution, inspection records, NCR management
- [ ] **Implement Safety Officer Agent** — RAMS compliance, incident reporting, permit-to-work

## Phase 4: Progress Monitoring and Reporting
- [ ] **Implement daily progress tracking** — Workfront measurement, resource utilization, variance analysis
- [ ] **Develop automated progress reporting** — Generate daily/weekly/monthly reports from field data
- [ ] **Implement milestone tracking** — Schedule variance, earned value, forecast completion

## Phase 5: Quality Management
- [ ] **Implement ITP management** — Inspection and Test Plan creation, tracking, and completion
- [ ] **Develop NCR management** — Non-conformance identification, root cause analysis, corrective actions
- [ ] **Implement quality documentation** — Inspection records, test results, certification tracking

## Phase 6: Safety and Compliance
- [ ] **Implement RAMS management** — Risk assessment and method statement tracking
- [ ] **Develop permit-to-work system** — Application, approval, monitoring, closure
- [ ] **Implement incident management** — Recording, investigation, reporting, lessons learned

## Phase 7: Natural Language Construction Interface
- [ ] **Implement site query assistant** — "Show all outstanding inspections for element X?"
- [ ] **Develop progress query interface** — "What is the % complete for structural works?"
- [ ] **Implement quality query system** — "Show all NCRs for concrete works in Zone A"

## Phase 8: AI Safety Boundaries & Governance
- [ ] **Implement non-delegable decision controls** — Safety-critical decisions always require human verification
- [ ] **Develop uncertainty disclosure** — AI must disclose when site data unverified
- [ ] **Implement immutable audit trail** — Log all AI outputs with provenance tags

## Automation Spectrum

| Level | Definition | Examples |
|-------|-----------|----------|
| Full Automation | AI executes with final human review | Daily progress reports, inspection record generation, site meeting minutes |
| Augment | AI drafts, human validates | Method statements, ITP creation, NCR documentation |
| Human-Led | AI supports decision-making | Safety incident classification, quality acceptance, work sequencing |

## Behavioral Rules

1. **Safety First:** Never recommend actions compromising safety. Always verify against RAMS.
2. **No Fabrication Rule:** Never invent measurements, test results, or safety observations.
3. **Provenance Rule:** All field data must tag source, inspector, date, and verification.
4. **No Guessing:** If site conditions unclear, flag "needs verification." Never assume.
5. **Authority Rule:** Never approve inspections or accept work without human inspector verification.
6. **Audit Trail:** All AI outputs must have full audit trail for quality records.