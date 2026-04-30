-- Load company goals into Supabase
-- Run with: PGPASSWORD='YOUR_PASSWORD' psql -h db.gmorarhibiptvcrnvrpi.supabase.co -U postgres -d postgres -f scripts/database/load_supabase_goals.sql

-- KnowledgeForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Build Centralized Knowledge Management for Paperclip Ecosystem',
'KnowledgeForge AI provides centralized knowledge management, documentation, and information architecture for the entire Paperclip ecosystem.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'KnowledgeForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve 90%+ Knowledge Retrieval Accuracy',
'Implement AI-powered knowledge retrieval achieving 90%+ accuracy, enabling fast and reliable access to organizational knowledge.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'KnowledgeForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable Seamless Knowledge Flow Across All Companies',
'Facilitate seamless knowledge flow across all Paperclip companies, breaking down information silos and enabling collaborative learning.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'KnowledgeForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Maintain 99%+ Documentation Quality Standards',
'Ensure 99%+ documentation quality across all knowledge assets, implementing comprehensive review and quality assurance processes.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'KnowledgeForge AI' ON CONFLICT DO NOTHING;

-- Learning Forge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Continuously Improve Learning from User Interactions and Domain Knowledge',
'LearningForge AI focuses on analyzing user interactions with construction-domain applications, tracking domain knowledge, and implementing automated research for skills enhancement.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'Learning Forge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Manage Standardized Workflows Across 50+ Construction Disciplines',
'Implement comprehensive workflows for 50+ construction disciplines including legal, safety, procurement, engineering, and project management.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'Learning Forge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Implement Automated Research Using AutoResearch for Skills Enhancement',
'Integrate Karpathy AutoResearch for automated skills enhancement, enabling continuous learning and improvement of AI agent capabilities.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'Learning Forge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable Knowledge Flow from Field Findings to Learning Content',
'Establish comprehensive knowledge flow systems that capture field findings, safety observations, and material innovations.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'Learning Forge AI' ON CONFLICT DO NOTHING;

-- Verification
SELECT c.name as company, COUNT(g.id) as goal_count 
FROM companies c 
LEFT JOIN goals g ON c.id = g.company_id AND g.status = 'active'
GROUP BY c.name 
ORDER BY c.name;
