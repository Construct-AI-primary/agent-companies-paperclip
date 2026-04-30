-- Apply Model Assignments to All Agents
-- Based on the Agent Model Assignment Procedure guidelines
-- This script assigns appropriate AI models to all existing agents based on their roles and capabilities

-- First, let's check which agents currently don't have model assignments
-- SELECT a.name, a.role, a.title, c.name as company_name
-- FROM agents a
-- JOIN companies c ON a.company_id = c.id
-- LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
-- WHERE am.id IS NULL
-- ORDER BY c.name, a.name;

-- Apply model assignments based on agent roles and capabilities
-- Using cost-effective model selection from the procedure guidelines

INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_at,
  assigned_by,
  reason,
  is_active
)
SELECT
  a.name,
  CASE
    -- CEOs and executive roles - use GLM-5.1 for complex strategic reasoning
    WHEN a.role = 'ceo' THEN 'anthropic/claude-3.5-sonnet'

    -- Engineering and technical roles - use GLM-4-Plus for coding tasks
    WHEN a.role IN ('engineer', 'devops') THEN 'anthropic/claude-3.5-sonnet'

    -- Content creation and marketing roles - use GLM-3-Turbo for cost efficiency
    WHEN LOWER(a.name) LIKE '%content%' THEN 'anthropic/claude-3-haiku'
    WHEN LOWER(a.name) LIKE '%blog%' THEN 'anthropic/claude-3-haiku'
    WHEN LOWER(a.name) LIKE '%email%' THEN 'anthropic/claude-3-haiku'
    WHEN LOWER(a.name) LIKE '%social%' THEN 'anthropic/claude-3-haiku'
    WHEN LOWER(a.name) LIKE '%marketing%' THEN 'anthropic/claude-3-haiku'
    WHEN LOWER(a.name) LIKE '%writer%' THEN 'anthropic/claude-3-haiku'
    WHEN LOWER(a.name) LIKE '%composer%' THEN 'anthropic/claude-3-haiku'

    -- Data and analytics roles - use GLM-5.1 for analytical reasoning
    WHEN LOWER(a.name) LIKE '%data%' THEN 'anthropic/claude-3.5-sonnet'
    WHEN LOWER(a.name) LIKE '%analyst%' THEN 'anthropic/claude-3.5-sonnet'
    WHEN LOWER(a.name) LIKE '%analytics%' THEN 'anthropic/claude-3.5-sonnet'

    -- Research and learning roles - use GLM-5.1 for deep understanding
    WHEN LOWER(a.name) LIKE '%research%' THEN 'anthropic/claude-3.5-sonnet'
    WHEN LOWER(a.name) LIKE '%learning%' THEN 'anthropic/claude-3.5-sonnet'
    WHEN LOWER(a.name) LIKE '%knowledge%' THEN 'anthropic/claude-3.5-sonnet'

    -- Creative and design roles - use GLM-4-Plus for content generation
    WHEN LOWER(a.name) LIKE '%design%' THEN 'anthropic/claude-3.5-sonnet'
    WHEN LOWER(a.name) LIKE '%creative%' THEN 'anthropic/claude-3.5-sonnet'
    WHEN LOWER(a.name) LIKE '%artist%' THEN 'anthropic/claude-3.5-sonnet'

    -- Administrative and coordination roles - use GLM-3-Turbo for efficiency
    WHEN LOWER(a.name) LIKE '%coordinator%' THEN 'anthropic/claude-3-haiku'
    WHEN LOWER(a.name) LIKE '%manager%' THEN 'anthropic/claude-3-haiku'
    WHEN LOWER(a.name) LIKE '%administrator%' THEN 'anthropic/claude-3-haiku'

    -- Specialist roles - assess based on title complexity
    WHEN a.role = 'specialist' AND (
      LOWER(a.title) LIKE '%expert%' OR
      LOWER(a.title) LIKE '%senior%' OR
      LOWER(a.title) LIKE '%lead%' OR
      LOWER(a.title) LIKE '%architect%'
    ) THEN 'anthropic/claude-3.5-sonnet'

    -- Default for general/specialist roles - use GLM-3-Turbo for cost efficiency
    WHEN a.role IN ('specialist', 'general') THEN 'anthropic/claude-3-haiku'

    -- Default fallback
    ELSE 'anthropic/claude-3-haiku'
  END as model_id,
  'primary',
  1,
  CASE
    WHEN a.role = 'ceo' THEN 0.5  -- More conservative for executive decisions
    WHEN LOWER(a.name) LIKE '%creative%' THEN 0.9  -- More creative for content generation
    WHEN LOWER(a.name) LIKE '%data%' THEN 0.3  -- More analytical for data tasks
    ELSE 0.7  -- Standard temperature
  END as temperature,
  4096,  -- Standard token limit
  NOW(),
  'system',
  'Bulk model assignment based on Agent Model Assignment Procedure guidelines - ' ||
  CASE
    WHEN a.role = 'ceo' THEN 'Executive role requiring complex strategic reasoning'
    WHEN a.role IN ('engineer', 'devops') THEN 'Technical role requiring coding capabilities'
    WHEN LOWER(a.name) LIKE '%content%' THEN 'Content creation role using cost-effective model'
    WHEN LOWER(a.name) LIKE '%blog%' THEN 'Blog writing role using cost-effective model'
    WHEN LOWER(a.name) LIKE '%email%' THEN 'Email composition role using cost-effective model'
    WHEN LOWER(a.name) LIKE '%data%' THEN 'Data analysis role requiring analytical reasoning'
    WHEN LOWER(a.name) LIKE '%research%' THEN 'Research role requiring deep understanding'
    WHEN LOWER(a.name) LIKE '%creative%' THEN 'Creative role requiring content generation'
    ELSE 'General role using cost-effective model'
  END,
  true
