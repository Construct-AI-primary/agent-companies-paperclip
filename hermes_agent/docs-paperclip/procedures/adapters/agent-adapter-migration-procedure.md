---
title: Agent Adapter Migration Procedure
summary: Step-by-step guide for migrating agents between different adapter types
date: 2026-04-20
version: 1.0
status: active
---

# Agent Adapter Migration Procedure

## Overview

This document provides comprehensive procedures for migrating Paperclip agents from one adapter type to another. Common scenarios include migrating from external services to built-in adapters, upgrading adapter versions, or consolidating infrastructure.

## Supported Adapter Types

### Built-in Adapters
- **claude_local** - Claude Desktop integration (local process)
- **codex_local** - OpenAI Codex integration (local process)
- **cursor_local** - Cursor IDE integration (local process)
- **gemini_local** - Google Gemini integration (local process)
- **opencode_local** - OpenCode integration (local process)
- **pi_local** - Pi integration (local process)
- **hermes_local** - Hermes Agent integration (local process)
- **openclaw_gateway** - OpenClaw gateway integration

### Generic Adapters
- **http** - Generic HTTP API adapter
- **process** - Generic process execution adapter (legacy)

## Migration Scenarios

### Scenario 1: HTTP to hermes_local

**Use Case**: Migrating from external Hermes service to built-in adapter

**Prerequisites**:
- Hermes CLI installed on server (`pip install hermes-agent`)
- API keys configured in environment variables

**Migration Steps**:

1. **Identify agents to migrate**:
```sql
SELECT
    id,
    name,
    adapter_type,
    adapter_config->>'url' as current_url,
    adapter_config->'payloadTemplate'->>'model' as current_model
FROM agents
WHERE adapter_type = 'http'
  AND (adapter_config->>'url' LIKE '%hermes%' 
       OR adapter_config->>'url' LIKE '%srv-%');
```

2. **Backup current configuration**:
```sql
CREATE TABLE agents_backup_20260420 AS
SELECT * FROM agents
WHERE adapter_type = 'http';
```

3. **Execute migration**:
```sql
UPDATE agents
SET 
    adapter_type = 'hermes_local',
    adapter_config = CASE
        WHEN adapter_config->'payloadTemplate'->>'model' IS NOT NULL THEN
            jsonb_build_object(
                'model', adapter_config->'payloadTemplate'->>'model',
                'timeoutSec', COALESCE((adapter_config->>'timeoutMs')::int / 1000, 300),
                'persistSession', true
            )
        ELSE
            jsonb_build_object(
                'timeoutSec', 300,
                'persistSession', true
            )
    END
WHERE adapter_type = 'http'
  AND (adapter_config->>'url' LIKE '%hermes%' 
       OR adapter_config->>'url' LIKE '%srv-%');
```

4. **Verify migration**:
```sql
SELECT
    id,
    name,
    adapter_type,
    adapter_config
FROM agents
WHERE adapter_type = 'hermes_local';
```

5. **Test agent execution**:
- Assign a test issue to a migrated agent
- Trigger heartbeat
- Monitor logs for successful execution

### Scenario 2: process to hermes_local

**Use Case**: Migrating from legacy process adapter with hermes_agent/run.sh

**Prerequisites**:
- Hermes CLI installed on server
- Server startup includes automatic migration (already implemented)

**Migration Steps**:

The migration is **automatic** on server startup via `server/src/index.ts`:

```typescript
const hermesMigrationResult = await db.execute(
  `UPDATE agents SET adapter_type = 'hermes_local', adapter_config = '{}' 
   WHERE adapter_type = 'process' AND adapter_config::text LIKE '%hermes_agent%'`
);
```

**Manual verification**:
```sql
SELECT id, name, adapter_type, adapter_config
FROM agents
WHERE adapter_type = 'process';
```

If any remain, manually migrate:
```sql
UPDATE agents
SET adapter_type = 'hermes_local', adapter_config = '{}'
WHERE adapter_type = 'process'
  AND adapter_config::text LIKE '%hermes_agent%';
```

### Scenario 3: hermes_local Configuration Cleanup

**Use Case**: Removing incorrect hermesCommand field from adapter_config

