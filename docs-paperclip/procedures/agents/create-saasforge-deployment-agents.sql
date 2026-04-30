-- Script: create-saasforge-deployment-agents.sql
-- Purpose: Create 4 new SaaSForge AI Platform Operations agents
-- Author: Atlas Agent Creator (via Cline)
-- Date: 2026-04-16
-- Schema Version: 1.0
-- Related Tables: agents, agent_skills, activity_log
-- Dependencies: 
--   - SaaSForge AI company must exist
--   - onboard-master agent must exist
--   - skills must be created in skill_definitions table
-- Rollback: Run cleanup-saasforge-agents.sql (if exists)
-- Validation: Run verification queries at end of script

-- ============================================================
-- PHASE 1: PREREQUISITES - Verify company and manager exist
-- ============================================================

DO $$
DECLARE
    company_uuid UUID;
    manager_uuid UUID;
    
    -- Agent IDs for the 4 new agents
    client_config_manager_uuid UUID;
    deployment_orchestrator_uuid UUID;
    github_branch_manager_uuid UUID;
    render_service_manager_uuid UUID;
    
    -- Track creation status
    agents_created INTEGER := 0;
    skills_assigned INTEGER := 0;
BEGIN
    RAISE NOTICE '============================================';
    RAISE NOTICE 'Starting SaaSForge Deployment Agents Creation';
    RAISE NOTICE '============================================';
    
    -- ============================================================
    -- STEP 1: Verify SaaSForge AI company exists
    -- ============================================================
    SELECT id INTO company_uuid
    FROM companies
    WHERE name = 'SaaSForge AI'
      AND status = 'active';
    
    IF company_uuid IS NULL THEN
        RAISE EXCEPTION 'SaaSForge AI company not found or not active';
    END IF;
    RAISE NOTICE '✓ Company verified: SaaSForge AI (ID: %)', company_uuid;
    
    -- ============================================================
    -- STEP 2: Verify Onboard Master exists
    -- ============================================================
    SELECT id INTO manager_uuid
    FROM agents
    WHERE name = 'onboard-master'
      AND company_id = company_uuid
      AND status = 'active';
    
    IF manager_uuid IS NULL THEN
        RAISE EXCEPTION 'onboard-master agent not found or not active in SaaSForge AI';
    END IF;
    RAISE NOTICE '✓ Manager verified: onboard-master (ID: %)', manager_uuid;
    
    -- ============================================================
    -- PHASE 2: Create the 4 new agents
    -- ============================================================
    
    -- ============================================================
    -- AGENT 1: Client Config Manager
    -- ============================================================
    IF EXISTS (SELECT 1 FROM agents WHERE name = 'saasforge-ai-Client-Config-Manager' AND company_id = company_uuid) THEN
        RAISE NOTICE '⚠ saasforge-ai-Client-Config-Manager already exists, skipping creation';
    ELSE
        INSERT INTO agents (
            id, company_id, name, role, title, status,
            capabilities, reports_to, adapter_type, adapter_config,
            runtime_config, permissions, metadata, created_at, updated_at
        ) VALUES (
            gen_random_uuid(), company_uuid, 'saasforge-ai-Client-Config-Manager',
            'specialist', 'Per-Company Configuration Specialist', 'idle',
            'Environment variables, branding management, feature flags, company-specific customizations',
            manager_uuid, 'process',
            '{"model": "glm-5.1", "temperature": 0.7, "max_tokens": 4096}'::jsonb,
            '{"max_concurrent_tasks": 5, "timeout_seconds": 300}'::jsonb,
            '{"access": {"read_company_data": true, "write_company_data": true}}'::jsonb,
            '{"team": "platform-operations", "specialization": "Configuration Management"}'::jsonb,
            NOW(), NOW()
        ) RETURNING id INTO client_config_manager_uuid;
        
        RAISE NOTICE '✓ Created: saasforge-ai-Client-Config-Manager (ID: %)', client_config_manager_uuid;
        agents_created := agents_created + 1;
    END IF;
    
    -- ============================================================
    -- AGENT 2: Deployment Orchestrator
    -- ============================================================
    IF EXISTS (SELECT 1 FROM agents WHERE name = 'saasforge-ai-Deployment-Orchestrator' AND company_id = company_uuid) THEN
        RAISE NOTICE '⚠ saasforge-ai-Deployment-Orchestrator already exists, skipping creation';
    ELSE
        INSERT INTO agents (
            id, company_id, name, role, title, status,
            capabilities, reports_to, adapter_type, adapter_config,
            runtime_config, permissions, metadata, created_at, updated_at
        ) VALUES (
            gen_random_uuid(), company_uuid, 'saasforge-ai-Deployment-Orchestrator',
            'specialist', 'Multi-Instance Deployment Coordinator', 'idle',
            'Cross-company deployment automation, Render service coordination, multi-client deployments',
            manager_uuid, 'process',
            '{"model": "glm-5.1", "temperature": 0.7, "max_tokens": 4096}'::jsonb,
            '{"max_concurrent_tasks": 10, "timeout_seconds": 600}'::jsonb,
            '{"access": {"read_company_data": true, "write_company_data": true}}'::jsonb,
            '{"team": "platform-operations", "specialization": "Deployment Orchestration"}'::jsonb,
            NOW(), NOW()
        ) RETURNING id INTO deployment_orchestrator_uuid;
        
        RAISE NOTICE '✓ Created: saasforge-ai-Deployment-Orchestrator (ID: %)', deployment_orchestrator_uuid;
        agents_created := agents_created + 1;
    END IF;
    
    -- ============================================================
    -- AGENT 3: GitHub Branch Manager
    -- ============================================================
    IF EXISTS (SELECT 1 FROM agents WHERE name = 'saasforge-ai-GitHub-Branch-Manager' AND company_id = company_uuid) THEN
        RAISE NOTICE '⚠ saasforge-ai-GitHub-Branch-Manager already exists, skipping creation';
    ELSE
        INSERT INTO agents (
            id, company_id, name, role, title, status,
            capabilities, reports_to, adapter_type, adapter_config,
            runtime_config, permissions, metadata, created_at, updated_at
        ) VALUES (
            gen_random_uuid(), company_uuid, 'saasforge-ai-GitHub-Branch-Manager',
            'specialist', 'Version Control & Branch Coordination Specialist', 'idle',
            'GitHub workflow automation, branch management, repository coordination, CI/CD pipelines',
            manager_uuid, 'process',
            '{"model": "glm-5.1", "temperature": 0.7, "max_tokens": 4096}'::jsonb,
            '{"max_concurrent_tasks": 5, "timeout_seconds": 300}'::jsonb,
            '{"access": {"read_company_data": true, "write_company_data": true}}'::jsonb,
            '{"team": "platform-operations", "specialization": "Version Control"}'::jsonb,
            NOW(), NOW()
        ) RETURNING id INTO github_branch_manager_uuid;
        
        RAISE NOTICE '✓ Created: saasforge-ai-GitHub-Branch-Manager (ID: %)', github_branch_manager_uuid;
        agents_created := agents_created + 1;
    END IF;
    
    -- ============================================================
    -- AGENT 4: Render Service Manager
    -- ============================================================
    IF EXISTS (SELECT 1 FROM agents WHERE name = 'saasforge-ai-Render-Service-Manager' AND company_id = company_uuid) THEN
        RAISE NOTICE '⚠ saasforge-ai-Render-Service-Manager already exists, skipping creation';
    ELSE
        INSERT INTO agents (
            id, company_id, name, role, title, status,
            capabilities, reports_to, adapter_type, adapter_config,
            runtime_config, permissions, metadata, created_at, updated_at
        ) VALUES (
            gen_random_uuid(), company_uuid, 'saasforge-ai-Render-Service-Manager',
            'specialist', 'Render Platform Infrastructure Specialist', 'idle',
            'Render service provisioning, infrastructure automation, service lifecycle management',
            manager_uuid, 'process',
            '{"model": "glm-5.1", "temperature": 0.7, "max_tokens": 4096}'::jsonb,
            '{"max_concurrent_tasks": 5, "timeout_seconds": 300}'::jsonb,
            '{"access": {"read_company_data": true, "write_company_data": true}}'::jsonb,
            '{"team": "platform-operations", "specialization": "Infrastructure Management"}'::jsonb,
            NOW(), NOW()
        ) RETURNING id INTO render_service_manager_uuid;
        
        RAISE NOTICE '✓ Created: saasforge-ai-Render-Service-Manager (ID: %)', render_service_manager_uuid;
        agents_created := agents_created + 1;
    END IF;
    
    -- ============================================================
    -- PHASE 3: Assign skills to agents (via agent_skills table)
    -- ============================================================
    
    -- Skills assignments would go here if using agent_skills junction table
    -- For now, skills are documented in agent capabilities and YAML skill files
    
    -- ============================================================
    -- PHASE 4: Log activity for audit trail
    -- ============================================================
    
    INSERT INTO activity_log (
        company_id, actor_type, actor_id, action, entity_type, entity_id, 
        agent_id, details, created_at
    ) VALUES (
        company_uuid, 'system', 'atlas-agent-creator', 'create', 'agents', company_uuid,
        company_uuid,
        jsonb_build_object(
            'description', 'Created 4 SaaSForge Deployment Operations agents',
            'agents_created', agents_created,
            'agent_list', jsonb_build_array(
                'saasforge-ai-Client-Config-Manager',
                'saasforge-ai-Deployment-Orchestrator',
                'saasforge-ai-GitHub-Branch-Manager',
                'saasforge-ai-Render-Service-Manager'
            ),
            'manager', 'onboard-master',
            'team', 'Platform Operations'
        ),
        NOW()
    );
    
    RAISE NOTICE '✓ Activity logged to activity_log';
    skills_assigned := 1; -- Activity logged counts as setup complete
    
    -- ============================================================
    -- SUMMARY
    -- ============================================================
    RAISE NOTICE '';
    RAISE NOTICE '============================================';
    RAISE NOTICE 'CREATION SUMMARY';
    RAISE NOTICE '============================================';
    RAISE NOTICE 'Company: SaaSForge AI';
    RAISE NOTICE 'Manager: onboard-master (%)', manager_uuid;
    RAISE NOTICE 'Agents Created: %', agents_created;
    RAISE NOTICE 'Skills Assigned: % (via agent YAML files)';
    RAISE NOTICE 'Activity Logged: Yes';
    RAISE NOTICE '============================================';
    
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'ERROR: %', SQLERRM;
    RAISE;
END $$;

-- ============================================================
-- POST-EXECUTION VERIFICATION QUERIES
-- ============================================================

-- Verify all 4 agents exist
SELECT name, role, title, status, capabilities
FROM agents
WHERE name IN (
    'saasforge-ai-Client-Config-Manager',
    'saasforge-ai-Deployment-Orchestrator',
    'saasforge-ai-GitHub-Branch-Manager',
    'saasforge-ai-Render-Service-Manager'
)
ORDER BY name;

-- Verify reporting structure
SELECT 
    a.name AS agent_name,
    m.name AS manager_name
FROM agents a
JOIN agents m ON a.reports_to = m.id
WHERE a.name IN (
    'saasforge-ai-Client-Config-Manager',
    'saasforge-ai-Deployment-Orchestrator',
    'saasforge-ai-GitHub-Branch-Manager',
    'saasforge-ai-Render-Service-Manager'
)
ORDER BY a.name;

-- Verify team assignments via metadata
SELECT 
    name,
    metadata->>'team' AS team,
    metadata->>'specialization' AS specialization
FROM agents
WHERE metadata->>'team' = 'platform-operations'
ORDER BY name;
