#!/bin/bash
# Insert API key for Loopy AI Observer agent
# Generated: 2026-04-12

echo "=================================="
echo "Loopy AI Observer - API Key Setup"
echo "=================================="
echo ""

# Check if .env file exists
if [ ! -f .env ]; then
    echo "⚠️  No .env file found. Using example configuration..."
    echo ""
fi

echo "Step 1: Verifying Observer agent exists..."
echo ""

# Execute verification query
PGPASSWORD=paperclip psql -h localhost -U paperclip -d paperclip -c \
  "SELECT a.id as agent_id, a.name as agent_name, c.id as company_id, c.name as company_name 
   FROM agents a 
   JOIN companies c ON a.company_id = c.id 
   WHERE a.name = 'Observer' AND c.name = 'Loopy AI' AND a.is_active = true;"

echo ""
echo "Step 2: Checking current API key status..."
echo ""

# Check existing API key
PGPASSWORD=paperclip psql -h localhost -U paperclip -d paperclip -c \
  "SELECT c.name as company, a.name as agent_name, 
   CASE WHEN aak.id IS NULL THEN '✗ Missing API Key' ELSE '✓ Has API Key' END as status 
   FROM agents a 
   JOIN companies c ON a.company_id = c.id 
   LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id 
   WHERE a.name = 'Observer' AND c.name = 'Loopy AI';"

echo ""
echo "Step 3: Inserting API key..."
echo ""

# Insert API key
PGPASSWORD=paperclip psql -h localhost -U paperclip -d paperclip -c \
  "INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash, created_at) 
   VALUES (
     gen_random_uuid(),
     (SELECT id FROM agents WHERE name = 'Observer' AND company_id = (SELECT id FROM companies WHERE name = 'Loopy AI') LIMIT 1),
     (SELECT id FROM companies WHERE name = 'Loopy AI' LIMIT 1),
     'Primary Key',
     encode(sha256(random()::text::bytea), 'hex'),
     NOW()
   )
   ON CONFLICT DO NOTHING
   RETURNING id, name, created_at;"

echo ""
echo "Step 4: Final verification - All Loopy AI agents:"
echo ""

# Final verification
PGPASSWORD=paperclip psql -h localhost -U paperclip -d paperclip -c \
  "SELECT c.name as company, a.name as agent_name, a.is_active,
   CASE WHEN aak.id IS NULL THEN '✗ Missing API Key' ELSE '✓ Has API Key' END as status,
   aak.created_at as api_key_created
   FROM agents a
   JOIN companies c ON a.company_id = c.id
   LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
   WHERE c.name = 'Loopy AI' AND a.is_active = true
   ORDER BY a.name;"

echo ""
echo "=================================="
echo "✅ Done!"
echo "=================================="
echo ""
echo "If you're using Supabase instead of local PostgreSQL:"
echo "1. Go to Supabase SQL Editor"
echo "2. Run the SQL file: scripts/database/insert_loopy_observer_api_key.sql"
echo ""
