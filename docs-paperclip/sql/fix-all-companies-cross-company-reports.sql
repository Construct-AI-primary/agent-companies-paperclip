-- Fix cross-company reporting relationships for ALL companies
-- Ensure all agents only report to other agents within the same company

-- Step 1: Get all company IDs
CREATE TEMP TABLE company_ids AS
SELECT DISTINCT company_id
FROM agents
WHERE company_id IS NOT NULL
ORDER BY company_id;

-- Step 2: For each company, fix cross-company reporting relationships
DO $$
DECLARE
    company_record RECORD;
    fixed_count INTEGER := 0;
BEGIN
    -- Loop through each company
    FOR company_record IN SELECT company_id FROM company_ids
    LOOP
        RAISE NOTICE 'Processing company: %', company_record.company_id;

        -- Fix agents in this company that report to agents in other companies
        UPDATE agents
        SET reports_to = NULL
        WHERE company_id = company_record.company_id
          AND reports_to IS NOT NULL
          AND reports_to NOT IN (
            SELECT id FROM agents WHERE company_id = company_record.company_id
          );

        -- Count how many were fixed
        GET DIAGNOSTICS fixed_count = ROW_COUNT;
        RAISE NOTICE 'Fixed % agents in company %', fixed_count, company_record.company_id;
    END LOOP;

    RAISE NOTICE 'Cross-company reporting fix completed for all companies';
END $$;

-- Step 3: Clean up temp table
DROP TABLE company_ids;

-- Step 4: Report summary
SELECT
    company_id,
    COUNT(*) as total_agents,
    COUNT(CASE WHEN reports_to IS NOT NULL THEN 1 END) as agents_with_reports,
    COUNT(CASE WHEN reports_to IS NULL THEN 1 END) as agents_without_reports
FROM agents
WHERE company_id IS NOT NULL
GROUP BY company_id
ORDER BY company_id;