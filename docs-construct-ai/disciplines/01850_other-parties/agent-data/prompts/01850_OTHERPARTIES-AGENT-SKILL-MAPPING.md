---
title: 01850 Other Parties Team — Agent/Skill Mapping
description: Mapping of AI agents to skills for the 01850_other-parties discipline covering stakeholder management, regulatory liaison, permit tracking, community engagement, and external communications
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/01850_other-parties/agent-data/prompts
gigabrain_tags: disciplines, 01850_other-parties, agent-skill-mapping, multi-agent-orchestration, stakeholder-management, regulatory-liaison, permit-tracking, community-engagement, external-communications
openstinger_context: other-parties-agent-skill-relationships
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/01850_other-parties/agent-data/domain-knowledge/01850_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/01850_other-parties/agent-data/domain-knowledge/01850_GLOSSARY.MD
  - docs_construct_ai/disciplines/01850_other-parties/agent-data/prompts/01850_AI-NATIVE-OTHER-PARTIES-OPERATIONS-PROMPT.md
---

# 01850 Other Parties Team — Agent/Skill Mapping

## Overview

Maps 6 AI agents to their primary and supporting skills across 5 key skill areas: stakeholder management, regulatory liaison, permit tracking, community engagement, and external communications.

---

## Agent Summary by Skill

### Skill: stakeholder-management
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | OP-STAKE-001 | deep-agents | Stakeholder identification, engagement planning, relationship mapping, sentiment tracking |
| Supporting | OP-COMMS-001 | OpenClaw | Communication material development, stakeholder briefing preparation |
| Supporting | OP-EXTCOMMS-001 | OpenClaw | External messaging alignment, public communication coordination |

### Skill: regulatory-liaison
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | OP-REGUL-001 | OpenClaw | Regulatory body coordination, submission management, compliance dialogue |
| Supporting | OP-PERMIT-001 | OpenClaw | Permit application coordination, regulatory requirement gathering |

### Skill: permit-tracking
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | OP-PERMIT-001 | OpenClaw | Permit application tracking, expiry monitoring, renewal scheduling, condition compliance |
| Supporting | OP-REGUL-001 | OpenClaw | Liaison with permitting authorities, submission status updates |

### Skill: community-engagement
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | OP-COMMUNITY-001 | deep-agents | Community relations planning, engagement activity tracking, feedback collection |
| Supporting | OP-STAKE-001 | deep-agents | Community stakeholder identification, local sentiment analysis |
| Supporting | OP-EXTCOMMS-001 | OpenClaw | Community-facing communication development and distribution |

### Skill: external-communications
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | OP-EXTCOMMS-001 | OpenClaw | Media relations, public statements, press release preparation, messaging consistency |
| Supporting | OP-COMMUNITY-001 | deep-agents | Community feedback integration into external messaging |
| Supporting | OP-STAKE-001 | deep-agents | Key stakeholder communication requirements alignment |

---

## Agent Capability Summary

| Agent | Primary Skill(s) | Supporting Skill(s) | Environments | Total Skills |
|-------|-----------------|---------------------|-------------|-------------|
| OP-STAKE-001 | stakeholder-management | community-engagement, external-communications | deep-agents | 3 |
| OP-REGUL-001 | regulatory-liaison | permit-tracking | OpenClaw | 2 |
| OP-PERMIT-001 | permit-tracking | regulatory-liaison | OpenClaw | 2 |
| OP-COMMUNITY-001 | community-engagement | external-communications | deep-agents | 2 |
| OP-EXTCOMMS-001 | external-communications | stakeholder-management, community-engagement | OpenClaw | 3 |
| OP-COORD-001 | — | stakeholder-management | deep-agents | 1 |

---

## Cross-Team Agent Assignments

### OpenClaw Team (Orchestration, Workflow, Processing)
- OP-REGUL-001, OP-PERMIT-001, OP-EXTCOMMS-001
- **Total: 3 agents**

### deep-agents Team (Complex Analysis, Specialized Functions)
- OP-STAKE-001, OP-COMMUNITY-001, OP-COORD-001
- **Total: 3 agents**

### JS Swarm Team
- None currently assigned

### DevForge Team
- None currently assigned

**Grand Total: 6 agents mapped to 5 skills**

---

*01850 Other Parties Team Agent/Skill Mapping — Version 1.0 — Last Updated: 2026-03-31*
