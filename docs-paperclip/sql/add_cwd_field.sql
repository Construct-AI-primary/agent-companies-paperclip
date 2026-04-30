UPDATE agents SET adapter_config = adapter_config || '{"cwd": "/opt/render/project/src/hermes_agent"}'::jsonb WHERE adapter_config->>'command' LIKE '%hermes_agent/run.sh%';
