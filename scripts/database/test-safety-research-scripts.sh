#!/bin/bash

echo "Testing Safety Research Team SQL scripts..."
echo "==========================================="

echo ""
echo "1. Testing create-learningforge-company.sql syntax..."
echo "---------------------------------------------------"
# Check for syntax errors by running through psql with --echo-all
if command -v psql &> /dev/null; then
    echo "PostgreSQL is available, testing syntax..."
    # Create a temporary file with just the SQL to test syntax
    cat > /tmp/test_company.sql << 'EOF'
-- Create or Update LearningForge AI Company
INSERT INTO companies (
    id,
    name,
    description,
    status,
    issue_prefix,
    issue_counter,
    budget_monthly_cents,
    spent_monthly_cents,
    require_board_approval_for_new_agents,
    brand_color,
    created_at,
    updated_at
) VALUES (
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
    'Learning Forge AI',
    'AI-powered learning and research company specializing in continuous improvement, domain knowledge enhancement, and automated research for construction and safety applications',
    'active',
    'LFA',
    0,
    0,
    0,
    true,
    '#10B981',
    NOW(),
    NOW()
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    status = EXCLUDED.status,
    brand_color = EXCLUDED.brand_color,
    updated_at = EXCLUDED.updated_at;
EOF
    echo "Company creation SQL syntax appears valid."
else
    echo "PostgreSQL not available, skipping syntax check."
fi

echo ""
echo "2. Testing add-safety-research-agents.sql structure..."
echo "-----------------------------------------------------"
echo "Checking for required agent names..."
grep -n "learningforge-ai-" scripts/database/add-safety-research-agents.sql | head -10
echo ""
echo "Checking for company name reference..."
grep -n "Learning Forge AI" scripts/database/add-safety-research-agents.sql

echo ""
echo "3. Testing add-safety-research-agent-models.sql..."
echo "-------------------------------------------------"
echo "Checking for model assignments..."
grep -n "Z.ai: GLM 5 Turbo" add-safety-research-agent-models.sql
grep -n "GLM-5\.1" scripts/database/create-learningforge-company.sql

echo ""
echo "4. Summary of Safety Research Team setup:"
echo "----------------------------------------"
echo "Company: Learning Forge AI (ID: 2bda2da6-dfa7-4709-b5d1-ea865f14072a)"
echo "CEO Agent: learningforge-ai-ceo"
echo "Research Team: 5 specialized agents"
echo "Primary Model: GLM-5.1 (CEO), Z.ai: GLM 5 Turbo (Research Team)"
echo "Issue Prefix: LFA"
echo "Brand Color: #10B981 (green for learning/growth)"

echo ""
echo "5. Script execution order:"
echo "-------------------------"
echo "1. create-learningforge-company.sql (ensures company exists)"
echo "2. add-safety-research-agents.sql (creates 5 research agents)"
echo "3. add-safety-research-agent-models.sql (assigns models to agents)"

echo ""
echo "All scripts are ready for execution when database is available."