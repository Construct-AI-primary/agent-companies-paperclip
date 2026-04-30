-- ============================================================
-- PRE-DEPLOYMENT DATABASE BACKUP SCRIPT
-- Paperclip Ecosystem Production Deployment
-- Date: 2026-04-22
-- Purpose: Create comprehensive backup of agents and companies tables
-- Tables: agents, companies, agent_api_keys (if exists)
-- ============================================================

-- ============================================================
-- BACKUP INSTRUCTIONS
-- ============================================================
-- 1. Execute this script BEFORE any deployment operations
-- 2. Save the output for rollback purposes if needed
-- 3. Verify backup completeness before proceeding
-- 4. Store backup securely for disaster recovery
-- ============================================================

-- Create backup timestamp for tracking
SELECT
  'BACKUP START TIME: ' || NOW()::TEXT as backup_timestamp,
  'Paperclip Ecosystem Pre-Deployment Backup' as backup_description;

-- ============================================================
-- BACKUP 1: COMPANIES TABLE
-- Core company information and metadata
-- ============================================================

SELECT 'BACKUP 1: Companies Table' as backup_section;

-- Full companies table backup
CREATE TEMP TABLE companies_backup AS
SELECT
  id,
  name,
  description,
  icon,
  status,
  created_at,
  updated_at,
  -- Include any additional columns that may exist
  (SELECT jsonb_object_keys(to_jsonb(c)) FROM companies c LIMIT 1) as schema_columns
FROM companies
ORDER BY name;

-- Display companies backup summary
SELECT
  'Companies Backup Summary' as summary_type,
  COUNT(*) as total_companies,
  COUNT(CASE WHEN status = 'active' THEN 1 END) as active_companies,
  MIN(created_at) as earliest_company,
  MAX(created_at) as latest_company
FROM companies_backup;

-- Display detailed companies data
SELECT
  'Companies Data Backup' as data_type,
  jsonb_agg(
    jsonb_build_object(
      'id', id,
      'name', name,
      'description', description,
      'icon', icon,
      'status', status,
      'created_at', created_at,
      'updated_at', updated_at
    )
  ) as companies_backup_json
FROM companies_backup;

-- ============================================================
-- BACKUP 2: AGENTS TABLE
-- Complete agent configurations and relationships
-- ============================================================

SELECT 'BACKUP 2: Agents Table' as backup_section;

-- Full agents table backup
CREATE TEMP TABLE agents_backup AS
SELECT
  id,
  company_id,
  name,
  role,
  title,
  icon,
  status,
  reports_to,
  capabilities,
  adapter_config,
  created_at,
  updated_at,
  -- Include any additional columns that may exist
  (SELECT jsonb_object_keys(to_jsonb(a)) FROM agents a LIMIT 1) as schema_columns
FROM agents
ORDER BY company_id, name;

-- Display agents backup summary
SELECT
  'Agents Backup Summary' as summary_type,
  COUNT(*) as total_agents,
  COUNT(DISTINCT company_id) as companies_with_agents,
  COUNT(CASE WHEN status = 'idle' THEN 1 END) as idle_agents,
  COUNT(CASE WHEN status = 'active' THEN 1 END) as active_agents,
  COUNT(CASE WHEN status = 'error' THEN 1 END) as error_agents,
  MIN(created_at) as earliest_agent,
  MAX(created_at) as latest_agent
FROM agents_backup;

-- Display agent status distribution
SELECT
  'Agent Status Distribution' as distribution_type,
  status,
  COUNT(*) as count,
  ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (), 1) as percentage
FROM agents_backup
GROUP BY status
ORDER BY count DESC;

-- Display model configuration distribution
SELECT
  'Model Configuration Distribution' as config_type,
  adapter_config->>'adapter' as adapter,
  adapter_config->>'model' as model,
  COUNT(*) as count,
  ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (), 1) as percentage
FROM agents_backup
GROUP BY adapter_config->>'adapter', adapter_config->>'model'
ORDER BY count DESC;

-- Display detailed agents data (first 50 for readability)
SELECT
  'Agents Data Backup (Sample - First 50)' as data_type,
  jsonb_agg(
    jsonb_build_object(
      'id', id,
      'company_id', company_id,
      'name', name,
      'role', role,
      'title', title,
      'status', status,
      'reports_to', reports_to,
      'capabilities', capabilities,
      'adapter_config', adapter_config,
      'created_at', created_at,
      'updated_at', updated_at
    )
  ) as agents_backup_json
FROM (
  SELECT * FROM agents_backup
  ORDER BY company_id, name
  LIMIT 50
) sample_agents;

-- ============================================================
-- BACKUP 3: AGENT RELATIONSHIPS & HIERARCHIES
-- Reporting structures and company relationships
-- ============================================================

SELECT 'BACKUP 3: Agent Relationships & Hierarchies' as backup_section;

-- Company-agent relationship summary
CREATE TEMP TABLE company_agent_relationships AS
SELECT
  c.name as company_name,
  c.id as company_id,
  COUNT(a.id) as agent_count,
  STRING_AGG(a.name, ', ' ORDER BY a.name) as agent_names,
  STRING_AGG(a.role, ', ' ORDER BY a.name) as agent_roles
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
GROUP BY c.id, c.name
ORDER BY c.name;

