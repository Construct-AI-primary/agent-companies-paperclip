---
title: 02500 Security Team — Agent/Skill Mapping
description: Mapping of AI agents to skills for the 02500_security discipline covering access control, incident management, patrol management, surveillance, and visitor management
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02500_security/agent-data/prompts
gigabrain_tags: disciplines, 02500_security, agent-skill-mapping, multi-agent-orchestration, access-control, incident-management, patrol-management, surveillance, visitor-management
openstinger_context: security-agent-skill-relationships
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/02500_security/agent-data/domain-knowledge/02500_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/02500_security/agent-data/domain-knowledge/02500_GLOSSARY.MD
  - docs_construct_ai/disciplines/02500_security/agent-data/prompts/02500_AI-NATIVE-SECURITY-OPERATIONS-PROMPT.md
---

# 02500 Security Team — Agent/Skill Mapping

## Overview

Maps 8 security AI agents to their primary and supporting skills across 5 key skill areas: access control, incident management, patrol management, surveillance, and visitor management.

---

## Agent Summary by Skill

### Skill: security-access-control
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | SEC-ACCESS-001 | OpenClaw | Badge scanning, authorization checking, entry/exit logging |
| Supporting | SEC-VISITOR-001 | OpenClaw | Visitor pre-registration and escort assignment |

### Skill: security-incident-management
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | SEC-INCIDENT-001 | OpenClaw | Incident reporting, severity classification, investigation coordination |
| Supporting | SEC-EVIDENCE-001 | OpenClaw | Evidence collection, chain of custody management |
| Supporting | SEC-ALERT-001 | OpenClaw | Escalation and real-time alert triggering |

### Skill: security-patrol-management
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | SEC-PATROL-001 | OpenClaw | Patrol planning, schedule generation, GPS tracking, checkpoint verification |
| Supporting | SEC-ALERT-001 | OpenClaw | Patrol exception alerting (missed checkpoints, delays) |

### Skill: security-surveillance
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | SEC-CCTV-001 | deep-agents | CCTV monitoring, anomaly detection, recording management |
| Supporting | SEC-EVIDENCE-001 | OpenClaw | Video evidence retrieval and retention management |
| Supporting | SEC-ALERT-001 | OpenClaw | Anomaly-triggered alert generation |

### Skill: security-visitor-management
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | SEC-VISITOR-001 | OpenClaw | Visitor pre-registration, on-site verification, badge printing, escort tracking |
| Supporting | SEC-ACCESS-001 | OpenClaw | Access authorization verification and restriction enforcement |

---

## Agent Capability Summary

| Agent | Primary Skill(s) | Supporting Skill(s) | Environments | Total Skills |
|-------|-----------------|---------------------|-------------|-------------|
| SEC-ACCESS-001 | security-access-control | security-visitor-management | OpenClaw | 2 |
| SEC-VISITOR-001 | security-visitor-management | security-access-control | OpenClaw | 2 |
| SEC-INCIDENT-001 | security-incident-management | — | OpenClaw | 1 |
| SEC-EVIDENCE-001 | — | security-incident-management, security-surveillance | OpenClaw | 2 |
| SEC-PATROL-001 | security-patrol-management | — | OpenClaw | 1 |
| SEC-CCTV-001 | security-surveillance | — | deep-agents | 1 |
| SEC-ALERT-001 | — | security-incident-management, security-patrol-management, security-surveillance | OpenClaw | 3 |
| SEC-AUDIT-001 | — | security-access-control, security-incident-management, security-patrol-management | OpenClaw | 3 |

---

## Cross-Team Agent Assignments

### OpenClaw Team (Orchestration, Workflow, Processing)
- SEC-ACCESS-001, SEC-VISITOR-001, SEC-INCIDENT-001, SEC-EVIDENCE-001, SEC-PATROL-001, SEC-ALERT-001
- **Total: 6 agents**

### deep-agents Team (Complex Analysis, Specialized Functions)
- SEC-CCTV-001
- **Total: 1 agent**

### JS Swarm Team
- None currently assigned

### DevForge Team
- SEC-AUDIT-001 (supporting across all skills for audit trail)
- **Total: 1 agent**

**Grand Total: 8 agents mapped to 5 skills**

---

*02500 Security Team Agent/Skill Mapping — Version 1.0 — Last Updated: 2026-03-31*