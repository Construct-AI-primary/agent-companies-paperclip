-- ============================================================
-- UPDATE AGENT TITLE TEMPLATE
-- Purpose: Fix agent human names (title field) for reconciliation
-- Created: 2026-04-25
-- Version: 1.0
-- ============================================================
--
-- IMPORTANT SCHEMA NOTES:
-- 1. The 'agents' table has TWO name fields:
--    - 'name' = agent identifier (e.g., "infraforge-ai-infraforge-db-specialist")
--    - 'title' = human-readable name (e.g., "DB Specialist")
-- 2. DO NOT confuse 'name' with 'slug' - 'slug' does not exist in the schema
-- 3. Always use 'name' for lookups, 'title' for human names
--
-- VALID COLUMNS in agents table:
--   id, company_id, name, role, title, status, reports_to,
--   capabilities, adapter_type, adapter_config, budget_monthly_cents,
--   spent_monthly_cents, is_active, model_config, runtime_config,
--   permissions, metadata, created_at, updated_at
--
-- REQUIRED: Run CHECK-column-existence.sql before executing this template
-- ============================================================

-- ============================================================
-- PRE-FLIGHT VALIDATION
-- Run this first to verify the target column exists
-- ============================================================
/*
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_name = 'agents'
  AND column_name IN ('name', 'title', 'id')
ORDER BY ordinal_position;
*/

-- ============================================================
-- TEMPLATE: UPDATE agent title by agent name identifier
-- ============================================================

-- Step 1: Verify agent exists before updating
SELECT 
  id,
  name,           -- agent identifier (DO NOT confuse with 'slug')
  title,          -- human-readable name
  role,
  status,
  company_id
FROM agents
WHERE name = '{AGENT_NAME_IDENTIFIER}'
LIMIT 1;

-- Step 2: Update the title (human-readable name)
-- NOTE: 'name' field is the identifier, 'title' is the human name
UPDATE agents
SET 
  title = '{NEW_TITLE_VALUE}',
  updated_at = NOW()
WHERE name = '{AGENT_NAME_IDENTIFIER}'
RETURNING 
  id,
  name,
  title,
  updated_at;

-- Step 3: Verify the update
SELECT 
  id,
  name AS agent_identifier,
  title AS human_name,
  status
FROM agents
WHERE name = '{AGENT_NAME_IDENTIFIER}';

-- ============================================================
-- BULK TEMPLATE: Update multiple agent titles
-- ============================================================

-- Example: Update 13 domainforge-ai agents from reconciliation
BEGIN;

-- Validate all agents exist before making changes
DO $$
DECLARE
  v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM agents
  WHERE name IN (
    'domainforge-ai-domainforge-ai-procurement',
    'domainforge-ai-domainforge-ai-contracts-pre-award',
    'domainforge-ai-domainforge-ai-contracts-post-award',
    'domainforge-ai-domainforge-ai-sales',
    'domainforge-ai-domainforge-ai-hr',
    'domainforge-ai-domainforge-ai-project-controls',
    'domainforge-ai-domainforge-ai-document-control',
    'domainforge-ai-domainforge-ai-logistics',
    'domainforge-ai-domainforge-ai-ethics',
    'domainforge-ai-domainforge-ai-legal',
    'domainforge-ai-domainforge-ai-commercial',
    'domainforge-ai-domainforge-ai-construction-director',
    'domainforge-ai-domainforge-ai-contracts-director'
  );
  
  IF v_count != 13 THEN
    RAISE WARNING 'Expected 13 agents, found %. Proceeding anyway...', v_count;
  END IF;
END $$;

-- Perform the updates
UPDATE agents SET title = 'Procurement'          WHERE name = 'domainforge-ai-domainforge-ai-procurement';
UPDATE agents SET title = 'Contracts Pre-Award'   WHERE name = 'domainforge-ai-domainforge-ai-contracts-pre-award';
UPDATE agents SET title = 'Contracts Post-Award'  WHERE name = 'domainforge-ai-domainforge-ai-contracts-post-award';
UPDATE agents SET title = 'Sales'                WHERE name = 'domainforge-ai-domainforge-ai-sales';
UPDATE agents SET title = 'HR'                   WHERE name = 'domainforge-ai-domainforge-ai-hr';
UPDATE agents SET title = 'Project Controls'     WHERE name = 'domainforge-ai-domainforge-ai-project-controls';
UPDATE agents SET title = 'Document Control'    WHERE name = 'domainforge-ai-domainforge-ai-document-control';
UPDATE agents SET title = 'Logistics'            WHERE name = 'domainforge-ai-domainforge-ai-logistics';
UPDATE agents SET title = 'Ethics'              WHERE name = 'domainforge-ai-domainforge-ai-ethics';
UPDATE agents SET title = 'Legal'               WHERE name = 'domainforge-ai-domainforge-ai-legal';
UPDATE agents SET title = 'Commercial'         WHERE name = 'domainforge-ai-domainforge-ai-commercial';
UPDATE agents SET title = 'Construction Director' WHERE name = 'domainforge-ai-domainforge-ai-construction-director';
UPDATE agents SET title = 'Contracts Director' WHERE name = 'domainforge-ai-domainforge-ai-contracts-director';

-- Verify all updates
SELECT 
  name AS agent_identifier,
  title AS human_name,
  role,
  status
FROM agents
WHERE name LIKE 'domainforge-ai-domainforge-ai-%'
ORDER BY title;

COMMIT;

-- ============================================================
-- PLACEHOLDER REFERENCE
-- ============================================================
-- {AGENT_NAME_IDENTIFIER} - The 'name' field value (identifier, not slug)
--   Example: "infraforge-ai-infraforge-db-specialist"
-- {NEW_TITLE_VALUE} - The new 'title' field value (human-readable)
--   Example: "DB Specialist"
--
-- COMMON MISTAKE TO AVOID:
--   ❌ WRONG: UPDATE agents SET slug = 'New Name' WHERE ...
--   ✅ RIGHT: UPDATE agents SET title = 'New Name' WHERE ...
--
--   The 'slug' column does NOT exist in the agents table!
-- ============================================================
