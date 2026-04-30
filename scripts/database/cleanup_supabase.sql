-- COMPLETE Cleanup Script for Supabase Database
-- Handles ALL foreign key constraints in correct order
-- Last Updated: 2026-04-12

BEGIN;

-- ============================================
-- ARCHIVED COMPANY IDs
-- ============================================
-- '3c97a4f3-8268-4913-950a-48692e1b8947' - ConstructAI
-- '7a49c2e8-a5f3-4714-a0d7-aabafc322f73' - K
-- '24ff8810-d4cd-4846-99f2-fe82b02d44b4' - KnowledgeForge AI (archived)
-- '9ec4c0ec-d8f1-48ab-b473-ec164b584129' - PromptForge AI (archived)
-- '721a7546-43c3-4c73-b197-a654de078847' - Quality Forge
-- '0ac7ed45-524b-4b1b-9d31-e9501b3ce7d9' - Test (Disabled)
-- 'c3559002-20fc-4b42-8e1b-34155e973743' - test-openclaw
-- '8c79a5e9-b435-48a4-b08a-57fa5477212b' - test2 (Disabled)
-- 'b1f6f529-a141-4ac1-92fd-fcdfb28d6373' - test3 (Disabled)
-- 'bc86ac19-0704-4804-8e15-96b7ef44c7d7' - TESTER

-- ============================================
-- STEP 1: Get archived company IDs for reference
-- ============================================
CREATE TEMP TABLE archived_companies AS
SELECT id FROM companies WHERE status = 'archived';

-- ============================================
-- STEP 2: Get archived company agents for reference
-- ============================================
CREATE TEMP TABLE archived_agents AS
SELECT id FROM agents WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 3: Get archived company issues for reference
-- ============================================
CREATE TEMP TABLE archived_issues AS
SELECT id FROM issues WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 4: Delete from issue_work_products (depends on issues)
-- ============================================
DELETE FROM issue_work_products WHERE issue_id IN (SELECT id FROM archived_issues);

-- ============================================
-- STEP 5: Delete from issue_read_states (depends on issues)
-- ============================================
DELETE FROM issue_read_states WHERE issue_id IN (SELECT id FROM archived_issues);

-- ============================================
-- STEP 6: Delete from issue_labels (depends on issues)
-- ============================================
DELETE FROM issue_labels WHERE issue_id IN (SELECT id FROM archived_issues);

-- ============================================
-- STEP 7: Delete from issue_inbox_archives (depends on issues)
-- ============================================
DELETE FROM issue_inbox_archives WHERE issue_id IN (SELECT id FROM archived_issues);

-- ============================================
-- STEP 8: Delete from issue_documents (depends on issues)
-- ============================================
DELETE FROM issue_documents WHERE issue_id IN (SELECT id FROM archived_issues);

-- ============================================
-- STEP 9: Delete from issue_attachments (depends on issues)
-- ============================================
DELETE FROM issue_attachments WHERE issue_id IN (SELECT id FROM archived_issues);

-- ============================================
-- STEP 10: Delete from issue_approvals (depends on issues)
-- ============================================
DELETE FROM issue_approvals WHERE issue_id IN (SELECT id FROM archived_issues);

-- ============================================
-- STEP 11: Delete from issue_comments (depends on issues AND agents)
-- ============================================
DELETE FROM issue_comments WHERE issue_id IN (SELECT id FROM archived_issues);
DELETE FROM issue_comments WHERE author_agent_id IN (SELECT id FROM archived_agents);

-- ============================================
-- STEP 12: Delete routine_runs referencing archived issues
-- ============================================
DELETE FROM routine_runs WHERE linked_issue_id IN (SELECT id FROM archived_issues);

-- ============================================
-- STEP 13: Delete workspace_runtime_services referencing archived issues
-- ============================================
DELETE FROM workspace_runtime_services WHERE issue_id IN (SELECT id FROM archived_issues);

-- ============================================
-- STEP 14: Delete execution_workspaces referencing archived issues
-- ============================================
DELETE FROM execution_workspaces WHERE source_issue_id IN (SELECT id FROM archived_issues);

-- ============================================
-- STEP 15: Delete issues from archived companies
-- ============================================
DELETE FROM issues WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 16: Delete activity_log entries for archived companies/agents
-- ============================================
DELETE FROM activity_log WHERE company_id IN (SELECT id FROM archived_companies);
DELETE FROM activity_log WHERE agent_id IN (SELECT id FROM archived_agents);

