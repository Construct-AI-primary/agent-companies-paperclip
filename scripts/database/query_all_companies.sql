-- Query all companies with details
SELECT 
  id,
  name,
  description,
  status,
  issue_prefix,
  issue_counter,
  budget_monthly_cents,
  spent_monthly_cents,
  require_board_approval_for_new_agents,
  brand_color,
  is_active,
  created_at,
  updated_at
FROM companies
ORDER BY name;
