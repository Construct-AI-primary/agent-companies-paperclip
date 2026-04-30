-- Cleanup failed operations and activity log entries
-- This script removes failed agent creation attempts, failed heartbeat runs,
-- and related log entries from both activity_log and heartbeat_runs tables

BEGIN;

-- ============================================================
-- PART 1: Clean activity_log
-- ============================================================

-- Phase 1: Diagnostic - Check for ALL failed/error/cancelled operations in activity_log
SELECT
    'Checking activity_log for ALL failed/error/cancelled operations:' as info,
    COUNT(*) as failed_operations_count
FROM activity_log
WHERE action ILIKE '%failed%'
   OR action ILIKE '%error%'
   OR action ILIKE '%cancelled%'
   OR action ILIKE '%timeout%'
   OR action ILIKE '%interrupt%'
   OR action ILIKE '%abort%'
   OR details::text ILIKE '%failed%'
   OR details::text ILIKE '%error%';

-- Phase 2: Show failed operations before cleanup (grouped by action type)
SELECT
    action,
    COUNT(*) as count,
    MIN(created_at) as earliest,
    MAX(created_at) as latest
FROM activity_log
WHERE action ILIKE '%failed%'
   OR action ILIKE '%error%'
   OR action ILIKE '%cancelled%'
GROUP BY action
ORDER BY count DESC;

-- Phase 3: Remove ALL failed/error operations from activity log
-- Covers: failed, error, cancelled, timeout, interrupt, abort actions
-- Plus any details text containing error indicators
DELETE FROM activity_log
WHERE action ILIKE '%failed%'
   OR action ILIKE '%error%'
   OR action ILIKE '%cancelled%'
   OR action ILIKE '%timeout%'
   OR action ILIKE '%interrupt%'
   OR action ILIKE '%abort%'
   OR action ILIKE '%exception%'
   OR action ILIKE '%crash%'
   OR action IN (
       'agent_creation_failed',
       'agent_update_failed',
       'operation_failed',
       'run_failed',
       'heartbeat_failed',
       'hire_hook.failed',
       'hire_hook.error',
       'heartbeat.cancelled',
       'approval.requester_wakeup_failed',
       'budget.soft_threshold_crossed',
       'budget.hard_threshold_crossed'
   )
   OR details::text ILIKE '%failed%'
   OR details::text ILIKE '%error%'
   OR details::text ILIKE '%missing%'
   OR details::text ILIKE '%strategos%'
   OR details::text ILIKE '%openclaw%'
   OR details::text ILIKE '%gateway%'
   OR details::text ILIKE '%exception%'
   OR details::text ILIKE '%crash%'
   OR details::text ILIKE '%invalid%'
   OR details::text ILIKE '%refused%'
   OR details::text ILIKE '%unauthorized%'
   OR details::text ILIKE '%forbidden%'
   OR details::text ILIKE '%not found%'
   OR details::text ILIKE '%not_found%'
   OR details::text ILIKE '%timed out%'
   OR details::text ILIKE '%timeout%'
   OR details::text ILIKE '%abort%'
   OR details::text ILIKE '%reject%'
   OR details::text ILIKE '%denied%';

-- Phase 4: Verify activity_log cleanup
SELECT
    'After activity_log cleanup - remaining entries:' as info,
    COUNT(*) as remaining_entries
FROM activity_log;

-- ============================================================
-- PART 2: Clean heartbeat_runs (failed run records)
-- ============================================================

-- Phase 5: Diagnostic - Check for failed runs in heartbeat_runs
SELECT
    'Checking heartbeat_runs for FAILED runs:' as info,
    COUNT(*) as failed_runs_count
FROM heartbeat_runs
WHERE status = 'failed'
   OR error IS NOT NULL
   OR error_code IS NOT NULL
   OR error::text ILIKE '%failed%'
   OR error::text ILIKE '%error%'
   OR error::text ILIKE '%missing%'
   OR error::text ILIKE '%adapter%';

-- Phase 6: Show sample failed runs for review
SELECT
    id,
    company_id,
    agent_id,
    status,
    LEFT(error::text, 200) as error_preview,
    error_code,
    exit_code,
    signal,
    started_at,
    finished_at,
    created_at
FROM heartbeat_runs
WHERE status = 'failed'
   OR error IS NOT NULL
   OR error::text ILIKE '%failed%'
   OR error::text ILIKE '%error%'
   OR error::text ILIKE '%missing%'
   OR error::text ILIKE '%adapter%'
   OR error_code IS NOT NULL
ORDER BY created_at DESC
LIMIT 30;

-- Phase 7: Remove failed runs from heartbeat_runs
-- Also remove related entries from heartbeat_run_events and agent_task_sessions
-- that reference these failed runs

-- First, get the IDs of failed runs
WITH failed_runs AS (
    SELECT id FROM heartbeat_runs
    WHERE status = 'failed'
       OR error IS NOT NULL
       OR error::text ILIKE '%failed%'
       OR error::text ILIKE '%error%'
       OR error::text ILIKE '%missing%'
       OR error::text ILIKE '%adapter%'
       OR error_code IS NOT NULL
)
-- Delete related run events
DELETE FROM heartbeat_run_events
WHERE run_id IN (SELECT id FROM failed_runs);

-- Phase 8: Delete the failed runs themselves
DELETE FROM heartbeat_runs
WHERE status = 'failed'
   OR error IS NOT NULL
   OR error::text ILIKE '%failed%'
   OR error::text ILIKE '%error%'
   OR error::text ILIKE '%missing%'
   OR error::text ILIKE '%adapter%'
   OR error_code IS NOT NULL;

-- Phase 9: Clean up agent_task_sessions that reference deleted runs
-- Remove sessions that have last_run_id pointing to a non-existent run
DELETE FROM agent_task_sessions ats
WHERE ats.last_run_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM heartbeat_runs hr WHERE hr.id = ats.last_run_id
  );

-- Phase 10: Clean up agent_runtime_state that references non-existent runs
UPDATE agent_runtime_state
SET last_run_id = NULL
WHERE last_run_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM heartbeat_runs hr WHERE hr.id = agent_runtime_state.last_run_id
  );

-- ============================================================
-- PART 3: Final verification
-- ============================================================

-- Phase 11: Show remaining heartbeat_runs status distribution
SELECT
    'Remaining heartbeat_runs status distribution:' as info,
    status,
    COUNT(*) as count
FROM heartbeat_runs
GROUP BY status
ORDER BY count DESC;

-- Phase 12: Show remaining activity_log actions distribution
SELECT
    'Remaining activity_log actions distribution:' as info,
    action,
    COUNT(*) as count
FROM activity_log
GROUP BY action
ORDER BY count DESC
LIMIT 20;

COMMIT;

-- Optional: Show remaining entries for verification
-- SELECT 'activity_log' as table_name, action, details::text, created_at FROM activity_log ORDER BY created_at DESC LIMIT 20;
-- SELECT 'heartbeat_runs' as table_name, status, error, created_at FROM heartbeat_runs ORDER BY created_at DESC LIMIT 20;
