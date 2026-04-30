-- =============================================================================
-- AUTOMATED RLS SECURITY AUDIT SYSTEM
-- Generated: October 2025
-- Version: v1.0 Production-Ready
-- Based on: 0035_SUPABASE_RLS_POLICY_EXTRACTION_SYSTEM.sql
--
-- RECENT FIXES (December 2025):
-- ✅ Tasks Table RLS Policy Fixed: Implemented proper development mode support
--    using established is_dev_mode() pattern. See fix_tasks_rls_policy.sql
--    for the implementation that resolves dashboard access issues in dev mode.
-- =============================================================================

-- This system provides automated daily, weekly, and monthly security audits
-- with reporting, alerting, and remediation suggestions.

-- =============================================================================
-- 1. SECURITY AUDIT HISTORY TABLES
-- =============================================================================

-- Store historical audit results
CREATE TABLE IF NOT EXISTS security_audit_history (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    audit_timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    audit_type TEXT NOT NULL, -- 'daily', 'weekly', 'monthly', 'emergency'
    audit_period_start TIMESTAMP WITH TIME ZONE,
    audit_period_end TIMESTAMP WITH TIME ZONE,

    -- Overall metrics
    total_tables_audited INTEGER,
    tables_with_rls INTEGER,
    tables_fully_secure INTEGER,
    tables_partially_secure INTEGER,
    tables_no_security INTEGER,
    critical_breaches INTEGER,

    -- Priority breakdown
    critical_tables_count INTEGER,
    high_risk_tables_count INTEGER,
    medium_risk_tables_count INTEGER,
    low_risk_tables_count INTEGER,

    -- Compliance metrics
    compliance_percentage DECIMAL(5,2),
    improvement_last_week DECIMAL(5,2),

    -- Detailed results
    audit_details JSONB,
    security_status JSONB,
    recommended_actions JSONB,
    critical_alerts JSONB,

    -- Run metadata
    execution_duration_ms INTEGER,
    run_by TEXT DEFAULT 'automated_system',
    next_scheduled_run TIMESTAMP WITH TIME ZONE
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_security_audit_history_timestamp ON security_audit_history(audit_timestamp);
CREATE INDEX IF NOT EXISTS idx_security_audit_history_type ON security_audit_history(audit_type);
CREATE INDEX IF NOT EXISTS idx_security_audit_history_period ON security_audit_history(audit_period_start, audit_period_end);

-- Security alerts table for critical issues
CREATE TABLE IF NOT EXISTS security_alerts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    alert_timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    alert_level TEXT NOT NULL, -- 'critical', 'high', 'medium', 'low'
    alert_type TEXT NOT NULL, -- 'breach', 'gap', 'degradation', 'non-compliance'
    alert_title TEXT NOT NULL,
    alert_description TEXT,
    affected_tables JSONB, -- List of affected tables with details
    affected_rows INTEGER DEFAULT 0, -- Estimated number of records exposed
    risk_level TEXT, -- 'low', 'medium', 'high', 'critical'
    remediation_actions JSONB,
    remediation_deadline TIMESTAMP WITH TIME ZONE,
    status TEXT DEFAULT 'open', -- 'open', 'in_progress', 'resolved', 'ignored'
    resolved_at TIMESTAMP WITH TIME ZONE,
    resolved_by TEXT
);

-- Indexes for alerts
CREATE INDEX IF NOT EXISTS idx_security_alerts_level ON security_alerts(alert_level);
CREATE INDEX IF NOT EXISTS idx_security_alerts_status ON security_alerts(status);
CREATE INDEX IF NOT EXISTS idx_security_alerts_deadline ON security_alerts(remediation_deadline);

