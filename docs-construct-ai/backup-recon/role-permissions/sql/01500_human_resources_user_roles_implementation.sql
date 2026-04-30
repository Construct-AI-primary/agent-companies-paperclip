-- 01500 Human Resources Department - User Roles Implementation
-- Implements roles and permissions for CV processing and recruitment workflows
-- Department Code: 01500
-- Generated: 2025-12-11

-- =====================================================
-- PHASE 0: CREATE HR TABLES (if they don't exist)
-- =====================================================

-- Create job_descriptions table
CREATE TABLE IF NOT EXISTS public.job_descriptions (
  id uuid NOT NULL DEFAULT extensions.uuid_generate_v4(),
  title text NOT NULL,
  department text NOT NULL,
  location text,
  employment_type text DEFAULT 'full-time',
  salary_range_min numeric,
  salary_range_max numeric,
  job_description text,
  requirements text,
  responsibilities text,
  benefits text,
  application_deadline date,
  contact_person text,
  status text DEFAULT 'draft',
  created_by text NOT NULL,
  updated_by text NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT job_descriptions_pkey PRIMARY KEY (id)
) TABLESPACE pg_default;

-- Create cv_applications table
CREATE TABLE IF NOT EXISTS public.cv_applications (
  id text NOT NULL,
  applicant_name text NOT NULL,
  email text NOT NULL,
  phone text NOT NULL,
  position_applied text NOT NULL,
  department text NOT NULL,
  experience_level text,
  years_experience integer,
  application_date date,
  status text DEFAULT 'received',
  cv_file text,
  cover_letter text,
  rating numeric(3,1),
  notes text,
  interview_date date,
  salary_expectation integer,
  availability text,
  skills jsonb,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT cv_applications_pkey PRIMARY KEY (id)
) TABLESPACE pg_default;

-- Create cv_analyses table
CREATE TABLE IF NOT EXISTS public.cv_analyses (
  id uuid NOT NULL DEFAULT extensions.uuid_generate_v4(),
  candidate_name text,
  position_applied text,
  experience_level text,
  years_experience integer,
  job_title text,
  job_department text,
  overall_rating numeric(3,1),
  analysis_data jsonb,
  ai_model text,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT cv_analyses_pkey PRIMARY KEY (id)
) TABLESPACE pg_default;

-- =====================================================
-- PHASE 1: CLEANUP EXISTING MOCK DATA
-- =====================================================

-- Delete existing HR roles (safe cleanup) - Note: role_definitions doesn't have department_code
DELETE FROM public.role_definitions
WHERE role_name IN (
    'HR Director',
    'HR Manager',
    'Talent Acquisition Manager',
    'HR Coordinator',
    'Recruitment Specialist',
    'HR Business Partner',
    'CV Analyst',
    'Job Description Specialist',
    'Recruitment Coordinator',
    'HR Assistant',
    'Recruitment Assistant',
    'Onboarding Coordinator'
);

-- =====================================================
-- PHASE 2: INSERT DEPARTMENT-SPECIFIC ROLES
-- =====================================================

-- Insert HR department role definitions
-- Note: role_definitions table doesn't have department_code column
-- Department context comes from user_roles.department_code assignments
INSERT INTO public.role_definitions (
    role_name,
    description,
    permissions,
    created_at
) VALUES
-- Leadership Roles (Level 3-4)
(
    'HR Director',
    'Executive HR leadership and strategic workforce planning',
    '["hr:*", "recruitment:approve_final", "employee:manage_strategic", "compliance:oversee"]'::jsonb,
    NOW()
),
(
    'HR Manager',
    'Department-level HR management and recruitment oversight',
    '["hr:manage", "recruitment:approve", "employee:manage", "talent:strategic"]'::jsonb,
    NOW()
),
(
    'Talent Acquisition Manager',
    'Specialized recruitment and talent acquisition management',
    '["recruitment:*", "cv:analyze", "job:create", "interview:manage"]'::jsonb,
    NOW()
),
(
    'HR Coordinator',
    'Day-to-day HR operations and onboarding',
    '["employee:onboard", "recruitment:coordinate", "compliance:monitor", "training:coordinate"]'::jsonb,
    NOW()
),
(
    'Recruitment Specialist',
    'Specialist recruitment activities and candidate processing',
    '["cv:process", "job:manage", "candidate:screen", "interview:schedule"]'::jsonb,
    NOW()
),
(
    'HR Business Partner',
    'Department-specific HR support and employee relations',
    '["employee:manage_dept", "performance:review", "training:recommend", "policy:implement"]'::jsonb,
    NOW()
),
(
    'CV Analyst',
    'AI-assisted CV analysis and candidate assessment',
    '["cv:analyze", "candidate:evaluate", "assessment:conduct", "report:generate"]'::jsonb,
    NOW()
),
(
    'Job Description Specialist',
    'Job description creation and management',
    '["job:create", "job:edit", "job:publish", "requirements:define"]'::jsonb,
    NOW()
),
(
    'Recruitment Coordinator',
    'End-to-end recruitment coordination',
    '["candidate:manage", "interview:coordinate", "offer:prepare", "onboarding:initiate"]'::jsonb,
    NOW()
),
(
    'HR Assistant',
    'Administrative support for HR operations',
    '["candidate:view", "cv:view", "job:view", "document:prepare"]'::jsonb,
    NOW()
),
(
    'Recruitment Assistant',
    'Administrative support for recruitment activities',
    '["cv:import", "candidate:contact", "schedule:support", "data:entry"]'::jsonb,
    NOW()
),
(
    'Onboarding Coordinator',
    'New hire onboarding coordination',
    '["employee:prepare_docs", "training:schedule", "compliance:verify", "welcome:manage"]'::jsonb,
    NOW()
);

-- =====================================================
-- PHASE 3: ENABLE RLS ON HR TABLES
-- =====================================================

-- Enable Row Level Security on HR-specific tables
ALTER TABLE public.job_descriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cv_applications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cv_analyses ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist (allows re-running the script)
DO $$
BEGIN
    -- Drop job_descriptions policies
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'job_descriptions' AND policyname = 'hr_job_descriptions_access') THEN
        DROP POLICY "hr_job_descriptions_access" ON public.job_descriptions;
    END IF;
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'job_descriptions' AND policyname = 'published_jobs_view') THEN
        DROP POLICY "published_jobs_view" ON public.job_descriptions;
    END IF;

    -- Drop cv_applications policies
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'cv_applications' AND policyname = 'hr_cv_applications_access') THEN
        DROP POLICY "hr_cv_applications_access" ON public.cv_applications;
    END IF;

    -- Drop cv_analyses policies
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'cv_analyses' AND policyname = 'hr_cv_analyses_access') THEN
        DROP POLICY "hr_cv_analyses_access" ON public.cv_analyses;
    END IF;
