-- ============================================================
-- Agent Name Migration Script
-- Phase 3: Human Name Standardization
-- Created: 2026-04-22
-- Description: Renames all agents to human-readable, globally unique names
-- Pattern: {human-name}-{company-slug}
-- ============================================================

-- ============================================================
-- PAPERCLIPFORGE AI NAME UPDATES
-- ============================================================

-- COO / Operations Director
UPDATE agents SET name = 'maya-paperclipforge' 
WHERE name = 'paperclipforge-ai-operations-director' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Agent Creator
UPDATE agents SET name = 'atlas-paperclipforge' 
WHERE name = 'paperclipforge-ai-atlas-agent-creator' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Engineering Analysis
UPDATE agents SET name = 'andy-paperclipforge' 
WHERE name = 'paperclipforge-ai-advanced-engineering-analysis' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Cross-Discipline Coordination
UPDATE agents SET name = 'charlie-paperclipforge' 
WHERE name = 'paperclipforge-ai-cross-discipline-coordination' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Engineering UI Specialist
UPDATE agents SET name = 'uma-paperclipforge' 
WHERE name = 'paperclipforge-ai-engineering-ui-specialist' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Measurement Coordination Specialist
UPDATE agents SET name = 'molly-paperclipforge' 
WHERE name = 'paperclipforge-ai-measurement-coordination-specialist' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Measurement Validation Specialist
UPDATE agents SET name = 'vera-paperclipforge' 
WHERE name = 'paperclipforge-ai-measurement-validation-specialist' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Measurement Standards Specialist
UPDATE agents SET name = 'stella-paperclipforge' 
WHERE name = 'paperclipforge-ai-measurement-standards-specialist' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Wisdom Weaver
UPDATE agents SET name = 'wisdom-paperclipforge' 
WHERE name = 'paperclipforge-ai-wisdom-weaver' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Org Research Folder Creator
UPDATE agents SET name = 'scout-paperclipforge' 
WHERE name = 'paperclipforge-ai-org-research-folder-creator' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- GitHub Operations Specialist
UPDATE agents SET name = 'git-paperclipforge' 
WHERE name = 'paperclipforge-ai-github-operations-specialist' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- API Manager
UPDATE agents SET name = 'api-paperclipforge' 
WHERE name = 'paperclipforge-ai-api-manager' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Assignment Specialist
UPDATE agents SET name = 'assign-paperclipforge' 
WHERE name = 'paperclipforge-ai-assignment-specialist' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Auth Administrator
UPDATE agents SET name = 'auth-paperclipforge' 
WHERE name = 'paperclipforge-ai-auth-administrator' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Backup Butler
UPDATE agents SET name = 'backup-paperclipforge' 
WHERE name = 'paperclipforge-ai-backup-butler' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Cache Keeper
UPDATE agents SET name = 'cache-paperclipforge' 
WHERE name = 'paperclipforge-ai-cache-keeper' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Chaos Champion
UPDATE agents SET name = 'chaos-paperclipforge' 
WHERE name = 'paperclipforge-ai-chaos-champion' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Code Sage
UPDATE agents SET name = 'sage-paperclipforge' 
WHERE name = 'paperclipforge-ai-code-sage' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Config Curator
UPDATE agents SET name = 'config-paperclipforge' 
WHERE name = 'paperclipforge-ai-config-curator' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Data Architect
UPDATE agents SET name = 'data-paperclipforge' 
WHERE name = 'paperclipforge-ai-data-architect' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Data Integrator
UPDATE agents SET name = 'integrator-paperclipforge' 
WHERE name = 'paperclipforge-ai-data-integrator' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Database Druid
UPDATE agents SET name = 'db-paperclipforge' 
WHERE name = 'paperclipforge-ai-database-druid' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Dependency Manager
UPDATE agents SET name = 'depend-paperclipforge' 
WHERE name = 'paperclipforge-ai-dependency-manager' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Deployer
UPDATE agents SET name = 'deploy-paperclipforge' 
WHERE name = 'paperclipforge-ai-deployer' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Documentarian
UPDATE agents SET name = 'docs-paperclipforge' 
WHERE name = 'paperclipforge-ai-documentarian' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Integration Architect
UPDATE agents SET name = 'architect-paperclipforge' 
WHERE name = 'paperclipforge-ai-integration-architect' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Issue Generator
UPDATE agents SET name = 'issue-paperclipforge' 
WHERE name = 'paperclipforge-ai-issue-generator' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Knowledge Integrator
UPDATE agents SET name = 'knowledge-paperclipforge' 
WHERE name = 'paperclipforge-ai-knowledge-integrator' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Log Analyst
UPDATE agents SET name = 'log-paperclipforge' 
WHERE name = 'paperclipforge-ai-log-analyst' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Metric Master
UPDATE agents SET name = 'metric-paperclipforge' 
WHERE name = 'paperclipforge-ai-metric-master' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Monitor Maven
UPDATE agents SET name = 'monitor-paperclipforge' 
WHERE name = 'paperclipforge-ai-monitor-maven' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Network Navigator
UPDATE agents SET name = 'network-paperclipforge' 
WHERE name = 'paperclipforge-ai-network-navigator' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Performance Monitor
UPDATE agents SET name = 'perfmon-paperclipforge' 
WHERE name = 'paperclipforge-ai-performance-monitor' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Performance Profiler
UPDATE agents SET name = 'profiler-paperclipforge' 
WHERE name = 'paperclipforge-ai-performance-profiler' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Predictive Modeler
UPDATE agents SET name = 'predict-paperclipforge' 
WHERE name = 'paperclipforge-ai-predictive-modeler' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Progress Tracker
UPDATE agents SET name = 'progress-paperclipforge' 
WHERE name = 'paperclipforge-ai-progress-tracker' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Project Coordinator
UPDATE agents SET name = 'coord-paperclipforge' 
WHERE name = 'paperclipforge-ai-project-coordinator' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Quality Controller
UPDATE agents SET name = 'qc-paperclipforge' 
WHERE name = 'paperclipforge-ai-quality-controller' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Reporting Analyst
UPDATE agents SET name = 'report-paperclipforge' 
WHERE name = 'paperclipforge-ai-reporting-analyst' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Resource Manager
UPDATE agents SET name = 'resource-paperclipforge' 
WHERE name = 'paperclipforge-ai-resource-manager' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Risk Analyst
UPDATE agents SET name = 'risk-paperclipforge' 
WHERE name = 'paperclipforge-ai-risk-analyst' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Scheduler Sage
UPDATE agents SET name = 'schedule-paperclipforge' 
WHERE name = 'paperclipforge-ai-scheduler-sage' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Secret Keeper
UPDATE agents SET name = 'secret-paperclipforge' 
WHERE name = 'paperclipforge-ai-secret-keeper' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Security Guardian
UPDATE agents SET name = 'security-paperclipforge' 
WHERE name = 'paperclipforge-ai-security-guardian' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Test Commander
UPDATE agents SET name = 'test-paperclipforge' 
WHERE name = 'paperclipforge-ai-test-commander' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- User Experience Coordinator
UPDATE agents SET name = 'ux-paperclipforge' 
WHERE name = 'paperclipforge-ai-user-experience-coordinator' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Version Vigilante
UPDATE agents SET name = 'version-paperclipforge' 
WHERE name = 'paperclipforge-ai-version-vigilante' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- Workflow Automator
UPDATE agents SET name = 'workflow-paperclipforge' 
WHERE name = 'paperclipforge-ai-workflow-automator' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- ============================================================
-- MEASUREFORGE AI NAME UPDATES (Tiered Architecture)
-- ============================================================

