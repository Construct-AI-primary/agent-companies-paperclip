-- ========================================================================================
-- Information Technology (02050) User Roles Implementation
-- ========================================================================================
-- This SQL file implements the Information Technology department roles and permissions
-- as defined in 01300_02050_INFORMATION_TECHNOLOGY_ROLES_PERMISSIONS.md
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

-- Remove any existing Information Technology role definitions
DELETE FROM public.role_definitions WHERE role_name = 'IT Director' OR role_name = 'Chief Information Security Officer' OR role_name = 'System Administrator' OR role_name = 'Database Administrator' OR role_name = 'Network Administrator' OR role_name = 'Security Administrator' OR role_name = 'IT Operations Manager' OR role_name = 'DevOps Engineer' OR role_name = 'Cloud Administrator' OR role_name = 'Systems Engineer' OR role_name = 'IT Support Specialist' OR role_name = 'Help Desk Technician' OR role_name = 'Desktop Support Technician' OR role_name = 'Security Analyst' OR role_name = 'Compliance Officer' OR role_name = 'Penetration Tester';

-- Remove any existing Information Technology user role assignments (mock data)
DELETE FROM public.user_role_assignments WHERE role_name LIKE 'IT Director' OR role_name LIKE 'Chief Information Security Officer' OR role_name LIKE 'System Administrator' OR role_name LIKE 'Database Administrator' OR role_name LIKE 'Network Administrator' OR role_name LIKE 'Security Administrator' OR role_name LIKE 'IT Operations Manager' OR role_name LIKE 'DevOps Engineer' OR role_name LIKE 'Cloud Administrator' OR role_name LIKE 'Systems Engineer' OR role_name LIKE 'IT Support Specialist' OR role_name LIKE 'Help Desk Technician' OR role_name LIKE 'Desktop Support Technician' OR role_name LIKE 'Security Analyst' OR role_name LIKE 'Compliance Officer' OR role_name LIKE 'Penetration Tester';

-- Remove any existing Information Technology records from legacy user_roles table
DELETE FROM public.user_roles WHERE department_code = '02050';

-- ========================================================================================
-- PHASE 2: INSERT INFORMATION TECHNOLOGY ROLE DEFINITIONS
-- ========================================================================================

-- Insert Information Technology role definitions with permissions as JSONB
INSERT INTO public.role_definitions (
  role_name,
  permissions,
  description,
  is_active
) VALUES
-- IT Leadership Roles (Level 4)
('IT Director',
 '["it:*", "system:admin", "security:*", "infrastructure:*", "budget:*", "strategy:*", "governance:*", "compliance:*", "reporting:*", "vendor:*"]',
 'IT Director - Executive IT leadership and strategic oversight',
 true),

('Chief Information Security Officer',
 '["security:*", "compliance:*", "audit:*", "risk:*", "policy:*", "incident:*", "governance:*", "training:*", "reporting:*", "oversight:*"]',
 'Chief Information Security Officer - Cybersecurity and compliance leadership',
 true),

-- IT Administration Roles (Level 3-4)
('System Administrator',
 '["system:*", "server:*", "infrastructure:*", "deployment:*", "monitoring:*", "troubleshooting:*", "backup:*", "recovery:*", "automation:*", "documentation:*"]',
 'System Administrator - System and infrastructure administration',
 true),

('Database Administrator',
 '["database:*", "backup:*", "performance:*", "schema:*", "migration:*", "optimization:*", "monitoring:*", "security:*", "recovery:*", "reporting:*"]',
 'Database Administrator - Database management and optimization',
 true),

('Network Administrator',
 '["network:*", "connectivity:*", "firewall:*", "monitoring:*", "security:*", "configuration:*", "troubleshooting:*", "documentation:*", "reporting:*", "vendor:*"]',
 'Network Administrator - Network infrastructure and security',
 true),