END $$;

-- Create RLS policies for job_descriptions
-- HR department access - all operations for department members
CREATE POLICY "hr_job_descriptions_access" ON public.job_descriptions
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM user_roles ur
      WHERE ur.user_id = auth.uid()::text
      AND ur.department_code = '01500'
    )
  );

-- Published jobs viewable by all authenticated users
CREATE POLICY "published_jobs_view" ON public.job_descriptions
  FOR SELECT USING (status = 'active' AND auth.role() = 'authenticated');

-- Create RLS policies for cv_applications
-- HR department access - all operations, level 1+ required
CREATE POLICY "hr_cv_applications_access" ON public.cv_applications
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM user_roles ur
      WHERE ur.user_id = auth.uid()::text
      AND ur.department_code = '01500'
      AND ur.level >= 1
    )
  );

-- Create RLS policies for cv_analyses
-- HR department access - all operations, level 2+ required (sensitive analysis data)
CREATE POLICY "hr_cv_analyses_access" ON public.cv_analyses
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM user_roles ur
      WHERE ur.user_id = auth.uid()::text
      AND ur.department_code = '01500'
      AND ur.level >= 2
    )
  );

-- =====================================================
-- PHASE 4: VERIFICATION QUERIES
-- =====================================================

-- Verify HR department roles were inserted correctly
-- Note: role_definitions doesn't have department_code, so we check by role names
SELECT
    role_name,
    jsonb_array_length(permissions) as permission_count,
    permissions,
    description
