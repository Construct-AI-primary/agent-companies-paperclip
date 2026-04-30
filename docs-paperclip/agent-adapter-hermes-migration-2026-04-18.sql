-- =============================================================================
-- HERMES ADAPTER MIGRATION - 2026-04-18
-- =============================================================================
-- Purpose: Change all agent adapters to hermes_local for Hermes integration
-- Backup: agents table before migration
-- =============================================================================

-- =============================================================================
-- STEP 1: CREATE BACKUP TABLE
-- =============================================================================

-- Drop existing backup tables if they exist (from previous runs)
DROP TABLE IF EXISTS agents_backup_20260418;
DROP TABLE IF EXISTS agent_api_keys_backup_20260418;

-- Create fresh backup of agents table with current adapter types
CREATE TABLE agents_backup_20260418 AS
SELECT 
    id,
    company_id,
    name,
    adapter_type,
    adapter_config,
    created_at,
    updated_at,
    'pre-hermes-migration' as migration_note
FROM agents;

-- Create fresh backup of agent_api_keys table
CREATE TABLE agent_api_keys_backup_20260418 AS
SELECT * FROM agent_api_keys;

-- Add comment to backup tables
COMMENT ON TABLE agents_backup_20260418 IS 'Backup of agents table before hermes_local adapter migration - created 2026-04-18';
COMMENT ON TABLE agent_api_keys_backup_20260418 IS 'Backup of agent_api_keys table before hermes_local adapter migration - created 2026-04-18';

-- Verify backup
SELECT 'Backup created: agents_backup_20260418' as status, COUNT(*) as record_count FROM agents_backup_20260418;
SELECT 'Backup created: agent_api_keys_backup_20260418' as status, COUNT(*) as record_count FROM agent_api_keys_backup_20260418;

-- =============================================================================
-- STEP 2: CHECK CURRENT ADAPTER TYPES
-- =============================================================================

-- Current adapter type distribution
SELECT 
    adapter_type, 
    COUNT(*) as agent_count 
FROM agents 
GROUP BY adapter_type 
ORDER BY agent_count DESC;

-- =============================================================================
-- STEP 3: CHECK AND UPDATE WEBHOOK URLS IN ADAPTER_CONFIG
-- =============================================================================

-- Webhook URLs are stored in the adapter_config JSONB field (not a separate table)
-- Check for any http:// URLs that need to be updated to https://

-- Check current webhook URLs in adapter_config
SELECT 
    id,
    name,
    adapter_type,
    adapter_config->>'url' as webhook_url
FROM agents 
WHERE adapter_config->>'url' LIKE 'http://%';

-- Update http:// to https:// in adapter_config
-- This updates the 'url' field within the JSONB adapter_config
-- UPDATE agents 
-- SET adapter_config = jsonb_set(
--     adapter_config,
--     '{url}',
--     REPLACE(adapter_config->>'url', 'http://', 'https://')::jsonb
-- )
-- WHERE adapter_config->>'url' LIKE 'http://%';

-- Alternative: Update all http:// to https:// in any JSONB field
-- UPDATE agents 
-- SET adapter_config = REPLACE(
--     adapter_config::text, 
--     '"http://', 
--     '"https://'
-- )::jsonb
-- WHERE adapter_config::text LIKE '%"http://%';

-- =============================================================================
-- STEP 4: UPDATE ADAPTER TYPES TO HERMES_LOCAL
-- =============================================================================

-- Current state: 446 agents with 'http' adapter type, 1 with 'process'
-- This step changes all 'http' adapters to 'hermes_local'

-- Option A: Update ALL 'http' agents to hermes_local (RECOMMENDED - matches current state)
UPDATE agents SET adapter_type = 'hermes_local' WHERE adapter_type = 'http';

-- Option B: Update agents by company (for selective migration)
-- Uncomment specific company IDs as needed:

-- DevForge AI
-- UPDATE agents SET adapter_type = 'hermes_local' WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- DomainForge AI  
-- UPDATE agents SET adapter_type = 'hermes_local' WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d';

-- InfraForge AI
-- UPDATE agents SET adapter_type = 'hermes_local' WHERE company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666';

-- KnowledgeForge AI
-- UPDATE agents SET adapter_type = 'hermes_local' WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34';

-- QualityForge AI
-- UPDATE agents SET adapter_type = 'hermes_local' WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef';

-- PromptForge AI
-- UPDATE agents SET adapter_type = 'hermes_local' WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5';

-- Loopy AI
-- UPDATE agents SET adapter_type = 'hermes_local' WHERE company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021';

-- Learning Forge AI
-- UPDATE agents SET adapter_type = 'hermes_local' WHERE company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a';

-- IntegrateForge AI
-- UPDATE agents SET adapter_type = 'hermes_local' WHERE company_id = '550e8400-e29b-41d4-a716-446655440000';

-- ContentForge AI
-- UPDATE agents SET adapter_type = 'hermes_local' WHERE company_id = '550e8400-e29b-41d4-a716-446655440008';

