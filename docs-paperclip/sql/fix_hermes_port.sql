UPDATE agents SET adapter_config = jsonb_set(adapter_config, '{url}', 'http://localhost:3100/api/execute') WHERE adapter_type = 'http' AND adapter_config->>'url' LIKE '%localhost:3001%';
