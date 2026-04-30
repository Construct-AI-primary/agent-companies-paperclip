-- ============================================================
-- FIX NAMES FOR: paperclipforge-ai
-- Company ID: 550e8400-e29b-41d4-a716-446655440014
-- Agents: 55
-- Uses UPDATE to fix name field on existing agents
-- Uses human_name field when available, otherwise name
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'Advanced Engineering'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-advancedengineering'
  AND name IS DISTINCT FROM 'Advanced Engineering';

UPDATE agents
SET name = 'Agent Reconciler'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-agent-reconciler'
  AND name IS DISTINCT FROM 'Agent Reconciler';

UPDATE agents
SET name = 'Api Manager'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-apimanager'
  AND name IS DISTINCT FROM 'Api Manager';

UPDATE agents
SET name = 'Assignment Specialist'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-assignmentspecialist'
  AND name IS DISTINCT FROM 'Assignment Specialist';

UPDATE agents
SET name = 'Atlas Agent Creator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-atlasagentcreator'
  AND name IS DISTINCT FROM 'Atlas Agent Creator';

UPDATE agents
SET name = 'Auth Administrator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-authadministrator'
  AND name IS DISTINCT FROM 'Auth Administrator';

UPDATE agents
SET name = 'Bridge Builder Extraor'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-bridgebuilderextraor'
  AND name IS DISTINCT FROM 'Bridge Builder Extraor';

UPDATE agents
SET name = 'Cache Keeper'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-cachekeeper'
  AND name IS DISTINCT FROM 'Cache Keeper';

UPDATE agents
SET name = 'Chainlink Charmer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-chainlinkcharmer'
  AND name IS DISTINCT FROM 'Chainlink Charmer';

UPDATE agents
SET name = 'Code Sage'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-codesage'
  AND name IS DISTINCT FROM 'Code Sage';

UPDATE agents
SET name = 'Config Curator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-configcurator'
  AND name IS DISTINCT FROM 'Config Curator';

UPDATE agents
SET name = 'Cross Discipline Coord'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-crossdisciplinecoord'
  AND name IS DISTINCT FROM 'Cross Discipline Coord';

UPDATE agents
SET name = 'Data Architect'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-dataarchitect'
  AND name IS DISTINCT FROM 'Data Architect';

UPDATE agents
SET name = 'Data Integrator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-dataintegrator'
  AND name IS DISTINCT FROM 'Data Integrator';

UPDATE agents
SET name = 'CRUD Commander'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-databasecrudorchestrator'
  AND name IS DISTINCT FROM 'CRUD Commander';

UPDATE agents
SET name = 'Database Druid'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-databasedruid'
  AND name IS DISTINCT FROM 'Database Druid';

UPDATE agents
SET name = 'Dependency Manager'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-dependencymanager'
  AND name IS DISTINCT FROM 'Dependency Manager';

UPDATE agents
SET name = 'Endpoint Enchantress'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-endpointenchantress'
  AND name IS DISTINCT FROM 'Endpoint Enchantress';

UPDATE agents
SET name = 'Engineering Ui Special'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-engineeringuispecial'
  AND name IS DISTINCT FROM 'Engineering Ui Special';

UPDATE agents
SET name = 'Github Operations Spec'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-githuboperationsspec'
  AND name IS DISTINCT FROM 'Github Operations Spec';

UPDATE agents
SET name = 'Integration Architect'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-integrationarchitect'
  AND name IS DISTINCT FROM 'Integration Architect';

UPDATE agents
SET name = 'Integration Illusionis'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-integrationillusionis'
  AND name IS DISTINCT FROM 'Integration Illusionis';

UPDATE agents
SET name = 'Issue Batch Importer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'issue-batch-importer-paperclipforge'
  AND name IS DISTINCT FROM 'Issue Batch Importer';

UPDATE agents
SET name = 'Issue Generator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-issuegenerator'
  AND name IS DISTINCT FROM 'Issue Generator';

UPDATE agents
SET name = 'Knowledge Integrator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-knowledgeintegrator'
  AND name IS DISTINCT FROM 'Knowledge Integrator';

UPDATE agents
SET name = 'Log Analyst'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-loganalyst'
  AND name IS DISTINCT FROM 'Log Analyst';

