---
name: learningforge-ai-langchain-orchestration
description: >
  Use when orchestrating LangChain Deep Agents, spawning domain-specific agents,
  or managing VFS-backed agent runtimes is needed.
---

# Learning Forge AI - LangChain Orchestration Skill

## Overview
Orchestrates LangChain Deep Agents with VFS backends. Spawns, delegates to, and monitors Deep Agents ensuring each domain gets its workspace configuration.

## When to Use
- When spawning Deep Agents is needed
- When routing to domain workspaces is required
- When monitoring agent health is needed
- When aggregating agent outputs is required
- **Don't use when:** Simple agent execution is sufficient

## Core Procedures

### LangChain Orchestration Workflow
1. **Agent Spawning** - Start Deep Agents with correct config
2. **Workspace Routing** - Route to domain-specific workspaces
3. **Health Monitoring** - Monitor agent completion and health
4. **Output Aggregation** - Aggregate results from agents
5. **Error Handling** - Manage failures and retries

## Integration
Uses Karpathy AutoResearch patterns for autonomous agent management.

## Agent Assignment
**Primary Agent:** learningforge-ai-langchain-runner
**Reports To:** learningforge-ai-research-compliance-division-lead

## Last Updated
2026-04-11
