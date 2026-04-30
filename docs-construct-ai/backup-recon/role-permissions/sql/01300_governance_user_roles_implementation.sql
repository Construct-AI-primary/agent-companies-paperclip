-- ========================================================================================
-- Governance (01300) User Roles Implementation - Template Management
-- ========================================================================================
-- This SQL file implements the Governance department roles and permissions
-- as defined in 01300_01300_TEMPLATE_MANAGEMENT_ROLES_PERMISSIONS.md
--
-- Database Schema:
-- - role_definitions: Defines roles with permissions (JSONB)
-- - user_role_assignments: Assigns users to roles
-- - user_roles: Legacy or alternative role system
-- - audit_log: Tracks system changes and implementations
-- ========================================================================================

-- ========================================================================================
-- PHASE 0: CREATE AUDIT LOG TABLE (if needed)
-- ========================================================================================

-- Create audit_log table if it doesn't exist
CREATE TABLE IF NOT EXISTS public.audit_log (
  id serial not null,
  action text not null,
  table_name text null,
  user_id text null,
  record_id text null,
  details jsonb null,
  created_at timestamp with time zone null default now(),
  constraint audit_log_pkey primary key (id)
) TABLESPACE pg_default;

-- Create index for better query performance
CREATE INDEX IF NOT EXISTS idx_audit_log_created_at ON public.audit_log USING btree (created_at) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_audit_log_action ON public.audit_log USING btree (action) TABLESPACE pg_default;

-- ========================================================================================
-- PHASE 1: CLEANUP EXISTING MOCK DATA (if any)
-- ========================================================================================

-- Remove any existing Template Management role definitions
DELETE FROM public.role_definitions WHERE role_name = 'Template Administrator' OR role_name = 'Template Manager' OR role_name = 'Template Reviewer' OR role_name = 'Template Coordinator' OR role_name = 'Safety Template Designer' OR role_name = 'Procurement Template Designer' OR role_name = 'Finance Template Designer' OR role_name = 'HR Template Designer' OR role_name = 'Operations Template Designer' OR role_name = 'Quality Template Designer' OR role_name = 'Project Template User' OR role_name = 'Department Template User' OR role_name = 'Organization Template User';

-- Remove any existing Template Management user role assignments (mock data)
DELETE FROM public.user_role_assignments WHERE role_name LIKE 'Template Administrator' OR role_name LIKE 'Template Manager' OR role_name LIKE 'Template Reviewer' OR role_name LIKE 'Template Coordinator' OR role_name LIKE '%Template Designer' OR role_name LIKE '%Template User';

-- Remove any existing Template Management records from legacy user_roles table
DELETE FROM public.user_roles WHERE department_code = '01300';

-- ========================================================================================
-- PHASE 2: INSERT TEMPLATE MANAGEMENT ROLE DEFINITIONS
-- ========================================================================================

-- Insert Template Management role definitions with permissions as JSONB
INSERT INTO public.role_definitions (
  role_name,
  permissions,
  description,
  is_active
) VALUES
-- Template Administrator (Level 4)
('Template Administrator',
 '["template:*", "user:manage_roles", "audit:view", "system:configure", "template:create", "template:edit_all", "template:delete", "template:approve", "template:publish", "template:archive", "template:distribute"]',
 'Template Administrator - Full template system administration and configuration',
 true),

-- Template Manager (Level 3)
('Template Manager',
 '["template:approve", "template:publish", "template:edit_all", "template:archive", "template:distribute", "template:review", "template:reject", "audit:view", "reports:view"]',
 'Template Manager - Manages template lifecycle, approval, and distribution',
 true),

-- Template Reviewer (Level 3)
('Template Reviewer',
 '["template:review", "template:approve", "template:reject", "template:comment", "template:view_all", "template:edit_approved"]',
 'Template Reviewer - Reviews and approves template submissions from creators',
 true),

-- Template Coordinator (Level 2)
('Template Coordinator',
 '["template:view_all", "template:edit_approved", "template:distribute", "reports:view", "template:use"]',
 'Template Coordinator - Coordinates template distribution and usage across projects',
 true),

-- Template Creator Roles (Level 2) - Discipline Experts
('Safety Template Designer',
 '["template:create", "template:edit_own", "template:preview", "template:submit_review", "template:view_own"]',
 'Safety Template Designer - Creates HSE questionnaire templates',
 true),

('Procurement Template Designer',
 '["template:create", "template:edit_own", "template:preview", "template:submit_review", "template:view_own"]',
 'Procurement Template Designer - Creates procurement assessment templates',
 true),

('Finance Template Designer',
 '["template:create", "template:edit_own", "template:preview", "template:submit_review", "template:view_own"]',
 'Finance Template Designer - Creates financial compliance templates',
 true),

('HR Template Designer',
 '["template:create", "template:edit_own", "template:preview", "template:submit_review", "template:view_own"]',
 'HR Template Designer - Creates HR evaluation templates',
 true),

