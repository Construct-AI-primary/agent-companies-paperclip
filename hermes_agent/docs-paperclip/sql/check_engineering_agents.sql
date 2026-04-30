-- Check if the three new engineering agents have been created in the database
SELECT
    'Engineering Agents Check' as check_type,
    a.id,
    a.name,
    a.title,
    a.status,
    a.created_at,
    a.adapter_config->>'model' as model,
    jsonb_array_length(COALESCE(a.adapter_config->'skills', '[]'::jsonb)) as skill_count
FROM agents a
WHERE a.company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI')
  AND a.name IN (
    'paperclipforge-ai-advanced-engineering-analysis',
    'paperclipforge-ai-cross-discipline-coordination',
    'paperclipforge-ai-engineering-ui-specialist'
  )
ORDER BY a.name;

-- Also show total count of agents for this company
SELECT
    'Company Summary' as summary,
    c.name as company_name,
    COUNT(a.id) as total_agents,
    COUNT(CASE WHEN a.name IN (
        'paperclipforge-ai-advanced-engineering-analysis',
        'paperclipforge-ai-cross-discipline-coordination',
        'paperclipforge-ai-engineering-ui-specialist'
    ) THEN 1 END) as engineering_agents_found
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
WHERE c.name = 'PaperclipForge AI'
GROUP BY c.id, c.name;