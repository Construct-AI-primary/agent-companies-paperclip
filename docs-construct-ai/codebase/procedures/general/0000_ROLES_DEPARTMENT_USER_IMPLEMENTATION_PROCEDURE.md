---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
---

# 01300 Department User Roles Implementation Procedure

## Overview

This document establishes the corrected and comprehensive procedure for implementing user roles and permissions for new departments. It addresses all issues encountered during the Human Resources (01500) department implementation and provides standardized best practices to prevent schema errors, incomplete implementations, and security gaps.

**🔗 Cross-References to Related Procedures:**

**Security & Access Control Procedures:**
- → `0000_USER_ROLES_IMPLEMENTATION_PROCEDURE.md` → Foundation user roles and permissions framework that this procedure extends
- → `0000_AGENT_ROLES_IMPLEMENTATION_PROCEDURE.md` → Agent security and discipline confinement procedures
- → `0000_API_KEY_SECURITY_MIGRATION_PROCEDURE.md` → Authentication and security implementation patterns

**System Maintenance & Troubleshooting:**
- → `0000_DEBUGGING_GUIDE.md` → Advanced debugging techniques for role implementation and RLS policy issues
- → `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` → Framework for diagnosing department role setup problems
- → `docs/0000_MASTER_DATABASE_SCHEMA.md` → Database schema reference for understanding role and permission table structures

## Version History

- **v1.0 (2025-12-11)**: Initial comprehensive procedure covering all implementation pitfalls and solutions

## Prerequisites

### 1. Schema Understanding Required
**CRITICAL**: Before implementation, the developer MUST fully understand the actual database schema:

```sql
-- VERIFY: role_definitions table structure
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'role_definitions' AND table_schema = 'public'
ORDER BY ordinal_position;

-- CONFIRM: Does NOT have department_code column
-- CONFIRM: Permissions stored as JSONB, not separate table
-- CONFIRM: No role_permissions table exists
```

### 2. Table Existence Verification
**CRITICAL**: Verify all tables referenced in permissions actually exist:

```sql
-- Check for HR tables BEFORE implementing security
SELECT tablename
FROM pg_tables
WHERE schemaname = 'public'
  AND tablename IN ('job_descriptions', 'cv_applications', 'cv_analyses');
```

## Phase 1: Schema Analysis & Documentation

### Step 1.1: Complete Schema Mapping
```bash
# Create comprehensive schema snapshot
./scripts/create-schema-snapshot.md

# Document all table relationships
./scripts/map-table-relationships.md

# Verify RLS policy patterns from existing implementations
./scripts/audit-rls-policies.md
```

### Step 1.2: Document Department-Specific Tables
**MANDATORY**: List all tables requiring RLS policies and their relationships:

```markdown
## Department Tables Requiring RLS

| Table | Purpose | RLS Level | Access Control |
|-------|---------|-----------|----------------|
| job_descriptions | Job postings | Level 1+ | HR department + published to all |
| cv_applications | CV submissions | Level 1+ | HR department only |
| cv_analyses | AI analysis results | Level 2+ | HR specialists only (sensitive data) |
```

### Step 1.3: Verify User Roles Table
**CRITICAL**: Confirm user roles are assigned via `user_roles` table, not `role_definitions`:

```sql
-- Confirm user role assignment pattern
SELECT
    ur.user_id,
    ur.role,
    ur.department_code,
    ur.level,
    rd.permissions
FROM user_roles ur
JOIN role_definitions rd ON ur.role = rd.role_name
WHERE ur.department_code = '01500'
LIMIT 5;
```

## Phase 2: Table Creation (if needed)

### Step 2.1: Create Department Tables FIRST
**ABSOLUTELY CRITICAL**: Create tables BEFORE attempting RLS policies:

```sql
-- Phase 0: CREATE TABLES FIRST
-- Include in SQL file before any ALTER TABLE ENABLE RLS

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

-- Add indexes post-creation if needed
CREATE INDEX IF NOT EXISTS idx_job_descriptions_status ON job_descriptions(status);
CREATE INDEX IF NOT EXISTS idx_job_descriptions_department ON job_descriptions(department);
```

