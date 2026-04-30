-- ==========================================
-- DELETE AGENT TEMPLATE
-- Created: 2026-04-23 (updated 2026-04-25)
-- Version: 2.0 (moved from scripts/database-templates)
-- Description: Template for safely deleting agents with proper FK cascade
-- Usage: Replace {AGENT_ID} with the actual agent UUID to delete
-- ==========================================

-- Step 1: Identify the agent to delete
SELECT 
  id,
  name,
  title,
  company_id,
  created_at,
  updated_at
FROM agents
WHERE id = '{AGENT_ID}';

-- Step 2: Create temporary table for the agent to delete
CREATE TEMP TABLE to_delete (id TEXT);
INSERT INTO to_delete VALUES ('{AGENT_ID}');

-- Step 3: Delete in proper FK dependency order (11 steps)

-- 1. Delete heartbeat events (chained via heartbeat_runs)
DELETE FROM heartbeat_run_events 
WHERE run_id::TEXT IN (
    SELECT hr.id::TEXT FROM heartbeat_runs hr 
    WHERE hr.agent_id::TEXT IN (SELECT id FROM to_delete)
);

-- 2. Delete heartbeat runs
DELETE FROM heartbeat_runs 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 3. Delete agent task sessions
DELETE FROM agent_task_sessions 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 4. Delete agent runtime state
DELETE FROM agent_runtime_state 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 5. Delete agent wakeup requests
DELETE FROM agent_wakeup_requests 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 6. Delete agent config revisions (both agent_id and created_by_agent_id FKs)
DELETE FROM agent_config_revisions 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
   OR created_by_agent_id::TEXT IN (SELECT id FROM to_delete);

-- 7. Delete agent API keys
DELETE FROM agent_api_keys
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 8. Delete agent skill assignments (if table exists)
DELETE FROM agent_skill_assignments
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 9. Clear nullable FKs (set to NULL before deleting parent)
UPDATE issues 
SET assignee_agent_id = NULL 
WHERE assignee_agent_id::TEXT IN (SELECT id FROM to_delete);

UPDATE agents 
SET reports_to = NULL 
WHERE reports_to::TEXT IN (SELECT id FROM to_delete);

-- 10. Delete activity log entries (nullable FK)
DELETE FROM activity_log 
WHERE actor_id::TEXT IN (SELECT id FROM to_delete);

-- 11. Delete the agent itself
DELETE FROM agents 
WHERE id::TEXT IN (SELECT id FROM to_delete);

-- Step 4: Verify deletion
SELECT 
  'Agent Deleted' as status,
  COUNT(*) as count
FROM agents 
WHERE id = '{AGENT_ID}';

-- Step 5: Verify no orphaned child records remain
SELECT 'heartbeat_runs' as table_name, COUNT(*) as orphaned_count
FROM heartbeat_runs WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
UNION ALL
SELECT 'agent_task_sessions', COUNT(*) FROM agent_task_sessions WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
UNION ALL
SELECT 'agent_api_keys', COUNT(*) FROM agent_api_keys WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
UNION ALL
SELECT 'agent_runtime_state', COUNT(*) FROM agent_runtime_state WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
UNION ALL
SELECT 'agent_wakeup_requests', COUNT(*) FROM agent_wakeup_requests WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
UNION ALL
SELECT 'agent_config_revisions', COUNT(*) FROM agent_config_revisions WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- Step 6: Cleanup temporary table
DROP TABLE to_delete;

-- ==========================================
-- Expected Results:
-- - Agent {AGENT_ID} deleted
-- - All child records cleaned up
-- - No orphaned FK references
-- ==========================================

-- ==========================================
-- NOTES:
-- - This template follows the actual schema from packages/db/src/schema/
-- - execution_workspaces does NOT have agent_id FK (removed from template)
-- - All UUID columns cast to TEXT for comparison
-- - Based on FK deletion procedure: docs-paperclip/procedures/agents/fk-deletion-procedure.md
-- ==========================================
