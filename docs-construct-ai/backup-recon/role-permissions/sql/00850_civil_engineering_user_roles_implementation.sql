-- ========================================================================================
-- Civil Engineering (00850) User Roles Implementation
-- ========================================================================================
-- This SQL file implements the Civil Engineering department roles and permissions
-- as defined in 01300_00850_CIVIL_ENGINEERING_ROLES_PERMISSIONS.md
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

-- Remove any existing Civil Engineering role definitions
DELETE FROM public.role_definitions WHERE role_name LIKE 'Chief Civil Engineer' OR role_name LIKE 'Civil Engineering Manager' OR role_name LIKE 'Project Civil Engineer' OR role_name LIKE 'Senior Civil Engineer' OR role_name LIKE 'Civil Engineer' OR role_name LIKE 'Materials Engineer' OR role_name LIKE 'Civil Engineering Technician' OR role_name LIKE 'Materials Technician';

-- Remove any existing Civil Engineering user role assignments (mock data)
DELETE FROM public.user_role_assignments WHERE role_name LIKE 'Chief Civil Engineer' OR role_name LIKE 'Civil Engineering Manager' OR role_name LIKE 'Project Civil Engineer' OR role_name LIKE 'Senior Civil Engineer' OR role_name LIKE 'Civil Engineer' OR role_name LIKE 'Materials Engineer' OR role_name LIKE 'Civil Engineering Technician' OR role_name LIKE 'Materials Technician';

-- Remove any existing Civil Engineering records from legacy user_roles table
DELETE FROM public.user_roles WHERE department_code = '00850';

-- ========================================================================================
-- PHASE 2: INSERT CIVIL ENGINEERING ROLE DEFINITIONS
-- ========================================================================================

-- Insert Civil Engineering role definitions with permissions as JSONB
INSERT INTO public.role_definitions (
  role_name,
  permissions,
  description,
  is_active
) VALUES
-- Chief Civil Engineer (Level 4)
('Chief Civil Engineer',
 '["civil:*", "civil:design:approve_final", "civil:construction:supervise", "civil:qa:certify", "civil:audit:conduct"]',
 'Chief Civil Engineer - oversees all civil engineering operations and final approvals',
 true),

-- Civil Engineering Manager (Level 3)
('Civil Engineering Manager',
 '["civil:manage", "civil:design:approve", "civil:construction:coordinate", "civil:qa:supervise", "civil:report:departmental"]',
 'Civil Engineering Manager - manages civil engineering department operations',
 true),

-- Project Civil Engineer (Level 3)
('Project Civil Engineer',
 '["civil:project:lead", "civil:design:review", "civil:construction:manage", "civil:qa:implement"]',
 'Project Civil Engineer - leads specific civil engineering projects',
 true),

-- Senior Civil Engineer (Level 3)
('Senior Civil Engineer',
 '["civil:design:lead", "civil:calculation:approve", "civil:specification:develop", "civil:construction:supervise"]',
 'Senior Civil Engineer - leads design and engineering calculations',
 true),

-- Civil Engineer (Level 2)
('Civil Engineer',
 '["civil:design:create", "civil:calculation:perform", "civil:drawing:produce", "civil:site:inspect"]',
 'Civil Engineer - performs civil engineering design and calculations',
 true),

-- Materials Engineer (Level 2)
('Materials Engineer',
 '["civil:materials:test", "civil:quality:verify", "civil:specification:materials", "civil:compliance:materials"]',
 'Materials Engineer - specializes in material testing and specifications',
 true),

-- Civil Engineering Technician (Level 1)
('Civil Engineering Technician',
 '["civil:drawing:assist", "civil:calculation:support", "civil:site:monitor", "civil:documentation:maintain"]',
 'Civil Engineering Technician - provides technical support for civil engineering tasks',
 true),

-- Materials Technician (Level 1)
('Materials Technician',
 '["civil:testing:assist", "civil:sample:collect", "civil:data:record", "civil:equipment:calibrate"]',
 'Materials Technician - assists with material testing and data collection',
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
      AND (ura.role_name = 'System Administrator' OR ura.role_name LIKE '%Admin%')
    )
  );

