SELECT id, name, adapter_config->>'command' as command FROM agents WHERE adapter_config IS NOT NULL AND adapter_config->>'command' IS NOT NULL LIMIT 5;
