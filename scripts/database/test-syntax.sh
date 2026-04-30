#!/bin/bash

echo "Testing SQL script syntax..."
echo "============================"
echo ""

# Test 1: create-learningforge-company.sql
echo "1. Testing create-learningforge-company.sql..."
if psql -d postgres://paperclip:paperclip@localhost:5432/paperclip --echo-all -f scripts/database/create-learningforge-company.sql 2>&1 | grep -q "ERROR"; then
    echo "❌ Syntax error in create-learningforge-company.sql"
    psql -d postgres://paperclip:paperclip@localhost:5432/paperclip --echo-all -f scripts/database/create-learningforge-company.sql 2>&1 | grep -A5 -B5 "ERROR"
else
    echo "✅ create-learningforge-company.sql syntax OK"
fi

echo ""
echo "2. Testing populate-learningforge-agents.sql..."
if psql -d postgres://paperclip:paperclip@localhost:5432/paperclip --echo-all -f scripts/database/populate-learningforge-agents.sql 2>&1 | grep -q "ERROR"; then
    echo "❌ Syntax error in populate-learningforge-agents.sql"
    psql -d postgres://paperclip:paperclip@localhost:5432/paperclip --echo-all -f scripts/database/populate-learningforge-agents.sql 2>&1 | grep -A5 -B5 "ERROR"
else
    echo "✅ populate-learningforge-agents.sql syntax OK"
fi

echo ""
echo "3. Testing add-safety-research-agent-models.sql..."
if psql -d postgres://paperclip:paperclip@localhost:5432/paperclip --echo-all -f add-safety-research-agent-models.sql 2>&1 | grep -q "ERROR"; then
    echo "❌ Syntax error in add-safety-research-agent-models.sql"
    psql -d postgres://paperclip:paperclip@localhost:5432/paperclip --echo-all -f add-safety-research-agent-models.sql 2>&1 | grep -A5 -B5 "ERROR"
else
    echo "✅ add-safety-research-agent-models.sql syntax OK"
fi

echo ""
echo "4. Summary of files:"
echo "   - create-learningforge-company.sql: Creates/updates company and CEO"
echo "   - populate-learningforge-agents.sql: Creates Safety Research Team agents"
echo "   - add-safety-research-agent-models.sql: Assigns GLM models to research agents"
echo ""
echo "To run full setup: ./scripts/database/setup-learningforge-safety-research.sh"
echo ""
echo "Note: If database is not running, these tests will fail with connection errors."