-- ============================================
-- STEP 17: Delete cost_events for archived
-- ============================================
DELETE FROM cost_events WHERE company_id IN (SELECT id FROM archived_companies);
DELETE FROM cost_events WHERE agent_id IN (SELECT id FROM archived_agents);
DELETE FROM cost_events WHERE issue_id IN (SELECT id FROM archived_issues);

-- ============================================
-- STEP 18: Delete finance_events for archived
-- ============================================
DELETE FROM finance_events WHERE company_id IN (SELECT id FROM archived_companies);
DELETE FROM finance_events WHERE agent_id IN (SELECT id FROM archived_agents);
DELETE FROM finance_events WHERE issue_id IN (SELECT id FROM archived_issues);

-- ============================================
-- STEP 19: Delete heartbeat_run_events for archived agents
-- ============================================
DELETE FROM heartbeat_run_events WHERE agent_id IN (SELECT id FROM archived_agents);
DELETE FROM heartbeat_run_events WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 20: Delete heartbeat_runs for archived agents
-- ============================================
DELETE FROM heartbeat_runs WHERE agent_id IN (SELECT id FROM archived_agents);
DELETE FROM heartbeat_runs WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 21: Delete agent_skill_assignments (depends on agents)
-- ============================================
DELETE FROM agent_skill_assignments WHERE agent_id IN (SELECT id FROM archived_agents);
DELETE FROM agent_skill_assignments WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 22: Delete agent_api_keys (depends on agents)
-- ============================================
DELETE FROM agent_api_keys WHERE agent_id IN (SELECT id FROM archived_agents);
DELETE FROM agent_api_keys WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 23: Delete agent_config_revisions (depends on agents)
-- ============================================
DELETE FROM agent_config_revisions WHERE agent_id IN (SELECT id FROM archived_agents);
DELETE FROM agent_config_revisions WHERE created_by_agent_id IN (SELECT id FROM archived_agents);
DELETE FROM agent_config_revisions WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 24: Delete agent_runtime_state (depends on agents)
-- ============================================
DELETE FROM agent_runtime_state WHERE agent_id IN (SELECT id FROM archived_agents);
DELETE FROM agent_runtime_state WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 25: Delete agent_task_sessions (depends on agents)
-- ============================================
DELETE FROM agent_task_sessions WHERE agent_id IN (SELECT id FROM archived_agents);
DELETE FROM agent_task_sessions WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 26: Delete agent_wakeup_requests (depends on agents)
-- ============================================
DELETE FROM agent_wakeup_requests WHERE agent_id IN (SELECT id FROM archived_agents);
DELETE FROM agent_wakeup_requests WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 27: Delete approval_comments (depends on agents)
-- ============================================
DELETE FROM approval_comments WHERE author_agent_id IN (SELECT id FROM archived_agents);
DELETE FROM approval_comments WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 28: Delete approvals (depends on agents)
-- ============================================
DELETE FROM approvals WHERE requested_by_agent_id IN (SELECT id FROM archived_agents);
DELETE FROM approvals WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 29: Delete assets (depends on agents)
-- ============================================
DELETE FROM assets WHERE created_by_agent_id IN (SELECT id FROM archived_agents);
DELETE FROM assets WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 30: Delete company_secrets (depends on agents)
-- ============================================
DELETE FROM company_secrets WHERE created_by_agent_id IN (SELECT id FROM archived_agents);
DELETE FROM company_secrets WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 31: Delete document_revisions (depends on agents)
-- ============================================
DELETE FROM document_revisions WHERE created_by_agent_id IN (SELECT id FROM archived_agents);
DELETE FROM document_revisions WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 32: Delete documents (depends on agents)
-- ============================================
DELETE FROM documents WHERE created_by_agent_id IN (SELECT id FROM archived_agents);
DELETE FROM documents WHERE updated_by_agent_id IN (SELECT id FROM archived_agents);
DELETE FROM documents WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 33: Delete routines (depends on agents)
-- ============================================
DELETE FROM routines WHERE assignee_agent_id IN (SELECT id FROM archived_agents);
DELETE FROM routines WHERE created_by_agent_id IN (SELECT id FROM archived_agents);
DELETE FROM routines WHERE updated_by_agent_id IN (SELECT id FROM archived_agents);
DELETE FROM routines WHERE parent_issue_id IN (SELECT id FROM archived_issues);
DELETE FROM routines WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 34: Delete routine_triggers (depends on agents)
-- ============================================
DELETE FROM routine_triggers WHERE created_by_agent_id IN (SELECT id FROM archived_agents);
DELETE FROM routine_triggers WHERE updated_by_agent_id IN (SELECT id FROM archived_agents);
DELETE FROM routine_triggers WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 35: Delete projects (depends on agents)
-- ============================================
DELETE FROM projects WHERE lead_agent_id IN (SELECT id FROM archived_agents);
DELETE FROM projects WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 36: Delete project_goals (depends on goals)
-- ============================================
DELETE FROM project_goals WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 37: Delete project_workspaces
-- ============================================
DELETE FROM project_workspaces WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 38: Delete labels
-- ============================================
DELETE FROM labels WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 39: Delete invites
-- ============================================
DELETE FROM invites WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 40: Delete join_requests
-- ============================================
DELETE FROM join_requests WHERE company_id IN (SELECT id FROM archived_companies);
DELETE FROM join_requests WHERE created_agent_id IN (SELECT id FROM archived_agents);

