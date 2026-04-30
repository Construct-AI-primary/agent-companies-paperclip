-- ==========================================
-- Show Current Model Usage Statistics
-- Created: 2026-04-23
-- Description: Query to show current model distribution across all agents
-- ==========================================

-- Current model distribution by model and assignment type
SELECT
    model_id,
    assignment_type,
    COUNT(*) as assignments_count,
    COUNT(CASE WHEN is_active THEN 1 END) as active_assignments,
    COUNT(DISTINCT agent_id) as unique_agents
FROM agent_models
GROUP BY model_id, assignment_type
ORDER BY COUNT(*) DESC, model_id, assignment_type;

-- Summary by model only
SELECT
    model_id,
    COUNT(*) as total_assignments,
    COUNT(CASE WHEN is_active THEN 1 END) as active_assignments,
    COUNT(DISTINCT agent_id) as unique_agents_affected,
    ROUND(
        COUNT(CASE WHEN is_active THEN 1 END)::numeric /
        NULLIF(COUNT(*), 0) * 100, 1
    ) as active_percentage
FROM agent_models
GROUP BY model_id
ORDER BY total_assignments DESC;

-- Agents with no model assignments
SELECT
    COUNT(DISTINCT a.name) as agents_without_assignments,
    COUNT(DISTINCT a.company_id) as companies_affected
FROM agents a
LEFT JOIN agent_models am ON a.name = am.agent_id
WHERE am.agent_id IS NULL;

-- Model usage by company
SELECT
    c.name as company_name,
    am.model_id,
    COUNT(*) as assignments_count,
    COUNT(DISTINCT am.agent_id) as agents_using_model
FROM agent_models am
JOIN agents a ON am.agent_id = a.name
JOIN companies c ON a.company_id = c.id
WHERE am.is_active = true
GROUP BY c.name, am.model_id
ORDER BY c.name, COUNT(*) DESC;

-- Most popular models overall
SELECT
    model_id,
    COUNT(*) as usage_count,
    COUNT(DISTINCT agent_id) as unique_agents,
    MAX(updated_at) as last_updated
FROM agent_models
WHERE is_active = true
GROUP BY model_id
ORDER BY usage_count DESC
LIMIT 10;