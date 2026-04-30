-- Query all agents with their company names and API keys
SELECT 
  a.id,
  a.name,
  a.role,
  a.title,
  a.company_id,
  c.name as company_name,
  aak.api_key_hash,
  aak.label as api_key_label,
  CASE WHEN aak.id IS NOT NULL THEN '✓ Has Key' ELSE '✗ MISSING KEY' END as key_status
FROM agents a
LEFT JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
ORDER BY c.name, a.name;
