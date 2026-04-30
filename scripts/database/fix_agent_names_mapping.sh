#!/bin/bash
# Fix agent names in insert_missing_api_keys.sql
# Convert from slugs to actual agent names based on insert_learningforge_agents.sql

FILE="scripts/database/insert_missing_api_keys.sql"

# Learning Forge AI agent name mappings (based on insert_learningforge_agents.sql)
sed -i '' "s/name = 'learningforge-ai-assessment-mastery'/name = 'Assessment Mastery Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-user-behavior-analyst'/name = 'User Behavior Analyst'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-interaction-pattern-coach'/name = 'Interaction Pattern Coach'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-feedback-synthesis'/name = 'Feedback Synthesis Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-curriculum-planner'/name = 'Curriculum Planner'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-micro-lesson-generator'/name = 'Micro-Lesson Generator'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-field-safety-inspector'/name = 'Field Safety Inspector'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-hazard-pattern-analyst'/name = 'Hazard Pattern Analyst'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-safety-training-compliance'/name = 'Safety Training Compliance'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-equipment-inspection'/name = 'Equipment Inspection Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-material-defect-tracker'/name = 'Material Defect Tracker'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-quality-learning'/name = 'Quality Learning Agent'/g" "$FILE"

# Division Leads
sed -i '' "s/name = 'learningforge-ai-ceo'/name = 'Learning Strategy Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-learning-division-lead'/name = 'Learning Division Lead'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-safety-quality-division-lead'/name = 'Safety Quality Division Lead'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-knowledge-flow-division-lead'/name = 'Knowledge Flow Division Lead'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-research-compliance-division-lead'/name = 'Research Compliance Division Lead'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-priority-disciplines-lead'/name = 'Priority Disciplines Lead'/g" "$FILE"

echo "✅ Agent names updated in $FILE"
echo "Note: This script updates only the agents found in insert_learningforge_agents.sql"
echo "You may need to run get_learningforge_agent_names.sql to get the complete list"
