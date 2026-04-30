-- ============================================================
-- FIX NAMES FOR: loopy-ai
-- Company ID: 0a40625e-78f9-4b0a-82e4-169a8befa021
-- Agents: 6
-- Uses UPDATE to fix name field on existing agents
-- Uses human_name field when available, otherwise name
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'Alex Loopy Deep Resear'
WHERE company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021'
  AND title = 'alex-loopy-deep-research'
  AND name IS DISTINCT FROM 'Alex Loopy Deep Resear';

UPDATE agents
SET name = 'Dev Loopy Technical Cr'
WHERE company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021'
  AND title = 'dev-loopy-technical-creative'
  AND name IS DISTINCT FROM 'Dev Loopy Technical Cr';

UPDATE agents
SET name = 'Jordan Loopy Marketing'
WHERE company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021'
  AND title = 'jordan-loopy-marketing-specialist'
  AND name IS DISTINCT FROM 'Jordan Loopy Marketing';

UPDATE agents
SET name = 'Maya Loopy Content Str'
WHERE company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021'
  AND title = 'maya-loopy-content-strategist'
  AND name IS DISTINCT FROM 'Maya Loopy Content Str';

UPDATE agents
SET name = 'Sam Loopy Social Media'
WHERE company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021'
  AND title = 'sam-loopy-social-media-coordinator'
  AND name IS DISTINCT FROM 'Sam Loopy Social Media';

UPDATE agents
SET name = 'Vision Loopy Ceo'
WHERE company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021'
  AND title = 'vision-loopy-ceo'
  AND name IS DISTINCT FROM 'Vision Loopy Ceo';

COMMIT;
