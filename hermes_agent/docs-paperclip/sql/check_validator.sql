SELECT id, name, adapter_config->>'command' as command, adapter_config->>'cwd' as cwd FROM agents WHERE adapter_config IS NOT NULL AND name = 'Validator' LIMIT 1;
