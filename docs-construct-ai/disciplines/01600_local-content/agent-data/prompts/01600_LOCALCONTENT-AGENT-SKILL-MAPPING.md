---
title: 01600 Local Content Team — Agent/Skill Mapping
description: Mapping of AI agents to skills for the 01600_local-content discipline covering employment tracking, procurement compliance, enterprise development, skills transfer, and regulatory reporting
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/01600_local-content/agent-data/prompts
gigabrain_tags: disciplines, 01600_local-content, agent-skill-mapping, multi-agent-orchestration, local-employment-tracking, local-procurement-compliance, enterprise-development, skills-transfer-monitoring, regulatory-reporting
openstinger_context: local-content-agent-skill-relationships
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/01600_local-content/agent-data/domain-knowledge/01600_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/01600_local-content/agent-data/domain-knowledge/01600_GLOSSARY.MD
  - docs_construct_ai/disciplines/01600_local-content/agent-data/prompts/01600_AI-NATIVE-LOCAL-CONTENT-OPERATIONS-PROMPT.md
---

# 01600 Local Content Team — Agent/Skill Mapping

## Overview

Maps 7 local content AI agents to their primary and supporting skills across 5 key skill areas: local employment tracking, local procurement compliance, enterprise development, skills transfer monitoring, and regulatory reporting.

---

## Agent Summary by Skill

### Skill: local-employment-tracking
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | LC-EMPLOY-001 | OpenClaw | Workforce data collection, employment metrics tracking, local hire verification |
| Supporting | LC-REPORT-001 | OpenClaw | Employment report generation, compliance data compilation |

### Skill: local-procurement-compliance
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | LC-PROCURE-001 | deep-agents | Local vendor identification, procurement threshold monitoring, spend analysis |
| Supporting | LC-COMPLY-001 | OpenClaw | Compliance verification, documentation review, audit support |

### Skill: enterprise-development
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | LC-ENTDEV-001 | deep-agents | SME capacity building, business development tracking, milestone monitoring |
| Supporting | LC-SKILLS-001 | deep-agents | Training program coordination, skills gap analysis |

### Skill: skills-transfer-monitoring
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | LC-SKILLS-001 | deep-agents | Knowledge transfer tracking, competency assessment, training effectiveness |
| Supporting | LC-EMPLOY-001 | OpenClaw | Local employee progression monitoring, career development tracking |

### Skill: regulatory-reporting
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | LC-REPORT-001 | OpenClaw | Regulatory submission preparation, compliance documentation, deadline tracking |
| Supporting | LC-EMPLOY-001 | OpenClaw | Employment data provision for regulatory submissions |
| Supporting | LC-PROCURE-001 | deep-agents | Procurement data provision for compliance reporting |

---

## Agent Capability Summary

| Agent | Primary Skill(s) | Supporting Skill(s) | Environments | Total Skills |
|-------|-----------------|---------------------|-------------|-------------|
| LC-EMPLOY-001 | local-employment-tracking | skills-transfer-monitoring, regulatory-reporting | OpenClaw | 3 |
| LC-PROCURE-001 | local-procurement-compliance | regulatory-reporting | deep-agents | 2 |
| LC-ENTDEV-001 | enterprise-development | — | deep-agents | 1 |
| LC-SKILLS-001 | skills-transfer-monitoring | enterprise-development | deep-agents | 2 |
| LC-COMPLY-001 | — | local-procurement-compliance | OpenClaw | 1 |
| LC-REPORT-001 | regulatory-reporting | local-employment-tracking | OpenClaw | 2 |

---

## Cross-Team Agent Assignments

### OpenClaw Team (Orchestration, Workflow, Processing)
- LC-EMPLOY-001, LC-COMPLY-001, LC-REPORT-001
- **Total: 3 agents**

### deep-agents Team (Complex Analysis, Specialized Functions)
- LC-PROCURE-001, LC-ENTDEV-001, LC-SKILLS-001
- **Total: 3 agents**

### JS Swarm Team
- None currently assigned

### DevForge Team
- LC-AUDIT-001 (supporting across all skills)
- **Total: 1 agent**

**Grand Total: 7 agents mapped to 5 skills**

---

*01600 Local Content Team Agent/Skill Mapping — Version 1.0 — Last Updated: 2026-03-31*
