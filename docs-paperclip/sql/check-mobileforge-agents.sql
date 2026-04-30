-- Check MobileForge AI agents and their status
SELECT
  id,
  name,
  status,
  "reportsTo",
  adapter_config
FROM agents
WHERE company_id = (
  SELECT id FROM companies WHERE name = 'MobileForge AI'
)
ORDER BY name;