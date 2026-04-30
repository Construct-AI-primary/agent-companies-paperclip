-- ============================================================
-- FIX NAMES FOR: learningforge-ai
-- Company ID: 2bda2da6-dfa7-4709-b5d1-ea865f14072a
-- Agents: 51
-- Uses UPDATE to fix name field on existing agents
-- Uses human_name field when available, otherwise name
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'Assessment Mastery'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-assessment-mastery'
  AND name IS DISTINCT FROM 'Assessment Mastery';

UPDATE agents
SET name = 'Audit By Path'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-audit-by-path'
  AND name IS DISTINCT FROM 'Audit By Path';

UPDATE agents
SET name = 'Audit Explainability'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-audit-explainability'
  AND name IS DISTINCT FROM 'Audit Explainability';

UPDATE agents
SET name = 'Autoresearch Gap Analy'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-autoresearch-gap-analyzer'
  AND name IS DISTINCT FROM 'Autoresearch Gap Analy';

UPDATE agents
SET name = 'Autoresearch Literatur'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-autoresearch-literature-scanner'
  AND name IS DISTINCT FROM 'Autoresearch Literatur';

UPDATE agents
SET name = 'Compliance Guard'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-compliance-guard'
  AND name IS DISTINCT FROM 'Compliance Guard';

UPDATE agents
SET name = 'Construction Law Resea'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-construction-law-research'
  AND name IS DISTINCT FROM 'Construction Law Resea';

UPDATE agents
SET name = 'Contracts Agent'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-contracts-agent'
  AND name IS DISTINCT FROM 'Contracts Agent';

UPDATE agents
SET name = 'Curriculum Planner'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-curriculum-planner'
  AND name IS DISTINCT FROM 'Curriculum Planner';

UPDATE agents
SET name = 'Defect Pattern Researc'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-defect-pattern-research'
  AND name IS DISTINCT FROM 'Defect Pattern Researc';

UPDATE agents
SET name = 'Doc Gap Detector'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-doc-gap-detector'
  AND name IS DISTINCT FROM 'Doc Gap Detector';

UPDATE agents
SET name = 'Doc Usage Analyzer'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-doc-usage-analyzer'
  AND name IS DISTINCT FROM 'Doc Usage Analyzer';

UPDATE agents
SET name = 'Electrical Engineering'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-electrical-engineering-agent'
  AND name IS DISTINCT FROM 'Electrical Engineering';

UPDATE agents
SET name = 'Equipment Innovation'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-equipment-innovation-research'
  AND name IS DISTINCT FROM 'Equipment Innovation';

UPDATE agents
SET name = 'Equipment Inspection'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-equipment-inspection'
  AND name IS DISTINCT FROM 'Equipment Inspection';

UPDATE agents
SET name = 'Error Pattern Monitor'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-error-pattern-monitor'
  AND name IS DISTINCT FROM 'Error Pattern Monitor';

UPDATE agents
SET name = 'Feedback Synthesis'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-feedback-synthesis'
  AND name IS DISTINCT FROM 'Feedback Synthesis';

UPDATE agents
SET name = 'Field Safety Inspector'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-field-safety-inspector'
  AND name IS DISTINCT FROM 'Field Safety Inspector';

UPDATE agents
SET name = 'From Doc To Lesson Gen'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-from-doc-to-lesson-generator'
  AND name IS DISTINCT FROM 'From Doc To Lesson Gen';

UPDATE agents
SET name = 'Goal Alignment Budget'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-goal-alignment-budget'
  AND name IS DISTINCT FROM 'Goal Alignment Budget';

UPDATE agents
SET name = 'Hazard Pattern Analyst'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-hazard-pattern-analyst'
  AND name IS DISTINCT FROM 'Hazard Pattern Analyst';

UPDATE agents
SET name = 'Hermes Research'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-hermes-research'
  AND name IS DISTINCT FROM 'Hermes Research';

UPDATE agents
SET name = 'Interaction Pattern Co'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-interaction-pattern-coach'
  AND name IS DISTINCT FROM 'Interaction Pattern Co';

UPDATE agents
SET name = 'Knowledge Flow Agent'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-knowledge-flow-agent'
  AND name IS DISTINCT FROM 'Knowledge Flow Agent';

