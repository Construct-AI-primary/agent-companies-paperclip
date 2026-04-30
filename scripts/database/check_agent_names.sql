-- Check actual agent names in database for LearningForge AI, PromptForge AI, and Loopy AI
-- This will show us what names to use in the insert_missing_api_keys.sql file

SELECT 
    c.name as company_name,
    a.name as agent_name,
    a.id as agent_id
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name IN ('LearningForge AI', 'PromptForge AI', 'Loopy AI')
ORDER BY c.name, a.name;
