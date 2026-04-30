-- Cleanup script for deleting archived companies and all their dependencies
-- Proper FK order to avoid constraint violations

BEGIN;

-- List of archived companies to delete
SELECT 'Archived companies to be deleted:' as status;
SELECT id, name, status, created_at FROM companies WHERE status = 'archived' ORDER BY name;

-- STEP 1: Delete records that reference heartbeat_runs (deepest dependencies first)
DELETE FROM workspace_runtime_services WHERE started_by_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.company_id IN (SELECT id FROM companies WHERE status = 'archived')
     OR hr.agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'))
);

DELETE FROM workspace_operations WHERE heartbeat_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.company_id IN (SELECT id FROM companies WHERE status = 'archived')
     OR hr.agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'))
);

DELETE FROM issue_work_products WHERE created_by_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.company_id IN (SELECT id FROM companies WHERE status = 'archived')
     OR hr.agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'))
);

DELETE FROM issues WHERE checkout_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.company_id IN (SELECT id FROM companies WHERE status = 'archived')
     OR hr.agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'))
);

DELETE FROM issues WHERE execution_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.company_id IN (SELECT id FROM companies WHERE status = 'archived')
     OR hr.agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'))
);

DELETE FROM finance_events WHERE heartbeat_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.company_id IN (SELECT id FROM companies WHERE status = 'archived')
     OR hr.agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'))
);

DELETE FROM cost_events WHERE heartbeat_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.company_id IN (SELECT id FROM companies WHERE status = 'archived')
     OR hr.agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'))
);

DELETE FROM activity_log WHERE run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.company_id IN (SELECT id FROM companies WHERE status = 'archived')
     OR hr.agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'))
);

DELETE FROM agent_task_sessions WHERE last_run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.company_id IN (SELECT id FROM companies WHERE status = 'archived')
     OR hr.agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'))
);

-- STEP 2: Delete heartbeat_run_events and heartbeat_runs
DELETE FROM heartbeat_run_events WHERE run_id IN (
  SELECT hr.id FROM heartbeat_runs hr
  WHERE hr.company_id IN (SELECT id FROM companies WHERE status = 'archived')
     OR hr.agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'))
);

DELETE FROM heartbeat_run_events WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM heartbeat_run_events WHERE agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));

DELETE FROM heartbeat_runs WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM heartbeat_runs WHERE agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));

-- STEP 3: Delete remaining company-scoped records (order matters due to FKs)
DELETE FROM cost_events WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM finance_events WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM activity_log WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- STEP 4: Delete agent_task_sessions
DELETE FROM agent_task_sessions WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- STEP 5: Delete agent-related records
DELETE FROM agent_wakeup_requests WHERE agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM agent_wakeup_requests WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

DELETE FROM agent_runtime_state WHERE agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM agent_runtime_state WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

DELETE FROM agent_config_revisions WHERE agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM agent_config_revisions WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

DELETE FROM agent_api_keys WHERE agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM agent_api_keys WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

DELETE FROM agent_skill_assignments WHERE agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM agent_skill_assignments WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- STEP 6: Delete issue-related records (handle issues table dependencies first)
DELETE FROM issue_work_products WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issue_read_states WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issue_labels WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issue_inbox_archives WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issue_documents WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issue_attachments WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issue_approvals WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issue_comments WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- STEP 7: Delete routine-related records
DELETE FROM routine_runs WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM routine_triggers WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM routines WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- STEP 8: Delete project-related records
DELETE FROM project_workspaces WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM project_goals WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM projects WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- STEP 9: Delete approval and document-related records
DELETE FROM approval_comments WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM approvals WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM document_revisions WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM documents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM assets WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- STEP 10: Delete workspace-related records
DELETE FROM workspace_runtime_services WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM workspace_operations WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM execution_workspaces WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- STEP 11: Delete company configuration records
DELETE FROM company_secret_versions WHERE secret_id IN (SELECT id FROM company_secrets WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM company_secrets WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM company_skills WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM company_logos WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM budget_incidents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM budget_policies WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM plugin_company_settings WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM principal_permission_grants WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- STEP 12: Delete auth and invite records
DELETE FROM cli_auth_challenges WHERE requested_company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM join_requests WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM invites WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM labels WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- STEP 13: Delete goals (after all other dependencies)
DELETE FROM goals WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- STEP 14: Delete agents (after all agent dependencies are removed)
DELETE FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- STEP 15: Finally delete the companies themselves
DELETE FROM companies WHERE status = 'archived';

-- Verification
SELECT 'Cleanup complete! Remaining companies:' as status;
SELECT id, name, status, created_at FROM companies ORDER BY name;

COMMIT;