-- Security reports for stakeholders
CREATE TABLE IF NOT EXISTS security_reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    report_period TEXT NOT NULL, -- 'daily', 'weekly', 'monthly'
    report_date DATE DEFAULT CURRENT_DATE,
    generated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

    -- Report sections
    executive_summary JSONB,
    security_status_overview JSONB,
    compliance_metrics JSONB,
    risk_assessment JSONB,
    recommendations JSONB,

    -- Recipients and status
    recipients JSONB, -- List of email addresses and notification preferences
    sent_at TIMESTAMP WITH TIME ZONE,
    delivery_status JSONB,

    -- Report metadata
    approval_required BOOLEAN DEFAULT FALSE,
    approved_by TEXT,
    approved_at TIMESTAMP WITH TIME ZONE
);

-- =============================================================================
-- 2. CORE AUDIT FUNCTIONS
-- =============================================================================

-- Main automated security audit function
CREATE OR REPLACE FUNCTION run_automated_security_audit(
    audit_category TEXT DEFAULT 'scheduled' -- 'scheduled', 'emergency', 'manual'
) RETURNS JSONB AS $$
DECLARE
    start_time TIMESTAMP WITH TIME ZONE;
    end_time TIMESTAMP WITH TIME ZONE;
    audit_results JSONB;
    audit_type TEXT;
    alert_count INTEGER := 0;
