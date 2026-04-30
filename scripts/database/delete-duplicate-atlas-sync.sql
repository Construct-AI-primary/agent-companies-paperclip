-- ==========================================
-- Delete Duplicate "Atlas Sync" Agent Entry
-- Created: 2026-04-23
-- Description: Removes the duplicate "Atlas Sync" entry with ID 7d2184df-ca56-4990-9674-fb0f710b5acd
--              following proper FK deletion order
-- ==========================================

-- Step 1: Identify the duplicate agent
SELECT 
  id,
  name,
  title,
  company_id,
  created_at,
  updated_at
FROM agents
WHERE id = '7d2184df-ca56-4990-9674-fb0f710b5acd';

-- Step 2: Create temporary table for the agent to delete
CREATE TEMP TABLE to_delete (id TEXT);
INSERT INTO to_delete VALUES ('7d2184df-ca56-4990-9674-fb0f710b5acd');

-- Step 3: Delete in proper FK dependency order

-- 1. Delete heartbeat events (chained via heartbeat_runs)
DELETE FROM heartbeat_run_events 
WHERE run_id::TEXT IN (
    SELECT hr.id::TEXT FROM heartbeat_runs hr 
    WHERE hr.agent_id::TEXT IN (SELECT id FROM to_delete)
);

-- 2. Delete heartbeat runs
DELETE FROM heartbeat_runs 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 3. Delete agent task sessions (HAS agent_id column)
DELETE FROM agent_task_sessions 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 5. Delete agent runtime state
DELETE FROM agent_runtime_state 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 6. Delete agent wakeup requests
DELETE FROM agent_wakeup_requests 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 7. Delete agent config revisions (both agent_id and created_by_agent_id FKs)
DELETE FROM agent_config_revisions 
WHERE agent_id::TEXT IN (SELECT id FROM to_delete)
   OR created_by_agent_id::TEXT IN (SELECT id FROM to_delete);

-- 8. Delete agent API keys
DELETE FROM agent_api_keys
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 9. Delete agent skill assignments (if table exists)
DELETE FROM agent_skill_assignments
WHERE agent_id::TEXT IN (SELECT id FROM to_delete);

-- 10. Clear nullable FKs (set to NULL before deleting parent)
UPDATE issues 
SET assignee_agent_id = NULL 
WHERE assignee_agent_id::TEXT IN (SELECT id FROM to_delete);

UPDATE agents 
SET reports_to = NULL 
WHERE reports_to::TEXT IN (SELECT id FROM to_delete);

-- 11. Delete activity log entries (nullable FK)
DELETE FROM activity_log 
WHERE actor_id::TEXT IN (SELECT id FROM to_delete);

-- 12. Delete the agent itself
DELETE FROM agents 
WHERE id::TEXT IN (SELECT id FROM to_delete);

-- Step 4: Verify deletion
SELECT 
  'Agents Deleted' as status,
  COUNT(*) as count
FROM agents 
WHERE id = '7d2184df-ca56-4990-9674-fb0f710b5acd'

UNION ALL

SELECT 
  'Remaining "Atlas Sync" Agents' as status,
  COUNT(*) as count
FROM agents 
WHERE name = 'Atlas Sync';

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
-- - Agent 7d2184df-ca56-4990-9674-fb0f710b5acd deleted
-- - All child records cleaned up
-- - No orphaned FK references
-- - One "Atlas Sync" agent should remain
-- ==========================================