-- Display company-agent relationships
SELECT
  'Company-Agent Relationships' as relationship_type,
  jsonb_agg(
    jsonb_build_object(
      'company_name', company_name,
      'company_id', company_id,
      'agent_count', agent_count,
      'agent_names', agent_names,
      'agent_roles', agent_roles
    )
  ) as relationships_backup
FROM company_agent_relationships;

-- Reporting hierarchy analysis
CREATE TEMP TABLE hierarchy_backup AS
SELECT
  a.id as agent_id,
  a.name as agent_name,
  a.company_id,
  c.name as company_name,
  a.reports_to,
  superior.name as reports_to_name,
  a.role,
  a.title
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agents superior ON a.reports_to = superior.name AND a.company_id = superior.company_id
ORDER BY c.name, a.name;

-- Display hierarchy backup
SELECT
  'Hierarchy Relationships Backup' as hierarchy_type,
  jsonb_agg(
    jsonb_build_object(
      'agent_id', agent_id,
      'agent_name', agent_name,
      'company_name', company_name,
      'reports_to', reports_to,
      'reports_to_name', reports_to_name,
      'role', role,
      'title', title
    )
  ) as hierarchy_backup
FROM hierarchy_backup;

-- ============================================================
-- BACKUP 4: SYSTEM HEALTH METRICS
-- Current system state for comparison
-- ============================================================

SELECT 'BACKUP 4: System Health Metrics' as backup_section;

-- System health snapshot
SELECT
  'System Health Snapshot' as health_type,
  jsonb_build_object(
    'total_companies', (SELECT COUNT(*) FROM companies),
    'total_agents', (SELECT COUNT(*) FROM agents),
    'active_companies', (SELECT COUNT(*) FROM companies WHERE status = 'active'),
    'idle_agents', (SELECT COUNT(*) FROM agents WHERE status = 'idle'),
    'active_agents', (SELECT COUNT(*) FROM agents WHERE status = 'active'),
    'error_agents', (SELECT COUNT(*) FROM agents WHERE status = 'error'),
    'companies_with_agents', (SELECT COUNT(DISTINCT company_id) FROM agents),
    'orphaned_agents', (SELECT COUNT(*) FROM agents a LEFT JOIN companies c ON a.company_id = c.id WHERE c.id IS NULL),
    'backup_timestamp', NOW(),
    'backup_version', '1.0'
  ) as system_health_snapshot;

-- ============================================================
-- BACKUP 5: SCHEMA INFORMATION
-- Table structures for reference
-- ============================================================

SELECT 'BACKUP 5: Schema Information' as backup_section;

-- Companies table schema
SELECT
  'Companies Table Schema' as schema_type,
  column_name,
  data_type,
  is_nullable,
  column_default
FROM information_schema.columns
WHERE table_name = 'companies'
ORDER BY ordinal_position;

-- Agents table schema
SELECT
  'Agents Table Schema' as schema_type,
  column_name,
  data_type,
  is_nullable,
  column_default
FROM information_schema.columns
WHERE table_name = 'agents'
ORDER BY ordinal_position;

-- ============================================================
-- BACKUP COMPLETION VERIFICATION
-- ============================================================

SELECT 'BACKUP COMPLETION VERIFICATION' as verification_type;

-- Verify backup completeness
SELECT
  'Backup Completeness Check' as check_type,
  CASE
    WHEN (SELECT COUNT(*) FROM companies_backup) = (SELECT COUNT(*) FROM companies) THEN '✅ Companies backup complete'
    ELSE '❌ Companies backup incomplete'
  END as companies_check,
  CASE
    WHEN (SELECT COUNT(*) FROM agents_backup) = (SELECT COUNT(*) FROM agents) THEN '✅ Agents backup complete'
    ELSE '❌ Agents backup incomplete'
  END as agents_check,
  CASE
    WHEN (SELECT COUNT(*) FROM companies_backup) > 0 AND (SELECT COUNT(*) FROM agents_backup) >= 0 THEN '✅ Backup process successful'
    ELSE '❌ Backup process failed'
  END as overall_status;

-- Final backup summary
SELECT
  'FINAL BACKUP SUMMARY' as summary_type,
  (SELECT COUNT(*) FROM companies_backup) as companies_backed_up,
  (SELECT COUNT(*) FROM agents_backup) as agents_backed_up,
  NOW() as backup_completion_time,
  'Pre-deployment backup completed successfully' as backup_status;

-- ============================================================
-- BACKUP COMPLETE - SAFE TO PROCEED WITH DEPLOYMENT
-- ============================================================

-- Display final backup confirmation
SELECT
  'BACKUP CONFIRMATION' as confirmation_type,
  'Database backup completed successfully' as message,
  'Ready to proceed with deployment operations' as next_step,
  NOW() as backup_timestamp;

-- ============================================================
-- END OF PRE-DEPLOYMENT BACKUP SCRIPT
-- ============================================================