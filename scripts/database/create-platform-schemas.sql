-- ============================================================
-- Platform Database Schema Creation Script
-- Created: 2026-04-21
-- Description: Creates database schemas for engineering and measurement platforms
-- Usage: Run this script against your PostgreSQL database
-- Prerequisites: Base Paperclip database schema must exist
-- ============================================================

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Set search path for consistency
SET search_path TO public;

-- Log start of schema creation
DO $$
BEGIN
    RAISE NOTICE 'Starting platform database schema creation...';
END $$;

-- Include engineering platform schema
\i docs-paperclip/disciplines-shared/engineering/database/create-engineering-schema.sql

-- Include measurement platform schema
\i docs-paperclip/disciplines-shared/measurement/database/create-measurement-schema.sql

-- Create cross-platform integration views
-- Note: Projects table integration commented out as it exists in a different Supabase project
-- CREATE OR REPLACE VIEW v_platform_projects AS
-- SELECT
--     p.id,
--     p.name as project_name,
--     p.status as project_status,
--     p.created_at as project_created,
--     -- Engineering statistics
--     eng.model_count,
--     eng.analysis_count,
--     eng.completed_analyses,
--     -- Measurement statistics
--     meas.measurement_count,
--     meas.validated_measurements,
--     meas.total_measurement_value
-- FROM projects p  -- Projects table exists in main Construct AI database
-- LEFT JOIN (
--     SELECT
--         project_id,
--         COUNT(DISTINCT m.id) as model_count,
--         COUNT(DISTINCT a.id) as analysis_count,
--         COUNT(DISTINCT CASE WHEN a.status = 'completed' THEN a.id END) as completed_analyses
--     FROM a_engineering_models m
--     LEFT JOIN a_engineering_analysis a ON m.id = a.model_id
--     GROUP BY project_id
-- ) eng ON p.id = eng.project_id
-- LEFT JOIN (
--     SELECT
--         project_id,
--         COUNT(DISTINCT id) as measurement_count,
--         COUNT(DISTINCT CASE WHEN validation_status = 'approved' THEN id END) as validated_measurements,
--         COALESCE(SUM(amount), 0) as total_measurement_value
--     FROM a_measurement_data
--     WHERE validation_status = 'approved'
--     GROUP BY project_id
-- ) meas ON p.id = meas.project_id;

-- Create platform health monitoring view
CREATE OR REPLACE VIEW v_platform_health AS
SELECT
    'engineering' as platform,
    COUNT(*) as total_models,
    COUNT(CASE WHEN validation_status = 'approved' THEN 1 END) as validated_models,
    COUNT(CASE WHEN ai_processed = true THEN 1 END) as ai_processed_models
FROM a_engineering_models

UNION ALL

SELECT
    'measurement' as platform,
    COUNT(*) as total_models,
    COUNT(CASE WHEN validation_status = 'approved' THEN 1 END) as validated_models,
    COUNT(CASE WHEN ai_processed = true THEN 1 END) as ai_processed_models
FROM a_measurement_data;

-- Create platform activity summary view
CREATE OR REPLACE VIEW v_platform_activity AS
SELECT
    DATE_TRUNC('day', timestamp) as activity_date,
    'engineering' as platform,
    COUNT(*) as total_actions,
    COUNT(CASE WHEN ai_agent IS NOT NULL THEN 1 END) as ai_actions,
    COUNT(DISTINCT user_id) as active_users
FROM a_engineering_audit_trail
GROUP BY DATE_TRUNC('day', timestamp)

UNION ALL

SELECT
    DATE_TRUNC('day', timestamp) as activity_date,
    'measurement' as platform,
    COUNT(*) as total_actions,
    COUNT(CASE WHEN ai_agent IS NOT NULL THEN 1 END) as ai_actions,
    COUNT(DISTINCT user_id) as active_users
FROM a_measurement_audit_trail
GROUP BY DATE_TRUNC('day', timestamp);

-- Create platform standards compliance view
CREATE OR REPLACE VIEW v_platform_standards_compliance AS
SELECT
    'engineering' as platform,
    discipline_code,
    jurisdiction,
    COUNT(*) as total_models,
    COUNT(CASE WHEN validation_status = 'approved' THEN 1 END) as compliant_models,
    ROUND(
        COUNT(CASE WHEN validation_status = 'approved' THEN 1 END)::decimal /
        NULLIF(COUNT(*), 0) * 100, 2
    ) as compliance_rate
FROM a_engineering_models
GROUP BY discipline_code, jurisdiction

UNION ALL

