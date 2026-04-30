-- Align agents table with CSV data
-- This replaces all agent data with the correct data from the CSV export

-- Copy data from CSV file
-- Note: Only importing columns that exist in the current table schema
-- CSV has extra columns (model_config, device_config, deleted_at, is_active) that we skip
COPY agents (
  id, company_id, name, role, title, status, reports_to, capabilities,
  adapter_type, adapter_config, budget_monthly_cents, spent_monthly_cents,
  last_heartbeat_at, metadata, created_at, updated_at, runtime_config,
  permissions, icon, pause_reason, paused_at
)
FROM '/tmp/agents_filtered.csv'
WITH (
  FORMAT csv,
  HEADER true,
  NULL '',
  QUOTE '"',
  ESCAPE '"'
);
