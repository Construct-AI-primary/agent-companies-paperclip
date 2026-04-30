# Foreign Key Dependency Levels Reference

**Document Type**: Schema Reference  
**Last Updated**: 2026-04-22  
**Status**: Active

## Overview

This document describes the foreign key dependencies in the Paperclip database schema. Understanding these levels is critical for:

- Deleting records in the correct order (to avoid FK constraint violations)
- Creating new records in the correct order (to satisfy FK requirements)
- Troubleshooting cascade delete behavior
- Writing SQL migration scripts

## Actual Schema Tables

Based on `packages/db/src/schema/index.ts`, the actual tables with agent-related FKs are:

### Tables Referencing `agents.id`

| Table | FK Column | Notes |
|-------|-----------|-------|
| `heartbeat_runs` | `agent_id` | |
| `heartbeat_run_events` | `run_id` → `heartbeat_runs.id` | Chained FK |
| `agent_task_sessions` | `agent_id` | |
| `execution_workspaces` | None (project/issue based) | |
| `agent_runtime_state` | `agent_id` | |
| `agent_wakeup_requests` | `agent_id` | |
| `agent_config_revisions` | `agent_id`, `created_by_agent_id` | Multiple FKs |
| `agent_api_keys` | `agent_id` | |
| `agent_skill_assignments` | `agent_id` | **NOT in schema/index.ts but exists in production DB** |
| `issues` | `assignee_id` | Nullable FK |
| `agents` (self-ref) | `reports_to` | Nullable FK |
| `activity_log` | `actor_id` | Nullable FK |

**Note**: There is NO `agent_skills` or `agent_models` table in the current schema.
**Warning**: `agent_skill_assignments` table exists in production database but is NOT defined in `packages/db/src/schema/index.ts`. This is a schema drift issue that needs to be resolved.

## Entity Relationship Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           LEVEL 0: ROOT ENTITIES                             │
├─────────────────────────────────────────────────────────────────────────────┤
│  companies                                                                   │
│  goals                                                                       │
│  labels                                                                      │
│  plugins                                                                     │
│  adapter_configurations (via plugin_config)                                  │
└─────────────────────────────────────────────────────────────────────────────┘
                                       │
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                           LEVEL 1: PRIMARY ENTITIES                          │
├─────────────────────────────────────────────────────────────────────────────┤
│  agents ──────────────── FK: company_id → companies.id                      │
│  projects ────────────── FK: company_id → companies.id                      │
│  issues ──────────────── FK: company_id → companies.id                      │
│  budget_policies ──────── FK: company_id → companies.id                     │
│  api_keys ─────────────── FK: company_id → companies.id                     │
└─────────────────────────────────────────────────────────────────────────────┘
                                       │
                     ┌─────────────────┼─────────────────┐
                     ▼                 ▼                 ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                       LEVEL 2: ENTITY CHILDREN                               │
├─────────────────────────────────────────────────────────────────────────────┤
│  agent_api_keys ──────── FK: agent_id → agents.id                           │
│  agent_config_revisions ─ FK: agent_id → agents.id, created_by → agents.id   │
│  heartbeat_runs ──────── FK: agent_id → agents.id                           │
│  heartbeat_run_events ─── FK: run_id → heartbeat_runs.id                     │
│  agent_task_sessions ─── FK: agent_id → agents.id                           │
│  execution_workspaces ─── FK: project_id → projects.id, issue_id → issues.id │
│  agent_runtime_state ─── FK: agent_id → agents.id                           │
│  agent_wakeup_requests ─ FK: agent_id → agents.id                           │
│  issue_comments ──────── FK: issue_id → issues.id                           │
│  issue_labels ────────── FK: issue_id → issues.id                           │
│  issue_relations ──────── FK: issue_id → issues.id                          │
│  project_workspaces ───── FK: project_id → projects.id                       │
│  company_skills ───────── FK: company_id → companies.id                        │
│  company_secrets ──────── FK: company_id → companies.id                      │
│  cost_events ─────────── FK: company_id → companies.id                       │
│  finance_events ──────── FK: company_id → companies.id                      │
│  activity_log ────────── FK: company_id → companies.id, actor_id → agents.id │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Deletion Order Summary

When deleting an agent, follow this order to avoid FK constraint violations:

| Order | Table | FK Reference |
|-------|-------|-------------|
| 1 | `heartbeat_run_events` | `run_id → heartbeat_runs.id` |
| 2 | `heartbeat_runs` | `agent_id → agents.id` |
| 3 | `execution_workspaces` | None (not agent-related) |
| 4 | `agent_task_sessions` | `agent_id → agents.id` |
| 5 | `agent_runtime_state` | `agent_id → agents.id` |
| 6 | `agent_wakeup_requests` | `agent_id → agents.id` |
| 7 | `agent_config_revisions` | `agent_id → agents.id`, `created_by_agent_id → agents.id` |
| 8 | `agent_api_keys` | `agent_id → agents.id` |
| 9 | `agents.reports_to` | SET NULL (nullable, self-ref) - if column exists |
| 10 | `agents` | `company_id → companies.id` |

