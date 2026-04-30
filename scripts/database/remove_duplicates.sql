-- Remove duplicate agents from Paperclip agents table
-- This script identifies and removes duplicate agents based on name + company_id
-- Keeps the agent with API keys when possible, otherwise the most recently updated
-- Handles foreign key constraints properly

-- First, let's see what duplicates exist and their foreign key relationships

-- Standard name + company duplicates
SELECT
    'NAME_DUPLICATES' as duplicate_type,
    a.name,
    a.company_id,
    COUNT(*) as duplicate_count,
    STRING_AGG(a.id::text ||
               ' (title:' || COALESCE(a.title, 'N/A') ||
               ', api_keys:' || COALESCE(ak.key_count::text, '0') || ')',
               ', ' ORDER BY a.created_at DESC) as agent_details,
    STRING_AGG(a.created_at::text, ', ' ORDER BY a.created_at DESC) as created_dates
FROM agents a
LEFT JOIN (
    SELECT agent_id, COUNT(*) as key_count
    FROM agent_api_keys
    GROUP BY agent_id
) ak ON a.id = ak.agent_id
GROUP BY a.name, a.company_id
HAVING COUNT(*) > 1

UNION ALL

-- Check for potential CEO duplicates (same role in same company)
SELECT
    'ROLE_DUPLICATES' as duplicate_type,
    'CEO Role in ' || c.name as name,
    a.company_id,
    COUNT(*) as duplicate_count,
    STRING_AGG(a.id::text || ' (' || a.name || ': ' || COALESCE(a.title, 'N/A') ||
               ', api_keys:' || COALESCE(ak.key_count::text, '0') || ')',
               ', ' ORDER BY a.created_at DESC) as agent_details,
    STRING_AGG(a.created_at::text, ', ' ORDER BY a.created_at DESC) as created_dates
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN (
    SELECT agent_id, COUNT(*) as key_count
    FROM agent_api_keys
    GROUP BY agent_id
) ak ON a.id = ak.agent_id
WHERE LOWER(a.title) LIKE '%chief executive%' OR LOWER(a.role) = 'ceo'
GROUP BY a.company_id, c.name
HAVING COUNT(*) > 1

ORDER BY duplicate_type, duplicate_count DESC, name;

-- Now remove the duplicates, keeping agents that have foreign key references when possible
-- Use a more sophisticated approach that considers foreign key relationships

-- FIRST: Handle name + company duplicates
-- Delete the foreign key references from agent_api_keys first
DELETE FROM agent_api_keys
WHERE agent_id IN (
    SELECT id FROM (
        SELECT
            a.id,
            ROW_NUMBER() OVER (
                PARTITION BY a.name, a.company_id
                ORDER BY
                    -- Prioritize agents with API keys
                    COALESCE(ak.key_count, 0) DESC,
                    -- Then by most recent update
                    a.updated_at DESC,
                    -- Then by most recent creation
                    a.created_at DESC,
                    -- Finally by ID for consistency
                    a.id
            ) as priority_rank
        FROM agents a
        LEFT JOIN (
            SELECT agent_id, COUNT(*) as key_count
            FROM agent_api_keys
            GROUP BY agent_id
        ) ak ON a.id = ak.agent_id
        WHERE EXISTS (
            SELECT 1 FROM agents a2
            WHERE a2.name = a.name AND a2.company_id = a.company_id
            GROUP BY a2.name, a2.company_id
            HAVING COUNT(*) > 1
        )
    ) ranked_agents
    WHERE priority_rank > 1
);

-- Then delete the duplicate name+company agents
DELETE FROM agents
WHERE id IN (
    SELECT id FROM (
        SELECT
            a.id,
            ROW_NUMBER() OVER (
                PARTITION BY a.name, a.company_id
                ORDER BY
                    -- Prioritize agents with API keys
                    COALESCE(ak.key_count, 0) DESC,
                    -- Then by most recent update
                    a.updated_at DESC,
                    -- Then by most recent creation
                    a.created_at DESC,
                    -- Finally by ID for consistency
                    a.id
            ) as priority_rank
        FROM agents a
        LEFT JOIN (
            SELECT agent_id, COUNT(*) as key_count
            FROM agent_api_keys
            GROUP BY agent_id
        ) ak ON a.id = ak.agent_id
        WHERE EXISTS (
            SELECT 1 FROM agents a2
            WHERE a2.name = a.name AND a2.company_id = a.company_id
            GROUP BY a2.name, a2.company_id
            HAVING COUNT(*) > 1
        )
    ) ranked_agents
    WHERE priority_rank > 1
);