BEGIN
    start_time := NOW();
    audit_type := CASE
        WHEN audit_category = 'scheduled' THEN 'daily'
        ELSE audit_category
    END;

    -- Log audit start
    RAISE NOTICE 'Starting automated security audit at %', start_time;

    -- Run comprehensive security audit
    SELECT jsonb_build_object(
        'timestamp', NOW()::text,
        'audit_type', audit_type,
        'inventory_summary', (
            SELECT jsonb_agg(
                jsonb_build_object(
                    'tablename', tablename,
                    'security_status', security_status,
                    'priority_level', priority_level,
                    'policies_active', policies_active,
                    'recommended_actions', recommended_actions
                )
            )
            FROM extract_rls_policy_inventory()
        ),
        'compliance_metrics', (
            SELECT jsonb_build_object(
                'total_tables', COUNT(*),
                'fully_secure', SUM(CASE WHEN security_status = '✅ FULLY SECURE' THEN 1 ELSE 0 END),
                'partially_secure', SUM(CASE WHEN security_status LIKE '🔶%' THEN 1 ELSE 0 END),
                'no_security', SUM(CASE WHEN security_status = '❌ NO SECURITY' THEN 1 ELSE 0 END),
                'compliance_percentage', ROUND(AVG(CASE WHEN policies_active >= 3 THEN 100 ELSE 0 END), 2),
                'critical_breaches', SUM(CASE WHEN priority_level = '🔴 CRITICAL' AND security_status != '✅ FULLY SECURE' THEN 1 ELSE 0 END)
            )
            FROM extract_rls_policy_inventory()
        ),
        'risk_assessment', (
            SELECT jsonb_build_object(
                'critical_tables', COUNT(CASE WHEN priority_level = '🔴 CRITICAL' THEN 1 END),
                'critical_violations', COUNT(CASE WHEN priority_level = '🔴 CRITICAL' AND security_status != '✅ FULLY SECURE' THEN 1 END),
                'high_risk_tables', COUNT(CASE WHEN priority_level = '🟠 HIGH' THEN 1 END),
                'unsecured_high_risk', COUNT(CASE WHEN priority_level = '🟠 HIGH' AND security_status = '❌ NO SECURITY' THEN 1 END)
            )
            FROM extract_rls_policy_inventory()
        )
    ) INTO audit_results;

    -- Calculate execution time
    end_time := NOW();
    execution_duration := EXTRACT(EPOCH FROM (end_time - start_time)) * 1000;

    -- Store audit results in history table
    INSERT INTO security_audit_history (
        audit_type,
        audit_period_start,
        audit_period_end,
        total_tables_audited,
        tables_with_rls,
        tables_fully_secure,
        tables_partially_secure,
        tables_no_security,
        critical_breaches,
        critical_tables_count,
        high_risk_tables_count,
        medium_risk_tables_count,
        low_risk_tables_count,
        compliance_percentage,
        audit_details,
        security_status,
        critical_alerts,
        execution_duration_ms
    )
    SELECT
        audit_type,
        start_time,
        end_time,
        (audit_results->>'compliance_metrics'->>'total_tables')::INTEGER,
        (audit_results->>'compliance_metrics'->>'fully_secure')::INTEGER + (audit_results->>'compliance_metrics'->>'partially_secure')::INTEGER,
        (audit_results->>'compliance_metrics'->>'fully_secure')::INTEGER,
        (audit_results->>'compliance_metrics'->>'partially_secure')::INTEGER,
        (audit_results->>'compliance_metrics'->>'no_security')::INTEGER,
        (audit_results->>'compliance_metrics'->>'critical_breaches')::INTEGER,
        (audit_results->>'risk_assessment'->>'critical_tables')::INTEGER,
        (audit_results->>'risk_assessment'->>'high_risk_tables')::INTEGER,
        0, 0, -- medium and low will be calculated separately
        (audit_results->>'compliance_metrics'->>'compliance_percentage')::DECIMAL,
        audit_results,
        audit_results->>'inventory_summary',
        audit_results->>'compliance_metrics',
        execution_duration::INTEGER
    FROM extract_rls_policy_inventory()
    WHERE priority_level = '🟡 MEDIUM'
    GROUP BY audit_type, start_time, end_time, audit_results, execution_duration;

    -- Generate critical alerts
    alert_count := generate_security_alerts(audit_results, audit_category, start_time);

    -- Update security status view
    PERFORM refresh_security_status_view();

    RAISE NOTICE 'Security audit completed in % ms, generated % alerts', execution_duration, alert_count;

    RETURN jsonb_build_object(
        'success', true,
        'audit_type', audit_type,
        'execution_time_ms', execution_duration,
        'alerts_generated', alert_count,
        'results_summary', audit_results->>'compliance_metrics'
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to generate alerts for critical security issues
CREATE OR REPLACE FUNCTION generate_security_alerts(
    audit_results JSONB,
    audit_category TEXT,
    audit_timestamp TIMESTAMP WITH TIME ZONE
) RETURNS INTEGER AS $$
DECLARE
    alert_count INTEGER := 0;
    table_record RECORD;
BEGIN
    -- Critical breach alerts - tables with no security that should have it
    FOR table_record IN
        SELECT * FROM extract_rls_policy_inventory()
        WHERE security_status = '❌ NO SECURITY'
        AND priority_level IN ('🔴 CRITICAL', '🟠 HIGH')
    LOOP
        INSERT INTO security_alerts (
            alert_level, alert_type, alert_title, alert_description,
            affected_tables, risk_level, remediation_actions
        )
        VALUES (
            CASE WHEN table_record.priority_level = '🔴 CRITICAL' THEN 'critical' ELSE 'high' END,
            'breach', 'Security Breach: Table Without RLS Policies',
            format('Critical table "%s" has no Row Level Security policies. %s records may be exposed to unauthorized access.',
                  table_record.tablename, calculate_estimated_rows(table_record.tablename)),
            jsonb_build_array(
                jsonb_build_object(
                    'table', table_record.tablename,
                    'priority', table_record.priority_level,
                    'estimated_rows', calculate_estimated_rows(table_record.tablename)
                )
            ),
            'critical',
            '["Enable RLS immediately", "Implement 4-pattern policy structure", "Add organization access control", "Run compliance
check after implementation"]'::jsonb,
            NOW() + INTERVAL '7 days'
        );
        alert_count := alert_count + 1;
    END LOOP;

    -- Graduation warnings - partial to no security degradation
    FOR table_record IN
        SELECT * FROM extract_rls_policy_inventory()
        WHERE security_status LIKE '🔶%' AND priority_level IN ('🔴 CRITICAL', '🟠 HIGH')
    LOOP
        INSERT INTO security_alerts (
            alert_level, alert_type, alert_title, alert_description,
            affected_tables, risk_level, remediation_actions, remediation_deadline
        )
        VALUES (
            'medium',
            'gap',
            'Security Gap: Insufficient Policies',
            format('Table "%s" has only %s security policies. Required: 3+ policies for full protection.',
                  table_record.tablename, table_record.policies_active),
            jsonb_build_array(jsonb_build_object('table', table_record.tablename, 'current_policies', table_record.policies_active)),
            'medium',
            '["Add missing policies", "Ensure organization-level filtering", "Add creator ownership control", "Add admin override"]'::jsonb,
            NOW() + INTERVAL '14 days'
        );
        alert_count := alert_count + 1;
    END LOOP;

    RETURN alert_count;
END;
$$ LANGUAGE plpgsql;

-- Helper function to estimate rows (for risk assessment)
CREATE OR REPLACE FUNCTION calculate_estimated_rows(table_name TEXT) RETURNS TEXT AS $$
DECLARE
    row_estimate BIGINT;
BEGIN
    -- Get row estimate from PostgreSQL statistics
    SELECT reltuples::BIGINT
    FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE c.relname = table_name
    AND n.nspname = 'public'
    INTO row_estimate;

    IF row_estimate IS NULL THEN
        RETURN 'Unknown';
    ELSIF row_estimate < 100 THEN
        RETURN format('%s (<100)', row_estimate);
    ELSIF row_estimate < 1000 THEN
        RETURN format('~%s', row_estimate);
    ELSIF row_estimate < 10000 THEN
        RETURN format('~%s', (row_estimate / 100 * 100));
    ELSE
        RETURN format('~%s+', (row_estimate / 1000 * 1000));
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Security status materialized view for dashboards
CREATE MATERIALIZED VIEW IF NOT EXISTS security_status_dashboard AS
SELECT
    NOW()::date as report_date,
    'current' as report_type,
    jsonb_build_object(
        'total_tables', COUNT(*),
        'compliance_score', ROUND(AVG(CASE WHEN policies_active >= 3 THEN 100 ELSE 0 END), 1),
        'critical_breaches', SUM(CASE WHEN priority_level = '🔴 CRITICAL' AND security_status != '✅ FULLY SECURE' THEN 1 ELSE 0 END),
        'high_risk_gaps', SUM(CASE WHEN priority_level = '🟠 HIGH' AND security_status = '❌ NO SECURITY' THEN 1 ELSE 0 END)
    ) as overall_metrics,
    jsonb_build_object(
        'by_priority', (
            SELECT jsonb_agg(
                jsonb_build_object(
                    'level', priority_level,
                    'tables_count', COUNT(*),
                    'secure_count', SUM(CASE WHEN security_status = '✅ FULLY SECURE' THEN 1 ELSE 0 END),
                    'compliance_pct', ROUND(AVG(CASE WHEN policies_active >= 3 THEN 100 ELSE 0 END), 1)
                )
            )
            FROM extract_rls_policy_inventory()
            GROUP BY priority_level
            ORDER BY priority_level
        ),
        'by_status', (
            SELECT jsonb_agg(
                jsonb_build_object(
                    'status', security_status,
                    'count', COUNT(*),
                    'percentage', ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1)
                )
            )
            FROM extract_rls_policy_inventory()
            GROUP BY security_status
            ORDER BY security_status
        )
    ) as breakdown
