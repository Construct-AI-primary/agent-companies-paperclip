-- Add Atlas Agent Creator to PaperclipForge AI
-- This agent specializes in creating and managing AI agents across the Paperclip ecosystem

BEGIN;

-- Insert Atlas agent
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  adapter_type,
  adapter_config,
  budget_monthly_cents,
  spent_monthly_cents,
  last_heartbeat_at,
  metadata,
  runtime_config,
  permissions,
  model_config,
  device_config,
  is_active,
  created_at,
  updated_at
) VALUES (
  '550e8400-e29b-41d4-a716-446655440001',
  (SELECT id FROM companies WHERE name = 'PaperclipForge AI'),
  'Atlas',
  'specialist',
  'Agent Creator and Manager',
  'Agent creation and lifecycle management, skill configuration, model assignment optimization, cross-company agent integration',
  'active',
  (SELECT id FROM agents WHERE name = 'operations-director'),
  'http',
  '{"url":"https://ecb3-102-132-198-101.ngrok-free.app/webhook","model":"openrouter/qwen/qwen-3-6-plus","api_key":"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","provider":"openrouter","maxIterations":50,"persistSession":true}',
  0,
  0,
  NULL,
  '{
    "team": "operations",
    "specialization": "Agent Lifecycle Management",
    "skills": [
      "agent-creation-management",
      "agent-lifecycle-orchestration",
      "skill-configuration-routing",
      "model-assignment-optimization",
      "agent-performance-monitoring"
    ],
    "reports_to_details": {
      "name": "operations-director",
      "title": "Chief Operations Officer",
      "company": "PaperclipForge AI"
    }
  }'::jsonb,
  '{"persistSession":true}',
  '{
    "can_create_agents": true,
    "can_manage_agent_lifecycle": true,
    "can_assign_models": true,
    "can_configure_skills": true,
    "cross_company_access": true
  }'::jsonb,
  '{"model":"Z.ai: GLM 5 Turbo","provider":"openrouter","max_tokens":4096,"temperature":0.1,"fallback_models":["GLM-3-Turbo"]}',
  '{"priority":1,"device_id":"device-1"}',
  true,
  NOW(),
  NOW()
)
ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  updated_at = EXCLUDED.updated_at;

COMMIT;

-- Verification query
SELECT
  a.name,
  a.title,
  a.role,
  c.name as company_name,
  boss.name as reports_to
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agents boss ON a.reports_to = boss.id
WHERE a.name = 'Atlas';