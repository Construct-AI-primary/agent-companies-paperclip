which will ---
title: Production Operations Procedure
date: 2026-04-07
status: Active
scope: Paperclip on Render + Hermes local agent runtime
---

# Production Operations Procedure

This document defines how to operate Paperclip in production when the server is hosted on Render and agents run via the local Hermes runtime.

## Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│ Render (paperclip-render.onrender.com)                  │
│ ┌─────────────────────────────────────────────────────┐ │
│ │ Paperclip Control Plane (ALWAYS RUNNING)            │ │
│ │ - Web UI (dashboard)                                │ │
│ │ - REST API                                          │ │
│ │ - Embedded or hosted PostgreSQL                     │ │
│ │ - Companies, agents, issues, tasks                  │ │
│ └─────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
         ↕ HTTPS API calls (outbound from local machine)
┌─────────────────────────────────────────────────────────┐
│ Your Machine (localhost)                                │
│ ┌─────────────────────────────────────────────────────┐ │
│ │ Hermes Agent Runtime (hermes_local adapter)         │ │
│ │ - OPENROUTER_API_KEY in hermes_agent/.env          │ │
│ │ - Connects to Paperclip on Render                   │ │
│ │ - Executes agent heartbeats on-demand               │ │
│ │ - Configured via ~/.hermes/config.yaml              │ │
│ └─────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

**Key principle:** Paperclip on Render is the source of truth. Hermes on your local machine is the agent executor. You do NOT need to run Paperclip locally for production use.

## Network Architecture & Ngrok Requirements

### Architecture Options

There are two possible architectures depending on where you want agents to execute:

#### Option A: Agents Run Locally (HP ZBook) - **REQUIRES NGROK**
```
┌─────────────────────────────────────────────────────────┐
│ Render (paperclip-render.onrender.com)                  │
│ ┌─────────────────────────────────────────────────────┐ │
│ │ Paperclip Control Plane (ALWAYS RUNNING)            │ │
│ │ - Web UI (dashboard)                                │ │
│ │ - REST API                                          │ │
│ │ - Embedded or hosted PostgreSQL                     │ │
│ │ - Companies, agents, issues, tasks                  │ │
│ └─────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
         ↕ HTTPS API calls + Webhooks (bidirectional)
┌─────────────────────────────────────────────────────────┐
│ Ngrok Tunnel (ngrok.io)                                │
│ ┌─────────────────────────────────────────────────────┐ │
│ │ Public HTTPS endpoint → Local machine              │ │
│ └─────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
         ↕ HTTPS API calls (inbound to local machine)
┌─────────────────────────────────────────────────────────┐
│ Your Machine (HP ZBook - localhost)                     │
│ ┌─────────────────────────────────────────────────────┐ │
│ │ Hermes Agent Runtime (hermes_local adapter)         │ │
│ │ - OPENROUTER_API_KEY in hermes_agent/.env          │ │
│ │ - Receives webhooks from Paperclip                 │ │
│ │ - Executes tasks and creates/edits local files     │ │
│ │ - Configured via ~/.hermes/config.yaml              │ │
│ └─────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

#### Option B: Agents Run on Render - **NO NGROK NEEDED**
```
┌─────────────────────────────────────────────────────────┐
│ Render (paperclip-render.onrender.com)                  │
│ ┌─────────────────────────────────────────────────────┐ │
│ │ Paperclip Control Plane + Agent Runtime             │ │
│ │ - Web UI (dashboard)                                │ │
│ │ - REST API                                          │ │
│ │ - Embedded or hosted PostgreSQL                     │ │
│ │ - Companies, agents, issues, tasks                  │ │
│ │ - Agent execution (files created on Render)         │ │
│ └─────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

### Current Setup: Option A (Local Agent Execution)

**You want agents to run on your HP ZBook and create/edit files locally.** This requires ngrok for bidirectional communication:

1. **Outbound requests**: Hermes agents poll Paperclip for work (heartbeats)
2. **Inbound webhooks**: Paperclip sends task assignments and updates to local Hermes
3. **Ngrok provides**: Public HTTPS endpoint that forwards to your local Hermes server