**Migration Steps**:

1. **Identify affected agents**:
```sql
SELECT
    id,
    name,
    adapter_config->>'hermesCommand' as hermes_command
FROM agents
WHERE adapter_type = 'hermes_local'
  AND adapter_config::text LIKE '%hermesCommand%';
```

2. **Remove hermesCommand field**:
```sql
UPDATE agents 
SET adapter_config = adapter_config - 'hermesCommand'
WHERE adapter_type = 'hermes_local' 
  AND adapter_config::text LIKE '%hermesCommand%';
```

3. **Verify cleanup**:
```sql
SELECT id, name, adapter_config
FROM agents
WHERE adapter_type = 'hermes_local'
  AND adapter_config::text LIKE '%hermesCommand%';
-- Should return 0 rows
```

### Scenario 4: claude_local to hermes_local

**Use Case**: Switching from Claude to Hermes for additional tool capabilities

**Migration Steps**:

1. **Backup and identify**:
```sql
SELECT id, name, adapter_type, adapter_config
FROM agents
WHERE adapter_type = 'claude_local';
```

2. **Migrate with model preservation**:
```sql
UPDATE agents
SET 
    adapter_type = 'hermes_local',
    adapter_config = jsonb_build_object(
        'model', COALESCE(adapter_config->>'model', 'anthropic/claude-opus-4.6'),
        'timeoutSec', COALESCE((adapter_config->>'timeoutSec')::int, 300),
        'persistSession', true
    )
WHERE adapter_type = 'claude_local';
```

3. **Verify and test**:
```sql
SELECT id, name, adapter_type, adapter_config
FROM agents
WHERE adapter_type = 'hermes_local';
```

### Scenario 5: Generic HTTP to Built-in Adapter

**Use Case**: Migrating from generic HTTP adapter to specific built-in adapter

**Migration Steps**:

1. **Identify target adapter** based on HTTP endpoint
2. **Map configuration fields** from HTTP to target adapter
3. **Execute migration** with field mapping
4. **Test thoroughly** as configuration schemas differ

**Example - HTTP to claude_local**:
```sql
UPDATE agents
SET 
    adapter_type = 'claude_local',
    adapter_config = jsonb_build_object(
        'model', adapter_config->'payloadTemplate'->>'model',
        'timeoutSec', COALESCE((adapter_config->>'timeoutMs')::int / 1000, 300)
    )
WHERE adapter_type = 'http'
  AND adapter_config->>'url' LIKE '%claude%';
```

## General Migration Checklist

### Pre-Migration
- [ ] Identify all agents to be migrated
- [ ] Document current adapter configurations
- [ ] Create database backup
- [ ] Verify target adapter is available and configured
- [ ] Check for any active tasks assigned to agents
- [ ] Notify stakeholders of planned migration

### Migration Execution
- [ ] Run diagnostic queries to understand current state
- [ ] Execute migration SQL with appropriate WHERE clause
- [ ] Verify row count matches expected agents
- [ ] Check migrated agent configurations
- [ ] Validate no unexpected side effects

### Post-Migration
- [ ] Test agent execution with sample tasks
- [ ] Monitor logs for errors or warnings
- [ ] Verify performance and response times
- [ ] Update documentation if needed
- [ ] Clean up old infrastructure (if applicable)
- [ ] Archive backup tables after successful validation

## Configuration Field Mapping

### Common Fields Across Adapters

