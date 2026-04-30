-- Script to INSERT agents for ExecForge, SaaSForge, VoiceForge into Render database
-- These companies exist but have no agents yet

-- Company IDs (verified from companies table):
-- ExecForge AI: 550e8400-e29b-41d4-a716-446655440010
-- SaaSForge AI: 550e8400-e29b-41d4-a716-446655440011
-- VoiceForge AI: 550e8400-e29b-41d4-a716-446655440012

-- Insert ExecForge CEO
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, metadata, created_at, updated_at)
VALUES (
  'a1b2c3d4-e5f6-7890-abcd-440010001',
  '550e8400-e29b-41d4-a716-446655440010',
  'Executive Director',
  'ceo',
  'Chief Executive Officer',
  'active',
  'Executive leadership and strategic direction for ExecForge AI',
  'http',
  '{"url":"https://ecb3-102-132-198-101.ngrok-free.app/webhook","model":"openrouter/qwen/qwen-3-6-plus","maxIterations":50,"persistSession":true}',
  '{"team":"ExecForge AI","source":"render-fix"}',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00'
) ON CONFLICT (id) DO NOTHING;

-- Insert additional ExecForge agents (18 total per local DB)
-- Add 17 more agents with sequential IDs

-- For the remaining agents, we need to know their names from the local database
-- Run this to check what agents exist locally for these companies:
-- SELECT name, slug FROM agents WHERE company_id = '550e8400-e29b-41d4-a716-446655440010';

-- Since we don't have the full agent list, here's a template for manual insertion:
-- INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, metadata, created_at, updated_at)
-- VALUES (
--   'UNIQUE_ID',
--   '550e8400-e29b-41d4-a716-446655440010', -- ExecForge
--   'Agent Name',
--   'role',
--   'Title',
--   'active',
--   'Capabilities description',
--   'http',
--   '{"url":"https://ecb3-102-132-198-101.ngrok-free.app/webhook","model":"openrouter/qwen/qwen-3-6-plus","maxIterations":50,"persistSession":true}',
--   '{"team":"ExecForge AI","source":"render-fix"}',
--   '2026-04-11 00:52:39.316183+00',
--   '2026-04-11 00:52:39.316183+00'
-- ) ON CONFLICT (id) DO NOTHING;

-- Alternative: Drop the constraint temporarily and INSERT agents from local DB CSV
-- First export agents from local DB for these companies, then import to Render
