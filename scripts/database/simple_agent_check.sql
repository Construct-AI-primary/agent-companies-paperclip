-- Simple check to see what agents actually exist in your database

-- Count agents by company
SELECT 
    c.name as company_name,
    COUNT(a.id) as agent_count
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id AND a.is_active = true
WHERE c.name IN ('Learning Forge AI', 'PromptForge AI', 'Loopy AI')
GROUP BY c.name
ORDER BY c.name;

-- Show a few actual agent names from each company
SELECT 
    c.name as company,
    a.name as agent_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name IN ('Learning Forge AI', 'PromptForge AI', 'Loopy AI')
AND a.is_active = true
ORDER BY c.name, a.name
LIMIT 20;