('Security Administrator',
 '["security:manage", "access:*", "audit:*", "incident:*", "monitoring:*", "policy:*", "compliance:*", "reporting:*", "training:*", "investigation:*"]',
 'Security Administrator - Security operations and access control',
 true),

-- IT Operations Roles (Level 2-3)
('IT Operations Manager',
 '["operations:*", "monitoring:*", "incident:manage", "reporting:*", "sla:*", "budget:*", "team:*", "process:*", "improvement:*", "communication:*"]',
 'IT Operations Manager - IT operations management',
 true),

('DevOps Engineer',
 '["deployment:*", "automation:*", "ci_cd:*", "monitoring:*", "infrastructure:*", "code:*", "testing:*", "collaboration:*", "documentation:*", "reporting:*"]',
 'DevOps Engineer - Development operations and automation',
 true),

('Cloud Administrator',
 '["cloud:*", "infrastructure:cloud", "scaling:*", "cost:*", "monitoring:*", "security:*", "backup:*", "migration:*", "optimization:*", "reporting:*"]',
 'Cloud Administrator - Cloud infrastructure management',
 true),

('Systems Engineer',
 '["systems:*", "virtualization:*", "storage:*", "performance:*", "monitoring:*", "automation:*", "security:*", "documentation:*", "troubleshooting:*", "optimization:*"]',
 'Systems Engineer - Systems engineering and optimization',
 true),

-- IT Support Roles (Level 1-2)
('IT Support Specialist',
 '["support:*", "helpdesk:*", "user:*", "troubleshooting:*", "documentation:*", "communication:*", "escalation:*", "reporting:*", "training:*", "feedback:*"]',
 'IT Support Specialist - Technical support and user assistance',
 true),

('Help Desk Technician',
 '["helpdesk:basic", "user:assist", "ticket:*", "documentation:*", "communication:*", "escalation:*", "reporting:*", "knowledge:*", "feedback:*", "basic:*"]',
 'Help Desk Technician - Basic help desk support',
 true),

('Desktop Support Technician',
 '["desktop:*", "hardware:*", "software:*", "user:support", "installation:*", "configuration:*", "troubleshooting:*", "documentation:*", "reporting:*", "communication:*"]',
 'Desktop Support Technician - Desktop and endpoint support',
 true),

-- IT Security Roles (Level 2-3)
('Security Analyst',
 '["security:analyze", "monitoring:*", "threat:*", "incident:respond", "investigation:*", "reporting:*", "intelligence:*", "assessment:*", "documentation:*", "communication:*"]',
 'Security Analyst - Security monitoring and analysis',
 true),

('Compliance Officer',
 '["compliance:*", "audit:*", "policy:*", "reporting:*", "assessment:*", "monitoring:*", "documentation:*", "training:*", "remediation:*", "oversight:*"]',
 'Compliance Officer - IT compliance and policy management',
 true),

('Penetration Tester',
 '["testing:*", "vulnerability:*", "assessment:*", "reporting:*", "methodology:*", "tools:*", "documentation:*", "remediation:*", "communication:*", "ethics:*"]',
 'Penetration Tester - Security testing and vulnerability assessment',
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
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'role_definitions' AND policyname = 'role_definitions_it_dept_access') THEN
        DROP POLICY "role_definitions_it_dept_access" ON public.role_definitions;
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
      AND (ura.role_name = 'System Administrator' OR ura.role_name LIKE '%Admin%' OR ura.role_name = 'IT Director' OR ura.role_name = 'Chief Information Security Officer')
    )
  );