## SQL Deletion Template

```sql
-- Step 1: Create temp table of records to delete
CREATE TEMP TABLE to_delete (id TEXT);
INSERT INTO to_delete SELECT id::TEXT FROM agents WHERE [condition];

-- Step 2: Delete in correct FK order

-- 1. Delete heartbeat events (chained via heartbeat_runs)
DELETE FROM heartbeat_run_events 
WHERE run_id IN (
    SELECT hr.id::TEXT FROM heartbeat_runs hr 
    WHERE hr.agent_id::TEXT IN (SELECT id FROM to_delete)
);

-- 2. Delete heartbeat runs
DELETE FROM heartbeat_runs WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 3. Delete agent task sessions
DELETE FROM agent_task_sessions WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 4. Delete agent runtime state
DELETE FROM agent_runtime_state WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 5. Delete agent wakeup requests
DELETE FROM agent_wakeup_requests WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 6. Delete agent config revisions (both FKs)
DELETE FROM agent_config_revisions 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
   OR created_by_agent_id::TEXT IN (SELECT id FROM to_delete);

-- 7. Delete agent API keys
DELETE FROM agent_api_keys WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 8. Clear self-referential nullable FK (agents.reports_to)
-- NOTE: issues.assignee_id and activity_log.actor_id may not exist - skip them
DO $$ BEGIN
    UPDATE agents SET reports_to = NULL WHERE reports_to::TEXT IN (SELECT id FROM to_delete);
EXCEPTION WHEN undefined_column THEN
    RAISE NOTICE 'Column reports_to does not exist, skipping';
END $$;

-- 9. Delete the agents
DELETE FROM agents WHERE id::TEXT IN (SELECT id FROM to_delete);

-- Cleanup
DROP TABLE to_delete;
```

## Insertion Order Summary

When inserting records, follow this reverse order:

| Order | Table | Parent Dependencies |
|-------|-------|-------------------|
| 1st | `companies`, `goals`, `labels`, `plugins` | None (root) |
| 2nd | `agents`, `projects`, `issues`, `budget_policies` | `companies` |
| 3rd | `agent_api_keys`, `agent_config_revisions`, `heartbeat_runs`, `issue_comments`, etc. | `companies`, `agents`, `projects`, `issues` |

## Type Casting Notes

**Critical**: PostgreSQL does not allow direct comparison between UUID and TEXT/VARCHAR types. When filtering across tables with mixed ID column types, **always cast to TEXT**:

```sql
-- Correct: Cast to TEXT for comparison
WHERE agent_id::TEXT IN (SELECT id::TEXT FROM agents)

-- Incorrect: Will cause "operator does not exist: uuid = text" error
WHERE agent_id IN (SELECT id FROM agents)

-- Also incorrect: Even with subquery casting
-- ERROR: operator does not exist: text = uuid
WHERE actor_id IN (SELECT id FROM agents)  -- if actor_id is TEXT and agents.id is UUID
```

**Always cast BOTH sides of the comparison to TEXT:**
```sql
WHERE agent_id::TEXT IN (SELECT id::TEXT FROM agents)
```

## Cascade Delete Configuration

Some foreign keys have `ON DELETE CASCADE` configured for automatic cleanup:

| Parent Table | Child Table | Cascade |
|-------------|-------------|---------|
| `agents` | `agent_api_keys` | Likely Yes |
| `agents` | `agent_config_revisions` | Likely Yes |
| `issues` | `issue_comments` | Likely Yes |
| `issues` | `issue_relations` | Likely Yes |
| `projects` | `issues` | Likely Yes |

**Note**: Tables with optional FK references (like `issues.assignee_id`, `agents.reports_to`) do NOT cascade delete because the relationship is nullable.

## Troubleshooting

### Error: "relation does not exist"

**Cause**: Table name incorrect or table doesn't exist in schema  
**Solution**: Verify table exists in `packages/db/src/schema/index.ts`

### Error: "violates foreign key constraint"

**Cause**: Attempting to delete a parent record before its children.  
**Solution**: Ensure all dependent records are deleted first (follow the deletion order above).

### Error: "operator does not exist: uuid = varchar"

**Cause**: Comparing UUID column with VARCHAR column without explicit cast.  
**Solution**: Cast both sides to TEXT: `column::TEXT IN (...)`

### Error: "null value in column violates not-null constraint"

**Cause**: FK column does not allow NULL but parent record was deleted.  
**Solution**: Either set FK column to nullable, or ensure child records are deleted before parent:
```sql
UPDATE issues SET assignee_id = NULL WHERE assignee_id::TEXT IN (SELECT id FROM to_delete);
```

---

**Related Documents**:
- `foreign-keys.md` - Detailed FK constraint mappings
- `unique-constraints.md` - Unique constraint definitions
- `deleting-companies-and-agents.md` - Deletion procedure
