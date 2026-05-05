# Discord Channel Taxonomy

**Status**: ✅ Active — Hybrid model (control channels + monitored issue channels + ephemeral work channels)

## Purpose

Defines the channel taxonomy for OpenClaw's Discord communication layer across 14 servers and ~130 channels. This document implements the hybrid model: thin control channels per server, monitored issue channels preserved where useful, and ephemeral work channels created on demand.

## Channel Types

| Type | Prefix | Agent Behavior | Human Behavior | Lifecycle |
|------|--------|---------------|----------------|-----------|
| **Control** | `#ai-work` | Orchestrator listens, spawns sub-agents | Type `@agent` commands | Permanent |
| **Log** | `#project-log` | Agent writes summaries, PR links, status | Read-only (human can comment) | Permanent |
| **Ops** | `#project-ops` | Infra/deploy agents respond | Staff-only commands | Permanent |
| **Issue** | `#{project}-{n}` | Agent monitors (read-only), replies in control channels | Full discussion | Permanent (archived when stale) |
| **Work** | `#work-{issue-id}` | Sub-agents post progress, diffs | Human can observe/intervene | Ephemeral (archived on completion) |
| **System** | `#deployments`, `#monitoring`, etc. | Bot posts automated alerts | Read-only | Permanent |

## Per-Server Taxonomy

### Openclaw-comms (Ops Server)
| Channel | Type | Purpose |
|---------|------|---------|
| `#deployments` | System | Deployment notifications |
| `#monitoring` | System | Health alerts |
| `#security` | System | Security events |
| `#operations` | System | Operations updates |
| `#agent-commands` | System | Bot commands (!ping, !status, !help) |
| `#voice-comm` | System | Voice communication |

### TEST Servers (PROCURE-TEST, ELEC-TEST, QS-TEST, LOGIS-TEST)
| Channel | Type | Purpose |
|---------|------|---------|
| `#ai-work` | **Control** | Orchestrator command hub (NEW — add) |
| `#project-log` | **Log** | Agent summaries and status (NEW — add) |
| `#{agent}-{issue}` | Issue | Existing issue channels — agent monitors read-only |

### Discipline Servers (PROCUREMENT-BIDDING, MEASUREMENT, VOICE-COMM, SAFETY, CONTRACTS-QS)
| Channel | Type | Purpose |
|---------|------|---------|
| `#ai-work` | **Control** | Orchestrator command hub (NEW — add) |
| `#project-log` | **Log** | Agent summaries and status (NEW — add) |
| `#{agent}-{subprocess}` | Issue | Existing sub-process channels — agent monitors read-only |

### Project Servers (ELEC-PROJECTS, LOGISTICS, ENGINEERING, ALL-DISCIPLINES)
| Channel | Type | Purpose |
|---------|------|---------|
| `#ai-work` | **Control** | Orchestrator command hub (NEW — add) |
| `#project-log` | **Log** | Agent summaries and status (NEW — add) |
| `#work-{issue-id}` | Work | Ephemeral — created on demand, archived when done |

## Agent Behavior by Channel Type

### Control Channels (`#ai-work`)
- Orchestrator agent listens for `@agent` mentions
- Commands: `@agent plan #{issue-id}`, `@agent work on #{issue-id}`, `@agent status`, `@agent help`
- Orchestrator spawns sub-agents in background sessions
- Orchestrator can optionally create `#work-{issue-id}` ephemeral channels
- **Reply mode**: Always reply in same channel

### Log Channels (`#project-log`)
- Agents write summaries, PR links, status changes, completion notifications
- Humans can comment for clarification
- **Reply mode**: Agent writes only; reads human comments

### Issue Channels (Existing)
- Agent monitors but does NOT reply directly
- If human mentions `@agent`, agent replies in `#ai-work` with a cross-reference
- **Reply mode**: Read-only (agent); full (human)

### Work Channels (Ephemeral)
- Created by orchestrator on demand
- Sub-agents post progress, diffs, questions
- Archived/renamed when work cycle completes
- **Reply mode**: Full (agent + human)

## Ephemeral Channel Lifecycle

```
1. Human: @agent work on PROCURE-007 in #ai-work
2. Orchestrator: Creates #work-procure-007 channel
3. Orchestrator: Spawns 10 sub-agents in background sessions
4. Sub-agents: Post progress in #work-procure-007
5. Orchestrator: Posts summary in #project-log
6. On completion: Orchestrator archives #work-procure-007
7. Human: Reviews in #project-log, comments in #ai-work if needed
```

## Bot Configuration

### Channel Registry Updates
The `CHANNEL_MAP` in `scripts/bot.js` should be extended with a `type` field:

```javascript
'channel-id': {
  server: 'PROCURE-TEST',
  name: 'ai-work',
  agent: 'OpenClaw Orchestrator',
  purpose: 'Orchestrator command hub',
  type: 'control',       // control | log | issue | work | system
  reply_mode: 'direct',  // direct | cross-ref | read-only
  ephemeral: false       // true for work channels
}
```

### Permission Model
| Channel Type | Bot Read | Bot Write | Bot Create/Delete |
|---|---|---|---|
| Control | ✅ | ✅ | ❌ |
| Log | ✅ | ✅ | ❌ |
| Issue | ✅ | ❌ (reply in control) | ❌ |
| Work | ✅ | ✅ | ✅ (orchestrator only) |
| System | ✅ | ✅ | ❌ |

## Migration Path

### Phase 1 — Add Control Channels (Immediate)
- Add `#ai-work` and `#project-log` to all 14 servers
- Update `bot.js` to recognize new channel types
- Existing issue channels continue working as before

### Phase 2 — Relegate Issue Channels (After Phase 1 Stable)
- Update `bot.js` to set issue channels to `reply_mode: 'cross-ref'`
- Agent reads issue channels but replies in `#ai-work`
- Human workflow unchanged (they still type in issue channels)

### Phase 3 — Ephemeral Work Channels (After Phase 2 Stable)
- Wire orchestrator agent with Discord `manage_channels` permission
- Implement `!create-work-channel` or `@agent work on` command
- Implement auto-archive on completion

### Phase 4 — New Projects (From Day One)
- Enforce thin-channel pattern: `#ai-work` + `#project-log` only
- No issue-per-channel for new Wave projects
- Ephemeral work channels on demand

## Related Documents
- `scripts/bot.js` — Discord bot implementation
- `orchestration/EXECUTION-TRACKER.md` — Execution status
- `agent-companies-core/companies/openclawforge-ai/tasks/discord-setup/TASK.md` — Discord setup task