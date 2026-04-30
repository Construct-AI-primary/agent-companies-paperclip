-- ============================================================
-- PAPERCLIP ECOSYSTEM POST-DEPLOYMENT TESTING SCRIPT
-- Date: 2026-04-22
-- Purpose: Comprehensive validation of production deployment
-- Tests: Agent creation, relationships, configurations, functionality
-- ============================================================

-- ============================================================
-- TEST 1: BASIC AGENT COUNT VERIFICATION
-- Expected: 454 total agents
-- ============================================================

SELECT 'TEST 1: Total Agent Count' as test_name;
SELECT COUNT(*) as total_agents FROM agents;

-- ============================================================
-- TEST 2: COMPANY AGENT DISTRIBUTION
-- Expected: Specific counts per company
-- ============================================================

SELECT 'TEST 2: Company Agent Distribution' as test_name;
SELECT
  c.name as company_name,
  COUNT(a.id) as agent_count,
  CASE
    WHEN c.name = 'DevForge AI' AND COUNT(a.id) = 59 THEN '✅ PASS'
    WHEN c.name = 'ContentForge AI' AND COUNT(a.id) = 17 THEN '✅ PASS'
    WHEN c.name = 'DomainForge AI' AND COUNT(a.id) = 66 THEN '✅ PASS'
    WHEN c.name = 'ExecForge AI' AND COUNT(a.id) = 18 THEN '✅ PASS'
    WHEN c.name = 'InfraForge AI' AND COUNT(a.id) = 6 THEN '✅ PASS'
    WHEN c.name = 'IntegrateForge AI' AND COUNT(a.id) = 21 THEN '✅ PASS'
    WHEN c.name = 'LearningForge AI' AND COUNT(a.id) = 50 THEN '✅ PASS'
    WHEN c.name = 'Loopy AI' AND COUNT(a.id) = 6 THEN '✅ PASS'
    WHEN c.name = 'PaperclipForge AI' AND COUNT(a.id) = 33 THEN '✅ PASS'
    WHEN c.name = 'PromptForge AI' AND COUNT(a.id) = 24 THEN '✅ PASS'
    WHEN c.name = 'QualityForge AI' AND COUNT(a.id) = 42 THEN '✅ PASS'
    WHEN c.name = 'VoiceForge AI' AND COUNT(a.id) = 12 THEN '✅ PASS'
    WHEN c.name = 'KnowledgeForge AI' AND COUNT(a.id) = 74 THEN '✅ PASS'
    ELSE '❌ FAIL'
  END as status
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
GROUP BY c.id, c.name
ORDER BY c.name;

-- ============================================================
-- TEST 3: AGENT STATUS DISTRIBUTION
-- Expected: All agents in 'idle' status initially
-- ============================================================

SELECT 'TEST 3: Agent Status Distribution' as test_name;
SELECT
  status,
  COUNT(*) as count,
  CASE
    WHEN status = 'idle' THEN '✅ PASS - Agents ready for activation'
    WHEN status = 'active' THEN '⚠️  WARN - Some agents already active'
    WHEN status = 'error' THEN '❌ FAIL - Agents in error state'
    ELSE '❓ UNKNOWN'
  END as status_check
FROM agents
GROUP BY status
ORDER BY status;

-- ============================================================
-- TEST 4: MODEL CONFIGURATION VERIFICATION
-- Expected: All agents using hermes_local with claude-opus-4.6
-- ============================================================

SELECT 'TEST 4: Model Configuration Verification' as test_name;
SELECT
  adapter_config->>'adapter' as adapter,
  adapter_config->>'model' as model,
  COUNT(*) as count,
  CASE
    WHEN adapter_config->>'adapter' = 'hermes_local' AND adapter_config->>'model' = 'anthropic/claude-opus-4.6' THEN '✅ PASS'
    ELSE '❌ FAIL'
  END as status
FROM agents
GROUP BY adapter_config->>'adapter', adapter_config->>'model'
ORDER BY count DESC;

-- ============================================================
-- TEST 5: REPORTING HIERARCHY VALIDATION
-- Expected: Proper hierarchical relationships
-- ============================================================

SELECT 'TEST 5: Reporting Hierarchy Validation' as test_name;
SELECT
  a.name as agent_name,
  a.reports_to as reports_to,
  c.name as company_name,
  CASE
    WHEN a.reports_to IS NULL THEN '✅ PASS - Top-level agent'
    WHEN a.reports_to IS NOT NULL AND EXISTS (SELECT 1 FROM agents a2 WHERE a2.name = a.reports_to AND a2.company_id = a.company_id) THEN '✅ PASS - Valid hierarchy'
    ELSE '❌ FAIL - Broken hierarchy'
  END as hierarchy_status
FROM agents a
JOIN companies c ON a.company_id = c.id
ORDER BY c.name, a.name
LIMIT 20; -- Sample of first 20 agents

-- ============================================================
-- TEST 6: CAPABILITIES VERIFICATION
-- Expected: All agents have standard capabilities
-- ============================================================

SELECT 'TEST 6: Capabilities Verification' as test_name;
SELECT
  a.name as agent_name,
  c.name as company_name,
  a.capabilities,
  CASE
    WHEN a.capabilities @> '["task_execution", "communication", "analysis"]' THEN '✅ PASS'
    ELSE '❌ FAIL'
  END as capabilities_status
FROM agents a
JOIN companies c ON a.company_id = c.id
ORDER BY c.name, a.name
LIMIT 20; -- Sample validation

-- ============================================================
-- TEST 7: UNIQUE CONSTRAINT VALIDATION
-- Expected: No duplicate agent names within companies
-- ============================================================

