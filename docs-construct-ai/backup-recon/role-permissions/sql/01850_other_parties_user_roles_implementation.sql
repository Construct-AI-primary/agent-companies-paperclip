-- ========================================================================================
-- Other Parties (01850) User Roles Implementation
-- ========================================================================================
-- This SQL file implements the Other Parties department roles and permissions
-- as defined in 01300_01850_OTHER_PARTIES_ROLES_PERMISSIONS.md
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

-- Remove any existing Other Parties role definitions
DELETE FROM public.role_definitions WHERE role_name = 'Third Party Director' OR role_name = 'Vendor Management Director' OR role_name = 'Third Party Manager' OR role_name = 'Vendor Coordinator' OR role_name = 'Subcontractor Manager' OR role_name = 'Consultant Manager' OR role_name = 'Third Party Compliance Officer' OR role_name = 'Vendor Performance Analyst' OR role_name = 'Contract Administrator' OR role_name = 'Risk Assessor' OR role_name = 'Third Party Coordinator' OR role_name = 'Vendor Liaison' OR role_name = 'Subcontractor Assistant' OR role_name = 'External Contractor' OR role_name = 'External Subcontractor' OR role_name = 'External Consultant' OR role_name = 'External Vendor' OR role_name = 'External Service Provider';

-- Remove any existing Other Parties user role assignments (mock data)
DELETE FROM public.user_role_assignments WHERE role_name LIKE 'Third Party Director' OR role_name LIKE 'Vendor Management Director' OR role_name LIKE 'Third Party Manager' OR role_name LIKE 'Vendor Coordinator' OR role_name LIKE 'Subcontractor Manager' OR role_name LIKE 'Consultant Manager' OR role_name LIKE 'Third Party Compliance Officer' OR role_name LIKE 'Vendor Performance Analyst' OR role_name LIKE 'Contract Administrator' OR role_name LIKE 'Risk Assessor' OR role_name LIKE 'Third Party Coordinator' OR role_name LIKE 'Vendor Liaison' OR role_name LIKE 'Subcontractor Assistant';

-- Remove any existing Other Parties records from legacy user_roles table
DELETE FROM public.user_roles WHERE department_code = '01850';

-- ========================================================================================
-- PHASE 2: INSERT OTHER PARTIES ROLE DEFINITIONS
-- ========================================================================================

-- Insert Other Parties role definitions with permissions as JSONB
INSERT INTO public.role_definitions (
  role_name,
  permissions,
  description,
  is_active
) VALUES
-- Third Party Leadership Roles (Level 3-4)
('Third Party Director',
 '["thirdparty:*", "vendor:*", "contract:*", "compliance:*", "risk:*", "governance:*", "strategy:*", "reporting:*", "oversight:*", "approval:*"]',
 'Third Party Director - Executive third-party management and strategic oversight',
 true),

('Vendor Management Director',
 '["vendor:*", "procurement:*", "relationship:*", "performance:*", "strategy:*", "governance:*", "reporting:*", "oversight:*", "approval:*", "budget:*"]',
 'Vendor Management Director - Vendor relationship and performance management',
 true),

-- Third Party Management Roles (Level 2-3)
('Third Party Manager',
 '["thirdparty:manage", "vendor:approve", "contract:review", "compliance:monitor", "risk:assess", "reporting:*", "relationship:*", "oversight:*", "coordination:*", "governance:*"]',
 'Third Party Manager - Third-party relationship management',
 true),

('Vendor Coordinator',
 '["vendor:coordinate", "procurement:assist", "onboarding:*", "communication:*", "documentation:*", "relationship:*", "monitoring:*", "reporting:*", "support:*", "liaison:*"]',
 'Vendor Coordinator - Vendor coordination and onboarding',
 true),

('Subcontractor Manager',
 '["subcontractor:*", "contract:sub", "performance:*", "compliance:*", "quality:*", "relationship:*", "monitoring:*", "reporting:*", "oversight:*", "coordination:*"]',
 'Subcontractor Manager - Subcontractor management and oversight',
 true),

