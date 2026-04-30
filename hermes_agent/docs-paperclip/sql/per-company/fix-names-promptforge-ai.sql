-- ============================================================
-- FIX NAMES FOR: promptforge-ai
-- Company ID: f02b83a8-e0db-4332-b507-22f85e71ebf5
-- Agents: 24
-- Uses UPDATE to fix name field on existing agents
-- Uses human_name field when available, otherwise name
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'Discipline Automation'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'promptforge-ai-disciplineautomation'
  AND name IS DISTINCT FROM 'Discipline Automation';

UPDATE agents
SET name = 'Analyzer'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'analyzer-promptforge-prompt-analytics'
  AND name IS DISTINCT FROM 'Analyzer';

UPDATE agents
SET name = 'Archivist'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'archivist-promptforge-knowledge-management'
  AND name IS DISTINCT FROM 'Archivist';

UPDATE agents
SET name = 'Blueprint'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'blueprint-promptforge-template-designer'
  AND name IS DISTINCT FROM 'Blueprint';

UPDATE agents
SET name = 'Cascade'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'cascade-promptforge-workflow-designer'
  AND name IS DISTINCT FROM 'Cascade';

UPDATE agents
SET name = 'Clarity'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'clarity-promptforge-performance-optimization'
  AND name IS DISTINCT FROM 'Clarity';

UPDATE agents
SET name = 'Collaborator'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'collaborator-promptforge-cross-company-knowledge-sharing'
  AND name IS DISTINCT FROM 'Collaborator';

UPDATE agents
SET name = 'Compliance'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'compliance-promptforge-regulatory-compliance'
  AND name IS DISTINCT FROM 'Compliance';

UPDATE agents
SET name = 'Enhancer'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'enhancer-promptforge-advanced-innovation'
  AND name IS DISTINCT FROM 'Enhancer';

UPDATE agents
SET name = 'Experimenter'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'experimenter-promptforge-hypothesis-testing'
  AND name IS DISTINCT FROM 'Experimenter';

UPDATE agents
SET name = 'Explorer'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'explorer-promptforge-new-techniques'
  AND name IS DISTINCT FROM 'Explorer';

UPDATE agents
SET name = 'Flowdesigner'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'flowdesigner-promptforge-agent-handoff'
  AND name IS DISTINCT FROM 'Flowdesigner';

UPDATE agents
SET name = 'Harmonic'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'harmonic-promptforge-orchestration-strategy'
  AND name IS DISTINCT FROM 'Harmonic';

UPDATE agents
SET name = 'Integration'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'integration-promptforge-cross-agent-compatibility'
  AND name IS DISTINCT FROM 'Integration';

UPDATE agents
SET name = 'Integrity'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'integrity-promptforge-ethical-ai'
  AND name IS DISTINCT FROM 'Integrity';

UPDATE agents
SET name = 'Predictor'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'predictor-promptforge-outcome-prediction'
  AND name IS DISTINCT FROM 'Predictor';

UPDATE agents
SET name = 'Quantifier'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'quantifier-promptforge-benchmarking'
  AND name IS DISTINCT FROM 'Quantifier';

UPDATE agents
SET name = 'Refiner'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'refiner-promptforge-version-control'
  AND name IS DISTINCT FROM 'Refiner';

UPDATE agents
SET name = 'Sage'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'sage-promptforge-chief-architect'
  AND name IS DISTINCT FROM 'Sage';

UPDATE agents
SET name = 'Scholar'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'scholar-promptforge-academic-research'
  AND name IS DISTINCT FROM 'Scholar';

UPDATE agents
SET name = 'Specialist'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'specialist-promptforge-domain-adaptation'
  AND name IS DISTINCT FROM 'Specialist';

UPDATE agents
SET name = 'Statemaster'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'statemaster-promptforge-state-management'
  AND name IS DISTINCT FROM 'Statemaster';

UPDATE agents
SET name = 'Tuner'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'tuner-promptforge-ab-testing'
  AND name IS DISTINCT FROM 'Tuner';

UPDATE agents
SET name = 'Validator'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND title = 'validator-promptforge-syntax-logic-validation'
  AND name IS DISTINCT FROM 'Validator';

COMMIT;
