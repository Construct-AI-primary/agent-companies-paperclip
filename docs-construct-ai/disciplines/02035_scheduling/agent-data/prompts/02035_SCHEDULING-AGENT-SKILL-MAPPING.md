---
title: 02035 Scheduling Team — Agent/Skill Mapping
description: Mapping of AI agents to skills for the 02035_scheduling discipline covering CPM scheduling, progress tracking, delay analysis, schedule reporting, resource loading, and baseline management
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02035_scheduling/agent-data/prompts
gigabrain_tags: disciplines, 02035_scheduling, agent-skill-mapping, multi-agent-orchestration, cpm-scheduling, progress-tracking, delay-analysis, schedule-reporting, resource-loading, baseline-management
openstinger_context: scheduling-agent-skill-relationships
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/02035_scheduling/agent-data/domain-knowledge/02035_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/02035_scheduling/agent-data/domain-knowledge/02035_GLOSSARY.MD
  - docs_construct_ai/disciplines/02035_scheduling/agent-data/prompts/02035_AI-NATIVE-SCHEDULING-OPERATIONS-PROMPT.md
---

# 02035 Scheduling Team — Agent/Skill Mapping

## Overview

Maps 7 scheduling AI agents to their primary and supporting skills across 4 key skill areas: CPM scheduling, progress tracking, delay analysis, and baseline management.

---

## Agent Summary by Skill

### Skill: scheduling-cpm-development
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | SCH-CPM-001 | deep-agents | CPM schedule development, critical path identification, float analysis |
| Supporting | SCH-RESOURCE-001 | OpenClaw | Resource loading and leveling integration |

### Skill: scheduling-progress-tracking
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | SCH-PROGRESS-001 | OpenClaw | Progress update processing, actual vs planned comparison, percent complete |
| Supporting | SCH-REPORT-001 | OpenClaw | Progress dashboard and schedule status reporting |

### Skill: scheduling-delay-analysis
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | SCH-DELAY-001 | deep-agents | Delay analysis (TIA, impact as-planned, as-built), critical delay identification |
| Supporting | SCH-BASELINE-001 | deep-agents | Baseline comparison and variance analysis |

### Skill: scheduling-baseline-management
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | SCH-BASELINE-001 | deep-agents | Baseline development, revision management, change impact on baseline |
| Supporting | SCH-CPM-001 | deep-agents | Schedule logic validation and integrity checking |

---

## Agent Capability Summary

| Agent | Primary Skill(s) | Supporting Skill(s) | Environments | Total Skills |
|-------|-----------------|---------------------|-------------|-------------|
| SCH-CPM-001 | scheduling-cpm-development | scheduling-baseline-management | deep-agents | 2 |
| SCH-PROGRESS-001 | scheduling-progress-tracking | — | OpenClaw | 1 |
| SCH-DELAY-001 | scheduling-delay-analysis | — | deep-agents | 1 |
| SCH-REPORT-001 | — | scheduling-progress-tracking | OpenClaw | 1 |
| SCH-BASELINE-001 | scheduling-baseline-management | scheduling-delay-analysis | deep-agents | 2 |
| SCH-RESOURCE-001 | — | scheduling-cpm-development | OpenClaw | 1 |
| SCH-CRITPATH-001 | — | scheduling-cpm-development, scheduling-delay-analysis | deep-agents | 2 |

---

## Cross-Team Agent Assignments

### OpenClaw Team (Orchestration, Workflow, Processing)
- SCH-PROGRESS-001, SCH-REPORT-001, SCH-RESOURCE-001
- **Total: 3 agents**

### deep-agents Team (Complex Analysis, Specialized Functions)
- SCH-CPM-001, SCH-DELAY-001, SCH-BASELINE-001, SCH-CRITPATH-001
- **Total: 4 agents**

### JS Swarm Team
- None currently assigned

### DevForge Team
- None currently assigned

**Grand Total: 7 agents mapped to 4 skills**

---

*02035 Scheduling Team Agent/Skill Mapping — Version 1.0 — Last Updated: 2026-03-31*