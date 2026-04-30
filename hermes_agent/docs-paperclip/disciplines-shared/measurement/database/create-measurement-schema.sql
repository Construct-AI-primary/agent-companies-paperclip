-- ============================================================
-- Measurement Platform Database Schema
-- Created: 2026-04-21
-- Description: Creates the database schema for the cross-discipline measurement platform
-- Dependencies: Base Paperclip database schema must exist
-- ============================================================

-- Create measurement data table (replaces and extends a_02025_qs_data)
CREATE TABLE IF NOT EXISTS a_measurement_data (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    discipline_code VARCHAR(10) NOT NULL,
    project_id UUID, -- Optional reference to projects (table may not exist yet)
    drawing_id UUID, -- Optional reference to drawings (table may not exist yet)

    -- Core measurement data
    item_code VARCHAR(50),
    item_description TEXT,
    quantity DECIMAL(15,4),
    unit VARCHAR(20),
    rate DECIMAL(12,4),
    amount DECIMAL(15,4),

    -- Discipline-specific data
    discipline_specific_data JSONB,
    measurement_type VARCHAR(50), -- 'earthworks', 'concrete', 'cabling', 'ductwork', etc.
    measurement_category VARCHAR(50), -- 'foundation', 'structural', 'mep', 'finishes', etc.

    -- Standards and validation
    standards_version VARCHAR(20),
    validation_status VARCHAR(20) DEFAULT 'pending',
    validation_errors JSONB,
    tolerance_applied DECIMAL(5,4),

    -- Audit and tracking
    created_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    version INTEGER DEFAULT 1,

    -- Cross-discipline references
    cross_discipline_references JSONB,
    related_measurements UUID[],

    -- AI processing metadata
    ai_processed BOOLEAN DEFAULT FALSE,
    ai_confidence DECIMAL(3,2),
    ai_processing_metadata JSONB
);

-- Create measurement audit trail table (extends a_02025_qs_audit_trail)
CREATE TABLE IF NOT EXISTS a_measurement_audit_trail (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    measurement_id UUID REFERENCES a_measurement_data(id) ON DELETE CASCADE,

    -- Audit data
    action VARCHAR(50) NOT NULL, -- 'create', 'update', 'delete', 'validate', 'approve'
    old_values JSONB,
    new_values JSONB,
    changes_summary TEXT,

    -- Context
    user_id UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    discipline_code VARCHAR(10),
    project_id UUID,
    session_id VARCHAR(100),

    -- AI processing context
    ai_agent VARCHAR(100), -- 'validation-vera', 'standards-stella', 'measurement-molly'
    ai_action VARCHAR(100),
    ai_confidence DECIMAL(3,2),

    -- Metadata
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    ip_address INET,
    user_agent TEXT,
    additional_context JSONB
);

-- Create measurement standards table
CREATE TABLE IF NOT EXISTS a_measurement_standards (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    discipline_code VARCHAR(10) NOT NULL,
    jurisdiction VARCHAR(5) NOT NULL, -- 'ZA', 'US', 'GB', etc.
    standard_code VARCHAR(50) NOT NULL, -- 'SANS-1200', 'CIDB-BPG-QS', 'ASAQS', etc.
    standard_name VARCHAR(255) NOT NULL,
    version VARCHAR(20),
    effective_date DATE,
    status VARCHAR(20) DEFAULT 'active', -- 'active', 'superseded', 'withdrawn'

    -- Standard content
    measurement_rules JSONB, -- Measurement rules and procedures
    tolerance_limits JSONB, -- Acceptable tolerances and variances
    validation_criteria JSONB, -- Validation requirements and checks
    compliance_requirements JSONB, -- Compliance and reporting requirements

    -- Metadata
    created_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    review_date DATE, -- Next review date
    source_url TEXT -- Link to official standard document
);

-- Create measurement templates table
CREATE TABLE IF NOT EXISTS a_measurement_templates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    discipline_code VARCHAR(10) NOT NULL,
    template_name VARCHAR(255) NOT NULL,
    template_type VARCHAR(50) NOT NULL, -- 'quantity-takeoff', 'cost-estimation', 'validation', 'reporting'
    description TEXT,

    -- Template content
    template_config JSONB, -- Template configuration and parameters
    default_values JSONB, -- Default measurement values and rates
    validation_rules JSONB, -- Template validation rules
    output_format JSONB, -- Expected output format and structure

    -- Usage tracking
    usage_count INTEGER DEFAULT 0,
    accuracy_rate DECIMAL(5,2), -- Historical accuracy of template results
    average_completion_time INTEGER, -- Average completion time in seconds

    -- AI optimization
    ai_optimized BOOLEAN DEFAULT FALSE,
    ai_performance_metrics JSONB,

    -- Metadata
    created_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    version INTEGER DEFAULT 1,
    status VARCHAR(20) DEFAULT 'active' -- 'active', 'deprecated', 'archived'
);