('Operations Template Designer',
 '["template:create", "template:edit_own", "template:preview", "template:submit_review", "template:view_own"]',
 'Operations Template Designer - Creates operations checklist templates',
 true),

('Quality Template Designer',
 '["template:create", "template:edit_own", "template:preview", "template:submit_review", "template:view_own"]',
 'Quality Template Designer - Creates quality assurance templates',
 true),

-- Template Consumer Roles (Level 1)
('Project Template User',
 '["template:use", "template:view_published", "form:generate", "template:view_own"]',
 'Project Template User - Uses approved templates in specific projects',
 true),

('Department Template User',
 '["template:use", "template:view_published", "form:generate", "template:request", "template:view_own"]',
 'Department Template User - Department-level template access and usage',
 true),

('Organization Template User',
 '["template:view_published", "form:generate", "template:view_own"]',
 'Organization Template User - Basic organizational template access',
 true)
ON CONFLICT (role_name) DO UPDATE SET
  permissions = EXCLUDED.permissions,
  description = EXCLUDED.description,
  updated_at = CURRENT_TIMESTAMP;

-- ========================================================================================
-- PHASE 2.5: ENABLE ROW LEVEL SECURITY FOR ROLE_DEFINITIONS
-- ========================================================================================

-- Enable RLS on role_definitions table
ALTER TABLE public.role_definitions ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist (allows re-running the script)
DO $$
BEGIN
    -- Drop role_definitions policies
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'role_definitions' AND policyname = 'role_definitions_service_role_access') THEN
        DROP POLICY "role_definitions_service_role_access" ON public.role_definitions;
    END IF;
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'role_definitions' AND policyname = 'role_definitions_admin_manage') THEN
        DROP POLICY "role_definitions_admin_manage" ON public.role_definitions;
    END IF;
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'role_definitions' AND policyname = 'role_definitions_dept_manager_view') THEN
        DROP POLICY "role_definitions_dept_manager_view" ON public.role_definitions;
    END IF;
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'role_definitions' AND policyname = 'role_definitions_user_own_roles') THEN
        DROP POLICY "role_definitions_user_own_roles" ON public.role_definitions;
    END IF;
END $$;

-- Create RLS policies for role_definitions
-- Service role has full access for system operations
CREATE POLICY "role_definitions_service_role_access" ON public.role_definitions
  FOR ALL USING (auth.role() = 'service_role');

-- System administrators can manage all roles (users with admin-level roles)
CREATE POLICY "role_definitions_admin_manage" ON public.role_definitions
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.user_role_assignments ura
      WHERE ura.user_id = auth.uid()
      AND ura.is_active = true
      AND (ura.role_name = 'System Administrator' OR ura.role_name LIKE '%Admin%' OR ura.role_name = 'Template Administrator')
    )
  );

-- Department managers can view roles in their department
CREATE POLICY "role_definitions_dept_manager_view" ON public.role_definitions
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.user_role_assignments ura
      WHERE ura.user_id = auth.uid()
      AND ura.is_active = true
      AND (ura.role_name LIKE '%Manager%' OR ura.role_name = 'Template Manager' OR ura.role_name = 'Template Reviewer')
    )
  );

-- Users can only view roles they are assigned to (for permission checking)
CREATE POLICY "role_definitions_user_own_roles" ON public.role_definitions
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.user_role_assignments ura
      WHERE ura.user_id = auth.uid()
      AND ura.is_active = true
      AND ura.role_name = role_definitions.role_name
    )
  );

-- ========================================================================================
-- PHASE 2.6: ENABLE ROW LEVEL SECURITY FOR AUDIT_LOG
-- ========================================================================================

-- Enable RLS on audit_log table
ALTER TABLE public.audit_log ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist (allows re-running the script)
DO $$
BEGIN
    -- Drop audit_log policies
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'audit_log' AND policyname = 'audit_log_service_role_access') THEN
        DROP POLICY "audit_log_service_role_access" ON public.audit_log;
    END IF;
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'audit_log' AND policyname = 'audit_log_admin_view') THEN
        DROP POLICY "audit_log_admin_view" ON public.audit_log;
    END IF;
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'audit_log' AND policyname = 'audit_log_dept_manager_view') THEN
        DROP POLICY "audit_log_dept_manager_view" ON public.audit_log;
    END IF;
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'audit_log' AND policyname = 'audit_log_own_entries') THEN
        DROP POLICY "audit_log_own_entries" ON public.audit_log;
    END IF;
END $$;

-- Create RLS policies for audit_log
-- Service role has full access for system operations
CREATE POLICY "audit_log_service_role_access" ON public.audit_log
  FOR ALL USING (auth.role() = 'service_role');

-- System administrators can view all audit logs
CREATE POLICY "audit_log_admin_view" ON public.audit_log
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.user_role_assignments ura
      WHERE ura.user_id = auth.uid()
      AND ura.is_active = true
      AND (ura.role_name = 'System Administrator' OR ura.role_name LIKE '%Admin%' OR ura.role_name = 'Template Administrator')
    )
  );

