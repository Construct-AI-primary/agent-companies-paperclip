-- SQL Script to Sync Agent Names in Database with Documentation
-- Run this script after the documentation folder naming standardization
-- Display format: {CompanyName AI}-{role} (e.g., KnowledgeForge AI-administrator)
-- NOTE: Folders stay lowercase for filesystem, but DB uses proper capitalization

-- =============================================================================
-- AGENT NAME SYNC SCRIPT
-- Purpose: Update agent 'name' field in database for proper Paperclip UI display
-- Display Format: {CompanyName AI}-{role} (e.g., KnowledgeForge AI-administrator)
-- =============================================================================

-- Get company IDs for reference
-- WITH company_map AS (
--   SELECT id, issue_prefix, name as current_name FROM companies
-- )

-- =============================================================================
-- KNOWLEDGEFORGE AI AGENTS (45 agents)
-- Display: KnowledgeForge AI-{role}
-- =============================================================================

UPDATE agents SET name = 'KnowledgeForge AI-administrator' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Administrator';
UPDATE agents SET name = 'KnowledgeForge AI-ambiguityprime' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Ambiguityprime';
UPDATE agents SET name = 'KnowledgeForge AI-archivist' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Archivist';
UPDATE agents SET name = 'KnowledgeForge AI-builder' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Builder';
UPDATE agents SET name = 'KnowledgeForge AI-buyer' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Buyer';
UPDATE agents SET name = 'KnowledgeForge AI-chairman' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Chairman';
UPDATE agents SET name = 'KnowledgeForge AI-chemist' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Chemist';
UPDATE agents SET name = 'KnowledgeForge AI-co-ordinator' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Co-ordinator';
UPDATE agents SET name = 'KnowledgeForge AI-communicator' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Communicator';
UPDATE agents SET name = 'KnowledgeForge AI-concierge' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Concierge';
UPDATE agents SET name = 'KnowledgeForge AI-constructor' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Constructor';
UPDATE agents SET name = 'KnowledgeForge AI-controller' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Controller';
UPDATE agents SET name = 'KnowledgeForge AI-counsel' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Counsel';
UPDATE agents SET name = 'KnowledgeForge AI-critic' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Critic';
UPDATE agents SET name = 'KnowledgeForge AI-designer' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Designer';
UPDATE agents SET name = 'KnowledgeForge AI-developer' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Developer';
UPDATE agents SET name = 'KnowledgeForge AI-directors' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Directors';
UPDATE agents SET name = 'KnowledgeForge AI-dispatcher' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Dispatcher';
UPDATE agents SET name = 'KnowledgeForge AI-electrician' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Electrician';
UPDATE agents SET name = 'KnowledgeForge AI-engineer' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Engineer';
UPDATE agents SET name = 'KnowledgeForge AI-environmentalist' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Environmentalist';
UPDATE agents SET name = 'KnowledgeForge AI-ethicist' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Ethicist';
UPDATE agents SET name = 'KnowledgeForge AI-examiner' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Examiner';
UPDATE agents SET name = 'KnowledgeForge AI-gatekeeper' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Gatekeeper';
UPDATE agents SET name = 'KnowledgeForge AI-generalist' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Generalist';
UPDATE agents SET name = 'KnowledgeForge AI-geologist' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Geologist';
UPDATE agents SET name = 'KnowledgeForge AI-governor' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Governor';
UPDATE agents SET name = 'KnowledgeForge AI-greeter' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Greeter';
UPDATE agents SET name = 'KnowledgeForge AI-guardian' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Guardian';
UPDATE agents SET name = 'KnowledgeForge AI-inetrmediary' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Inetrmediary';
UPDATE agents SET name = 'KnowledgeForge AI-inspector' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Inspector';
UPDATE agents SET name = 'KnowledgeForge AI-landscaper' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Landscaper';
UPDATE agents SET name = 'KnowledgeForge AI-leader' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Leader';
UPDATE agents SET name = 'KnowledgeForge AI-merchant' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Merchant';
UPDATE agents SET name = 'KnowledgeForge AI-negotiator' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Negotiator';
UPDATE agents SET name = 'KnowledgeForge AI-optimizer' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Optimizer';
UPDATE agents SET name = 'KnowledgeForge AI-physician' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Physician';
UPDATE agents SET name = 'KnowledgeForge AI-salesperson' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Salesperson';
UPDATE agents SET name = 'KnowledgeForge AI-scheduler' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Scheduler';
UPDATE agents SET name = 'KnowledgeForge AI-sentinel' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Sentinel';
UPDATE agents SET name = 'KnowledgeForge AI-specialist' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Specialist';
UPDATE agents SET name = 'KnowledgeForge AI-surveyor' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Surveyor';
UPDATE agents SET name = 'KnowledgeForge AI-technician' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Technician';
UPDATE agents SET name = 'KnowledgeForge AI-treasurer' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'KNOW') 
  AND name = 'Treasurer';

