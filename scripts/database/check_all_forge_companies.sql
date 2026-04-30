-- Check all Forge companies and their exact names
SELECT 
    id,
    name,
    status,
    is_active,
    (SELECT COUNT(*) FROM agents WHERE company_id = companies.id) as agent_count
FROM companies
WHERE name ILIKE '%forge%' OR name ILIKE '%loopy%'
ORDER BY name;

-- Specifically check for variations of "LearningForge"
SELECT id, name
FROM companies  
WHERE name ILIKE '%learning%' OR name = 'LearningForge AI' OR name = 'Learning Forge AI';

-- Check the specific UUID that was used in insert_learningforge_agents.sql
SELECT id, name, status, is_active
FROM companies
WHERE id = '2bda2da6-dfa7-4709-b5d1-ea865f14072a';
