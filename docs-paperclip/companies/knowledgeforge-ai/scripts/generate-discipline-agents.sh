#!/bin/bash
# Generate SQL INSERT statements for all discipline and non-discipline specialist agents
# Usage: ./generate-discipline-agents.sh > discipline-agents.sql

echo "-- Discipline and Non-Discipline Specialist Agents for KnowledgeForge"
echo "-- Generated on $(date)"
echo "-- Run AFTER the core 12 agents are created"
echo ""
echo "DO \$\$"
echo "DECLARE"
echo "  v_company_id UUID;"
echo "  v_discipline_strategist UUID;"
echo "  v_sector_analyst UUID;"
echo "BEGIN"
echo "  SELECT id INTO v_company_id FROM companies WHERE name = 'KnowledgeForge AI' LIMIT 1;"
echo "  SELECT id INTO v_discipline_strategist FROM agents WHERE company_id = v_company_id AND name = 'KnowledgeForge Discipline Strategist' LIMIT 1;"
echo "  SELECT id INTO v_sector_analyst FROM agents WHERE company_id = v_company_id AND name = 'KnowledgeForge Sector Analyst' LIMIT 1;"
echo ""

# Discipline agents (50)
for dir in docs-construct-ai/disciplines/*/; do
  code=$(basename "$dir")
  if [ "$code" = "CROSS-DISCIPLINE.md" ]; then continue; fi
  
  # Convert directory name to agent name
  name=$(echo "$code" | sed 's/^[0-9]*_//' | sed 's/-/ /g' | sed 's/_/ /g')
  role=$(echo "$code" | sed 's/^[0-9]*_//' | sed 's/-/-/g' | sed 's/_/-/g')
  
  echo "  INSERT INTO agents (company_id, name, role, adapter_type, reports_to, created_at, updated_at)"
  echo "  VALUES (v_company_id, 'KF $name', '$role', 'hermes_local', v_discipline_strategist, now(), now())"
  echo "  ON CONFLICT DO NOTHING;"
done

echo ""

# Non-discipline agents (36)
for dir in docs-construct-ai/disciplines-non/*/; do
  code=$(basename "$dir")
  
  # Convert directory name to agent name
  name=$(echo "$code" | sed 's/^[0-9]*_//' | sed 's/^[0-9]*-//' | sed 's/-/ /g' | sed 's/_/ /g')
  role=$(echo "$code" | sed 's/^[0-9]*_//' | sed 's/^[0-9]*-//' | sed 's/-/-/g' | sed 's/_/-/g')
  
  echo "  INSERT INTO agents (company_id, name, role, adapter_type, reports_to, created_at, updated_at)"
  echo "  VALUES (v_company_id, 'KF $name', '$role', 'hermes_local', v_sector_analyst, now(), now())"
  echo "  ON CONFLICT DO NOTHING;"
done

echo ""
echo "  RAISE NOTICE 'Added 86 specialist agents to KnowledgeForge';"
echo "END"
echo "\$\$;"