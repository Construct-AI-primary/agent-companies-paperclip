---
title: 01750 Legal Team — Agent/Skill Mapping
description: Mapping of AI agents to skills for the 01750_legal discipline covering contract analysis, claims management, dispute resolution, compliance monitoring, notice tracking, precedent research, and legal reporting
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/01750_legal/agent-data/prompts
gigabrain_tags: disciplines, 01750_legal, agent-skill-mapping, multi-agent-orchestration, legal-contract-analysis, legal-claims-management, legal-dispute-resolution, legal-notice-tracking, legal-precedent-research
openstinger_context: legal-agent-skill-relationships
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/01750_legal/agent-data/domain-knowledge/01750_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/01750_legal/agent-data/domain-knowledge/01750_GLOSSARY.MD
  - docs_construct_ai/disciplines/01750_legal/agent-data/prompts/01750_AI-NATIVE-LEGAL-OPERATIONS-PROMPT.md
---

# 01750 Legal Team — Agent/Skill Mapping

## Overview

Maps 7 legal AI agents to their primary and supporting skills across 5 key skill areas: legal contract analysis, legal claims management, legal dispute resolution, legal notice tracking, and legal precedent research.

---

## Agent Summary by Skill

### Skill: legal-contract-analysis
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | LEG-CONTRACT-001 | deep-agents | Contract review, clause extraction, risk identification, obligation tracking |
| Supporting | LEG-COMPLY-001 | OpenClaw | Regulatory compliance verification, statutory requirement cross-referencing |
| Supporting | LEG-REPORT-001 | OpenClaw | Contract performance data aggregation for reporting |

### Skill: legal-claims-management
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | LEG-CLAIMS-001 | deep-agents | Claim identification, quantification, documentation preparation, timeline tracking |
| Supporting | LEG-CONTRACT-001 | deep-agents | Contractual entitlement analysis, clause interpretation for claim validity |
| Supporting | LEG-NOTICE-001 | OpenClaw | Notice of claim compliance, deadline monitoring |

### Skill: legal-dispute-resolution
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | LEG-DISPUTE-001 | deep-agents | Dispute assessment, resolution strategy development, settlement analysis |
| Supporting | LEG-PRECEDENT-001 | deep-agents | Case law research, precedent identification, outcome probability analysis |
| Supporting | LEG-CLAIMS-001 | deep-agents | Claim substantiation, evidence compilation for dispute proceedings |

### Skill: legal-notice-tracking
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | LEG-NOTICE-001 | OpenClaw | Notice monitoring, deadline tracking, compliance verification, escalation alerts |
| Supporting | LEG-CONTRACT-001 | deep-agents | Notice provision extraction from contractual documents |
| Supporting | LEG-COMPLY-001 | OpenClaw | Regulatory notice requirement verification |

### Skill: legal-precedent-research
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | LEG-PRECEDENT-001 | deep-agents | Case law research, legal database querying, precedent analysis and summarization |
| Supporting | LEG-DISPUTE-001 | deep-agents | Dispute-specific research direction, relevant jurisdiction identification |

---

## Agent Capability Summary

| Agent | Primary Skill(s) | Supporting Skill(s) | Environments | Total Skills |
|-------|-----------------|---------------------|-------------|-------------|
| LEG-CONTRACT-001 | legal-contract-analysis | legal-claims-management, legal-notice-tracking | deep-agents | 3 |
| LEG-CLAIMS-001 | legal-claims-management | legal-dispute-resolution | deep-agents | 2 |
| LEG-DISPUTE-001 | legal-dispute-resolution | legal-precedent-research | deep-agents | 2 |
| LEG-COMPLY-001 | — | legal-contract-analysis, legal-notice-tracking | OpenClaw | 2 |
| LEG-NOTICE-001 | legal-notice-tracking | legal-claims-management | OpenClaw | 2 |
| LEG-PRECEDENT-001 | legal-precedent-research | legal-dispute-resolution | deep-agents | 2 |
| LEG-REPORT-001 | — | legal-contract-analysis | OpenClaw | 1 |

---

## Cross-Team Agent Assignments

### OpenClaw Team (Orchestration, Workflow, Processing)
- LEG-COMPLY-001, LEG-NOTICE-001, LEG-REPORT-001
- **Total: 3 agents**

### deep-agents Team (Complex Analysis, Specialized Functions)
- LEG-CONTRACT-001, LEG-CLAIMS-001, LEG-DISPUTE-001, LEG-PRECEDENT-001
- **Total: 4 agents**

### JS Swarm Team
- None currently assigned

### DevForge Team
- LEG-AUDIT-001 (supporting across all skills)
- **Total: 1 agent**

**Grand Total: 7 agents mapped to 5 skills**

---

*01750 Legal Team Agent/Skill Mapping — Version 1.0 — Last Updated: 2026-03-31*
