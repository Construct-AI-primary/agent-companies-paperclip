# Agent and Entity Deletion Procedure

**Document Type**: Procedure  
**Last Updated**: 2026-04-22  
**Source**: `packages/db/src/schema/index.ts`

## Purpose

This procedure provides step-by-step instructions for safely deleting agents and related entities from the Paperclip database without violating foreign key constraints.

## Overview

The database has tables with FK dependencies on `agents.id`. Always delete in the correct order (children before parents).

## Actual Tables Referencing `agents.id`

Based on the actual schema:

| Table | FK Column | Type |
|-------|-----------|------|
| `heartbeat_runs` | `agent_id` | Direct FK |
| `heartbeat_run_events` | `run_id → heartbeat_runs.id` | Chained FK |
| `agent_task_sessions` | `agent_id` | Direct FK |
| `execution_workspaces` | `agent_id` | Direct FK |
| `agent_runtime_state` | `agent_id` | Direct FK |
| `agent_wakeup_requests` | `agent_id` | Direct FK |
| `agent_config_revisions` | `agent_id`, `created_by_agent_id` | Multiple FKs |
| `agent_api_keys` | `agent_id` | Direct FK |
| `agent_skill_assignments` | `agent_id` | Direct FK ⚠️ **MISSING FROM SCHEMA** |
| `issues` | `assignee_id` | Nullable FK |
| `agents` | `reports_to` | Self-referential FK (nullable) |
| `activity_log` | `actor_id` | Nullable FK |

**Note**: There is NO `agent_skills` or `agent_models` table in the current schema.

## Deletion Order

### Agent Deletion Order (12 steps)

| Order | Table | Action | Notes |
|-------|-------|--------|-------|
| 1 | `heartbeat_run_events` | DELETE | Chained via heartbeat_runs |
| 2 | `heartbeat_runs` | DELETE | Direct FK |
| 3 | `execution_workspaces` | DELETE | Direct FK |
| 4 | `agent_task_sessions` | DELETE | Direct FK |
| 5 | `agent_runtime_state` | DELETE | Direct FK |
| 6 | `agent_wakeup_requests` | DELETE | Direct FK |
| 7 | `agent_config_revisions` | DELETE | Both agent_id and created_by_agent_id |
| 8 | `agent_api_keys` | DELETE | Direct FK |
| 9 | `issues` | UPDATE | Set assignee_id = NULL (nullable) |
| 10 | `agents` | UPDATE | Set reports_to = NULL (self-ref) |
| 11 | `activity_log` | UPDATE | Set actor_id = NULL (nullable) |
| 12 | `agents` | DELETE | Final deletion |

## Step-by-Step Procedure

### Step 1: Identify Records to Delete

```sql
-- For agents by name
SELECT id, name, company_id, created_at, updated_at
FROM agents
WHERE name = 'agent-name' AND company_id = 'company-uuid';

-- For duplicate agents (keep most recent)
SELECT id, name, company_id, updated_at
FROM agents
WHERE name IN (
    SELECT name FROM agents GROUP BY name HAVING COUNT(*) > 1
)
ORDER BY name, updated_at DESC;
```

### Step 2: Create Temporary Table

```sql
CREATE TEMP TABLE to_delete (id TEXT);
INSERT INTO to_delete
SELECT id::TEXT FROM agents WHERE [your condition];
```

### Step 3: Delete in Dependency Order

```sql
-- 1. Delete heartbeat events (chained via heartbeat_runs)
DELETE FROM heartbeat_run_events 
WHERE run_id IN (
    SELECT hr.id::TEXT FROM heartbeat_runs hr 
    WHERE hr.agent_id::TEXT IN (SELECT id FROM to_delete)
);

-- 2. Delete heartbeat runs
DELETE FROM heartbeat_runs 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 3. Delete execution workspaces
DELETE FROM execution_workspaces 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 4. Delete agent task sessions
DELETE FROM agent_task_sessions 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 5. Delete agent runtime state
DELETE FROM agent_runtime_state 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 6. Delete agent wakeup requests
DELETE FROM agent_wakeup_requests 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 7. Delete agent config revisions (both FKs)
DELETE FROM agent_config_revisions 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
   OR created_by_agent_id::TEXT IN (SELECT id FROM to_delete);

-- 8. Delete agent API keys
DELETE FROM agent_api_keys
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 9. Delete agent skill assignments ⚠️ **CRITICAL - MISSING FROM SCHEMA**
DELETE FROM agent_skill_assignments
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 10. Clear nullable FKs (set to NULL before deleting parent)
UPDATE issues SET assignee_id = NULL WHERE assignee_id::TEXT IN (SELECT id FROM to_delete);
UPDATE agents SET reports_to = NULL WHERE reports_to::TEXT IN (SELECT id FROM to_delete);

-- 11. Delete activity log entries (nullable)
DELETE FROM activity_log WHERE actor_id::TEXT IN (SELECT id FROM to_delete);

-- 12. Delete the agents
DELETE FROM agents WHERE id::TEXT IN (SELECT id FROM to_delete);
```