### Ngrok Setup for Local Agent Execution

```bash
# Install ngrok
brew install ngrok  # or download from ngrok.com

# Authenticate ngrok (get token from ngrok dashboard)
ngrok config add-authtoken YOUR_NGROK_TOKEN

# Start ngrok tunnel to Hermes port (adjust port as needed)
ngrok http 3001  # or whatever port Hermes uses for webhooks

# Copy the ngrok URL (e.g., https://abc123.ngrok.io)
# Configure this URL in Paperclip as the webhook endpoint for your agents
```

### How Paperclip Communicates with Local Devices

Paperclip communicates with local agents through **heartbeats** - short execution windows where agents wake up, check for work, perform tasks, and exit. This is **event-driven polling**, not continuous communication.

#### Heartbeat Mechanism

- **Outbound polling**: Local Hermes agents periodically poll Paperclip's API to check for work
- **Event triggers**: Agents wake up on scheduled intervals, task assignments, status changes, or @-mentions
- **Context injection**: Paperclip provides work context through environment variables:
  - `PAPERCLIP_AGENT_ID`: Agent identity
  - `PAPERCLIP_COMPANY_ID`: Company context
  - `PAPERCLIP_TASK_ID`: Specific task that triggered the heartbeat
  - `PAPERCLIP_WAKE_REASON`: Why the heartbeat was triggered
  - `PAPERCLIP_API_KEY`: Short-lived JWT for API access

#### Heartbeat Procedure

Each heartbeat follows this standardized procedure:

1. **Identity check**: `GET /api/agents/me` to get agent details
2. **Work discovery**: `GET /api/agents/me/inbox-lite` for compact task assignments
3. **Task prioritization**: Work on `in_progress` first, then `todo`, skip `blocked`
4. **Atomic checkout**: Claim work to prevent conflicts
5. **Task execution**: Perform assigned work using domain skills
6. **Status updates**: Report progress and completion back to Paperclip

#### Key Architecture Benefits

- **Firewall-friendly**: Only outbound HTTPS connections required
- **Event-driven**: Agents don't run continuously - they wake up for specific work
- **Atomic operations**: Task checkout prevents double-work
- **Audit trail**: Every action logged with run IDs for traceability
- **Secure**: Short-lived JWTs, no persistent inbound exposure

### When Ngrok Is NOT Required

Ngrok is only NOT required if you choose **Option B** (agents run on Render infrastructure):
- Files created on Render server, not your local machine
- No inbound connections needed to your HP ZBook
- All execution happens in Render's cloud environment

### Recommendation for Your Use Case

Since you want **local file creation/editing on your HP ZBook**, use **Option A with ngrok**. This gives you:
- ✅ Local file access and editing
- ✅ Direct control over agent execution environment
- ✅ Ability to work with local repositories and tools
- ⚠️ Requires ngrok for webhook communication

## Environment Variables

### Render (set in Render Dashboard)

| Variable | Required | How to Generate |
|----------|----------|-----------------|
| `DATABASE_URL` | Yes | From your PostgreSQL provider (Render/Supebase) |
| `PAPERCLIP_AGENT_JWT_SECRET` | Yes | `openssl rand -hex 32` |
| `BETTER_AUTH_SECRET` | Yes | `openssl rand -hex 32` |
| `NODE_ENV` | Yes | `production` |
| `HOST` | Yes | `0.0.0.0` |
| `SERVE_UI` | Yes | `true` |
| `BETTER_AUTH_BASE_URL` | Yes | `https://paperclip-render.onrender.com` |
| `PAPERCLIP_MIGRATION_AUTO_APPLY` | Yes | `true` |
| `PAPERCLIP_DB_BACKUP_ENABLED` | Yes | `true` |

### Hermes Local (set in `hermes_agent/.env`)

| Variable | Required | Purpose |
|----------|----------|---------|
| `OPENROUTER_API_KEY` | Yes | LLM API access (qwen/qwen3.6-pro) |