UPDATE agents
SET name = 'Maya Loopy Content Str'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'maya-loopy-content-strategist'
  AND name IS DISTINCT FROM 'Maya Loopy Content Str';

UPDATE agents
SET name = 'Measurement Coord Spec'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-measurementcoordspec'
  AND name IS DISTINCT FROM 'Measurement Coord Spec';

UPDATE agents
SET name = 'Measurement Standards'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-measurementstandards'
  AND name IS DISTINCT FROM 'Measurement Standards';

UPDATE agents
SET name = 'Measurement Validation'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-measurementvalidation'
  AND name IS DISTINCT FROM 'Measurement Validation';

UPDATE agents
SET name = 'Model Assignment Specialist'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-modelassignmentspeci'
  AND name IS DISTINCT FROM 'Model Assignment Specialist';

UPDATE agents
SET name = 'Monitor Maven'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-monitormaven'
  AND name IS DISTINCT FROM 'Monitor Maven';

UPDATE agents
SET name = 'Network Navigator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-networknavigator'
  AND name IS DISTINCT FROM 'Network Navigator';

UPDATE agents
SET name = 'Operations Director'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-operationsdirector'
  AND name IS DISTINCT FROM 'Operations Director';

UPDATE agents
SET name = 'Org Research Folder Cr'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-orgresearchfoldercr'
  AND name IS DISTINCT FROM 'Org Research Folder Cr';

UPDATE agents
SET name = 'Performance Monitor'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-performancemonitor'
  AND name IS DISTINCT FROM 'Performance Monitor';

UPDATE agents
SET name = 'Performance Profiler'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-performanceprofiler'
  AND name IS DISTINCT FROM 'Performance Profiler';

UPDATE agents
SET name = 'Predictive Modeler'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-predictivemodeler'
  AND name IS DISTINCT FROM 'Predictive Modeler';

UPDATE agents
SET name = 'Progress Tracker'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-progresstracker'
  AND name IS DISTINCT FROM 'Progress Tracker';

UPDATE agents
SET name = 'Project Coordinator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-projectcoordinator'
  AND name IS DISTINCT FROM 'Project Coordinator';

UPDATE agents
SET name = 'Project Maestro'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-projectmaestro'
  AND name IS DISTINCT FROM 'Project Maestro';

UPDATE agents
SET name = 'Quality Controller'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-qualitycontroller'
  AND name IS DISTINCT FROM 'Quality Controller';

UPDATE agents
SET name = 'Reporting Analyst'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-reportinganalyst'
  AND name IS DISTINCT FROM 'Reporting Analyst';

UPDATE agents
SET name = 'Resource Manager'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-resourcemanager'
  AND name IS DISTINCT FROM 'Resource Manager';

UPDATE agents
SET name = 'Risk Analyst'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-riskanalyst'
  AND name IS DISTINCT FROM 'Risk Analyst';

UPDATE agents
SET name = 'Security Guardian'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-securityguardian'
  AND name IS DISTINCT FROM 'Security Guardian';

UPDATE agents
SET name = 'Task Tango Dancer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-tasktangodancer'
  AND name IS DISTINCT FROM 'Task Tango Dancer';

UPDATE agents
SET name = 'Test Commander'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-testcommander'
  AND name IS DISTINCT FROM 'Test Commander';

UPDATE agents
SET name = 'Ticket Tinkerer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-tickettinkerer'
  AND name IS DISTINCT FROM 'Ticket Tinkerer';

UPDATE agents
SET name = 'User Experience Coordi'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-userexperiencecoordi'
  AND name IS DISTINCT FROM 'User Experience Coordi';

UPDATE agents
SET name = 'Vision Loopy Ceo'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'vision-loopy-ceo'
  AND name IS DISTINCT FROM 'Vision Loopy Ceo';

UPDATE agents
SET name = 'Wisdom Weaver'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-wisdomweaver'
  AND name IS DISTINCT FROM 'Wisdom Weaver';

UPDATE agents
SET name = 'Workflow Automator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-workflowautomator'
  AND name IS DISTINCT FROM 'Workflow Automator';

UPDATE agents
SET name = 'Deployer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-deployer'
  AND name IS DISTINCT FROM 'Deployer';

UPDATE agents
SET name = 'Documentarian'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440014'
  AND title = 'paperclipforge-ai-documentarian'
  AND name IS DISTINCT FROM 'Documentarian';

COMMIT;
