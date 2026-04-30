-- ==========================================
-- MODEL ASSIGNMENT SPECIALIST VERIFICATION
-- Created: 2026-04-24
-- Description: Verify SparkAssign agent registration and setup
-- ==========================================

-- ==========================================
-- COMPREHENSIVE VERIFICATION QUERIES
-- ==========================================

-- 1. Agent Registration Verification
SELECT
    '🔍 AGENT REGISTRATION CHECK' as check_type,
    CASE
        WHEN COUNT(*) = 1 THEN '✅ SUCCESS: Agent registered'
        WHEN COUNT(*) = 0 THEN '❌ FAILED: Agent not found'
        ELSE '⚠️ WARNING: Multiple agents found'
    END as status,
    COUNT(*) as count,
    'Expected: 1' as expected
FROM agents
WHERE name = 'paperclipforge-ai-model-assignment-specialist'
    AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI' AND status = 'active')
    AND is_active = true;

-- 2. Agent Details Verification
SELECT
    '📋 AGENT DETAILS' as section,
    a.id as agent_id,
    a.name as agent_name,
    a.title,
    a.role,
    a.status,
    c.name as company_name,
    a.adapter_type,
    a.is_active,
    a.created_at,
    a.updated_at
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.name = 'paperclipforge-ai-model-assignment-specialist'
    AND c.name = 'PaperclipForge AI';

-- 3. Capabilities Verification
SELECT
    '🛠️ AGENT CAPABILITIES' as section,
    jsonb_array_length(capabilities::jsonb) as total_capabilities,
    (capabilities::jsonb)->0 as first_capability,
    (capabilities::jsonb)->(jsonb_array_length(capabilities::jsonb) - 1) as last_capability,
    LEFT(capabilities::text, 100) || CASE WHEN LENGTH(capabilities::text) > 100 THEN '...' ELSE '' END as capabilities_preview
FROM agents
WHERE name = 'paperclipforge-ai-model-assignment-specialist'
    AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI' AND status = 'active');

-- 4. API Key Verification
SELECT
    '🔑 API KEY CHECK' as check_type,
    CASE
        WHEN COUNT(*) = 1 THEN '✅ SUCCESS: API key created'
        WHEN COUNT(*) = 0 THEN '❌ FAILED: No API key found'
        ELSE '⚠️ WARNING: Multiple API keys found'
    END as status,
    COUNT(*) as count,
    'Expected: 1' as expected
FROM agent_api_keys aak
JOIN agents a ON aak.agent_id = a.id
WHERE a.name = 'paperclipforge-ai-model-assignment-specialist'
    AND aak.revoked_at IS NULL;

-- 5. API Key Details
SELECT
    '🔐 API KEY DETAILS' as section,
    aak.id as key_id,
    aak.name as key_name,
    LEFT(aak.api_key, 10) || '...' as api_key_preview,
    LEFT(aak.key_hash, 10) || '...' as key_hash_preview,
    aak.created_at,
    aak.last_used_at,
    aak.revoked_at
FROM agent_api_keys aak
JOIN agents a ON aak.agent_id = a.id
WHERE a.name = 'paperclipforge-ai-model-assignment-specialist'
ORDER BY aak.created_at DESC
LIMIT 1;

-- 6. Model Assignments Verification
SELECT
    '🤖 MODEL ASSIGNMENTS CHECK' as check_type,
    CASE
        WHEN COUNT(*) >= 1 THEN '✅ SUCCESS: Model assignments created'
        WHEN COUNT(*) = 0 THEN '❌ FAILED: No model assignments found'
        ELSE '✅ SUCCESS: Multiple model assignments found'
    END as status,
    COUNT(*) as count,
    'Expected: 1-2 (primary ± fallback)' as expected
FROM agent_models
WHERE agent_id = 'paperclipforge-ai-model-assignment-specialist'
    AND is_active = true;

-- 7. Model Assignment Details
SELECT
    '⚙️ MODEL ASSIGNMENT DETAILS' as section,
    am.agent_id,
    am.model_id,
    am.assignment_type,
    am.priority,
    am.temperature,
    am.max_tokens,
    am.assigned_by,
    LEFT(am.reason, 50) || CASE WHEN LENGTH(am.reason) > 50 THEN '...' ELSE '' END as reason_preview,
    am.is_active,
    am.created_at,
    am.updated_at
FROM agent_models am
WHERE am.agent_id = 'paperclipforge-ai-model-assignment-specialist'
    AND am.is_active = true
ORDER BY am.priority;

-- 8. Activity Log Verification
SELECT
    '📝 ACTIVITY LOG CHECK' as check_type,
    CASE
        WHEN COUNT(*) >= 1 THEN '✅ SUCCESS: Activity logged'
        WHEN COUNT(*) = 0 THEN '⚠️ WARNING: No activity logged'
        ELSE '✅ SUCCESS: Multiple activities logged'
    END as status,
    COUNT(*) as count,
    'Expected: 1+' as expected
