-- Model assignments for Nimbus Supabase Specialist
-- Nimbus requires advanced reasoning for complex SQL generation and database optimization

-- Primary model assignment - Z.ai: GLM 5 Turbo for complex database operations and SQL generation
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
  'Nimbus',
  'Z.ai: GLM 5 Turbo',
  'primary',
  1,
  0.1,
  4096,
  NOW(),
  'atlas-agent-creator',
  'Advanced reasoning required for complex SQL generation, database optimization, and authentication troubleshooting',
  true
) ON CONFLICT (agent_id, assignment_type) DO NOTHING;

-- Fallback model assignment - GLM-3-Turbo for general database operations
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
  'Nimbus',
  'GLM-3-Turbo',
  'fallback',
  2,
  0.2,
  4096,
  NOW(),
  'atlas-agent-creator',
  'Cost-effective fallback model for general database operations and integration support',
  true
) ON CONFLICT (agent_id, assignment_type) DO NOTHING;

-- Specialized model assignment - GLM-5.1 for expert-level SQL and data analysis
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
  'Nimbus',
  'GLM-5.1',
  'specialized',
  3,
  0.05,
  8192,
  NOW(),
  'atlas-agent-creator',
  'Specialized model for expert-level SQL generation and complex data analysis tasks',
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
WHERE am.agent_id = 'Nimbus'
ORDER BY am.priority;