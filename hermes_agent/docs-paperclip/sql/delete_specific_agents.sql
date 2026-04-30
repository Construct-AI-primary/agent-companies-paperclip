-- Delete specific agents by ID
-- Agent IDs: a7e42dcb-2b0d-4074-adc6-adbf6da67bbd, 88ab7dce-16cc-421b-ae4c-f5c1aa7ee29b
-- This script follows the FK dependency order from the deletion procedure

BEGIN;

-- Create temp table for agents to delete
CREATE TEMP TABLE agents_to_delete AS
SELECT id, name, company_id
FROM agents
WHERE id IN (
  'a7e42dcb-2b0d-4074-adc6-adbf6da67bbd',
  '88ab7dce-16cc-421b-ae4c-f5c1aa7ee29b'
);

-- Display agents to be deleted
SELECT 'Agents to be deleted:' as info;
SELECT * FROM agents_to_delete;

-- Level 1: Records referencing heartbeat_runs (deepest dependencies)
DELETE FROM workspace_runtime_services 
WHERE last_heartbeat_run_id IN (
  SELECT id FROM heartbeat_runs WHERE agent_id IN (SELECT id FROM agents_to_delete)
);

DELETE FROM workspace_operations 
WHERE heartbeat_run_id IN (
  SELECT id FROM heartbeat_runs WHERE agent_id IN (SELECT id FROM agents_to_delete)
);

DELETE FROM issue_work_products 
WHERE run_id IN (
  SELECT id FROM heartbeat_runs WHERE agent_id IN (SELECT id FROM agents_to_delete)
);

UPDATE issues SET checkout_run_id = NULL 
WHERE checkout_run_id IN (
  SELECT id FROM heartbeat_runs WHERE agent_id IN (SELECT id FROM agents_to_delete)
);

UPDATE issues SET execution_run_id = NULL 
WHERE execution_run_id IN (
  SELECT id FROM heartbeat_runs WHERE agent_id IN (SELECT id FROM agents_to_delete)
);

DELETE FROM finance_events 
WHERE heartbeat_run_id IN (
  SELECT id FROM heartbeat_runs WHERE agent_id IN (SELECT id FROM agents_to_delete)
);

DELETE FROM cost_events 
WHERE heartbeat_run_id IN (
  SELECT id FROM heartbeat_runs WHERE agent_id IN (SELECT id FROM agents_to_delete)
);

DELETE FROM activity_log 
WHERE run_id IN (
  SELECT id FROM heartbeat_runs WHERE agent_id IN (SELECT id FROM agents_to_delete)
);

UPDATE agent_task_sessions SET last_run_id = NULL 
WHERE last_run_id IN (
  SELECT id FROM heartbeat_runs WHERE agent_id IN (SELECT id FROM agents_to_delete)
);

-- Level 2: Heartbeat records
DELETE FROM heartbeat_run_events 
WHERE run_id IN (
  SELECT id FROM heartbeat_runs WHERE agent_id IN (SELECT id FROM agents_to_delete)
);

DELETE FROM heartbeat_runs 
WHERE agent_id IN (SELECT id FROM agents_to_delete);

-- Level 3: Agent activity
DELETE FROM cost_events 
WHERE agent_id IN (SELECT id FROM agents_to_delete);

DELETE FROM finance_events 
WHERE agent_id IN (SELECT id FROM agents_to_delete);

DELETE FROM activity_log 
WHERE agent_id IN (SELECT id FROM agents_to_delete);

DELETE FROM agent_task_sessions 
WHERE agent_id IN (SELECT id FROM agents_to_delete);

-- Level 4: Agent configuration
DELETE FROM agent_wakeup_requests 
WHERE agent_id IN (SELECT id FROM agents_to_delete);

DELETE FROM agent_runtime_state 
WHERE agent_id IN (SELECT id FROM agents_to_delete);