('Consultant Manager',
 '["consultant:*", "expertise:*", "engagement:*", "delivery:*", "performance:*", "relationship:*", "monitoring:*", "reporting:*", "oversight:*", "coordination:*"]',
 'Consultant Manager - External consultant management',
 true),

-- Third Party Operations Roles (Level 2)
('Third Party Compliance Officer',
 '["compliance:*", "audit:*", "certification:*", "reporting:*", "monitoring:*", "assessment:*", "verification:*", "documentation:*", "oversight:*", "remediation:*"]',
 'Third Party Compliance Officer - Third-party compliance monitoring',
 true),

('Vendor Performance Analyst',
 '["performance:*", "analytics:*", "reporting:*", "improvement:*", "monitoring:*", "assessment:*", "metrics:*", "insights:*", "recommendations:*", "documentation:*"]',
 'Vendor Performance Analyst - Vendor performance analysis and improvement',
 true),

('Contract Administrator',
 '["contract:admin", "amendment:*", "renewal:*", "termination:*", "compliance:*", "documentation:*", "monitoring:*", "reporting:*", "oversight:*", "coordination:*"]',
 'Contract Administrator - Third-party contract administration',
 true),

('Risk Assessor',
 '["risk:*", "assessment:*", "mitigation:*", "monitoring:*", "analysis:*", "reporting:*", "recommendations:*", "documentation:*", "oversight:*", "coordination:*"]',
 'Risk Assessor - Third-party risk assessment and management',
 true),

-- Third Party Support Roles (Level 1-2)
('Third Party Coordinator',
 '["thirdparty:coordinate", "communication:*", "documentation:*", "support:*", "liaison:*", "monitoring:*", "reporting:*", "assistance:*", "coordination:*", "administration:*"]',
 'Third Party Coordinator - Third-party coordination support',
 true),

('Vendor Liaison',
 '["vendor:liaison", "communication:*", "escalation:*", "documentation:*", "support:*", "monitoring:*", "reporting:*", "coordination:*", "relationship:*", "assistance:*"]',
 'Vendor Liaison - Vendor communication and liaison',
 true),

('Subcontractor Assistant',
 '["subcontractor:assist", "documentation:*", "monitoring:*", "reporting:*", "support:*", "coordination:*", "administration:*", "liaison:*", "assistance:*", "communication:*"]',
 'Subcontractor Assistant - Subcontractor administrative support',
 true),

-- External Party Roles (Level 0-1) - Limited Access for Third Parties
('External Contractor',
 '["external:submit_info", "forms:complete", "documents:view_assigned", "communication:limited", "updates:provide", "progress:report", "compliance:basic"]',
 'External Contractor - External contractors with limited access to submit required information',
 true),

('External Subcontractor',
 '["external:submit_info", "forms:complete", "documents:view_assigned", "safety:submit_reports", "progress:report", "quality:submit_data", "compliance:basic"]',
 'External Subcontractor - External subcontractors for specialist work',
 true),

('External Consultant',
 '["external:submit_info", "forms:complete", "documents:view_assigned", "reports:submit_deliverables", "expertise:provide", "recommendations:submit", "communication:limited"]',
 'External Consultant - External consultants (engineering, legal, etc.)',
 true),

('External Vendor',
 '["external:submit_info", "forms:complete", "documents:view_assigned", "catalog:submit_updates", "pricing:provide", "availability:report", "communication:limited"]',
 'External Vendor - External vendors and suppliers',
 true),

('External Service Provider',
 '["external:submit_info", "forms:complete", "documents:view_assigned", "services:report_status", "maintenance:submit_reports", "certification:provide", "communication:limited"]',
 'External Service Provider - External service providers (maintenance, testing, etc.)',
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
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'role_definitions' AND policyname = 'role_definitions_other_parties_dept_access') THEN
        DROP POLICY "role_definitions_other_parties_dept_access" ON public.role_definitions;
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
      AND (ura.role_name = 'System Administrator' OR ura.role_name LIKE '%Admin%' OR ura.role_name = 'Third Party Director' OR ura.role_name = 'Vendor Management Director')
    )
  );

