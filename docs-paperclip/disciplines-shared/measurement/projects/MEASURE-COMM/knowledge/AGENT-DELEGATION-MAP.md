# AGENT DELEGATION MAP — MEASURE-COMM

## Overview

This document maps the delegation hierarchy for the MEASURE-COMM project. All issues delegate from the root parent goal `MEASURE-ROOT-2026` with a standard heartbeat frequency of 15 minutes.

## Delegation Hierarchy

```
MEASURE-ROOT-2026 (Parent Goal)
│
├── MEASURE-001: Shared UI Architecture
│   ├── Primary: validator-qualityforge (qualityforge-ai)
│   ├── Sub-agents:
│   │   ├── forge-devforge-system-architecture
│   │   ├── interface-devforge-api-integration
│   │   ├── engineering-ui-specialist
│   │   └── dev-loopy-technical-creative
│   └── Heartbeat: 15min
│
├── MEASURE-001-REVIEW: UI Review Coordination
│   ├── Primary: validator-qualityforge (qualityforge-ai)
│   ├── Sub-agents:
│   │   ├── dev-loopy-technical-creative
│   │   ├── engineering-ui-specialist
│   │   ├── paperclipforge-ai-user-experience-coordinator
│   │   └── interface-devforge-api-integration
│   └── Heartbeat: 15min
│
├── MEASURE-002: OpenCV Processing Engine
│   ├── Primary: validator-qualityforge (qualityforge-ai)
│   ├── Sub-agents:
│   │   ├── forge-devforge-system-architecture
│   │   ├── interface-devforge-api-integration
│   │   └── engineering-ui-specialist
│   └── Heartbeat: 15min
│
├── MEASURE-003: Discipline Integration
│   ├── Primary: procurement-strategy-domainforge-procurement-strategy (domainforge-ai)
│   ├── Sub-agents:
│   │   ├── forge-devforge-system-architecture
│   │   ├── engineering-ui-specialist
│   │   └── interface-devforge-api-integration
│   └── Heartbeat: 15min
│
├── MEASURE-004: Standards Compliance
│   ├── Primary: validator-qualityforge (qualityforge-ai)
│   ├── Sub-agents:
│   │   ├── forge-devforge-system-architecture
│   │   ├── interface-devforge-api-integration
│   │   └── engineering-ui-specialist
│   └── Heartbeat: 15min
│
└── BUILDER-MEAS-AGENTS: Builder Procurement Agents
    ├── Primary: procurement-strategy-domainforge-procurement-strategy (domainforge-ai)
    ├── Sub-agents:
    │   ├── procurement-classifier-builder (MeasureForge AI)
    │   ├── subcontract-procurement-builder (MeasureForge AI)
    │   ├── materials-procurement-builder (MeasureForge AI)
    │   ├── service-procurement-builder (MeasureForge AI)
    │   ├── workorder-procurement-builder (MeasureForge AI)
    │   ├── supplier-matching-builder (MeasureForge AI)
    │   ├── candy-integration-builder (MeasureForge AI)
    │   ├── budget-monitoring-builder (MeasureForge AI)
    │   └── approval-routing-builder (MeasureForge AI)
    └── Heartbeat: 15min
```

## Agent Summary

| Issue | Primary Agent | Company | Sub-agents |
|-------|--------------|---------|------------|
| MEASURE-001 | validator-qualityforge | qualityforge-ai | 4 |
| MEASURE-001-REVIEW | validator-qualityforge | qualityforge-ai | 4 |
| MEASURE-002 | validator-qualityforge | qualityforge-ai | 3 |
| MEASURE-003 | procurement-strategy-domainforge-procurement-strategy | domainforge-ai | 3 |
| MEASURE-004 | validator-qualityforge | qualityforge-ai | 3 |
| BUILDER-MEAS-AGENTS | procurement-strategy-domainforge-procurement-strategy | domainforge-ai | 9 |

## Standard Delegation Prompt

All issues use the following standard delegation prompt:

> Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API.

## Heartbeat Configuration

- **Frequency:** 15 minutes (all issues)
- **Purpose:** Status reporting, progress tracking, bottleneck detection
- **Escalation:** If a sub-agent fails to respond to 3 consecutive heartbeats, escalate to primary agent
