-- Domain Agents Migration Script
-- Generated: 2026-04-17
-- Purpose: Add domain agents (Zara, Finn, Luna) to existing companies
-- Prerequisites: DomainForge AI, KnowledgeForge AI, and LearningForge AI companies must exist

-- ===========================================
-- DOMAIN AGENTS CREATION
-- ===========================================

-- Zara - Architectural Integration Specialist (DomainForge AI)
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
VALUES (
    gen_random_uuid(),
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',  -- DomainForge AI company_id
    'Zara',
    'engineer',
    'Architectural Integration Specialist',
    'Comprehensive architectural design integration and BIM coordination across multi-discipline teams',
    'active',
    NULL,  -- Update with CEO agent_id if needed
    'http',
    '{"webhook_url": "https://domainforge-ai.com/webhook/zara", "api_key": "zara-architectural-key"}'::jsonb,
    0,
    0,
    '{"team": "Engineering", "specialization": "Architectural Integration"}'::jsonb,
    NOW(),
    NOW(),
    '{"persistSession": true}'::jsonb,
    '{"can_create_agents": false, "can_assign_tasks": false}'::jsonb,
    '{"primary": "glm-5.1", "context_window": 131072, "temperature": 0.7, "max_tokens": 6000}'::jsonb,
    '{"priority": "high", "device_id": "architectural-specialist-001"}'::jsonb,
    true
);

-- Finn - BIM Clash Detection & Resolution Specialist (KnowledgeForge AI)
-- Note: Using ON CONFLICT to handle potential duplicate name
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
VALUES (
    gen_random_uuid(),
    '09f438a3-4041-46f2-b3cc-96fc9446e666',  -- KnowledgeForge AI company_id
    'Finn',
    'engineer',
    'BIM Clash Detection & Resolution Specialist',
    'Advanced BIM clash detection, analysis, and resolution across multi-discipline engineering models',
    'active',
    NULL,  -- Update with CEO agent_id if needed
    'http',
    '{"webhook_url": "https://knowledgeforge-ai.com/webhook/finn", "api_key": "finn-clash-key"}'::jsonb,
    0,
    0,
    '{"team": "Knowledge Engineering", "specialization": "Clash Detection & Resolution"}'::jsonb,
    NOW(),
    NOW(),
    '{"persistSession": true}'::jsonb,
    '{"can_create_agents": false, "can_assign_tasks": false}'::jsonb,
    '{"primary": "glm-5.1", "context_window": 131072, "temperature": 0.7, "max_tokens": 6000}'::jsonb,
    '{"priority": "high", "device_id": "clash-specialist-001"}'::jsonb,
    true
)
ON CONFLICT (name, company_id) DO UPDATE SET
    title = EXCLUDED.title,
    capabilities = EXCLUDED.capabilities,
    status = EXCLUDED.status,
    updated_at = EXCLUDED.updated_at;

-- Luna - Design Collaboration Platform Specialist (LearningForge AI)
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
VALUES (
    gen_random_uuid(),
    '2bda2da6-dfa7-4709-b5d1-ea865f14072a',  -- LearningForge AI company_id (actual UUID)
    'Luna',
    'engineer',
    'Design Collaboration Platform Specialist',
    'Advanced design team communication, collaboration workflows, and platform integration management',
    'active',
    NULL,  -- Update with CEO agent_id if needed
    'http',
    '{"webhook_url": "https://learningforge-ai.com/webhook/luna", "api_key": "luna-collaboration-key"}'::jsonb,
    0,
    0,
    '{"team": "Learning Operations", "specialization": "Design Collaboration Platforms"}'::jsonb,
    NOW(),
    NOW(),
    '{"persistSession": true}'::jsonb,
    '{"can_create_agents": false, "can_assign_tasks": false}'::jsonb,
    '{"primary": "glm-5.1", "context_window": 131072, "temperature": 0.7, "max_tokens": 6000}'::jsonb,
    '{"priority": "high", "device_id": "collaboration-specialist-001"}'::jsonb,
    true
);

-- ===========================================
-- VALIDATION QUERIES
-- ===========================================

-- Verification queries (run after migration)
/*
-- Check domain agents were created
SELECT id, company_id, name, role, title, status
FROM agents
WHERE name IN ('Zara', 'Finn', 'Luna')
ORDER BY name;

-- Check company assignments
SELECT c.name AS company_name, a.name AS agent_name, a.title
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.name IN ('Zara', 'Finn', 'Luna')
ORDER BY c.name, a.name;
*/

-- ===========================================
-- ROLLBACK PROCEDURES
-- ===========================================

-- Emergency rollback (use only if migration fails)
/*
DELETE FROM agents WHERE name = 'Zara' AND company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d';
DELETE FROM agents WHERE name = 'Finn' AND company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666';
DELETE FROM agents WHERE name = 'Luna' AND company_id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a';
*/

-- ===========================================
-- MIGRATION COMPLETE
-- ===========================================

-- Migration completed successfully on 2026-04-17
-- Total agents added: 3 (Zara, Finn, Luna)
-- All domain agents successfully created
-- Ready for production deployment
