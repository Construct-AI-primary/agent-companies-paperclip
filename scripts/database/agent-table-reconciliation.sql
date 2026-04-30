-- ============================================================
-- PAPERCLIP ECOSYSTEM AGENT TABLE RECONCILIATION
-- Date: 2026-04-22
-- Purpose: Verify agent table matches documentation (UPDATED)
-- Database State: 479 agents already exist
-- Expected Final: 479+ agents (existing + any missing)
-- Deployment Type: Selective (only missing agents)
-- ============================================================

-- ============================================================
-- RECONCILIATION OVERVIEW
-- ============================================================
-- This script performs comprehensive reconciliation between:
-- 1. Documentation state (AGENTS.md files)
-- 2. Database state (agents table)
-- 3. Company agent counts
-- 4. Agent configurations and hierarchies
-- ============================================================

-- ============================================================
-- PHASE 1: DOCUMENTATION STATE ANALYSIS
-- Expected counts based on file system analysis
-- ============================================================

SELECT 'RECONCILIATION PHASE 1: Documentation State Analysis' as phase;

-- Create temporary table with expected agent counts per company
CREATE TEMP TABLE expected_agent_counts (
  company_name TEXT PRIMARY KEY,
  expected_count INTEGER,
  documentation_status TEXT
);

INSERT INTO expected_agent_counts VALUES
  ('DevForge AI', 59, 'Complete'),
  ('ContentForge AI', 17, 'Complete'),
  ('DomainForge AI', 66, 'Complete'),
  ('ExecForge AI', 18, 'Complete'),
  ('InfraForge AI', 6, 'Complete'),
  ('IntegrateForge AI', 21, 'Complete'),
  ('LearningForge AI', 50, 'Complete'),
  ('Loopy AI', 6, 'Complete'),
  ('PaperclipForge AI', 33, 'Complete'),
  ('PromptForge AI', 24, 'Complete'),
  ('QualityForge AI', 42, 'Complete'),
  ('VoiceForge AI', 12, 'Complete'),
  ('KnowledgeForge AI', 74, 'Complete');

-- Display expected vs actual documentation counts
SELECT
  'Expected Documentation Counts' as analysis_type,
  SUM(expected_count) as total_expected_agents,
  COUNT(*) as companies_expected,
  '454 agents across 13 companies' as summary
FROM expected_agent_counts;

-- ============================================================
-- PHASE 2: DATABASE STATE ANALYSIS
-- Current agents table analysis
-- ============================================================

SELECT 'RECONCILIATION PHASE 2: Database State Analysis' as phase;

-- Current agent count by company
CREATE TEMP TABLE current_agent_counts AS
SELECT
  c.name as company_name,
  COUNT(a.id) as current_count,
  c.id as company_id
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
GROUP BY c.id, c.name
ORDER BY c.name;

-- Display current database state
SELECT
  'Current Database State' as analysis_type,
  SUM(current_count) as total_current_agents,
  COUNT(*) as companies_with_agents,
  AVG(current_count) as avg_agents_per_company
FROM current_agent_counts;

-- ============================================================
-- PHASE 3: RECONCILIATION ANALYSIS
-- Compare expected vs actual
-- ============================================================

SELECT 'RECONCILIATION PHASE 3: Expected vs Actual Analysis' as phase;

-- Comprehensive reconciliation report
SELECT
  COALESCE(e.company_name, c.company_name) as company_name,
  COALESCE(e.expected_count, 0) as expected_count,
  COALESCE(c.current_count, 0) as current_count,
  CASE
    WHEN COALESCE(e.expected_count, 0) = COALESCE(c.current_count, 0) THEN '✅ MATCH'
    WHEN COALESCE(e.expected_count, 0) > COALESCE(c.current_count, 0) THEN '❌ UNDER - Missing agents'
    WHEN COALESCE(e.expected_count, 0) < COALESCE(c.current_count, 0) THEN '⚠️  OVER - Extra agents'
    ELSE '❓ UNKNOWN'
  END as reconciliation_status,
  ABS(COALESCE(e.expected_count, 0) - COALESCE(c.current_count, 0)) as difference,
  CASE
    WHEN COALESCE(e.expected_count, 0) = COALESCE(c.current_count, 0) THEN 'No action needed'
    WHEN COALESCE(e.expected_count, 0) > COALESCE(c.current_count, 0) THEN 'Deploy missing agents'
    WHEN COALESCE(e.expected_count, 0) < COALESCE(c.current_count, 0) THEN 'Review extra agents'
    ELSE 'Investigate discrepancy'
  END as recommended_action