-- =============================================================================
-- QUALITYFORGE AI AGENTS (40 agents)
-- Display: QualityForge AI-{role}
-- =============================================================================

UPDATE agents SET name = 'QualityForge AI-accessibility' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'accessibility';
UPDATE agents SET name = 'QualityForge AI-apex' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'apex';
UPDATE agents SET name = 'QualityForge AI-architect' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'architect';
UPDATE agents SET name = 'QualityForge AI-auditor' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'auditor';
UPDATE agents SET name = 'QualityForge AI-automation' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'automation';
UPDATE agents SET name = 'QualityForge AI-code-analyzer' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'code-analyzer';
UPDATE agents SET name = 'QualityForge AI-code-reviewer' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'code-reviewer';
UPDATE agents SET name = 'QualityForge AI-codesmith' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'codesmith';
UPDATE agents SET name = 'QualityForge AI-compatibility' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'compatibility';
UPDATE agents SET name = 'QualityForge AI-coverage' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'coverage';
UPDATE agents SET name = 'QualityForge AI-dbat-testing' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'dbat-testing';
UPDATE agents SET name = 'QualityForge AI-debugger' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'debugger';
UPDATE agents SET name = 'QualityForge AI-diagnostics' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'diagnostics';
UPDATE agents SET name = 'QualityForge AI-documenter' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'documenter';
UPDATE agents SET name = 'QualityForge AI-e2e' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'e2e';
UPDATE agents SET name = 'QualityForge AI-fixer' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'fixer';
UPDATE agents SET name = 'QualityForge AI-governor' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'governor';
UPDATE agents SET name = 'QualityForge AI-guardian' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'guardian';
UPDATE agents SET name = 'QualityForge AI-inspector' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'inspector';
UPDATE agents SET name = 'QualityForge AI-integration' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'integration';
UPDATE agents SET name = 'QualityForge AI-integrator' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'integrator';
UPDATE agents SET name = 'QualityForge AI-load' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'load';
UPDATE agents SET name = 'QualityForge AI-loadtester' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'loadtester';
UPDATE agents SET name = 'QualityForge AI-maintainer' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'maintainer';
UPDATE agents SET name = 'QualityForge AI-migrator' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'migrator';
UPDATE agents SET name = 'QualityForge AI-monitor' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'monitor';
UPDATE agents SET name = 'QualityForge AI-optimizer' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'optimizer';
UPDATE agents SET name = 'QualityForge AI-performance' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'performance';
UPDATE agents SET name = 'QualityForge AI-probe' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'probe';
UPDATE agents SET name = 'QualityForge AI-profiler' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'profiler';
UPDATE agents SET name = 'QualityForge AI-refactor' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'refactor';
UPDATE agents SET name = 'QualityForge AI-reporter' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'reporter';
UPDATE agents SET name = 'QualityForge AI-resolver' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'resolver';
UPDATE agents SET name = 'QualityForge AI-simulator' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'simulator';
UPDATE agents SET name = 'QualityForge AI-standards' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'standards';
UPDATE agents SET name = 'QualityForge AI-tracer' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'tracer';
UPDATE agents SET name = 'QualityForge AI-trainer' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'trainer';
UPDATE agents SET name = 'QualityForge AI-validator' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'QUAL') 
  AND name = 'validator';

-- =============================================================================
-- INFRAFORGE AI AGENTS (5 agents)
-- Display: InfraForge AI-{role}
-- =============================================================================

UPDATE agents SET name = 'InfraForge AI-database-infrastructure' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'INFRA') 
  AND name = 'Database Infrastructure';
UPDATE agents SET name = 'InfraForge AI-mobile-api-integration' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'INFRA') 
  AND name = 'Mobile API Integration';
UPDATE agents SET name = 'InfraForge AI-supply-chain-integration' 
  WHERE company_id = (SELECT id FROM companies WHERE issue_prefix = 'INFRA') 
  AND name = 'Supply Chain Integration';

-- =============================================================================
-- VERIFICATION QUERY - List all agents after sync
-- =============================================================================
-- SELECT c.name as company, a.name, a.role 
-- FROM agents a 
-- JOIN companies c ON a.company_id = c.id 
-- ORDER BY c.name, a.name;

-- =============================================================================
-- COMPANY ISSUE_PREFIX REFERENCE
-- =============================================================================
-- KNOW = KnowledgeForge AI
-- DOM = DomainForge AI
-- DEV = DevForge AI
-- QUAL = QualityForge AI
-- INFRA = InfraForge AI
-- PROMPT = PromptForge AI
-- CONTENT = ContentForge AI
-- EXEC = ExecForge AI
-- MOBILE = MobileForge AI
-- VOICE = VoiceForge AI
-- SAAS = SaaSForge AI
-- LEARN = LearningForge AI
-- PAPCLIP = PaperclipForge AI
-- LOOPY = Loopy AI

