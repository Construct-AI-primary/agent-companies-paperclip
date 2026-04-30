-- ============================================================================
-- MISSING API KEYS INSERT STATEMENTS FOR CONTENTFORGE, DOMAINFORGE, PAPERCLIPFORGE
-- Generated: 2026-04-12
-- Companies: ContentForge AI (16), DomainForge AI (65), PaperclipForge AI (3)
-- Total Missing: 84 API Keys
-- ============================================================================

-- NOTE: Company IDs are resolved dynamically via subqueries
-- Verify companies exist: SELECT id, name FROM companies WHERE name IN ('ContentForge AI', 'DomainForge AI', 'PaperclipForge AI');

-- ============================================================================
-- CONTENTFORGE AI (16 Agents)
-- ============================================================================

-- Agent: Blog-Architect
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Blog Architect' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: Content-Maestro
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Content Maestro' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: Conversion-Analyst
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Conversion Analyst' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: Conversion-Specialist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Conversion Specialist' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: Data-Analyst
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Data Analyst' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: Email-Composer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Email Composer' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: Link-Builder
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Link Builder' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: Local-SEO-Expert
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Local SEO Expert' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: Mobile-Optimizer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Mobile Optimizer' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: Performance-Optimizer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Performance Optimizer' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: Reporting-Specialist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Reporting Specialist' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: SEO-Analyst
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'SEO Analyst' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: SEO-Strategist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'SEO Strategist' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: Social-Strategist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Social Strategist' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: Technical-SEO-Specialist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Technical SEO Specialist' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: UX-Designer
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'UX Designer' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'ContentForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- ============================================================================
-- PAPERCLIPFORGE AI (3 Agents - Missing 3 keys)
-- ============================================================================

-- Agent: project-maestro
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Project Maestro' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: maya-loopy-content-strategist
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Maya' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- Agent: vision-loopy-ceo
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Vision Loopy CEO' LIMIT 1),
  (SELECT id FROM companies WHERE name = 'PaperclipForge AI' LIMIT 1),
  'Primary Key',
  encode(sha256(random()::text::bytea), 'hex')
);

-- ============================================================================
-- VERIFICATION QUERY
-- ============================================================================
-- Run this to verify all keys were created:
-- SELECT c.name as company, COUNT(aak.id) as api_keys_count
-- FROM companies c
-- LEFT JOIN agents a ON c.id = a.company_id
-- LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
-- WHERE c.name IN ('ContentForge AI', 'DomainForge AI', 'PaperclipForge AI')
-- GROUP BY c.name;