# Memory System Guide

## Overview

Hermes Agent uses the persistent memory system from the official Hermes Agent framework ([docs](https://hermes-agent.nousresearch.com/docs/user-guide/features/memory)). This system provides bounded curated memory injected into the system prompt every session.

## How It Works

Two memory stores are configured:
- **MEMORY.md** — Agent's personal notes: environment facts, conventions, things learned
- **USER.md** — User profile: preferences, communication style, expectations

### Character Limits
| Memory Type | Limit | Approx Tokens |
|---|---|---|
| Agent Memory | 2,200 chars | ~800 tokens |
| User Profile | 1,375 chars | ~500 tokens |

Character limits keep memory small and focused. The agent manages pruning — when at the limit, it must consolidate or replace entries.

## Configuration

### cli-config.yaml
```yaml
memory:
  memory_enabled: true
  user_profile_enabled: true
  memory_char_limit: 2200   # ~800 tokens
  user_char_limit: 1375     # ~500 tokens
  nudge_interval: 10        # Remind to save memory every 10 turns
  memory_directory: ".hermes-memory"
```

## Memory Directory Locations

Runtime memory files are stored in `~/.hermes-memory/` (created at first run):

```
~/.hermes-memory/
├── MEMORY.md   # Agent's working knowledge
└── USER.md     # User preferences and profile
```

Profile-specific memory folders:
```
~/.hermes-memory/              # Default (Orion)
~/.hermes-memory-forge/        # Development profile
~/.hermes-memory-quality/      # Quality/Prompt profile
~/.hermes-memory-strategy/     # Strategy/Business profile
~/.hermes-memory-guardian/     # Security/Compliance profile
```

## Configuration Files

These files configure the Hermes Agent, not runtime memory:

| File | Purpose | Location |
|---|---|---|
| `hermes_agent/.env` | API keys and environment vars | hermes_agent/ |
| `hermes_agent/cli-config.yaml` | Memory and execution settings | hermes_agent/ |
| `hermes_agent/profiles/` | Profile documentation | hermes_agent/ |

## Memory Nudge

When `nudge_interval: 10`, the agent is reminded to consider saving important information to memory every 10 user turns. This helps ensure valuable context is preserved across sessions.

## Best Practices

1. **Keep entries concise** — Character limits force focus on essential information
2. **Regular pruning** — When limits are reached, consolidate or replace stale entries
3. **Separate concerns** — MEMORY.md for facts/work, USER.md for preferences/style
4. **Cross-reference** — Reference external docs for detailed information
5. **Update actively** — Don't just append; review and curate