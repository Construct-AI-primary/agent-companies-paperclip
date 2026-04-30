-- Check which agents already have API keys
SELECT 
    c.name as company,
    COUNT(DISTINCT a.id) as total_agents,
    COUNT(DISTINCT k.agent_id) as agents_with_keys,
    COUNT(DISTINCT a.id) - COUNT(DISTINCT k.agent_id) as missing_keys
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id AND a.is_active = true
LEFT JOIN agent_api_keys k ON a.id = k.agent_id
WHERE c.name IN ('Learning Forge AI', 'PromptForge AI', 'Loopy AI')
GROUP BY c.name
ORDER BY c.name;

-- Show which specific agents are missing API keys
SELECT 
    c.name as company,
    a.name as agent_name,
    CASE WHEN k.id IS NULL THEN '✗ Missing API Key' ELSE '✓ Has API Key' END as status
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_api_keys k ON a.id = k.agent_id
WHERE c.name IN ('Learning Forge AI', 'PromptForge AI', 'Loopy AI')
AND a.is_active = true
AND k.id IS NULL
ORDER BY c.name, a.name;
