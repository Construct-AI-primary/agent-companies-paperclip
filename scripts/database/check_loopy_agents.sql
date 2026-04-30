-- Check current Loopy AI agents
SELECT 
    c.name as company_name,
    a.name as agent_name,
    a.role,
    a.title,
    boss.name as reports_to,
    a.status,
    a.created_at
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agents boss ON a.reports_to = boss.id
WHERE c.name = 'Loopy AI'
ORDER BY a.created_at;
