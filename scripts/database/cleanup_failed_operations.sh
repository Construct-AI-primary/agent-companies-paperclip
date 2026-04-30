#!/bin/bash
# Cleanup failed operations and activity log entries
# Generated: 2026-04-13

echo "=================================="
echo "Cleaning up failed operations"
echo "=================================="
echo ""

# Check if .env file exists
if [ ! -f .env ]; then
    echo "⚠️  No .env file found. Using example configuration..."
    echo ""
fi

echo "Step 1: Checking for ALL failed operations in activity log..."
echo ""

# Check for failed operations
psql -h localhost -U paperclip -d paperclip -c \
  "SELECT
    'Checking activity_log for ALL failed operations:' as info,
    COUNT(*) as failed_operations_count
   FROM activity_log
   WHERE action IN ('agent_creation_failed', 'agent_update_failed', 'operation_failed', 'run_failed', 'heartbeat_failed')
      OR details::text ILIKE '%failed%'
      OR details::text ILIKE '%error%'
      OR details::text ILIKE '%missing%';" 2>/dev/null || echo "Could not connect to database"

echo ""
echo "Step 2: Showing failed operations before cleanup..."
echo ""

# Show failed operations
psql -h localhost -U paperclip -d paperclip -c \
  "SELECT
    id,
    company_id,
    actor_type,
    actor_id,
    action,
    LEFT(details::text, 150) as details_preview,
    created_at
   FROM activity_log
   WHERE action IN ('agent_creation_failed', 'agent_update_failed', 'operation_failed', 'run_failed', 'heartbeat_failed')
      OR details::text ILIKE '%failed%'
      OR details::text ILIKE '%error%'
      OR details::text ILIKE '%missing%'
   ORDER BY created_at DESC
   LIMIT 20;" 2>/dev/null || echo "Could not connect to database"

echo ""
echo "Step 3: Running cleanup script..."
echo ""

# Run the cleanup SQL script
psql -h localhost -U paperclip -d paperclip -f cleanup_failed_operations.sql 2>/dev/null || {
    echo "Could not connect to PostgreSQL database."
    echo "If using embedded database, start the Paperclip dev server first:"
    echo "  cd /path/to/paperclip && pnpm dev"
    echo ""
    echo "If using Supabase, run the SQL file manually in the SQL Editor."
    exit 1
}

echo ""
echo "Step 4: Final verification..."
echo ""

# Final verification
psql -h localhost -U paperclip -d paperclip -c \
  "SELECT
    'After cleanup - remaining legitimate Vision activity:' as info,
    COUNT(*) as remaining_entries
   FROM activity_log
   WHERE details::text ILIKE '%vision%'
     AND action NOT IN ('agent_creation_failed', 'agent_update_failed', 'operation_failed');" 2>/dev/null || echo "Could not connect to database"

echo ""
echo "=================================="
echo "✅ Failed operations cleanup complete!"
echo "=================================="
echo ""
echo "Summary:"
echo "- Removed ONLY failed agent creation/update log entries"
echo "- Preserved legitimate Vision activity logs (successful operations)"
echo "- Failed items should no longer appear in inbox"
echo "- The remaining activity logs are normal system operations"
echo ""
echo "If you're using Supabase instead of local PostgreSQL:"
echo "1. Go to Supabase SQL Editor"
echo "2. Run the file: scripts/database/cleanup_failed_operations.sql"
echo ""
