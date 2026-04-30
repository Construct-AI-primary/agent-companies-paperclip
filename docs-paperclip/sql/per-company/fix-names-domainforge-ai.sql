-- ============================================================
-- FIX NAMES FOR: domainforge-ai
-- Company ID: 2d7d9c60-c02f-42a7-8f6a-7db86ecc879d
-- Agents: 77
-- Uses UPDATE to fix name field on existing agents
-- Uses human_name field when available, otherwise name
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'Architectural Integrat'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-architecturalintegrat'
  AND name IS DISTINCT FROM 'Architectural Integrat';

UPDATE agents
SET name = 'Buyer Specialist'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-buyerspecialist'
  AND name IS DISTINCT FROM 'Buyer Specialist';

UPDATE agents
SET name = 'Chemical Engineering'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-chemicalengineering'
  AND name IS DISTINCT FROM 'Chemical Engineering';

UPDATE agents
SET name = 'Dependency Manager'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-constructiondirector'
  AND name IS DISTINCT FROM 'Dependency Manager';

UPDATE agents
SET name = 'Construction Eng'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'construction-engineering-domainforge-construction-engineering'
  AND name IS DISTINCT FROM 'Construction Eng';

UPDATE agents
SET name = 'Contract Admin'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'contract-administration-domainforge-contract-administration'
  AND name IS DISTINCT FROM 'Contract Admin';

UPDATE agents
SET name = 'Contract Admin'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'contract-administration-domainforge-contract-administration'
  AND name IS DISTINCT FROM 'Contract Admin';

UPDATE agents
SET name = 'Contracts Director'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-contractsdirector'
  AND name IS DISTINCT FROM 'Contracts Director';

UPDATE agents
SET name = 'Contracts Post Award'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-contractspostaward'
  AND name IS DISTINCT FROM 'Contracts Post Award';

UPDATE agents
SET name = 'Contracts Pre Award'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-contractspreaward'
  AND name IS DISTINCT FROM 'Contracts Pre Award';

UPDATE agents
SET name = 'Council Council'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'council-domainforge-governance-standards'
  AND name IS DISTINCT FROM 'Council Council';

UPDATE agents
SET name = 'Counsel Specialist'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-counselspecialist'
  AND name IS DISTINCT FROM 'Counsel Specialist';

UPDATE agents
SET name = 'Director Project'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-directorproject'
  AND name IS DISTINCT FROM 'Director Project';

UPDATE agents
SET name = 'Dispatcher Specialist'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-dispatcherspecialist'
  AND name IS DISTINCT FROM 'Dispatcher Specialist';

UPDATE agents
SET name = 'Document Control'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-documentcontrol'
  AND name IS DISTINCT FROM 'Document Control';

UPDATE agents
SET name = 'Electrical Engineering'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-electricalengineering'
  AND name IS DISTINCT FROM 'Electrical Engineering';

UPDATE agents
SET name = 'Engineering Director'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-engineeringdirector'
  AND name IS DISTINCT FROM 'Engineering Director';

UPDATE agents
SET name = 'Finance Director'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-financedirector'
  AND name IS DISTINCT FROM 'Finance Director';

UPDATE agents
SET name = 'Finance Finance'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'finance-domainforge-finance-cost-management'
  AND name IS DISTINCT FROM 'Finance Finance';

UPDATE agents
SET name = 'Financial Compliance'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-financialcompliance'
  AND name IS DISTINCT FROM 'Financial Compliance';

UPDATE agents
SET name = 'Guardian 2'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-guardian2'
  AND name IS DISTINCT FROM 'Guardian 2';

UPDATE agents
SET name = 'Hse Director'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-hsedirector'
  AND name IS DISTINCT FROM 'Hse Director';

UPDATE agents
SET name = 'Information Technology'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-informationtechnology'
  AND name IS DISTINCT FROM 'Information Technology';

