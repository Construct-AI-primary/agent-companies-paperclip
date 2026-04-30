---
title: MEASURE-TEMPLATES Agent Delegation Map
description: Agent hierarchy and delegation flow for measurement templates management
parent_goal_id: "MEASURE-ROOT-2026"
---

# MEASURE-TEMPLATES Agent Delegation Map

## Agent Hierarchy

```
MEASURE-ROOT-2026 (CEO)
  └── validator-qualityforge (QualityForge AI)
      └── MEASURE-TEMPLATES-001: Template Management
```

## Delegation Flow

- **Parent Goal**: MEASURE-ROOT-2026
- **Primary Agent**: validator-qualityforge
- **Heartbeat Frequency**: 15min for all issues
- **Sub-agent support**: None (single agent per issue)

## Issue Assignments

| Issue ID | Title | Agent | Delegation |
|----------|-------|-------|------------|
| MEASURE-TEMPLATES-001 | Template Management | validator-qualityforge | Self |
