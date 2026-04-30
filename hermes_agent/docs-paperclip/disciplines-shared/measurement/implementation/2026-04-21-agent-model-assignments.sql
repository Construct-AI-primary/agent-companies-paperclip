-- ========================================================================================
-- Measurement Platform Agent Model Assignments
-- Created: 2026-04-21
-- Description: Complete AI model assignments for all measurement platform agents
-- Prerequisites: All agents must be registered in the agents table
-- ========================================================================================

-- Enable transaction for atomicity
BEGIN;

-- ================================================================================
-- FIRST: Clean up any existing assignments for these agents
-- ================================================================================

DELETE FROM agent_models
WHERE agent_id IN (
  'paperclipforge-ai-measurement-validation-specialist',
  'paperclipforge-ai-measurement-standards-specialist',
  'paperclipforge-ai-measurement-coordination-specialist',
  'paperclipforge-ai-advanced-engineering-analysis',
  'paperclipforge-ai-cross-discipline-coordination',
  'paperclipforge-ai-engineering-ui-specialist'
);

-- ================================================================================
-- MEASUREMENT VALIDATION SPECIALIST - Validation Vera
-- ================================================================================

INSERT INTO agent_models (
  agent_id, model_id, assignment_type, priority,
  temperature, max_tokens, assigned_at, assigned_by,
  reason, is_active
) VALUES (
  'paperclipforge-ai-measurement-validation-specialist',
  'qwen/qwen2.5-72b-instruct',
  'primary',
  1,
  0.1,
  6144,
  NOW(),
  'system',
  'Primary model for measurement validation and quality assurance with high precision requirements using Alibaba Qwen',
  true
);

INSERT INTO agent_models (
  agent_id, model_id, assignment_type, priority,
  temperature, max_tokens, assigned_at, assigned_by,
  reason, is_active
) VALUES (
  'paperclipforge-ai-measurement-validation-specialist',
  'ernie/ernie-4.0-8k',
  'fallback',
  2,
  0.1,
  6144,
  NOW(),
  'system',
  'Fallback model for measurement validation using Baidu ERNIE when primary model is unavailable',
  true
);

-- ================================================================================
-- MEASUREMENT STANDARDS SPECIALIST - Standards Stella
-- ================================================================================

INSERT INTO agent_models (
  agent_id, model_id, assignment_type, priority,
  temperature, max_tokens, assigned_at, assigned_by,
  reason, is_active
) VALUES (
  'paperclipforge-ai-measurement-standards-specialist',
  'hunyuan/hunyuan-turbo',
  'primary',
  1,
  0.05,
  8192,
  NOW(),
  'system',
  'Primary model for standards compliance and regulatory validation requiring maximum accuracy using Tencent Hunyuan',
  true
);

INSERT INTO agent_models (
  agent_id, model_id, assignment_type, priority,
  temperature, max_tokens, assigned_at, assigned_by,
  reason, is_active
) VALUES (
  'paperclipforge-ai-measurement-standards-specialist',
  'spark/spark-max',
  'fallback',
  2,
  0.05,
  8192,
  NOW(),
  'system',
  'Fallback model for standards validation using iFlytek Spark with strong reasoning capabilities',
  true
);

-- ================================================================================
-- MEASUREMENT COORDINATION SPECIALIST - Measurement Molly
-- ================================================================================

INSERT INTO agent_models (
  agent_id, model_id, assignment_type, priority,
  temperature, max_tokens, assigned_at, assigned_by,
  reason, is_active
) VALUES (
  'paperclipforge-ai-measurement-coordination-specialist',
  'ernie/ernie-3.5-8k',
  'primary',
  1,
  0.3,
  4096,
  NOW(),
  'system',
  'Primary model for workflow coordination requiring balanced creativity and precision using Baidu ERNIE',
  true
);

INSERT INTO agent_models (
  agent_id, model_id, assignment_type, priority,
  temperature, max_tokens, assigned_at, assigned_by,
  reason, is_active
) VALUES (
  'paperclipforge-ai-measurement-coordination-specialist',
  'qwen/qwen2.5-14b-instruct',
  'fallback',
  2,
  0.3,
  4096,
  NOW(),
  'system',
  'Fallback model for coordination tasks with fast processing capabilities using Alibaba Qwen',
  true
);

-- ================================================================================
-- ADVANCED ENGINEERING ANALYSIS - Analysis Andy
-- ================================================================================

INSERT INTO agent_models (
  agent_id, model_id, assignment_type, priority,
  temperature, max_tokens, assigned_at, assigned_by,
  reason, is_active
) VALUES (
  'paperclipforge-ai-advanced-engineering-analysis',
  'hunyuan/hunyuan-pro',
  'primary',
  1,
  0.2,
  8192,
  NOW(),
  'system',
  'Primary model for complex engineering analysis requiring high reasoning and calculation accuracy using Tencent Hunyuan',
  true
);

