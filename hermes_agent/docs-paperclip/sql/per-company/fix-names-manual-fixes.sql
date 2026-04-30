-- ============================================================
-- MANUAL FIXES FOR REMAINING AGENTS
-- Agents that need special handling due to different file structures
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'End-to-End Testing Coordinator'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'e2e-qualityforge-end-to-end-testing'
  AND name IS DISTINCT FROM 'End-to-End Testing Coordinator';

UPDATE agents
SET name = 'Accessibility Testing'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'accessibility-qualityforge-accessibility-testing'
  AND name IS DISTINCT FROM 'Accessibility Testing';

UPDATE agents
SET name = 'AI Integration Testing'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'ai-integration-qualityforge-ai-integration-testing'
  AND name IS DISTINCT FROM 'AI Integration Testing';

UPDATE agents
SET name = 'Code Analyzer'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'analyzer-qualityforge-code-analyzer'
  AND name IS DISTINCT FROM 'Code Analyzer';

UPDATE agents
SET name = 'System Architect'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'architect-qualityforge-system-architect'
  AND name IS DISTINCT FROM 'System Architect';

UPDATE agents
SET name = 'Quality Auditor'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'auditor-qualityforge-quality-auditor'
  AND name IS DISTINCT FROM 'Quality Auditor';

UPDATE agents
SET name = 'Authentication Testing'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'authentication-qualityforge-authentication-testing'
  AND name IS DISTINCT FROM 'Authentication Testing';

UPDATE agents
SET name = 'Test Automation'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'automation-qualityforge-test-automation'
  AND name IS DISTINCT FROM 'Test Automation';

UPDATE agents
SET name = 'Code Architect'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'codesmith-qualityforge-code-architect'
  AND name IS DISTINCT FROM 'Code Architect';

UPDATE agents
SET name = 'Compatibility Testing'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'compatibility-qualityforge-compatibility-testing'
  AND name IS DISTINCT FROM 'Compatibility Testing';

UPDATE agents
SET name = 'Test Coverage Analyst'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'coverage-qualityforge-test-coverage-analyst'
  AND name IS DISTINCT FROM 'Test Coverage Analyst';

UPDATE agents
SET name = 'Database Integration Testing'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'database-integration-testing-qualityforge'
  AND name IS DISTINCT FROM 'Database Integration Testing';

UPDATE agents
SET name = 'Database Testing'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'database-qualityforge-database-testing'
  AND name IS DISTINCT FROM 'Database Testing';

UPDATE agents
SET name = 'Debugger Specialist'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'debugger-qualityforge-debugger-specialist'
  AND name IS DISTINCT FROM 'Debugger Specialist';

UPDATE agents
SET name = 'Diagnostics Specialist'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'diagnostics-qualityforge-diagnostics-specialist'
  AND name IS DISTINCT FROM 'Diagnostics Specialist';

UPDATE agents
SET name = 'Documentation Specialist'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'documenter-qualityforge-documentation-specialist'
  AND name IS DISTINCT FROM 'Documentation Specialist';

UPDATE agents
SET name = 'Bug Fixing Specialist'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'fixer-qualityforge-bug-fixing-specialist'
  AND name IS DISTINCT FROM 'Bug Fixing Specialist';

UPDATE agents
SET name = 'Quality Director'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'governor-qualityforge-quality-director'
  AND name IS DISTINCT FROM 'Quality Director';

UPDATE agents
SET name = 'Quality Guardian'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'guardian-qualityforge-quality-guardian'
  AND name IS DISTINCT FROM 'Quality Guardian';

UPDATE agents
SET name = 'Human-in-the-Loop Testing'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'hitl-qualityforge-human-in-the-loop-testing'
  AND name IS DISTINCT FROM 'Human-in-the-Loop Testing';

UPDATE agents
SET name = 'Code Inspector'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'inspector-qualityforge-code-inspector'
  AND name IS DISTINCT FROM 'Code Inspector';

UPDATE agents
SET name = 'Integration Testing'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'integration-qualityforge-integration-testing'
  AND name IS DISTINCT FROM 'Integration Testing';

UPDATE agents
SET name = 'Integration Specialist'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'integrator-qualityforge-integration-specialist'
  AND name IS DISTINCT FROM 'Integration Specialist';

UPDATE agents
SET name = 'Load Testing'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'load-qualityforge-load-testing'
  AND name IS DISTINCT FROM 'Load Testing';

UPDATE agents
SET name = 'Scalability Testing'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'loadtester-qualityforge-scalability-testing'
  AND name IS DISTINCT FROM 'Scalability Testing';

