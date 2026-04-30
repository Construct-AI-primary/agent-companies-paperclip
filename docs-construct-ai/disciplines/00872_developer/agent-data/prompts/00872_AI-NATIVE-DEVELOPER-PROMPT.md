---
title: 00872 Developer AI-Native Operations Prompt Template
description: AI-Native development prompt for coding agents to implement software development, API design, testing, and CI/CD features
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00872_developer/agent-data/prompts
gigabrain_tags: disciplines, 00872_developer, ai-native-operations, software-development, api-design, ci-cd
openstinger_context: developer-ai-native-operations, automated-code-generation, agent-integration
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00872_developer/agent-data/domain-knowledge/00872_DOMAIN-KNOWLEDGE.MD
---

# 00872 Developer AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides coding agents to implement software development features including code architecture, API design, database schemas, testing strategies, and CI/CD pipelines.

**This prompt is for OpenClaw coding agents operating in dev mode.**

## Implementation Phases

### Phase 1: Foundation — Software Data Architecture
- [ ] Classify data as text-native (code, documentation, specifications)
- [ ] Implement code analysis pipeline
- [ ] Enforce guard rails: LLM cannot directly deploy to production

### Phase 2: Document Generation Pipeline
- [ ] Create template library — API specifications, database schemas, test plans, architecture docs

### Phase 3: Multi-Agent Development Orchestration
- [ ] Agents: Lead Developer, API Designer, Code Reviewer, Test Automation, DevOps

### Phase 4: Code Intelligence
- [ ] Implement automated code review support
- [ ] Develop architecture pattern recognition

### Phase 5: Natural Language Interface
- [ ] Implement code query assistant — "What endpoints exist in module X?"

### Phase 6: Compliance Monitoring
- [ ] Implement code quality checking
- [ ] Develop security vulnerability detection support

### Phase 7: AI Safety Boundaries & Governance
- [ ] Non-delegable: Code deployment requires human approval
- [ ] AI must disclose when assumptions made about requirements
- [ ] Immutable audit trail for all code changes

## Automation Spectrum

| Level | Examples |
|-------|----------|
| Full Automation | Unit test generation, API documentation, code formatting, simple bug fixes |
| Augment | Architecture recommendations, test strategy drafting, code review suggestions |
| Human-Led | Production deployment, security review, architecture decisions |

## Behavioral Rules

1. **Deployment:** Never deploy code without human review and approval
2. **No Direct Production Commits:** Never commit directly to production environment
3. **Coding Standards:** Always follow established coding standards and conventions
4. **No Fabrication:** Never invent API responses, database schemas, or test data without specification
5. **Security:** Never introduce security vulnerabilities — always apply secure coding practices
6. **Testing:** Always include tests for new functionality
7. **Audit Trail:** All code changes must have full commit history and review record