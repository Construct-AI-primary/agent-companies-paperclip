---
title: Paperclip + Hermes Architecture
summary: System architecture, data flow, and component relationships
---

# Paperclip + Hermes Architecture

This document describes the current architecture of the Paperclip control plane and its integration with Hermes agents.

## System Overview

```
┌─────────────────────────────────────────────────────────────────────┐
│                        Paperclip Control Plane                       │
│  ┌─────────────────┐  ┌──────────────┐  ┌───────────────────────┐   │
│  │  Express Server │  │  React UI    │  │  Supabase (PostgreSQL)│   │
│  │  (port 3100)    │◄─┤  (Vite)      │  │                       │   │
│  │                 │  │              │  │  ┌─────────────────┐  │   │
│  │  • REST API     │  │  • Dashboard │  │  │ agents          │  │   │
│  │  • Auth         │  │  • Boards    │  │  │ companies       │  │   │
│  │  • Orchestration│  │  • Issues    │  │  │ issues          │  │   │
│  │  • Activity Log │  │  • Companies │  │  │ agent_api_keys  │  │   │
│  └────────┬────────┘  └──────────────┘  │  │ agent_models    │  │   │
│           │                              │  │ projects        │  │   │
│           │                              │  │ workspaces      │  │   │
│           └──────────────────────────────┤  └─────────────────┘  │   │
│                                          └───────────────────────┘   │
└──────────────────────────────────────────────────────────────────────┘
           │
           │ API (Bearer tokens)
           ▼
┌──────────────────────────────────────────────────────────────────────┐
│                        Hermes Agent (Local)                          │
│                                                                      │
│  ┌────────────────────────────────────────────────────────────────┐ │
│  │  Local SQLite (~/.hermes/state.db)                             │ │
│  │                                                                │ │
│  │  Tables:                                                       │ │
│  │  • sessions        - Session metadata, model config, costs     │ │
│  │  • messages        - Full conversation history + reasoning     │ │
│  │  • agent_api_keys  - Hashed API keys (synced from Supabase)    │ │
│  │  • state_meta      - Key-value metadata store                  │ │
│  │  • messages_fts    - Full-text search index                    │ │
│  │                                                                │ │
│  │  Schema Version: 8                                             │ │
│  └────────────────────────────────────────────────────────────────┘ │
│                                                                      │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐  │
│  │  AIAgent         │  │  CLI / Gateway   │  │  TUI (Ink/React) │  │
│  │  • Model calls   │  │  • Telegram      │  │  • Terminal UI   │  │
│  │  • Tool dispatch │  │  • Discord       │  │  • Activity feed │  │
│  │  • Context mgmt  │  │  • Slack         │  │  • Session picker│  │
│  │  • Compression   │  │  • Webhook       │  │  • Prompts       │  │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘  │
│                                                                      │
│  ┌────────────────────────────────────────────────────────────────┐ │
│  │  Tools (one per file, registered via registry)                 │ │
│  │  • file_tools    • web_tools    • browser_tool                │ │
│  │  • code_execution • delegate     • mcp_tool                   │ │
│  │  • terminal      • approval      • environments               │ │
│  └────────────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────────────┘
```

## Component Responsibilities

### Paperclip (Control Plane)

| Component | Location | Responsibility |
|-----------|----------|----------------|
| Express Server | `server/` | REST API, auth, orchestration, activity logging |
| React UI | `ui/` | Dashboard, boards, issue management, company selection |
| Database Schema | `packages/db/` | Drizzle ORM schema, migrations |
| Shared Types | `packages/shared/` | Constants, validators, API paths |
| Adapters | `packages/adapters/` | Agent adapter implementations (Claude, Codex, Hermes, etc.) |
| Plugins | `packages/plugins/` | Plugin system packages |

### Hermes Agent (Execution Engine)

| Component | Location | Responsibility |
|-----------|----------|----------------|
| AIAgent | `hermes_agent/run_agent.py` | Core conversation loop, model calls |
| CLI | `hermes_agent/cli.py` | Interactive CLI, slash commands |
| State Store | `hermes_agent/hermes_state.py` | SQLite session storage, FTS5 search |
| Tools | `hermes_agent/tools/` | Tool implementations (file, web, browser, code, etc.) |
| Gateway | `hermes_agent/gateway/` | Messaging platform adapters (Telegram, Discord, Slack) |
| TUI | `hermes_agent/ui-tui/` | Ink-based terminal UI |
| Paperclip Worker | `hermes_agent/supabase_paperclip_worker.py` | Polls Supabase for tasks |

## Data Flow

### Issue Assignment Flow

```
1. Paperclip Board creates issue
   └─► Supabase: issues table (status: "queued")
       └─► Hermes Worker polls every 3s
           └─► Claims issue atomically (queued → running)
               └─► Executes task with Hermes agent
                   └─► Updates issue status (completed/failed)
                       └─► Posts result comment to Supabase
```

