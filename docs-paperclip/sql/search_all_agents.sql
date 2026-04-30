-- Search all agents across all companies
SELECT
    c.name as company_name,
    a.id,
    a.name,
    a.role,
    a.title,
    a.status,
    a.created_at,
    jsonb_array_length(COALESCE(a.adapter_config->'skills', '[]'::jsonb)) as skill_count
FROM agents a
LEFT JOIN companies c ON a.company_id = c.id
ORDER BY a.created_at DESC
LIMIT 50;