-- Create measurement validation rules table
CREATE TABLE IF NOT EXISTS a_measurement_validation_rules (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    discipline_code VARCHAR(10) NOT NULL,
    rule_name VARCHAR(255) NOT NULL,
    rule_type VARCHAR(50) NOT NULL, -- 'tolerance', 'completeness', 'consistency', 'standards'
    description TEXT,

    -- Rule definition
    rule_conditions JSONB, -- Conditions that trigger the rule
    rule_actions JSONB, -- Actions to take when rule is triggered
    severity_level VARCHAR(20) DEFAULT 'warning', -- 'info', 'warning', 'error', 'critical'

    -- Validation parameters
    tolerance_values JSONB, -- Tolerance limits and thresholds
    validation_logic JSONB, -- Logic for applying the validation rule

    -- Metadata
    created_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    version INTEGER DEFAULT 1,
    active BOOLEAN DEFAULT TRUE
);

-- Create measurement CAD integration table
CREATE TABLE IF NOT EXISTS a_measurement_cad_integration (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    measurement_id UUID REFERENCES a_measurement_data(id) ON DELETE CASCADE,
    cad_system VARCHAR(50) NOT NULL, -- 'autocad', 'revit', 'civil3d', etc.
    cad_session_id VARCHAR(100),
    cad_object_id VARCHAR(255), -- CAD object identifier
    cad_layer VARCHAR(100),
    cad_properties JSONB, -- CAD object properties and metadata

    -- Synchronization data
    last_sync TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    sync_status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'synced', 'conflict', 'error'
    sync_conflicts JSONB, -- Details of any synchronization conflicts

    -- Metadata
    created_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create measurement approval workflow table
CREATE TABLE IF NOT EXISTS a_measurement_approvals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    measurement_id UUID REFERENCES a_measurement_data(id) ON DELETE CASCADE,
    approval_type VARCHAR(50) NOT NULL, -- 'technical', 'commercial', 'client', 'regulatory'
    approval_level VARCHAR(20) DEFAULT 'pending', -- 'pending', 'approved', 'rejected', 'conditional'

    -- Approval details
    approver_role VARCHAR(100), -- Required role for approval
    approver_user UUID REFERENCES agents(id), -- Specific agent if assigned (Paperclip platform)
    approval_criteria JSONB, -- Criteria for approval
    approval_comments TEXT,

    -- Workflow tracking
    requested_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    approved_at TIMESTAMP WITH TIME ZONE,
    due_date TIMESTAMP WITH TIME ZONE,

    -- Audit trail
    approval_history JSONB, -- History of approval actions
    escalation_rules JSONB, -- Rules for escalating overdue approvals

    -- Metadata
    created_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_measurement_data_discipline ON a_measurement_data(discipline_code);
CREATE INDEX IF NOT EXISTS idx_measurement_data_project ON a_measurement_data(project_id);
CREATE INDEX IF NOT EXISTS idx_measurement_data_drawing ON a_measurement_data(drawing_id);
CREATE INDEX IF NOT EXISTS idx_measurement_data_validation ON a_measurement_data(validation_status);
CREATE INDEX IF NOT EXISTS idx_measurement_data_type ON a_measurement_data(measurement_type);
CREATE INDEX IF NOT EXISTS idx_measurement_data_cross_ref ON a_measurement_data USING GIN(cross_discipline_references);

CREATE INDEX IF NOT EXISTS idx_measurement_audit_measurement ON a_measurement_audit_trail(measurement_id);
CREATE INDEX IF NOT EXISTS idx_measurement_audit_user ON a_measurement_audit_trail(user_id);
CREATE INDEX IF NOT EXISTS idx_measurement_audit_timestamp ON a_measurement_audit_trail(timestamp);
CREATE INDEX IF NOT EXISTS idx_measurement_audit_discipline ON a_measurement_audit_trail(discipline_code);

CREATE INDEX IF NOT EXISTS idx_measurement_standards_discipline ON a_measurement_standards(discipline_code);
CREATE INDEX IF NOT EXISTS idx_measurement_standards_jurisdiction ON a_measurement_standards(jurisdiction);
CREATE INDEX IF NOT EXISTS idx_measurement_standards_code ON a_measurement_standards(standard_code);
CREATE INDEX IF NOT EXISTS idx_measurement_standards_status ON a_measurement_standards(status);

CREATE INDEX IF NOT EXISTS idx_measurement_templates_discipline ON a_measurement_templates(discipline_code);
CREATE INDEX IF NOT EXISTS idx_measurement_templates_type ON a_measurement_templates(template_type);
CREATE INDEX IF NOT EXISTS idx_measurement_templates_status ON a_measurement_templates(status);

CREATE INDEX IF NOT EXISTS idx_measurement_validation_discipline ON a_measurement_validation_rules(discipline_code);
CREATE INDEX IF NOT EXISTS idx_measurement_validation_type ON a_measurement_validation_rules(rule_type);
CREATE INDEX IF NOT EXISTS idx_measurement_validation_active ON a_measurement_validation_rules(active);

CREATE INDEX IF NOT EXISTS idx_measurement_cad_measurement ON a_measurement_cad_integration(measurement_id);
CREATE INDEX IF NOT EXISTS idx_measurement_cad_system ON a_measurement_cad_integration(cad_system);
CREATE INDEX IF NOT EXISTS idx_measurement_cad_sync ON a_measurement_cad_integration(sync_status);

CREATE INDEX IF NOT EXISTS idx_measurement_approvals_measurement ON a_measurement_approvals(measurement_id);
CREATE INDEX IF NOT EXISTS idx_measurement_approvals_type ON a_measurement_approvals(approval_type);
CREATE INDEX IF NOT EXISTS idx_measurement_approvals_level ON a_measurement_approvals(approval_level);

-- Create composite indexes for common queries
CREATE INDEX IF NOT EXISTS idx_measurement_data_project_discipline ON a_measurement_data(project_id, discipline_code);
CREATE INDEX IF NOT EXISTS idx_measurement_standards_disc_juris ON a_measurement_standards(discipline_code, jurisdiction);
CREATE INDEX IF NOT EXISTS idx_measurement_cad_system_session ON a_measurement_cad_integration(cad_system, cad_session_id);

-- Add table comments for documentation
COMMENT ON TABLE a_measurement_data IS 'Cross-discipline measurement data with validation and AI processing support';
COMMENT ON TABLE a_measurement_audit_trail IS 'Complete audit trail for all measurement data changes and validations';
COMMENT ON TABLE a_measurement_standards IS 'Measurement standards library with jurisdiction-specific requirements';
COMMENT ON TABLE a_measurement_templates IS 'Reusable measurement templates with AI optimization and usage tracking';
COMMENT ON TABLE a_measurement_validation_rules IS 'Automated validation rules for measurement data quality assurance';
COMMENT ON TABLE a_measurement_cad_integration IS 'CAD system integration tracking for measurement synchronization';
COMMENT ON TABLE a_measurement_approvals IS 'Multi-level approval workflow for measurement validation and acceptance';

-- Create views for common queries
CREATE OR REPLACE VIEW v_measurement_summary AS
SELECT
    m.id,
    m.discipline_code,
    m.project_id,
    m.measurement_type,
    m.measurement_category,
    m.quantity,
    m.unit,
    m.amount,
    m.validation_status,
    m.created_at,
    COUNT(a.id) as audit_entries,
    COUNT(ap.id) as approval_count,
    COUNT(CASE WHEN ap.approval_level = 'approved' THEN 1 END) as approved_count
FROM a_measurement_data m
LEFT JOIN a_measurement_audit_trail a ON m.id = a.measurement_id
LEFT JOIN a_measurement_approvals ap ON m.id = ap.measurement_id
GROUP BY m.id, m.discipline_code, m.project_id, m.measurement_type, m.measurement_category,
         m.quantity, m.unit, m.amount, m.validation_status, m.created_at;

CREATE OR REPLACE VIEW v_measurement_validation_status AS
SELECT
    m.id,
    m.discipline_code,
    m.measurement_type,
    m.validation_status,
    COUNT(vr.id) as validation_rules_applied,
    COUNT(CASE WHEN vr.severity_level = 'error' THEN 1 END) as critical_issues,
    COUNT(CASE WHEN vr.severity_level = 'warning' THEN 1 END) as warning_issues,
    MAX(a.timestamp) as last_validation
FROM a_measurement_data m
LEFT JOIN a_measurement_validation_rules vr ON m.discipline_code = vr.discipline_code
LEFT JOIN a_measurement_audit_trail a ON m.id = a.measurement_id AND a.action = 'validate'
GROUP BY m.id, m.discipline_code, m.measurement_type, m.validation_status;

CREATE OR REPLACE VIEW v_measurement_standards_compliance AS
SELECT
    m.id,
    m.discipline_code,
    s.jurisdiction,
    s.standard_code,
    s.standard_name,
    m.validation_status,
    CASE
        WHEN m.validation_status = 'approved' THEN 'compliant'
        WHEN m.validation_status = 'rejected' THEN 'non-compliant'
        ELSE 'pending'
    END as compliance_status
FROM a_measurement_data m
JOIN a_measurement_standards s ON m.discipline_code = s.discipline_code
WHERE s.status = 'active';

-- Create functions for common operations
CREATE OR REPLACE FUNCTION calculate_measurement_total(project_id UUID, discipline_code VARCHAR(10))
RETURNS DECIMAL(15,4) AS $$
DECLARE
    total_amount DECIMAL(15,4) := 0;
BEGIN
    SELECT COALESCE(SUM(amount), 0)
    INTO total_amount
    FROM a_measurement_data
    WHERE project_id = $1
      AND discipline_code = $2
      AND validation_status = 'approved';

    RETURN total_amount;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION validate_measurement_tolerance(
    measurement_id UUID,
    tolerance_limit DECIMAL
) RETURNS BOOLEAN AS $$
DECLARE
    measurement_value DECIMAL(15,4);
    tolerance_range DECIMAL(5,4);
BEGIN
    -- Get measurement value and calculate tolerance range
    SELECT quantity INTO measurement_value
    FROM a_measurement_data
    WHERE id = $1;

    tolerance_range := measurement_value * tolerance_limit;

    -- Check if measurement is within tolerance (simplified logic)
    -- In practice, this would compare against expected values
    RETURN TRUE; -- Placeholder - implement actual tolerance checking logic
END;
$$ LANGUAGE plpgsql;

-- Grant appropriate permissions (adjust as needed for your security model)
-- GRANT SELECT, INSERT, UPDATE ON a_measurement_data TO measurement_users;
-- GRANT SELECT, INSERT ON a_measurement_audit_trail TO measurement_users;
-- GRANT SELECT ON a_measurement_standards TO measurement_users;
-- GRANT SELECT ON a_measurement_templates TO measurement_users;
-- GRANT SELECT ON a_measurement_validation_rules TO measurement_users;
-- GRANT SELECT, INSERT, UPDATE ON a_measurement_cad_integration TO measurement_users;
-- GRANT SELECT, INSERT, UPDATE ON a_measurement_approvals TO measurement_users;

-- GRANT SELECT ON v_measurement_summary TO measurement_users;
-- GRANT SELECT ON v_measurement_validation_status TO measurement_users;
-- GRANT SELECT ON v_measurement_standards_compliance TO measurement_users;

-- GRANT EXECUTE ON FUNCTION calculate_measurement_total(UUID, VARCHAR) TO measurement_users;
-- GRANT EXECUTE ON FUNCTION validate_measurement_tolerance(UUID, DECIMAL) TO measurement_users;

-- ============================================================
-- Verification queries (run after schema creation)
-- ============================================================

-- Check table creation
-- SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_name LIKE 'a_measurement%';

-- Check index creation
-- SELECT indexname, tablename FROM pg_indexes WHERE tablename LIKE 'a_measurement%';

-- Check view creation
-- SELECT table_name FROM information_schema.views WHERE table_schema = 'public' AND table_name LIKE 'v_measurement%';

-- Check function creation
-- SELECT routine_name FROM information_schema.routines WHERE routine_schema = 'public' AND routine_name LIKE 'calculate_measurement%' OR routine_name LIKE 'validate_measurement%';

-- ============================================================
-- Clean up: Uncomment to remove the measurement schema
-- ============================================================

-- DROP VIEW IF EXISTS v_measurement_standards_compliance;
-- DROP VIEW IF EXISTS v_measurement_validation_status;
-- DROP VIEW IF EXISTS v_measurement_summary;
-- DROP FUNCTION IF EXISTS validate_measurement_tolerance(UUID, DECIMAL);
-- DROP FUNCTION IF EXISTS calculate_measurement_total(UUID, VARCHAR);
-- DROP TABLE IF EXISTS a_measurement_approvals;
-- DROP TABLE IF EXISTS a_measurement_cad_integration;
-- DROP TABLE IF EXISTS a_measurement_validation_rules;
-- DROP TABLE IF EXISTS a_measurement_templates;
-- DROP TABLE IF EXISTS a_measurement_standards;
-- DROP TABLE IF EXISTS a_measurement_audit_trail;
-- DROP TABLE IF EXISTS a_measurement_data;