-- =============================================================================
-- CONSTRUCTION PROCUREMENT PLATFORM - MASTER DATABASE SCHEMA (SQLite)
-- Generated: 2025-12-17T11:50:43.322Z
-- Source: Converted from 100% accurate PostgreSQL schema
-- =============================================================================

-- =============================================================================
-- CONSTRUCTION PROCUREMENT PLATFORM - MASTER DATABASE SCHEMA
-- Generated: 2025-12-17T11:50:40.822Z
-- Source: 100% Accurate - Direct PostgreSQL metadata extraction
-- Tables: 9
-- =============================================================================

-- organizations table
CREATE TABLE IF NOT EXISTS public.organizations (
    name character varying NOT NULL,
    sector_id uuid,
    is_active boolean DEFAULT true,
    is_template boolean DEFAULT false,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    id uuid NOT NULL DEFAULT NULL,
    supabase_url text,
    supabase_anon_key text,
    supabase_service_key text,
    organization_id uuid,
    user_id uuid
);

-- users table (no columns found)

-- projects table
CREATE TABLE IF NOT EXISTS public.projects (
    company_id integer,
    name character varying NOT NULL,
    project_type character varying,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    id uuid NOT NULL,
    project_number text,
    project_description text,
    site_location text,
    delivery_date date,
    completion_date date,
    cost_center text,
    budget_code text,
    workflow_status text DEFAULT 'active'::text,
    organization_id uuid,
    user_id uuid
);

-- disciplines table
CREATE TABLE IF NOT EXISTS public.disciplines (
    id uuid NOT NULL DEFAULT NULL,
    page_id uuid NOT NULL,
    name text NOT NULL,
    code text NOT NULL,
    slug text,
    organization_id uuid NOT NULL,
    organization_name text,
    sector_id uuid,
    sector_name text,
    parent_discipline_id uuid,
    hierarchy_level integer DEFAULT 0,
    display_order integer DEFAULT 0,
    is_active boolean DEFAULT true,
    is_standard_link boolean DEFAULT false,
    is_virtual boolean DEFAULT false,
    organization_ids ARRAY DEFAULT '{}'::uuid[],
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    created_by uuid,
    updated_by uuid
);

-- templates table
CREATE TABLE IF NOT EXISTS public.templates (
    id uuid NOT NULL DEFAULT NULL,
    type character varying NOT NULL,
    name character varying NOT NULL,
    description text,
    version character varying DEFAULT '1.0.0'::character varying,
    prompt_template text NOT NULL,
    validation_config jsonb DEFAULT '{}'::jsonb,
    ui_config jsonb DEFAULT '{}'::jsonb,
    is_active boolean DEFAULT true,
    is_public boolean DEFAULT false,
    created_by uuid,
    updated_by uuid,
    usage_count integer DEFAULT 0,
    success_rate numeric DEFAULT 100.00,
    average_generation_time integer DEFAULT 0,
    tags ARRAY DEFAULT '{}'::text[],
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    discipline_code character varying,
    document_type character varying,
    discipline character varying DEFAULT 'General'::character varying,
    copied_from_template_id uuid,
    template_scope character varying DEFAULT 'original'::character varying,
    target_discipline character varying,
    copy_metadata jsonb,
    processing_status text DEFAULT 'draft'::text,
    organization_id uuid,
    suitable_for_document_types ARRAY DEFAULT ARRAY['purchase_order'::text, 'work_order'::text, 'service_order'::text],
    category character varying,
    deleted_at TEXT,
    deleted_by uuid,
    deletion_reason text
);

-- forms table (no columns found)

-- form_data table (no columns found)

-- documents table (no columns found)

-- procurement_orders table
CREATE TABLE IF NOT EXISTS public.procurement_orders (
    id uuid NOT NULL DEFAULT NULL,
    order_number character varying,
    order_type character varying NOT NULL,
    title character varying NOT NULL,
    description text,
    department character varying,
    priority character varying DEFAULT 'medium'::character varying,
    estimated_value numeric,
    currency character varying DEFAULT 'ZAR'::character varying,
    supplier_name character varying,
    supplier_contact character varying,
    project_id uuid,
    project_phase character varying,
    template_id uuid,
    linked_documents jsonb DEFAULT '[]'::jsonb,
    approval_status character varying DEFAULT 'draft'::character varying,
    delivery_date date,
    special_requirements text,
    created_by uuid NOT NULL,
    organization_id uuid,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    sow_id uuid,
    sow_template_id uuid,
    appendix_a_content text,
    appendix_b_content text,
    appendix_c_content text,
    appendix_d_content text,
    appendix_e_content text,
    appendix_f_content text,
    approval_cover_content text,
    main_order_content text,
    discipline_assignments jsonb,
    contribution_status jsonb,
    approval_matrix jsonb,
    approval_routing_type character varying DEFAULT 'sequential'::character varying,
    approval_config jsonb DEFAULT '{}'::jsonb,
    user_assignments jsonb DEFAULT '{}'::jsonb,
    task_sequence jsonb,
    template_variation character varying,
    sequence_override_id uuid,
    estimated_completion_time interval,
    sequence_execution_id uuid
);

-- =============================================================================
-- SCHEMA EXTRACTION COMPLETE
-- Total Tables: 9
-- Generated: 2025-12-17T11:50:43.322Z
-- =============================================================================
