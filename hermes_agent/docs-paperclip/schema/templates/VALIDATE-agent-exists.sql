-- ============================================================
-- VALIDATE AGENT EXISTS TEMPLATE
-- Purpose: Verify agent exists before modification operations
-- Created: 2026-04-25
-- Version: 1.0
-- ============================================================
--
-- This template provides queries to validate agent existence
-- BEFORE executing UPDATE/DELETE operations. Prevents errors
-- from operating on non-existent agents.
--
-- IMPORTANT: This is a READ-ONLY validation template
-- ============================================================

-- ============================================================
-- SECTION 1: Validate by agent NAME (identifier)
-- ============================================================
-- Use this when you know the agent 'name' field value

SELECT 
  a.id,
  a.name AS agent_identifier,      -- This is the lookup field
  a.title AS human_name,            -- Human-readable name
  a.role,
  a.status,
  a.is_active,
  a.company_id,
  c.name AS company_name,
  a.created_at,
  a.updated_at,
  -- Check for related records
  (SELECT COUNT(*) FROM agent_api_keys aak WHERE aak.agent_id = a.id AND aak.revoked_at IS NULL) AS active_api_keys,
  (SELECT COUNT(*) FROM agent_models am WHERE am.agent_id = a.name) AS model_assignments
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.name = '{AGENT_NAME_IDENTIFIER}'
LIMIT 1;

-- ============================================================
-- SECTION 2: Validate by agent ID (UUID)
-- ============================================================
-- Use this when you know the agent UUID

SELECT 
  a.id AS agent_id,
  a.name AS agent_identifier,
  a.title AS human_name,
  a.role,
  a.status,
  a.is_active,
  a.company_id,
  c.name AS company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.id = '{AGENT_ID_UUID}'
LIMIT 1;

-- ============================================================
-- SECTION 3: Validate by company + partial name match
-- ============================================================
-- Use this when searching for agents within a company

SELECT 
  a.id,
  a.name AS agent_identifier,
  a.title AS human_name,
  a.role,
  a.status
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = '{COMPANY_NAME}'
  AND (a.name LIKE '%{SEARCH_TERM}%' OR a.title LIKE '%{SEARCH_TERM}%')
ORDER BY a.name
LIMIT 50;

-- ============================================================
-- SECTION 4: Bulk validation (for batch operations)
-- ============================================================
-- Use this to validate multiple agents before batch update

SELECT 
  a.name AS agent_identifier,
  a.title AS human_name,
  CASE 
    WHEN a.id IS NOT NULL THEN 'FOUND'
    ELSE 'NOT_FOUND'
  END AS validation_status,
  a.id,
  a.status,
  a.is_active
FROM (
  VALUES 
    ('{AGENT_NAME_1}'),
    ('{AGENT_NAME_2}'),
    ('{AGENT_NAME_3}')
) AS search_terms(agent_name)
LEFT JOIN agents a ON a.name = search_terms.agent_name
ORDER BY search_terms.agent_name;

-- ============================================================
-- SECTION 5: Find agents by naming convention violation
-- ============================================================
-- Use this to find agents that violate naming rules

-- Rule 1: Name length > 22 characters (human_name limit)
SELECT 
  name AS agent_identifier,
  title AS human_name,
  LENGTH(title) AS title_length,
  CASE 
    WHEN LENGTH(title) > 22 THEN 'VIOLATION: too long'
    ELSE 'OK'
  END AS validation_status
FROM agents
WHERE LENGTH(title) > 22
ORDER BY LENGTH(title) DESC;

-- Rule 2: Name contains pattern that doesn't match company slug
SELECT 
  a.name AS agent_identifier,
  a.title AS human_name,
  c.name AS company_name,
  CASE 
    WHEN a.name NOT LIKE c.slug || '-%' THEN 'VIOLATION: name prefix mismatch'
    ELSE 'OK'
  END AS naming_validation
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.name NOT LIKE c.slug || '-%'
ORDER BY c.name, a.name;

-- ============================================================
-- SECTION 6: Pre-modification checklist
-- ============================================================
-- Use this to verify agent is ready for modification

DO $$
DECLARE
  v_agent_id UUID;
  v_agent_name TEXT;
  v_agent_status TEXT;
  v_active_keys INTEGER;
  v_models INTEGER;
BEGIN
  -- Check agent exists
  SELECT id, name, status INTO v_agent_id, v_agent_name, v_agent_status
  FROM agents
  WHERE name = '{AGENT_NAME_IDENTIFIER}';
  
  IF v_agent_id IS NULL THEN
    RAISE WARNING 'AGENT NOT FOUND: %', '{AGENT_NAME_IDENTIFIER}';
    RAISE EXCEPTION 'Cannot proceed - agent does not exist';
  END IF;
  
  -- Check API keys
  SELECT COUNT(*) INTO v_active_keys
  FROM agent_api_keys
  WHERE agent_id = v_agent_id AND revoked_at IS NULL;
  
  -- Check model assignments
  SELECT COUNT(*) INTO v_models
  FROM agent_models
  WHERE agent_id = v_agent_name;  -- Note: agent_models uses TEXT for agent_id
  
  RAISE NOTICE 'Agent: %', v_agent_name;
  RAISE NOTICE 'Status: %', v_agent_status;
  RAISE NOTICE 'Active API Keys: %', v_active_keys;
  RAISE NOTICE 'Model Assignments: %', v_models;
  
  -- Validation rules for modification readiness
  IF v_agent_status = 'deleted' THEN
    RAISE WARNING 'Agent is marked as deleted. Verify this is intentional.';
  END IF;
  
  IF v_active_keys = 0 THEN
    RAISE NOTICE 'WARNING: Agent has no active API keys';
  END IF;
  
  IF v_models = 0 THEN
    RAISE NOTICE 'WARNING: Agent has no model assignments';
  END IF;
  
END $$;

-- ============================================================
-- SECTION 7: Generate modification report
-- ============================================================
-- Use this to generate a full report for audit purposes

SELECT 
  'VALIDATION_REPORT' AS report_type,
  NOW() AS generated_at,
  COUNT(*) AS total_agents_checked,
  COUNT(CASE WHEN id IS NOT NULL THEN 1 END) AS agents_found,
  COUNT(CASE WHEN id IS NULL THEN 1 END) AS agents_not_found,
  COUNT(DISTINCT company_id) AS companies_represented
FROM (
  SELECT NULL AS id, NULL AS company_id
  WHERE FALSE  -- Force empty, replace with actual lookup
  --
  -- To use: Replace the above with:
  -- SELECT id, company_id FROM agents WHERE name IN ('{AGENT_1}', '{AGENT_2}', ...)
) AS agent_lookup;

-- ============================================================
-- PLACEHOLDER REFERENCE
-- ============================================================
-- {AGENT_NAME_IDENTIFIER} - The 'name' field value (identifier)
--   Example: "infraforge-ai-infraforge-db-specialist"
-- {AGENT_ID_UUID} - The UUID from agents.id
--   Example: "550e8400-e29b-41d4-a716-446655440000"
-- {COMPANY_NAME} - Full company name
--   Example: "InfraForge AI"
-- {SEARCH_TERM} - Partial name to search for
--   Example: "database"
-- {AGENT_NAME_1}, {AGENT_NAME_2}, etc. - For bulk validation
-- ============================================================