### Step 2.2: Verify Table Creation
```sql
-- IMMEDIATE verification after creation
SELECT
    schemaname,
    tablename,
    tableowner
FROM pg_tables
WHERE schemaname = 'public'
  AND tablename IN ('job_descriptions', 'cv_applications', 'cv_analyses')
ORDER BY tablename;
```

## Phase 3: Role Definitions Implementation

### Step 3.1: Clean Existing Roles
```sql
-- SAFE cleanup - only remove exact role names, no wildcards
DELETE FROM public.role_definitions
WHERE role_name IN (
    'HR Director',
    'HR Manager',
    'Talent Acquisition Manager',
    'HR Coordinator',
    'Recruitment Specialist'
    -- FULL LIST of roles to be replaced
);
```

### Step 3.2: Insert Role Definitions
**CORRECTED**: No department_code field in role_definitions:

```sql
INSERT INTO public.role_definitions (
    role_name,
    description,
    permissions,
    created_at
) VALUES
(
    'HR Director',
    'Executive HR leadership...',
    '["hr:*", "recruitment:approve_final"]'::jsonb,
    NOW()
);
-- Additional roles...
```

### Step 3.3: Verify Role Insertion
```sql
-- Immediate verification
SELECT
    role_name,
    jsonb_array_length(permissions) as permission_count,
    permissions
FROM public.role_definitions
WHERE role_name LIKE 'HR%'
ORDER BY role_name;
```

## Phase 4: RLS Policies Implementation

### Step 4.1: Enable RLS on Department Tables
**ONLY AFTER tables exist**:

```sql
-- ENABLE RLS AFTER table creation
ALTER TABLE public.job_descriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cv_applications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cv_analyses ENABLE ROW LEVEL SECURITY;
```

### Step 4.2: Policy Cleanup Pattern
```sql
-- SAFE policy cleanup with existence checks
DO $$
BEGIN
    -- Drop policies individually with checks
    IF EXISTS (SELECT 1 FROM pg_policies
               WHERE schemaname = 'public'
               AND tablename = 'job_descriptions'
               AND policyname = 'hr_job_descriptions_access') THEN
        DROP POLICY "hr_job_descriptions_access" ON public.job_descriptions;
    END IF;
END $$;
```

### Step 4.3: Department-Specific RLS Policies
```sql
-- Department access - uses user_roles table for department check
CREATE POLICY "hr_job_descriptions_access" ON public.job_descriptions
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM user_roles ur
      WHERE ur.user_id = auth.uid()::text
      AND ur.department_code = '01500'
    )
  );

-- Specialized level-based access for sensitive data
CREATE POLICY "hr_cv_analyses_access" ON public.cv_analyses
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM user_roles ur
      WHERE ur.user_id = auth.uid()::text
      AND ur.department_code = '01500'
      AND ur.level >= 2
    )
  );
```

### Step 4.4: Public Access Policies (when applicable)
```sql
-- Published jobs visible to all authenticated users
CREATE POLICY "published_jobs_view" ON public.job_descriptions
  FOR SELECT USING (status = 'active' AND auth.role() = 'authenticated');
```

### Step 4.5: Verify RLS Implementation
```sql
-- Comprehensive RLS verification
SELECT
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual
FROM pg_policies
WHERE schemaname = 'public'
  AND tablename IN ('job_descriptions', 'cv_applications', 'cv_analyses')
ORDER BY tablename, policyname;
```

## Phase 5: Verification & Testing

### Step 5.1: Complete Schema Verification
```sql
-- Comprehensive verification query
WITH department_check AS (
  SELECT '01500' as department_code
)
SELECT
    'Role Definitions Count' as metric,
    COUNT(*) as value
FROM public.role_definitions
WHERE role_name LIKE 'HR%' OR role_name LIKE 'Recruitment%'
OR role_name LIKE 'CV%' OR role_name LIKE '%Description%'

UNION ALL

SELECT
    'Tables with RLS Enabled' as metric,
    COUNT(*) as value
FROM information_schema.tables t
WHERE t.table_schema = 'public'
  AND t.table_name IN ('job_descriptions', 'cv_applications', 'cv_analyses')
  AND EXISTS (
    SELECT 1 FROM pg_class c
    WHERE c.relname = t.table_name
    AND c.relrowsecurity = true
  )

UNION ALL

SELECT
    'RLS Policies Created' as metric,
    COUNT(*) as value
FROM pg_policies
WHERE schemaname = 'public'
  AND tablename IN ('job_descriptions', 'cv_applications', 'cv_analyses')

UNION ALL

SELECT
    'Total Permissions Defined' as metric,
    SUM(jsonb_array_length(permissions)) as value
FROM public.role_definitions
WHERE role_name LIKE 'HR%' OR role_name LIKE 'Recruitment%'
OR role_name LIKE 'CV%' OR role_name LIKE '%Description%';
```