-- ============================================
-- STEP 41: Delete company_skills
-- ============================================
DELETE FROM company_skills WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 42: Delete company_logos
-- ============================================
DELETE FROM company_logos WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 43: Delete budget_policies
-- ============================================
DELETE FROM budget_policies WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 44: Delete budget_incidents
-- ============================================
DELETE FROM budget_incidents WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 45: Delete plugin_company_settings
-- ============================================
DELETE FROM plugin_company_settings WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 46: Delete principal_permission_grants
-- ============================================
DELETE FROM principal_permission_grants WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 47: Delete cli_auth_challenges
-- ============================================
DELETE FROM cli_auth_challenges WHERE requested_company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 48: Delete workspace_operations
-- ============================================
DELETE FROM workspace_operations WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 49: Delete workspace_runtime_services
-- ============================================
DELETE FROM workspace_runtime_services WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 50: Delete goals from archived companies
-- ============================================
DELETE FROM goals WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 51: Update agents reports_to (self-reference cleanup)
-- ============================================
UPDATE agents SET reports_to = NULL WHERE reports_to IN (SELECT id FROM archived_agents);

-- ============================================
-- STEP 52: Delete agents from archived companies
-- ============================================
DELETE FROM agents WHERE company_id IN (SELECT id FROM archived_companies);

-- ============================================
-- STEP 53: Delete duplicate goals from active companies
-- ============================================
DELETE FROM goals g1
USING goals g2
WHERE g1.company_id = g2.company_id 
  AND g1.title = g2.title 
  AND g1.id > g2.id;

-- ============================================
-- STEP 54: Delete archived companies
-- ============================================
DELETE FROM companies WHERE status = 'archived';

-- ============================================
-- STEP 55: Clean up temp tables
-- ============================================
DROP TABLE IF EXISTS archived_issues;
DROP TABLE IF EXISTS archived_agents;
DROP TABLE IF EXISTS archived_companies;

-- ============================================
-- Verification
-- ============================================
SELECT '=== Active Companies ===' as status;
SELECT id, name FROM companies WHERE status = 'active' ORDER BY name;

SELECT '=== Goals by Active Company ===' as status;
SELECT c.name as company, COUNT(g.id) as goal_count 
FROM companies c 
LEFT JOIN goals g ON c.id = g.company_id AND g.status = 'active'
WHERE c.status = 'active'
GROUP BY c.name 
ORDER BY c.name;

SELECT '=== Total Counts ===' as status;
SELECT 
    (SELECT COUNT(*) FROM companies WHERE status = 'active') as active_companies,
    (SELECT COUNT(*) FROM agents) as total_agents,
    (SELECT COUNT(*) FROM goals WHERE status = 'active') as active_goals,
    (SELECT COUNT(*) FROM companies WHERE status = 'archived') as archived_companies;

SELECT '=== Remaining Duplicate Goals ===' as status;
SELECT company_id, title, COUNT(*) as count
FROM goals 
WHERE status = 'active'
GROUP BY company_id, title 
HAVING COUNT(*) > 1;

COMMIT;
