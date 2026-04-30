-- ============================================================
-- REMOVE DUPLICATE AGENTS
-- Standalone SQL file to remove duplicate agent records
-- Generated: 2026-04-27
-- Total duplicates to remove: 12
-- ============================================================

BEGIN;

DELETE FROM agents WHERE id = '86a528a6-4a47-40b2-946d-10099e491dc6';
DELETE FROM agents WHERE id = 'a4f332f0-3ed4-4670-869e-0e127ed3546f';
DELETE FROM agents WHERE id = '5c1efd16-00a4-4ddd-a1fb-1ab03a21c667';
DELETE FROM agents WHERE id = '1ee034c7-1ab7-438f-ba49-06353bf10693';
DELETE FROM agents WHERE id = 'd28b297f-6bbc-400f-812d-357352b22806';
DELETE FROM agents WHERE id = 'd0169d52-cb26-4728-a941-f2d44c7e7cba';
DELETE FROM agents WHERE id = 'd54cc30c-ba5b-4ed5-8056-836c2ccb44ef';
DELETE FROM agents WHERE id = 'd70d8fd2-e6a3-4809-af43-92bd7ba37c92';
DELETE FROM agents WHERE id = '7d93f71e-d5d6-4b04-983a-840d038927da';
DELETE FROM agents WHERE id = '5da12350-c859-41d5-b4e4-cd08b853817b';
DELETE FROM agents WHERE id = 'b6a2b308-3b90-4b08-b7f4-f9ce75aab989';
DELETE FROM agents WHERE id = '62b61398-1e13-4c75-9864-ab173e27c84a';

COMMIT;

-- Verification query:
-- SELECT company_id, title, COUNT(*) as count FROM agents GROUP BY company_id, title HAVING COUNT(*) > 1 ORDER BY company_id, title;