UPDATE agents
SET name = 'Inspector Specialist'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-inspectorspecialist'
  AND name IS DISTINCT FROM 'Inspector Specialist';

UPDATE agents
SET name = 'Local Content'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-localcontent'
  AND name IS DISTINCT FROM 'Local Content';

UPDATE agents
SET name = 'Logistics Director'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-logisticsdirector'
  AND name IS DISTINCT FROM 'Logistics Director';

UPDATE agents
SET name = 'Mechanical Engineering'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-mechanicalengineering'
  AND name IS DISTINCT FROM 'Mechanical Engineering';

UPDATE agents
SET name = 'Mobile Testing'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-mobiletesting'
  AND name IS DISTINCT FROM 'Mobile Testing';

UPDATE agents
SET name = 'Mobile Workflow Design'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-mobileworkflowdesign'
  AND name IS DISTINCT FROM 'Mobile Workflow Design';

UPDATE agents
SET name = 'Other Parties'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-otherparties'
  AND name IS DISTINCT FROM 'Other Parties';

UPDATE agents
SET name = 'Process Engineering'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-processengineering'
  AND name IS DISTINCT FROM 'Process Engineering';

UPDATE agents
SET name = 'Procurement Analytics'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'procurement-analytics-domainforge-procurement-analytics'
  AND name IS DISTINCT FROM 'Procurement Analytics';

UPDATE agents
SET name = 'Procurement Director'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-procurementdirector'
  AND name IS DISTINCT FROM 'Procurement Director';

UPDATE agents
SET name = 'Procurement Strategy'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'procurement-strategy-domainforge-procurement-strategy'
  AND name IS DISTINCT FROM 'Procurement Strategy';

UPDATE agents
SET name = 'Project Controls'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-projectcontrols'
  AND name IS DISTINCT FROM 'Project Controls';

UPDATE agents
SET name = 'Public Relations'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-publicrelations'
  AND name IS DISTINCT FROM 'Public Relations';

UPDATE agents
SET name = 'Quality Assurance'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'quality-assurance-domainforge-quality-assurance'
  AND name IS DISTINCT FROM 'Quality Assurance';

UPDATE agents
SET name = 'Quality Assurance Qual'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'quality-assurance-domainforge-quality-assurance'
  AND name IS DISTINCT FROM 'Quality Assurance Qual';

UPDATE agents
SET name = 'Quality Control'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'quality-control-domainforge-quality-control'
  AND name IS DISTINCT FROM 'Quality Control';

UPDATE agents
SET name = 'Quality Control Qualit'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'quality-control-domainforge-quality-control'
  AND name IS DISTINCT FROM 'Quality Control Qualit';

UPDATE agents
SET name = 'Quantity Surveying'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-quantitysurveying'
  AND name IS DISTINCT FROM 'Quantity Surveying';

UPDATE agents
SET name = 'Safety Officer'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'safety-domainforge-safety-risk-management'
  AND name IS DISTINCT FROM 'Safety Officer';

UPDATE agents
SET name = 'Safety Safety'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'safety-domainforge-safety-risk-management'
  AND name IS DISTINCT FROM 'Safety Safety';

UPDATE agents
SET name = 'Sales Director'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-salesdirector'
  AND name IS DISTINCT FROM 'Sales Director';

UPDATE agents
SET name = 'Structural Engineer'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'structural-domainforge-structural-engineering'
  AND name IS DISTINCT FROM 'Structural Engineer';

UPDATE agents
SET name = 'Supplier Management'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-suppliermanagement'
  AND name IS DISTINCT FROM 'Supplier Management';

UPDATE agents
SET name = 'Treasurer 2'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-treasurer2'
  AND name IS DISTINCT FROM 'Treasurer 2';

UPDATE agents
SET name = 'Architectural'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-architectural'
  AND name IS DISTINCT FROM 'Architectural';

UPDATE agents
SET name = 'civil'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'civil-domainforge-civil-engineering'
  AND name IS DISTINCT FROM 'civil';

