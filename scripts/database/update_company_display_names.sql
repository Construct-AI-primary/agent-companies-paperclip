-- SQL Script to Update Company Display Names
-- Purpose: Update company 'name' field to show proper capitalization in Paperclip UI
-- Display format: {CompanyName} AI (e.g., KnowledgeForge AI)

-- =============================================================================
-- COMPANY NAME UPDATE SCRIPT
-- Purpose: Update company 'name' field for proper Paperclip UI display
-- Uses issue_prefix to match companies since there's no slug column
-- =============================================================================

-- Update company names to use proper capitalization
-- Using CASE WHEN with issue_prefix to identify companies

UPDATE companies SET name = 
  CASE issue_prefix
    WHEN 'KNOW' THEN 'KnowledgeForge AI'
    WHEN 'DOM' THEN 'DomainForge AI'
    WHEN 'DEV' THEN 'DevForge AI'
    WHEN 'QUAL' THEN 'QualityForge AI'
    WHEN 'INFRA' THEN 'InfraForge AI'
    WHEN 'PROMPT' THEN 'PromptForge AI'
    WHEN 'CONTENT' THEN 'ContentForge AI'
    WHEN 'EXEC' THEN 'ExecForge AI'
    WHEN 'MOBILE' THEN 'MobileForge AI'
    WHEN 'VOICE' THEN 'VoiceForge AI'
    WHEN 'SAAS' THEN 'SaaSForge AI'
    WHEN 'LEARN' THEN 'LearningForge AI'
    WHEN 'PAPCLIP' THEN 'PaperclipForge AI'
    WHEN 'LOOPY' THEN 'Loopy AI'
    ELSE name
  END;

-- Alternative: If you prefer matching by current name:
-- UPDATE companies SET name = 'KnowledgeForge AI' WHERE name = 'knowledgeforge-ai';
-- UPDATE companies SET name = 'DomainForge AI' WHERE name = 'domainforge-ai';
-- etc.

-- Verification query
-- SELECT issue_prefix, name FROM companies ORDER BY issue_prefix;

