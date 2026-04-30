-- Add Vision Loopy CEO agent to Paperclip database
-- This script adds the missing CEO agent and updates reporting structure

BEGIN;

-- First, check current Loopy AI agents
SELECT 
    'Current Loopy AI agents:' as info,
    a.name as agent_name,
    a.role,
    a.title,
    COALESCE(boss.name, 'Board') as reports_to,
    a.status
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agents boss ON a.reports_to = boss.id
WHERE c.name = 'Loopy AI' AND a.is_active = true
ORDER BY a.created_at;

-- Get Loopy AI company ID
CREATE TEMP TABLE loopy_company AS
SELECT id, name FROM companies WHERE name = 'Loopy AI';

-- Check for existing Vision agent before adding
SELECT
    'Checking for existing Vision agent:' as info,
    CASE WHEN EXISTS (
        SELECT 1 FROM agents a
        JOIN companies c ON a.company_id = c.id
        WHERE c.name = 'Loopy AI' AND a.name = 'Vision'
    ) THEN 'Vision agent already exists - skipping creation' ELSE 'Vision agent not found - will create' END as status;

-- Add Vision Loopy CEO agent (only if doesn't exist)
INSERT INTO agents (
    id,
    company_id,
    name,
    role,
    title,
    capabilities,
    status,
    reports_to,
    metadata,
    created_at,
    updated_at
)
SELECT
    gen_random_uuid(),
    lc.id,
    'Vision',
    'ceo',
    'Chief Executive Officer',
    'Strategic planning and company vision, cross-division coordination, performance monitoring and reporting, resource allocation and priority setting, external partnerships and stakeholder management.',
    'active',
    NULL,  -- CEOs report to board (NULL)
    jsonb_build_object(
        'team', 'Loopy AI',
        'specialization', 'CEO Leadership',
        'skills', jsonb_build_array(
            'deep-research',
            'content-strategy',
            'creative-content-generation',
            'narrative-design',
            'interactive-media-development',
            'artistic-ai-ethics',
            'brainstorming',
            'status-reporting',
            'knowledge-transfer'
        )
    ),
    NOW(),
    NOW()
FROM loopy_company lc
WHERE NOT EXISTS (
    SELECT 1 FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'Loopy AI' AND a.name = 'Vision'
);

-- Update all existing Loopy AI agents to report to Vision
UPDATE agents 
SET reports_to = (
    SELECT a.id FROM agents a 
    JOIN companies c ON a.company_id = c.id 
    WHERE c.name = 'Loopy AI' AND a.name = 'Vision' AND a.role = 'ceo'
),
updated_at = NOW()
WHERE company_id = (SELECT id FROM loopy_company)
AND name != 'Vision'
AND is_active = true;

-- Add API key for Vision CEO
INSERT INTO agent_api_keys (
    id,
    agent_id,
    company_id,
    name,
    key_hash,
    created_at
)
SELECT
    gen_random_uuid(),
    a.id,
    a.company_id,
    'Primary Key',
    encode(sha256(random()::text::bytea), 'hex'),
    NOW()
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Loopy AI' 
AND a.name = 'Vision'
AND NOT EXISTS (
    SELECT 1 FROM agent_api_keys aak WHERE aak.agent_id = a.id
);

-- Add model assignment for Vision CEO
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
    'anthropic/claude-3.5-sonnet',
    'primary',
    1,
    0.7,
    4096,
    NOW(),
    'system',
    'Default model assignment for Vision Loopy CEO - creative content and strategic planning',
    true
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Loopy AI' 
AND a.name = 'Vision'
ON CONFLICT (agent_id, assignment_type) DO NOTHING;

-- Verify the setup
SELECT 
    'Final Loopy AI agent structure:' as info,
    a.name as agent_name,
    a.role,
    a.title,
    COALESCE(boss.name, 'Board') as reports_to,
    CASE WHEN aak.id IS NULL THEN '✗ Missing API Key' ELSE '✓ Has API Key' END as api_key_status,
    CASE WHEN am.id IS NULL THEN '✗ Missing Model' ELSE '✓ Has Model' END as model_status
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agents boss ON a.reports_to = boss.id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
WHERE c.name = 'Loopy AI' AND a.is_active = true
ORDER BY 
    CASE WHEN a.role = 'ceo' THEN 1 ELSE 2 END,
    a.created_at;

COMMIT;

-- Clean up temp table
DROP TABLE IF EXISTS loopy_company;
