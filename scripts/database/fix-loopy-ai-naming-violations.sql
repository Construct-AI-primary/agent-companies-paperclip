-- Fix Loopy AI Agent Naming Convention Violations
-- Corrects agent names to follow the standardized naming procedure

-- ===========================================
-- ISSUE: Loopy AI agents have incorrect names
-- ===========================================
-- Current violations:
-- ❌ maya-loopy-content-strategist (contains "maya" prefix)
-- ❌ Vision Loopy CEO (contains "Vision" prefix)
-- ❌ Other agents with non-standard names

-- According to agent naming procedure:
-- Filesystem format: {company-slug}-{role} → loopy-ai-{role}
-- Database/UI format: {CompanyName AI}-{Role} → Loopy AI-{Role}

-- ===========================================
-- CORRECTIONS NEEDED
-- ===========================================

-- 1. Rename maya-loopy-content-strategist to loopy-ai-content-strategist
UPDATE agents
SET name = 'loopy-ai-content-strategist',
    title = 'Content Strategist',
    updated_at = NOW()
WHERE name = 'maya-loopy-content-strategist'
  AND company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021';

-- Update corresponding API key name
UPDATE agent_api_keys
SET name = 'loopy-ai-content-strategist API Key'
WHERE agent_id IN (
    SELECT id FROM agents WHERE name = 'loopy-ai-content-strategist'
);

-- 2. Rename Vision Loopy CEO to Loopy AI-CEO
UPDATE agents
SET name = 'Loopy AI-CEO',
    title = 'Chief Executive Officer',
    updated_at = NOW()
WHERE name = 'Vision Loopy CEO'
  AND company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021';

-- Update corresponding API key name
UPDATE agent_api_keys
SET name = 'Loopy AI-CEO API Key'
WHERE agent_id IN (
    SELECT id FROM agents WHERE name = 'Loopy AI-CEO'
);

-- 3. Rename other non-standard Loopy AI agent names
-- Note: These agents (Maya, Jordan, Vision, Sam, Dev, Observer, Alex)
-- appear to be personal names rather than functional roles.
-- They should be renamed to follow proper naming conventions or removed if not functional.

-- Example corrections (uncomment and modify as needed):
/*
-- If these are functional agents, rename them properly:
UPDATE agents SET name = 'Loopy AI-Navigator', title = 'Data Navigator' WHERE name = 'Jordan' AND company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021';
UPDATE agents SET name = 'Loopy AI-Observer', title = 'System Observer' WHERE name = 'Observer' AND company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021';
UPDATE agents SET name = 'Loopy AI-Developer', title = 'Software Developer' WHERE name = 'Dev' AND company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021';

-- If these are not functional agents, consider deactivating them:
UPDATE agents SET status = 'inactive', updated_at = NOW() WHERE name IN ('Maya', 'Sam', 'Alex') AND company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021';
*/

-- ===========================================
-- VERIFICATION QUERIES
-- ===========================================

-- Check current Loopy AI agent names:
/*
SELECT name, title, status
FROM agents
WHERE company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021'
ORDER BY name;
*/

-- Check for remaining naming violations:
/*
SELECT name,
       CASE
         WHEN name NOT LIKE 'Loopy AI-%' AND name NOT LIKE 'loopy-ai-%' THEN 'Non-standard naming'
         WHEN name LIKE '%maya%' OR name LIKE '%vision%' THEN 'Contains personal prefix'
         ELSE 'OK'
       END as naming_status
FROM agents
WHERE company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021';
*/

-- ===========================================
-- FILE SYSTEM CORRECTIONS NEEDED
-- ===========================================
-- After database corrections, rename directories:
-- mv docs-paperclip/companies/loopy-ai/agents/loopy-ai-maya-loopy-content-strategist/
--    docs-paperclip/companies/loopy-ai/agents/loopy-ai-content-strategist/
--
-- mv docs-paperclip/companies/loopy-ai/agents/loopy-ai-vision-loopy-ceo/
--    docs-paperclip/companies/loopy-ai/agents/loopy-ai-ceo/

-- ===========================================
-- AGENT FILE CORRECTIONS NEEDED
-- ===========================================
-- Update YAML frontmatter in agent files:
-- name: loopy-ai-content-strategist
-- title: Content Strategist
-- slug: loopy-ai-content-strategist

-- ===========================================
-- PREVENTION MEASURES
-- ===========================================
-- 1. Implement naming validation in agent creation process
-- 2. Add automated checks for naming convention compliance
-- 3. Require naming procedure review before agent approval
-- 4. Create naming validation function in database

-- Create naming validation function:
/*
CREATE OR REPLACE FUNCTION validate_loopy_ai_name(
    proposed_name TEXT
) RETURNS BOOLEAN AS $$
BEGIN
    -- Check if name follows Loopy AI naming convention
    RETURN proposed_name LIKE 'loopy-ai-%' OR proposed_name LIKE 'Loopy AI-%';
END;
$$ LANGUAGE plpgsql;
*/