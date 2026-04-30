-- ============================================================
-- SaaSForge AI Deployment Agents Creation
-- Run this in Supabase SQL Editor
-- ============================================================

-- STEP 1: Create the 4 agents
DO $$
DECLARE
    company_uuid UUID := '550e8400-e29b-41d4-a716-446655440011';
    manager_uuid UUID := '7e22d6cc-d7d7-4be8-a811-d8e03b2a9587';
BEGIN
    -- Agent 1: Client Config Manager
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'saasforge-ai-Client-Config-Manager' AND company_id = company_uuid) THEN
        INSERT INTO agents (id, company_id, name, role, title, status, capabilities, reports_to, adapter_type, adapter_config, runtime_config, permissions, metadata, created_at, updated_at)
        VALUES (
            gen_random_uuid(), 
            company_uuid, 
            'saasforge-ai-Client-Config-Manager', 
            'specialist', 
            'Per-Company Configuration Specialist', 
            'idle', 
            'Environment variables, branding management, feature flags, company-specific customizations',
            manager_uuid, 
            'http', 
            '{}', 
            '{}', 
            '{}', 
            '{"team": "platform-operations", "specialization": "Configuration Management", "skills": ["client-config-manager"]}',
            NOW(), 
            NOW()
        );
        RAISE NOTICE 'Created: saasforge-ai-Client-Config-Manager';
    ELSE
        RAISE NOTICE 'saasforge-ai-Client-Config-Manager already exists';
    END IF;

    -- Agent 2: Deployment Orchestrator
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'saasforge-ai-Deployment-Orchestrator' AND company_id = company_uuid) THEN
        INSERT INTO agents (id, company_id, name, role, title, status, capabilities, reports_to, adapter_type, adapter_config, runtime_config, permissions, metadata, created_at, updated_at)
        VALUES (
            gen_random_uuid(), 
            company_uuid, 
            'saasforge-ai-Deployment-Orchestrator', 
            'specialist', 
            'Multi-Instance Deployment Coordinator', 
            'idle', 
            'Cross-company deployment automation, Render service coordination, multi-client deployments',
            manager_uuid, 
            'http', 
            '{}', 
            '{}', 
            '{}', 
            '{"team": "platform-operations", "specialization": "Deployment Orchestration", "skills": ["deployment-orchestrator"]}',
            NOW(), 
            NOW()
        );
        RAISE NOTICE 'Created: saasforge-ai-Deployment-Orchestrator';
    ELSE
        RAISE NOTICE 'saasforge-ai-Deployment-Orchestrator already exists';
    END IF;

    -- Agent 3: GitHub Branch Manager
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'saasforge-ai-GitHub-Branch-Manager' AND company_id = company_uuid) THEN
        INSERT INTO agents (id, company_id, name, role, title, status, capabilities, reports_to, adapter_type, adapter_config, runtime_config, permissions, metadata, created_at, updated_at)
        VALUES (
            gen_random_uuid(), 
            company_uuid, 
            'saasforge-ai-GitHub-Branch-Manager', 
            'specialist', 
            'Version Control Specialist', 
            'idle', 
            'GitHub workflow automation, branch management, repository coordination, CI/CD pipelines',
            manager_uuid, 
            'http', 
            '{}', 
            '{}', 
            '{}', 
            '{"team": "platform-operations", "specialization": "Version Control", "skills": ["github-branch-manager"]}',
            NOW(), 
            NOW()
        );
        RAISE NOTICE 'Created: saasforge-ai-GitHub-Branch-Manager';
    ELSE
        RAISE NOTICE 'saasforge-ai-GitHub-Branch-Manager already exists';
    END IF;

    -- Agent 4: Render Service Manager
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'saasforge-ai-Render-Service-Manager' AND company_id = company_uuid) THEN
        INSERT INTO agents (id, company_id, name, role, title, status, capabilities, reports_to, adapter_type, adapter_config, runtime_config, permissions, metadata, created_at, updated_at)
        VALUES (
            gen_random_uuid(), 
            company_uuid, 
            'saasforge-ai-Render-Service-Manager', 
            'specialist', 
            'Render Platform Specialist', 
            'idle', 
            'Render service provisioning, infrastructure automation, service lifecycle management',
            manager_uuid, 
            'http', 
            '{}', 
            '{}', 
            '{}', 
            '{"team": "platform-operations", "specialization": "Infrastructure Management", "skills": ["render-service-manager"]}',
            NOW(), 
            NOW()
        );
        RAISE NOTICE 'Created: saasforge-ai-Render-Service-Manager';
    ELSE
        RAISE NOTICE 'saasforge-ai-Render-Service-Manager already exists';
    END IF;
END $$;

-- STEP 2: Verify agents were created
SELECT id, name, role, title, status, reports_to, metadata
FROM agents 
WHERE company_id = '550e8400-e29b-41d4-a716-446655440011'
  AND name LIKE 'saasforge-ai-%'
ORDER BY name;
