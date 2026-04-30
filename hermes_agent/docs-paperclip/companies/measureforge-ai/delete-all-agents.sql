-- ============================================================
-- Delete All MeasureForge AI Agents (Proper FK Order)
-- Created: 2026-04-22
-- Description: Removes all existing agents from MeasureForge AI company following FK dependency order
-- Prerequisites: MeasureForge AI company must exist
-- Note: This will remove 65+ agents to prepare for tiered architecture
-- Follows: docs-paperclip/procedures/agents/deleting-companies-and-agents.md
-- ============================================================

-- Verify MeasureForge AI company exists before proceeding
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM companies WHERE name = 'MeasureForge AI') THEN
        RAISE EXCEPTION 'ERROR: MeasureForge AI company does not exist. Please run register-company.sql first.';
    END IF;
END $$;

-- Get MeasureForge AI company ID
DO $$
DECLARE
    measureforge_company_id UUID;
BEGIN
    SELECT id INTO measureforge_company_id FROM companies WHERE name = 'MeasureForge AI';

    -- Log start of deletion process
    RAISE NOTICE 'Starting deletion of all MeasureForge AI agents (company_id: %)', measureforge_company_id;

    -- ====================================================
    -- LEVEL 1: Deepest Dependencies (Heartbeat Records)
    -- ====================================================

    -- Delete heartbeat_runs first (references agent_wakeup_requests)
    DELETE FROM heartbeat_runs
    WHERE agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Deleted heartbeat_runs';

    -- ====================================================
    -- LEVEL 4: Agent Configuration (Delete FIRST)
    -- ====================================================

    -- Delete agent_skill_assignments (CRITICAL - blocks agent deletion)
    DELETE FROM agent_skill_assignments
    WHERE agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Deleted agent_skill_assignments';

    -- Delete agent_runtime_state (referenced in error)
    DELETE FROM agent_runtime_state
    WHERE agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Deleted agent_runtime_state';

    -- Delete agent_config_revisions
    DELETE FROM agent_config_revisions
    WHERE agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Deleted agent_config_revisions';

    -- Delete agent_api_keys
    DELETE FROM agent_api_keys
    WHERE agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Deleted agent_api_keys';

    -- Delete agent_wakeup_requests (now safe - heartbeat_runs deleted)
    DELETE FROM agent_wakeup_requests
    WHERE agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Deleted agent_wakeup_requests';

    -- ====================================================
    -- LEVEL 3: Agent Activity Records
    -- ====================================================

    -- Delete cost_events (agent_id)
    DELETE FROM cost_events
    WHERE agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Deleted cost_events (agent)';

    -- Delete finance_events (agent_id)
    DELETE FROM finance_events
    WHERE agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Deleted finance_events (agent)';

    -- Delete activity_log (agent_id)
    DELETE FROM activity_log
    WHERE agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Deleted activity_log (agent)';

    -- Delete agent_task_sessions
    DELETE FROM agent_task_sessions
    WHERE agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Deleted agent_task_sessions';

    -- ====================================================
    -- LEVEL 6: Nullable FK Updates (Set to NULL)
    -- ====================================================

    -- Update issues (assignee_agent_id) - set to NULL
    UPDATE issues SET assignee_agent_id = NULL
    WHERE assignee_agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Updated issues (assignee_agent_id to NULL)';

    -- Update issues (created_by_agent_id) - set to NULL
    UPDATE issues SET created_by_agent_id = NULL
    WHERE created_by_agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Updated issues (created_by_agent_id to NULL)';

    -- Update goals (owner_agent_id) - set to NULL
    UPDATE goals SET owner_agent_id = NULL
    WHERE owner_agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Updated goals (owner_agent_id to NULL)';

    -- Update projects (lead_agent_id) - set to NULL
    UPDATE projects SET lead_agent_id = NULL
    WHERE lead_agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Updated projects (lead_agent_id to NULL)';

    -- Update routines (assignee_agent_id) - set to NULL
    UPDATE routines SET assignee_agent_id = NULL
    WHERE assignee_agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Updated routines (assignee_agent_id to NULL)';

    -- Update routines (created_by_agent_id) - set to NULL
    UPDATE routines SET created_by_agent_id = NULL
    WHERE created_by_agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Updated routines (created_by_agent_id to NULL)';

    -- Update routines (updated_by_agent_id) - set to NULL
    UPDATE routines SET updated_by_agent_id = NULL
    WHERE updated_by_agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Updated routines (updated_by_agent_id to NULL)';

    -- Update routine_triggers (created_by_agent_id) - set to NULL
    UPDATE routine_triggers SET created_by_agent_id = NULL
    WHERE created_by_agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Updated routine_triggers (created_by_agent_id to NULL)';

    -- Update routine_triggers (updated_by_agent_id) - set to NULL
    UPDATE routine_triggers SET updated_by_agent_id = NULL
    WHERE updated_by_agent_id IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Updated routine_triggers (updated_by_agent_id to NULL)';

    -- Update agents (reports_to) - self-referential, set to NULL
    UPDATE agents SET reports_to = NULL
    WHERE reports_to IN (SELECT id FROM agents WHERE company_id = measureforge_company_id);
    RAISE NOTICE 'Updated agents (reports_to to NULL)';

    -- ====================================================
    -- LEVEL 7: Final Agent Deletion
    -- ====================================================

    -- Finally delete the agents themselves
    DELETE FROM agents
    WHERE company_id = measureforge_company_id;

    -- Log completion
    RAISE NOTICE 'Successfully completed deletion of all MeasureForge AI agents and dependencies';

END $$;
