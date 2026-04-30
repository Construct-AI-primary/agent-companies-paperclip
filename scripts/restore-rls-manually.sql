-- ========================================================================================
-- MANUAL RLS RESTORATION
-- Restore Row Level Security to its proper state after schema extraction
-- Run this when the backup table is not available
-- ========================================================================================

-- Based on the schema extraction results, these core tables should have RLS enabled:
-- agents, companies, issues, projects, and most other application tables

DO $$
DECLARE
    table_record RECORD;
    tables_restored INTEGER := 0;
BEGIN
    -- List of tables that should have RLS enabled (based on typical Paperclip setup)
    FOR table_record IN VALUES
        ('agents'),
        ('companies'),
        ('issues'),
        ('projects'),
        ('goals'),
        ('agent_api_keys'),
        ('agent_skill_assignments'),
        ('agent_runtime_state'),
        ('agent_config_revisions'),
        ('agent_wakeup_requests'),
        ('heartbeat_runs'),
        ('heartbeat_run_events'),
        ('cost_events'),
        ('finance_events'),
        ('activity_log'),
        ('agent_task_sessions'),
        ('issue_work_products'),
        ('issue_read_states'),
        ('issue_labels'),
        ('issue_inbox_archives'),
        ('issue_documents'),
        ('issue_attachments'),
        ('issue_approvals'),
        ('issue_comments'),
        ('project_workspaces'),
        ('project_goals'),
        ('routine_runs'),
        ('routine_triggers'),
        ('routines'),
        ('company_secret_versions'),
        ('company_secrets'),
        ('company_skills'),
        ('company_logos'),
        ('budget_incidents'),
        ('budget_policies'),
        ('plugin_company_settings'),
        ('principal_permission_grants'),
        ('cli_auth_challenges'),
        ('join_requests'),
        ('invites'),
        ('labels'),
        ('document_revisions'),
        ('documents'),
        ('assets'),
        ('approval_comments'),
        ('approvals'),
        ('workspace_runtime_services'),
        ('workspace_operations'),
        ('execution_workspaces')
    LOOP
        -- Enable RLS for this table
        BEGIN
            EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY',
                          table_record.column1);
            tables_restored := tables_restored + 1;
            RAISE NOTICE 'Restored RLS (ENABLED) on: public.%', table_record.column1;
        EXCEPTION
            WHEN others THEN
                RAISE NOTICE 'Could not enable RLS on public.%: %', table_record.column1, SQLERRM;
        END;
    END LOOP;

    RAISE NOTICE 'RLS restoration complete: % tables processed', tables_restored;
END $$;

-- Verify RLS has been restored correctly
SELECT
    schemaname,
    tablename,
    rowsecurity as rls_enabled,
    CASE
        WHEN rowsecurity THEN 'ENABLED ✓'
        ELSE 'DISABLED ⚠️'
    END as status
FROM pg_tables
WHERE schemaname = 'public'
AND tablename IN (
    'agents', 'companies', 'issues', 'projects', 'goals',
    'agent_skill_assignments', 'company_skills', 'heartbeat_runs',
    'issues', 'models', 'model_benchmarks', 'model_change_log',
    'project_workspaces', 'shared_skills'
)
ORDER BY schemaname, tablename;

-- Final verification count
DO $$
DECLARE
    total_tables INTEGER;
    rls_enabled INTEGER;
    rls_disabled INTEGER;
BEGIN
    SELECT
        COUNT(*),
        COUNT(*) FILTER (WHERE rowsecurity = true),
        COUNT(*) FILTER (WHERE rowsecurity = false)
    INTO total_tables, rls_enabled, rls_disabled
    FROM pg_tables
    WHERE schemaname = 'public';

    RAISE NOTICE 'FINAL VERIFICATION: % total tables (% RLS enabled, % RLS disabled)',
                total_tables, rls_enabled, rls_disabled;

    IF rls_enabled < rls_disabled THEN
        RAISE NOTICE '⚠️ WARNING: More tables have RLS disabled than enabled. Please verify this is correct.';
    ELSE
        RAISE NOTICE '✅ RLS restoration appears successful.';
    END IF;
END $$;