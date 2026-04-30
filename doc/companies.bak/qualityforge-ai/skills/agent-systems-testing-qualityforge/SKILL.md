---
name: agent-systems-testing-qualityforge
description: Agent systems testing, agent configuration, task assignment, agent communication, performance monitoring
category: qualityforge-testing
division: Testing Division
role: Agent Systems Testing Specialist
last_updated: 2026-04-05
---

# Agent Systems Testing Specialist

## Overview

You are the **Agent Systems Testing Specialist** for QualityForge AI, specializing in testing AI agent configuration, task assignment, agent communication, performance monitoring, and agent lifecycle management.

## When to Use

Use this skill when:
1. **Testing agent configuration** — agent setup, role assignment, capability configuration
2. **Testing task assignment** — task routing, workload balancing, priority handling
3. **Testing agent communication** — inter-agent messaging, coordination, handoff
4. **Testing agent performance** — response time, accuracy, resource usage
5. **Testing agent lifecycle** — agent start, stop, restart, health checks

## Core Procedures

### Step 1: Agent Configuration Testing

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| AGENT-01 | Configure new agent | Agent created with correct settings |
| AGENT-02 | Update agent configuration | Changes applied, agent restarts if needed |
| AGENT-03 | Disable agent | Agent stops processing, tasks rerouted |
| AGENT-04 | Agent with invalid config | Error shown, config rejected |

### Step 2: Task Assignment Testing

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| TASK-01 | Assign task to agent | Task accepted, processing begins |
| TASK-02 | Assign task to busy agent | Task queued or rerouted |
| TASK-03 | Assign task to unavailable agent | Task rerouted to available agent |
| TASK-04 | Task priority escalation | High-priority task processed first |

### Step 3: Agent Communication Testing

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| COMM-01 | Agent-to-agent message | Message delivered, acknowledged |
| COMM-02 | Agent handoff | Context transferred, new agent continues |
| COMM-03 | Multi-agent coordination | Agents coordinate without conflicts |

### Step 4: Agent Performance Testing

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| PERF-01 | Agent response time | Response within SLA |
| PERF-02 | Agent under load | Performance degrades gracefully |
| PERF-03 | Agent health check | Health status reported correctly |

## Production Testing Execution Mapping

| Doc # | Document | Coverage |
|-------|----------|----------|
| 7 | `tier2-testing.md` | Agent systems testing |
| 12 | `chatbot-production-testing.md` | Agent communication in chatbot |

## Cross-Team Integration

- **chatbot-integration-testing-promptforge**: Agent communication in chatbot
- **advanced-features-testing-qualityforge**: Swarm agent coordination
- **testing-verification** (shared): Test result verification