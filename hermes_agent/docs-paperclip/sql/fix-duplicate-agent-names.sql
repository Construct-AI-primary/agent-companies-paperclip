-- ============================================================
-- FIX NAMES ON REMAINING DUPLICATE AGENTS
-- Instead of deleting duplicates, fix the names on the remaining records
-- Generated: 2026-04-27
-- Total names to fix: 9
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'Civil Engineering'
WHERE id = 'c2e1f62e-2774-42aa-b6d6-735b345bd0df';
UPDATE agents
SET name = 'Contract Administration'
WHERE id = '93405bdd-5205-49d1-89e5-664be5049095';
UPDATE agents
SET name = 'Council'
WHERE id = 'd5a8dcf5-0ae4-44ec-8b16-703571fc16c3';
UPDATE agents
SET name = 'Finance'
WHERE id = 'c4d488ab-7cfa-47c1-baa8-64ad190a3974';
UPDATE agents
SET name = 'Orion'
WHERE id = 'c3a266fb-9b5e-456c-a98b-1859756b0d7f';
UPDATE agents
SET name = 'Procurement'
WHERE id = '4c25098a-1e60-4b0d-87b4-ad260d9aeaca';
UPDATE agents
SET name = 'Quality Control'
WHERE id = '652b4111-7bad-4ea0-9acc-8e8d163ae219';
UPDATE agents
SET name = 'Safety'
WHERE id = '8655de58-df44-455d-9671-c75e43c0316d';
UPDATE agents
SET name = 'Strategos'
WHERE id = '49d80edb-b229-4467-aa25-32cb103ef77f';

COMMIT;

-- Verification query:
-- SELECT id, company_id, title, name FROM agents WHERE id IN ('c2e1f62e-2774-42aa-b6d6-735b345bd0df', '93405bdd-5205-49d1-89e5-664be5049095', 'd5a8dcf5-0ae4-44ec-8b16-703571fc16c3', 'c4d488ab-7cfa-47c1-baa8-64ad190a3974', 'c3a266fb-9b5e-456c-a98b-1859756b0d7f', '4c25098a-1e60-4b0d-87b4-ad260d9aeaca', '652b4111-7bad-4ea0-9acc-8e8d163ae219', '8655de58-df44-455d-9671-c75e43c0316d', '49d80edb-b229-4467-aa25-32cb103ef77f') ORDER BY company_id, title;