FROM activity_log al
WHERE al.action = 'create'
    AND al.entity_type = 'agent'
    AND al.details->>'description' LIKE '%SparkAssign%';

-- 9. Activity Log Details
SELECT
    '📜 ACTIVITY LOG DETAILS' as section,
    al.id as log_id,
    al.action,
    al.entity_type,
    al.actor_type,
    al.actor_id,
    al.details->>'description' as description,
    al.details->>'team' as team,
    al.details->>'created_by_procedure' as procedure,
    al.created_at
FROM activity_log al
WHERE al.action = 'create'
    AND al.entity_type = 'agent'
    AND al.details->>'description' LIKE '%SparkAssign%'
ORDER BY al.created_at DESC
LIMIT 1;

-- 10. Reports-To Relationship Verification
SELECT
    '👔 REPORTS-TO RELATIONSHIP' as section,
    a.name as agent_name,
    a.title as agent_title,
    manager.name as manager_name,
    manager.title as manager_title,
    c.name as company_name
FROM agents a
LEFT JOIN agents manager ON a.reports_to = manager.id
JOIN companies c ON a.company_id = c.id
WHERE a.name = 'paperclipforge-ai-model-assignment-specialist'
    AND c.name = 'PaperclipForge AI';

-- 11. Company Relationship Verification
SELECT
    '🏢 COMPANY RELATIONSHIP' as section,
    a.name as agent_name,
    c.name as company_name,
    c.status as company_status,
    a.company_id
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.name = 'paperclipforge-ai-model-assignment-specialist';

-- 12. Budget and Runtime Configuration
SELECT
    '💰 BUDGET & CONFIGURATION' as section,
    a.name as agent_name,
    a.budget_monthly_cents,
    a.spent_monthly_cents,
    a.model_config,
    a.runtime_config,
    a.permissions
FROM agents a
WHERE a.name = 'paperclipforge-ai-model-assignment-specialist'
    AND a.company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI' AND status = 'active');

-- 13. Metadata Verification
SELECT
    '📊 METADATA CHECK' as section,
    a.name as agent_name,
    a.metadata->>'agent_slug' as agent_slug,
    a.metadata->>'team' as team,
    jsonb_array_length((a.metadata->'skills')::jsonb) as skills_count,
    (a.metadata->'skills'->0)::text as first_skill,
    (a.metadata->'skills'->(jsonb_array_length((a.metadata->'skills')::jsonb) - 1))::text as last_skill,
    LEFT(a.metadata::text, 150) || CASE WHEN LENGTH(a.metadata::text) > 150 THEN '...' ELSE '' END as metadata_preview
FROM agents a
WHERE a.name = 'paperclipforge-ai-model-assignment-specialist'
    AND a.company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI' AND status = 'active');

-- ==========================================
-- SUMMARY REPORT
-- ==========================================

SELECT
    '📊 REGISTRATION SUMMARY' as summary,
    COUNT(DISTINCT a.id) as agents_created,
    COUNT(DISTINCT aak.id) as api_keys_created,
    COUNT(DISTINCT am.id) as model_assignments_created,
    COUNT(DISTINCT al.id) as activity_logs_created,
    CASE
        WHEN COUNT(DISTINCT a.id) = 1
             AND COUNT(DISTINCT aak.id) >= 1
             AND COUNT(DISTINCT am.id) >= 1 THEN '✅ COMPLETE SUCCESS'
        WHEN COUNT(DISTINCT a.id) = 1 THEN '⚠️ PARTIAL SUCCESS (missing components)'
        ELSE '❌ REGISTRATION FAILED'
    END as overall_status
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id AND aak.revoked_at IS NULL
LEFT JOIN agent_models am ON a.name = am.agent_id AND am.is_active = true
LEFT JOIN activity_log al ON al.entity_id = a.id AND al.action = 'create' AND al.entity_type = 'agent'
WHERE a.name = 'paperclipforge-ai-model-assignment-specialist'
    AND a.company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI' AND status = 'active');

-- ==========================================
-- VERIFICATION COMPLETE
-- ==========================================

-- Expected Results Summary:
-- ✅ Agent: 1 record in agents table
-- ✅ API Keys: 1+ active keys in agent_api_keys table
-- ✅ Models: 1-2 assignments in agent_models table (primary ± fallback)
-- ✅ Activity: 1+ log entries in activity_log table
-- ✅ Relationships: Proper company and manager linkages
-- ✅ Configuration: Complete metadata and runtime config
--
-- Overall Status should be: ✅ COMPLETE SUCCESS