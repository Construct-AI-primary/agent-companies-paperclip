-- Diagnostic query to find which agent names from insert_missing_api_keys.sql don't exist in database

-- Test a sample of agent names that should exist
SELECT 
    'Assessment Mastery Agent' as lookup_name,
    CASE WHEN EXISTS (SELECT 1 FROM agents WHERE name = 'Assessment Mastery Agent') 
        THEN '✓ Found' ELSE '✗ NOT FOUND' END as status,
    (SELECT id FROM agents WHERE name = 'Assessment Mastery Agent' LIMIT 1) as agent_id
UNION ALL
SELECT 
    'Analyzer' as lookup_name,
    CASE WHEN EXISTS (SELECT 1 FROM agents WHERE name = 'Analyzer') 
        THEN '✓ Found' ELSE '✗ NOT FOUND' END as status,
    (SELECT id FROM agents WHERE name = 'Analyzer' LIMIT 1) as agent_id
UNION ALL
SELECT 
    'Maya' as lookup_name,
    CASE WHEN EXISTS (SELECT 1 FROM agents WHERE name = 'Maya') 
        THEN '✓ Found' ELSE '✗ NOT FOUND' END as status,
    (SELECT id FROM agents WHERE name = 'Maya' LIMIT 1) as agent_id
UNION ALL
SELECT 
    'Observer' as lookup_name,
    CASE WHEN EXISTS (SELECT 1 FROM agents WHERE name = 'Observer') 
        THEN '✓ Found' ELSE '✗ NOT FOUND' END as status,
    (SELECT id FROM agents WHERE name = 'Observer' LIMIT 1) as agent_id
UNION ALL
SELECT 
    'Learning Strategy Agent' as lookup_name,
    CASE WHEN EXISTS (SELECT 1 FROM agents WHERE name = 'Learning Strategy Agent') 
        THEN '✓ Found' ELSE '✗ NOT FOUND' END as status,
    (SELECT id FROM agents WHERE name = 'Learning Strategy Agent' LIMIT 1) as agent_id;

-- Also check company names
SELECT 
    'Learning Forge AI' as company_name,
    CASE WHEN EXISTS (SELECT 1 FROM companies WHERE name = 'Learning Forge AI') 
        THEN '✓ Found' ELSE '✗ NOT FOUND' END as status,
    (SELECT id FROM companies WHERE name = 'Learning Forge AI' LIMIT 1) as company_id
UNION ALL
SELECT 
    'PromptForge AI' as company_name,
    CASE WHEN EXISTS (SELECT 1 FROM companies WHERE name = 'PromptForge AI') 
        THEN '✓ Found' ELSE '✗ NOT FOUND' END as status,
    (SELECT id FROM companies WHERE name = 'PromptForge AI' LIMIT 1) as company_id
UNION ALL
SELECT 
    'Loopy AI' as company_name,
    CASE WHEN EXISTS (SELECT 1 FROM companies WHERE name = 'Loopy AI') 
        THEN '✓ Found' ELSE '✗ NOT FOUND' END as status,
    (SELECT id FROM companies WHERE name = 'Loopy AI' LIMIT 1) as company_id;
