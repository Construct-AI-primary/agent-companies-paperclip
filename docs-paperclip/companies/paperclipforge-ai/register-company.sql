-- ============================================================
-- PaperclipForge AI Company Registration
-- Created: 2026-04-22
-- Description: Registers PaperclipForge AI company in the Paperclip ecosystem
-- Prerequisites: None - this creates the company first
-- ============================================================

-- Insert PaperclipForge AI company (idempotent - safe to run multiple times)
INSERT INTO companies (
  id,
  name,
  description,
  status,
  issue_prefix,
  budget_monthly_cents,
  require_board_approval_for_new_agents,
  brand_color,
  created_at,
  updated_at
) VALUES (
  '550e8400-e29b-41d4-a716-446655440014',
  'PaperclipForge AI',
  'Core orchestration company managing system-wide coordination, agent lifecycle, workflow automation, and cross-company integration. Responsible for enterprise-level project management, engineering analysis, and operational excellence across the Paperclip ecosystem.',
  'active',
  'PAPF',
  1500000,  -- $15,000 monthly budget
  true,     -- Require board approval for new agents
  '#8B5CF6', -- Purple brand color
  '2026-04-22T11:00:00.000Z',
  '2026-04-22T11:00:00.000Z'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  issue_prefix = EXCLUDED.issue_prefix,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  require_board_approval_for_new_agents = EXCLUDED.require_board_approval_for_new_agents,
  brand_color = EXCLUDED.brand_color,
  updated_at = EXCLUDED.updated_at;

-- Verification query
-- SELECT id, name, description, status, issue_prefix, budget_monthly_cents, brand_color
-- FROM companies WHERE name = 'PaperclipForge AI';

-- ============================================================
-- Clean up: Uncomment to remove the company (CAUTION: This will cascade delete all agents)
-- DELETE FROM companies WHERE name = 'PaperclipForge AI';