-- MobileForge AI
-- UPDATE agents SET adapter_type = 'hermes_local' WHERE company_id = '550e8400-e29b-41d4-a716-446655440009';

-- ExecForge AI
-- UPDATE agents SET adapter_type = 'hermes_local' WHERE company_id = '550e8400-e29b-41d4-a716-446655440010';

-- SaaSForge AI
-- UPDATE agents SET adapter_type = 'hermes_local' WHERE company_id = '550e8400-e29b-41d4-a716-446655440011';

-- VoiceForge AI
-- UPDATE agents SET adapter_type = 'hermes_local' WHERE company_id = '550e8400-e29b-41d4-a716-446655440012';

-- PaperclipForge AI
-- UPDATE agents SET adapter_type = 'hermes_local' WHERE company_id = '550e8400-e29b-41d4-a716-446655440013';

-- =============================================================================
-- STEP 5: UPDATE WEBHOOK/CALLBACK URL IN ADAPTER_CONFIG
-- =============================================================================

-- For hermes_local adapter, set the webhook URL where Paperclip will send callbacks
-- Replace 'YOUR_HERMES_WEBHOOK_URL' with your actual Hermes agent webhook URL
-- Example: 'https://your-hermes-agent.example.com/webhook'

-- UPDATE agents 
-- SET adapter_config = jsonb_set(
--     COALESCE(adapter_config, '{}'::jsonb),
--     '{url}',
--     '"https://YOUR_HERMES_WEBHOOK_URL"'::jsonb
-- )
-- WHERE adapter_type = 'hermes_local';

-- Or update for a specific company:
-- UPDATE agents
-- SET adapter_config = jsonb_set(
--     COALESCE(adapter_config, '{}'::jsonb),
--     '{url}',
--     '"https://YOUR_HERMES_WEBHOOK_URL"'::jsonb
-- )
-- WHERE adapter_type = 'hermes_local'
-- AND company_id = 'YOUR_COMPANY_ID';

-- Set the GitHub repository URL for hermes_local adapters
UPDATE agents
SET adapter_config = jsonb_set(
    COALESCE(adapter_config, '{}'::jsonb),
    '{url}',
    '"https://github.com/tennantalistair/hermes-render-github-testing.git"'::jsonb
)
WHERE adapter_type = 'hermes_local';

-- =============================================================================
-- STEP 6: HERMES_ADAPTER CONFIGURATION
-- =============================================================================

-- ⚠️ IMPORTANT: DO NOT CHANGE THE MODEL
-- The adapter_config should preserve existing model settings.
-- Only add hermes-specific settings like persistSession, timeoutSec, etc.

-- Default hermes_local adapter config (preserving existing model)
-- Note: adapter_config is stored as JSONB in PostgreSQL

-- Option C: Merge hermes settings while preserving existing model
-- This is the SAFEST approach - it adds hermes settings without touching model
-- UPDATE agents 
-- SET adapter_config = 
--     COALESCE(adapter_config, '{}'::jsonb) ||
--     '{
--         "persistSession": true,
--         "toolsets": ["file_tools", "terminal_tools", "git"],
--         "timeoutSec": 600,
--         "graceSec": 15
--     }'::jsonb
-- WHERE adapter_type = 'hermes_local';

-- =============================================================================
-- STEP 7: VERIFY CHANGES
-- =============================================================================

-- Check updated adapter types
SELECT 
    adapter_type, 
    COUNT(*) as agent_count 
FROM agents 
GROUP BY adapter_type 
ORDER BY agent_count DESC;

-- =============================================================================
-- STEP 8: ROLLBACK (if needed)
-- =============================================================================

-- To rollback, restore from backup:
-- INSERT INTO agents 
-- SELECT id, company_id, name, adapter_type, adapter_config, created_at, updated_at
-- FROM agents_backup_20260418;

-- =============================================================================
-- NOTES FOR EXECUTION
-- =============================================================================
-- 1. Run STEP 1 first to create backup
-- 2. Run STEP 2 to verify current state
-- 3. Run STEP 3 if webhook URLs need checking
-- 4. Run STEP 4 to update adapter types
-- 5. Run STEP 5 to set webhook URL (replace YOUR_HERMES_WEBHOOK_URL)
-- 6. Optionally run STEP 6 to add hermes settings (preserves model!)
-- 7. Run STEP 7 to verify changes
-- 
-- ⚠️ MODEL PRESERVATION:
-- The migration is designed to PRESERVE existing model settings.
-- Only STEP 5 Option C (recommended) or Option A should be used.
-- Option B changes the model - only use if intentionally desired.
-- 
-- WEBHOOK URLS IN ADAPTER_CONFIG:
-- Webhook URLs are stored in adapter_config JSONB as the 'url' field.
-- To update http:// to https://:
-- UPDATE agents SET adapter_config = jsonb_set(adapter_config, '{url}', REPLACE(adapter_config->>'url', 'http://', 'https://')::jsonb) WHERE adapter_config->>'url' LIKE 'http://%';
-- 
-- =============================================================================