**NOT needed on Render:** `OPENROUTER_API_KEY` — this is only used by the local Hermes runtime.

## Starting / Stopping

### Paperclip on Render

- **Automatic** — Render manages the server lifecycle
- **Redeploy:** Push to `master` branch or trigger manual redeploy in Render dashboard
- **Logs:** Render Dashboard → Logs tab
- **Health check:** `curl https://paperclip-render.onrender.com/api/health`

### Hermes Local Agent Runtime

```bash
cd hermes_agent
source venv/bin/activate

# Option 1: Interactive CLI
hermes

# Option 2: Gateway mode (messaging platforms)
hermes gateway

# Option 3: Connect to a specific company's agents
paperclipai agent local-cli <agent-id-or-name> --company-id <company-id>
```

### Important: Do NOT Run Paperclip Locally in Production

When Paperclip is deployed to Render:
- **Do NOT** run `pnpm dev` on the same machine for production agent work
- **Do NOT** use `rm -rf ~/.paperclip/instances/default/db` — this only resets local dev data
- **Use the Render URL** for all agent configuration: `https://paperclip-render.onrender.com`

If you need to work locally:
```bash
# Only for development / testing
pnpm dev
# Access at http://localhost:3100
# This creates a SEPARATE local database — not connected to Render
```

## Agent Configuration in Production

### Adding a New Agent to an Existing Company

1. Create the agent definition in Paperclip via API or UI
2. Set `adapter_type: hermes_local`
3. Configure `adapter_config` with the correct model
4. On the Hermes machine, run the setup to register the agent:
```bash
paperclipai agent local-cli <agent-name> --company-id <company-id>
```

### Changing Agent Model

Update the agent's `adapter_config.model` in the database or via the API:

```sql
UPDATE agents
SET adapter_config = jsonb_set(adapter_config, '{model}', '"openrouter/qwen/qwen3.6-pro"')
WHERE company_id = (SELECT id FROM companies WHERE slug = 'knowledgeforge-ai');
```

Then restart the Hermes runtime to pick up the change.

## Knowledge Management

### Daily Operations

- Agents automatically append to `docs-construct-ai/memory/YYYY-MM-DD.md`
- Chat history from `/Users/Chat-history/` is indexed periodically
- KnowledgeForge Knowledge Sync issue runs on schedule (recurring daily)

### Monthly Knowledge Index Rebuild

```bash
cd docs-construct-ai
python3 scripts/build-knowledge-index.py --root . --output KNOWLEDGE-INDEX.json
commit and push the updated index
```

### Adding New Knowledge

1. Add markdown files to the appropriate `docs-construct-ai/` subdirectory
2. Ensure YAML frontmatter includes `memory_layer`, `gigabrain_tags`, `last_updated`
3. Run the knowledge index rebuild (see above)
4. Push to trigger Render redeploy

## External Repo Workflow

KnowledgeForge agents can review and edit code in external repositories. This section covers how to set up and manage access to the main Construct AI codebases.

### Target Repositories

| Repository | Purpose | Local Path |
|------------|---------|------------|
| `https://github.com/Construct-AI-primary/construct_ai.git` | Main application | `~/.hermes/workspaces/construct_ai/` |
| `https://github.com/Construct-AI-primary/construct_ai-mobile.git` | Mobile package | `~/.hermes/workspaces/construct_ai-mobile/` |

### Initial Setup

Clone both repositories to the Hermes workspace directory:

```bash
mkdir -p ~/.hermes/workspaces
git clone https://github.com/Construct-AI-primary/construct_ai.git ~/.hermes/workspaces/construct_ai
git clone https://github.com/Construct-AI-primary/construct_ai-mobile.git ~/.hermes/workspaces/construct_ai-mobile
```

### Registering Projects in Paperclip

For agents to access these repos, create projects in the Paperclip UI:

1. Go to KnowledgeForge → **Projects** → **Create Project**
2. Name: "Construct AI Main"
3. Set `cwd` to `~/.hermes/workspaces/construct_ai/`
4. Repeat for "Construct AI Mobile" with `cwd` pointing to `~/.hermes/workspaces/construct_ai-mobile/`
5. Assign relevant agents to each project