FROM expected_agent_counts e
FULL OUTER JOIN current_agent_counts c ON e.company_name = c.company_name
ORDER BY
  CASE
    WHEN COALESCE(e.expected_count, 0) != COALESCE(c.current_count, 0) THEN 1
    ELSE 2
  END,
  COALESCE(e.company_name, c.company_name);

-- ============================================================
-- PHASE 4: AGENT CONFIGURATION VALIDATION
-- Verify agent configurations match standards
-- ============================================================

SELECT 'RECONCILIATION PHASE 4: Agent Configuration Validation' as phase;

-- Model configuration analysis
SELECT
  'Model Configuration Analysis' as validation_type,
  adapter_config->>'adapter' as adapter,
  adapter_config->>'model' as model,
  COUNT(*) as count,
  ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (), 1) as percentage,
  CASE
    WHEN adapter_config->>'adapter' = 'hermes_local' AND adapter_config->>'model' = 'anthropic/claude-opus-4.6' THEN '✅ STANDARD'
    ELSE '❌ NON-STANDARD'
  END as compliance_status
FROM agents
GROUP BY adapter_config->>'adapter', adapter_config->>'model'
ORDER BY count DESC;

-- Status distribution analysis
SELECT
  'Agent Status Distribution' as validation_type,
  status,
  COUNT(*) as count,
  ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (), 1) as percentage,
  CASE
    WHEN status = 'idle' THEN '✅ READY'
    WHEN status = 'active' THEN '⚠️  ACTIVE'
    WHEN status = 'error' THEN '❌ ERROR'
    ELSE '❓ UNKNOWN'
  END as status_assessment
FROM agents
GROUP BY status
ORDER BY count DESC;

-- Capabilities validation
SELECT
  'Capabilities Validation' as validation_type,
  CASE
    WHEN capabilities @> '["task_execution", "communication", "analysis"]' THEN '✅ STANDARD CAPABILITIES'
    ELSE '❌ NON-STANDARD CAPABILITIES'
  END as capabilities_status,
  COUNT(*) as count,
  ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (), 1) as percentage
FROM agents
GROUP BY capabilities @> '["task_execution", "communication", "analysis"]';

-- ============================================================
-- PHASE 5: HIERARCHY VALIDATION
-- Verify reporting relationships are valid
-- ============================================================

SELECT 'RECONCILIATION PHASE 5: Hierarchy Validation' as phase;

-- Reporting hierarchy analysis
SELECT
  'Hierarchy Validation' as validation_type,
  CASE
    WHEN a.reports_to IS NULL THEN 'Top-level agent'
    WHEN a.reports_to IS NOT NULL AND EXISTS (SELECT 1 FROM agents a2 WHERE a2.name = a.reports_to AND a2.company_id = a.company_id) THEN 'Valid hierarchy'
    ELSE 'Broken hierarchy'
  END as hierarchy_status,
  COUNT(*) as count,
  ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (), 1) as percentage
FROM agents a
GROUP BY
  CASE
    WHEN a.reports_to IS NULL THEN 'Top-level agent'
    WHEN a.reports_to IS NOT NULL AND EXISTS (SELECT 1 FROM agents a2 WHERE a2.name = a.reports_to AND a2.company_id = a.company_id) THEN 'Valid hierarchy'
    ELSE 'Broken hierarchy'
  END;

-- Display broken hierarchies for review
SELECT
  'Broken Hierarchies - Requires Attention' as issue_type,
  c.name as company_name,
  a.name as agent_name,
  a.reports_to as invalid_reports_to,
  'Agent reports to non-existent superior' as issue_description
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.reports_to IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM agents a2 WHERE a2.name = a.reports_to AND a2.company_id = a.company_id);

-- ============================================================
-- PHASE 6: DATA INTEGRITY CHECKS
-- Comprehensive data quality assessment
-- ============================================================

SELECT 'RECONCILIATION PHASE 6: Data Integrity Checks' as phase;