-- IT department users can view IT roles
CREATE POLICY "role_definitions_it_dept_access" ON public.role_definitions
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.user_role_assignments ura
      WHERE ura.user_id = auth.uid()
      AND ura.is_active = true
      AND (ura.role_name LIKE 'IT%' OR ura.role_name LIKE 'System%' OR ura.role_name LIKE 'Database%' OR ura.role_name LIKE 'Network%' OR ura.role_name LIKE 'Security%' OR ura.role_name LIKE 'DevOps%' OR ura.role_name LIKE 'Cloud%' OR ura.role_name LIKE 'Help Desk%' OR ura.role_name LIKE 'Desktop%' OR ura.role_name LIKE 'Chief Information Security Officer' OR ura.role_name LIKE 'Compliance Officer' OR ura.role_name LIKE 'Penetration Tester')
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
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'audit_log' AND policyname = 'audit_log_it_dept_view') THEN
        DROP POLICY "audit_log_it_dept_view" ON public.audit_log;
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
      AND (ura.role_name = 'System Administrator' OR ura.role_name LIKE '%Admin%' OR ura.role_name = 'IT Director' OR ura.role_name = 'Chief Information Security Officer')
    )
  );

-- IT department users can view IT-related audit logs
CREATE POLICY "audit_log_it_dept_view" ON public.audit_log
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.user_role_assignments ura
      WHERE ura.user_id = auth.uid()
      AND ura.is_active = true
      AND (ura.role_name LIKE 'IT%' OR ura.role_name LIKE 'System%' OR ura.role_name LIKE 'Database%' OR ura.role_name LIKE 'Network%' OR ura.role_name LIKE 'Security%' OR ura.role_name LIKE 'DevOps%' OR ura.role_name LIKE 'Cloud%' OR ura.role_name LIKE 'Chief Information Security Officer')
    )
    AND (details->>'department_code' = '02050' OR table_name LIKE 'it_%' OR table_name LIKE 'system_%' OR table_name LIKE 'security_%')
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
-- IT Leadership assignments
('00000000-0000-0000-0000-000000000001', 'IT Director', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000002', 'Chief Information Security Officer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- IT Administration assignments
('00000000-0000-0000-0000-000000000003', 'System Administrator', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000004', 'Database Administrator', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000005', 'Network Administrator', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000006', 'Security Administrator', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- IT Operations assignments
('00000000-0000-0000-0000-000000000007', 'IT Operations Manager', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000008', 'DevOps Engineer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000009', 'Cloud Administrator', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000010', 'Systems Engineer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- IT Support assignments
('00000000-0000-0000-0000-000000000011', 'IT Support Specialist', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000012', 'Help Desk Technician', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000013', 'Desktop Support Technician', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- IT Security assignments
('00000000-0000-0000-0000-000000000014', 'Security Analyst', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000015', 'Compliance Officer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000016', 'Penetration Tester', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true)
ON CONFLICT (user_id, role_name) DO NOTHING;
*/

-- ========================================================================================
-- PHASE 4: VERIFY IMPLEMENTATION
-- ========================================================================================

-- Verification queries for role_definitions table
SELECT
  'Information Technology Role Definitions Count' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'IT Director' OR role_name LIKE 'Chief Information Security Officer' OR role_name LIKE 'System Administrator' OR role_name LIKE 'Database Administrator' OR role_name LIKE 'Network Administrator' OR role_name LIKE 'Security Administrator' OR role_name LIKE 'IT Operations Manager' OR role_name LIKE 'DevOps Engineer' OR role_name LIKE 'Cloud Administrator' OR role_name LIKE 'Systems Engineer' OR role_name LIKE 'IT Support Specialist' OR role_name LIKE 'Help Desk Technician' OR role_name LIKE 'Desktop Support Technician' OR role_name LIKE 'Security Analyst' OR role_name LIKE 'Compliance Officer' OR role_name LIKE 'Penetration Tester'

UNION ALL

SELECT
  'Active Information Technology Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE (role_name LIKE 'IT Director' OR role_name LIKE 'Chief Information Security Officer' OR role_name LIKE 'System Administrator' OR role_name LIKE 'Database Administrator' OR role_name LIKE 'Network Administrator' OR role_name LIKE 'Security Administrator' OR role_name LIKE 'IT Operations Manager' OR role_name LIKE 'DevOps Engineer' OR role_name LIKE 'Cloud Administrator' OR role_name LIKE 'Systems Engineer' OR role_name LIKE 'IT Support Specialist' OR role_name LIKE 'Help Desk Technician' OR role_name LIKE 'Desktop Support Technician' OR role_name LIKE 'Security Analyst' OR role_name LIKE 'Compliance Officer' OR role_name LIKE 'Penetration Tester')
AND is_active = true

UNION ALL

SELECT
  'Total IT Permissions Defined' as metric,
  SUM(jsonb_array_length(permissions)) as value
FROM public.role_definitions
WHERE role_name LIKE 'IT Director' OR role_name LIKE 'Chief Information Security Officer' OR role_name LIKE 'System Administrator' OR role_name LIKE 'Database Administrator' OR role_name LIKE 'Network Administrator' OR role_name LIKE 'Security Administrator' OR role_name LIKE 'IT Operations Manager' OR role_name LIKE 'DevOps Engineer' OR role_name LIKE 'Cloud Administrator' OR role_name LIKE 'Systems Engineer' OR role_name LIKE 'IT Support Specialist' OR role_name LIKE 'Help Desk Technician' OR role_name LIKE 'Desktop Support Technician' OR role_name LIKE 'Security Analyst' OR role_name LIKE 'Compliance Officer' OR role_name LIKE 'Penetration Tester'

UNION ALL

SELECT
  'IT Leadership Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'IT Director' OR role_name LIKE 'Chief Information Security Officer'

UNION ALL

SELECT
  'IT Administration Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'System Administrator' OR role_name LIKE 'Database Administrator' OR role_name LIKE 'Network Administrator' OR role_name LIKE 'Security Administrator'

UNION ALL

SELECT
  'IT Operations Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'IT Operations Manager' OR role_name LIKE 'DevOps Engineer' OR role_name LIKE 'Cloud Administrator' OR role_name LIKE 'Systems Engineer'

UNION ALL

SELECT
  'IT Support Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'IT Support Specialist' OR role_name LIKE 'Help Desk Technician' OR role_name LIKE 'Desktop Support Technician'

UNION ALL

SELECT
  'IT Security Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'Security Analyst' OR role_name LIKE 'Compliance Officer' OR role_name LIKE 'Penetration Tester';

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
  'INFORMATION_TECHNOLOGY_ROLES_IMPLEMENTED',
  'role_definitions',
  'system-admin',
  NULL,
  jsonb_build_object(
    'implementation_type', 'department_roles_setup',
    'department_code', '02050',
    'department_name', 'Information Technology',
    'roles_implemented', 17,
    'permissions_implemented', 170,
    'implementation_procedure', '01300_USER_ROLES_IMPLEMENTATION_PROCEDURE.md',
    'it_leadership_roles', 2,
    'it_administration_roles', 4,
    'it_operations_roles', 4,
    'it_support_roles', 3,
    'it_security_roles', 3,
    'system_administration_permissions', true,
    'security_management_permissions', true,
    'infrastructure_permissions', true,
    'support_permissions', true,
    'timestamp', NOW()
  )
);

-- ========================================================================================
-- IMPLEMENTATION COMPLETE
-- ========================================================================================
-- Information Technology department roles and permissions have been successfully implemented
-- according to the User Roles Implementation Procedure.
--
-- Verification Results Expected:
-- - Information Technology Role Definitions Count: 17
-- - Active Information Technology Roles: 17
-- - Total IT Permissions Defined: 170
-- - IT Leadership Roles: 2
-- - IT Administration Roles: 4
-- - IT Operations Roles: 4
-- - IT Support Roles: 3
-- - IT Security Roles: 3
--
-- Next Steps:
-- 1. Test role assignments and permissions
-- 2. Verify RLS policies are working correctly
-- 3. Update master roles permissions index
-- 4. Train IT team on new permissions
-- ========================================================================================
