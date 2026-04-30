SELECT c.name as company_name, c.id as company_id, COUNT(a.id) as agent_count
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
WHERE c.name LIKE '%measure%'
GROUP BY c.id, c.name;