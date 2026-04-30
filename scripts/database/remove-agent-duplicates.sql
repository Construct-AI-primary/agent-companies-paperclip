-- ============================================================
-- Remove Duplicate Agent Names
-- Created: 2026-04-22
-- Updated: 2026-04-22 - Fixed to use actual tables from schema/index.ts
-- NOTE: Uses TEXT type for temp table to handle mixed UUID/VARCHAR FK columns
-- NOTE: This script must be run as a single transaction
-- ============================================================

-- STEP 1: Show all duplicate agent names
SELECT name, company_id, COUNT(*) as cnt, MIN(created_at) as oldest, MAX(created_at) as newest
FROM agents
GROUP BY name, company_id
HAVING COUNT(*) > 1
ORDER BY name;

-- STEP 2: Identify duplicate agent IDs to delete (keeping most recent)
DROP TABLE IF EXISTS duplicates_to_delete;
CREATE TEMP TABLE duplicates_to_delete (id TEXT);
INSERT INTO duplicates_to_delete
SELECT id::TEXT
FROM (
    SELECT id, name, company_id, updated_at,
           ROW_NUMBER() OVER (PARTITION BY name, company_id ORDER BY updated_at DESC) as rn
    FROM agents
) ranked
WHERE rn > 1;

-- STEP 3: Delete in correct FK order (per FK-DEPENDENCY-LEVELS.md)
-- Order: heartbeat_run_events → heartbeat_runs → execution_workspaces → agent_task_sessions
--        → agent_runtime_state → agent_wakeup_requests → agent_config_revisions → agent_api_keys
--        → nullable FKs (issues.assignee_id, agents.reports_to) → activity_log

-- 1. Delete heartbeat_run_events (chained via heartbeat_runs)
DELETE FROM heartbeat_run_events 
WHERE run_id IN (
    SELECT hr.id FROM heartbeat_runs hr 
    WHERE hr.agent_id::TEXT IN (SELECT id FROM duplicates_to_delete)
);

-- 2. Delete heartbeat_runs
DELETE FROM heartbeat_runs 
WHERE agent_id::TEXT IN (SELECT id FROM duplicates_to_delete);

-- 3. Note: execution_workspaces does NOT have agent_id column (verified in schema)
-- FK-DEPENDENCY-LEVELS.md is incorrect - actual schema has no agent_id FK

-- 4. Delete agent_task_sessions
DELETE FROM agent_task_sessions 
WHERE agent_id::TEXT IN (SELECT id FROM duplicates_to_delete);

-- 5. Delete agent_runtime_state
DELETE FROM agent_runtime_state 
WHERE agent_id::TEXT IN (SELECT id FROM duplicates_to_delete);

-- 6. Delete agent_wakeup_requests
DELETE FROM agent_wakeup_requests 
WHERE agent_id::TEXT IN (SELECT id FROM duplicates_to_delete);

-- 7. Delete agent_config_revisions (both agent_id and created_by_agent_id FKs)
DELETE FROM agent_config_revisions 
WHERE agent_id::TEXT IN (SELECT id FROM duplicates_to_delete)
   OR created_by_agent_id::TEXT IN (SELECT id FROM duplicates_to_delete);

-- 8. Delete agent_api_keys
DELETE FROM agent_api_keys 
WHERE agent_id::TEXT IN (SELECT id FROM duplicates_to_delete);

-- 8b. Delete agent_skill_assignments (NOT in schema/index.ts but exists in production DB)
DELETE FROM agent_skill_assignments 
WHERE agent_id::TEXT IN (SELECT id FROM duplicates_to_delete);

-- 9. Clear nullable FKs (set to NULL before deleting parent)
UPDATE issues SET assignee_agent_id = NULL WHERE assignee_agent_id::TEXT IN (SELECT id FROM duplicates_to_delete);
UPDATE issues SET created_by_agent_id = NULL WHERE created_by_agent_id::TEXT IN (SELECT id FROM duplicates_to_delete);
UPDATE agents SET reports_to = NULL WHERE reports_to::TEXT IN (SELECT id FROM duplicates_to_delete);

-- 10. Delete activity_log entries
DELETE FROM activity_log 
WHERE actor_id::TEXT IN (SELECT id FROM duplicates_to_delete);

-- STEP 4: Delete the duplicate agents
DELETE FROM agents 
WHERE id::TEXT IN (SELECT id FROM duplicates_to_delete);

-- STEP 5: Clean up temp table
DROP TABLE duplicates_to_delete;

-- STEP 6: Verify no duplicates remain
SELECT name, company_id, COUNT(*) as cnt
FROM agents
GROUP BY name, company_id
HAVING COUNT(*) > 1;
