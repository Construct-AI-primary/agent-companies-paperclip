SELECT name, adapter_type, adapter_config->>'url' as service_url FROM agents WHERE adapter_type = 'http' LIMIT 3;
