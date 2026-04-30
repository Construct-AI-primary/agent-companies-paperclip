-- Check what LearningForge company actually exists in the database
SELECT id, name, status, is_active
FROM companies
WHERE name ILIKE '%learning%'
ORDER BY name;

-- Also count agents per company matching "learning"
SELECT 
    c.name as company_name,
    COUNT(a.id) as agent_count,
    COUNT(CASE WHEN a.is_active = true THEN 1 END) as active_agents
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
WHERE c.name ILIKE '%learning%'
GROUP BY c.name;
