-- Create or Update LearningForge AI Company
-- This script ensures the LearningForge AI company exists in the database
-- Created: 2026-04-15
-- Updated: 2026-04-15 - Made conditional to avoid duplicate company creation

-- Note: Company already exists as 'Learning Forge AI' with ID '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
-- This script ensures the company exists with correct configuration

-- Check if company exists, if not insert, if yes update
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM companies WHERE id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a') THEN
        -- Update existing company
        UPDATE companies SET
            name = 'Learning Forge AI',
            description = 'AI-powered learning and research company specializing in continuous improvement, domain knowledge enhancement, and automated research for construction and safety applications',
            status = 'active',
            issue_prefix = 'LFA',
            brand_color = '#10B981',
            updated_at = NOW()
        WHERE id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a';
        RAISE NOTICE 'Updated Learning Forge AI company';
    ELSE
        -- Insert new company
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
            created_at,
            updated_at
        ) VALUES (
            '2bda2da6-dfa7-4709-b5d1-ea865f14072a',
            'Learning Forge AI',
            'AI-powered learning and research company specializing in continuous improvement, domain knowledge enhancement, and automated research for construction and safety applications',
            'active',
            'LFA',
            0,
            0,
            0,
            true,
            '#10B981',
            NOW(),
            NOW()
        );
        RAISE NOTICE 'Created Learning Forge AI company';
    END IF;
END $$;

-- Add CEO agent for LearningForge AI (if not exists)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM agents WHERE name = 'learningforge-ai-ceo') THEN
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
            '2bda2da6-dfa7-4709-b5d1-ea865f14072a',  -- Learning Forge AI company ID (from database)
            'learningforge-ai-ceo',
            'ceo',
            'Chief Learning Officer (CEO)',
            'Strategic leadership for AI-powered learning initiatives, research coordination, and continuous improvement across construction and safety domains.',
            'active',
            NULL,  -- CEOs don't report to anyone
            jsonb_build_object(
                'team', 'executive',
                'specialization', 'Learning Strategy',
                'skills', ARRAY['strategic-leadership', 'research-orchestration', 'continuous-improvement', 'domain-expertise']
            ),
            NOW(),
            NOW()
        );
        RAISE NOTICE 'Created Learning Forge AI CEO agent';
    ELSE
        RAISE NOTICE 'Learning Forge AI CEO agent already exists';
    END IF;
END $$;

-- Add model assignment for CEO (if not exists)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM agent_models WHERE agent_id = 'learningforge-ai-ceo' AND assignment_type = 'primary') THEN
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
        ) VALUES (
            'learningforge-ai-ceo',
            'GLM-5.1',  -- Advanced reasoning for strategic leadership
            'primary',
            1,
            0.3,  -- Controlled temperature for strategic decisions
            4096,
            NOW(),
            'system',
            'Primary model for CEO strategic reasoning and leadership',
            true
        );
        RAISE NOTICE 'Added primary model (GLM-5.1) for CEO';
    ELSE
        RAISE NOTICE 'CEO primary model already exists';
    END IF;
END $$;

-- Add fallback model for CEO (if not exists)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM agent_models WHERE agent_id = 'learningforge-ai-ceo' AND assignment_type = 'fallback') THEN
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
        ) VALUES (
            'learningforge-ai-ceo',
            'Z.ai: GLM 5 Turbo',  -- Reliable fallback
            'fallback',
            2,
            0.3,
            4096,
            NOW(),
            'system',
            'Fallback model for reliability when primary model is unavailable',
            true
        );
        RAISE NOTICE 'Added fallback model (Z.ai: GLM 5 Turbo) for CEO';
    ELSE
        RAISE NOTICE 'CEO fallback model already exists';
    END IF;
END $$;

-- Verification queries
-- Check company creation
SELECT id, name, issue_prefix, status, brand_color
FROM companies
WHERE name = 'Learning Forge AI';

-- Check CEO agent creation
SELECT a.name, a.title, a.role, a.status, am.model_id, am.assignment_type
FROM agents a
LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
WHERE a.company_id = (SELECT id FROM companies WHERE name = 'Learning Forge AI')
  AND a.role = 'ceo';
