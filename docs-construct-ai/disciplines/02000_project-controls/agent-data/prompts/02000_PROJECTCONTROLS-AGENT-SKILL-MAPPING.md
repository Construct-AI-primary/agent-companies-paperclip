---
title: 02000 Project Controls Team — Agent/Skill Mapping
description: Mapping of AI agents to skills for the 02000_project-controls discipline covering earned value analysis, progress tracking, change management, risk management, performance reporting, and forecasting
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02000_project-controls/agent-data/prompts
gigabrain_tags: disciplines, 02000_project-controls, agent-skill-mapping, multi-agent-orchestration, earned-value-analysis, progress-tracking, change-management, risk-management, performance-reporting, forecasting
openstinger_context: project-controls-agent-skill-relationships
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/02000_project-controls/agent-data/domain-knowledge/02000_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/02000_project-controls/agent-data/domain-knowledge/02000_GLOSSARY.MD
  - docs_construct_ai/disciplines/02000_project-controls/agent-data/prompts/02000_AI-NATIVE-PROJECT-CONTROLS-OPERATIONS-PROMPT.md
---

# 02000 Project Controls Team — Agent/Skill Mapping

## Overview

Maps 9 project controls AI agents to their primary and supporting skills across 6 key skill areas: earned value analysis, progress tracking, change management, risk management, performance reporting, and forecasting.

---

## Agent Summary by Skill

### Skill: pc-earned-value-analysis
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | PC-EV-001 | deep-agents | CPI/SPI calculation, EVM metrics, variance analysis |
| Supporting | PC-PROGRESS-001 | OpenClaw | Progress data collection for EV calculation |
| Supporting | PC-REPORT-001 | OpenClaw | EV metrics reporting and dashboard updates |

### Skill: pc-progress-tracking
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | PC-PROGRESS-001 | OpenClaw | Physical percent complete tracking, milestone monitoring |
| Supporting | PC-SCHEDULE-001 | OpenClaw | Schedule integration and progress synchronization |

### Skill: pc-change-management
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | PC-CHANGE-001 | OpenClaw | Change request processing, impact analysis, change log maintenance |
| Supporting | PC-EV-001 | deep-agents | Cost/schedule impact quantification |

### Skill: pc-risk-management
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | PC-RISK-001 | deep-agents | Risk register management, probability-impact analysis, risk response planning |
| Supporting | PC-FORECAST-001 | deep-agents | Risk impact on forecast and contingency analysis |

### Skill: pc-performance-reporting
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | PC-REPORT-001 | OpenClaw | Performance dashboard generation, executive reporting, KPI tracking |
| Supporting | PC-EV-001 | deep-agents | EVM data integration into reports |
| Supporting | PC-PROGRESS-001 | OpenClaw | Progress status integration |

### Skill: pc-forecasting
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | PC-FORECAST-001 | deep-agents | EAC, ETC, VAC forecasting, trend analysis, Monte Carlo simulation |
| Supporting | PC-EV-001 | deep-agents | Historical performance data for trend analysis |
| Supporting | PC-CHANGE-001 | OpenClaw | Change impact integration into forecast |

---

## Agent Capability Summary

| Agent | Primary Skill(s) | Supporting Skill(s) | Environments | Total Skills |
|-------|-----------------|---------------------|-------------|-------------|
| PC-EV-001 | pc-earned-value-analysis | pc-performance-reporting, pc-forecasting | deep-agents | 3 |
| PC-PROGRESS-001 | pc-progress-tracking | pc-earned-value-analysis, pc-performance-reporting | OpenClaw | 3 |
| PC-CHANGE-001 | pc-change-management | pc-forecasting | OpenClaw | 2 |
| PC-RISK-001 | pc-risk-management | — | deep-agents | 1 |
| PC-REPORT-001 | pc-performance-reporting | — | OpenClaw | 1 |
| PC-FORECAST-001 | pc-forecasting | pc-risk-management | deep-agents | 2 |
| PC-SCHEDULE-001 | — | pc-progress-tracking | OpenClaw | 1 |

---

## Cross-Team Agent Assignments

### OpenClaw Team (Orchestration, Workflow, Processing)
- PC-PROGRESS-001, PC-CHANGE-001, PC-REPORT-001, PC-SCHEDULE-001
- **Total: 4 agents**

### deep-agents Team (Complex Analysis, Specialized Functions)
- PC-EV-001, PC-RISK-001, PC-FORECAST-001
- **Total: 3 agents**

### JS Swarm Team
- None currently assigned

### DevForge Team
- None currently assigned

**Grand Total: 7 agents mapped to 6 skills**

---

*02000 Project Controls Team Agent/Skill Mapping — Version 1.0 — Last Updated: 2026-03-31*