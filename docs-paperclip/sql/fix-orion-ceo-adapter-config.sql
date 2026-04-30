-- Fix Orion CEO designation by updating adapter_config JSON
-- Based on the view definition, is_ceo = true when adapter_config->>'authority_level' = 'ceo'

-- First, check Orion's current adapter_config
SELECT
  a.name,
  a.adapter_config,
  a.adapter_config->>'authority_level' as current_authority_level,
  a.adapter_config->>'division' as current_division
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'DevForge AI'
  AND a.name = 'Orion';

-- Update Orion's adapter_config to set authority_level = 'ceo'
-- Preserve existing adapter_config values and just update authority_level
UPDATE agents
SET adapter_config = jsonb_set(
  COALESCE(adapter_config, '{}'::jsonb),
  '{authority_level}',
  '"ceo"'::jsonb
)
WHERE name = 'Orion'
  AND company_id = (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1);

-- Also ensure Orion has the executive division if not already set
UPDATE agents
SET adapter_config = jsonb_set(
  COALESCE(adapter_config, '{}'::jsonb),
  '{division}',
  '"executive"'::jsonb
)
WHERE name = 'Orion'
  AND company_id = (SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1)
  AND (adapter_config->>'division' IS NULL OR adapter_config->>'division' = 'general');

-- Verify the update
SELECT
  a.name,
  a.adapter_config,
  a.adapter_config->>'authority_level' as authority_level,
  a.adapter_config->>'division' as division
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'DevForge AI'
  AND a.name = 'Orion';

-- Check that the org_chart_hierarchy view now shows Orion as CEO
SELECT
  agent_name,
  is_ceo,
  authority_level,
  hierarchy_rank,
  company_name
FROM org_chart_hierarchy
WHERE company_name = 'DevForge AI'
ORDER BY hierarchy_rank ASC, agent_name;

-- Confirm only one CEO exists
SELECT
  agent_name,
  is_ceo,
  company_name
FROM org_chart_hierarchy
WHERE company_name = 'DevForge AI'
  AND is_ceo = true;