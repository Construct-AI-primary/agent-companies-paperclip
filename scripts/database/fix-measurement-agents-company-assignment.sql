-- Fix Measurement Agents Company Assignment
-- Move measurement-related agents from paperclipforge-ai to measureforge-ai

-- First, get the company IDs
-- paperclipforge-ai company ID and measureforge-ai company ID

-- Update agent company assignments for measurement agents
UPDATE agents
SET company_id = (SELECT id FROM companies WHERE slug = 'measureforge-ai')
WHERE slug IN (
    'measurement-validation-specialist',
    'measurement-standards-specialist',
    'measurement-coordination-specialist',
    'advanced-engineering-analysis',
    'cross-discipline-coordination',
    'engineering-ui-specialist',
    'document-intelligence-specialist',
    'data-processing-specialist',
    'integration-orchestration-specialist',
    'communication-coordination-specialist'
)
AND company_id = (SELECT id FROM companies WHERE slug = 'paperclipforge-ai');

-- Update agent names to remove paperclipforge-ai prefix if they have it
UPDATE agents
SET name = REPLACE(name, 'paperclipforge-ai-', '')
WHERE name LIKE 'paperclipforge-ai-measurement-%'
   OR name LIKE 'paperclipforge-ai-advanced-%'
   OR name LIKE 'paperclipforge-ai-cross-%'
   OR name LIKE 'paperclipforge-ai-engineering-%'
   OR name LIKE 'paperclipforge-ai-document-%'
   OR name LIKE 'paperclipforge-ai-data-%'
   OR name LIKE 'paperclipforge-ai-integration-%'
   OR name LIKE 'paperclipforge-ai-communication-%';

-- Update agent slugs to remove paperclipforge-ai prefix if they have it
UPDATE agents
SET slug = REPLACE(slug, 'paperclipforge-ai-', '')
WHERE slug LIKE 'paperclipforge-ai-measurement-%'
   OR slug LIKE 'paperclipforge-ai-advanced-%'
   OR slug LIKE 'paperclipforge-ai-cross-%'
   OR slug LIKE 'paperclipforge-ai-engineering-%'
   OR slug LIKE 'paperclipforge-ai-document-%'
   OR slug LIKE 'paperclipforge-ai-data-%'
   OR slug LIKE 'paperclipforge-ai-integration-%'
   OR slug LIKE 'paperclipforge-ai-communication-%';

-- Update agent_model_assignments table to reflect the company changes
UPDATE agent_model_assignments
SET company_id = (SELECT id FROM companies WHERE slug = 'measureforge-ai')
WHERE agent_id IN (
    SELECT id FROM agents
    WHERE slug IN (
        'measurement-validation-specialist',
        'measurement-standards-specialist',
        'measurement-coordination-specialist',
        'advanced-engineering-analysis',
        'cross-discipline-coordination',
        'engineering-ui-specialist',
        'document-intelligence-specialist',
        'data-processing-specialist',
        'integration-orchestration-specialist',
        'communication-coordination-specialist'
    )
)
AND company_id = (SELECT id FROM companies WHERE slug = 'paperclipforge-ai');

-- Update agent_api_keys table to reflect the company changes
UPDATE agent_api_keys
SET company_id = (SELECT id FROM companies WHERE slug = 'measureforge-ai')
WHERE agent_id IN (
    SELECT id FROM agents
    WHERE slug IN (
        'measurement-validation-specialist',
        'measurement-standards-specialist',
        'measurement-coordination-specialist',
        'advanced-engineering-analysis',
        'cross-discipline-coordination',
        'engineering-ui-specialist',
        'document-intelligence-specialist',
        'data-processing-specialist',
        'integration-orchestration-specialist',
        'communication-coordination-specialist'
    )
)
AND company_id = (SELECT id FROM companies WHERE slug = 'paperclipforge-ai');

-- Update agent_skills table to reflect the company changes
UPDATE agent_skills
SET company_id = (SELECT id FROM companies WHERE slug = 'measureforge-ai')
WHERE agent_id IN (
    SELECT id FROM agents
    WHERE slug IN (
        'measurement-validation-specialist',
        'measurement-standards-specialist',
        'measurement-coordination-specialist',
        'advanced-engineering-analysis',
        'cross-discipline-coordination',
        'engineering-ui-specialist',
        'document-intelligence-specialist',
        'data-processing-specialist',
        'integration-orchestration-specialist',
        'communication-coordination-specialist'
    )
)
AND company_id = (SELECT id FROM companies WHERE slug = 'paperclipforge-ai');

-- Update issues table to reflect agent company changes (if agent_id references change)
-- This might not be needed if agent IDs remain the same, but updating assignee company context
UPDATE issues
SET assignee_company_id = (SELECT id FROM companies WHERE slug = 'measureforge-ai')
WHERE assignee_id IN (
    SELECT id FROM agents
    WHERE slug IN (
        'measurement-validation-specialist',
        'measurement-standards-specialist',
        'measurement-coordination-specialist',
        'advanced-engineering-analysis',
        'cross-discipline-coordination',
        'engineering-ui-specialist',
        'document-intelligence-specialist',
        'data-processing-specialist',
        'integration-orchestration-specialist',
        'communication-coordination-specialist'
    )
)
AND assignee_company_id = (SELECT id FROM companies WHERE slug = 'paperclipforge-ai');

-- Update issue_comments to reflect agent company changes
UPDATE issue_comments
SET author_company_id = (SELECT id FROM companies WHERE slug = 'measureforge-ai')
WHERE author_id IN (
    SELECT id FROM agents
    WHERE slug IN (
        'measurement-validation-specialist',
        'measurement-standards-specialist',
        'measurement-coordination-specialist',
        'advanced-engineering-analysis',
        'cross-discipline-coordination',
        'engineering-ui-specialist',
        'document-intelligence-specialist',
        'data-processing-specialist',
        'integration-orchestration-specialist',
        'communication-coordination-specialist'
    )
)
AND author_company_id = (SELECT id FROM companies WHERE slug = 'paperclipforge-ai');

-- Update activity_logs to reflect agent company changes
UPDATE activity_logs
SET company_id = (SELECT id FROM companies WHERE slug = 'measureforge-ai')
WHERE actor_id IN (
    SELECT id FROM agents
    WHERE slug IN (
        'measurement-validation-specialist',
        'measurement-standards-specialist',
        'measurement-coordination-specialist',
        'advanced-engineering-analysis',
        'cross-discipline-coordination',
        'engineering-ui-specialist',
        'document-intelligence-specialist',
        'data-processing-specialist',
        'integration-orchestration-specialist',
        'communication-coordination-specialist'
    )
)
AND company_id = (SELECT id FROM companies WHERE slug = 'paperclipforge-ai');

-- Verification queries
-- Check that agents are now assigned to measureforge-ai
SELECT a.slug, c.slug as company_slug, a.name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.slug IN (
    'measurement-validation-specialist',
    'measurement-standards-specialist',
    'measurement-coordination-specialist',
    'advanced-engineering-analysis',
    'cross-discipline-coordination',
    'engineering-ui-specialist',
    'document-intelligence-specialist',
    'data-processing-specialist',
    'integration-orchestration-specialist',
    'communication-coordination-specialist'
)
ORDER BY a.slug;

-- Check agent counts by company
SELECT c.slug as company_slug, COUNT(a.id) as agent_count
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
WHERE c.slug IN ('paperclipforge-ai', 'measureforge-ai')
GROUP BY c.slug
ORDER BY c.slug;