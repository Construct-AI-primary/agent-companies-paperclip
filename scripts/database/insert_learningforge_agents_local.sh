#!/bin/bash
# Insert Learning Forge AI agents into LOCAL PostgreSQL database
# Company ID: 2bda2da6-dfa7-4709-b5d1-ea865f14072a

echo "Inserting Learning Forge AI agents into local database..."
echo "Company ID: 2bda2da6-dfa7-4709-b5d1-ea865f14072a"
echo ""

# Remove the company creation part from the SQL file and execute only agent inserts
# Skip first 40 lines which contain company creation
tail -n +42 scripts/database/insert_learningforge_agents.sql | \
  PGPASSWORD=paperclip psql -h localhost -U paperclip -d paperclip

echo ""
echo "Verifying agent count..."
PGPASSWORD=paperclip psql -h localhost -U paperclip -d paperclip -c \
  "SELECT COUNT(*) as agent_count FROM agents WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a';"

echo ""
echo "✅ Done! Run the verification script to confirm:"
echo "BOARD_TOKEN=your_token node scripts/database/verify_learningforge_setup.js"
