-- ============================================================
-- SAFE REMOVAL OF DUPLICATE AGENTS WITH FOREIGN KEY REFERENCES
-- Remove related records first, then the agent
-- Generated: 2026-04-27
-- Total agents to safely remove: 1
-- ============================================================

BEGIN;

-- Remove foreign key references for agent 62b61398-1e13-4c75-9864-ab173e27c84a
DELETE FROM agent_api_keys WHERE agent_id = '62b61398-1e13-4c75-9864-ab173e27c84a';
DELETE FROM agents WHERE id = '62b61398-1e13-4c75-9864-ab173e27c84a';

COMMIT;

-- Verification query:
-- SELECT id, title, name FROM agents WHERE id IN ('62b61398-1e13-4c75-9864-ab173e27c84a');