-- Chief Measurement Orchestrator
UPDATE agents SET name = 'master-measureforge' 
WHERE name = 'the-measuremaster' 
  AND company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI');

-- Measurement Standards Director
UPDATE agents SET name = 'reggie-measureforge' 
WHERE name = 'reggie-the-regulator' 
  AND company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI');

-- Quality Assurance Coordinator
UPDATE agents SET name = 'quincy-measureforge' 
WHERE name = 'quincy-the-quality-queen' 
  AND company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI');

-- Quantity Surveying Coordinator
UPDATE agents SET name = 'quantina-measureforge' 
WHERE name = 'quantina-the-calculator' 
  AND company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI');

-- Earthwork & Terrain Coordinator
UPDATE agents SET name = 'terra-measureforge' 
WHERE name = 'terra-the-terrain-titan' 
  AND company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI');

-- Civil Engineering Coordinator
UPDATE agents SET name = 'cindy-measureforge' 
WHERE name = 'cindy-the-concrete-queen' 
  AND company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI');

-- Electrical Coordinator
UPDATE agents SET name = 'sparky-measureforge' 
WHERE name = 'sparky-the-electrical-wizard' 
  AND company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI');

-- Traffic & Transportation Coordinator
UPDATE agents SET name = 'tina-measureforge' 
WHERE name = 'traffic-tina-the-transit-guru' 
  AND company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI');

-- CAD Integration Coordinator
UPDATE agents SET name = 'caddy-measureforge' 
WHERE name = 'caddy-the-cad-commander' 
  AND company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI');

-- Quality Control Coordinator
UPDATE agents SET name = 'quill-measureforge' 
WHERE name = 'quill-the-quality-inspector' 
  AND company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI');

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Check for any remaining non-human-readable names
SELECT a.name, a.company_id FROM agents a 
WHERE a.name LIKE 'paperclipforge-ai-%' 
   OR a.name LIKE 'the-%' 
   OR a.name LIKE '%-the-%'
ORDER BY a.company_id, a.name;

-- List all unique agent names after migration
SELECT a.name, c.name as company_name 
FROM agents a 
JOIN companies c ON a.company_id = c.id 
ORDER BY c.name, a.name;
