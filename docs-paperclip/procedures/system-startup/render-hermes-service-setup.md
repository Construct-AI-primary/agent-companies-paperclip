---
title: Hermes Adapter Configuration - Built-in Integration
summary: Guide for using the built-in hermes_local adapter in Paperclip
date: 2026-04-20
version: 2.0
status: active
---

# Hermes Adapter Configuration - Built-in Integration

## Overview

**IMPORTANT**: Paperclip has a **built-in Hermes adapter** (`hermes_local`) that does NOT require an external Hermes service or the `hermes_agent` submodule. This document explains the correct configuration approach.

## Design Summary

### What is hermes_local?

The `hermes_local` adapter is a **built-in adapter** in Paperclip that integrates Hermes Agent functionality directly into the Paperclip server through the `hermes-paperclip-adapter` npm package (version 0.2.0).

**Key Points**:
- ✅ Built into the Paperclip server (no external service needed)
- ✅ Installed via npm dependency: `"hermes-paperclip-adapter": "^0.2.0"`
- ✅ Registered in `server/src/adapters/registry.ts` as `hermesLocalAdapter`
- ✅ Requires Hermes CLI installed on the server (`pip install hermes-agent`)
- ✅ Uses the `hermes` command from the system PATH by default
- ❌ Does NOT require the `hermes_agent` git submodule
- ❌ Does NOT require `hermes_agent/run.sh` script
- ❌ Does NOT require a separate Hermes service deployment

## Problem Context (Historical)

**Previous Incorrect Approaches**:
1. ❌ Deploying Hermes as a separate service on Render
2. ❌ Using `hermesCommand: "/opt/render/project/src/hermes_agent/run.sh"` in adapter_config
3. ❌ Using the `process` adapter type with hermes_agent/run.sh
4. ❌ Trying to initialize the hermes_agent git submodule

**Why These Failed**:
- The `hermes_agent` directory is a git submodule with `/venv/` gitignored
- The venv doesn't exist on Render, causing `run.sh` to fail
- The build script explicitly skips hermes_agent: "hermes_local adapter is built into the server"

## Correct Configuration Approach

### Step 1: Ensure Hermes CLI is Installed on Render

The `hermes_local` adapter requires the `hermes` CLI command to be available on the Paperclip server.

**Add to `scripts/render-build.sh`** (after line 31):

```bash
echo "=== [BUILD-STEP-5.5] Installing Hermes Agent ==="
pip install hermes-agent
```

**Verify installation**:
```bash
hermes --version
```

### Step 2: Configure Agents with hermes_local Adapter

Agents should use the `hermes_local` adapter type with **minimal or empty** `adapter_config`:

**Correct Configuration**:
```json
{
  "adapter_type": "hermes_local",
  "adapter_config": {}
}
```

**Optional Configuration** (if needed):
```json
{
  "adapter_type": "hermes_local",
  "adapter_config": {
    "model": "anthropic/claude-opus-4.6",
    "timeoutSec": 300,
    "persistSession": true
  }
}
```

**DO NOT include `hermesCommand` field** - the adapter uses the system `hermes` command by default.

### Step 3: Automatic Migration

The Paperclip server includes automatic migration code in `server/src/index.ts` (lines 476-491) that converts old `process` adapter configurations to `hermes_local`:

```typescript
// Data migration: switch agents from process adapter (hermes_agent/run.sh) to hermes_local
const hermesMigrationResult = await db.execute(
  `UPDATE agents SET adapter_type = 'hermes_local', adapter_config = '{}' 
   WHERE adapter_type = 'process' AND adapter_config::text LIKE '%hermes_agent%'`
);
```

This migration runs automatically on server startup.

### Step 4: Remove hermesCommand from Existing Agents

If agents already have `hermesCommand` in their `adapter_config`, remove it:

**SQL to clean up**:
```sql
UPDATE agents 
SET adapter_config = adapter_config - 'hermesCommand'
WHERE adapter_type = 'hermes_local' 
  AND adapter_config::text LIKE '%hermesCommand%';
```

### Step 5: Verify Configuration

**Check agent configuration**:
```sql
SELECT
    id,
    name,
    adapter_type,
    adapter_config
FROM agents
WHERE adapter_type = 'hermes_local';
```

**Expected result**:
- `adapter_type`: `hermes_local`
- `adapter_config`: `{}` or minimal config without `hermesCommand`

## How hermes_local Works

### Architecture

```
Paperclip Server
  └─> server/src/adapters/registry.ts
       └─> hermesLocalAdapter (registered)
            └─> hermes-paperclip-adapter (npm package)
                 └─> execute() function
                      └─> spawns `hermes` CLI process
                           └─> Hermes Agent executes task
```

### Execution Flow

1. **Heartbeat triggers** agent execution
2. **Paperclip server** calls `hermesLocalAdapter.execute()`
3. **Adapter spawns** `hermes` CLI process with task prompt
4. **Hermes Agent** executes task using its tools
5. **Result returned** to Paperclip via stdout
6. **Paperclip stores** result and updates issue status

