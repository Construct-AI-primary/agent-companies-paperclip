-- Model assignments for Atlas Agent Creator
-- Atlas requires advanced reasoning for complex agent creation and management tasks

-- Primary model assignment - Z.ai: GLM 5 Turbo for complex agent architecture and lifecycle management
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
) VALUES (
  'Atlas',
  'Z.ai: GLM 5 Turbo',
  'primary',
  1,
  0.1,
  4096,
  NOW(),
  'system',
  'Advanced reasoning required for complex agent creation, skill architecture design, and lifecycle management',
  true
) ON CONFLICT (agent_id, assignment_type) DO NOTHING;

-- Fallback model assignment - GLM-3-Turbo for general agent management tasks
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
) VALUES (
  'Atlas',
  'GLM-3-Turbo',
  'fallback',
  2,
  0.2,
  4096,
  NOW(),
  'system',
  'Cost-effective fallback model for general agent management and coordination tasks',
  true
) ON CONFLICT (agent_id, assignment_type) DO NOTHING;

-- Verification query
SELECT
  am.agent_id,
  am.model_id,
  am.assignment_type,
  am.priority,
  am.temperature,
  am.max_tokens,
  am.reason
FROM agent_models am
WHERE am.agent_id = 'Atlas'
ORDER BY am.priority;