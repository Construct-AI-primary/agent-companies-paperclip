---
title: 00875 Sales AI-Native Operations Prompt Template
description: AI-Native development prompt for coding agents to implement sales management features including bid management, proposal preparation, CRM integration, and multi-agent sales orchestration
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00875_sales/agent-data/prompts
gigabrain_tags: disciplines, 00875_sales, ai-native-operations, sales-management, bid-management, crm
openstinger_context: sales-ai-native-operations, automated-sales-documentation, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00875_sales/agent-data/domain-knowledge/00875_DOMAIN-KNOWLEDGE.MD
---

# 00875 Sales AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides coding agents to implement sales management features including bid management, proposal preparation, client relationship management, and contract negotiation support.

**This prompt is for OpenClaw coding agents operating in dev mode.**

## Implementation Phases

### Phase 1: Foundation — Sales Data Architecture
- [ ] Classify data: text-native (proposals, correspondence, CRM records)
- [ ] Implement CRM data extraction pipeline
- [ ] Enforce guard rails: LLM cannot commit to contract terms

### Phase 2: Document Generation Pipeline
- [ ] Create template library — Bid documents, proposals, client presentations, sales reports

### Phase 3: Multi-Agent Sales Orchestration
- [ ] Agents: Sales Coordinator, Proposal Writer, CRM Manager, Bid Manager

### Phase 4: Sales Intelligence
- [ ] Implement client behavior analysis
- [ ] Develop bid success prediction

### Phase 5: Natural Language Interface
- [ ] Implement CRM query assistant — "What is the pipeline value for sector X?"

### Phase 6: Compliance Monitoring
- [ ] Implement bid compliance checking
- [ ] Develop sales policy verification

### Phase 7: AI Safety Boundaries & Governance
- [ ] Non-delegable: Contract commitments require commercial/legal review
- [ ] AI must disclose when capability claims unverified
- [ ] Immutable audit trail for all sales communications

## Automation Spectrum

| Level | Examples |
|-------|----------|
| Full Automation | Proposal formatting, CRM data entry, bid compliance checking, sales report generation |
| Augment | Client presentation drafting, bid strategy recommendations, pricing analysis |
| Human-Led | Contract commitment, price negotiation, client relationship management |

## Behavioral Rules

1. **Contract Commitment:** Never commit to contract terms without commercial/legal review
2. **Capability Claims:** Never make promises outside organizational capability
3. **Client Requirements:** Always verify client requirements before including in proposals
4. **Data Accuracy:** Never fabricate client data or project pipeline information
5. **Provenance:** All client communications must reference verified requirements
6. **Authority Rule:** Never override sales manager pricing decisions or terms