SELECT
    'measurement' as platform,
    discipline_code,
    jurisdiction,
    COUNT(*) as total_measurements,
    COUNT(CASE WHEN validation_status = 'approved' THEN 1 END) as compliant_measurements,
    ROUND(
        COUNT(CASE WHEN validation_status = 'approved' THEN 1 END)::decimal /
        NULLIF(COUNT(*), 0) * 100, 2
    ) as compliance_rate
FROM a_measurement_data m
JOIN a_measurement_standards s ON m.discipline_code = s.discipline_code
GROUP BY discipline_code, jurisdiction;

-- Grant permissions for cross-platform views
-- GRANT SELECT ON v_platform_projects TO platform_users;
-- GRANT SELECT ON v_platform_health TO platform_users;
-- GRANT SELECT ON v_platform_activity TO platform_users;
-- GRANT SELECT ON v_platform_standards_compliance TO platform_users;

-- Create platform initialization data
-- Note: Standards initialization commented out as users table doesn't exist in Paperclip database
-- INSERT INTO a_engineering_standards (
--     discipline_code, jurisdiction, standard_code, standard_name, version,
--     requirements, design_values, created_by
-- ) SELECT
--     '00850', 'ZA', 'SANS-10160', 'Basis of structural design and actions for buildings and industrial structures', '2017',
--     '{"load_combinations": ["1.2G + 1.5Q", "1.35G + 1.5Q"], "safety_factors": {"uls": 1.5, "sls": 1.0}}',
--     '{"concrete": {"fck": 30, "fctm": 2.9}, "steel": {"fy": 300, "fu": 450}}',
--     (SELECT id FROM users LIMIT 1)  -- Users table doesn't exist in Paperclip database
-- WHERE NOT EXISTS (
--     SELECT 1 FROM a_engineering_standards
--     WHERE discipline_code = '00850' AND jurisdiction = 'ZA' AND standard_code = 'SANS-10160'
-- );

-- INSERT INTO a_measurement_standards (
--     discipline_code, jurisdiction, standard_code, standard_name, version,
--     measurement_rules, tolerance_limits, created_by
-- ) SELECT
--     '00850', 'ZA', 'SANS-1200', 'Civil engineering construction', '1987',
--     '{"quantity_accuracy": "±5%", "unit_consistency": "required", "measurement_methods": ["direct", "scaled", "calculated"]}',
--     '{"volume": 0.05, "area": 0.03, "length": 0.02}',
--     (SELECT id FROM users LIMIT 1)  -- Users table doesn't exist in Paperclip database
-- WHERE NOT EXISTS (
--     SELECT 1 FROM a_measurement_standards
--     WHERE discipline_code = '00850' AND jurisdiction = 'ZA' AND standard_code = 'SANS-1200'
-- );

-- Log completion
DO $$
BEGIN
    RAISE NOTICE 'Platform database schema creation completed successfully!';
    RAISE NOTICE 'Created tables:';
    RAISE NOTICE '  - Engineering: a_engineering_models, a_engineering_analysis, a_engineering_audit_trail, a_engineering_standards, a_engineering_templates';
    RAISE NOTICE '  - Measurement: a_measurement_data, a_measurement_audit_trail, a_measurement_standards, a_measurement_templates, a_measurement_validation_rules, a_measurement_cad_integration, a_measurement_approvals';
    RAISE NOTICE '  - Cross-platform: v_platform_projects, v_platform_health, v_platform_activity, v_platform_standards_compliance';
END $$;

-- ============================================================
-- Verification queries (run after schema creation)
-- ============================================================

-- Check all platform tables exist
-- SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND (table_name LIKE 'a_engineering%' OR table_name LIKE 'a_measurement%') ORDER BY table_name;

-- Check all platform views exist
-- SELECT table_name FROM information_schema.views WHERE table_schema = 'public' AND table_name LIKE 'v_platform%' ORDER BY table_name;

-- Check platform health
-- SELECT * FROM v_platform_health;

-- Check standards initialization
-- SELECT platform, discipline_code, jurisdiction, COUNT(*) as standards_count FROM v_platform_standards_compliance GROUP BY platform, discipline_code, jurisdiction;

-- ============================================================
-- Clean up: Uncomment to remove all platform schemas
-- ============================================================

-- DROP VIEW IF EXISTS v_platform_standards_compliance;
-- DROP VIEW IF EXISTS v_platform_activity;
-- DROP VIEW IF EXISTS v_platform_health;
-- DROP VIEW IF EXISTS v_platform_projects;

-- \i docs-paperclip/disciplines-shared/measurement/database/cleanup-measurement-schema.sql
-- \i docs-paperclip/disciplines-shared/engineering/database/cleanup-engineering-schema.sql