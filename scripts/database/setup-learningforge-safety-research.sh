#!/bin/bash

echo "Setting up Learning Forge AI Safety Research Team..."
echo "==================================================="
echo ""

# Check if psql is available
if ! command -v psql &> /dev/null; then
    echo "ERROR: PostgreSQL client (psql) is not available."
    echo "Please install PostgreSQL client tools and ensure database is running."
    exit 1
fi

# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
    echo "ERROR: DATABASE_URL environment variable is not set."
    echo "Please set DATABASE_URL to your database connection string."
    exit 1
fi

# Check database connection
echo "Testing database connection..."
if ! psql "$DATABASE_URL" -c "SELECT 1" &> /dev/null; then
    echo "ERROR: Cannot connect to database."
    echo "Please check your DATABASE_URL environment variable."
    exit 1
fi

echo "Database connection successful."
echo ""

# Execute scripts in order
echo "1. Ensuring Learning Forge AI company exists..."
psql "$DATABASE_URL" -f scripts/database/create-learningforge-company.sql

echo ""
echo "2. Adding Safety Research Team agents (only new agents)..."
psql "$DATABASE_URL" -f scripts/database/add-safety-research-team-only.sql

echo ""
echo "3. Assigning models to Safety Research Team agents..."
psql "$DATABASE_URL" -f add-safety-research-agent-models.sql

echo ""
echo "4. Verifying setup..."
echo "===================="

# Run verification queries
echo "Company verification:"
psql "$DATABASE_URL" -c "SELECT id, name, issue_prefix, status, brand_color FROM companies WHERE name = 'Learning Forge AI';"

echo ""
echo "Agent count by team:"
psql "$DATABASE_URL" -c "
SELECT
    COALESCE(a.metadata->>'team', 'no-team') as team,
    COUNT(*) as agent_count,
    STRING_AGG(a.name, ', ') as agents
FROM agents a
WHERE a.company_id = (SELECT id FROM companies WHERE name = 'Learning Forge AI')
GROUP BY COALESCE(a.metadata->>'team', 'no-team')
ORDER BY agent_count DESC;"

echo ""
echo "Safety Research Team details:"
psql "$DATABASE_URL" -c "
SELECT
    a.name,
    a.title,
    boss.name as reports_to,
    a.metadata->>'specialization' as specialization,
    am.model_id,
    am.assignment_type
FROM agents a
LEFT JOIN agents boss ON a.reports_to = boss.id
LEFT JOIN agent_models am ON a.name = am.agent_id
WHERE a.company_id = (SELECT id FROM companies WHERE name = 'Learning Forge AI')
  AND a.metadata->>'team' = 'safety-research'
ORDER BY a.name;"

echo ""
echo "Setup complete! Learning Forge AI Safety Research Team is ready."
echo ""
echo "Summary:"
echo "- Company: Learning Forge AI (LFA prefix)"
echo "- CEO: learningforge-ai-ceo with GLM-5.1 model"
echo "- Safety Research Team: 5 agents with Z.ai: GLM 5 Turbo models"
echo "- Research Coordinator: learningforge-ai-research-coordinator"
echo "- Total agents created: 7 (CEO + Research Coordinator + 5 research agents)"