UPDATE agents
SET name = 'Code Maintainer'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'maintainer-qualityforge-code-maintainer'
  AND name IS DISTINCT FROM 'Code Maintainer';

UPDATE agents
SET name = 'Migration Specialist'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'migrator-qualityforge-migration-specialist'
  AND name IS DISTINCT FROM 'Migration Specialist';

UPDATE agents
SET name = 'Quality Monitor'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'monitor-qualityforge-quality-monitor'
  AND name IS DISTINCT FROM 'Quality Monitor';

UPDATE agents
SET name = 'Code Optimizer'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'optimizer-qualityforge-code-optimizer'
  AND name IS DISTINCT FROM 'Code Optimizer';

UPDATE agents
SET name = 'Performance Testing'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'performance-qualityforge-performance-testing'
  AND name IS DISTINCT FROM 'Performance Testing';

UPDATE agents
SET name = 'Prompt Testing'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'probe-qualityforge-prompt-testing'
  AND name IS DISTINCT FROM 'Prompt Testing';

UPDATE agents
SET name = 'Performance Profiler'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'profiler-qualityforge-performance-profiler'
  AND name IS DISTINCT FROM 'Performance Profiler';

UPDATE agents
SET name = 'Refactoring Specialist'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'refactor-qualityforge-refactoring-specialist'
  AND name IS DISTINCT FROM 'Refactoring Specialist';

UPDATE agents
SET name = 'Quality Reporter'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'reporter-qualityforge-quality-reporter'
  AND name IS DISTINCT FROM 'Quality Reporter';

UPDATE agents
SET name = 'Issue Resolver'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'resolver-qualityforge-issue-resolver'
  AND name IS DISTINCT FROM 'Issue Resolver';

UPDATE agents
SET name = 'Code Reviewer'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'reviewer-qualityforge-code-reviewer'
  AND name IS DISTINCT FROM 'Code Reviewer';

UPDATE agents
SET name = 'Workflow Simulation'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'simulator-qualityforge-workflow-simulation'
  AND name IS DISTINCT FROM 'Workflow Simulation';

UPDATE agents
SET name = 'Standards Enforcer'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'standards-qualityforge-standards-enforcer'
  AND name IS DISTINCT FROM 'Standards Enforcer';

UPDATE agents
SET name = 'Execution Tracer'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'tracer-qualityforge-execution-tracer'
  AND name IS DISTINCT FROM 'Execution Tracer';

UPDATE agents
SET name = 'Quality Trainer'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'trainer-qualityforge-quality-trainer'
  AND name IS DISTINCT FROM 'Quality Trainer';

UPDATE agents
SET name = 'User Management Testing'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'user-management-qualityforge-user-management-testing'
  AND name IS DISTINCT FROM 'User Management Testing';

UPDATE agents
SET name = 'Validator'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'validator-qualityforge-validator'
  AND name IS DISTINCT FROM 'Validator';

UPDATE agents
SET name = 'Administrator - pre-award'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'Administrator - pre-award'
  AND name IS DISTINCT FROM 'Administrator - pre-award';

UPDATE agents
SET name = 'Database CRUD Orchestrator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-databasecrudorchestrator'
  AND name IS DISTINCT FROM 'Database CRUD Orchestrator';

UPDATE agents
SET name = 'Atlas Agent Creator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-atlasagentcreator'
  AND name IS DISTINCT FROM 'Atlas Agent Creator';

UPDATE agents
SET name = 'Org Research Folder Creator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-orgresearchfoldercr'
  AND name IS DISTINCT FROM 'Org Research Folder Creator';

UPDATE agents
SET name = 'Quality Assurance'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'quality-assurance-domainforge-quality-assurance'
  AND name IS DISTINCT FROM 'Quality Assurance';

UPDATE agents
SET name = 'Geotechnical Engineering'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'geotechnical-domainforge-geotechnical-engineering'
  AND name IS DISTINCT FROM 'Geotechnical Engineering';

UPDATE agents
SET name = 'Structural Engineering'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'structural-domainforge-structural-engineering'
  AND name IS DISTINCT FROM 'Structural Engineering';

UPDATE agents
SET name = 'Error Pattern Monitor'
WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
  AND title = 'learningforge-ai-error-pattern-monitor'
  AND name IS DISTINCT FROM 'Error Pattern Monitor';

UPDATE agents
SET name = 'Autocad Integration Specialist'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440013'
  AND title = 'autocad-integration-specialist'
  AND name IS DISTINCT FROM 'Autocad Integration Specialist';

COMMIT;
