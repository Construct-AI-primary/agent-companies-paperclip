-- ============================================================
-- Update Org Research Folder Creator Reports To
-- Set reports_to to Operations Director
-- Date: 2026-04-20
-- ============================================================

-- Update the org-research-folder-creator agent to report to the operations director
UPDATE agents
SET
  reports_to = (SELECT id FROM agents WHERE name = 'paperclipforge-ai-operations-director'),
  updated_at = NOW()
WHERE name = 'paperclipforge-ai-org-research-folder-creator'
  AND reports_to IS NULL;

-- ============================================================
-- VERIFICATION QUERY
-- ============================================================

-- Check the update was successful
-- SELECT
--   a.name,
--   a.title,
--   reporter.name as reports_to_name,
--   reporter.title as reports_to_title
-- FROM agents a
-- LEFT JOIN agents reporter ON a.reports_to = reporter.id
-- WHERE a.name = 'paperclipforge-ai-org-research-folder-creator';