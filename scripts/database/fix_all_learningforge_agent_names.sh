#!/bin/bash
# Complete Learning Forge AI agent name mapping
# Converts all slugs to actual database names based on insert_learningforge_agents.sql

FILE="scripts/database/insert_missing_api_keys.sql"

echo "Fixing Learning Forge AI agent names in $FILE..."

# CEO
sed -i '' "s/name = 'learningforge-ai-ceo'/name = 'Learning Strategy Agent'/g" "$FILE"

# Learning & Curriculum Division (7 agents)
sed -i '' "s/name = 'learningforge-ai-learning-division-lead'/name = 'Learning Division Lead'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-user-behavior-analyst'/name = 'User Behavior Analyst'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-interaction-pattern-coach'/name = 'Interaction Pattern Coach'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-feedback-synthesis'/name = 'Feedback Synthesis Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-curriculum-planner'/name = 'Curriculum Planner'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-micro-lesson-generator'/name = 'Micro-Lesson Generator'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-assessment-mastery'/name = 'Assessment Mastery Agent'/g" "$FILE"

# Safety & Quality Division (7 agents)
sed -i '' "s/name = 'learningforge-ai-safety-quality-division-lead'/name = 'Safety Quality Division Lead'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-field-safety-inspector'/name = 'Field Safety Inspector'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-hazard-pattern-analyst'/name = 'Hazard Pattern Analyst'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-safety-training-compliance'/name = 'Safety Training Compliance'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-equipment-inspection'/name = 'Equipment Inspection Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-material-defect-tracker'/name = 'Material Defect Tracker'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-quality-learning'/name = 'Quality Learning Agent'/g" "$FILE"

# Knowledge-Flow & Docs Division (10 agents)
sed -i '' "s/name = 'learningforge-ai-knowledge-flow-division-lead'/name = 'Knowledge Flow Division Lead'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-vfs-markdown-tracker'/name = 'VFS Markdown Tracker'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-knowledge-provenance'/name = 'Knowledge Provenance Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-doc-usage-analyzer'/name = 'Doc Usage Analyzer'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-from-doc-to-lesson-generator'/name = 'From Doc to Lesson Generator'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-doc-gap-detector'/name = 'Doc Gap Detector'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-workflow-coach'/name = 'Workflow Coach Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-knowledge-transparency'/name = 'Knowledge Transparency Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-knowledge-hygiene'/name = 'Knowledge Hygiene Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-audit-by-path'/name = 'Audit By Path Agent'/g" "$FILE"

# Research & Compliance Division (15 agents)
sed -i '' "s/name = 'learningforge-ai-research-compliance-division-lead'/name = 'Research Compliance Division Lead'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-hermes-research'/name = 'Hermes Research Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-construction-law-research'/name = 'Construction Law Research Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-safety-regulation-research'/name = 'Safety Regulation Research Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-equipment-innovation-research'/name = 'Equipment Innovation Research Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-defect-pattern-research'/name = 'Defect Pattern Research Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-autoresearch-skills-enhancer'/name = 'AutoResearch Skills Enhancer'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-autoresearch-literature-scanner'/name = 'AutoResearch Literature Scanner'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-autoresearch-gap-analyzer'/name = 'AutoResearch Gap Analyzer'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-goal-alignment-budget'/name = 'Goal Alignment Budget Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-audit-explainability'/name = 'Audit Explainability Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-compliance-guard'/name = 'Compliance Guard Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-research-scheduler'/name = 'Research Scheduler Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-vfs-watcher'/name = 'VFS Watcher Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-knowledge-flow-agent'/name = 'Knowledge Flow Agent'/g" "$FILE"

# Priority Disciplines Division (6 agents)
sed -i '' "s/name = 'learningforge-ai-priority-disciplines-lead'/name = 'Priority Disciplines Lead'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-contracts-agent'/name = 'Contracts Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-procurement-agent'/name = 'Procurement Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-logistics-agent'/name = 'Logistics Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-safety-workflow-agent'/name = 'Safety Workflow Agent'/g" "$FILE"
sed -i '' "s/name = 'learningforge-ai-electrical-engineering-agent'/name = 'Electrical Engineering Agent'/g" "$FILE"

# PromptForge AI agent names (remove suffix from slugs) - already mostly correct but need to capitalize
sed -i '' "s/name = 'analyzer-promptforge-prompt-analytics'/name = 'Analyzer'/g" "$FILE"
sed -i '' "s/name = 'archivist-promptforge-knowledge-management'/name = 'Archivist'/g" "$FILE"
sed -i '' "s/name = 'blueprint-promptforge-template-designer'/name = 'Blueprint'/g" "$FILE"
sed -i '' "s/name = 'cascade-promptforge-workflow-designer'/name = 'Cascade'/g" "$FILE"
sed -i '' "s/name = 'clarity-promptforge-performance-optimization'/name = 'Clarity'/g" "$FILE"
sed -i '' "s/name = 'collaborator-promptforge-cross-company-knowledge-sharing'/name = 'Collaborator'/g" "$FILE"
sed -i '' "s/name = 'compliance-promptforge-regulatory-compliance'/name = 'Compliance'/g" "$FILE"
sed -i '' "s/name = 'enhancer-promptforge-advanced-innovation'/name = 'Enhancer'/g" "$FILE"
sed -i '' "s/name = 'experimenter-promptforge-hypothesis-testing'/name = 'Experimenter'/g" "$FILE"
sed -i '' "s/name = 'explorer-promptforge-new-techniques'/name = 'Explorer'/g" "$FILE"
sed -i '' "s/name = 'flowdesigner-promptforge-agent-handoff'/name = 'FlowDesigner'/g" "$FILE"
sed -i '' "s/name = 'harmonic-promptforge-orchestration-strategy'/name = 'Harmonic'/g" "$FILE"
sed -i '' "s/name = 'integration-promptforge-cross-agent-compatibility'/name = 'Integration'/g" "$FILE"
sed -i '' "s/name = 'integrity-promptforge-ethical-ai'/name = 'Integrity'/g" "$FILE"
sed -i '' "s/name = 'predictor-promptforge-outcome-prediction'/name = 'Predictor'/g" "$FILE"
sed -i '' "s/name = 'quantifier-promptforge-benchmarking'/name = 'Quantifier'/g" "$FILE"
sed -i '' "s/name = 'refiner-promptforge-version-control'/name = 'Refiner'/g" "$FILE"
sed -i '' "s/name = 'sage-promptforge-chief-architect'/name = 'Sage'/g" "$FILE"
sed -i '' "s/name = 'scholar-promptforge-academic-research'/name = 'Scholar'/g" "$FILE"
sed -i '' "s/name = 'specialist-promptforge-domain-adaptation'/name = 'Specialist'/g" "$FILE"
sed -i '' "s/name = 'statemaster-promptforge-state-management'/name = 'StateMaster'/g" "$FILE"
sed -i '' "s/name = 'tuner-promptforge-ab-testing'/name = 'Tuner'/g" "$FILE"
sed -i '' "s/name = 'validator-promptforge-syntax-logic-validation'/name = 'Validator'/g" "$FILE"

# Loopy AI agent names (based on query results)
sed -i '' "s/name = 'maya-loopy-content-strategist'/name = 'Maya'/g" "$FILE"
sed -i '' "s/name = 'vision-loopy-ceo'/name = 'Observer'/g" "$FILE"

echo "✅ All agent names fixed!"
echo "   - Learning Forge AI: 46 agents"
echo "   - PromptForge AI: 23 agents"
echo "   - Loopy AI: 2 agents"
echo ""
echo "Total mappings applied: 71 agent names"
