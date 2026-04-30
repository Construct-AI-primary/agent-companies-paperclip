-- ============================================================
-- Phase 5: Add Unique Constraint on Agent Name
-- Created: 2026-04-22
-- Description: Adds unique constraint on agents.name to prevent duplicate names
-- Prerequisites: All agent migrations complete, no duplicates exist
-- Follows: Agent Table Reconciliation Plan Phase 5
-- ============================================================

-- ============================================================
-- STEP 1: Verify no duplicates exist before adding constraint
-- ============================================================

DO $$
DECLARE
    duplicate_count INTEGER;
BEGIN
    -- Check for duplicate names within same company
    SELECT COUNT(*) INTO duplicate_count
    FROM agents
    GROUP BY name, company_id
    HAVING COUNT(*) > 1;
    
    IF duplicate_count > 0 THEN
        RAISE EXCEPTION 'ERROR: Duplicate agent names exist. Please resolve duplicates before adding unique constraint.';
    END IF;
    
    -- Check for duplicate names across companies (should be unique globally)
    SELECT COUNT(*) INTO duplicate_count
    FROM (
        SELECT name, COUNT(DISTINCT company_id) as company_cnt
        FROM agents
        GROUP BY name
        HAVING COUNT(DISTINCT company_id) > 1
    ) AS cross_company_dups;
    
    IF duplicate_count > 0 THEN
        RAISE EXCEPTION 'ERROR: Agent names exist across multiple companies. Names must be globally unique.';
    END IF;
    
    RAISE NOTICE 'No duplicate agent names found. Safe to add unique constraint.';
END $$;

-- ============================================================
-- STEP 2: Check if constraint already exists and create
-- ============================================================

DO $$
BEGIN
    -- Check if unique index already exists
    IF EXISTS (
        SELECT 1 FROM pg_indexes 
        WHERE tablename = 'agents' 
          AND indexname = 'agents_name_unique_idx'
    ) THEN
        RAISE NOTICE 'Unique index agents_name_unique_idx already exists. Skipping constraint creation.';
    ELSE
        -- Create unique index on name column
        CREATE UNIQUE INDEX IF NOT EXISTS agents_name_unique_idx ON agents (name);
        RAISE NOTICE 'Successfully created unique index agents_name_unique_idx on agents.name';
    END IF;
END $$;

-- ============================================================
-- STEP 3: Verify constraint was applied
-- ============================================================

DO $$
BEGIN
    -- Verify the index exists
    IF EXISTS (
        SELECT 1 FROM pg_indexes 
        WHERE tablename = 'agents' 
          AND indexname = 'agents_name_unique_idx'
    ) THEN
        RAISE NOTICE 'Verification: Unique constraint on agents.name is now enforced.';
    ELSE
        RAISE WARNING 'Warning: Could not verify unique constraint. Please check manually.';
    END IF;
END $$;
