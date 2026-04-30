-- Supplemental SQL to add missing company goals
-- NOTE: Company names must match exactly: 'Learning Forge AI' (with space), not 'LearningForge AI'

-- Learning Forge AI Goals (note: name has spaces)
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Continuously Improve Learning from User Interactions and Domain Knowledge',
'LearningForge AI focuses on analyzing user interactions with construction-domain applications, tracking domain knowledge (legal precedents, safety standards, material innovations), and implementing automated research using AutoResearch for skills enhancement.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'Learning Forge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Manage Standardized Workflows Across 50+ Construction Disciplines',
'Implement comprehensive workflows for 50+ construction disciplines including legal, safety, procurement, engineering, and project management, ensuring knowledge transfer from field findings to learning content.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'Learning Forge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Implement Automated Research Using AutoResearch for Skills Enhancement',
'Integrate Karpathy AutoResearch for automated skills enhancement, enabling continuous learning and improvement of AI agent capabilities through systematic research and knowledge discovery.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'Learning Forge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable Knowledge Flow from Field Findings to Learning Content',
'Establish comprehensive knowledge flow systems that capture field findings, safety observations, and material innovations, transforming them into actionable learning content for continuous improvement.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'Learning Forge AI' ON CONFLICT DO NOTHING;

-- PaperclipForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Revolutionize Project Management and Issue Orchestration through Intelligent Automation',
'PaperclipForge AI serves as the operational backbone of the Paperclip ecosystem, specializing in intelligent project management, issue orchestration, workflow automation, and seamless integration between all Paperclip companies.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'PaperclipForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve 95%+ Project Success Rate with 60% Reduction in Issue Resolution Time',
'Deliver end-to-end project lifecycle automation, intelligent resource allocation, proactive risk management, and comprehensive performance analytics to achieve 95%+ project success rate and 60% reduction in issue resolution time.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'PaperclipForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Generate Issues with 90%+ Relevance Accuracy and Enable 90%+ Process Automation',
'Provide AI-powered issue generation, smart agent assignment based on expertise, complex dependency tracking, and real-time progress monitoring to generate issues with 90%+ relevance accuracy.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'PaperclipForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable Seamless Cross-Company Coordination with 99.9%+ System Integration Uptime',
'Coordinate seamlessly between Paperclip companies, manage comprehensive API integration, implement continuous workflow optimization, and maintain 99.9%+ system integration uptime across the Paperclip ecosystem.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'PaperclipForge AI' ON CONFLICT DO NOTHING;

-- First check if companies exist
SELECT '=== Checking Company Names ===' as status;
SELECT id, name FROM companies WHERE name IN ('Learning Forge AI', 'PaperclipForge AI');

-- Verify
SELECT '=== Verification ===' as status;
SELECT c.name as company, COUNT(g.id) as goal_count
FROM companies c
LEFT JOIN goals g ON c.id = g.company_id AND g.status = 'active'
WHERE c.name IN ('Learning Forge AI', 'PaperclipForge AI')
GROUP BY c.name;