DELETE FROM agent_config_revisions 
WHERE agent_id IN (SELECT id FROM agents_to_delete);

DELETE FROM agent_config_revisions 
WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);

-- CRITICAL: Delete from agent_api_keys
DELETE FROM agent_api_keys 
WHERE agent_id IN (SELECT id FROM agents_to_delete);

DELETE FROM agent_skill_assignments 
WHERE agent_id IN (SELECT id FROM agents_to_delete);

-- CRITICAL: Delete from agent_models
DELETE FROM agent_models 
WHERE agent_id IN (SELECT id FROM agents_to_delete);

-- Level 5: Records created/owned by agent
UPDATE company_secret_versions SET created_by_agent_id = NULL 
WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE company_secrets SET created_by_agent_id = NULL 
WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE document_revisions SET created_by_agent_id = NULL 
WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE documents SET created_by_agent_id = NULL 
WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE documents SET updated_by_agent_id = NULL 
WHERE updated_by_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE assets SET created_by_agent_id = NULL 
WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);

DELETE FROM approval_comments 
WHERE author_agent_id IN (SELECT id FROM agents_to_delete);

DELETE FROM approvals 
WHERE requested_by_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE issue_approvals SET linked_by_agent_id = NULL 
WHERE linked_by_agent_id IN (SELECT id FROM agents_to_delete);

DELETE FROM issue_comments 
WHERE author_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE workspace_runtime_services SET owner_agent_id = NULL 
WHERE owner_agent_id IN (SELECT id FROM agents_to_delete);

-- Level 6: Nullable FK updates (set to NULL)
UPDATE issues SET assignee_agent_id = NULL 
WHERE assignee_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE issues SET created_by_agent_id = NULL 
WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE goals SET owner_agent_id = NULL 
WHERE owner_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE projects SET lead_agent_id = NULL 
WHERE lead_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE routines SET assignee_agent_id = NULL 
WHERE assignee_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE routines SET created_by_agent_id = NULL 
WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE routines SET updated_by_agent_id = NULL 
WHERE updated_by_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE routine_triggers SET created_by_agent_id = NULL 
WHERE created_by_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE routine_triggers SET updated_by_agent_id = NULL 
WHERE updated_by_agent_id IN (SELECT id FROM agents_to_delete);

UPDATE join_requests SET created_agent_id = NULL 
WHERE created_agent_id IN (SELECT id FROM agents_to_delete);

-- Self-referential FK
UPDATE agents SET reports_to = NULL 
WHERE reports_to IN (SELECT id FROM agents_to_delete);

-- Level 7: Agent deletion
DELETE FROM agents 
WHERE id IN (SELECT id FROM agents_to_delete);

-- Verification
SELECT 'Deletion complete. Verifying...' as info;

-- Check that agents are deleted
SELECT 'Remaining agents with these IDs (should be 0):' as check;
SELECT COUNT(*) as count FROM agents 
WHERE id IN (
  'a7e42dcb-2b0d-4074-adc6-adbf6da67bbd',
  '88ab7dce-16cc-421b-ae4c-f5c1aa7ee29b'
);

-- Check for orphaned agent_api_keys
SELECT 'Orphaned agent_api_keys (should be 0):' as check;
SELECT COUNT(*) as count FROM agent_api_keys 
WHERE agent_id IN (
  'a7e42dcb-2b0d-4074-adc6-adbf6da67bbd',
  '88ab7dce-16cc-421b-ae4c-f5c1aa7ee29b'
);

-- Check for orphaned agent_models
SELECT 'Orphaned agent_models (should be 0):' as check;
SELECT COUNT(*) as count FROM agent_models 
WHERE agent_id IN (
  'a7e42dcb-2b0d-4074-adc6-adbf6da67bbd',
  '88ab7dce-16cc-421b-ae4c-f5c1aa7ee29b'
);

COMMIT;

SELECT 'Transaction committed successfully!' as result;