UPDATE agents
SET name = 'Commercial'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-commercial'
  AND name IS DISTINCT FROM 'Commercial';

UPDATE agents
SET name = 'council'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'council-domainforge-governance-standards'
  AND name IS DISTINCT FROM 'council';

UPDATE agents
SET name = 'Design'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-design'
  AND name IS DISTINCT FROM 'Design';

UPDATE agents
SET name = 'Directors'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-directors'
  AND name IS DISTINCT FROM 'Directors';

UPDATE agents
SET name = 'domainforgeai Civil'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'civil-domainforge-civil-engineering'
  AND name IS DISTINCT FROM 'domainforgeai Civil';

UPDATE agents
SET name = 'Orion'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'orion-domainforge-ceo'
  AND name IS DISTINCT FROM 'Orion';

UPDATE agents
SET name = 'domainforgeai Procure'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'procurement-domainforge-procurement-contracts'
  AND name IS DISTINCT FROM 'domainforgeai Procure';

UPDATE agents
SET name = 'domainforgeai Strateg'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'strategos-domainforge-strategic-planning'
  AND name IS DISTINCT FROM 'domainforgeai Strateg';

UPDATE agents
SET name = 'domainforgeai Structu'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'structural-domainforge-structural-engineering'
  AND name IS DISTINCT FROM 'domainforgeai Structu';

UPDATE agents
SET name = 'Environmental'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-environmental'
  AND name IS DISTINCT FROM 'Environmental';

UPDATE agents
SET name = 'Ethics'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-ethics'
  AND name IS DISTINCT FROM 'Ethics';

UPDATE agents
SET name = 'Evaluator'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-evaluator'
  AND name IS DISTINCT FROM 'Evaluator';

UPDATE agents
SET name = 'finance'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'finance-domainforge-finance-cost-management'
  AND name IS DISTINCT FROM 'finance';

UPDATE agents
SET name = 'geotechnical'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'geotechnical-domainforge-geotechnical-engineering'
  AND name IS DISTINCT FROM 'geotechnical';

UPDATE agents
SET name = 'Health'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-health'
  AND name IS DISTINCT FROM 'Health';

UPDATE agents
SET name = 'Inspection'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-inspection'
  AND name IS DISTINCT FROM 'Inspection';

UPDATE agents
SET name = 'Landscaping'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-landscaping'
  AND name IS DISTINCT FROM 'Landscaping';

UPDATE agents
SET name = 'legal'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'legal-domainforge-legal-regulatory-compliance'
  AND name IS DISTINCT FROM 'legal';

UPDATE agents
SET name = 'logistics'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'logistics-domainforge-supply-chain'
  AND name IS DISTINCT FROM 'logistics';

UPDATE agents
SET name = 'orion'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'orion-domainforge-ceo'
  AND name IS DISTINCT FROM 'orion';

UPDATE agents
SET name = 'procurement'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'procurement-domainforge-procurement-contracts'
  AND name IS DISTINCT FROM 'procurement';

UPDATE agents
SET name = 'Sales'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-sales'
  AND name IS DISTINCT FROM 'Sales';

UPDATE agents
SET name = 'Scheduling'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-scheduling'
  AND name IS DISTINCT FROM 'Scheduling';

UPDATE agents
SET name = 'Scrutineer'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-scrutineer'
  AND name IS DISTINCT FROM 'Scrutineer';

UPDATE agents
SET name = 'Security'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-security'
  AND name IS DISTINCT FROM 'Security';

UPDATE agents
SET name = 'strategos'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'strategos-domainforge-strategic-planning'
  AND name IS DISTINCT FROM 'strategos';

UPDATE agents
SET name = 'Sundry'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-sundry'
  AND name IS DISTINCT FROM 'Sundry';

UPDATE agents
SET name = 'Transportation'
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND title = 'domainforge-ai-transportation'
  AND name IS DISTINCT FROM 'Transportation';

COMMIT;