### Step 4: Verify Deletion

```sql
-- Verify no agents remain
SELECT COUNT(*) FROM agents WHERE id::TEXT IN (SELECT id FROM to_delete);

-- Verify no orphaned child records
SELECT 'heartbeat_runs' as table_name, COUNT(*) as orphaned_count
FROM heartbeat_runs WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
UNION ALL
SELECT 'agent_task_sessions', COUNT(*) FROM agent_task_sessions WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
UNION ALL
SELECT 'agent_api_keys', COUNT(*) FROM agent_api_keys WHERE agent_id::TEXT IN (SELECT id FROM to_delete);
```

### Step 5: Cleanup

```sql
DROP TABLE to_delete;
```

## Handling Duplicate Agents

For removing duplicate agent entries (keeping the most recent):

```sql
-- Step 1: Find duplicates
SELECT name, company_id, COUNT(*) as cnt
FROM agents
GROUP BY name, company_id
HAVING COUNT(*) > 1;

-- Step 2: Create temp table with duplicates to delete (keep most recent)
CREATE TEMP TABLE duplicates_to_delete (id TEXT);
INSERT INTO duplicates_to_delete
SELECT id::TEXT
FROM (
    SELECT id, name, company_id, updated_at,
           ROW_NUMBER() OVER (PARTITION BY name, company_id ORDER BY updated_at DESC) as rn
    FROM agents
) ranked
WHERE rn > 1;

-- Step 3: Execute deletion script using duplicates_to_delete
-- (follow deletion order from Step 3 above)

-- Step 4: Verify
SELECT name, company_id, COUNT(*) as cnt
FROM agents
GROUP BY name, company_id
HAVING COUNT(*) > 1;
-- Should return empty result
```

## Common Errors and Solutions

### Error: "relation does not exist"

**Cause**: Table name incorrect or table doesn't exist in schema  
**Solution**: Verify table exists in `packages/db/src/schema/index.ts`

### Error: "violates foreign key constraint"

**Cause**: Deleting parent before children  
**Solution**: Add the missing level to deletion order

### Error: "operator does not exist: uuid = varchar"

**Cause**: Mixed UUID/VARCHAR types in comparison  
**Solution**: Cast to TEXT: `column::TEXT IN (...)`

### Error: "null value in column violates not-null constraint"

**Cause**: FK column doesn't allow NULL but parent deleted  
**Solution**: Update child records to NULL before deletion:
```sql
UPDATE issues SET assignee_id = NULL WHERE assignee_id::TEXT IN (SELECT id FROM to_delete);
```

## Verification Queries

After deletion, run these verification queries:

```sql
-- Verify no orphaned records
SELECT 'agent_api_keys' as tbl, COUNT(*) FROM agent_api_keys WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
UNION ALL SELECT 'heartbeat_runs', COUNT(*) FROM heartbeat_runs WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
UNION ALL SELECT 'agent_task_sessions', COUNT(*) FROM agent_task_sessions WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
UNION ALL SELECT 'agent_runtime_state', COUNT(*) FROM agent_runtime_state WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
UNION ALL SELECT 'agent_wakeup_requests', COUNT(*) FROM agent_wakeup_requests WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
UNION ALL SELECT 'agent_config_revisions', COUNT(*) FROM agent_config_revisions WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- Verify agents table is clean
SELECT COUNT(*) as remaining_to_delete FROM agents WHERE id::TEXT IN (SELECT id FROM to_delete);
-- Should be 0
```

## Related Documents

- `FK-DEPENDENCY-LEVELS.md` - Complete FK dependency hierarchy
- `foreign-keys.md` - Detailed FK constraint mappings
- `unique-constraints.md` - Unique constraint definitions