### Creating Recurring Issues

In Paperclip, work is managed through **Issues**, not Tasks:

1. Go to KnowledgeForge → **Issues** → **Create Issue**
2. Title: "Knowledge Sync — Daily"
3. Description: "Scan docs-construct-ai/ for new or changed documents. Update KNOWLEDGE-INDEX.json. Append daily learnings to memory/YYYY-MM-DD.md."
4. Set recurrence: **Daily**
5. Assign to: `KnowledgeForge Doc Analyzer`
6. Save

For repo sync, create a separate issue:
1. Title: "Repo Sync — Daily"
2. Description: "Pull latest from origin/main for construct_ai and construct_ai-mobile workspaces."
3. Set recurrence: **Daily**
4. Assign to: `KnowledgeForge Doc Analyzer`

### Agent Task Execution

When an agent is assigned a task involving these repos:

1. Hermes resolves the project's `cwd` to the local clone path
2. Agent reads/writes files within that directory
3. Agent creates commits and opens PRs via git commands
4. Task results are reported back to Paperclip

### Keeping Repositories in Sync

Add a periodic sync task to keep local clones updated:

```bash
# Add to Hermes cron or run manually
cd ~/.hermes/workspaces/construct_ai && git pull --rebase origin main
cd ~/.hermes/workspaces/construct_ai-mobile && git pull --rebase origin main
```

Or create a Paperclip issue "Repo Sync" assigned to a KnowledgeForge agent that runs daily.

### Branch Management

Agents should follow this convention when working on external repos:

- **Feature branches**: `knowledgeforge/<task-slug>` (e.g., `knowledgeforge/fix-auth-validation`)
- **PR titles**: Prefix with `[KnowledgeForge]` for traceability
- **Commit messages**: Include task reference from Paperclip

### Security Considerations

- Agent git operations use the local machine's git credentials
- Ensure SSH keys or GitHub tokens are configured for push access
- Agents should NOT commit API keys, secrets, or credentials
- Review agent-created PRs before merging

## Troubleshooting

### Agent Not Responding

1. Check Hermes is running on the local machine
2. Verify `OPENROUTER_API_KEY` is set in `hermes_agent/.env`
3. Check Paperclip on Render is healthy: `curl https://paperclip-render.onrender.com/api/health`
4. Review Hermes logs for errors

### Paperclip on Render Failing

1. Check Render logs in the dashboard
2. Verify all 3 critical env vars are set (DATABASE_URL, AGENT_JWT_SECRET, BETTER_AUTH_SECRET)
3. Check database connectivity from Render
4. If needed, trigger a manual redeploy

### Knowledge Sync Failures

1. Verify `docs-construct-ai/` directory is accessible
2. Run `python3 scripts/build-knowledge-index.py --root docs-construct-ai --output docs-construct-ai/KNOWLEDGE-INDEX.json`
3. Check for new documents missing frontmatter

## Security

### Agent API Keys

- Agent API keys are created in the Paperclip dashboard
- Keys are hashed at rest in the `agent_api_keys` table
- Keys must not be shared across agents
- Rotate keys periodically

### OPENROUTER_API_KEY

- Stored in `hermes_agent/.env` — NOT committed to git
- NOT stored in Render environment variables
- Rotate if compromised

### Database

- Use connection pooling for hosted PostgreSQL
- Enable SSL for database connections
- `PAPERCLIP_DB_BACKUP_ENABLED: true` is set by default

## Deployment Checklist

When deploying new changes to Render:

- [ ] Changes committed to `master` branch
- [ ] Any new env vars added in Render dashboard
- [ ] Database migrations applied (auto via PAPERCLIP_MIGRATION_AUTO_APPLY)
- [ ] Health check passes: `curl https://paperclip-render.onrender.com/api/health`
- [ ] Agent smoke test: create test issue, verify heartbeat runs
- [ ] Knowledge index rebuilt if docs changed