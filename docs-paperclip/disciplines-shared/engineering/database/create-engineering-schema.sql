-- ============================================================
-- Engineering Platform Database Schema
-- Created: 2026-04-21
-- Description: Creates the database schema for the cross-discipline engineering platform
-- Dependencies: Base Paperclip database schema must exist
-- ============================================================

-- Create engineering models table
CREATE TABLE IF NOT EXISTS a_engineering_models (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    discipline_code VARCHAR(10) NOT NULL,
    project_id UUID, -- Optional reference to projects (table may not exist yet)
    model_name VARCHAR(255) NOT NULL,
    model_type VARCHAR(50), -- 'structural', 'mep', 'architectural', etc.
    cad_system VARCHAR(50), -- 'autocad', 'revit', 'civil3d', etc.
    jurisdiction VARCHAR(5), -- 'ZA', 'US', 'GB', etc.
    standards_version VARCHAR(20),
    validation_status VARCHAR(20) DEFAULT 'pending',
    created_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    version INTEGER DEFAULT 1,

    -- Engineering-specific metadata
    analysis_requirements JSONB, -- Required analysis types for this model
    material_library JSONB, -- Available materials for the discipline
    load_cases JSONB, -- Standard load cases for the discipline
    design_codes JSONB, -- Applicable design codes and standards

    -- AI processing metadata
    ai_processed BOOLEAN DEFAULT FALSE,
    ai_confidence DECIMAL(3,2),
    ai_processing_metadata JSONB
);

-- Create engineering analysis results table
CREATE TABLE IF NOT EXISTS a_engineering_analysis (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    model_id UUID REFERENCES a_engineering_models(id) ON DELETE CASCADE,
    analysis_type VARCHAR(50) NOT NULL, -- 'fea', 'thermal', 'fluid', 'modal', etc.
    analysis_engine VARCHAR(50), -- 'ansys', 'abaqus', 'custom', etc.
    status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'running', 'completed', 'failed'
    progress DECIMAL(5,2) DEFAULT 0, -- Progress percentage 0-100

    -- Analysis configuration
    analysis_config JSONB, -- Solver settings, convergence criteria, etc.
    boundary_conditions JSONB, -- Loads, constraints, material properties
    mesh_config JSONB, -- Mesh settings and quality metrics

    -- Results data
    results_data JSONB, -- Analysis results (stresses, displacements, etc.)
    result_summary JSONB, -- Key metrics and pass/fail status
    convergence_history JSONB, -- Iteration convergence data

    -- Validation and compliance
    validation_status VARCHAR(20) DEFAULT 'pending',
    compliance_checks JSONB, -- Standards compliance results
    design_criteria JSONB, -- Design criteria and limits

    -- Metadata
    created_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    started_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    duration_seconds INTEGER,

    -- AI processing metadata
    ai_reviewed BOOLEAN DEFAULT FALSE,
    ai_recommendations JSONB,
    ai_confidence DECIMAL(3,2)
);

-- Create engineering audit trail table
CREATE TABLE IF NOT EXISTS a_engineering_audit_trail (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    model_id UUID REFERENCES a_engineering_models(id) ON DELETE CASCADE,
    analysis_id UUID REFERENCES a_engineering_analysis(id) ON DELETE CASCADE,

    -- Audit data
    action VARCHAR(50) NOT NULL, -- 'create', 'update', 'delete', 'analyze', 'validate'
    action_details JSONB, -- Specific details of the action
    old_values JSONB,
    new_values JSONB,
    changes_summary TEXT,

    -- Context
    user_id UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    discipline_code VARCHAR(10),
    project_id UUID,
    session_id VARCHAR(100),

    -- AI processing context
    ai_agent VARCHAR(100), -- 'analysis-andy', 'coordination-charlie', etc.
    ai_action VARCHAR(100),
    ai_confidence DECIMAL(3,2),

    -- Metadata
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    ip_address INET,
    user_agent TEXT,
    additional_context JSONB
);

