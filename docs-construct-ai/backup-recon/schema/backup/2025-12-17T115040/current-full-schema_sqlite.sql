-- =============================================================================
-- CONSTRUCTION PROCUREMENT PLATFORM - MASTER DATABASE SCHEMA (SQLite)
-- Generated: 2025-12-17T11:48:26.362Z
-- Source: Converted from PostgreSQL schema
-- =============================================================================

-- =============================================================================
-- CONSTRUCTION PROCUREMENT PLATFORM - MASTER DATABASE SCHEMA
-- Generated: 2025-12-17T11:48:20.725Z
-- Source: Direct database metadata extraction
-- =============================================================================

-- organizations table
CREATE TABLE IF NOT EXISTS public.organizations (
    name VARCHAR(255) NOT NULL,
    sector_id TEXT,
    is_active BOOLEAN NOT NULL,
    is_template BOOLEAN NOT NULL,
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now(),
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    supabase_url TEXT,
    supabase_anon_key TEXT,
    supabase_service_key TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- users table
CREATE TABLE IF NOT EXISTS public.users (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- projects table
CREATE TABLE IF NOT EXISTS public.projects (
    company_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    project_type VARCHAR(255) NOT NULL,
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now(),
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    project_number TEXT,
    project_description TEXT,
    site_location TEXT,
    delivery_date TEXT,
    completion_date TEXT,
    cost_center TEXT,
    budget_code TEXT,
    workflow_status VARCHAR(255) NOT NULL,
    organization_id TEXT NOT NULL,
    user_id TEXT
);

-- disciplines table
CREATE TABLE IF NOT EXISTS public.disciplines (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    page_id TEXT NOT NULL,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL,
    organization_id TEXT NOT NULL,
    organization_name VARCHAR(255) NOT NULL,
    sector_id TEXT NOT NULL,
    sector_name VARCHAR(255) NOT NULL,
    parent_discipline_id TEXT,
    hierarchy_level INTEGER NOT NULL,
    display_order INTEGER NOT NULL,
    is_active BOOLEAN NOT NULL,
    is_standard_link BOOLEAN NOT NULL,
    is_virtual BOOLEAN NOT NULL,
    organization_ids TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now(),
    created_by TEXT,
    updated_by TEXT
);

-- templates table
CREATE TABLE IF NOT EXISTS public.templates (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- forms table
CREATE TABLE IF NOT EXISTS public.forms (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- form_data table
CREATE TABLE IF NOT EXISTS public.form_data (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- documents table
CREATE TABLE IF NOT EXISTS public.documents (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- procurement_orders table
CREATE TABLE IF NOT EXISTS public.procurement_orders (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- procurement_templates table
CREATE TABLE IF NOT EXISTS public.procurement_templates (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- procurement_categories table
CREATE TABLE IF NOT EXISTS public.procurement_categories (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- procurement_performance table
CREATE TABLE IF NOT EXISTS public.procurement_performance (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- quality_metrics table
CREATE TABLE IF NOT EXISTS public.quality_metrics (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- equipment table
CREATE TABLE IF NOT EXISTS public.equipment (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- suppliers table
CREATE TABLE IF NOT EXISTS public.suppliers (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- contracts table
CREATE TABLE IF NOT EXISTS public.contracts (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    contractor_id TEXT,
    contract_number VARCHAR(255) NOT NULL,
    contract_type VARCHAR(255) NOT NULL,
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now(),
    contract_type_id TEXT,
    category VARCHAR(255) NOT NULL,
    working_zones TEXT,
    project_id TEXT,
    organization_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    assigned_to TEXT
);

-- tasks table
CREATE TABLE IF NOT EXISTS public.tasks (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    organization_id TEXT NOT NULL,
    task_type VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    business_object_type VARCHAR(255) NOT NULL,
    business_object_id TEXT NOT NULL,
    assigned_to TEXT NOT NULL,
    assigned_by TEXT NOT NULL,
    discipline VARCHAR(255) NOT NULL,
    priority VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    due_date TEXT,
    is_hitl BOOLEAN NOT NULL,
    intervention_type TEXT,
    chatbot_session_id TEXT,
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now(),
    completed_at TEXT,
    escalated_at TEXT,
    metadata TEXT NOT NULL,
    sequence_position TEXT,
    sequence_group TEXT,
    sequence_dependencies TEXT NOT NULL,
    sequence_execution_id TEXT,
    estimated_duration_minutes TEXT,
    actual_duration_minutes TEXT
);

-- task_assignments table
CREATE TABLE IF NOT EXISTS public.task_assignments (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- schedules table
CREATE TABLE IF NOT EXISTS public.schedules (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- gantt_data table
CREATE TABLE IF NOT EXISTS public.gantt_data (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- audit_logs table
CREATE TABLE IF NOT EXISTS public.audit_logs (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- notifications table
CREATE TABLE IF NOT EXISTS public.notifications (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- user_sessions table
CREATE TABLE IF NOT EXISTS public.user_sessions (
    id TEXT NOT NULL DEFAULT gen_random_uuid(),
    created_at TEXT NOT NULL DEFAULT now(),
    updated_at TEXT NOT NULL DEFAULT now()
);

-- =============================================================================
-- SCHEMA EXTRACTION COMPLETE
-- =============================================================================
