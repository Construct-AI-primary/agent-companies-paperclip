SELECT name, adapter_config->>'url' as repo_url FROM agents WHERE adapter_config->>'url' IS NOT NULL LIMIT 5;
