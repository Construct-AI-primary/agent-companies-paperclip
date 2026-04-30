-- Fix DevForge AI agents: Change terminated agents (status = 0) to active
-- This will make all 55 agents visible in the UI sidebar

-- First, check current status distribution for DevForge AI
SELECT status, COUNT(*) as count
FROM agents
WHERE company_id = (SELECT id FROM companies WHERE name = 'DevForge AI')
GROUP BY status
ORDER BY status;

-- Update all terminated agents (status = 0) to active (status = 'active' or appropriate value)
-- Note: Status might be stored as integer codes, so we need to check what 'active' maps to
-- Common mappings: 0=terminated, 1=idle, 2=active, 3=paused, 4=error

UPDATE agents
SET status = 'active'  -- or 'idle' if that's the correct active state
WHERE company_id = (SELECT id FROM companies WHERE name = 'DevForge AI')
  AND status = 'terminated';  -- or status = 0 if stored as integer

-- Alternative: If status is stored as integer, use:
-- UPDATE agents
-- SET status = 2  -- assuming 2 = active
-- WHERE company_id = (SELECT id FROM companies WHERE name = 'DevForge AI')
--   AND status = 0;  -- 0 = terminated

-- Verify the update
SELECT
  a.name,
  a.status,
  a.role,
  c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'DevForge AI'
ORDER BY a.name;

-- Check final counts
SELECT status, COUNT(*) as count
FROM agents
WHERE company_id = (SELECT id FROM companies WHERE name = 'DevForge AI')
GROUP BY status
ORDER BY status;