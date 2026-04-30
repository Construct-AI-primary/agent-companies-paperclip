-- Render Deployment Specialist Agent Registration
-- Generated following Atlas Agent Creator procedure with schema inspection
-- Company: InfraForge AI
-- Agent: render-deployment-specialist

-- Step 1: Insert agent record
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  reports_to,
  capabilities,
  adapter_type,
  adapter_config,
  budget_monthly_cents,
  spent_monthly_cents,
  metadata,
  created_at,
  updated_at,
  runtime_config,
  permissions
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'InfraForge AI' AND status = 'active'),
  'render-deployment-specialist',
  'specialist',
  'Render Deployment and Desktop Communication Specialist',
  'active',
  '2876f20c-220c-4bf7-9baf-6ea668f85ef6', -- Orchestrator (CEO)
  'Specialized agent for deploying Paperclip applications on Render cloud platform and enabling secure desktop communication with the dashboard via various tunneling and networking solutions including ngrok, Tailscale, and Hermes integration.',
  'hermes_local',
  '{
    "model": "anthropic/claude-3-5-sonnet-20241022",
    "skills": [
      "render-environment-integration",
      "environment-variable-access",
      "configuration-file-parsing",
      "hermes-communication-setup",
      "cloud-deployment-automation",
      "network-tunneling-configuration",
      "desktop-dashboard-connectivity",
      "secure-api-key-management",
      "infrastructure-monitoring-setup",
      "deployment-verification-testing"
    ]
  }'::jsonb,
  0,
  0,
  '{
    "created_by": "atlas-agent-creator",
    "company": "InfraForge AI",
    "team": "infrastructure",
    "skills_count": 10,
    "integration_points": ["DevForge AI", "PaperclipForge AI", "QualityForge AI", "KnowledgeForge AI"]
  }'::jsonb,
  NOW(),
  NOW(),
  '{
    "automation_enabled": true,
    "max_iterations": 50,
    "context_window": 200000,
    "temperature": 0.7
  }'::jsonb,
  '{
    "company_access": "InfraForge AI",
    "cross_company_access": ["DevForge AI", "PaperclipForge AI", "QualityForge AI", "KnowledgeForge AI"],
    "infrastructure_permissions": ["render_deployment", "network_configuration", "hermes_setup"],
    "security_level": "standard"
  }'::jsonb
);

-- Step 2: Insert API key record
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  api_key,
  key_hash,
  created_at
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'render-deployment-specialist' ORDER BY created_at DESC LIMIT 1),
  (SELECT id FROM companies WHERE name = 'InfraForge AI' AND status = 'active'),
  'render_deployment_specialist_key',
  'pcak_' || encode(gen_random_uuid()::text::bytea, 'base64'),
  encode(digest('pcak_render_' || gen_random_uuid()::text, 'sha256'), 'hex'),
  NOW()
);

-- Step 3: Insert activity log record
INSERT INTO activity_log (
  id,
  company_id,
  actor_type,
  actor_id,
  action,
  entity_type,
  entity_id,
  agent_id,
  details,
  created_at
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'InfraForge AI' AND status = 'active'),
  'system',
  'atlas-agent-creator',
  'create',
  'agent',
  (SELECT id FROM agents WHERE name = 'render-deployment-specialist' ORDER BY created_at DESC LIMIT 1),
  (SELECT id FROM agents WHERE name = 'render-deployment-specialist' ORDER BY created_at DESC LIMIT 1),
  '{
    "description": "Created Render Deployment Specialist agent",
    "skills": [
      "render-environment-integration",
      "environment-variable-access",
      "configuration-file-parsing",
      "hermes-communication-setup",
      "cloud-deployment-automation",
      "network-tunneling-configuration",
      "desktop-dashboard-connectivity",
      "secure-api-key-management",
      "infrastructure-monitoring-setup",
      "deployment-verification-testing"
    ],
    "capabilities": "Render cloud deployment and desktop communication setup",
    "integration_points": ["DevForge AI", "PaperclipForge AI", "QualityForge AI", "KnowledgeForge AI"],
    "created_by_procedure": "atlas-agent-creation-with-schema-inspection-procedure"
  }'::jsonb,
  NOW()
);

-- Verification Query
SELECT
  a.id AS agent_id,
  a.name AS agent_name,
  a.role,
  a.title,
  a.status,
  a.adapter_type,
  c.name AS company_name,
  a.created_at,
  ak.name AS api_key_name,
  ak.created_at AS key_created_at
FROM
  agents a
JOIN
  companies c ON a.company_id = c.id
LEFT JOIN
  agent_api_keys ak ON a.id = ak.agent_id
WHERE
  a.name = 'render-deployment-specialist'
ORDER BY
  a.created_at DESC
LIMIT 1;