INSERT INTO agent_models (
  agent_id, model_id, assignment_type, priority,
  temperature, max_tokens, assigned_at, assigned_by,
  reason, is_active
) VALUES (
  'paperclipforge-ai-advanced-engineering-analysis',
  'ernie/ernie-4.0-8k',
  'fallback',
  2,
  0.2,
  8192,
  NOW(),
  'system',
  'Fallback model for engineering analysis with strong mathematical capabilities using Baidu ERNIE',
  true
);

-- ================================================================================
-- CROSS-DISCIPLINE COORDINATION - Coordination Charlie
-- ================================================================================

INSERT INTO agent_models (
  agent_id, model_id, assignment_type, priority,
  temperature, max_tokens, assigned_at, assigned_by,
  reason, is_active
) VALUES (
  'paperclipforge-ai-cross-discipline-coordination',
  'qwen/qwen2.5-32b-instruct',
  'primary',
  1,
  0.4,
  6144,
  NOW(),
  'system',
  'Primary model for interdisciplinary coordination requiring communication and mediation skills using Alibaba Qwen',
  true
);

INSERT INTO agent_models (
  agent_id, model_id, assignment_type, priority,
  temperature, max_tokens, assigned_at, assigned_by,
  reason, is_active
) VALUES (
  'paperclipforge-ai-cross-discipline-coordination',
  'spark/spark-pro',
  'fallback',
  2,
  0.4,
  6144,
  NOW(),
  'system',
  'Fallback model for complex coordination scenarios requiring higher reasoning using iFlytek Spark',
  true
);

-- ================================================================================
-- ENGINEERING UI SPECIALIST - UI Specialist Uma
-- ================================================================================

INSERT INTO agent_models (
  agent_id, model_id, assignment_type, priority,
  temperature, max_tokens, assigned_at, assigned_by,
  reason, is_active
) VALUES (
  'paperclipforge-ai-engineering-ui-specialist',
  'ernie/ernie-speed-8k',
  'primary',
  1,
  0.6,
  4096,
  NOW(),
  'system',
  'Primary model for UI design requiring creativity and user experience focus using Baidu ERNIE',
  true
);

INSERT INTO agent_models (
  agent_id, model_id, assignment_type, priority,
  temperature, max_tokens, assigned_at, assigned_by,
  reason, is_active
) VALUES (
  'paperclipforge-ai-engineering-ui-specialist',
  'hunyuan/hunyuan-lite',
  'fallback',
  2,
  0.6,
  4096,
  NOW(),
  'system',
  'Fallback model for UI design with strong visual and creative capabilities using Tencent Hunyuan',
  true
);

-- ================================================================================
-- VERIFICATION QUERIES
-- ================================================================================

-- Verify all model assignments
SELECT
    a.name as agent_name,
    a.title,
    am.model_id,
    am.assignment_type,
    am.priority,
    am.temperature,
    am.max_tokens,
    am.is_active
FROM agents a
LEFT JOIN agent_models am ON a.name = am.agent_id
WHERE a.name LIKE 'paperclipforge-ai-%'
ORDER BY a.name, am.priority;

-- Count total assignments per agent
SELECT
    a.name as agent_name,
    COUNT(am.*) as total_assignments,
    COUNT(CASE WHEN am.assignment_type = 'primary' THEN 1 END) as primary_models,
    COUNT(CASE WHEN am.assignment_type = 'fallback' THEN 1 END) as fallback_models
FROM agents a
LEFT JOIN agent_models am ON a.name = am.agent_id
WHERE a.name LIKE 'paperclipforge-ai-%'
GROUP BY a.name
ORDER BY a.name;

-- ================================================================================
-- PERFORMANCE MONITORING SETUP (REMOVED - Table does not exist in schema)
-- ================================================================================

-- Note: measurement_performance_baselines table is not defined in current schema
-- Performance monitoring will need to be implemented separately when the table is created

-- ================================================================================
-- CLEANUP: Uncomment to remove all assignments for an agent
-- ================================================================================

-- DELETE FROM agent_models WHERE agent_id = 'paperclipforge-ai-measurement-validation-specialist';
-- DELETE FROM agent_models WHERE agent_id = 'paperclipforge-ai-measurement-standards-specialist';
-- DELETE FROM agent_models WHERE agent_id = 'paperclipforge-ai-measurement-coordination-specialist';
-- DELETE FROM agent_models WHERE agent_id = 'paperclipforge-ai-advanced-engineering-analysis';
-- DELETE FROM agent_models WHERE agent_id = 'paperclipforge-ai-cross-discipline-coordination';
-- DELETE FROM agent_models WHERE agent_id = 'paperclipforge-ai-engineering-ui-specialist';

COMMIT;

-- ========================================================================================
-- END OF AGENT MODEL ASSIGNMENTS
-- ========================================================================================