FROM extract_rls_policy_inventory()
WITH NO DATA;

-- Function to refresh the dashboard view
CREATE OR REPLACE FUNCTION refresh_security_status_view() RETURNS void AS $$
BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY security_status_dashboard;
END;
$$ LANGUAGE plpgsql;

-- =============================================================================
-- 3. AUTOMATED SCHEDULING SYSTEM
-- =============================================================================

-- Daily audit function (runs at 2 AM)
CREATE OR REPLACE FUNCTION schedule_daily_security_audit() RETURNS jsonb AS $$
BEGIN
    RETURN run_automated_security_audit('daily');
END;
$$ LANGUAGE plpgsql;

-- Weekly audit function (Mondays at 3 AM)
CREATE OR REPLACE FUNCTION schedule_weekly_security_audit() RETURNS jsonb AS $$
DECLARE
    weekly_report JSONB;
BEGIN
    -- Run the audit
    weekly_report := run_automated_security_audit('weekly');

    -- Generate weekly security report
    PERFORM generate_security_report('weekly', weekly_report);

    -- Send notifications to stakeholders
    PERFORM send_security_notifications('weekly',
        jsonb_build_object('audit_results', weekly_report));

    RETURN weekly_report;
END;
$$ LANGUAGE plpgsql;

-- Monthly audit function (1st of month at 4 AM)
CREATE OR REPLACE FUNCTION schedule_monthly_security_audit() RETURNS jsonb AS $$
DECLARE
    monthly_report JSONB;