### Configuration Options

The `hermes-paperclip-adapter` supports these `adapter_config` fields:

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| model | string | (Hermes default) | LLM model in provider/model format |
| provider | string | auto | API provider (auto-detected from model) |
| timeoutSec | number | 300 | Execution timeout in seconds |
| graceSec | number | 10 | Grace period after SIGTERM |
| toolsets | string | (all) | Comma-separated toolsets to enable |
| persistSession | boolean | true | Resume sessions across heartbeats |
| worktreeMode | boolean | false | Use git worktree for isolated changes |
| checkpoints | boolean | false | Enable filesystem checkpoints |
| verbose | boolean | false | Enable verbose output |
| extraArgs | string[] | [] | Additional CLI arguments |
| env | object | {} | Extra environment variables |

**DO NOT use `hermesCommand`** - it's only for custom Hermes installations in non-standard locations.

## Environment Variables

The Hermes CLI requires API keys to be configured. These should be set in the Render environment:

**Required**:
```bash
OPENROUTER_API_KEY=sk-or-v1-...
```

**Optional** (depending on tools used):
```bash
GITHUB_TOKEN=ghp_...
EXA_API_KEY=...
PARALLEL_API_KEY=...
FIRECRAWL_API_KEY=...
```

Hermes reads these from `~/.hermes/.env` or system environment variables.

## Troubleshooting

### Error: "hermes: command not found"

**Cause**: Hermes CLI not installed on the server
**Solution**: Add `pip install hermes-agent` to `scripts/render-build.sh`

### Error: "venv/bin/activate: No such file or directory"

**Cause**: Agent has old `hermesCommand` configuration pointing to `hermes_agent/run.sh`
**Solution**: Run the SQL cleanup command to remove `hermesCommand` field

### Error: "OPENROUTER_API_KEY not set"

**Cause**: Hermes requires an LLM API key
**Solution**: Set `OPENROUTER_API_KEY` in Render environment variables

### Agent execution times out

**Cause**: Default timeout may be too short for complex tasks
**Solution**: Increase `timeoutSec` in `adapter_config`:
```json
{
  "adapter_type": "hermes_local",
  "adapter_config": {
    "timeoutSec": 600
  }
}
```

## Migration from Old Configurations

### From process adapter

**Old configuration**:
```json
{
  "adapter_type": "process",
  "adapter_config": {
    "command": "/opt/render/project/src/hermes_agent/run.sh",
    "args": ["{{prompt}}"]
  }
}
```

**New configuration**:
```json
{
  "adapter_type": "hermes_local",
  "adapter_config": {}
}
```

**Migration**: Automatic on server startup (see Step 3)

### From http adapter (external Hermes service)

**Old configuration**:
```json
{
  "adapter_type": "http",
  "adapter_config": {
    "url": "https://hermes-service.onrender.com/api/execute"
  }
}
```

**New configuration**:
```json
{
  "adapter_type": "hermes_local",
  "adapter_config": {}
}
```

**Migration**: Manual SQL update required:
```sql
UPDATE agents
SET adapter_type = 'hermes_local', adapter_config = '{}'
WHERE adapter_type = 'http'
  AND adapter_config->>'url' LIKE '%hermes%';
```

## Benefits of Built-in Adapter

✅ **Simpler deployment** - No separate Hermes service needed
✅ **Lower latency** - Direct process execution, no HTTP overhead
✅ **Better resource usage** - Hermes processes only run when needed
✅ **Easier maintenance** - Single deployment to manage
✅ **Automatic updates** - Hermes version controlled via npm package
✅ **Session persistence** - Built-in session management
✅ **Full tool access** - All 30+ Hermes tools available

## When to Use External Hermes Service

You might still want a separate Hermes service if:

- ❌ You need Hermes for non-Paperclip use cases (Telegram bots, Discord, etc.)
- ❌ You want to isolate Hermes resource usage from Paperclip
- ❌ You need different Hermes versions for different agents
- ❌ You have custom Hermes modifications not in the npm package

For most Paperclip deployments, the **built-in `hermes_local` adapter is the recommended approach**.

## Related Documents

- [Paperclip Adapter System](../../doc/SPEC-implementation.md#adapters)
- [Agent Configuration](../agents/hermes-agent-setup-procedure.md)
- [Render Build Script](../../../scripts/render-build.sh)
- [Server Adapter Registry](../../../server/src/adapters/registry.ts)

## Summary

**DO NOT deploy Hermes as a separate service**. Use the built-in `hermes_local` adapter with:
1. Hermes CLI installed on the Paperclip server (`pip install hermes-agent`)
2. Agent `adapter_type` set to `hermes_local`
3. Empty or minimal `adapter_config` (no `hermesCommand` field)
4. Required API keys in environment variables

---

**Document Version**: 2.0
**Last Updated**: 2026-04-20
**Author**: Cline AI Assistant
**Review Cycle**: As needed