SELECT 'TEST 7: Unique Agent Names per Company' as test_name;
SELECT
  company_id,
  name,
  COUNT(*) as duplicate_count,
  CASE
    WHEN COUNT(*) = 1 THEN '✅ PASS'
    ELSE '❌ FAIL - Duplicate names'
  END as uniqueness_status
FROM agents
GROUP BY company_id, name
HAVING COUNT(*) > 1
ORDER BY company_id, name;

-- ============================================================
-- TEST 8: DATA INTEGRITY CHECKS
-- Expected: All required fields populated
-- ============================================================

SELECT 'TEST 8: Data Integrity Checks' as test_name;
SELECT
  COUNT(*) as total_agents,
  COUNT(CASE WHEN name IS NULL OR name = '' THEN 1 END) as missing_names,
  COUNT(CASE WHEN role IS NULL OR role = '' THEN 1 END) as missing_roles,
  COUNT(CASE WHEN title IS NULL OR title = '' THEN 1 END) as missing_titles,
  COUNT(CASE WHEN adapter_config IS NULL THEN 1 END) as missing_configs,
  CASE
    WHEN COUNT(CASE WHEN name IS NULL OR name = '' THEN 1 END) = 0
     AND COUNT(CASE WHEN role IS NULL OR role = '' THEN 1 END) = 0
     AND COUNT(CASE WHEN title IS NULL OR title = '' THEN 1 END) = 0
     AND COUNT(CASE WHEN adapter_config IS NULL THEN 1 END) = 0
    THEN '✅ PASS - All required fields populated'
    ELSE '❌ FAIL - Missing required fields'
  END as integrity_status
FROM agents;

-- ============================================================
-- TEST 9: COMPANY CROSS-REFERENCES
-- Expected: All agents properly linked to companies
-- ============================================================

SELECT 'TEST 9: Company Cross-References' as test_name;
SELECT
  COUNT(a.id) as agents_with_companies,
  COUNT(CASE WHEN c.id IS NULL THEN 1 END) as orphaned_agents,
  CASE
    WHEN COUNT(CASE WHEN c.id IS NULL THEN 1 END) = 0 THEN '✅ PASS - All agents linked to companies'
    ELSE '❌ FAIL - Orphaned agents detected'
  END as company_link_status
FROM agents a
LEFT JOIN companies c ON a.company_id = c.id;

-- ============================================================
-- TEST 10: PERFORMANCE METRICS
-- Expected: Reasonable creation timestamps
-- ============================================================

SELECT 'TEST 10: Performance Metrics' as test_name;
SELECT
  COUNT(*) as total_agents,
  MIN(created_at) as earliest_creation,
  MAX(created_at) as latest_creation,
  EXTRACT(EPOCH FROM (MAX(created_at) - MIN(created_at))) as deployment_duration_seconds,
  CASE
    WHEN EXTRACT(EPOCH FROM (MAX(created_at) - MIN(created_at))) < 300 THEN '✅ PASS - Fast deployment'
    WHEN EXTRACT(EPOCH FROM (MAX(created_at) - MIN(created_at))) < 600 THEN '⚠️  WARN - Moderate deployment time'
    ELSE '❌ FAIL - Slow deployment'
  END as performance_status
FROM agents
WHERE created_at >= CURRENT_DATE; -- Only check today's deployments

-- ============================================================
-- TEST 11: ATLAS AGENT CREATOR VALIDATION
-- Expected: Specific agents created by Atlas system
-- ============================================================

SELECT 'TEST 11: Atlas Agent Creator Validation' as test_name;
SELECT
  'KnowledgeForge AI agents created' as metric,
  COUNT(*) as count,
  CASE WHEN COUNT(*) >= 40 THEN '✅ PASS' ELSE '❌ FAIL' END as status
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'KnowledgeForge AI'

UNION ALL

SELECT
  'LearningForge AI agents created' as metric,
  COUNT(*) as count,
  CASE WHEN COUNT(*) >= 45 THEN '✅ PASS' ELSE '❌ FAIL' END as status
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'LearningForge AI';

-- ============================================================
-- TEST 12: SYSTEM READINESS CHECK
-- Expected: All systems ready for operation
-- ============================================================

SELECT 'TEST 12: System Readiness Check' as test_name;
WITH system_metrics AS (
  SELECT
    COUNT(*) as total_agents,
    COUNT(CASE WHEN status = 'idle' THEN 1 END) as idle_agents,
    COUNT(CASE WHEN adapter_config->>'adapter' = 'hermes_local' THEN 1 END) as hermes_agents,
    COUNT(CASE WHEN capabilities @> '["task_execution", "communication", "analysis"]' THEN 1 END) as capable_agents
  FROM agents
)
SELECT
  total_agents,
  idle_agents,
  hermes_agents,
  capable_agents,
  CASE
    WHEN total_agents = 454
     AND idle_agents = total_agents
     AND hermes_agents = total_agents
     AND capable_agents = total_agents
    THEN '✅ PASS - System fully ready for production'
    ELSE '❌ FAIL - System not ready'
  END as system_readiness
FROM system_metrics;

-- ============================================================
-- DEPLOYMENT VALIDATION COMPLETE
-- Summary: Run all tests above and verify ✅ PASS results
-- ============================================================

-- Final deployment summary
SELECT
  'DEPLOYMENT SUMMARY' as report_type,
  COUNT(*) as total_agents_deployed,
  COUNT(DISTINCT company_id) as companies_populated,
  MAX(created_at) as deployment_completion_time,
  CASE
    WHEN COUNT(*) = 454 THEN '🎯 100% SUCCESS - Full ecosystem deployed'
    ELSE '⚠️ PARTIAL - Review deployment logs'
  END as deployment_status
FROM agents;