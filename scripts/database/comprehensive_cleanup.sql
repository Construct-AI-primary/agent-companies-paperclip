-- Comprehensive cleanup of failed operations
-- This catches all possible failed operation patterns

BEGIN;

-- First, let's see ALL activity log entries to understand the patterns
SELECT 
    'Total activity log entries:' as info,
    COUNT(*) as total_count
FROM activity_log;

-- Show recent entries that might be failed operations
SELECT 
    id,
    action,
    LEFT(details::text, 200) as details_preview,
    created_at
FROM activity_log 
ORDER BY created_at DESC
LIMIT 50;

-- Look for entries that contain common failure indicators
SELECT 
    id,
    action,
    LEFT(details::text, 200) as details_preview,
    created_at
FROM activity_log 
WHERE details::text ILIKE '%failed%'
   OR details::text ILIKE '%error%'
   OR details::text ILIKE '%missing%'
   OR details::text ILIKE '%strategos%'
   OR details::text ILIKE '%openclaw%'
   OR details::text ILIKE '%gateway%'
   OR action ILIKE '%failed%'
   OR action = 'run_failed'
   OR action = 'heartbeat_failed'
ORDER BY created_at DESC;

-- Now delete ALL entries that look like failures
-- This is more aggressive but should catch everything
DELETE FROM activity_log 
WHERE details::text ILIKE '%failed%'
   OR details::text ILIKE '%error%'  
   OR details::text ILIKE '%missing%'
   OR details::text ILIKE '%strategos%'
   OR details::text ILIKE '%openclaw%'
   OR details::text ILIKE '%gateway%'
   OR action ILIKE '%failed%'
   OR action = 'run_failed'
   OR action = 'heartbeat_failed'
   OR action = 'agent_creation_failed'
   OR action = 'agent_update_failed'
   OR action = 'operation_failed';

-- Verify what was deleted and what remains
SELECT 
    'Remaining activity log entries after cleanup:' as info,
    COUNT(*) as remaining_count
FROM activity_log;

COMMIT;
