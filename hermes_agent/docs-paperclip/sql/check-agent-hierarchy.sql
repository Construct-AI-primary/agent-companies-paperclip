-- Check agent hierarchy and reporting relationships
SELECT
  id,
  name,
  status,
  "reportsTo",
  adapter_config
FROM agents
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
ORDER BY name;