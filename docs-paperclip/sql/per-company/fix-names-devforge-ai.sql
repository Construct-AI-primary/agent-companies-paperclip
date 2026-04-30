-- ============================================================
-- FIX NAMES FOR: devforge-ai
-- Company ID: f97b30e8-b022-4350-b4b0-30d43e2ebcf4
-- Agents: 59
-- Uses UPDATE to fix name field on existing agents
-- Uses human_name field when available, otherwise name
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'Ally'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'ally-devforge-partnership-management'
  AND name IS DISTINCT FROM 'Ally';

UPDATE agents
SET name = 'Ambassador'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'ambassador-devforge-brand-representation'
  AND name IS DISTINCT FROM 'Ambassador';

UPDATE agents
SET name = 'Amplifier'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'amplifier-devforge-marketing-promotion'
  AND name IS DISTINCT FROM 'Amplifier';

UPDATE agents
SET name = 'Analyst'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'analyst-devforge-market-analysis'
  AND name IS DISTINCT FROM 'Analyst';

UPDATE agents
SET name = 'Archivist'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'archivist-devforge-knowledge-security'
  AND name IS DISTINCT FROM 'Archivist';

UPDATE agents
SET name = 'Atlas'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'atlas-devforge-product-mapping'
  AND name IS DISTINCT FROM 'Atlas';

UPDATE agents
SET name = 'Auditor'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'auditor-devforge-security-compliance'
  AND name IS DISTINCT FROM 'Auditor';

UPDATE agents
SET name = 'Automata'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'automata-devforge-automation-systems'
  AND name IS DISTINCT FROM 'Automata';

UPDATE agents
SET name = 'Brandforge'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'brandforge-devforge-brand-development'
  AND name IS DISTINCT FROM 'Brandforge';

UPDATE agents
SET name = 'Cartographer'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'cartographer-devforge-product-roadmapping'
  AND name IS DISTINCT FROM 'Cartographer';

UPDATE agents
SET name = 'Catalyst'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'catalyst-devforge-product-innovation'
  AND name IS DISTINCT FROM 'Catalyst';

UPDATE agents
SET name = 'Catalystx'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'catalystx-devforge-market-disruption'
  AND name IS DISTINCT FROM 'Catalystx';

UPDATE agents
SET name = 'Cloudops'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'cloudops-devforge-cloud-operations'
  AND name IS DISTINCT FROM 'Cloudops';

UPDATE agents
SET name = 'Codesmith'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'codesmith-devforge-backend-engineer'
  AND name IS DISTINCT FROM 'Codesmith';

UPDATE agents
SET name = 'Compass'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'compass-devforge-direction-setting'
  AND name IS DISTINCT FROM 'Compass';

UPDATE agents
SET name = 'Concierge'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'concierge-devforge-customer-experience'
  AND name IS DISTINCT FROM 'Concierge';

UPDATE agents
SET name = 'Cortex'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'cortex-devforge-ai-reasoning'
  AND name IS DISTINCT FROM 'Cortex';

UPDATE agents
SET name = 'Council'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'council-devforge-strategic-decision-making'
  AND name IS DISTINCT FROM 'Council';

UPDATE agents
SET name = 'Dataforge'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'dataforge-devforge-data-transformation'
  AND name IS DISTINCT FROM 'Dataforge';

UPDATE agents
SET name = 'Dealmaker'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'dealmaker-devforge-sales-negotiation'
  AND name IS DISTINCT FROM 'Dealmaker';

UPDATE agents
SET name = 'Devcore'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'devcore-devforge-core-development'
  AND name IS DISTINCT FROM 'Devcore';

UPDATE agents
SET name = 'Document Generation Sp'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'devforge-ai-documentgenerationsp'
  AND name IS DISTINCT FROM 'Document Generation Sp';

UPDATE agents
SET name = 'Financial Validator'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'devforge-ai-financialvalidator'
  AND name IS DISTINCT FROM 'Financial Validator';

UPDATE agents
SET name = 'Forge'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'forge-devforge-system-architecture'
  AND name IS DISTINCT FROM 'Forge';

UPDATE agents
SET name = 'Gatekeeper'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'gatekeeper-devforge-access-control'
  AND name IS DISTINCT FROM 'Gatekeeper';

UPDATE agents
SET name = 'Guardian'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'guardian-devforge-threat-protection'
  AND name IS DISTINCT FROM 'Guardian';

UPDATE agents
SET name = 'Insight'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'insight-devforge-business-intelligence'
  AND name IS DISTINCT FROM 'Insight';

UPDATE agents
SET name = 'Interface'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'interface-devforge-api-integration'
  AND name IS DISTINCT FROM 'Interface';

UPDATE agents
SET name = 'Ledger'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'ledger-devforge-financial-oversight'
  AND name IS DISTINCT FROM 'Ledger';

