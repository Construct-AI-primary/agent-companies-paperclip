-- =====================================================
-- Assign Skills to Agents
-- Maps each agent to its primary skill (matching name pattern)
-- plus key shared skills
-- =====================================================

-- 1. Assign each agent its PRIMARY skill (the skill matching its name/role)
--    For example: Nexus agent → nexus-devforge-ceo skill

INSERT INTO agent_skill_assignments (company_id, agent_id, skill_key, source)
SELECT 
  a.company_id,
  a.id AS agent_id,
  cs.key AS skill_key,
  'company_skills' AS source
FROM agents a
JOIN company_skills cs ON cs.company_id = a.company_id
WHERE cs.key ILIKE '%' || REPLACE(a.name, ' ', '') || '%'
   OR cs.key ILIKE '%' || LOWER(a.name) || '%'
ON CONFLICT (agent_id, skill_key) DO NOTHING;

-- 2. Assign SHARED skills to ALL agents
INSERT INTO agent_skill_assignments (company_id, agent_id, skill_key, source)
SELECT 
  a.company_id,
  a.id AS agent_id,
  s.key AS skill_key,
  'shared_skills' AS source
FROM agents a
CROSS JOIN shared_skills s
ON CONFLICT (agent_id, skill_key) DO NOTHING;

-- 3. Verify assignments
SELECT 
  a.name AS agent_name,
  c.name AS company_name,
  COUNT(asa.id) AS skill_count
FROM agent_skill_assignments asa
JOIN agents a ON a.id = asa.agent_id
JOIN companies c ON c.id = a.company_id
GROUP BY a.name, c.name
ORDER BY c.name, a.name;