-- ============================================================
-- MODEL MIGRATION: ANTHROPIC → CHINESE MODELS
-- Date: 2026-04-22
-- Purpose: Replace Anthropic models with equivalent Chinese models
-- Fix null model configuration
-- Safety: Transactional updates with rollback capability
-- ============================================================

-- ============================================================
-- EXECUTION INSTRUCTIONS
-- ============================================================
-- 1. Run this script in Supabase SQL Editor
-- 2. Check the before/after counts to verify changes
-- 3. All changes are within transactions for safety
-- ============================================================

BEGIN;

-- PHASE 1: PRE-MIGRATION VERIFICATION
-- ============================================================

DO $$
BEGIN
    RAISE NOTICE '🔄 STARTING MODEL MIGRATION: Anthropic → Chinese Models';
    RAISE NOTICE 'Checking current model distribution...';
END $$;

-- Show current model distribution before migration
SELECT
    'PRE-MIGRATION MODEL DISTRIBUTION' as phase,
    adapter_config->>'model' as current_model,
    COUNT(*) as agents_count,
    ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (), 1) as percentage
FROM agents
GROUP BY adapter_config->>'model'
ORDER BY agents_count DESC;

-- Show agents with null models
SELECT
    'AGENTS WITH NULL MODELS' as issue_check,
    COUNT(*) as null_model_count,
    array_agg(name ORDER BY name) as affected_agents
FROM agents
WHERE adapter_config->>'model' IS NULL;

-- PHASE 2: MODEL MIGRATION
-- ============================================================

DO $$
BEGIN
    RAISE NOTICE 'Updating Claude Opus models to GLM-5.1...';
END $$;

-- 1. Claude Opus 4.6 → GLM-5.1 (High reasoning equivalent - latest GLM model)
UPDATE agents
SET adapter_config = jsonb_set(
    adapter_config,
    '{model}',
    '"z-ai/glm-5.1"'
)
WHERE adapter_config->>'model' = 'anthropic/claude-opus-4.6';

DO $$
BEGIN
    RAISE NOTICE 'Updating Claude Sonnet models to GLM-4...';
END $$;

-- 2. Claude Sonnet 3.5 → GLM-4 (Balanced performance equivalent)
UPDATE agents
SET adapter_config = jsonb_set(
    adapter_config,
    '{model}',
    '"z-ai/glm-4"'
)
WHERE adapter_config->>'model' = 'anthropic/claude-sonnet-3.5';

DO $$
BEGIN
    RAISE NOTICE 'Updating Claude Haiku models to GLM-4 Flash...';
END $$;

-- 3. Claude Haiku 3.5 → GLM-4 Flash (Fast/lightweight equivalent)
UPDATE agents
SET adapter_config = jsonb_set(
    adapter_config,
    '{model}',
    '"z-ai/glm-4-flash"'
)
WHERE adapter_config->>'model' = 'anthropic/claude-haiku-3.5';

DO $$
BEGIN
    RAISE NOTICE 'Fixing null model configurations...';
END $$;

-- 4. Fix null models → GLM-4 (default high-performance model)
UPDATE agents
SET adapter_config = jsonb_set(
    COALESCE(adapter_config, '{}'::jsonb),
    '{model}',
    '"z-ai/glm-4"'
)
WHERE adapter_config->>'model' IS NULL;

-- PHASE 3: POST-MIGRATION VERIFICATION
-- ============================================================

DO $$
BEGIN
    RAISE NOTICE '✅ MODEL MIGRATION COMPLETED - Running verification...';
END $$;

-- Show model distribution after migration
SELECT
    'POST-MIGRATION MODEL DISTRIBUTION' as phase,
    adapter_config->>'model' as updated_model,
    COUNT(*) as agents_count,
    ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (), 1) as percentage
FROM agents
GROUP BY adapter_config->>'model'
ORDER BY agents_count DESC;

-- Verify no null models remain
SELECT
    'NULL MODEL VERIFICATION' as final_check,
    COUNT(*) as remaining_null_models,
    CASE
        WHEN COUNT(*) = 0 THEN '✅ SUCCESS - All null models fixed'
        ELSE '❌ ERROR - Null models still exist'
    END as status
FROM agents
WHERE adapter_config->>'model' IS NULL;

-- Migration summary
SELECT
    'MIGRATION SUMMARY' as report,
    COUNT(*) as total_agents,
    COUNT(CASE WHEN adapter_config->>'model' LIKE 'z-ai/%' THEN 1 END) as chinese_models,
    COUNT(CASE WHEN adapter_config->>'model' LIKE 'anthropic/%' THEN 1 END) as remaining_anthropic,
    COUNT(CASE WHEN adapter_config->>'model' LIKE 'openrouter/%' THEN 1 END) as openrouter_models,
    ROUND((
        COUNT(CASE WHEN adapter_config->>'model' LIKE 'z-ai/%' THEN 1 END) * 100.0
    ) / COUNT(*), 1) as chinese_model_percentage
FROM agents;

COMMIT;

-- ============================================================
-- ROLLBACK INSTRUCTIONS (if needed)
-- ============================================================
-- If you need to rollback, run this before the migration:
-- UPDATE agents SET adapter_config = jsonb_set(adapter_config, '{model}', '"anthropic/claude-opus-4.6"') WHERE adapter_config->>'model' = 'z-ai/glm-4-plus';
-- UPDATE agents SET adapter_config = jsonb_set(adapter_config, '{model}', '"anthropic/claude-sonnet-3.5"') WHERE adapter_config->>'model' = 'z-ai/glm-4';
-- UPDATE agents SET adapter_config = jsonb_set(adapter_config, '{model}', '"anthropic/claude-haiku-3.5"') WHERE adapter_config->>'model' = 'z-ai/glm-4-flash';
-- ============================================================

DO $$
DECLARE
    chinese_count INTEGER;
    total_count INTEGER;
    null_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO total_count FROM agents;
    SELECT COUNT(*) INTO chinese_count FROM agents WHERE adapter_config->>'model' LIKE 'z-ai/%';
    SELECT COUNT(*) INTO null_count FROM agents WHERE adapter_config->>'model' IS NULL;

    RAISE NOTICE '🎉 MODEL MIGRATION COMPLETE!';
    RAISE NOTICE 'Total agents: %', total_count;
    RAISE NOTICE 'Chinese models: % (% of total)', chinese_count, ROUND((chinese_count * 100.0) / total_count, 1);
    RAISE NOTICE 'Null models fixed: %', CASE WHEN null_count = 0 THEN 'All fixed' ELSE 'Still have nulls' END;

    IF chinese_count > 0 AND null_count = 0 THEN
        RAISE NOTICE '✅ SUCCESS - Migration completed successfully!';
    ELSE
        RAISE NOTICE '⚠️ WARNING - Migration may have issues, check results above';
    END IF;
END $$;