-- Create engineering standards compliance table
CREATE TABLE IF NOT EXISTS a_engineering_standards (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    discipline_code VARCHAR(10) NOT NULL,
    jurisdiction VARCHAR(5) NOT NULL, -- 'ZA', 'US', 'GB', etc.
    standard_code VARCHAR(50) NOT NULL, -- 'SANS-10160', 'ACI-318', etc.
    standard_name VARCHAR(255) NOT NULL,
    version VARCHAR(20),
    effective_date DATE,
    status VARCHAR(20) DEFAULT 'active', -- 'active', 'superseded', 'withdrawn'

    -- Standard content
    requirements JSONB, -- Specific requirements and criteria
    design_values JSONB, -- Allowable stresses, factors of safety, etc.
    test_methods JSONB, -- Testing and validation procedures
    standard_references JSONB, -- Cross-references to other standards

    -- Metadata
    created_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_by UUID REFERENCES agents(id), -- Reference to agents table (Paperclip platform)
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    review_date DATE, -- Next review date
    source_url TEXT -- Link to official standard document
);

-- Create engineering templates table
CREATE TABLE IF NOT EXISTS a_engineering_templates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    discipline_code VARCHAR(10) NOT NULL,
    template_name VARCHAR(255) NOT NULL,
    template_type VARCHAR(50) NOT NULL, -- 'analysis', 'design', 'validation', 'report'
    description TEXT,

    -- Template content
    template_config JSONB, -- Template configuration and parameters
    default_values JSONB, -- Default parameter values
    validation_rules JSONB, -- Template validation rules
    output_format JSONB, -- Expected output format and structure

    -- Usage tracking
    usage_count INTEGER DEFAULT 0,
    success_rate DECIMAL(5,2), -- Success rate of template usage
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

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_engineering_models_discipline ON a_engineering_models(discipline_code);
CREATE INDEX IF NOT EXISTS idx_engineering_models_project ON a_engineering_models(project_id);
CREATE INDEX IF NOT EXISTS idx_engineering_models_status ON a_engineering_models(validation_status);
CREATE INDEX IF NOT EXISTS idx_engineering_models_cad ON a_engineering_models(cad_system);
CREATE INDEX IF NOT EXISTS idx_engineering_models_jurisdiction ON a_engineering_models(jurisdiction);

CREATE INDEX IF NOT EXISTS idx_engineering_analysis_model ON a_engineering_analysis(model_id);
CREATE INDEX IF NOT EXISTS idx_engineering_analysis_type ON a_engineering_analysis(analysis_type);
CREATE INDEX IF NOT EXISTS idx_engineering_analysis_status ON a_engineering_analysis(status);
CREATE INDEX IF NOT EXISTS idx_engineering_analysis_created ON a_engineering_analysis(created_at);

CREATE INDEX IF NOT EXISTS idx_engineering_audit_model ON a_engineering_audit_trail(model_id);
CREATE INDEX IF NOT EXISTS idx_engineering_audit_analysis ON a_engineering_audit_trail(analysis_id);
CREATE INDEX IF NOT EXISTS idx_engineering_audit_user ON a_engineering_audit_trail(user_id);
CREATE INDEX IF NOT EXISTS idx_engineering_audit_timestamp ON a_engineering_audit_trail(timestamp);
CREATE INDEX IF NOT EXISTS idx_engineering_audit_discipline ON a_engineering_audit_trail(discipline_code);

CREATE INDEX IF NOT EXISTS idx_engineering_standards_discipline ON a_engineering_standards(discipline_code);
CREATE INDEX IF NOT EXISTS idx_engineering_standards_jurisdiction ON a_engineering_standards(jurisdiction);
CREATE INDEX IF NOT EXISTS idx_engineering_standards_code ON a_engineering_standards(standard_code);
CREATE INDEX IF NOT EXISTS idx_engineering_standards_status ON a_engineering_standards(status);

CREATE INDEX IF NOT EXISTS idx_engineering_templates_discipline ON a_engineering_templates(discipline_code);
CREATE INDEX IF NOT EXISTS idx_engineering_templates_type ON a_engineering_templates(template_type);
CREATE INDEX IF NOT EXISTS idx_engineering_templates_status ON a_engineering_templates(status);

