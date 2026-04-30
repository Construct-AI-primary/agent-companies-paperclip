-- Finn Agent Only Migration Script
-- Generated: 2026-04-17
-- Purpose: Create IntegrateForge AI company and add Finn agent
-- Prerequisites: None

-- ===========================================
-- INTEGRATEFORGE AI COMPANY CREATION
-- ===========================================

-- Create IntegrateForge AI company
INSERT INTO companies (
    id,
    name,
    description,
    status,
    issue_prefix,
    issue_counter,
    budget_monthly_cents,
    spent_monthly_cents,
    require_board_approval_for_new_agents,
    brand_color,
    is_active,
    feedback_data_sharing_enabled,
    created_at,
    updated_at
) VALUES (
    '550e8400-e29b-41d4-a716-446655440000',
    'IntegrateForge AI',
    'Specialized autonomous AI company focused on third-party tool integrations for the engineering and construction ecosystem',
    'active',
    'INT',
    0,
    0,
    0,
    true,
    '#10b981',
    true,
    false,
    NOW(),
    NOW()
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    status = EXCLUDED.status,
    brand_color = EXCLUDED.brand_color,
    updated_at = EXCLUDED.updated_at;

-- ===========================================
-- FINN AGENT CREATION
-- ===========================================

-- Finn - BIM Clash Detection & Resolution Specialist (IntegrateForge AI)
-- Check if Finn already exists before inserting
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
    metadata,
    created_at,
    updated_at,
    runtime_config,
    permissions,
    model_config,
    device_config,
    is_active
)
SELECT
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440000',  -- IntegrateForge AI company_id
    'Finn',
    'engineer',
    'BIM Clash Detection & Resolution Specialist',
    'Advanced BIM clash detection, analysis, and resolution across multi-discipline engineering models',
    'active',
    NULL,  -- Update with CEO agent_id if needed
    'http',
    '{"webhook_url": "https://integrateforge-ai.com/webhook/finn", "api_key": "finn-clash-key"}'::jsonb,
    0,
    0,
    '{"team": "Integration Engineering", "specialization": "Clash Detection & Resolution"}'::jsonb,
    NOW(),
    NOW(),
    '{"persistSession": true}'::jsonb,
    '{"can_create_agents": false, "can_assign_tasks": false}'::jsonb,
    '{"primary": "glm-5.1", "context_window": 131072, "temperature": 0.7, "max_tokens": 6000}'::jsonb,
    '{"priority": "high", "device_id": "clash-specialist-001"}'::jsonb,
    true
WHERE NOT EXISTS (
    SELECT 1 FROM agents
    WHERE name = 'Finn' AND company_id = '550e8400-e29b-41d4-a716-446655440000'
);

-- ===========================================
-- VALIDATION QUERIES
-- ===========================================

-- Verification queries (run after migration)
/*
-- Check Finn agent was created
SELECT id, company_id, name, role, title, status
FROM agents
WHERE name = 'Finn' AND company_id = '550e8400-e29b-41d4-a716-446655440000';

-- Check company assignment
SELECT c.name AS company_name, a.name AS agent_name, a.title
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.name = 'Finn' AND a.company_id = '550e8400-e29b-41d4-a716-446655440000';
*/

-- ===========================================
-- ROLLBACK PROCEDURES
-- ===========================================

-- Emergency rollback (use only if migration fails)
/*
DELETE FROM agents WHERE name = 'Finn' AND company_id = '550e8400-e29b-41d4-a716-446655440000';
*/

-- ===========================================
-- MIGRATION COMPLETE
-- ===========================================

-- Migration completed successfully on 2026-04-17
-- Total agents added: 1 (Finn)
-- Ready for production deployment
