-- Delete agent with ID: 9e780111-85f6-4cc3-a110-377f23e8fdfc
-- Following the correct deletion order from docs-paperclip/procedures/agents/deleting-companies-and-agents.md

-- Level 1: Records referencing heartbeat_runs
-- Delete activity_log entries that reference heartbeat_runs for this agent
DELETE FROM activity_log
WHERE run_id IN (
  SELECT id FROM heartbeat_runs WHERE agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc'
);

-- Level 2: Heartbeat records
DELETE FROM heartbeat_run_events
WHERE run_id IN (
  SELECT id FROM heartbeat_runs WHERE agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc'
);

DELETE FROM heartbeat_runs
WHERE agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

-- Level 3: Agent activity
DELETE FROM cost_events
WHERE agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM finance_events
WHERE agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM activity_log
WHERE agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM agent_task_sessions
WHERE agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

-- Level 4: Agent configuration
DELETE FROM agent_wakeup_requests
WHERE agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM agent_runtime_state
WHERE agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

-- CRITICAL: agent_skill_assignments MUST be deleted before agents table
DELETE FROM agent_skill_assignments
WHERE agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM agent_config_revisions
WHERE agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM agent_config_revisions
WHERE created_by_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM agent_api_keys
WHERE agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM agent_models
WHERE agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

-- Level 5: Records created/owned by agent
DELETE FROM company_secret_versions
WHERE created_by_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM company_secrets
WHERE created_by_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM document_revisions
WHERE created_by_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM documents
WHERE created_by_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc'
   OR updated_by_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM assets
WHERE created_by_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM approval_comments
WHERE author_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM approvals
WHERE requested_by_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM issue_approvals
WHERE linked_by_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM issue_comments
WHERE author_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

DELETE FROM workspace_runtime_services
WHERE owner_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

-- Level 6: Nullable FK updates (set to NULL)
UPDATE issues
SET assignee_agent_id = NULL
WHERE assignee_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

UPDATE issues
SET created_by_agent_id = NULL
WHERE created_by_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

UPDATE goals
SET owner_agent_id = NULL
WHERE owner_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

UPDATE projects
SET lead_agent_id = NULL
WHERE lead_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

UPDATE routines
SET assignee_agent_id = NULL,
    created_by_agent_id = NULL,
    updated_by_agent_id = NULL
WHERE assignee_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc'
   OR created_by_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc'
   OR updated_by_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

UPDATE routine_triggers
SET created_by_agent_id = NULL,
    updated_by_agent_id = NULL
WHERE created_by_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc'
   OR updated_by_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

UPDATE join_requests
SET created_agent_id = NULL
WHERE created_agent_id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

-- Self-referential: Update agents that report to this agent
UPDATE agents
SET reports_to = NULL
WHERE reports_to = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

-- Level 7: Agent deletion
DELETE FROM agents
WHERE id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

-- Verification: Check if agent was deleted
-- SELECT id, name FROM agents WHERE id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';