UPDATE agents
SET name = 'Ledgerai'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'ledgerai-devforge-financial-data'
  AND name IS DISTINCT FROM 'Ledgerai';

UPDATE agents
SET name = 'Librarian'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'librarian-devforge-knowledge-management'
  AND name IS DISTINCT FROM 'Librarian';

UPDATE agents
SET name = 'Mentor'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'mentor-devforge-team-development'
  AND name IS DISTINCT FROM 'Mentor';

UPDATE agents
SET name = 'Merchant'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'merchant-devforge-commerce-operations'
  AND name IS DISTINCT FROM 'Merchant';

UPDATE agents
SET name = 'Multi Discipline Coord'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'devforge-ai-multidisciplinecoord'
  AND name IS DISTINCT FROM 'Multi Discipline Coord';

UPDATE agents
SET name = 'Navigator'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'navigator-devforge-data-discovery'
  AND name IS DISTINCT FROM 'Navigator';

UPDATE agents
SET name = 'Nexus'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'nexus-devforge-ceo'
  AND name IS DISTINCT FROM 'Nexus';

UPDATE agents
SET name = 'Nova'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'nova-devforge-product-launches'
  AND name IS DISTINCT FROM 'Nova';

UPDATE agents
SET name = 'Oracle'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'oracle-devforge-predictive-analytics'
  AND name IS DISTINCT FROM 'Oracle';

UPDATE agents
SET name = 'Orion'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'orion-devforge-orchestrator'
  AND name IS DISTINCT FROM 'Orion';

UPDATE agents
SET name = 'Pathfinder'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'pathfinder-devforge-opportunity-identification'
  AND name IS DISTINCT FROM 'Pathfinder';

UPDATE agents
SET name = 'Promptsmith'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'promptsmith-devforge-prompt-engineering'
  AND name IS DISTINCT FROM 'Promptsmith';

UPDATE agents
SET name = 'Pulse'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'pulse-devforge-realtime-monitoring'
  AND name IS DISTINCT FROM 'Pulse';

UPDATE agents
SET name = 'Reviewer'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'reviewer-devforge-code-review-qa'
  AND name IS DISTINCT FROM 'Reviewer';

UPDATE agents
SET name = 'Schema'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'schema-devforge-data-schema-management'
  AND name IS DISTINCT FROM 'Schema';

UPDATE agents
SET name = 'Scout'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'scout-devforge-competitive-intelligence'
  AND name IS DISTINCT FROM 'Scout';

UPDATE agents
SET name = 'Sentinel'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'sentinel-devforge-data-quality-monitoring'
  AND name IS DISTINCT FROM 'Sentinel';

UPDATE agents
SET name = 'Sentinelx'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'sentinelx-devforge-advanced-monitoring'
  AND name IS DISTINCT FROM 'Sentinelx';

UPDATE agents
SET name = 'Sql Query Devforge'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'sql-query-devforge'
  AND name IS DISTINCT FROM 'Sql Query Devforge';

UPDATE agents
SET name = 'Storycraft'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'storycraft-devforge-product-storytelling'
  AND name IS DISTINCT FROM 'Storycraft';

UPDATE agents
SET name = 'Strategos'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'strategos-devforge-strategic-planning'
  AND name IS DISTINCT FROM 'Strategos';

UPDATE agents
SET name = 'Stream'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'stream-devforge-data-streaming'
  AND name IS DISTINCT FROM 'Stream';

UPDATE agents
SET name = 'Synth'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'synth-Synthetic-data'
  AND name IS DISTINCT FROM 'Synth';

UPDATE agents
SET name = 'Transaction Processor'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'devforge-ai-transactionprocessor'
  AND name IS DISTINCT FROM 'Transaction Processor';

UPDATE agents
SET name = 'Troubleshooter'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'fixer-devforge-bug-fixing'
  AND name IS DISTINCT FROM 'Troubleshooter';

UPDATE agents
SET name = 'Vector'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'vector-Vector-processing'
  AND name IS DISTINCT FROM 'Vector';

UPDATE agents
SET name = 'Voyager'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'voyager-devforge-market-exploration'
  AND name IS DISTINCT FROM 'Voyager';

UPDATE agents
SET name = 'Watchtower'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'watchtower-devforge-security-oversight'
  AND name IS DISTINCT FROM 'Watchtower';

UPDATE agents
SET name = 'Workflow Complexity An'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'devforge-ai-workflowcomplexityan'
  AND name IS DISTINCT FROM 'Workflow Complexity An';

UPDATE agents
SET name = 'Workflow Learning Coor'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND title = 'devforge-ai-workflowlearningcoor'
  AND name IS DISTINCT FROM 'Workflow Learning Coor';

COMMIT;
