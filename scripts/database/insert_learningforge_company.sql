-- Learning Forge AI Company Insert
-- Run this FIRST to add the company, then run insert_learningforge_agents.sql

INSERT INTO companies (
  id,
  name,
  description,
  status,
  budget_monthly_cents,
  spent_monthly_cents,
  created_at,
  updated_at,
  issue_prefix,
  issue_counter,
  require_board_approval_for_new_agents,
  brand_color,
  pause_reason,
  paused_at,
  deleted_at,
  is_active
) VALUES (
  '550e8400-e29b-41d4-a716-446655440013',
  'Learning Forge AI',
  'AI Learning & Knowledge Management company specializing in construction domain learning',
  'active',
  0,
  0,
  NOW(),
  NOW(),
  'LFA',
  0,
  true,
  '#9333ea',
  NULL,
  NULL,
  NULL,
  true
) ON CONFLICT (id) DO NOTHING;

-- Verify
-- SELECT * FROM companies WHERE id = '550e8400-e29b-41d4-a716-446655440013';
