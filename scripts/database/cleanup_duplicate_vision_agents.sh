#!/bin/bash
# Cleanup duplicate Vision Loopy CEO agents
# Generated: 2026-04-13

echo "=================================="
echo "Cleaning up duplicate Vision agents"
echo "=================================="
echo ""

# Check if .env file exists
if [ ! -f .env ]; then
    echo "⚠️  No .env file found. Using example configuration..."
    echo ""
fi

echo "Step 1: Checking for duplicate Vision agents..."
echo ""

# Check for duplicates
psql -h localhost -U paperclip -d paperclip -c \
  "SELECT 
    'Duplicate Vision agents found:' as info,
    COUNT(*) as duplicate_count
   FROM agents a
   JOIN companies c ON a.company_id = c.id
   WHERE c.name = 'Loopy AI' AND a.name = 'Vision';" 2>/dev/null || echo "Could not connect to database"

echo ""
echo "Step 2: Showing all Vision agents before cleanup..."
echo ""

# Show all Vision agents
psql -h localhost -U paperclip -d paperclip -c \
  "SELECT 
    a.id,
    a.name,
    a.role,
    a.title,
    a.created_at,
    CASE WHEN aak.id IS NOT NULL THEN 'Has API Key' ELSE 'No API Key' END as api_key_status,
    CASE WHEN am.id IS NOT NULL THEN 'Has Model' ELSE 'No Model' END as model_status
   FROM agents a
   JOIN companies c ON a.company_id = c.id
   LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
   LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
   WHERE c.name = 'Loopy AI' AND a.name = 'Vision'
   ORDER BY a.created_at DESC;" 2>/dev/null || echo "Could not connect to database"

echo ""
echo "Step 3: Running cleanup script..."
echo ""

# Run the cleanup SQL script
psql -h localhost -U paperclip -d paperclip -f cleanup_duplicate_vision_agents.sql 2>/dev/null || {
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
    'After cleanup - Vision agents:' as info,
    COUNT(*) as vision_count
   FROM agents a
   JOIN companies c ON a.company_id = c.id
   WHERE c.name = 'Loopy AI' AND a.name = 'Vision';" 2>/dev/null || echo "Could not connect to database"

psql -h localhost -U paperclip -d paperclip -c \
  "SELECT 
    a.id,
    a.name,
    a.role,
    a.title,
    a.created_at,
    CASE WHEN aak.id IS NOT NULL THEN '✓ Has API Key' ELSE '✗ Missing API Key' END as api_key_status,
    CASE WHEN am.id IS NOT NULL THEN '✓ Has Model' ELSE '✗ Missing Model' END as model_status
   FROM agents a
   JOIN companies c ON a.company_id = c.id
   LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
   LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
   WHERE c.name = 'Loopy AI' AND a.name = 'Vision';" 2>/dev/null || echo "Could not connect to database"

echo ""
echo "=================================="
echo "✅ Duplicate cleanup complete!"
echo "=================================="
echo ""
echo "Summary:"
echo "- Removed duplicate Vision agents (kept most recent)"
echo "- Cleaned up associated API keys and model assignments"
echo "- Should now have exactly 1 Vision agent"
echo ""
echo "If you're using Supabase instead of local PostgreSQL:"
echo "1. Go to Supabase SQL Editor"
echo "2. Run the file: scripts/database/cleanup_duplicate_vision_agents.sql"
echo ""
