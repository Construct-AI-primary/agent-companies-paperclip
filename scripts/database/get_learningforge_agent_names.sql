-- Get all Learning Forge AI agent names for mapping
SELECT 
    a.name as agent_name,
    a.id as agent_id
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Learning Forge AI'
AND a.is_active = true
ORDER BY a.name;
