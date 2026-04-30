---
title: "Agent Deletion Procedure"
description: "Safe procedure for deleting agents from the database with proper FK constraint handling"
gigabrain_tags: database, procedure, agent-deletion, foreign-key, postgres
labels: ["database", "procedure", "agent-deletion"]
blocked_by: []
depends_on: []
para_section: docs-paperclip/procedures/database
last_updated: 2026-04-25
---

# Agent Deletion Procedure

## Purpose

This procedure ensures safe deletion of agents from the Paperclip database by properly handling all foreign key constraints. Following this procedure prevents FK violation errors when deleting agents that have associated skill assignments, API keys, or other dependent records.

## Problem

```
ERROR: 23503: update or delete on table "agents" violates foreign key constraint 
"agent_skill_assignments_agent_id_fkey" on table "agent_skill_assignments"
```

This error occurs when attempting to delete an agent before removing associated records in tables that reference `agents(id)`.

## Prerequisites

- Database access with service role permissions
- Agent UUID(s) to delete
- Backup completed (recommended)

## Deletion Order

Tables must be deleted in the following order to respect foreign key dependencies:

### Step 1-12: Delete Dependent Records

| Step | Table | Notes |
|------|-------|-------|
| 1 | `agent_skill_assignments` | **CRITICAL** - causes FK error if not first |
| 2 | `heartbeat_run_events` | Must delete before heartbeat_runs |
| 3 | `heartbeat_runs` | |
| 4 | `cost_events` | |
| 5 | `finance_events` | |
| 6 | `activity_log` | |
| 7 | `agent_task_sessions` | |
| 8 | `agent_wakeup_requests` | |
| 9 | `agent_runtime_state` | |
| 10 | `agent_config_revisions` | |
| 11 | `agent_api_keys` | |
| 12 | `agent_models` | Table may not exist in all deployments |

### Step 13-14: NULLify References

| Step | Table | Column | Action |
|------|-------|--------|--------|
| 13 | `issues` | `assignee_agent_id` | UPDATE to NULL (preserve issues) |
| 14 | `agents` | `reports_to` | UPDATE to NULL (preserve agent hierarchy) |

### Step 15: Delete Agent

| Step | Table | Notes |
|------|-------|-------|
| 15 | `agents` | **DELETE LAST** |

## Automated Scripts

Use the following scripts for automated deletion:

### delete_agents.js
```bash
node delete_agents.js
```

Edit `AGENT_IDS` array with the UUIDs to delete.

### delete_agents_direct.js
```bash
node delete_agents_direct.js
```

Uses `DATABASE_URL` environment variable.

## Manual SQL Procedure

If running SQL directly, execute in this order:

```sql
-- Replace 'YOUR-AGENT-ID' with actual UUID

-- Step 1: CRITICAL - Delete skill assignments first
DELETE FROM agent_skill_assignments WHERE agent_id = 'YOUR-AGENT-ID';

-- Step 2-12: Delete other dependent records
DELETE FROM heartbeat_run_events WHERE run_id IN (SELECT id FROM heartbeat_runs WHERE agent_id = 'YOUR-AGENT-ID');
DELETE FROM heartbeat_runs WHERE agent_id = 'YOUR-AGENT-ID';
DELETE FROM cost_events WHERE agent_id = 'YOUR-AGENT-ID';
DELETE FROM finance_events WHERE agent_id = 'YOUR-AGENT-ID';
DELETE FROM activity_log WHERE agent_id = 'YOUR-AGENT-ID';
DELETE FROM agent_task_sessions WHERE agent_id = 'YOUR-AGENT-ID';
DELETE FROM agent_wakeup_requests WHERE agent_id = 'YOUR-AGENT-ID';
DELETE FROM agent_runtime_state WHERE agent_id = 'YOUR-AGENT-ID';
DELETE FROM agent_config_revisions WHERE agent_id = 'YOUR-AGENT-ID';
DELETE FROM agent_api_keys WHERE agent_id = 'YOUR-AGENT-ID';
DELETE FROM agent_models WHERE agent_id = 'YOUR-AGENT-ID';

-- Step 13-14: NULLify references
UPDATE issues SET assignee_agent_id = NULL WHERE assignee_agent_id = 'YOUR-AGENT-ID';
UPDATE agents SET reports_to = NULL WHERE reports_to = 'YOUR-AGENT-ID';

-- Step 15: Delete agent LAST
DELETE FROM agents WHERE id = 'YOUR-AGENT-ID';
```

## Alternative: Stored Procedure

Deploy the `safe_delete_agent()` function for reusable deletion:

```sql
CREATE OR REPLACE FUNCTION safe_delete_agent(agent_uuid UUID)
RETURNS VOID AS $$
BEGIN
  DELETE FROM heartbeat_run_events 
  WHERE run_id IN (SELECT id FROM heartbeat_runs WHERE agent_id = agent_uuid);
  
  DELETE FROM heartbeat_runs WHERE agent_id = agent_uuid;
  DELETE FROM cost_events WHERE agent_id = agent_uuid;
  DELETE FROM finance_events WHERE agent_id = agent_uuid;
  DELETE FROM activity_log WHERE agent_id = agent_uuid;
  DELETE FROM agent_task_sessions WHERE agent_id = agent_uuid;
  DELETE FROM agent_wakeup_requests WHERE agent_id = agent_uuid;
  DELETE FROM agent_runtime_state WHERE agent_id = agent_uuid;
  DELETE FROM agent_config_revisions WHERE agent_id = agent_uuid;
  DELETE FROM agent_api_keys WHERE agent_id = agent_uuid;
  DELETE FROM agent_skill_assignments WHERE agent_id = agent_uuid;
  
  UPDATE issues SET assignee_agent_id = NULL WHERE assignee_agent_id = agent_uuid;
  UPDATE issues SET created_by_agent_id = NULL WHERE created_by_agent_id = agent_uuid;
  UPDATE agents SET reports_to = NULL WHERE reports_to = agent_uuid;
  
  DELETE FROM agents WHERE id = agent_uuid;
END;
$$ LANGUAGE plpgsql;

-- Usage:
SELECT safe_delete_agent('d9ab69e1-ef1c-45b4-8c7d-87d58cd4e797');
```

## Alternative: CASCADE FK Constraint

As a permanent solution, modify the FK constraint to cascade deletions:

```sql
ALTER TABLE agent_skill_assignments 
DROP CONSTRAINT agent_skill_assignments_agent_id_fkey;

ALTER TABLE agent_skill_assignments 
ADD CONSTRAINT agent_skill_assignments_agent_id_fkey 
FOREIGN KEY (agent_id) REFERENCES agents(id) ON DELETE CASCADE;
```

## Verification

### Check for Orphaned Records
```sql
SELECT COUNT(*) as orphaned_skill_assignments
FROM agent_skill_assignments asa
LEFT JOIN agents a ON asa.agent_id = a.id
WHERE a.id IS NULL;
```

### Verify Agent Deleted
```sql
SELECT * FROM agents WHERE id = 'YOUR-AGENT-ID';
-- Should return 0 rows
```

## Rollback

If deletion was accidental, restore from the most recent database backup.

## Related Documentation

- [FK Agent Delete Fix](/docs-paperclip/database/FK-AGENT-DELETE-FIX.md)
- [Database Backup Recovery Procedure](./database-backup-recovery-procedure.md)
- [CRUD Error Resolution Procedure](./crud-error-resolution-procedure.md)

---

**Last Updated**: 2026-04-25
**Owner**: Database Operations
**Review Cycle**: Annually
