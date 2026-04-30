-- =====================================================
-- Sync agent adapterConfig with agent_skill_assignments
-- 
-- The Skills tab UI reads desiredSkills from:
--   agent.adapterConfig -> paperclipSkillSync.desiredSkills
--
-- This script reads agent_skill_assignments and updates
-- each agent's adapterConfig so the UI shows all skills.
-- =====================================================

-- Step 1: Clear all desired_skills from adapterConfig (reset)
UPDATE agents
SET adapter_config = jsonb_set(adapter_config, '{paperclipSkillSync,desiredSkills}', '[]'::jsonb)
WHERE company_id IS NOT NULL
  AND jsonb_extract_path_text(adapter_config, 'paperclipSkillSync', 'desiredSkills') IS NOT NULL;

-- Step 2: Build desiredSkills arrays from assignments per agent
-- We do this per company to handle it in batches
DO $$
DECLARE
  agent_record RECORD;
  skill_array JSONB;
BEGIN
  FOR agent_record IN
    SELECT asa.agent_id,
           jsonb_agg(DISTINCT asa.skill_key) AS skills
    FROM agent_skill_assignments asa
    GROUP BY asa.agent_id
  LOOP
    UPDATE agents
    SET adapter_config = jsonb_set(
          COALESCE(adapter_config, '{}'::jsonb),
          '{paperclipSkillSync,desiredSkills}',
          agent_record.skills
        )
    WHERE id = agent_record.agent_id;
  END LOOP;
END $$;

-- Step 3: Verify - show agents with skills count
SELECT 
  a.name,
  a.adapter_type,
  jsonb_array_length(COALESCE(a.adapter_config->'paperclipSkillSync'->'desiredSkills', '[]'::jsonb)) AS desired_skill_count
FROM agents a
WHERE a.company_id IS NOT NULL
ORDER BY desired_skill_count DESC
LIMIT 20;