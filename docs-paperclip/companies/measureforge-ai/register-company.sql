-- ============================================================
-- MeasureForge AI Company Registration
-- Created: 2026-04-22
-- Description: Registers MeasureForge AI company in the Paperclip ecosystem
-- Prerequisites: None - this creates the company first
-- ============================================================

-- Insert MeasureForge AI company (idempotent - safe to run multiple times)
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
  '2B5D3695-102D-4C02-8785-D53B306E29BF',
  'MeasureForge AI',
  'AI-powered measurement and analytics platform for construction and engineering. Specializes in automated measurement validation, cross-discipline coordination, and intelligent analysis across civil, electrical, mechanical, and structural engineering domains.',
  'active',
  'MEAS',
  1000000,  -- $10,000 monthly budget
  true,     -- Require board approval for new agents
  '#2563EB', -- Blue brand color
  NOW(),
  NOW()
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  issue_prefix = EXCLUDED.issue_prefix,
  budget_monthly_cents = EXCLUDED.budget_monthly_cents,
  require_board_approval_for_new_agents = EXCLUDED.require_board_approval_for_new_agents,
  brand_color = EXCLUDED.brand_color,
  updated_at = NOW();

-- Verification query
-- SELECT id, name, description, status, issue_prefix, budget_monthly_cents, brand_color
-- FROM companies WHERE name = 'MeasureForge AI';

-- ============================================================
-- Clean up: Uncomment to remove the company (CAUTION: This will cascade delete all agents)
-- DELETE FROM companies WHERE name = 'MeasureForge AI';
