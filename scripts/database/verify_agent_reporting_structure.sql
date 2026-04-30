-- Paperclip Agent Reporting Structure Verification
-- This script verifies that all agents have proper reporting hierarchies
-- and identifies any orphaned agents or missing relationships

-- =============================================================================
-- VERIFICATION QUERIES
-- =============================================================================

-- 1. Check for orphaned agents (agents with invalid reports_to references)
SELECT
    'Orphaned Agents' as check_type,
    a.name as agent_name,
    a.role,
    a.title,
    a.company_id,
    c.name as company_name,
    a.reports_to as invalid_reports_to
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agents boss ON a.reports_to = boss.id
WHERE a.reports_to IS NOT NULL
  AND boss.id IS NULL
ORDER BY c.name, a.name;

-- 2. Check for agents missing model assignments
SELECT
    'Missing Model Assignments' as check_type,
    a.name as agent_name,
    a.role,
    a.title,
    c.name as company_name,
    a.company_id
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
WHERE am.id IS NULL
ORDER BY c.name, a.name;

-- 3. Count agents by company
SELECT
    'Agent Count by Company' as check_type,
    c.name as company_name,
    COUNT(a.id) as agent_count,
    c.issue_prefix
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
WHERE c.status = 'active'
GROUP BY c.name, c.issue_prefix
ORDER BY c.name;

-- 4. View complete agent hierarchy for each company
SELECT
    'Agent Hierarchy' as check_type,
    c.name as company_name,
    a.name as agent_name,
    a.role,
    a.title,
    COALESCE(boss.name, 'CEO/Top Level') as reports_to,
    a.status
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agents boss ON a.reports_to = boss.id
WHERE c.status = 'active'
ORDER BY c.name, a.created_at;

-- 5. Check for duplicate agent names within companies
SELECT
    'Duplicate Agent Names' as check_type,
    company_id,
    a.name as agent_name,
    COUNT(*) as duplicate_count,
    c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
GROUP BY company_id, a.name, c.name
HAVING COUNT(*) > 1
ORDER BY company_id, a.name;

-- 6. Check for CEOs that report to someone (should be NULL)
SELECT
    'CEOs with Reports_To' as check_type,
    a.name as ceo_name,
    a.role,
    c.name as company_name,
    a.reports_to as should_be_null
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.role = 'ceo'
  AND a.reports_to IS NOT NULL
ORDER BY c.name;

-- 7. Check agent permissions structure
SELECT
    'Agent Permissions' as check_type,
    a.name as agent_name,
    c.name as company_name,
    a.permissions
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.status = 'active'
ORDER BY c.name, a.name;

-- 8. Check model assignments summary
SELECT
    'Model Assignments Summary' as check_type,
    c.name as company_name,
    COUNT(DISTINCT a.id) as total_agents,
    COUNT(DISTINCT am.id) as agents_with_models,
    COUNT(DISTINCT a.id) - COUNT(DISTINCT am.id) as missing_models
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
WHERE c.status = 'active'
GROUP BY c.name
ORDER BY c.name;

-- =============================================================================
-- EXPECTED RESULTS SUMMARY
-- =============================================================================

/*
Expected Results for Complete Paperclip Ecosystem:

1. Orphaned Agents: Should return 0 rows
2. Missing Model Assignments: Should return 0 rows
3. Agent Count by Company:
   - ContentForge AI: 16 agents
   - DomainForge AI: 16 agents
   - ExecForge AI: 16 agents
   - MobileForge AI: 10 agents
   - PaperclipForge AI: 16 agents
   - SaaSForge AI: 12 agents
   - VoiceForge AI: 12 agents
   Total: 98 agents

4. Agent Hierarchy: Should show proper org charts for each company
5. Duplicate Agent Names: Should return 0 rows
6. CEOs with Reports_To: Should return 0 rows
7. Agent Permissions: Should show proper JSON permissions for each agent
8. Model Assignments Summary: Should show 0 missing models for all companies
*/

-- =============================================================================
-- QUICK HEALTH CHECK - Run this first
-- =============================================================================

-- Simple count check
SELECT
    COUNT(*) as total_companies,
    SUM(CASE WHEN status = 'active' THEN 1 ELSE 0 END) as active_companies
FROM companies;

SELECT
    COUNT(*) as total_agents,
    COUNT(DISTINCT company_id) as companies_with_agents
FROM agents;

-- Check if all expected companies exist
SELECT
    'Expected Companies Check' as check_type,
    COUNT(*) as companies_found,
    CASE
        WHEN COUNT(*) = 7 THEN 'All 7 companies present'
        ELSE 'Missing companies - check setup'
    END as status
FROM companies
WHERE name IN (
    'PaperclipForge AI',
    'ContentForge AI',
    'MobileForge AI',
    'ExecForge AI',
    'SaaSForge AI',
    'VoiceForge AI',
    'DomainForge AI'
);