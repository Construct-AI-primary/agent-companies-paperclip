-- Update all QualityForge AI agents to report to the new CEO agent
-- Company ID: f535f9bc-00be-4b6d-9f53-c53abfacacef
-- New CEO Agent ID: 703cccd1-b698-4717-8ff8-6425d59b1c69

-- First, verify the new CEO agent exists and belongs to QualityForge AI
SELECT
    a.id,
    a.name,
    a.title,
    a.role,
    c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.id = '703cccd1-b698-4717-8ff8-6425d59b1c69'
  AND a.company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef';

-- Update all QualityForge AI agents (except the CEO itself) to report to the new CEO
UPDATE agents
SET reports_to = '703cccd1-b698-4717-8ff8-6425d59b1c69',
    updated_at = NOW()
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND id != '703cccd1-b698-4717-8ff8-6425d59b1c69'
  AND deleted_at IS NULL;

-- Verify the changes
SELECT
    a.id,
    a.name,
    a.title,
    a.role,
    a.reports_to,
    r.name as reports_to_name,
    r.title as reports_to_title
FROM agents a
LEFT JOIN agents r ON a.reports_to = r.id
WHERE a.company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND a.deleted_at IS NULL
ORDER BY a.name;