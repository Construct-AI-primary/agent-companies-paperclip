-- Check current company IDs in Render database
SELECT id, name FROM companies WHERE name LIKE '%Forge%' OR name LIKE '%Voice%' OR name LIKE '%Exec%' OR name LIKE '%SaaS%';

-- Check agents table - what company_ids exist
SELECT company_id, COUNT(*) as count FROM agents GROUP BY company_id;

-- Check if there are any agents for these companies
SELECT a.company_id, c.name, COUNT(a.id) as agent_count
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name IN ('ExecForge AI', 'SaaSForge AI', 'VoiceForge AI')
GROUP BY a.company_id, c.name;
