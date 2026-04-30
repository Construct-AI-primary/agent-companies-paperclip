-- Test EVERY agent name from insert_missing_api_keys.sql
-- This will show which ones return NULL

SELECT 
    'Assessment Mastery Agent' as agent_name,
    (SELECT id FROM agents WHERE name = 'Assessment Mastery Agent' LIMIT 1) as agent_id,
    CASE WHEN (SELECT id FROM agents WHERE name = 'Assessment Mastery Agent' LIMIT 1) IS NULL 
        THEN '✗ NOT FOUND' ELSE '✓ Found' END as status
UNION ALL SELECT 'Audit By Path Agent', (SELECT id FROM agents WHERE name = 'Audit By Path Agent' LIMIT 1), CASE WHEN (SELECT id FROM agents WHERE name = 'Audit By Path Agent' LIMIT 1) IS NULL THEN '✗ NOT FOUND' ELSE '✓ Found' END
UNION ALL SELECT 'Audit Explainability Agent', (SELECT id FROM agents WHERE name = 'Audit Explainability Agent' LIMIT 1), CASE WHEN (SELECT id FROM agents WHERE name = 'Audit Explainability Agent' LIMIT 1) IS NULL THEN '✗ NOT FOUND' ELSE '✓ Found' END
UNION ALL SELECT 'AutoResearch Gap Analyzer', (SELECT id FROM agents WHERE name = 'AutoResearch Gap Analyzer' LIMIT 1), CASE WHEN (SELECT id FROM agents WHERE name = 'AutoResearch Gap Analyzer' LIMIT 1) IS NULL THEN '✗ NOT FOUND' ELSE '✓ Found' END
UNION ALL SELECT 'AutoResearch Literature Scanner', (SELECT id FROM agents WHERE name = 'AutoResearch Literature Scanner' LIMIT 1), CASE WHEN (SELECT id FROM agents WHERE name = 'AutoResearch Literature Scanner' LIMIT 1) IS NULL THEN '✗ NOT FOUND' ELSE '✓ Found' END
UNION ALL SELECT 'AutoResearch Skills Enhancer', (SELECT id FROM agents WHERE name = 'AutoResearch Skills Enhancer' LIMIT 1), CASE WHEN (SELECT id FROM agents WHERE name = 'AutoResearch Skills Enhancer' LIMIT 1) IS NULL THEN '✗ NOT FOUND' ELSE '✓ Found' END
UNION ALL SELECT 'Compliance Guard Agent', (SELECT id FROM agents WHERE name = 'Compliance Guard Agent' LIMIT 1), CASE WHEN (SELECT id FROM agents WHERE name = 'Compliance Guard Agent' LIMIT 1) IS NULL THEN '✗ NOT FOUND' ELSE '✓ Found' END
UNION ALL SELECT 'Construction Law Research Agent', (SELECT id FROM agents WHERE name = 'Construction Law Research Agent' LIMIT 1), CASE WHEN (SELECT id FROM agents WHERE name = 'Construction Law Research Agent' LIMIT 1) IS NULL THEN '✗ NOT FOUND' ELSE '✓ Found' END
UNION ALL SELECT 'Learning Strategy Agent', (SELECT id FROM agents WHERE name = 'Learning Strategy Agent' LIMIT 1), CASE WHEN (SELECT id FROM agents WHERE name = 'Learning Strategy Agent' LIMIT 1) IS NULL THEN '✗ NOT FOUND' ELSE '✓ Found' END
UNION ALL SELECT 'Hermes Research Agent', (SELECT id FROM agents WHERE name = 'Hermes Research Agent' LIMIT 1), CASE WHEN (SELECT id FROM agents WHERE name = 'Hermes Research Agent' LIMIT 1) IS NULL THEN '✗ NOT FOUND' ELSE '✓ Found' END
UNION ALL SELECT 'Knowledge Flow Agent', (SELECT id FROM agents WHERE name = 'Knowledge Flow Agent' LIMIT 1), CASE WHEN (SELECT id FROM agents WHERE name = 'Knowledge Flow Agent' LIMIT 1) IS NULL THEN '✗ NOT FOUND' ELSE '✓ Found' END
UNION ALL SELECT 'Knowledge Flow Division Lead', (SELECT id FROM agents WHERE name = 'Knowledge Flow Division Lead' LIMIT 1), CASE WHEN (SELECT id FROM agents WHERE name = 'Knowledge Flow Division Lead' LIMIT 1) IS NULL THEN '✗ NOT FOUND' ELSE '✓ Found' END
UNION ALL SELECT 'Langchain Runner', (SELECT id FROM agents WHERE name = 'Langchain Runner' LIMIT 1), CASE WHEN (SELECT id FROM agents WHERE name = 'Langchain Runner' LIMIT 1) IS NULL THEN '✗ NOT FOUND' ELSE '✓ Found' END
ORDER BY status DESC, agent_name;
