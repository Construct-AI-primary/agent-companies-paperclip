-- ============================================================
-- Phase 1: Database Cleanup - Remove Duplicate Agents
-- Date: 2026-04-22
-- Companies: PaperclipForge AI + MeasureForge AI
-- Strategy: Keep OLDEST entry (earliest created_at), delete newer duplicates
-- ============================================================

-- IMPORTANT: Run a full database backup before executing this script!

-- ============================================================
-- PAPERCLIPFORGE AI DUPLICATE CLEANUP
-- Company ID: 550e8400-e29b-41d4-a716-446655440014
-- ============================================================

-- 1. paperclipforge-ai-operations-director: Keep d8475f0a (oldest), delete 2 newer
DELETE FROM agents WHERE id IN ('16f59f76-9b06-4755-b95c-cebeee4fa2ac', '91b48330-2893-49ee-9234-ba6b82da0327');

-- 2. paperclipforge-ai-agent-monitor: Keep 66a58395, delete 8fe456ca
DELETE FROM agents WHERE id = '8fe456ca-f377-428e-98fd-0fe0ce7a5273';

-- 3. paperclipforge-ai-coordination-hub: Keep 4c61fbb6, delete 0d0fe63a
DELETE FROM agents WHERE id = '0d0fe63a-2ea7-468e-9592-e2b14a6311b5';

-- 4. paperclipforge-ai-issue-importer: Keep 01860905, delete 42ef2223
DELETE FROM agents WHERE id = '42ef2223-e374-4cf0-9e2a-adade7c1f98f';

-- 5. paperclipforge-ai-orchestration-engine: Keep eb92c0ad, delete e37b4e2b
DELETE FROM agents WHERE id = 'e37b4e2b-ae8a-4a51-a314-25c6c6b8556f';

-- 6. paperclipforge-ai-system-integrator: Keep dcc0fcc3, delete 8d6f2dcb
DELETE FROM agents WHERE id = '8d6f2dcb-b4e8-4f51-84ac-e482d17a408f';

-- 7. paperclipforge-ai-task-allocator: Keep 1a9f4f0e, delete 96516200
DELETE FROM agents WHERE id = '96516200-ac70-4ea1-80a3-971bd791311a';

-- 8. paperclipforge-ai-workflow-orchestrator: Keep 35196fb6, delete 3fb1015d
DELETE FROM agents WHERE id = '3fb1015d-a337-4335-bd06-4058455a4f52';

-- ============================================================
-- MEASUREFORGE AI DUPLICATE CLEANUP
-- Company ID: 550e8400-e29b-41d4-a716-446655440013
-- ============================================================

-- 1. advanced-engineering-analysis: Keep 1462606d (newer, better title), delete c076d300
DELETE FROM agents WHERE id = 'c076d300-b4a6-4540-8c81-161298c308b0';

-- 2. cross-discipline-coordination: Keep 4c63c5d3 (specialist role), delete 55f83928
DELETE FROM agents WHERE id = '55f83928-c78e-4e28-8b11-5d7c40fe256f';

-- 3. engineering-ui-specialist: Keep 02f70a2c (newer, proper specialist), delete 04bdc189
DELETE FROM agents WHERE id = '04bdc189-5a79-426b-91fd-dd8e9cc54c76';

-- ============================================================
-- VERIFICATION QUERIES (run after cleanup)
-- ============================================================

-- Verify PaperclipForge AI now has 10 unique agents
-- SELECT name, COUNT(*) as cnt FROM agents WHERE company_id = '550e8400-e29b-41d4-a716-446655440014' GROUP BY name HAVING COUNT(*) > 1;

-- Verify MeasureForge AI duplicates reduced
-- SELECT name, COUNT(*) as cnt FROM agents WHERE company_id = '550e8400-e29b-41d4-a716-446655440013' GROUP BY name HAVING COUNT(*) > 1;

-- Total agents deleted: 11 (8 from PaperclipForge + 3 from MeasureForge)