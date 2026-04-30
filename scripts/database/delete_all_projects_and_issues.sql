-- Paperclip: Delete all projects and issues data
-- This script safely removes all project and issue related records
-- while respecting foreign key constraints

-- Start transaction for safety
BEGIN;

-- =============================================================================
-- STEP 1: Delete from tables with CASCADE on issues/projects
-- These will be automatically deleted when we delete issues/projects
-- But we'll explicitly delete them first for clarity and control
-- =============================================================================

-- Delete issue-related records that cascade
DELETE FROM issue_comments;
DELETE FROM issue_attachments;
DELETE FROM issue_labels;
DELETE FROM issue_approvals;
DELETE FROM issue_documents;
DELETE FROM issue_work_products;
DELETE FROM issue_inbox_archives;
DELETE FROM issue_read_states;

-- Delete project-related records that cascade
DELETE FROM project_workspaces;
DELETE FROM project_goals;
DELETE FROM execution_workspaces;
DELETE FROM routines;

-- =============================================================================
-- STEP 2: Set NULL for foreign keys that don't cascade
-- These references will be set to NULL when issues/projects are deleted
-- =============================================================================

-- Set issue references to NULL in tables that don't cascade
UPDATE routines SET parent_issue_id = NULL WHERE parent_issue_id IS NOT NULL;
UPDATE execution_workspaces SET source_issue_id = NULL WHERE source_issue_id IS NOT NULL;
UPDATE workspace_runtime_services SET issue_id = NULL WHERE issue_id IS NOT NULL;
UPDATE routine_runs SET linked_issue_id = NULL WHERE linked_issue_id IS NOT NULL;

-- Set project references to NULL in tables that don't cascade
UPDATE issue_work_products SET project_id = NULL WHERE project_id IS NOT NULL;
UPDATE workspace_runtime_services SET project_id = NULL WHERE project_id IS NOT NULL;

-- =============================================================================
-- STEP 3: Delete from cost and finance events (no cascade)
-- =============================================================================

DELETE FROM cost_events WHERE issue_id IS NOT NULL OR project_id IS NOT NULL;
DELETE FROM finance_events WHERE issue_id IS NOT NULL OR project_id IS NOT NULL;

-- =============================================================================
-- STEP 4: Delete from activity log (entity references)
-- =============================================================================

DELETE FROM activity_log WHERE entity_type IN ('issue', 'project');

-- =============================================================================
-- STEP 5: Delete issues (this will cascade to remaining child tables)
-- =============================================================================

DELETE FROM issues;

-- =============================================================================
-- STEP 6: Delete projects (this will cascade to remaining child tables)
-- =============================================================================

DELETE FROM projects;

-- =============================================================================
-- STEP 7: Verify deletion
-- =============================================================================

-- Check that no issues remain
DO $$
DECLARE
    issue_count INTEGER;
    project_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO issue_count FROM issues;
    SELECT COUNT(*) INTO project_count FROM projects;

    RAISE NOTICE 'Remaining issues: %', issue_count;
    RAISE NOTICE 'Remaining projects: %', project_count;

    IF issue_count > 0 OR project_count > 0 THEN
        RAISE EXCEPTION 'Deletion incomplete - issues: %, projects: %', issue_count, project_count;
    END IF;
END $$;

-- =============================================================================
-- STEP 8: Final verification - check for orphaned records
-- =============================================================================

-- Check for any remaining references to deleted issues/projects
DO $$
DECLARE
    orphaned_count INTEGER;
BEGIN
    -- Check routines with null parent_issue_id (should be all of them now)
    SELECT COUNT(*) INTO orphaned_count FROM routines WHERE parent_issue_id IS NOT NULL;
    IF orphaned_count > 0 THEN
        RAISE NOTICE 'Warning: % routines still reference issues', orphaned_count;
    END IF;

    -- Check execution_workspaces with null source_issue_id
    SELECT COUNT(*) INTO orphaned_count FROM execution_workspaces WHERE source_issue_id IS NOT NULL;
    IF orphaned_count > 0 THEN
        RAISE NOTICE 'Warning: % execution workspaces still reference issues', orphaned_count;
    END IF;

    -- Check workspace_runtime_services with null issue_id
    SELECT COUNT(*) INTO orphaned_count FROM workspace_runtime_services WHERE issue_id IS NOT NULL;
    IF orphaned_count > 0 THEN
        RAISE NOTICE 'Warning: % workspace runtime services still reference issues', orphaned_count;
    END IF;

    -- Check workspace_runtime_services with null project_id
    SELECT COUNT(*) INTO orphaned_count FROM workspace_runtime_services WHERE project_id IS NOT NULL;
    IF orphaned_count > 0 THEN
        RAISE NOTICE 'Warning: % workspace runtime services still reference projects', orphaned_count;
    END IF;

    RAISE NOTICE 'Orphaned reference check complete';
END $$;

-- Commit the transaction
COMMIT;

-- Final summary
SELECT
    'issues' as table_name, COUNT(*) as remaining_records FROM issues
UNION ALL
SELECT
    'projects' as table_name, COUNT(*) as remaining_records FROM projects
UNION ALL
SELECT
    'issue_comments' as table_name, COUNT(*) as remaining_records FROM issue_comments
UNION ALL
SELECT
    'issue_attachments' as table_name, COUNT(*) as remaining_records FROM issue_attachments
UNION ALL
SELECT
    'issue_labels' as table_name, COUNT(*) as remaining_records FROM issue_labels
UNION ALL
SELECT
    'issue_approvals' as table_name, COUNT(*) as remaining_records FROM issue_approvals
UNION ALL
SELECT
    'issue_documents' as table_name, COUNT(*) as remaining_records FROM issue_documents
UNION ALL
SELECT
    'issue_work_products' as table_name, COUNT(*) as remaining_records FROM issue_work_products
UNION ALL
SELECT
    'issue_inbox_archives' as table_name, COUNT(*) as remaining_records FROM issue_inbox_archives
UNION ALL
SELECT
    'issue_read_states' as table_name, COUNT(*) as remaining_records FROM issue_read_states
UNION ALL
SELECT
    'project_workspaces' as table_name, COUNT(*) as remaining_records FROM project_workspaces
UNION ALL
SELECT
    'project_goals' as table_name, COUNT(*) as remaining_records FROM project_goals
UNION ALL
SELECT
    'execution_workspaces' as table_name, COUNT(*) as remaining_records FROM execution_workspaces
UNION ALL
SELECT
    'routines' as table_name, COUNT(*) as remaining_records FROM routines
ORDER BY table_name;