-- Extract ALL Tables RLS Status Report
-- Run this in Supabase SQL Editor to get complete RLS status for all tables
-- Copy the ENTIRE OUTPUT (including headers) and save as extract_rls_policies_output.sql
-- Then run: node docs/schema/format_rls_policies.js

-- Get ALL tables with their RLS status and policy counts
SELECT
    n.nspname as schemaname,
    c.relname as tablename,
    CASE
        WHEN c.relrowsecurity = false THEN 'NO_RLS'
        WHEN c.relrowsecurity = true AND p.policy_count > 0 THEN 'HAS_POLICIES'
        WHEN c.relrowsecurity = true AND (p.policy_count IS NULL OR p.policy_count = 0) THEN 'RLS_ENABLED_NO_POLICIES'
        ELSE 'UNKNOWN'
    END as rls_status,
    c.relrowsecurity as rls_enabled,
    COALESCE(p.policy_count, 0) as policy_count,
    CASE
        WHEN p.first_policy IS NOT NULL THEN p.first_policy
        ELSE 'No policies'
    END as sample_policy
FROM pg_class c
JOIN pg_namespace n ON c.relnamespace = n.oid
LEFT JOIN (
    SELECT
        schemaname,
        tablename,
        COUNT(*) as policy_count,
        STRING_AGG(policyname, ', ' ORDER BY policyname) as first_policy
    FROM pg_policies
    WHERE schemaname = 'public'
    GROUP BY schemaname, tablename
) p ON c.relname = p.tablename AND n.nspname = p.schemaname
WHERE n.nspname = 'public'
  AND c.relkind = 'r'
  AND c.relname NOT LIKE 'pg_%'  -- Exclude system tables
ORDER BY
    CASE
        WHEN c.relrowsecurity = false THEN 1  -- No RLS first
        WHEN c.relrowsecurity = true AND p.policy_count > 0 THEN 2  -- Has policies second
        WHEN c.relrowsecurity = true AND (p.policy_count IS NULL OR p.policy_count = 0) THEN 3  -- RLS enabled no policies third
        ELSE 4
    END,
    c.relname;

-- Extract all RLS policies with detailed information (for tables that have them)
SELECT
    schemaname,
    tablename,
    policyname,
    permissive,
    CASE
        WHEN roles = '{public}' THEN 'public'
        WHEN roles = '{anon}' THEN 'anon'
        WHEN roles = '{authenticated}' THEN 'authenticated'
        WHEN roles IS NULL THEN 'authenticated'
        ELSE array_to_string(roles, ', ')
    END as roles,
    cmd,
    qual,
    with_check
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, policyname;