BEGIN
    -- Run comprehensive audit
    monthly_report := run_automated_security_audit('monthly');

    -- Generate monthly security report for executives
    PERFORM generate_security_report('monthly', monthly_report);

    -- Send critical alerts and executive summary
    PERFORM send_security_notifications('monthly',
        jsonb_build_object('audit_results', monthly_report, 'executive_summary', true));

    RETURN monthly_report;
END;
$$ LANGUAGE plpgsql;

-- Emergency audit trigger
CREATE OR REPLACE FUNCTION trigger_emergency_audit(trigger_reason TEXT DEFAULT 'unknown') RETURNS jsonb AS $$
DECLARE
    emergency_results JSONB;
BEGIN
    -- Immediate audit with priority alerting
    emergency_results := run_automated_security_audit('emergency');

    -- Send immediate critical alerts
    PERFORM send_security_notifications('emergency',
        jsonb_build_object(
            'reason', trigger_reason,
            'results', emergency_results,
            'priority', 'urgent'
        ));

    RETURN emergency_results;
END;
$$ LANGUAGE plpgsql;

-- =============================================================================
-- 4. REPORTING AND NOTIFICATION FUNCTIONS
-- =============================================================================

-- Generate formatted security reports
CREATE OR REPLACE FUNCTION generate_security_report(
    report_type TEXT,
    audit_data JSONB
) RETURNS UUID AS $$
DECLARE
    report_id UUID;
BEGIN
    INSERT INTO security_reports (
        report_period,
        report_date,
        executive_summary,
        security_status_overview,
        compliance_metrics,
        risk_assessment,
        recommendations
    )
    VALUES (
        report_type,
        CURRENT_DATE,
        jsonb_build_object(
            'period', report_type,
            'total_tables', audit_data->'compliance_metrics'->>'total_tables',
            'compliance_score', audit_data->'compliance_metrics'->>'compliance_percentage' || '%',
            'critical_breaches', audit_data->'compliance_metrics'->>'critical_breaches',
            'status', CASE
                WHEN (audit_data->'compliance_metrics'->>'compliance_percentage')::DECIMAL >= 90 THEN 'EXCELLENT'
                WHEN (audit_data->'compliance_metrics'->>'compliance_percentage')::DECIMAL >= 75 THEN 'GOOD'
                WHEN (audit_data->'compliance_metrics'->>'compliance_percentage')::DECIMAL >= 50 THEN 'CONCERNS'
                ELSE 'CRITICAL'
            END
        ),
        jsonb_build_object(
            'fully_secure', audit_data->'compliance_metrics'->>'fully_secure',
            'partially_secure', audit_data->'compliance_metrics'->>'partially_secure',
            'no_security', audit_data->'compliance_metrics'->>'no_security',
            'priority_breakdown', audit_data->'risk_assessment'
        ),
        audit_data->'compliance_metrics',
        audit_data->>'risk_assessment',
        jsonb_build_object(
            'immediate_actions',
            CASE WHEN (audit_data->'compliance_metrics'->>'critical_breaches')::INT > 0 THEN
                'URGENT: Address critical security breaches immediately'::text[]
            END,
            'maintenance_actions',
            CASE WHEN report_type = 'weekly' THEN
                'Review and update policy effectiveness'::text[]
            END
        )
    )
    RETURNING id INTO report_id;

    RETURN report_id;