-- SECOND: Handle CEO role duplicates (same role in same company)
-- Delete API keys for duplicate CEOs
DELETE FROM agent_api_keys
WHERE agent_id IN (
    SELECT id FROM (
        SELECT
            a.id,
            ROW_NUMBER() OVER (
                PARTITION BY a.company_id, LOWER(COALESCE(a.title, '')), LOWER(COALESCE(a.role, ''))
                ORDER BY
                    -- Prioritize agents with API keys
                    COALESCE(ak.key_count, 0) DESC,
                    -- Then by most recent update
                    a.updated_at DESC,
                    -- Then by most recent creation
                    a.created_at DESC,
                    -- Finally by ID for consistency
                    a.id
            ) as priority_rank
        FROM agents a
        LEFT JOIN (
            SELECT agent_id, COUNT(*) as key_count
            FROM agent_api_keys
            GROUP BY agent_id
        ) ak ON a.id = ak.agent_id
        WHERE LOWER(COALESCE(a.title, '')) LIKE '%chief executive%'
           OR LOWER(COALESCE(a.role, '')) = 'ceo'
           OR LOWER(COALESCE(a.title, '')) LIKE '%ceo%'
        AND EXISTS (
            SELECT 1 FROM agents a2
            WHERE a2.company_id = a.company_id
              AND (LOWER(COALESCE(a2.title, '')) LIKE '%chief executive%'
                   OR LOWER(COALESCE(a2.role, '')) = 'ceo'
                   OR LOWER(COALESCE(a2.title, '')) LIKE '%ceo%')
            GROUP BY a2.company_id
            HAVING COUNT(*) > 1
        )
    ) ranked_agents
    WHERE priority_rank > 1
);

-- Then delete duplicate CEOs
DELETE FROM agents
WHERE id IN (
    SELECT id FROM (
        SELECT
            a.id,
            ROW_NUMBER() OVER (
                PARTITION BY a.company_id, LOWER(COALESCE(a.title, '')), LOWER(COALESCE(a.role, ''))
                ORDER BY
                    -- Prioritize agents with API keys
                    COALESCE(ak.key_count, 0) DESC,
                    -- Then by most recent update
                    a.updated_at DESC,
                    -- Then by most recent creation
                    a.created_at DESC,
                    -- Finally by ID for consistency
                    a.id
            ) as priority_rank
        FROM agents a
        LEFT JOIN (
            SELECT agent_id, COUNT(*) as key_count
            FROM agent_api_keys
            GROUP BY agent_id
        ) ak ON a.id = ak.agent_id
        WHERE LOWER(COALESCE(a.title, '')) LIKE '%chief executive%'
           OR LOWER(COALESCE(a.role, '')) = 'ceo'
           OR LOWER(COALESCE(a.title, '')) LIKE '%ceo%'
        AND EXISTS (
            SELECT 1 FROM agents a2
            WHERE a2.company_id = a.company_id
              AND (LOWER(COALESCE(a2.title, '')) LIKE '%chief executive%'
                   OR LOWER(COALESCE(a2.role, '')) = 'ceo'
                   OR LOWER(COALESCE(a2.title, '')) LIKE '%ceo%')
            GROUP BY a2.company_id
            HAVING COUNT(*) > 1
        )
    ) ranked_agents
    WHERE priority_rank > 1
);

-- Verify the duplicates are removed
SELECT
    name,
    company_id,
    COUNT(*) as remaining_count
FROM agents
GROUP BY name, company_id
HAVING COUNT(*) > 1
ORDER BY remaining_count DESC;

-- Show summary of what was removed
SELECT
    'Cleanup completed' as status,
    COUNT(*) as total_agents_after_cleanup,
    (SELECT COUNT(*) FROM agent_api_keys) as remaining_api_keys
FROM agents;

-- Show which agents were kept (with their reference counts)
SELECT
    a.name,
    a.company_id,
    a.id,
    COALESCE(ak.key_count, 0) as api_keys,
    a.created_at,
    a.updated_at
FROM agents a
LEFT JOIN (
    SELECT agent_id, COUNT(*) as key_count
    FROM agent_api_keys
    GROUP BY agent_id
) ak ON a.id = ak.agent_id
WHERE (a.name, a.company_id) IN (
    SELECT name, company_id
    FROM agents
    GROUP BY name, company_id
    HAVING COUNT(*) > 1
)
ORDER BY a.name, a.company_id, a.updated_at DESC;

-- MANUAL CLEANUP SECTION: Handle specific duplicates like Orion CEO case
-- Uncomment and modify the sections below for manual duplicate removal

/*
-- Example: Remove specific duplicate Orion agents
-- First check which Orion agents exist
SELECT
    a.id, a.name, a.title, a.role, a.company_id, c.name as company_name,
    COALESCE(ak.key_count, 0) as api_keys,
    a.created_at, a.updated_at
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN (
    SELECT agent_id, COUNT(*) as key_count
    FROM agent_api_keys
    GROUP BY agent_id
) ak ON a.id = ak.agent_id
WHERE LOWER(a.name) LIKE '%orion%' OR LOWER(a.title) LIKE '%chief%'
ORDER BY a.created_at DESC;

-- Then manually delete the duplicate (replace with actual ID)
-- DELETE FROM agent_api_keys WHERE agent_id = 'duplicate-orion-id';
-- DELETE FROM agents WHERE id = 'duplicate-orion-id';
*/
