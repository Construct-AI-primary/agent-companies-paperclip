-- Check agents created around the time of the operations director
-- Looking for agents created within 10 minutes of 2026-04-21 09:55:58

SELECT
    'Agents Created Around Operations Director Time' as check_type,
    a.id,
    a.name,
    a.role,
    a.title,
    a.status,
    a.created_at,
    jsonb_array_length(COALESCE(a.adapter_config->'skills', '[]'::jsonb)) as skill_count,
    LEFT(aak.api_key, 12) || '...' as key_preview
FROM agents a
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid
WHERE a.company_id = (SELECT id FROM companies WHERE name = 'paperclipforge-ai')
  AND a.created_at >= '2026-04-21 09:45:00+00'::timestamp
  AND a.created_at <= '2026-04-21 10:05:00+00'::timestamp
ORDER BY a.created_at DESC;

-- Also check total agent count for the company
SELECT
    'Company Agent Summary' as summary,
    c.name as company_name,
    COUNT(a.id) as total_agents,
    COUNT(CASE WHEN a.status = 'idle' THEN 1 END) as idle_agents,
    COUNT(CASE WHEN a.status = 'busy' THEN 1 END) as busy_agents,
    COUNT(CASE WHEN aak.id IS NOT NULL THEN 1 END) as agents_with_keys
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::uuid
WHERE c.name = 'paperclipforge-ai'
GROUP BY c.id, c.name;