-- ============================================================================
-- MISSING API KEYS INSERT STATEMENTS
-- Generated: 2026-04-12
-- Companies: LearningForge AI (47), PromptForge AI (23), Loopy AI (2)
-- Total Missing: 72 API Keys
-- ============================================================================

-- NOTE: Company IDs are resolved dynamically via subqueries
-- Verify companies exist: SELECT id, name FROM companies WHERE name IN ('Learning Forge AI', 'PromptForge AI', 'Loopy AI');

-- ============================================================================
-- LEARNINGFORGE AI (47 Agents)
-- ============================================================================

-- Agent: learningforge-ai-assessment-mastery
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Assessment Mastery Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-audit-by-path
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Audit By Path Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-audit-explainability
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Audit Explainability Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-autoresearch-gap-analyzer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'AutoResearch Gap Analyzer' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-autoresearch-literature-scanner
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'AutoResearch Literature Scanner' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-autoresearch-skills-enhancer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'AutoResearch Skills Enhancer' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-ceo
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Learning Strategy Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-compliance-guard
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Compliance Guard Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-construction-law-research
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Construction Law Research Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-contracts-agent
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Contracts Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-curriculum-planner
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Curriculum Planner' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-defect-pattern-research
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Defect Pattern Research Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-doc-gap-detector
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Doc Gap Detector' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-doc-usage-analyzer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Doc Usage Analyzer' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-electrical-engineering-agent
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Electrical Engineering Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-equipment-innovation-research
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Equipment Innovation Research Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-equipment-inspection
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Equipment Inspection Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-feedback-synthesis
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Feedback Synthesis Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-field-safety-inspector
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Field Safety Inspector' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-from-doc-to-lesson-generator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'From Doc to Lesson Generator' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-goal-alignment-budget
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Goal Alignment Budget Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-hazard-pattern-analyst
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Hazard Pattern Analyst' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-hermes-research
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Hermes Research Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-interaction-pattern-coach
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Interaction Pattern Coach' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-knowledge-flow-agent
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Knowledge Flow Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-knowledge-flow-division-lead
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Knowledge Flow Division Lead' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-knowledge-hygiene
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Knowledge Hygiene Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-knowledge-provenance
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Knowledge Provenance Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-knowledge-transparency
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Knowledge Transparency Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-langchain-runner
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'learningforge-ai-langchain-runner' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-learning-division-lead
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Learning Division Lead' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-logistics-agent
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Logistics Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-material-defect-tracker
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Material Defect Tracker' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-micro-lesson-generator
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Micro-Lesson Generator' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-priority-disciplines-lead
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Priority Disciplines Lead' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-procurement-agent
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Procurement Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-quality-learning
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Quality Learning Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-research-compliance-division-lead
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Research Compliance Division Lead' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-research-scheduler
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Research Scheduler Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-safety-quality-division-lead
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Safety Quality Division Lead' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-safety-regulation-research
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Safety Regulation Research Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-safety-training-compliance
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Safety Training Compliance' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-safety-workflow-agent
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Safety Workflow Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-user-behavior-analyst
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'User Behavior Analyst' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-vfs-markdown-tracker
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'VFS Markdown Tracker' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-vfs-watcher
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'VFS Watcher Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: learningforge-ai-workflow-coach
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Workflow Coach Agent' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- ============================================================================
-- PROMPTFORGE AI (23 Agents)
-- ============================================================================

-- Agent: analyzer-promptforge-prompt-analytics
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Analyzer' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: archivist-promptforge-knowledge-management
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Archivist' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: blueprint-promptforge-template-designer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Blueprint' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: cascade-promptforge-workflow-designer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Cascade' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: clarity-promptforge-performance-optimization
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Clarity' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: collaborator-promptforge-cross-company-knowledge-sharing
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Collaborator' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: compliance-promptforge-regulatory-compliance
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Compliance' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: enhancer-promptforge-advanced-innovation
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Enhancer' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: experimenter-promptforge-hypothesis-testing
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Experimenter' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: explorer-promptforge-new-techniques
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Explorer' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: flowdesigner-promptforge-agent-handoff
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'FlowDesigner' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: harmonic-promptforge-orchestration-strategy
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Harmonic' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: integration-promptforge-cross-agent-compatibility
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Integration' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: integrity-promptforge-ethical-ai
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Integrity' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: predictor-promptforge-outcome-prediction
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Predictor' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: quantifier-promptforge-benchmarking
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Quantifier' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: refiner-promptforge-version-control
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Refiner' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: sage-promptforge-chief-architect
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Sage' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: scholar-promptforge-academic-research
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Scholar' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: specialist-promptforge-domain-adaptation
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Specialist' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: statemaster-promptforge-state-management
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'StateMaster' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: tuner-promptforge-ab-testing
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Tuner' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: validator-promptforge-syntax-logic-validation
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Validator' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- ============================================================================
-- LOOPY AI (2 Agents)
-- ============================================================================

-- Agent: maya-loopy-content-strategist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Maya' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Loopy AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: vision-loopy-ceo
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Observer' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Loopy AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- ============================================================================
-- VERIFICATION QUERY
-- ============================================================================
-- Run this to verify all keys were created:
-- SELECT c.name as company, COUNT(aak.id) as api_keys_count
-- FROM companies c
-- LEFT JOIN agents a ON c.id = a.company_id
-- LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
-- WHERE c.name IN ('Learning Forge AI', 'PromptForge AI', 'Loopy AI')
-- GROUP BY c.name;
