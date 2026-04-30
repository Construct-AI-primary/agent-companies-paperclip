-- Populate Learning Forge AI Agents from Documentation
-- This script creates all Learning Forge AI agents based on the documentation structure
-- Created: 2026-04-15
-- Updated: 2026-04-15 - Fixed ON CONFLICT constraint issues

BEGIN;

-- Get Learning Forge AI company ID
DO $$
DECLARE
    learningforge_company_id UUID;
    ceo_agent_id UUID;
    research_coordinator_id UUID;
BEGIN
    -- Get Learning Forge AI company ID
    SELECT id INTO learningforge_company_id
    FROM companies
    WHERE name = 'Learning Forge AI';

    IF learningforge_company_id IS NULL THEN
        RAISE EXCEPTION 'Learning Forge AI company not found';
    END IF;

    -- Get CEO agent ID
    SELECT id INTO ceo_agent_id
    FROM agents
    WHERE name = 'learningforge-ai-ceo'
      AND company_id = learningforge_company_id;

    IF ceo_agent_id IS NULL THEN
        RAISE EXCEPTION 'Learning Forge AI CEO agent not found. Run create-learningforge-company.sql first.';
    END IF;

    -- Create Research Coordinator (Team Lead for Safety Research Team) if not exists
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'learningforge-ai-research-coordinator') THEN
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
        ) VALUES (
            gen_random_uuid(),
            learningforge_company_id,
            'learningforge-ai-research-coordinator',
            'general',
            'Research Coordinator - Safety Research Team Lead',
            'Overall research project management, methodology development, cross-agent coordination, and quality assurance for construction safety research initiatives.',
            'active',
            ceo_agent_id,
            jsonb_build_object(
                'team', 'safety-research',
                'specialization', 'Research Coordination',
                'skills', ARRAY['research-coordination', 'methodology-development', 'cross-agent-collaboration', 'quality-assurance', 'project-management']
            ),
            NOW(),
            NOW()
        );
        RAISE NOTICE 'Created Research Coordinator agent';
    ELSE
        RAISE NOTICE 'Research Coordinator agent already exists';
    END IF;

    -- Get Research Coordinator ID
    SELECT id INTO research_coordinator_id
    FROM agents
    WHERE name = 'learningforge-ai-research-coordinator'
      AND company_id = learningforge_company_id;

    -- Create Safety Research Agent if not exists
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'learningforge-ai-safety-research-agent') THEN
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
        ) VALUES (
            gen_random_uuid(),
            learningforge_company_id,
            'learningforge-ai-safety-research-agent',
            'general',
            'Safety Research Agent',
            'Comprehensive research on OSHA standards, HSE regulations, and construction safety compliance for regulatory compliance and safety protocol development.',
            'active',
            research_coordinator_id,
            jsonb_build_object(
                'team', 'safety-research',
                'specialization', 'Safety Standards Research',
                'skills', ARRAY['safety-standards-research', 'regulatory-compliance', 'construction-safety-analysis', 'osha-standards', 'hse-regulations']
            ),
            NOW(),
            NOW()
        );
        RAISE NOTICE 'Created Safety Research Agent';
    ELSE
        RAISE NOTICE 'Safety Research Agent already exists';
    END IF;

    -- Create Mobile Patterns Agent if not exists
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'learningforge-ai-mobile-patterns-agent') THEN
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
        ) VALUES (
            gen_random_uuid(),
            learningforge_company_id,
            'learningforge-ai-mobile-patterns-agent',
            'general',
            'Mobile Patterns Agent',
            'Research on construction industry mobile UX patterns, glove-friendly interfaces, and outdoor optimization for field operations and usability.',
            'active',
            research_coordinator_id,
            jsonb_build_object(
                'team', 'safety-research',
                'specialization', 'Mobile UX Research',
                'skills', ARRAY['mobile-ux-research', 'construction-mobile-patterns', 'glove-friendly-design', 'outdoor-optimization', 'field-usability']
            ),
            NOW(),
            NOW()
        );
        RAISE NOTICE 'Created Mobile Patterns Agent';
    ELSE
        RAISE NOTICE 'Mobile Patterns Agent already exists';
    END IF;

    -- Create Domain Knowledge Agent if not exists
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'learningforge-ai-domain-knowledge-agent') THEN
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
        ) VALUES (
            gen_random_uuid(),
            learningforge_company_id,
            'learningforge-ai-domain-knowledge-agent',
            'general',
            'Domain Knowledge Agent',
            'Research on construction industry expertise, safety inspection procedures, and equipment protocols for comprehensive domain knowledge.',
            'active',
            research_coordinator_id,
            jsonb_build_object(
                'team', 'safety-research',
                'specialization', 'Construction Domain Knowledge',
                'skills', ARRAY['construction-expertise', 'safety-inspection-procedures', 'equipment-protocols', 'industry-knowledge-synthesis', 'construction-terminology']
            ),
            NOW(),
            NOW()
        );
        RAISE NOTICE 'Created Domain Knowledge Agent';
    ELSE
        RAISE NOTICE 'Domain Knowledge Agent already exists';
    END IF;

    -- Create Learning Integration Agent if not exists
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'learningforge-ai-learning-integration-agent') THEN
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
        ) VALUES (
            gen_random_uuid(),
            learningforge_company_id,
            'learningforge-ai-learning-integration-agent',
            'general',
            'Learning Integration Agent',
            'Research on user feedback analysis, continuous learning, and performance optimization for effective research integration and capability enhancement.',
            'active',
            research_coordinator_id,
            jsonb_build_object(
                'team', 'safety-research',
                'specialization', 'Learning Integration',
                'skills', ARRAY['user-feedback-analysis', 'continuous-learning', 'performance-optimization', 'learning-loop-optimization', 'feedback-synthesis']
            ),
            NOW(),
            NOW()
        );
        RAISE NOTICE 'Created Learning Integration Agent';
    ELSE
        RAISE NOTICE 'Learning Integration Agent already exists';
    END IF;

    RAISE NOTICE 'Successfully populated Learning Forge AI Safety Research Team agents';

END $$;

COMMIT;

-- Verification queries
-- Count agents by team
SELECT
    COALESCE(a.metadata->>'team', 'no-team') as team,
    COUNT(*) as agent_count,
    STRING_AGG(a.name, ', ') as agents
FROM agents a
WHERE a.company_id = (SELECT id FROM companies WHERE name = 'Learning Forge AI')
GROUP BY COALESCE(a.metadata->>'team', 'no-team')
ORDER BY agent_count DESC;

-- Show agent hierarchy
SELECT
    a.name,
    a.title,
    a.role,
    boss.name as reports_to,
    a.metadata->>'team' as team,
    a.metadata->>'specialization' as specialization
FROM agents a
LEFT JOIN agents boss ON a.reports_to = boss.id
WHERE a.company_id = (SELECT id FROM companies WHERE name = 'Learning Forge AI')
ORDER BY 
    CASE WHEN a.role = 'ceo' THEN 1 ELSE 2 END,
    a.metadata->>'team',
    a.name;