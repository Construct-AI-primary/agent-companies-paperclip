-- Add Issue Batch Importer agent to PaperclipForge AI
-- This agent specializes in bulk issue processing and cross-company orchestration

BEGIN;

-- Insert the Issue Batch Importer agent
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
  permissions,
  is_active
) VALUES (
  'f47ac10b-58cc-4372-a567-0e02b2c3d479', -- Generated UUID for issue-batch-importer
  '550e8400-e29b-41d4-a716-446655440013', -- PaperclipForge AI company ID
  'Issue Batch Importer',
  'specialist',
  'Bulk Issue Processing Specialist',
  'idle',
  NULL, -- Reports to CEO (Project Maestro) - Operations Director not yet created
  'Intelligent bulk issue processing, cross-company orchestration, automated routing and assignment',
  'hermes_local',
  '{
    "url": "https://hermes-agent/webhook",
    "model": "openrouter/anthropic/claude-sonnet-4.5",
    "maxIterations": 75,
    "persistSession": true
  }'::jsonb,
  50000, -- $500 monthly budget
  0,
  '{
    "team": "Issue Orchestration",
    "division": "issue-orchestration",
    "skills": ["issue-batch-importer"],
    "specialization": "bulk-processing"
  }'::jsonb,
  NOW(),
  NOW(),
  '{
    "canCreateIssues": true,
    "canAssignIssues": true,
    "canAccessAllCompanies": true,
    "canManageBulkOperations": true
  }'::jsonb,
  true
);

-- Insert API key for the Issue Batch Importer agent
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  key_hash,
  created_at
) VALUES (
  gen_random_uuid(),
  'f47ac10b-58cc-4372-a567-0e02b2c3d479', -- Issue Batch Importer agent ID
  '550e8400-e29b-41d4-a716-446655440013', -- PaperclipForge AI company ID
  'Production Key',
  encode(sha256('pk_paperclipforge_issue_batch_importer_2026'::bytea), 'hex'),
  NOW()
);

COMMIT;

-- Verification queries
SELECT
  'Agent created:' as status,
  a.name,
  a.role,
  a.title,
  c.name as company
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.id = 'f47ac10b-58cc-4372-a567-0e02b2c3d479';

SELECT
  'API key created:' as status,
  a.name as agent_name,
  aak.name as key_name,
  CASE WHEN aak.revoked_at IS NULL THEN 'Active' ELSE 'Revoked' END as status
FROM agent_api_keys aak
JOIN agents a ON aak.agent_id = a.id
WHERE a.id = 'f47ac10b-58cc-4372-a567-0e02b2c3d479';
