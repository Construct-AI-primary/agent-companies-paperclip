-- Fix Agent Company Assignments
-- Generated SQL to correct agent assignments based on file system structure

-- ===========================================
-- FIX 1: Assign LearningForge AI agents to correct company
-- ===========================================
-- Learning Forge AI Company ID: 2bda2da6-dfa7-4709-b5d1-ea865f14072a
-- All agents with slugs starting with 'learningforge-ai-' should be assigned to this company

UPDATE agents
SET company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
WHERE name IN (
    'learningforge-ai-assessment-mastery',
    'learningforge-ai-audit-by-path',
    'learningforge-ai-audit-explainability',
    'learningforge-ai-autoresearch-gap-analyzer',
    'learningforge-ai-autoresearch-literature-scanner',
    'learningforge-ai-autoresearch-skills-enhancer',
    'learningforge-ai-ceo',
    'learningforge-ai-compliance-guard',
    'learningforge-ai-construction-law-research',
    'learningforge-ai-contracts-agent',
    'learningforge-ai-curriculum-planner',
    'learningforge-ai-defect-pattern-research',
    'learningforge-ai-doc-gap-detector',
    'learningforge-ai-doc-usage-analyzer',
    'learningforge-ai-electrical-engineering-agent',
    'learningforge-ai-equipment-innovation-research',
    'learningforge-ai-equipment-inspection',
    'learningforge-ai-feedback-synthesis',
    'learningforge-ai-field-safety-inspector',
    'learningforge-ai-from-doc-to-lesson-generator',
    'learningforge-ai-goal-alignment-budget',
    'learningforge-ai-hazard-pattern-analyst',
    'learningforge-ai-hermes-research',
    'learningforge-ai-interaction-pattern-coach',
    'learningforge-ai-knowledge-flow-agent',
    'learningforge-ai-knowledge-flow-division-lead',
    'learningforge-ai-knowledge-hygiene',
    'learningforge-ai-knowledge-provenance',
    'learningforge-ai-knowledge-transparency',
    'learningforge-ai-langchain-runner',
    'learningforge-ai-learning-division-lead',
    'learningforge-ai-logistics-agent',
    'learningforge-ai-material-defect-tracker',
    'learningforge-ai-micro-lesson-generator',
    'learningforge-ai-priority-disciplines-lead',
    'learningforge-ai-procurement-agent',
    'learningforge-ai-quality-learning',
    'learningforge-ai-research-compliance-division-lead',
    'learningforge-ai-research-scheduler',
    'learningforge-ai-safety-quality-division-lead',
    'learningforge-ai-safety-regulation-research',
    'learningforge-ai-safety-training-compliance',
    'learningforge-ai-safety-workflow-agent',
    'learningforge-ai-user-behavior-analyst',
    'learningforge-ai-vfs-markdown-tracker',
    'learningforge-ai-vfs-watcher',
    'learningforge-ai-workflow-coach'
);

-- ===========================================
-- FIX 2: Move misplaced Loopy AI agents to correct company
-- ===========================================
-- Loopy AI Company ID: 0a40625e-78f9-4b0a-82e4-169a8befa021
-- These agents are currently in PaperclipForge AI but should be in Loopy AI

UPDATE agents
SET company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021'
WHERE name IN (
    'maya-loopy-content-strategist',
    'vision-loopy-ceo'
);

-- ===========================================
-- FIX 3: Update API keys to match corrected company assignments
-- ===========================================
-- Update agent_api_keys table to reflect the corrected company assignments

UPDATE agent_api_keys
SET company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
WHERE agent_id IN (
    SELECT id FROM agents WHERE name LIKE 'learningforge-ai-%'
);

UPDATE agent_api_keys
SET company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021'
WHERE agent_id IN (
    SELECT id FROM agents WHERE name IN ('maya-loopy-content-strategist', 'vision-loopy-ceo')
);

-- ===========================================
-- VERIFICATION QUERIES
-- ===========================================
-- Run these after applying the fixes to verify correctness

-- Check Learning Forge AI agent count:
/*
SELECT COUNT(*) as learningforge_agent_count
FROM agents
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a';
*/

-- Check Loopy AI agent count:
/*
SELECT COUNT(*) as loopy_agent_count
FROM agents
WHERE company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021';
*/

-- Check for any remaining misplaced agents:
/*
SELECT a.name, a.company_id, c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.name LIKE '%loopy%' AND c.name != 'Loopy AI';
*/

-- ===========================================
-- BACKUP RECOMMENDATION
-- ===========================================
-- Before running this script, create a backup:
/*
pg_dump "postgres://paperclip:paperclip@localhost:5432/paperclip" > paperclip_backup_before_agent_fix.sql
*/

-- Or for Supabase:
/*
-- Use Supabase dashboard to create a backup before applying changes
*/