END;
$$ LANGUAGE plpgsql;

-- Send security notifications (integrates with your existing notification system)
CREATE OR REPLACE FUNCTION send_security_notifications(
    notification_type TEXT,
    notification_data JSONB
) RETURNS void AS $$
DECLARE
    recipient_list JSONB;
    alert_severity TEXT;
    alert_title TEXT;
    alert_message TEXT;
BEGIN
    -- Determine recipients based on notification type and criticality
    CASE notification_type
        WHEN 'daily' THEN
            recipient_list := '["security-admin@epcm.com", "database-admin@epcm.com"]'::jsonb;
        WHEN 'weekly' THEN
            recipient_list := '["security-admin@epcm.com", "it-director@epcm.com"]'::jsonb;
        WHEN 'monthly' THEN
            recipient_list := '["security-admin@epcm.com", "it-director@epcm.com", "compliance-officer@epcm.com"]'::jsonb;
        WHEN 'emergency' THEN
            recipient_list := '["security-admin@epcm.com", "it-director@epcm.com", "ciso@epcm.com", "ceo@epcm.com"]'::jsonb;
        ELSE
            recipient_list := '["security-admin@epcm.com"]'::jsonb;
    END CASE;

    -- Create notification records for email system
    FOR i IN 0..jsonb_array_length(recipient_list) - 1 LOOP
        INSERT INTO notification_log (
            notification_type,
            recipient_email,
            subject,
            message_body,
            status
        )
        VALUES (
            'security_' || notification_type,
            recipient_list->>i,
            'RLS Security Report: ' || UPPER(notification_type),
            format_notification_message(notification_type, notification_data),
            'queued'
        );
    END LOOP;

    -- Log the notification action
    RAISE NOTICE 'Sent security notifications to % recipients for: %', jsonb_array_length(recipient_list), notification_type;
END;
$$ LANGUAGE plpgsql;

-- Format notification messages for email
CREATE OR REPLACE FUNCTION format_notification_message(
    notification_type TEXT,
    notification_data JSONB
) RETURNS TEXT AS $$
DECLARE
    message_body TEXT;
BEGIN
    CASE notification_type
        WHEN 'daily' THEN
            message_body := format('Daily RLS Security Audit Summary:

Total Tables Audited: %s
Compliance Score: %s%%
Critical Breaches: %s
Fully Secure Tables: %s

See attached audit details or login to Supabase for full report.',
                COALESCE(notification_data->'results'->'compliance_metrics'->>'total_tables', 'N/A'),
                COALESCE(notification_data->'results'->'compliance_metrics'->>'compliance_percentage', 'N/A'),
                COALESCE(notification_data->'results'->'compliance_metrics'->>'critical_breaches', 'N/A'),
                COALESCE(notification_data->'results'->'compliance_metrics'->>'fully_secure', 'N/A'));

        WHEN 'emergency' THEN
            message_body := format('🚨 URGENT SECURITY ALERT

Trigger Reason: %s
Critical Breaches Detected: %s
Action Required: Immediate review and remediation needed.

Please login to Supabase to review security status and alerts.',
                COALESCE(notification_data->>'reason', 'Automatics'),
                COALESCE(notification_data->'results'->'compliance_metrics'->>'critical_breaches', 'N/A'));

        ELSE
            message_body := 'Security audit completed. Please review the full report in Supabase.';
    END CASE;

    RETURN message_body;
END;
$$ LANGUAGE plpgsql;

-- =============================================================================
-- 5. INTEGRATION AND MONITORING TRIGGERS
-- =============================================================================

-- Trigger to automatically run security audit when new tables are created
CREATE OR REPLACE FUNCTION auto_audit_new_tables() RETURNS trigger AS $$
BEGIN
    -- Trigger emergency audit when new tables are added
    PERFORM trigger_emergency_audit('New table ' || NEW.relname || ' detected');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger on pg_class (careful with this!)
