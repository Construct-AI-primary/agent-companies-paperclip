-- Cleanup script for deleting terminated and soft-deleted agents
-- Safe deletion of agents with status='terminated' OR deleted_at IS NOT NULL
-- Does NOT delete 'idle' agents unless they're soft-deleted

BEGIN;

-- List agents to be deleted
SELECT '=== Agents to be deleted ===' as status;
SELECT a.id, c.name as company, a.name as agent_name, a.status, a.is_active, a.deleted_at, a.created_at
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.status = 'terminated' OR a.deleted_at IS NOT NULL
ORDER BY c.name, a.name;

-- Store agent IDs to be deleted
CREATE TEMP TABLE agents_to_delete AS
SELECT id FROM agents WHERE status = 'terminated' OR deleted_at IS NOT NULL;

-- STEP 1: Delete records that reference heartbeat_runs for these agents
DELETE FROM workspace_runtime_services WHERE started_by_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.agent_id IN (SELECT id FROM agents_to_delete)
);

DELETE FROM workspace_operations WHERE heartbeat_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.agent_id IN (SELECT id FROM agents_to_delete)
);

DELETE FROM issue_work_products WHERE created_by_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.agent_id IN (SELECT id FROM agents_to_delete)
);

DELETE FROM issues WHERE checkout_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.agent_id IN (SELECT id FROM agents_to_delete)
);

DELETE FROM issues WHERE execution_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.agent_id IN (SELECT id FROM agents_to_delete)
);

DELETE FROM finance_events WHERE heartbeat_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.agent_id IN (SELECT id FROM agents_to_delete)
);

DELETE FROM cost_events WHERE heartbeat_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.agent_id IN (SELECT id FROM agents_to_delete)
);

DELETE FROM activity_log WHERE run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.agent_id IN (SELECT id FROM agents_to_delete)
);

DELETE FROM agent_task_sessions WHERE last_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.agent_id IN (SELECT id FROM agents_to_delete)
);

-- STEP 2: Delete heartbeat records
DELETE FROM heartbeat_run_events WHERE run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.agent_id IN (SELECT id FROM agents_to_delete)
);

DELETE FROM heartbeat_run_events WHERE agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM heartbeat_runs WHERE agent_id IN (SELECT id FROM agents_to_delete);

-- STEP 3: Delete agent activity records
DELETE FROM cost_events WHERE agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM finance_events WHERE agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM activity_log WHERE agent_id IN (SELECT id FROM agents_to_delete);

-- STEP 4: Delete agent task sessions
DELETE FROM agent_task_sessions WHERE agent_id IN (SELECT id FROM agents_to_delete);

-- STEP 5: Delete agent configuration and state
DELETE FROM agent_wakeup_requests WHERE agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM agent_runtime_state WHERE agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM agent_config_revisions WHERE agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM agent_config_revisions WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM agent_api_keys WHERE agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM agent_skill_assignments WHERE agent_id IN (SELECT id FROM agents_to_delete);

-- STEP 6: Delete records created/owned by these agents
DELETE FROM company_secret_versions WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM company_secrets WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM document_revisions WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM documents WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM documents WHERE updated_by_agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM assets WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM approval_comments WHERE author_agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM approvals WHERE requested_by_agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM issue_approvals WHERE linked_by_agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM issue_comments WHERE author_agent_id IN (SELECT id FROM agents_to_delete);
DELETE FROM workspace_runtime_services WHERE owner_agent_id IN (SELECT id FROM agents_to_delete);

-- STEP 7: Update references to null for nullable FKs
UPDATE issues SET assignee_agent_id = NULL WHERE assignee_agent_id IN (SELECT id FROM agents_to_delete);
UPDATE issues SET created_by_agent_id = NULL WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);
UPDATE goals SET owner_agent_id = NULL WHERE owner_agent_id IN (SELECT id FROM agents_to_delete);
UPDATE projects SET lead_agent_id = NULL WHERE lead_agent_id IN (SELECT id FROM agents_to_delete);
UPDATE routines SET assignee_agent_id = NULL WHERE assignee_agent_id IN (SELECT id FROM agents_to_delete);
UPDATE routines SET created_by_agent_id = NULL WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);
UPDATE routines SET updated_by_agent_id = NULL WHERE updated_by_agent_id IN (SELECT id FROM agents_to_delete);
UPDATE routine_triggers SET created_by_agent_id = NULL WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);
UPDATE routine_triggers SET updated_by_agent_id = NULL WHERE updated_by_agent_id IN (SELECT id FROM agents_to_delete);
UPDATE join_requests SET created_agent_id = NULL WHERE created_agent_id IN (SELECT id FROM agents_to_delete);

-- STEP 8: Update agent hierarchy (reports_to references)
UPDATE agents SET reports_to = NULL WHERE reports_to IN (SELECT id FROM agents_to_delete);

-- STEP 9: Delete the agents themselves
DELETE FROM agents WHERE id IN (SELECT id FROM agents_to_delete);

-- Cleanup temp table
DROP TABLE agents_to_delete;

-- Verification
SELECT '=== Cleanup complete! Remaining agent summary ===' as status;
SELECT c.name as company, COUNT(a.id) as agent_count
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id AND a.is_active = true
GROUP BY c.name
ORDER BY c.name;

SELECT '=== Agent status distribution ===' as status;
SELECT status, is_active, COUNT(*) as count 
FROM agents 
GROUP BY status, is_active 
ORDER BY status, is_active;

COMMIT;
