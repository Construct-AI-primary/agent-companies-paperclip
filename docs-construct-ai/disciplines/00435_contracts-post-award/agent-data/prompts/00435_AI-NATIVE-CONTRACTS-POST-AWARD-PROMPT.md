---
title: 00435 Contracts Post-Award AI-Native Operations Prompt Template
description: AI-Native development prompt for coding agents to implement contract administration, variation management, claims processing, and contract close-out features
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00435_contracts-post-award/agent-data/prompts
gigabrain_tags: disciplines, 00435_contracts-post-award, ai-native-operations, contract-administration, claims-management
openstinger_context: contracts-post-award-ai-native-operations, automated-contract-documentation, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00435_contracts-post-award/agent-data/domain-knowledge/00435_DOMAIN-KNOWLEDGE.MD
---

# 00435 Contracts Post-Award AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides coding agents to implement contract post-award administration features including contract administration, variation management, claims processing, and contract close-out.

**This prompt is for OpenClaw coding agents operating in dev mode.**

## Implementation Phases

### Phase 1: Foundation — Contract Post-Award Data Architecture
- [ ] Classify data: text-native (correspondence, notices, records) or structured (payment schedules, variation registers)
- [ ] Implement contract register extraction pipeline
- [ ] Enforce guard rails: LLM cannot modify contract terms

### Phase 2: Document Generation Pipeline
- [ ] Create template library — Variation notices, claim letters, payment certificates, close-out documentation

### Phase 3: Multi-Agent Orchestration
- [ ] Agents: Post-Award Coordinator, Variation Analyst, Claims Analyst, Contract Close-Out Agent

### Phase 4: Contract Intelligence
- [ ] Implement obligation tracking automation
- [ ] Develop payment cycle monitoring

### Phase 5: Natural Language Interface
- [ ] "What variations are outstanding on contract X?"

### Phase 6: Compliance Monitoring
- [ ] Implement contract terms compliance checking
- [ ] Develop payment timeline verification

### Phase 7: AI Safety Boundaries & Governance
- [ ] Non-delegable: Contract modifications require human approval
- [ ] AI must disclose when data derived from unverified records
- [ ] Immutable audit trail for all contract communications

## Automation Spectrum

| Level | Examples |
|-------|----------|
| Full Automation | Payment application formatting, variation log maintenance, contract register updates, close-out checklist generation |
| Augment | Claim letter drafting, variation impact assessment support, payment schedule reconciliation |
| Human-Led | Contract modification approval, claim settlement, final account certification |

## Behavioral Rules

1. **Contract Modification:** Never approve contract payments without proper documentation
2. **No Term Changes:** Never modify executed contract terms
3. **Audit Trail:** Always maintain audit trail for all contract changes
4. **Data Accuracy:** Never fabricate payment amounts, variation quantities, or claim values
5. **Notice Requirements:** Always verify notice requirements before drafting communications
6. **Provenance:** All data must reference source contract and supporting documentation
7. **Authority Rule:** Never override contract administrator decisions