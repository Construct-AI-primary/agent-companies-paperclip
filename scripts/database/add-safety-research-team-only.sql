-- Add Safety Research Team Agents Only
-- This script adds ONLY the 5 safety research team agents to Learning Forge AI
-- It does NOT modify existing agents or depend on specific agent IDs
-- Created: 2026-04-15

BEGIN;

-- Get Learning Forge AI company ID
DO $$
DECLARE
    learningforge_company_id UUID;
    research_coordinator_id UUID;
BEGIN
    -- Get Learning Forge AI company ID
    SELECT id INTO learningforge_company_id
    FROM companies
    WHERE name = 'Learning Forge AI';

    IF learningforge_company_id IS NULL THEN
        RAISE EXCEPTION 'Learning Forge AI company not found';
    END IF;

    RAISE NOTICE 'Adding Safety Research Team agents to Learning Forge AI (company_id: %)', learningforge_company_id;

    -- 1. Create Research Coordinator (Team Lead) if not exists
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Jax' AND company_id = learningforge_company_id) THEN
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
            'Jax',
            'general',
            'Research Coordinator - Safety Research Team Lead',
            'Overall research project management, methodology development, cross-agent coordination, and quality assurance for construction safety research initiatives.',
            'active',
            NULL, -- Will be updated to CEO later if needed
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

    -- 2. Create Safety Research Agent if not exists
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Nova' AND company_id = learningforge_company_id) THEN
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
            'Nova',
            'general',
            'Safety Research Agent',
            'Comprehensive research on OSHA standards, HSE regulations, and construction safety compliance for regulatory compliance and safety protocol development.',
            'active',
            NULL, -- Will be updated to Research Coordinator later
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

    -- 3. Create Mobile Patterns Agent if not exists
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Phoenix' AND company_id = learningforge_company_id) THEN
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
            'Phoenix',
            'general',
            'Mobile Patterns Agent',
            'Research on construction industry mobile UX patterns, glove-friendly interfaces, and outdoor optimization for field operations and usability.',
            'active',
            NULL, -- Will be updated to Research Coordinator later
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

    -- 4. Create Domain Knowledge Agent if not exists
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Sage' AND company_id = learningforge_company_id) THEN
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
            'Sage',
            'general',
            'Domain Knowledge Agent',
            'Research on construction industry expertise, safety inspection procedures, and equipment protocols for comprehensive domain knowledge.',
            'active',
            NULL, -- Will be updated to Research Coordinator later
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

    -- 5. Create Learning Integration Agent if not exists
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'Echo' AND company_id = learningforge_company_id) THEN
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
            'Echo',
            'general',
            'Learning Integration Agent',
            'Research on user feedback analysis, continuous learning, and performance optimization for effective research integration and capability enhancement.',
            'active',
            NULL, -- Will be updated to Research Coordinator later
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

    -- Now update reporting relationships
    -- Get Research Coordinator ID
    SELECT id INTO research_coordinator_id
    FROM agents
    WHERE name = 'Jax'
      AND company_id = learningforge_company_id;

    IF research_coordinator_id IS NOT NULL THEN
        -- Update research agents to report to Research Coordinator
        UPDATE agents
        SET reports_to = research_coordinator_id,
            updated_at = NOW()
        WHERE company_id = learningforge_company_id
          AND name IN (
            'Nova',
            'Phoenix',
            'Sage',
            'Echo'
          )
          AND reports_to IS NULL;

        RAISE NOTICE 'Updated reporting relationships for research agents';
    END IF;

    -- Update Research Coordinator to report to CEO if CEO exists
    UPDATE agents
    SET reports_to = (
        SELECT id FROM agents
        WHERE name = 'learningforge-ai-ceo'
          AND company_id = learningforge_company_id
          AND role = 'ceo'
        LIMIT 1
    ),
    updated_at = NOW()
    WHERE name = 'Jax'
      AND company_id = learningforge_company_id
      AND reports_to IS NULL;

    RAISE NOTICE 'Successfully added/updated Safety Research Team agents';

END $$;

COMMIT;

-- Verification: Show the 5 safety research team agents
SELECT
    a.name,
    a.title,
    a.role,
    boss.name as reports_to,
    a.metadata->>'team' as team,
    a.metadata->>'specialization' as specialization,
    CASE
        WHEN a.name = 'Jax' THEN 'Team Lead'
        WHEN a.name IN ('Nova', 'Phoenix', 'Sage', 'Echo') THEN 'Research Agent'
        ELSE 'Other'
    END as agent_type
FROM agents a
LEFT JOIN agents boss ON a.reports_to = boss.id
WHERE a.company_id = (SELECT id FROM companies WHERE name = 'Learning Forge AI')
  AND a.metadata->>'team' = 'safety-research'
ORDER BY
    CASE
        WHEN a.name = 'Jax' THEN 1
        ELSE 2
    END,
    a.name;
