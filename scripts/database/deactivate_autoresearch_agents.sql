-- ============================================================================
-- DEACTIVATE AUTORESEARCH AGENTS IN LEARNINGFORGE AI
-- Generated: 2026-04-12
-- Reason: Decision not to use Karpathy's AutoResearch methodology
-- ============================================================================

-- NOTE: This is a SOFT DELETE operation - agents are deactivated, not deleted
-- Can be reversed if needed (see rollback plan in report)

BEGIN;

-- Step 1: Verify agents exist before deactivation
SELECT 
    a.id,
    a.name,
    a.is_active,
    a.reports_to,
    c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Learning Forge AI'
  AND a.name IN (
    'AutoResearch Skills Enhancer',
    'AutoResearch Literature Scanner',
    'AutoResearch Gap Analyzer'
  )
ORDER BY a.name;

-- Step 2: Check API keys status
SELECT 
    a.name as agent_name,
    aak.id as api_key_id,
    aak.name as key_name,
    aak.created_at,
    aak.revoked_at
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.name = 'Learning Forge AI'
  AND a.name IN (
    'AutoResearch Skills Enhancer',
    'AutoResearch Literature Scanner',
    'AutoResearch Gap Analyzer'
  );

-- Step 3: Deactivate agents (soft delete)
UPDATE agents
SET 
    is_active = false,
    updated_at = NOW()
WHERE id IN (
    SELECT a.id
    FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'Learning Forge AI'
      AND a.name IN (
        'AutoResearch Skills Enhancer',
        'AutoResearch Literature Scanner',
        'AutoResearch Gap Analyzer'
      )
)
RETURNING id, name, is_active, updated_at;

-- Step 4: Revoke API keys
UPDATE agent_api_keys
SET revoked_at = NOW()
WHERE agent_id IN (
    SELECT a.id
    FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'Learning Forge AI'
      AND a.name IN (
        'AutoResearch Skills Enhancer',
        'AutoResearch Literature Scanner',
        'AutoResearch Gap Analyzer'
      )
)
AND revoked_at IS NULL
RETURNING id, name, revoked_at;

-- Step 5: Verification - Show final status
SELECT 
    a.name as agent_name,
    a.is_active,
    aak.revoked_at as api_key_revoked
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.name = 'Learning Forge AI'
  AND a.name IN (
    'AutoResearch Skills Enhancer',
    'AutoResearch Literature Scanner',
    'AutoResearch Gap Analyzer'
  )
ORDER BY a.name;

COMMIT;

-- ============================================================================
-- EXPECTED RESULTS AFTER EXECUTION:
-- - 3 agents deactivated (is_active = false)
-- - 3 API keys revoked (revoked_at set to NOW())
-- ============================================================================