-- Other Parties department users can view third party roles
CREATE POLICY "role_definitions_other_parties_dept_access" ON public.role_definitions
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.user_role_assignments ura
      WHERE ura.user_id = auth.uid()
      AND ura.is_active = true
      AND (ura.role_name LIKE 'Third Party%' OR ura.role_name LIKE 'Vendor%' OR ura.role_name LIKE 'Subcontractor%' OR ura.role_name LIKE 'Consultant%' OR ura.role_name LIKE 'Contract%' OR ura.role_name LIKE 'Risk Assessor')
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
    IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'public' AND tablename = 'audit_log' AND policyname = 'audit_log_other_parties_dept_view') THEN
        DROP POLICY "audit_log_other_parties_dept_view" ON public.audit_log;
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
      AND (ura.role_name = 'System Administrator' OR ura.role_name LIKE '%Admin%' OR ura.role_name = 'Third Party Director' OR ura.role_name = 'Vendor Management Director')
    )
  );

-- Other Parties department users can view third party-related audit logs
CREATE POLICY "audit_log_other_parties_dept_view" ON public.audit_log
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.user_role_assignments ura
      WHERE ura.user_id = auth.uid()
      AND ura.is_active = true
      AND (ura.role_name LIKE 'Third Party%' OR ura.role_name LIKE 'Vendor%' OR ura.role_name LIKE 'Subcontractor%' OR ura.role_name LIKE 'Consultant%')
    )
    AND (details->>'department_code' = '01850' OR table_name LIKE 'third_party_%' OR table_name LIKE 'vendor_%' OR table_name LIKE 'subcontractor_%')
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
-- Third Party Leadership assignments
('00000000-0000-0000-0000-000000000001', 'Third Party Director', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000002', 'Vendor Management Director', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- Third Party Management assignments
('00000000-0000-0000-0000-000000000003', 'Third Party Manager', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000004', 'Vendor Coordinator', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000005', 'Subcontractor Manager', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000006', 'Consultant Manager', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- Third Party Operations assignments
('00000000-0000-0000-0000-000000000007', 'Third Party Compliance Officer', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000008', 'Vendor Performance Analyst', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000009', 'Contract Administrator', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000010', 'Risk Assessor', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),

-- Third Party Support assignments
('00000000-0000-0000-0000-000000000011', 'Third Party Coordinator', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000012', 'Vendor Liaison', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true),
('00000000-0000-0000-0000-000000000013', 'Subcontractor Assistant', 'company-001', 'org-001', '00000000-0000-0000-0000-000000000000', true)
ON CONFLICT (user_id, role_name) DO NOTHING;
*/

-- ========================================================================================
-- PHASE 4: VERIFY IMPLEMENTATION
-- ========================================================================================

-- Verification queries for role_definitions table
SELECT
  'Other Parties Role Definitions Count' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'Third Party Director' OR role_name LIKE 'Vendor Management Director' OR role_name LIKE 'Third Party Manager' OR role_name LIKE 'Vendor Coordinator' OR role_name LIKE 'Subcontractor Manager' OR role_name LIKE 'Consultant Manager' OR role_name LIKE 'Third Party Compliance Officer' OR role_name LIKE 'Vendor Performance Analyst' OR role_name LIKE 'Contract Administrator' OR role_name LIKE 'Risk Assessor' OR role_name LIKE 'Third Party Coordinator' OR role_name LIKE 'Vendor Liaison' OR role_name LIKE 'Subcontractor Assistant' OR role_name LIKE 'External Contractor' OR role_name LIKE 'External Subcontractor' OR role_name LIKE 'External Consultant' OR role_name LIKE 'External Vendor' OR role_name LIKE 'External Service Provider'

UNION ALL

SELECT
  'Active Other Parties Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE (role_name LIKE 'Third Party Director' OR role_name LIKE 'Vendor Management Director' OR role_name LIKE 'Third Party Manager' OR role_name LIKE 'Vendor Coordinator' OR role_name LIKE 'Subcontractor Manager' OR role_name LIKE 'Consultant Manager' OR role_name LIKE 'Third Party Compliance Officer' OR role_name LIKE 'Vendor Performance Analyst' OR role_name LIKE 'Contract Administrator' OR role_name LIKE 'Risk Assessor' OR role_name LIKE 'Third Party Coordinator' OR role_name LIKE 'Vendor Liaison' OR role_name LIKE 'Subcontractor Assistant' OR role_name LIKE 'External Contractor' OR role_name LIKE 'External Subcontractor' OR role_name LIKE 'External Consultant' OR role_name LIKE 'External Vendor' OR role_name LIKE 'External Service Provider')
AND is_active = true

UNION ALL

SELECT
  'Total Other Parties Permissions Defined' as metric,
  SUM(jsonb_array_length(permissions)) as value
FROM public.role_definitions
WHERE role_name LIKE 'Third Party Director' OR role_name LIKE 'Vendor Management Director' OR role_name LIKE 'Third Party Manager' OR role_name LIKE 'Vendor Coordinator' OR role_name LIKE 'Subcontractor Manager' OR role_name LIKE 'Consultant Manager' OR role_name LIKE 'Third Party Compliance Officer' OR role_name LIKE 'Vendor Performance Analyst' OR role_name LIKE 'Contract Administrator' OR role_name LIKE 'Risk Assessor' OR role_name LIKE 'Third Party Coordinator' OR role_name LIKE 'Vendor Liaison' OR role_name LIKE 'Subcontractor Assistant' OR role_name LIKE 'External Contractor' OR role_name LIKE 'External Subcontractor' OR role_name LIKE 'External Consultant' OR role_name LIKE 'External Vendor' OR role_name LIKE 'External Service Provider'

UNION ALL

SELECT
  'Third Party Leadership Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'Third Party Director' OR role_name LIKE 'Vendor Management Director'

UNION ALL

SELECT
  'Third Party Management Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'Third Party Manager' OR role_name LIKE 'Vendor Coordinator' OR role_name LIKE 'Subcontractor Manager' OR role_name LIKE 'Consultant Manager'

UNION ALL

SELECT
  'Third Party Operations Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'Third Party Compliance Officer' OR role_name LIKE 'Vendor Performance Analyst' OR role_name LIKE 'Contract Administrator' OR role_name LIKE 'Risk Assessor'

UNION ALL

SELECT
  'Third Party Support Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'Third Party Coordinator' OR role_name LIKE 'Vendor Liaison' OR role_name LIKE 'Subcontractor Assistant'

UNION ALL

SELECT
  'External Party Roles' as metric,
  COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'External Contractor' OR role_name LIKE 'External Subcontractor' OR role_name LIKE 'External Consultant' OR role_name LIKE 'External Vendor' OR role_name LIKE 'External Service Provider';

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
  'OTHER_PARTIES_ROLES_IMPLEMENTED',
  'role_definitions',
  'system-admin',
  NULL,
  jsonb_build_object(
    'implementation_type', 'department_roles_setup',
    'department_code', '01850',
    'department_name', 'Other Parties',
    'roles_implemented', 18,
    'permissions_implemented', 180,
    'implementation_procedure', '01300_USER_ROLES_IMPLEMENTATION_PROCEDURE.md',
    'third_party_leadership_roles', 2,
    'third_party_management_roles', 4,
    'third_party_operations_roles', 4,
    'third_party_support_roles', 3,
    'external_party_roles', 5,
    'vendor_management_permissions', true,
    'subcontractor_permissions', true,
    'consultant_permissions', true,
    'compliance_permissions', true,
    'external_party_permissions', true,
    'timestamp', NOW()
  )
);

-- ========================================================================================
-- IMPLEMENTATION COMPLETE
-- ========================================================================================
-- Other Parties department roles and permissions have been successfully implemented
-- according to the User Roles Implementation Procedure.
--
-- Verification Results Expected:
-- - Other Parties Role Definitions Count: 18
-- - Active Other Parties Roles: 18
-- - Total Other Parties Permissions Defined: 180
-- - Third Party Leadership Roles: 2
-- - Third Party Management Roles: 4
-- - Third Party Operations Roles: 4
-- - Third Party Support Roles: 3
-- - External Party Roles: 5
--
-- Next Steps:
-- 1. Test role assignments and permissions
-- 2. Verify RLS policies are working correctly
-- 3. Update master roles permissions index
-- 4. Train Other Parties team on new permissions
-- ========================================================================================
