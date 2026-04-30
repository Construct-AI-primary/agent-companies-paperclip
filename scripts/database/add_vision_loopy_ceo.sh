#!/bin/bash
# Add Vision Loopy CEO agent to Paperclip database
# Generated: 2026-04-13

echo "=================================="
echo "Adding Vision Loopy CEO to Loopy AI"
echo "=================================="
echo ""

# Check if .env file exists
if [ ! -f .env ]; then
    echo "⚠️  No .env file found. Using example configuration..."
    echo ""
fi

echo "Step 1: Verifying Loopy AI company exists..."
echo ""

# Check if Loopy AI company exists
psql -h localhost -U paperclip -d paperclip -c \
  "SELECT id, name, issue_prefix, status 
   FROM companies 
   WHERE name = 'Loopy AI';" 2>/dev/null || echo "Could not connect to database - may need to start Paperclip dev server first"

echo ""
echo "Step 2: Checking current Loopy AI agents..."
echo ""

# Check current agents
psql -h localhost -U paperclip -d paperclip -c \
  "SELECT a.name as agent_name, a.role, a.title, 
    COALESCE(boss.name, 'Board') as reports_to, a.status
   FROM agents a
   JOIN companies c ON a.company_id = c.id
   LEFT JOIN agents boss ON a.reports_to = boss.id
   WHERE c.name = 'Loopy AI' AND a.is_active = true
   ORDER BY a.created_at;" 2>/dev/null || echo "Could not connect to database"

echo ""
echo "Step 3: Adding Vision Loopy CEO..."
echo ""

# Run the SQL script
psql -h localhost -U paperclip -d paperclip -f add_vision_loopy_ceo.sql 2>/dev/null || {
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
  "SELECT a.name as agent_name, a.role, a.title,
    COALESCE(boss.name, 'Board') as reports_to,
    CASE WHEN aak.id IS NULL THEN '✗ Missing API Key' ELSE '✓ Has API Key' END as api_key_status,
    CASE WHEN am.id IS NULL THEN '✗ Missing Model' ELSE '✓ Has Model' END as model_status
   FROM agents a
   JOIN companies c ON a.company_id = c.id
   LEFT JOIN agents boss ON a.reports_to = boss.id
   LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
   LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
   WHERE c.name = 'Loopy AI' AND a.is_active = true
   ORDER BY CASE WHEN a.role = 'ceo' THEN 1 ELSE 2 END, a.created_at;"

echo ""
echo "=================================="
echo "✅ Vision Loopy CEO setup complete!"
echo "=================================="
echo ""
echo "Summary of changes:"
echo "- Added Vision as CEO of Loopy AI"
echo "- Updated all existing agents to report to Vision"
echo "- Added API key for Vision"
echo "- Added model assignment for Vision"
echo ""
echo "If you're using Supabase instead of local PostgreSQL:"
echo "1. Go to Supabase SQL Editor"
echo "2. Run the file: scripts/database/add_vision_loopy_ceo.sql"
echo ""