-- Uncomment when ready for production:
-- CREATE TRIGGER audit_new_tables_trigger
--     AFTER INSERT ON pg_class
--     FOR EACH ROW
--     WHEN (NEW.relname NOT LIKE 'pg_%' AND NEW.relname NOT LIKE '%backup%'
--           AND NEW.relkind = 'r' AND NEW.relnamespace = 2200) -- public schema
--     EXECUTE FUNCTION auto_audit_new_tables();

-- Trigger to alert on policy changes
CREATE OR REPLACE FUNCTION monitor_policy_changes() RETURNS trigger AS $$
BEGIN
    -- Log policy changes and trigger reduced audit
    RAISE NOTICE 'RLS policy change detected on %.%s', CURRENT_SCHEMA(), TG_TABLE_NAME;

    -- Schedule a follow-up audit after policy changes
    INSERT INTO scheduled_jobs (job_type, job_data, scheduled_for)
    VALUES ('security_audit', 'post_policy_change'::jsonb, NOW() + INTERVAL '30 minutes');

    RETURN CASE WHEN TG_OP = 'DELETE' THEN OLD ELSE NEW END;
END;
$$ LANGUAGE plpgsql;

-- Monitor policy table for changes
CREATE TRIGGER policies_change_trigger
    AFTER INSERT OR UPDATE OR DELETE ON pg_policies
    EXECUTE FUNCTION monitor_policy_changes();

-- =============================================================================
-- 6. SUPABASE EDGE FUNCTION INTERFACE (OPTIONAL)
-- =============================================================================

-- Alternative approach: Use Edge Functions for scheduling (if pg_cron not available)
-- This function can be called from cron or external schedulers

CREATE OR REPLACE FUNCTION execute_scheduled_security_audit(
    audit_type TEXT DEFAULT 'scheduled',
    include_email BOOLEAN DEFAULT TRUE
) RETURNS JSONB AS $$
DECLARE
    results JSONB;
BEGIN
    -- Execute the appropriate audit type
    CASE audit_type
        WHEN 'daily' THEN results := schedule_daily_security_audit();
        WHEN 'weekly' THEN results := schedule_weekly_security_audit();
        WHEN 'monthly' THEN results := schedule_monthly_security_audit();
        WHEN 'emergency' THEN results := trigger_emergency_audit('scheduled_emergency');
        ELSE results := run_automated_security_audit('scheduled');
    END CASE;

    -- Add metadata
    results := results || jsonb_build_object(
        'execution_mode', 'edge_function',
        'timestamp', NOW()::text
    );

    -- Store results for API access
    INSERT INTO security_audit_results_rest (results, created_at)
    VALUES (results, NOW());

    RETURN results;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- API-accessible results table
