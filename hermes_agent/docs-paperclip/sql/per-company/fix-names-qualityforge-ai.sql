-- ============================================================
-- FIX NAMES FOR: qualityforge-ai
-- Company ID: f535f9bc-00be-4b6d-9f53-c53abfacacef
-- Agents: 41
-- Uses UPDATE to fix name field on existing agents
-- Uses human_name field when available, otherwise name
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'Apex'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'apex-qualityforge-ceo'
  AND name IS DISTINCT FROM 'Apex';

UPDATE agents
SET name = 'Architect'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'architect-qualityforge-system-architect'
  AND name IS DISTINCT FROM 'Architect';

UPDATE agents
SET name = 'Assessment Criteria'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'qualityforge-ai-assessmentcriteria'
  AND name IS DISTINCT FROM 'Assessment Criteria';

UPDATE agents
SET name = 'Auditor'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'auditor'
  AND name IS DISTINCT FROM 'Auditor';

UPDATE agents
SET name = 'Automation'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'automation-qualityforge-test-automation'
  AND name IS DISTINCT FROM 'Automation';

UPDATE agents
SET name = 'Code Analyzer'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'code-analyzer'
  AND name IS DISTINCT FROM 'Code Analyzer';

UPDATE agents
SET name = 'Code Reviewer'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'reviewer-qualityforge-code-reviewer'
  AND name IS DISTINCT FROM 'Code Reviewer';

UPDATE agents
SET name = 'Codesmith'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'codesmith-qualityforge-code-architect'
  AND name IS DISTINCT FROM 'Codesmith';

UPDATE agents
SET name = 'Compatibility'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'compatibility'
  AND name IS DISTINCT FROM 'Compatibility';

UPDATE agents
SET name = 'Compliance Validator'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'qualityforge-ai-compliancevalidator'
  AND name IS DISTINCT FROM 'Compliance Validator';

UPDATE agents
SET name = 'Coverage'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'coverage-qualityforge-test-coverage-analyst'
  AND name IS DISTINCT FROM 'Coverage';

UPDATE agents
SET name = 'Dbat Testing'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'dbat-testing-qualityforge'
  AND name IS DISTINCT FROM 'Dbat Testing';

UPDATE agents
SET name = 'Debugger'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'debugger-Debugger-specialist'
  AND name IS DISTINCT FROM 'Debugger';

UPDATE agents
SET name = 'Decision Support'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'qualityforge-ai-decisionsupport'
  AND name IS DISTINCT FROM 'Decision Support';

UPDATE agents
SET name = 'Diagnostics'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'diagnostics-Diagnostics-specialist'
  AND name IS DISTINCT FROM 'Diagnostics';

UPDATE agents
SET name = 'Documentation Process'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'qualityforge-ai-documentationprocess'
  AND name IS DISTINCT FROM 'Documentation Process';

UPDATE agents
SET name = 'Documenter'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'documenter-qualityforge-documentation-specialist'
  AND name IS DISTINCT FROM 'Documenter';

UPDATE agents
SET name = 'E2E'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'e2e-qualityforge-end-to-end-testing'
  AND name IS DISTINCT FROM 'E2E';

UPDATE agents
SET name = 'Fixer'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'fixer-qualityforge-bug-fixing-specialist'
  AND name IS DISTINCT FROM 'Fixer';

UPDATE agents
SET name = 'Governor'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'governor-qualityforge-quality-director'
  AND name IS DISTINCT FROM 'Governor';

UPDATE agents
SET name = 'Guardian'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'guardian-qualityforge-quality-guardian'
  AND name IS DISTINCT FROM 'Guardian';

UPDATE agents
SET name = 'Inspector'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'inspector-qualityforge-code-inspector'
  AND name IS DISTINCT FROM 'Inspector';

UPDATE agents
SET name = 'Integration'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'integration-Integration-testing'
  AND name IS DISTINCT FROM 'Integration';

UPDATE agents
SET name = 'Integrator'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'integrator-Integration-specialist'
  AND name IS DISTINCT FROM 'Integrator';

UPDATE agents
SET name = 'Load'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'load-Load-testing'
  AND name IS DISTINCT FROM 'Load';

UPDATE agents
SET name = 'Loadtester'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'loadtester-qualityforge-scalability-testing'
  AND name IS DISTINCT FROM 'Loadtester';

UPDATE agents
SET name = 'Maintainer'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'maintainer-qualityforge-code-maintainer'
  AND name IS DISTINCT FROM 'Maintainer';

UPDATE agents
SET name = 'Migrator'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'migrator-qualityforge-migration-specialist'
  AND name IS DISTINCT FROM 'Migrator';

UPDATE agents
SET name = 'Monitor'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'monitor-qualityforge-quality-monitor'
  AND name IS DISTINCT FROM 'Monitor';

UPDATE agents
SET name = 'Optimizer'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'optimizer-qualityforge-code-optimizer'
  AND name IS DISTINCT FROM 'Optimizer';

UPDATE agents
SET name = 'Performance'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'performance-Performance-testing'
  AND name IS DISTINCT FROM 'Performance';

UPDATE agents
SET name = 'Probe'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'probe-qualityforge-prompt-testing'
  AND name IS DISTINCT FROM 'Probe';

UPDATE agents
SET name = 'Profiler'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'profiler-Performance-profiler'
  AND name IS DISTINCT FROM 'Profiler';

UPDATE agents
SET name = 'Refactor'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'refactor-Refactoring-specialist'
  AND name IS DISTINCT FROM 'Refactor';

UPDATE agents
SET name = 'Reporter'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'reporter-qualityforge-quality-reporter'
  AND name IS DISTINCT FROM 'Reporter';

UPDATE agents
SET name = 'Resolver'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'resolver-qualityforge-issue-resolver'
  AND name IS DISTINCT FROM 'Resolver';

UPDATE agents
SET name = 'Simulator'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'simulator-qualityforge-workflow-simulation'
  AND name IS DISTINCT FROM 'Simulator';

UPDATE agents
SET name = 'Standards'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'standards-Standards-enforcer'
  AND name IS DISTINCT FROM 'Standards';

UPDATE agents
SET name = 'Tracer'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'tracer-qualityforge-execution-tracer'
  AND name IS DISTINCT FROM 'Tracer';

UPDATE agents
SET name = 'Trainer'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'trainer-qualityforge-quality-trainer'
  AND name IS DISTINCT FROM 'Trainer';

UPDATE agents
SET name = 'Accessibility'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND title = 'accessibility-Accessibility-testing'
  AND name IS DISTINCT FROM 'Accessibility';

COMMIT;