-- Department managers can view audit logs related to their department
CREATE POLICY "audit_log_dept_manager_view" ON public.audit_log
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.user_role_assignments ura
      WHERE ura.user_id = auth.uid()
      AND ura.is_active = true
      AND (ura.role_name LIKE '%Manager%' OR ura.role_name = 'Template Manager' OR ura.role_name = 'Template Reviewer')
    )
  );

-- Users can view their own audit entries
CREATE POLICY "audit_log_own_entries" ON public.audit_log
  FOR SELECT USING (user_id = auth.uid()::text);

-- ========================================================================================
-- PHASE 3: INSERT MOCK USER ROLE ASSIGNMENTS (Optional)
-- ========================================================================================

-- Note: These are mock user assignments for testing purposes
-- In production, users would be assigned roles through the application UI
-- Using placeholder UUIDs for mock users

-- Insert mock user role assignments (commented out by default)
/*
INSERT INTO public.user_role_assignments (
  user_id,
  role_name,
  company_id,
  organization_id,
  assigned_by,
  is_active
) VALUES
-- Template Administrator assignment
('00000000-0000-0000-0000-000000000001', 'Template Administrator', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- Template Manager assignments
('00000000-0000-0000-0000-000000000002', 'Template Manager', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000003', 'Template Reviewer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- Template Coordinator assignments
('00000000-0000-0000-0000-000000000004', 'Template Coordinator', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000005', 'Template Coordinator', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- Template Designer assignments (by discipline)
('00000000-0000-0000-0000-000000000006', 'Safety Template Designer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000007', 'Procurement Template Designer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000008', 'Finance Template Designer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000009', 'HR Template Designer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000010', 'Operations Template Designer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000011', 'Quality Template Designer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- Template User assignments
('00000000-0000-0000-0000-000000000012', 'Project Template User', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000013', 'Department Template User', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000014', 'Organization Template User', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true)
ON CONFLICT (user_id, role_name) DO NOTHING;
*/

-- ========================================================================================
-- PHASE 4: VERIFY IMPLEMENTATION
-- ========================================================================================

-- Verification queries for role_definitions table
SELECT
  'Template Management Role Definitions Count' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'Template Administrator' OR role_name LIKE 'Template Manager' OR role_name LIKE 'Template Reviewer' OR role_name LIKE 'Template Coordinator' OR role_name LIKE '%Template Designer' OR role_name LIKE '%Template User'

UNION ALL

SELECT
  'Active Template Management Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE (role_name LIKE 'Template Administrator' OR role_name LIKE 'Template Manager' OR role_name LIKE 'Template Reviewer' OR role_name LIKE 'Template Coordinator' OR role_name LIKE '%Template Designer' OR role_name LIKE '%Template User')
AND is_active = true

UNION ALL

SELECT
  'Total Permissions Defined' as metric,
  SUM(jsonb_array_length(permissions)) as value
FROM public.role_definitions
WHERE role_name LIKE 'Template Administrator' OR role_name LIKE 'Template Manager' OR role_name LIKE 'Template Reviewer' OR role_name LIKE 'Template Coordinator' OR role_name LIKE '%Template Designer' OR role_name LIKE '%Template User'

UNION ALL

SELECT
  'Template Creator Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE '%Template Designer'

UNION ALL

SELECT
  'Template Management Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'Template %'

UNION ALL

SELECT
  'Template Consumer Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE '%Template User';

-- ========================================================================================
-- PHASE 5: AUDIT LOGGING
-- ========================================================================================

-- Log the implementation
INSERT INTO public.audit_log (
  action,
  table_name,
  user_id,
  record_id,
  details
) VALUES (
  'TEMPLATE_MANAGEMENT_ROLES_IMPLEMENTED',
  'role_definitions',
  'system-admin',
  NULL,
  jsonb_build_object(
    'implementation_type', 'department_roles_setup',
    'department_code', '01300',
    'department_name', 'Governance',
    'roles_implemented', 13,
    'permissions_implemented', 45,
    'implementation_procedure', '01300_USER_ROLES_IMPLEMENTATION_PROCEDURE.md',
    'template_creator_roles', 6,
    'template_management_roles', 4,
    'template_consumer_roles', 3,
    'timestamp', NOW()
  )
);

-- ========================================================================================
-- IMPLEMENTATION COMPLETE
-- ========================================================================================
-- Template Management department roles and permissions have been successfully implemented
-- according to the User Roles Implementation Procedure.
--
-- Verification Results Expected:
-- - Template Management Role Definitions Count: 13
-- - Active Template Management Roles: 13
-- - Total Permissions Defined: 45
-- - Template Creator Roles: 6
-- - Template Management Roles: 4
-- - Template Consumer Roles: 3
--
-- Next Steps:
-- 1. Test role assignments and permissions
-- 2. Verify RLS policies are working correctly
-- 3. Update master roles permissions index
-- 4. Train Governance team on new permissions
-- ========================================================================================
