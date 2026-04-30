-- Add Safety Research Agents to LearningForge AI
-- This script adds the 5 specialized research agents for the Safety Research Team
-- Created: 2026-04-14

BEGIN;

-- Get LearningForge AI company ID
DO $$
DECLARE
    learningforge_company_id UUID;
    ceo_agent_id UUID;
BEGIN
    -- Get Learning Forge AI company ID (note: name has space in database)
    SELECT id INTO learningforge_company_id
    FROM companies
    WHERE name = 'Learning Forge AI';

    IF learningforge_company_id IS NULL THEN
        RAISE EXCEPTION 'LearningForge AI company not found';
    END IF;

    -- Get or create CEO agent ID for reporting structure
    SELECT id INTO ceo_agent_id
    FROM agents
    WHERE company_id = learningforge_company_id
      AND role = 'ceo';

    IF ceo_agent_id IS NULL THEN
        -- Create CEO agent if it doesn't exist
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
            'learningforge-ai-ceo',
            'ceo',
            'Chief Learning Officer (CEO)',
            'Strategic leadership for AI-powered learning initiatives, research coordination, and continuous improvement across construction and safety domains.',
            'active',
            NULL,
            jsonb_build_object(
                'team', 'executive',
                'specialization', 'Learning Strategy',
                'skills', ARRAY['strategic-leadership', 'research-orchestration', 'continuous-improvement', 'domain-expertise']
            ),
            NOW(),
            NOW()
        ) ON CONFLICT (name) DO NOTHING
        RETURNING id INTO ceo_agent_id;
        
        RAISE NOTICE 'Created LearningForge AI CEO agent';
    END IF;

    -- Add Research Coordinator (Team Lead)
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

    -- Add Safety Research Agent
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
        (SELECT id FROM agents WHERE name = 'learningforge-ai-research-coordinator'),
        jsonb_build_object(
            'team', 'safety-research',
            'specialization', 'Safety Standards Research',
            'skills', ARRAY['safety-standards-research', 'regulatory-compliance', 'construction-safety-analysis', 'osha-standards', 'hse-regulations']
        ),
        NOW(),
        NOW()
    );

    -- Add Mobile Patterns Agent
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
        (SELECT id FROM agents WHERE name = 'learningforge-ai-research-coordinator'),
        jsonb_build_object(
            'team', 'safety-research',
            'specialization', 'Mobile UX Research',
            'skills', ARRAY['mobile-ux-research', 'construction-mobile-patterns', 'glove-friendly-design', 'outdoor-optimization', 'field-usability']
        ),
        NOW(),
        NOW()
    );

    -- Add Domain Knowledge Agent
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
        (SELECT id FROM agents WHERE name = 'learningforge-ai-research-coordinator'),
        jsonb_build_object(
            'team', 'safety-research',
            'specialization', 'Construction Domain Knowledge',
            'skills', ARRAY['construction-expertise', 'safety-inspection-procedures', 'equipment-protocols', 'industry-knowledge-synthesis', 'construction-terminology']
        ),
        NOW(),
        NOW()
    );

    -- Add Learning Integration Agent
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
        (SELECT id FROM agents WHERE name = 'learningforge-ai-research-coordinator'),
        jsonb_build_object(
            'team', 'safety-research',
            'specialization', 'Learning Integration',
            'skills', ARRAY['user-feedback-analysis', 'continuous-learning', 'performance-optimization', 'learning-loop-optimization', 'feedback-synthesis']
        ),
        NOW(),
        NOW()
    );

    RAISE NOTICE 'Successfully added 5 Safety Research Team agents to LearningForge AI';

END $$;

COMMIT;

-- Verification queries
-- Check agent creation
SELECT
    a.name,
    a.title,
    a.capabilities,
    boss.name as reports_to,
    a.metadata->>'team' as team,
    a.metadata->>'specialization' as specialization
FROM agents a
LEFT JOIN agents boss ON a.reports_to = boss.id
WHERE a.company_id = (SELECT id FROM companies WHERE name = 'Learning Forge AI')
  AND a.metadata->>'team' = 'safety-research'
ORDER BY a.created_at;

-- Check team structure
SELECT
    'Safety Research Team' as team,
    COUNT(*) as total_members,
    COUNT(CASE WHEN a.metadata->>'specialization' = 'Research Coordination' THEN 1 END) as coordinators,
    COUNT(CASE WHEN a.metadata->>'specialization' = 'Safety Standards Research' THEN 1 END) as safety_researchers,
    COUNT(CASE WHEN a.metadata->>'specialization' = 'Mobile UX Research' THEN 1 END) as mobile_researchers,
    COUNT(CASE WHEN a.metadata->>'specialization' = 'Construction Domain Knowledge' THEN 1 END) as domain_experts,
    COUNT(CASE WHEN a.metadata->>'specialization' = 'Learning Integration' THEN 1 END) as learning_integrators
FROM agents a
WHERE a.company_id = (SELECT id FROM companies WHERE name = 'Learning Forge AI')
  AND a.metadata->>'team' = 'safety-research';