| Source Field | Target Field | Transformation |
|--------------|--------------|----------------|
| `url` | N/A | Removed (built-in adapters don't use URLs) |
| `timeoutMs` | `timeoutSec` | Divide by 1000 |
| `payloadTemplate.model` | `model` | Direct copy |
| `method` | N/A | Removed (adapter-specific) |
| `headers` | N/A | Removed (adapter-specific) |

### Adapter-Specific Fields

**hermes_local**:
- `model` - LLM model in provider/model format
- `provider` - API provider (auto-detected)
- `timeoutSec` - Execution timeout
- `graceSec` - Grace period after SIGTERM
- `toolsets` - Comma-separated toolsets
- `persistSession` - Resume sessions across heartbeats
- `worktreeMode` - Use git worktree
- `checkpoints` - Enable filesystem checkpoints
- `verbose` - Enable verbose output
- `extraArgs` - Additional CLI arguments
- `env` - Extra environment variables

**claude_local**:
- `model` - Claude model name
- `timeoutSec` - Execution timeout
- `maxTokens` - Maximum response tokens
- `temperature` - Sampling temperature

**http**:
- `url` - API endpoint URL
- `method` - HTTP method (GET, POST, etc.)
- `timeoutMs` - Request timeout in milliseconds
- `headers` - Custom HTTP headers
- `payloadTemplate` - Request body template

## Rollback Procedures

### Rollback from Backup Table

If migration fails or causes issues:

```sql
-- Restore from backup
UPDATE agents a
SET 
    adapter_type = b.adapter_type,
    adapter_config = b.adapter_config
FROM agents_backup_20260420 b
WHERE a.id = b.id;

-- Verify rollback
SELECT COUNT(*) FROM agents a
JOIN agents_backup_20260420 b ON a.id = b.id
WHERE a.adapter_type = b.adapter_type;
```

### Rollback Individual Agent

```sql
UPDATE agents
SET 
    adapter_type = 'http',
    adapter_config = '{"url": "http://old-service:3100/api/execute", "method": "POST"}'
WHERE id = 'agent-id-here';
```

## Troubleshooting

### Migration Found No Rows

**Cause**: WHERE clause doesn't match any agents
**Solution**: 
1. Run diagnostic query without WHERE clause
2. Check adapter_type values (case sensitivity)
3. Verify URL patterns match actual data

### Agents Not Executing After Migration

**Cause**: Missing adapter dependencies or configuration
**Solution**:
1. Check server logs for adapter errors
2. Verify adapter is installed (for built-in adapters)
3. Confirm API keys are configured
4. Test adapter with simple task

### Configuration Fields Missing

**Cause**: Field mapping incomplete
**Solution**:
1. Review adapter configuration documentation
2. Add missing required fields
3. Use default values where appropriate

### Performance Degradation

**Cause**: Adapter not optimized for workload
**Solution**:
1. Adjust timeout settings
2. Enable session persistence
3. Consider resource allocation
4. Monitor adapter-specific metrics

## Best Practices

1. **Always backup before migration** - Create backup table or export data
2. **Test on non-production first** - Validate migration on staging environment
3. **Migrate in batches** - Don't migrate all agents at once
4. **Monitor closely** - Watch logs and metrics during migration
5. **Document changes** - Record what was migrated and why
6. **Communicate** - Inform stakeholders of migration timeline
7. **Have rollback plan** - Know how to revert if needed
8. **Validate thoroughly** - Test agent execution before declaring success

## Related Documents

- [Hermes Adapter Configuration](../system-startup/render-hermes-service-setup.md)
- [Adapter URL Migration](./adapter-url-migration-procedure.md)
- [Agent Setup Procedure](../agents/hermes-agent-setup-procedure.md)
- [Server Adapter Registry](../../../server/src/adapters/registry.ts)

## Appendix: SQL Migration Templates

### Template: Generic Adapter Migration

```sql
-- Step 1: Backup
CREATE TABLE agents_backup_YYYYMMDD AS
SELECT * FROM agents WHERE adapter_type = 'SOURCE_TYPE';

-- Step 2: Identify
SELECT id, name, adapter_type, adapter_config
FROM agents
WHERE adapter_type = 'SOURCE_TYPE';

-- Step 3: Migrate
UPDATE agents
SET 
    adapter_type = 'TARGET_TYPE',
    adapter_config = jsonb_build_object(
        'field1', adapter_config->>'sourceField1',
        'field2', 'default_value'
    )
WHERE adapter_type = 'SOURCE_TYPE';

-- Step 4: Verify
SELECT id, name, adapter_type, adapter_config
FROM agents
WHERE adapter_type = 'TARGET_TYPE';

-- Step 5: Cleanup (after validation)
DROP TABLE agents_backup_YYYYMMDD;
```

---

**Document Version**: 1.0
**Last Updated**: 2026-04-20
**Author**: Cline AI Assistant
**Review Cycle**: Quarterly or as needed
