-- SQL Script to Delete All Records from Tables: issues, heartbeat_runs, and heartbeat_run_events
-- Generated for Database Agent: infraforge-ai-database-infrastructure
-- Based on FK dependencies documented in /docs-paperclip/schema/constraints/FK-DEPENDENCY-LEVELS.md
-- and FK table relationships CSV
--
-- CRITICAL FIX: The original script failed because it didn't account for ALL FK references to heartbeat_runs.
-- When deleting ALL records from heartbeat_runs, we must handle ALL tables that reference it.
--
-- Complete FK Dependency Analysis:
--
-- For heartbeat_runs:
-- Tables with FKs TO heartbeat_runs that must be handled:
-- 1. heartbeat_run_events.run_id → heartbeat_runs.id (DELETE child first)
-- 2. agent_task_sessions.last_run_id → heartbeat_runs.id (DELETE referencing records)
-- 3. cost_events.heartbeat_run_id → heartbeat_runs.id (DELETE referencing records)
-- 4. finance_events.heartbeat_run_id → heartbeat_runs.id (DELETE referencing records)
-- 5. issue_comments.created_by_run_id → heartbeat_runs.id (SET NULL - nullable)
-- 6. issue_execution_decisions.created_by_run_id → heartbeat_runs.id (SET NULL - nullable)
-- 7. issue_work_products.created_by_run_id → heartbeat_runs.id (SET NULL - nullable)
-- 8. workspace_operations.heartbeat_run_id → heartbeat_runs.id (SET NULL - nullable)
-- 9. workspace_runtime_services.started_by_run_id → heartbeat_runs.id (SET NULL - nullable)
--
-- For issues:
-- Tables with FKs TO issues that must be handled:
-- 1. issue_comments.issue_id → issues.id (DELETE referencing records - NO ACTION)
-- 2. issue_read_states.issue_id → issues.id (DELETE referencing records - NO ACTION)
-- 3. issue_thread_interactions.issue_id → issues.id (DELETE referencing records - NO ACTION)
-- 4. issues.checkout_run_id → heartbeat_runs.id (SET NULL - already handled above)
-- 5. issues.execution_run_id → heartbeat_runs.id (SET NULL - already handled above)
-- 6. routine_runs.linked_issue_id → issues.id (SET NULL - nullable)
-- Note: CASCADE FKs (issue_approvals, issue_attachments, etc.) will auto-delete
--
-- Correct Deletion Order:
-- 1. Handle SET NULL FKs to heartbeat_runs and issues
-- 2. Delete tables with NO ACTION FKs to heartbeat_runs
-- 3. Delete heartbeat_run_events (child of heartbeat_runs)
-- 4. Delete tables with NO ACTION FKs to issues
-- 5. Delete heartbeat_runs and issues (now safe)

-- Step 1: Handle SET NULL FKs to heartbeat_runs and issues (set to NULL before deleting)
UPDATE public.issue_comments SET created_by_run_id = NULL WHERE created_by_run_id IS NOT NULL;
UPDATE public.issue_execution_decisions SET created_by_run_id = NULL WHERE created_by_run_id IS NOT NULL;
UPDATE public.issue_work_products SET created_by_run_id = NULL WHERE created_by_run_id IS NOT NULL;
UPDATE public.workspace_operations SET heartbeat_run_id = NULL WHERE heartbeat_run_id IS NOT NULL;
UPDATE public.workspace_runtime_services SET started_by_run_id = NULL WHERE started_by_run_id IS NOT NULL;
UPDATE public.routine_runs SET linked_issue_id = NULL WHERE linked_issue_id IS NOT NULL;

-- Step 2: Delete tables with NO ACTION FKs TO heartbeat_runs (must delete before heartbeat_runs)
DELETE FROM public.cost_events WHERE heartbeat_run_id IS NOT NULL;
DELETE FROM public.finance_events WHERE heartbeat_run_id IS NOT NULL;
DELETE FROM public.agent_task_sessions WHERE last_run_id IS NOT NULL;

-- Step 3: Delete heartbeat_run_events (child table of heartbeat_runs)
DELETE FROM public.heartbeat_run_events;

-- Step 4: Delete tables with NO ACTION FKs TO issues (must delete before issues)
DELETE FROM public.issue_comments WHERE issue_id IS NOT NULL;
DELETE FROM public.issue_read_states WHERE issue_id IS NOT NULL;
DELETE FROM public.issue_thread_interactions WHERE issue_id IS NOT NULL;

-- Step 5: Delete all records from heartbeat_runs (now safe - all FK references handled)
DELETE FROM public.heartbeat_runs;

-- Step 6: Delete all records from issues (now safe - all FK references handled)
DELETE FROM public.issues;

-- Verification: Check that tables are empty
-- SELECT COUNT(*) as heartbeat_run_events_count FROM public.heartbeat_run_events;
-- SELECT COUNT(*) as heartbeat_runs_count FROM public.heartbeat_runs;
-- SELECT COUNT(*) as issues_count FROM public.issues;