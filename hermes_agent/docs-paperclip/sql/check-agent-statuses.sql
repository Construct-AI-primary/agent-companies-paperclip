-- Check current agent statuses for DevForge AI
SELECT
  a.name as agent_name,
  a.status,
  c.name as company_name,
  COUNT(*) OVER (PARTITION BY a.status) as status_count
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'DevForge AI'
ORDER BY a.status, a.name;

-- Check how many agents are active vs terminated
SELECT
  a.status,
  COUNT(*) as count
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'DevForge AI'
GROUP BY a.status
ORDER BY a.status;

-- Check if the UI filter is working correctly
-- The UI should show agents where status is NOT 'terminated' and NOT 'error'
SELECT
  a.name as agent_name,
  a.status,
  CASE
    WHEN a.status NOT IN ('terminated', 'error') THEN 'Should be visible'
    ELSE 'Hidden by UI filter'
  END as visibility_status
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'DevForge AI'
ORDER BY a.status, a.name;