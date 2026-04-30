-- Fix: Update name column from slug to human-readable display name
-- The name column should be the human-readable name, not the kebab-case slug
-- Reference: AGENTS.md frontmatter has name: Paperclip Setup Specialist

UPDATE agents
SET name = 'Paperclip Setup Specialist',
    updated_at = now()
WHERE name = 'paperclip-setup-infraforge-specialist'
  AND company_id = (SELECT id FROM companies WHERE name = 'InfraForge AI' AND status = 'active');

-- Verify the fix
SELECT
  id,
  name,
  title,
  metadata->>'agent_slug' AS slug
FROM agents
WHERE id = '0b150fd7-2bd1-46c3-80a8-02478441bb59';