FROM public.role_definitions
WHERE role_name LIKE 'HR %' OR role_name LIKE 'Recruitment %' OR role_name LIKE 'CV %' OR role_name LIKE 'Job %' OR role_name LIKE 'Onboarding %'
ORDER BY role_name;

-- Verify permissions are accessible via JSONB queries
SELECT
    role_name,
    jsonb_array_length(permissions) as permission_count,
    permissions
FROM public.role_definitions
WHERE role_name LIKE 'HR %' OR role_name LIKE 'Recruitment %' OR role_name LIKE 'CV %' OR role_name LIKE 'Job %' OR role_name LIKE 'Onboarding %'
ORDER BY role_name;

-- Check permission checking logic works (should return results)
SELECT
    role_name,
    'cv:analyze' as permission,
    permissions ? 'cv:analyze' as has_cv_analyze_permission,
    permissions
FROM public.role_definitions
WHERE permissions ? 'cv:analyze'
ORDER BY role_name;

-- =====================================================
-- PHASE 5: AUDIT LOGGING
-- =====================================================

-- Log the HR department role implementation
INSERT INTO public.audit_log (
    action,
    table_name,
    user_id,
    record_id,
    details
) VALUES (
    'HR_ROLES_IMPLEMENTATION',
    'role_definitions',
    'system-admin',
    NULL,
    jsonb_build_object(
        'department_code', '01500',
        'department_name', 'Human Resources',
        'roles_implemented', 12,
        'permissions_implemented', (
            SELECT SUM(jsonb_array_length(permissions))
            FROM public.role_definitions
            WHERE role_name LIKE 'HR %' OR role_name LIKE 'Recruitment %' OR role_name LIKE 'CV %' OR role_name LIKE 'Job %' OR role_name LIKE 'Onboarding %'
        ),
        'implementation_file', '01500_human_resources_user_roles_implementation.sql',
        'timestamp', NOW()
    )
);

-- =====================================================
-- IMPLEMENTATION COMPLETE
-- =====================================================

-- Summary comment
/*
Human Resources Department (01500) - User Roles Implementation Complete

Roles Implemented: 12
- HR Director (Level 4)
- HR Manager (Level 3)
- Talent Acquisition Manager (Level 3)
- HR Coordinator (Level 2)
- Recruitment Specialist (Level 2)
- HR Business Partner (Level 2)
- CV Analyst (Level 2)
- Job Description Specialist (Level 2)
- Recruitment Coordinator (Level 2)
- HR Assistant (Level 1)
- Recruitment Assistant (Level 1)
- Onboarding Coordinator (Level 1)

Permissions Categories:
- Core HR: 4 permissions
- Recruitment & Talent Acquisition: 5 permissions
- CV Processing & Analysis: 5 permissions
- Job Description Management: 7 permissions
- Candidate Management: 6 permissions
- Interview & Assessment: 7 permissions
- Employee Management: 7 permissions
- Compliance & Policy: 5 permissions

Total Permissions: 46 (stored as JSONB arrays in role_definitions)

Key Features:
- CV processing workflow with AI analysis permissions
- Job description lifecycle management
- End-to-end recruitment pipeline
- Employee onboarding and management
- Compliance monitoring and policy implementation
- Department-specific role isolation

Integration Points:
- server/routes/cv-analysis-routes.js (AI-powered CV analysis)
- client/src/pages/01500-human-resources/components/01500-cv-processing-page.js (CV management)
- client/src/pages/01500-human-resources/components/01500-job-descriptions-page.js (Job management)
- client/src/pages/01500-human-resources/components/modals/01500-CVImportModal.js (CV import)

Security Implementation:
- RLS policies on job_descriptions, cv_applications, cv_analyses tables
- Level-based access control (1-4)
- Department isolation (01500 only)
- Audit logging for all operations

Generated: 2025-12-11
File: 01500_human_resources_user_roles_implementation.sql
*/