CREATE TABLE IF NOT EXISTS security_audit_results_rest (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    results JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =============================================================================
-- 7. MONITORING AND MAINTENANCE
-- =============================================================================

-- Function to clean up old audit data (keep last 90 days)
CREATE OR REPLACE FUNCTION cleanup_security_logs(days_retention INTEGER DEFAULT 90) RETURNS INTEGER AS $$
DECLARE
    deleted_count INTEGER;
BEGIN
    DELETE FROM security_audit_history
    WHERE audit_timestamp < NOW() - INTERVAL '1 day' * days_retention;

    GET DIAGNOSTICS deleted_count = ROW_COUNT;

    -- Also archive old alerts
    UPDATE security_alerts
    SET status = 'archived'
    WHERE status = 'resolved'
    AND resolved_at < NOW() - INTERVAL '1 day' * (days_retention * 2);

    RAISE NOTICE 'Cleaned up % old audit records, archived stale alerts', deleted_count;
    RETURN deleted_count;
END;
$$ LANGUAGE plpgsql;

-- Health check function for the audit system
CREATE OR REPLACE FUNCTION security_audit_system_health() RETURNS JSONB AS $$
DECLARE
    health_status JSONB;
    last_audit_age INTERVAL;
    pending_alerts INTEGER;
BEGIN
    -- Check last audit run
    SELECT NOW() - MAX(audit_timestamp)
    FROM security_audit_history
    WHERE audit_type = 'daily'
    INTO last_audit_age;

    -- Check pending alerts
    SELECT COUNT(*) FROM security_alerts WHERE status = 'open'
    INTO pending_alerts;

    -- Build health report
    health_status := jsonb_build_object(
        'system_status', CASE
            WHEN last_audit_age IS NULL THEN 'NOT_RUN_YET'
            WHEN last_audit_age > INTERVAL '48 hours' THEN 'DEFECTIVE'
            WHEN last_audit_age > INTERVAL '26 hours' THEN 'DEGRADED'
            ELSE 'HEALTHY'
        END,
        'last_audit_age_hours', EXTRACT(EPOCH FROM last_audit_age)/3600,
        'pending_critical_alerts', (
            SELECT COUNT(*) FROM security_alerts
            WHERE status = 'open' AND alert_level = 'critical'
        ),
        'total_pending_alerts', pending_alerts,
        'audit_history_rows', (
            SELECT COUNT(*) FROM security_audit_history
        ),
        'last_check', NOW()::text
    );

    -- Automated alert if system is degraded
    IF health_status->>'system_status' = 'DEFECTIVE' THEN
        INSERT INTO security_alerts (alert_level, alert_type, alert_title, alert_description)
        VALUES ('high', 'system', 'Security Audit System Failure',
               'Automated security audits have not run for more than 48 hours. System may be compromised or malfunctioning.');
    END IF;

    RETURN health_status;
END;
$$ LANGUAGE plpgsql;

-- =============================================================================
-- 8. DEPLOYMENT & INITIALIZATION
-- =============================================================================

-- Initialize the system with first audit run
-- Run this after deploying the system
DO $$
DECLARE
    init_results JSONB;
BEGIN
    RAISE NOTICE 'Initializing Automated RLS Security Audit System...';

    -- Run initial system health check
    RAISE NOTICE 'Running initial audit...';
    init_results := run_automated_security_audit('initialization');

    -- Refresh dashboard
    PERFORM refresh_security_status_view();

    RAISE NOTICE 'System initialization complete.';
    RAISE NOTICE 'Results: %', init_results;

    -- Display setup instructions
    RAISE NOTICE '';
    RAISE NOTICE '=================== SETUP COMPLETE ===================';
    RAISE NOTICE '';
    RAISE NOTICE 'To enable automatic scheduling, choose one of these options:';
    RAISE NOTICE '';
    RAISE NOTICE 'OPTION 1: pg_cron (Recommended for PostgreSQL)';
    RAISE NOTICE 'Run these queries with superuser privileges:';
    RAISE NOTICE '';
    RAISE NOTICE 'SELECT cron.schedule(''daily-security-audit'', ''0 2 * * *'',';
    RAISE NOTICE '   ''SELECT schedule_daily_security_audit();'');';
    RAISE NOTICE '';
    RAISE NOTICE 'SELECT cron.schedule(''weekly-security-audit'', ''0 3 * * 1'',';
    RAISE NOTICE '   ''SELECT schedule_weekly_security_audit();'');';
    RAISE NOTICE '';
    RAISE NOTICE 'SELECT cron.schedule(''monthly-security-audit'', ''0 4 1 * *'',';
    RAISE NOTICE '   ''SELECT schedule_monthly_security_audit();'');';
    RAISE NOTICE '';
    RAISE NOTICE 'OPTION 2: External Cron Job';
    RAISE NOTICE 'Use curl to call an Edge Function:';
    RAISE NOTICE '';
    RAISE NOTICE 'curl -X GET https://your-project.supabase.co/functions/v1/security-audit';
    RAISE NOTICE '';
    RAISE NOTICE 'OPTION 3: Supabase Dashboard';
    RAISE NOTICE 'Schedule Edge Functions directly in the Supabase dashboard.';
    RAISE NOTICE '';
    RAISE NOTICE '===================================================';
END;
$$;