-- Required field validation
SELECT
  'Data Integrity Assessment' as validation_type,
  'Required Fields Check' as check_type,
  COUNT(*) as total_agents,
  COUNT(CASE WHEN name IS NULL OR name = '' THEN 1 END) as missing_names,
  COUNT(CASE WHEN role IS NULL OR role = '' THEN 1 END) as missing_roles,
  COUNT(CASE WHEN title IS NULL OR title = '' THEN 1 END) as missing_titles,
  COUNT(CASE WHEN adapter_config IS NULL THEN 1 END) as missing_configs,
  COUNT(CASE WHEN company_id IS NULL THEN 1 END) as missing_company_links,
  CASE
    WHEN COUNT(CASE WHEN name IS NULL OR name = '' THEN 1 END) = 0
     AND COUNT(CASE WHEN role IS NULL OR role = '' THEN 1 END) = 0
     AND COUNT(CASE WHEN title IS NULL OR title = '' THEN 1 END) = 0
     AND COUNT(CASE WHEN adapter_config IS NULL THEN 1 END) = 0
     AND COUNT(CASE WHEN company_id IS NULL THEN 1 END) = 0
    THEN '✅ ALL FIELDS POPULATED'
    ELSE '❌ MISSING REQUIRED FIELDS'
  END as integrity_status
FROM agents;

-- Duplicate name check within companies
SELECT
  'Duplicate Prevention Check' as validation_type,
  'Duplicate Names Within Companies' as check_type,
  COUNT(*) as duplicate_groups,
  SUM(duplicate_count) as total_duplicates,
  CASE
    WHEN COUNT(*) = 0 THEN '✅ NO DUPLICATES'
    ELSE '❌ DUPLICATES FOUND'
  END as duplicate_status
FROM (
  SELECT
    company_id,
    name,
    COUNT(*) as duplicate_count
  FROM agents
  GROUP BY company_id, name
  HAVING COUNT(*) > 1
) duplicates;

-- ============================================================
-- PHASE 7: RECONCILIATION SUMMARY & RECOMMENDATIONS
-- Final assessment and action plan
-- ============================================================

SELECT 'RECONCILIATION PHASE 7: Final Summary & Recommendations' as phase;

-- Overall reconciliation status
WITH reconciliation_summary AS (
  SELECT
    SUM(ABS(COALESCE(e.expected_count, 0) - COALESCE(c.current_count, 0))) as total_discrepancy,
    COUNT(CASE WHEN COALESCE(e.expected_count, 0) != COALESCE(c.current_count, 0) THEN 1 END) as companies_with_discrepancy,
    COUNT(*) as total_companies
  FROM expected_agent_counts e
  FULL OUTER JOIN current_agent_counts c ON e.company_name = c.company_name
)
SELECT
  'OVERALL RECONCILIATION STATUS' as summary_type,
  total_discrepancy as total_agent_discrepancy,
  companies_with_discrepancy as companies_affected,
  total_companies as total_companies_analyzed,
  CASE
    WHEN total_discrepancy = 0 THEN '🎯 PERFECT ALIGNMENT - Ready for production'
    WHEN total_discrepancy <= 10 THEN '⚠️  MINOR DISCREPANCIES - Review and resolve'
    WHEN total_discrepancy <= 50 THEN '❌ SIGNIFICANT GAPS - Requires attention'
    ELSE '💥 CRITICAL MISALIGNMENT - Do not deploy'
  END as overall_status,
  CASE
    WHEN total_discrepancy = 0 THEN 'Proceed with production deployment'
    WHEN total_discrepancy <= 10 THEN 'Resolve minor discrepancies before deployment'
    WHEN total_discrepancy <= 50 THEN 'Major reconciliation required'
    ELSE 'Complete system review needed'
  END as recommended_action
FROM reconciliation_summary;