-- Create composite indexes for common queries
CREATE INDEX IF NOT EXISTS idx_engineering_models_project_discipline ON a_engineering_models(project_id, discipline_code);
CREATE INDEX IF NOT EXISTS idx_engineering_analysis_model_type ON a_engineering_analysis(model_id, analysis_type);
CREATE INDEX IF NOT EXISTS idx_engineering_standards_disc_juris ON a_engineering_standards(discipline_code, jurisdiction);

-- Add table comments for documentation
COMMENT ON TABLE a_engineering_models IS 'Core engineering models with discipline-specific metadata and AI processing support';
COMMENT ON TABLE a_engineering_analysis IS 'Engineering analysis results with comprehensive validation and compliance tracking';
COMMENT ON TABLE a_engineering_audit_trail IS 'Complete audit trail for all engineering model and analysis changes';
COMMENT ON TABLE a_engineering_standards IS 'Engineering standards library with jurisdiction-specific requirements';
COMMENT ON TABLE a_engineering_templates IS 'Reusable engineering templates with AI optimization and usage tracking';

-- Create views for common queries
CREATE OR REPLACE VIEW v_engineering_model_summary AS
SELECT
    m.id,
    m.model_name,
    m.discipline_code,
    m.cad_system,
    m.jurisdiction,
    m.validation_status,
    m.created_at,
    COUNT(a.id) as analysis_count,
    COUNT(CASE WHEN a.status = 'completed' THEN 1 END) as completed_analyses,
    MAX(a.completed_at) as last_analysis_date
FROM a_engineering_models m
LEFT JOIN a_engineering_analysis a ON m.id = a.model_id
GROUP BY m.id, m.model_name, m.discipline_code, m.cad_system, m.jurisdiction, m.validation_status, m.created_at;

CREATE OR REPLACE VIEW v_engineering_analysis_summary AS
SELECT
    a.id,
    a.model_id,
    m.model_name,
    m.discipline_code,
    a.analysis_type,
    a.status,
    a.progress,
    a.created_at,
    a.started_at,
    a.completed_at,
    a.duration_seconds,
    a.validation_status
FROM a_engineering_analysis a
JOIN a_engineering_models m ON a.model_id = m.id;

-- Grant appropriate permissions (adjust as needed for your security model)
-- GRANT SELECT, INSERT, UPDATE ON a_engineering_models TO engineering_users;
-- GRANT SELECT, INSERT, UPDATE ON a_engineering_analysis TO engineering_users;
-- GRANT SELECT, INSERT ON a_engineering_audit_trail TO engineering_users;
-- GRANT SELECT ON a_engineering_standards TO engineering_users;
-- GRANT SELECT ON a_engineering_templates TO engineering_users;

-- GRANT SELECT ON v_engineering_model_summary TO engineering_users;
-- GRANT SELECT ON v_engineering_analysis_summary TO engineering_users;

-- ============================================================
-- Verification queries (run after schema creation)
-- ============================================================

-- Check table creation
-- SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_name LIKE 'a_engineering%';

-- Check index creation
-- SELECT indexname, tablename FROM pg_indexes WHERE tablename LIKE 'a_engineering%';

-- Check view creation
-- SELECT table_name FROM information_schema.views WHERE table_schema = 'public' AND table_name LIKE 'v_engineering%';

-- ============================================================
-- Clean up: Uncomment to remove the engineering schema
-- ============================================================

-- DROP VIEW IF EXISTS v_engineering_analysis_summary;
-- DROP VIEW IF EXISTS v_engineering_model_summary;
-- DROP TABLE IF EXISTS a_engineering_templates;
-- DROP TABLE IF EXISTS a_engineering_standards;
-- DROP TABLE IF EXISTS a_engineering_audit_trail;
-- DROP TABLE IF EXISTS a_engineering_analysis;
-- DROP TABLE IF EXISTS a_engineering_models;