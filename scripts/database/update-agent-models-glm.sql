-- Update GLM model IDs to valid Z.ai OpenRouter models in agent_models table
-- This script replaces all instances of invalid GLM models with their Z.ai equivalents

-- Update GLM-4-Plus to z-ai/glm-4.7-flash
UPDATE agent_models
SET model_id = 'z-ai/glm-4.7-flash'
WHERE model_id = 'GLM-4-Plus';

-- Update GLM-3-Turbo to Z.ai: GLM 5 Turbo
UPDATE agent_models
SET model_id = 'Z.ai: GLM 5 Turbo'
WHERE model_id = 'GLM-3-Turbo';

-- Update GLM-5.1 to Z.ai: GLM 5.1
UPDATE agent_models
SET model_id = 'Z.ai: GLM 5.1'
WHERE model_id = 'GLM-5.1';

-- Verify the changes
SELECT
    COUNT(*) as total_agent_models,
    COUNT(CASE WHEN model_id = 'z-ai/glm-4.7-flash' THEN 1 END) as updated_to_glm_47_flash,
    COUNT(CASE WHEN model_id = 'Z.ai: GLM 5 Turbo' THEN 1 END) as updated_to_glm_5_turbo,
    COUNT(CASE WHEN model_id = 'Z.ai: GLM 5.1' THEN 1 END) as updated_to_glm_51,
    COUNT(CASE WHEN model_id IN ('GLM-4-Plus', 'GLM-3-Turbo', 'GLM-5.1') THEN 1 END) as remaining_old_models
FROM agent_models;

-- Show all affected agents
SELECT
    a.name as agent_name,
    am.model_id,
    am.assignment_type,
    am.is_active
FROM agents a
JOIN agent_models am ON a.id::text = am.agent_id
WHERE am.model_id IN ('z-ai/glm-4.7-flash', 'Z.ai: GLM 5 Turbo', 'Z.ai: GLM 5.1')
ORDER BY am.model_id, a.name;
