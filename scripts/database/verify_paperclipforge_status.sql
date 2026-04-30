-- Verify PaperclipForge AI agents and API keys status
SELECT 
    c.name as company,
    COUNT(DISTINCT a.id) as total_agents,
    COUNT(DISTINCT CASE WHEN a.is_active = true THEN a.id END) as active_agents,
    COUNT(DISTINCT aak.id) as total_api_keys,
    COUNT(DISTINCT CASE WHEN a.is_active = true AND aak.id IS NOT NULL THEN a.id END) as agents_with_keys,
    COUNT(DISTINCT CASE WHEN a.is_active = true AND aak.id IS NULL THEN a.id END) as agents_missing_keys
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.id = '550e8400-e29b-41d4-a716-446655440013'
GROUP BY c.name;

-- List all PaperclipForge AI agents with their API key status
SELECT 
    a.name as agent_name,
    a.role,
    a.is_active,
    CASE WHEN aak.id IS NOT NULL THEN '✓' ELSE '✗' END as has_api_key
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE a.company_id = '550e8400-e29b-41d4-a716-446655440013'
ORDER BY a.name;
