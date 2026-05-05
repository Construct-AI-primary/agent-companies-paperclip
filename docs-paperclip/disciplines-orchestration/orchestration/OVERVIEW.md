# Orchestration Overview

**Status**: ✅ Active — Updated with current OpenClaw patterns.

## Purpose

This document describes how the Construct AI agent ecosystem is orchestrated on OpenClaw, including multi-agent coordination, task dispatch, dependency resolution, and cross-company communication.

## Architecture

### Repository Structure
- **`agent-companies-openclaw/`** — Root repository containing:
  - `agent-companies-core/` — Submodule with all agent definitions, skills, companies, projects, and domain knowledge
  - `orchestration/` — Cross-project orchestration docs (this directory)
  - `schema/` — SQLite database schemas
  - `triggers/` — OpenClaw-native trigger definitions
  - `adapters/` — Adapter configurations for AI coding assistants
  - `migration/` — Paperclip → OpenClaw migration plans

### Agent Lifecycle
1. **Creation** — Agent AGENTS.md created in `agent-companies-core/agents/{company}/agents/{slug}/`
2. **Registration** — Agent slug registered in issue `assignee` field
3. **Task Assignment** — Issue dispatched to agent via trigger document
4. **Execution** — Agent performs work using assigned skills
5. **Completion** — Results reported back through heartbeat loop

### Cross-Company Coordination
- Agents report to company CEOs (e.g., `orion-domainforge-ceo`, `apex-qualityforge-ceo`)
- Cross-company tasks use delegation with `assigneeAgentId` + `parentId` fields
- Heartbeat loop polls activity logs every 15 minutes for stalled agents
- Escalation flows upward through the agent hierarchy

### Communication Patterns
- **Synchronous**: Direct agent-to-agent via issue dependencies
- **Asynchronous**: Heartbeat-based status polling
- **Escalation**: Stalled agents → CEO → escalation path
- **Discord**: Human-agent communication via dedicated Discord servers and channels

### Discord Integration
OpenClaw uses Discord as the primary human-agent communication layer. Each project phase has its own Discord server with channels named by the pattern `{company}-{discipline}-{issue-shorthand}`.

**How agents communicate via Discord:**
1. **Channel assignment** — Each issue/project gets a dedicated Discord channel
2. **Channel topic** — Shows the issue ID and assigned company
3. **Message author** — Bot username identifies the specific agent (e.g., `DevForge-Stream`, `QualityForge-Validator`)
4. **Message routing** — The `!route` command sends messages from humans to agent channels
5. **Agent updates** — Agents post progress updates, questions, and completion notifications
6. **Human replies** — Provide feedback, approvals, or additional requirements

**Current servers (6 total):**
| Server | ID | Channels | Purpose |
|--------|-----|----------|---------|
| Openclaw-comms | 1481205775710949428 | 6 | Platform operations |
| VOICE-COMM | 1500106236669071534 | 6 | Voice communication |
| PROCURE-TEST | 1500115728769093632 | 16 | Phase 1 testing |
| PROCUREMENT-BIDDING | 1500116207552954540 | 17 | Phase 2b procurement |
| SAFETY | 1500117103817134131 | 10 | Phase 2c safety |
| ELEC-TEST | 1500117452238098554 | 16 | Phase testing |

**To integrate an agent with Discord:**
1. Add the agent's slug to `AGENT_CHANNELS` in `scripts/deploy-discord-bot.sh`
2. Map it to the appropriate channel name
3. Redeploy the bot on the VPS: `bash scripts/deploy-discord-bot.sh`
4. The agent can now receive messages via `!route <agent-slug> <message>`

### Quality Gates
- Phase gates enforce pass rate thresholds (100% → 95% → 90% → 85%)
- Each phase must pass before next phase begins
- Final gate produces go/no-go recommendation

## Key Concepts

| Concept | Description |
|---------|-------------|
| **Agent** | AI entity with defined role, skills, and reporting structure |
| **Company** | Organizational unit grouping related agents |
| **Skill** | Capability that an agent can execute |
| **Issue** | Task definition with assignee, dependencies, and phase |
| **Trigger** | Event-based dispatch mechanism for project execution |
| **Heartbeat** | 15-minute polling loop for agent status monitoring |
| **Phase Gate** | Quality threshold that gates progression to next phase |

## Related Documents

- `orchestration/EXECUTION-TRACKER.md` — Per-project execution status
- `orchestration/RISK-TRACKER.md` — Operational and technical risks
- `orchestration/LEARNING-INTEGRATION.md` — Learning and feedback loops
- `triggers/TRIGGER-README.md` — Trigger definitions
- `agent-companies-core/agents/` — All agent definitions
- `agent-companies-core/companies/` — All company definitions