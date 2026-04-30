-- All Agents Across All Companies - Detailed View
-- Provides comprehensive agent information including company details

SELECT 
    a.id AS agent_id,
    a.name AS agent_name,
    a.role,
    a.title,
    a.status,
    a.adapter_type,
    a.budget_monthly_cents,
    a.spent_monthly_cents,
    a.last_heartbeat_at,
    a.is_active,
    a.pause_reason,
    a.paused_at,
    a.deleted_at,
    a.created_at,
    a.updated_at,
    a.capabilities,
    a.icon,
    a.model_config,
    a.device_config,
    a.adapter_config,
    a.runtime_config,
    a.permissions,
    a.metadata,
    c.id AS company_id,
    c.name AS company_name,
    c.status AS company_status,
    r.name AS reports_to_name,
    r.role AS reports_to_role,
    mc.name AS manager_company_name
FROM 
    public.agents a
LEFT JOIN 
    public.companies c ON a.company_id = c.id
LEFT JOIN 
    public.agents r ON a.reports_to = r.id
LEFT JOIN 
    public.companies mc ON r.company_id = mc.id
WHERE 
    a.deleted_at IS NULL
ORDER BY 
    c.name, a.name;