-- Department managers can view roles in their department
CREATE POLICY "role_definitions_dept_manager_view" ON public.role_definitions
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.user_role_assignments ura
      WHERE ura.user_id = auth.uid()
      AND ura.is_active = true
      AND ura.role_name LIKE '%Manager%'
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
      AND (ura.role_name = 'System Administrator' OR ura.role_name LIKE '%Admin%')
    )
  );

-- Department managers can view audit logs related to their department
CREATE POLICY "audit_log_dept_manager_view" ON public.audit_log
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.user_role_assignments ura
      WHERE ura.user_id = auth.uid()
      AND ura.is_active = true
      AND ura.role_name LIKE '%Manager%' -- Department managers
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
-- Chief Civil Engineer assignment
('00000000-0000-0000-0000-000000000001', 'Chief Civil Engineer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- Civil Engineering Manager assignments
('00000000-0000-0000-0000-000000000002', 'Civil Engineering Manager', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000003', 'Project Civil Engineer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- Senior Civil Engineer assignments
('00000000-0000-0000-0000-000000000004', 'Senior Civil Engineer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000005', 'Senior Civil Engineer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- Civil Engineer assignments
('00000000-0000-0000-0000-000000000006', 'Civil Engineer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000007', 'Civil Engineer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000008', 'Civil Engineer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- Materials Engineer assignment
('00000000-0000-0000-0000-000000000009', 'Materials Engineer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- Technician assignments
('00000000-0000-0000-0000-000000000010', 'Civil Engineering Technician', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000011', 'Civil Engineering Technician', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000012', 'Materials Technician', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true)
ON CONFLICT (user_id, role_name) DO NOTHING;
*/

-- ========================================================================================
-- PHASE 4: VERIFY IMPLEMENTATION
-- ========================================================================================

-- Verification queries for role_definitions table
SELECT
  'Civil Engineering Role Definitions Count' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'Chief Civil Engineer' OR role_name LIKE 'Civil Engineering Manager' OR role_name LIKE 'Project Civil Engineer' OR role_name LIKE 'Senior Civil Engineer' OR role_name LIKE 'Civil Engineer' OR role_name LIKE 'Materials Engineer' OR role_name LIKE 'Civil Engineering Technician' OR role_name LIKE 'Materials Technician'

UNION ALL

SELECT
  'Active Civil Engineering Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE (role_name LIKE 'Chief Civil Engineer' OR role_name LIKE 'Civil Engineering Manager' OR role_name LIKE 'Project Civil Engineer' OR role_name LIKE 'Senior Civil Engineer' OR role_name LIKE 'Civil Engineer' OR role_name LIKE 'Materials Engineer' OR role_name LIKE 'Civil Engineering Technician' OR role_name LIKE 'Materials Technician')
AND is_active = true

UNION ALL

SELECT
  'Total Permissions Defined' as metric,
  SUM(jsonb_array_length(permissions)) as value
FROM public.role_definitions
WHERE role_name LIKE 'Chief Civil Engineer' OR role_name LIKE 'Civil Engineering Manager' OR role_name LIKE 'Project Civil Engineer' OR role_name LIKE 'Senior Civil Engineer' OR role_name LIKE 'Civil Engineer' OR role_name LIKE 'Materials Engineer' OR role_name LIKE 'Civil Engineering Technician' OR role_name LIKE 'Materials Technician';

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
  'CIVIL_ENGINEERING_ROLES_IMPLEMENTED',
  'role_definitions',
  'system-admin',
  NULL,
  jsonb_build_object(
    'implementation_type', 'department_roles_setup',
    'department_code', '00850',
    'department_name', 'Civil Engineering',
    'roles_implemented', 8,
    'permissions_implemented', 30,
    'implementation_procedure', '01300_USER_ROLES_IMPLEMENTATION_PROCEDURE.md',
    'timestamp', NOW()
  )
);

-- ========================================================================================
-- IMPLEMENTATION COMPLETE
-- ========================================================================================
-- Civil Engineering department roles and permissions have been successfully implemented
-- according to the User Roles Implementation Procedure.
--
-- Verification Results Expected:
-- - Civil Engineering Role Definitions Count: 8
-- - Active Civil Engineering Roles: 8
-- - Total Permissions Defined: 30
--
-- Next Steps:
-- 1. Test role assignments and permissions
-- 2. Verify RLS policies are working correctly
-- 3. Update master roles permissions index
-- 4. Train Civil Engineering team on new permissions
-- ========================================================================================