### Step 5.2: Function Testing
```sql
-- Test permission checking works
SELECT
    role_name,
    'cv:analyze' as permission,
    permissions ? 'cv:analyze' as has_permission
FROM public.role_definitions
WHERE permissions ? 'cv:analyze'
ORDER BY role_name;
```

## Phase 6: Audit Logging

### Step 6.1: Corrected Audit Log Format
```sql
-- FIXED audit log implementation
INSERT INTO public.audit_log (
    action,
    table_name,
    user_id,
    record_id,
    details
) VALUES (
    'DEPARTMENT_ROLES_IMPLEMENTATION',
    'role_definitions',
    'system-admin',
    NULL,
    jsonb_build_object(
        'department_code', '01500',
        'department_name', 'Human Resources',
        'roles_implemented', 12,
        'tables_secured', 3,
        'rls_policies_created', 4,
        'permissions_total', 46,
        'implementation_file', '01500_human_resources_user_roles_implementation.sql',
        'timestamp', NOW()
    )
);
```

## Common Pitfalls & Solutions

### ❌ Pitfall 1: Missing Table Creation
**Symptom**: `ERROR: relation "public.cv_analyses" does not exist`
**Solution**: Add `CREATE TABLE IF NOT EXISTS` statements BEFORE RLS ALTERs

### ❌ Pitfall 2: Wrong Column Names
**Symptom**: `ERROR: column "timestamp" of relation "audit_log" does not exist`
**Solution**: Check actual audit_log columns: `id`, `action`, `table_name`, `user_id`, `record_id`, `details`, `created_at`

### ❌ Pitfall 3: Non-existent role_permissions Table
**Symptom**: Reference to `role_permissions` table not found
**Solution**: All permissions stored as JSONB in `role_definitions.permissions` column

### ❌ Pitfall 4: department_code in role_definitions
**Symptom**: Column doesn't exist error when inserting
**Solution**: Remove `department_code` from role_definitions INSERT - department context comes from `user_roles` assignments

### ❌ Pitfall 5: Incomplete RLS Implementation
**Symptom**: Roles defined but no data access control
**Solution**: Always implement BOTH role_definitions AND RLS policies on department tables

## Implementation Checklist

### Pre-Implementation
- [ ] Verified actual database schema (no assumptions)
- [ ] Confirmed all referenced tables exist or documented creation plan
- [ ] Mapped user role assignment patterns (user_roles table)
- [ ] Documented all department-specific tables requiring RLS

### Table Creation Phase
- [ ] Created all necessary tables BEFORE RLS policies
- [ ] Added appropriate indexes
- [ ] Verified table creation with schema queries

### Role Definition Phase
- [ ] Cleaned existing roles safely (exact name matches)
- [ ] Inserted roles WITHOUT department_code field
- [ ] Stored permissions as JSONB arrays
- [ ] Verified role creation with permission checks

### Security Implementation Phase
- [ ] Enabled RLS on all department-specific tables
- [ ] Dropped existing policies safely with existence checks
- [ ] Created appropriate department-level access policies
- [ ] Added level-based restrictions for sensitive data
- [ ] Included public access policies where applicable

### Verification Phase
- [ ] Complete schema verification (roles, tables, policies)
- [ ] Function testing of permission checking logic
- [ ] RLS policy verification queries
- [ ] Data access testing (can department members access data?)

### Documentation Phase
- [ ] Updated master roles permissions index
- [ ] Created department-specific roles permissions document
- [ ] Added implementation to department master guide
- [ ] Logged implementation details in audit table

## Testing Strategy

### Unit Testing
```sql
-- Test permission functions
SELECT *
FROM test_role_permissions('CV Analyst', 'cv:analyze'); -- Should return true

-- Test department access
SELECT *
FROM test_department_access('user-123', '01500', 'cv_applications'); -- Should return true for HR users
```

