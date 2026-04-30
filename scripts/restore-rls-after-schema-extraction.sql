-- ========================================================================================
-- RESTORE RLS AFTER SCHEMA EXTRACTION
-- This script restores Row Level Security to its original state on all tables
-- Run this immediately after schema extraction is complete
-- ========================================================================================

-- Check if the backup table exists (from the disable script)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_name = 'rls_backup'
        AND table_type = 'LOCAL TEMPORARY'
    ) THEN
        RAISE EXCEPTION 'ERROR: RLS backup table not found. Make sure to run disable-rls-for-schema-extraction.sql first in the same session.';
    END IF;
END $$;

-- Restore RLS based on the backup
DO $$
DECLARE
    backup_record RECORD;
    tables_restored INTEGER := 0;
    tables_enabled INTEGER := 0;
    tables_disabled INTEGER := 0;
BEGIN
    FOR backup_record IN
        SELECT schemaname, tablename, rowsecurity
        FROM rls_backup
        ORDER BY schemaname, tablename
    LOOP
        -- Restore the original RLS state
        IF backup_record.rowsecurity THEN
            EXECUTE format('ALTER TABLE %I.%I ENABLE ROW LEVEL SECURITY',
                          backup_record.schemaname, backup_record.tablename);
            tables_enabled := tables_enabled + 1;
            RAISE NOTICE 'Restored RLS (ENABLED) on: %.%', backup_record.schemaname, backup_record.tablename;
        ELSE
            EXECUTE format('ALTER TABLE %I.%I DISABLE ROW LEVEL SECURITY',
                          backup_record.schemaname, backup_record.tablename);
            tables_disabled := tables_disabled + 1;
            RAISE NOTICE 'Restored RLS (DISABLED) on: %.%', backup_record.schemaname, backup_record.tablename;
        END IF;

        tables_restored := tables_restored + 1;
    END LOOP;

    RAISE NOTICE 'RLS restoration complete: % tables processed (% enabled, % disabled)',
                tables_restored, tables_enabled, tables_disabled;
END $$;

-- Verify RLS has been restored correctly
SELECT
    b.schemaname,
    b.tablename,
    b.rowsecurity as original_rls,
    CASE
        WHEN b.rowsecurity THEN 'ENABLED'
        ELSE 'DISABLED'
    END as rls_status,
    CASE
        WHEN p.rowsecurity = b.rowsecurity THEN '✓ MATCH'
        ELSE '✗ MISMATCH'
    END as verification
FROM rls_backup b
LEFT JOIN pg_tables p ON p.schemaname = b.schemaname AND p.tablename = b.tablename
ORDER BY b.schemaname, b.tablename;

-- Clean up the temporary backup table
DROP TABLE rls_backup;

-- Final verification
DO $$
DECLARE
    total_tables INTEGER;
    rls_enabled INTEGER;
    rls_disabled INTEGER;
BEGIN
    SELECT
        COUNT(*),
        COUNT(*) FILTER (WHERE rowsecurity = true),
        COUNT(*) FILTER (WHERE rowsecurity = false)
    INTO total_tables, rls_enabled, rls_disabled
    FROM pg_tables
    WHERE schemaname = 'public';

    RAISE NOTICE 'FINAL VERIFICATION: % total tables (% RLS enabled, % RLS disabled)',
                total_tables, rls_enabled, rls_disabled;
END $$;