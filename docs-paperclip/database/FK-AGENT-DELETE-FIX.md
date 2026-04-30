---
title: "Agent Deletion FK Constraint Fix Procedure"
description: "Permanent fix for agent_skill_assignments FK constraint errors - standardized deletion procedure"
gigabrain_tags: database, fix, foreign-key, agent-deletion, sql, postgres
labels: ["database", "fix", "foreign-key", "agent-deletion"]
blocked_by: []
depends_on: []
para_section: docs-paperclip/database
last_updated: 2026-04-25
---

# Agent Deletion FK Constraint Fix

## Problem

```
ERROR: 23503: update or delete on table "agents" violates foreign key constraint 
"agent_skill_assignments_agent_id_fkey" on table "agent_skill_assignments"
```

## Root Cause

The `agent_skill_assignments` table has a FK pointing to `agents(id)` with `ON DELETE no action`. When deleting agents, this prevents deletion if any skill assignments exist.

## Immediate Fix (Run This)

```sql
-- First, identify orphaned skill assignments
SELECT asa.id, asa.agent_id, a.name as agent_name, a.company_id
FROM agent_skill_assignments asa
LEFT JOIN agents a ON asa.agent_id = a.id
WHERE a.id IS NULL;

-- Clean up orphaned skill assignments (agents that no longer exist)
DELETE FROM agent_skill_assignments 
WHERE agent_id NOT IN (SELECT id FROM agents);

-- Now safe to delete agents
DELETE FROM agents WHERE id = 'YOUR-AGENT-ID-HERE';
```

## Permanent Fix - Scripts Updated ✅

Both deletion scripts have been updated to handle FK constraints in the correct order:

### Updated Scripts:
- ✅ `delete_agents.js` - Updated with complete FK-safe deletion order
- ✅ `delete_agents_direct.js` - Updated with complete FK-safe deletion order

### Deletion Order (15 steps):

| Step | Table | Action | Notes |
|------|-------|--------|-------|
| 1 | agent_skill_assignments | DELETE | **CRITICAL** - was causing FK errors |
| 2 | heartbeat_run_events | DELETE | Depends on heartbeat_runs |
| 3 | heartbeat_runs | DELETE | |
| 4 | cost_events | DELETE | |
| 5 | finance_events | DELETE | |
| 6 | activity_log | DELETE | |
| 7 | agent_task_sessions | DELETE | |
| 8 | agent_wakeup_requests | DELETE | |
| 9 | agent_runtime_state | DELETE | |
| 10 | agent_config_revisions | DELETE | |
| 11 | agent_api_keys | DELETE | |
| 12 | agent_models | DELETE | Table may not exist |
| 13 | issues | UPDATE | Set assignee_agent_id = NULL |
| 14 | agents | UPDATE | Set reports_to = NULL |
| 15 | agents | DELETE | **LAST** |

### Alternative: Stored Procedure

```sql
CREATE OR REPLACE FUNCTION safe_delete_agent(agent_uuid UUID)
RETURNS VOID AS $$
BEGIN
  -- Step 1: Delete heartbeat events (depends on heartbeat_runs)
  DELETE FROM heartbeat_run_events 
  WHERE run_id IN (SELECT id FROM heartbeat_runs WHERE agent_id = agent_uuid);
  
  -- Step 2: Delete heartbeat runs
  DELETE FROM heartbeat_runs WHERE agent_id = agent_uuid;
  
  -- Step 3: Delete cost and finance events
  DELETE FROM cost_events WHERE agent_id = agent_uuid;
  DELETE FROM finance_events WHERE agent_id = agent_uuid;
  
  -- Step 4: Delete activity log
  DELETE FROM activity_log WHERE agent_id = agent_uuid;
  
  -- Step 5: Delete task sessions
  DELETE FROM agent_task_sessions WHERE agent_id = agent_uuid;
  
  -- Step 6: Delete wakeup requests
  DELETE FROM agent_wakeup_requests WHERE agent_id = agent_uuid;
  
  -- Step 7: Delete runtime state
  DELETE FROM agent_runtime_state WHERE agent_id = agent_uuid;
  
  -- Step 8: Delete config revisions
  DELETE FROM agent_config_revisions WHERE agent_id = agent_uuid;
  
  -- Step 9: Delete API keys
  DELETE FROM agent_api_keys WHERE agent_id = agent_uuid;
  
  -- Step 10: Delete skill assignments (CRITICAL - this was causing the error)
  DELETE FROM agent_skill_assignments WHERE agent_id = agent_uuid;
  
  -- Step 11: Update issue references to NULL
  UPDATE issues SET assignee_agent_id = NULL WHERE assignee_agent_id = agent_uuid;
  UPDATE issues SET created_by_agent_id = NULL WHERE created_by_agent_id = agent_uuid;
  
  -- Step 12: Update other agent references
  UPDATE agents SET reports_to = NULL WHERE reports_to = agent_uuid;
  
  -- Step 13: Delete the agent
  DELETE FROM agents WHERE id = agent_uuid;
END;
$$ LANGUAGE plpgsql;

-- Usage:
SELECT safe_delete_agent('d9ab69e1-ef1c-45b4-8c7d-87d58cd4e797');
```

## Alternative: CASCADE FK Constraint

```sql
-- Drop existing FK
ALTER TABLE agent_skill_assignments 
DROP CONSTRAINT agent_skill_assignments_agent_id_fkey;

-- Add FK with CASCADE
ALTER TABLE agent_skill_assignments 
ADD CONSTRAINT agent_skill_assignments_agent_id_fkey 
FOREIGN KEY (agent_id) REFERENCES agents(id) ON DELETE CASCADE;
```

## Tables Referencing agents(id)

| Table | FK Column | Delete Order |
|-------|-----------|-------------|
| agent_skill_assignments | agent_id | **1** (CRITICAL) |
| heartbeat_run_events | agent_id | 2 |
| heartbeat_runs | agent_id | 3 |
| cost_events | agent_id | 4 |
| finance_events | agent_id | 5 |
| activity_log | agent_id | 6 |
| agent_task_sessions | agent_id | 7 |
| agent_wakeup_requests | agent_id | 8 |
| agent_runtime_state | agent_id | 9 |
| agent_config_revisions | agent_id | 10 |
| agent_api_keys | agent_id | 11 |
| issues | assignee_agent_id | UPDATE to NULL |
| issues | created_by_agent_id | UPDATE to NULL |
| agents | reports_to | UPDATE to NULL |

## Procedure Document

A formal procedure document is available at:
**[Agent Deletion Procedure](/docs-paperclip/procedures/database/agent-deletion-procedure.md)**

## Prevention Checklist

- [x] Run `cleanup_terminated_agents.sql` for all agent deletions
- [x] Update delete_agents.js to use proper deletion order
- [x] Update delete_agents_direct.js to use proper deletion order
- [x] Create formal procedure document
- [ ] Consider adding `ON DELETE CASCADE` to agent_skill_assignments FK (optional)
- [ ] Consider deploying `safe_delete_agent()` stored procedure (optional)

## Test Query

```sql
-- Verify no orphaned references before any agent deletion
SELECT COUNT(*) as orphaned_skill_assignments
FROM agent_skill_assignments asa
LEFT JOIN agents a ON asa.agent_id = a.id
WHERE a.id IS NULL;
```

---

**Last Updated**: 2026-04-25
**Issue**: FK constraint error on agent_skill_assignments
**Fix Version**: 1.1 - Scripts updated
