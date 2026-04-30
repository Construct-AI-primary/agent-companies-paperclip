-- Cleanup script for Supabase - FIXED SYNTAX
BEGIN;

-- Step 1: Delete agent_task_sessions referencing heartbeat_runs for archived companies/agents FIRST
DELETE FROM agent_task_sessions WHERE last_run_id IN (
    SELECT hr.id FROM heartbeat_runs hr 
    WHERE hr.agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'))
    OR hr.company_id IN (SELECT id FROM companies WHERE status = 'archived')
);

-- Step 2: Delete heartbeat_runs for archived companies/agents
DELETE FROM heartbeat_run_events WHERE agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM heartbeat_run_events WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM heartbeat_runs WHERE agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM heartbeat_runs WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- Step 3: Delete agent-related records
DELETE FROM agent_skill_assignments WHERE agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM agent_skill_assignments WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM agent_api_keys WHERE agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM agent_api_keys WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM agent_config_revisions WHERE agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM agent_config_revisions WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM agent_runtime_state WHERE agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM agent_runtime_state WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM agent_wakeup_requests WHERE agent_id IN (SELECT id FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM agent_wakeup_requests WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM agent_task_sessions WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- Step 4: Delete issue-related records
DELETE FROM issue_work_products WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issue_read_states WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issue_labels WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issue_inbox_archives WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issue_documents WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issue_attachments WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issue_approvals WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issue_comments WHERE issue_id IN (SELECT id FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived'));
DELETE FROM issues WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- Step 5: Delete agents
DELETE FROM agents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- Step 6: Delete goals
DELETE FROM goals WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- Step 7: Delete remaining company-related records
DELETE FROM activity_log WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM cost_events WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM finance_events WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM routines WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM routine_triggers WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM routine_runs WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM projects WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM project_goals WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM project_workspaces WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM labels WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM invites WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM join_requests WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM company_skills WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM company_secrets WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM company_logos WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM budget_policies WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM budget_incidents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM plugin_company_settings WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM principal_permission_grants WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM workspace_operations WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM workspace_runtime_services WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM execution_workspaces WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM assets WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM documents WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM document_revisions WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM approvals WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM approval_comments WHERE company_id IN (SELECT id FROM companies WHERE status = 'archived');
DELETE FROM cli_auth_challenges WHERE requested_company_id IN (SELECT id FROM companies WHERE status = 'archived');

-- Step 8: Delete duplicate goals
DELETE FROM goals g1 USING goals g2
WHERE g1.company_id = g2.company_id AND g1.title = g2.title AND g1.id > g2.id;

-- Step 9: Delete archived companies
DELETE FROM companies WHERE status = 'archived';

-- Verification
SELECT 'Active Companies:' as status;
SELECT name, status FROM companies ORDER BY name;

SELECT 'Goals by Company:' as status;
SELECT c.name, COUNT(g.id) as goal_count 
FROM companies c LEFT JOIN goals g ON c.id = g.company_id AND g.status = 'active'
GROUP BY c.name ORDER BY c.name;

SELECT 'Counts:' as status;
SELECT 
    (SELECT COUNT(*) FROM companies) as total_companies,
    (SELECT COUNT(*) FROM goals WHERE status = 'active') as active_goals,
    (SELECT COUNT(*) FROM agents) as total_agents;

COMMIT;