### Integration Testing
```sql
-- Test full workflow
BEGIN;
  -- Create test job
  INSERT INTO job_descriptions (title, department, created_by, updated_by)
  VALUES ('Test Job', 'Engineering', 'test-user', 'test-user');

  -- Test RLS access for HR user
  SET LOCAL auth.uid = 'hr-user-456';
  SELECT * FROM job_descriptions; -- Should return test job

  -- Test RLS deny for non-HR user
  SET LOCAL auth.uid = 'finance-user-789';
  SELECT * FROM job_descriptions; -- Should return no rows
ROLLBACK;
```

### Security Testing
```sql
-- Test level-based restrictions
SET LOCAL auth.uid = 'hr-assistant-level1';
SELECT COUNT(*) FROM cv_analyses; -- Should return 0 (level >= 2 required)

SET LOCAL auth.uid = 'cv-analyst-level2';
SELECT COUNT(*) FROM cv_analyses; -- Should return actual count
```

## Rollback Procedures

### Role Definitions Rollback
```sql
-- Safe rollback
DELETE FROM public.role_definitions
WHERE role_name IN ('HR Director', 'HR Manager', ... );

-- Restore previous roles if needed
-- INSERT backup data...
```

### RLS Policies Rollback
```sql
-- Drop new policies
DROP POLICY IF EXISTS "hr_job_descriptions_access" ON public.job_descriptions;
DROP POLICY IF EXISTS "hr_cv_applications_access" ON public.cv_applications;
DROP POLICY IF EXISTS "hr_cv_analyses_access" ON public.cv_analyses;

-- Disable RLS if needed
ALTER TABLE public.job_descriptions DISABLE ROW LEVEL SECURITY;
```

### Complete Implementation Rollback
```sql
-- Emergency full rollback
BEGIN;
  -- Roles
  DELETE FROM role_definitions WHERE role_name LIKE 'HR%' OR role_name LIKE 'Recruitment%';

  -- RLS policies
  DROP POLICY IF EXISTS "hr_%_access" ON job_descriptions;
  DROP POLICY IF EXISTS "hr_%_access" ON cv_applications;
  DROP POLICY IF EXISTS "hr_%_access" ON cv_analyses;

  -- Tables (optional - keep data)
  -- DROP TABLE IF EXISTS cv_analyses;

  -- Audit
  DELETE FROM audit_log WHERE action = 'DEPARTMENT_ROLES_IMPLEMENTATION';
COMMIT;
```

## Monitoring & Maintenance

### Post-Implementation Monitoring
- Monitor for RLS policy violations in application logs
- Track permission check performance
- Watch for new department-specific tables requiring policies

### Update Procedures
- Document all role/permission changes
- Test RLS policies after schema changes
- Update master permissions index
- Audit log all modifications

### Performance Considerations
- Index frequently queried columns used in RLS policies
- Monitor JSONB permission queries for optimization
- Consider caching for frequently checked permissions

## Related Documentation

- [01300_00000_MASTER_ROLES_PERMISSIONS_INDEX.md](../role-permissions/01300_00000_MASTER_ROLES_PERMISSIONS_INDEX.md) - Master roles index
- [01300_01500_HUMAN_RESOURCES_ROLES_PERMISSIONS.md](../role-permissions/01300_01500_HUMAN_RESOURCES_ROLES_PERMISSIONS.md) - HR permissions documentation
- [0000_DATABASE_SCHEMA_REFERENCE.md](../database-systems/0000_DATABASE_SCHEMA_REFERENCE.md) - Database schema reference
- [0020_RLS_IMPLEMENTATION_PROGRESS_TRACKING.md](../authentication/0020_RLS_IMPLEMENTATION_PROGRESS_TRACKING.md) - RLS implementation tracking

## Emergency Contacts

- **Schema Issues**: Check database schema documentation
- **RLS Problems**: Consult authentication master guide
- **Permission Errors**: Verify role definitions and user assignments
- **Rollback Required**: Use emergency rollback procedures above

---

**IMPLEMENTATION NOTE**: This procedure was developed after encountering multiple schema errors during the HR department implementation. Following this comprehensive approach prevents all the pitfalls that caused significant debugging time and incomplete security implementations.