FROM agents a
WHERE NOT EXISTS (
  SELECT 1 FROM agent_models am
  WHERE am.agent_id = a.name AND am.assignment_type = 'primary'
)
ORDER BY a.company_id, a.name
ON CONFLICT (agent_id, assignment_type) DO NOTHING;

-- Add fallback models for critical agents (CEOs and key technical roles)
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_at,
  assigned_by,
  reason,
  is_active
)
SELECT
  a.name,
  'openai/gpt-4o-mini',  -- Cost-effective fallback
  'fallback',
  2,
  0.7,
  4096,
  NOW(),
  'system',
  'Fallback model for reliability when primary model is unavailable',
  true
FROM agents a
WHERE a.role = 'ceo'
  AND NOT EXISTS (
    SELECT 1 FROM agent_models am
    WHERE am.agent_id = a.name AND am.assignment_type = 'fallback'
  )
ON CONFLICT (agent_id, assignment_type) DO NOTHING;

-- Verification queries
-- Check total assignments created
SELECT
  'Total agents' as metric,
  COUNT(*) as count
FROM agents
UNION ALL
SELECT
  'Agents with primary models' as metric,
  COUNT(DISTINCT am.agent_id) as count
FROM agent_models am
WHERE am.assignment_type = 'primary' AND am.is_active = true
UNION ALL
SELECT
  'Agents missing primary models' as metric,
  COUNT(*) as count
FROM agents a
LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
WHERE am.id IS NULL;

-- Show model distribution
SELECT
  am.model_id,
  COUNT(*) as agents_using,
  ROUND(AVG(am.temperature), 2) as avg_temperature
FROM agent_models am
WHERE am.assignment_type = 'primary' AND am.is_active = true
GROUP BY am.model_id
ORDER BY agents_using DESC;

-- Show assignments by company
SELECT
  c.name as company_name,
  COUNT(DISTINCT a.name) as total_agents,
  COUNT(DISTINCT am.agent_id) as agents_with_models,
  ROUND(
    COUNT(DISTINCT am.agent_id)::decimal /
    NULLIF(COUNT(DISTINCT a.name), 0) * 100, 1
  ) as coverage_percentage
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary' AND am.is_active = true
GROUP BY c.name
ORDER BY c.name;