### API Key Authentication Flow

```
1. Paperclip generates API key
   └─► Supabase: agent_api_keys (hashed)
       └─► Sync script pulls to Hermes local SQLite
           └─► Hermes validates incoming requests against local hash
               └─► Updates last_used_at timestamp
```

### Session State Flow

```
1. Hermes starts conversation
   └─► Creates session in local SQLite
       └─► Each message appended to messages table
           └─► FTS5 index updated for search
               └─► Session metadata (tokens, cost) updated
                   └─► On compression: parent_session_id chain created
```

## Database Schemas

### Supabase (PostgreSQL) - Paperclip

| Table | Purpose |
|-------|---------|
| `agents` | Agent definitions, adapter types, company assignments |
| `companies` | Company records, settings, hierarchies |
| `issues` | Task assignments, status tracking, results |
| `agent_api_keys` | Per-agent API keys (hashed) |
| `agent_models` | Model configurations per agent |
| `projects` | Project definitions and workspaces |
| `project_workspaces` | Repository URLs, refs, working directories |
| `issue_comments` | Comments on issues |

### Local SQLite - Hermes

| Table | Purpose | Schema Version |
|-------|---------|----------------|
| `schema_version` | Tracks migration state | 8 |
| `sessions` | Session metadata, model config, costs | 8 |
| `messages` | Full conversation history | 8 |
| `messages_fts` | Full-text search virtual table | 8 |
| `agent_api_keys` | Hashed API keys (synced from Supabase) | 8 |
| `state_meta` | Key-value metadata store | 8 |

#### Messages Table Columns

| Column | Type | Purpose |
|--------|------|---------|
| `id` | INTEGER | Auto-increment primary key |
| `session_id` | TEXT | FK to sessions |
| `role` | TEXT | system/user/assistant/tool |
| `content` | TEXT | Message content |
| `tool_call_id` | TEXT | Tool call correlation ID |
| `tool_calls` | TEXT | JSON array of tool calls |
| `tool_name` | TEXT | Name of tool (for tool results) |
| `timestamp` | REAL | Unix timestamp |
| `token_count` | INTEGER | Token count for message |
| `finish_reason` | TEXT | API finish reason |
| `reasoning` | TEXT | Raw reasoning content |
| `reasoning_content` | TEXT | Structured reasoning content |
| `reasoning_details` | TEXT | JSON reasoning details |
| `codex_reasoning_items` | TEXT | JSON Codex-specific reasoning |

## Configuration

### Paperclip Configuration

| File | Purpose |
|------|---------|
| `config.json` | Server configuration |
| `.env` | Environment variables (DATABASE_URL, auth secrets) |
| `~/.paperclip/adapter-plugins.json` | External adapter plugin paths |

### Hermes Configuration

| File | Purpose |
|------|---------|
| `~/.hermes/config.yaml` | Agent settings, model, terminal backend |
| `~/.hermes/.env` | API keys (OpenRouter, tools, messaging) |
| `~/.hermes/state.db` | Local SQLite session store |
| `~/.hermes/skills/` | Installed skills |

## Deployment Modes

| Mode | Auth | Network | Best For |
|------|------|---------|----------|
| `local_trusted` | None | localhost only | Solo development |
| `authenticated` + `private` | Better Auth | Private network (Tailscale, VPN) | Team access |
| `authenticated` + `public` | Better Auth | Internet-facing | Cloud deployment |

## Troubleshooting

### SQLite Schema Issues

If you see `no such column` errors in Hermes:

```bash
# Delete old database (safe - only loses session history)
rm -f ~/.hermes/state.db

# Hermes will recreate with current schema on next run
hermes local
```

### Schema Version Mismatch

Check current schema version:

```bash
python -c "from hermes_state import SCHEMA_VERSION; print(SCHEMA_VERSION)"
```

Expected: `8`

### Database Verification

Verify all tables and columns exist:

```bash
cd ~/.hermes/hermes-agent && source venv/bin/activate
python -c "
from hermes_state import SessionDB
db = SessionDB()
tables = db._conn.execute(\"SELECT name FROM sqlite_master WHERE type='table'\").fetchall()
print('Tables:', [t[0] for t in tables])
"
```

## Key Design Decisions

1. **Local SQLite for sessions** - Fast, no network dependency, survives outages
2. **Supabase for control plane** - Relational data, RLS, real-time subscriptions
3. **One-way API key sync** - Supabase is authoritative source, local is cache
4. **Adapter plugin system** - External adapters loaded dynamically, no hardcoded imports
5. **Company-scoped changes** - All domain entities scoped to company with enforced boundaries

---

**Document Version**: 1.0
**Last Updated**: 2026-04-25
**Maintained By**: Paperclip Engineering