-- Action plan based on findings
SELECT
  'ACTION PLAN' as plan_type,
  CASE
    WHEN (
      SELECT COUNT(*)
      FROM expected_agent_counts e
      FULL OUTER JOIN current_agent_counts c ON e.company_name = c.company_name
      WHERE COALESCE(e.expected_count, 0) != COALESCE(c.current_count, 0)
    ) = 0 THEN '✅ No action required - Perfect alignment achieved'
    ELSE 'Resolve discrepancies before production deployment'
  END as primary_action,

  CASE
    WHEN (
      SELECT COUNT(*)
      FROM agents a
      WHERE a.reports_to IS NOT NULL
        AND NOT EXISTS (SELECT 1 FROM agents a2 WHERE a2.name = a.reports_to AND a2.company_id = a.company_id)
    ) = 0 THEN '✅ All hierarchies valid'
    ELSE 'Fix broken reporting relationships'
  END as hierarchy_action,

  CASE
    WHEN (
      SELECT COUNT(*)
      FROM agents
      WHERE NOT (capabilities @> '["task_execution", "communication", "analysis"]')
    ) = 0 THEN '✅ All capabilities standard'
    ELSE 'Standardize agent capabilities'
  END as capabilities_action,

  CASE
    WHEN (
      SELECT COUNT(*)
      FROM agents
      WHERE adapter_config->>'adapter' != 'hermes_local'
         OR adapter_config->>'model' != 'anthropic/claude-opus-4.6'
    ) = 0 THEN '✅ All configurations standard'
    ELSE 'Standardize model configurations'
  END as configuration_action;

-- ============================================================
-- RECONCILIATION COMPLETE
-- Review results above and take appropriate actions
-- ============================================================

-- Final readiness assessment
SELECT
  'PRODUCTION READINESS ASSESSMENT' as assessment_type,
  CASE
    WHEN (
      -- Check for perfect agent count alignment
      SELECT COUNT(*)
      FROM expected_agent_counts e
      FULL OUTER JOIN current_agent_counts c ON e.company_name = c.company_name
      WHERE COALESCE(e.expected_count, 0) != COALESCE(c.current_count, 0)
    ) = 0
    AND (
      -- Check for valid hierarchies
      SELECT COUNT(*)
      FROM agents a
      WHERE a.reports_to IS NOT NULL
        AND NOT EXISTS (SELECT 1 FROM agents a2 WHERE a2.name = a.reports_to AND a2.company_id = a.company_id)
    ) = 0
    AND (
      -- Check for standard capabilities
      SELECT COUNT(*)
      FROM agents
      WHERE NOT (capabilities @> '["task_execution", "communication", "analysis"]')
    ) = 0
    AND (
      -- Check for standard configurations
      SELECT COUNT(*)
      FROM agents
      WHERE adapter_config->>'adapter' != 'hermes_local'
         OR adapter_config->>'model' != 'anthropic/claude-opus-4.6'
    ) = 0 THEN '🚀 PRODUCTION READY - All systems aligned'
    ELSE '⚠️  REQUIRES ATTENTION - Address issues before deployment'
  END as readiness_status,

  CASE
    WHEN (
      SELECT COUNT(*)
      FROM expected_agent_counts e
      FULL OUTER JOIN current_agent_counts c ON e.company_name = c.company_name
      WHERE COALESCE(e.expected_count, 0) != COALESCE(c.current_count, 0)
    ) = 0 THEN 'Agent counts match documentation'
    ELSE 'Agent count discrepancies detected'
  END as agent_count_status,

  CASE
    WHEN (
      SELECT COUNT(*)
      FROM agents a
      WHERE a.reports_to IS NOT NULL
        AND NOT EXISTS (SELECT 1 FROM agents a2 WHERE a2.name = a.reports_to AND a2.company_id = a.company_id)
    ) = 0 THEN 'All hierarchies valid'
    ELSE 'Broken hierarchies detected'
  END as hierarchy_status,

  CASE
    WHEN (
      SELECT COUNT(*)
      FROM agents
      WHERE NOT (capabilities @> '["task_execution", "communication", "analysis"]')
    ) = 0 THEN 'All capabilities standard'
    ELSE 'Non-standard capabilities detected'
  END as capabilities_status,

  CASE
    WHEN (
      SELECT COUNT(*)
      FROM agents
      WHERE adapter_config->>'adapter' != 'hermes_local'
         OR adapter_config->>'model' != 'anthropic/claude-opus-4.6'
    ) = 0 THEN 'All configurations standard'
    ELSE 'Non-standard configurations detected'
  END as configuration_status;

-- ============================================================
-- END OF RECONCILIATION SCRIPT
-- ============================================================