UPDATE agents
SET name = 'Knowledge Flow Divisio'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-knowledge-flow-division-lead'
  AND name IS DISTINCT FROM 'Knowledge Flow Divisio';

UPDATE agents
SET name = 'Knowledge Hygiene'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-knowledge-hygiene'
  AND name IS DISTINCT FROM 'Knowledge Hygiene';

UPDATE agents
SET name = 'Knowledge Provenance'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-knowledge-provenance'
  AND name IS DISTINCT FROM 'Knowledge Provenance';

UPDATE agents
SET name = 'Knowledge Transparency'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-knowledge-transparency'
  AND name IS DISTINCT FROM 'Knowledge Transparency';

UPDATE agents
SET name = 'Langchain Runner'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-langchain-runner'
  AND name IS DISTINCT FROM 'Langchain Runner';

UPDATE agents
SET name = 'Learning Division Lead'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-learning-division-lead'
  AND name IS DISTINCT FROM 'Learning Division Lead';

UPDATE agents
SET name = 'Learning Integration'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-learningintegration'
  AND name IS DISTINCT FROM 'Learning Integration';

UPDATE agents
SET name = 'Literature Scanner'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-autoresearch-skills-enhancer'
  AND name IS DISTINCT FROM 'Literature Scanner';

UPDATE agents
SET name = 'Logistics Agent'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-logistics-agent'
  AND name IS DISTINCT FROM 'Logistics Agent';

UPDATE agents
SET name = 'Material Defect Tracke'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-material-defect-tracker'
  AND name IS DISTINCT FROM 'Material Defect Tracke';

UPDATE agents
SET name = 'Micro Lesson Generator'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-micro-lesson-generator'
  AND name IS DISTINCT FROM 'Micro Lesson Generator';

UPDATE agents
SET name = 'Mobile Patterns Agent'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-mobilepatternsagent'
  AND name IS DISTINCT FROM 'Mobile Patterns Agent';

UPDATE agents
SET name = 'Priority Disciplines L'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-priority-disciplines-lead'
  AND name IS DISTINCT FROM 'Priority Disciplines L';

UPDATE agents
SET name = 'Procurement Agent'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-procurement-agent'
  AND name IS DISTINCT FROM 'Procurement Agent';

UPDATE agents
SET name = 'Quality Learning'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-quality-learning'
  AND name IS DISTINCT FROM 'Quality Learning';

UPDATE agents
SET name = 'Research Compliance Di'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-research-compliance-division-lead'
  AND name IS DISTINCT FROM 'Research Compliance Di';

UPDATE agents
SET name = 'Research Scheduler'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-research-scheduler'
  AND name IS DISTINCT FROM 'Research Scheduler';

UPDATE agents
SET name = 'Safety Quality Divisio'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-safety-quality-division-lead'
  AND name IS DISTINCT FROM 'Safety Quality Divisio';

UPDATE agents
SET name = 'Safety Regulation Rese'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-safety-regulation-research'
  AND name IS DISTINCT FROM 'Safety Regulation Rese';

UPDATE agents
SET name = 'Safety Research Agent'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-safetyresearchagent'
  AND name IS DISTINCT FROM 'Safety Research Agent';

UPDATE agents
SET name = 'Safety Training Compli'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-safety-training-compliance'
  AND name IS DISTINCT FROM 'Safety Training Compli';

UPDATE agents
SET name = 'Safety Workflow Agent'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-safety-workflow-agent'
  AND name IS DISTINCT FROM 'Safety Workflow Agent';

UPDATE agents
SET name = 'User Behavior Analyst'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-user-behavior-analyst'
  AND name IS DISTINCT FROM 'User Behavior Analyst';

UPDATE agents
SET name = 'Vfs Markdown Tracker'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-vfs-markdown-tracker'
  AND name IS DISTINCT FROM 'Vfs Markdown Tracker';

UPDATE agents
SET name = 'Vfs Watcher'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-vfs-watcher'
  AND name IS DISTINCT FROM 'Vfs Watcher';

UPDATE agents
SET name = 'Workflow Coach'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-workflow-coach'
  AND name IS DISTINCT FROM 'Workflow Coach';

UPDATE agents
SET name = 'Ceo'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-ceo'
  AND name IS DISTINCT FROM 'Ceo';

COMMIT;
