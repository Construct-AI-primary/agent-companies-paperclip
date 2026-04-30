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

# 0000_USER_ROLES_IMPLEMENTATION_PROCEDURE.md

## Overview

This document provides a comprehensive procedure for implementing the `user_roles` table and aligning it with policies, access restrictions, and authentication systems. This procedure ensures secure role-based access control (RBAC) implementation across the ConstructAI platform, integrating with Supabase authentication and Row Level Security (RLS) policies.

## Requirements

### Prerequisites
- Supabase project with authentication enabled
- Database administrator access
- Understanding of PostgreSQL and RLS policies
- Familiarity with JWT token structure and claims
- Access to authentication and role-permissions documentation

### Discipline-Specific Role Assignment Rules

**CRITICAL REQUIREMENT**: Each discipline's role permissions document must contain ONLY roles for that specific discipline. Cross-discipline role assignments are strictly prohibited.

#### Discipline Definition
- Disciplines are defined by page names from the [Page List Documentation](../pages-disciplines/1300_00000_PAGE_LIST.md)
- Each discipline has a unique department_code (e.g., 01300 for Governance, 02400 for Safety)
- Role permissions files follow the naming convention: `01300_{DEPARTMENT_CODE}_{DISCIPLINE_NAME}_ROLES_PERMISSIONS.md`

#### Role Assignment Constraints
1. **Strict Discipline Isolation**: A discipline's role file (e.g., 01300_01300_TEMPLATE_MANAGEMENT) may only contain roles with department_code = '01300'
2. **No Cross-Discipline Roles**: Roles from other disciplines (e.g., Safety roles in Procurement file) are not permitted
3. **Department Code Validation**: All roles in a discipline file must match the file's department code prefix
4. **Template Management Exception**: Governance (01300) manages templates for all disciplines but defines only its own operational roles

#### Permission-Based Role Architecture
- **Role Definitions Table**: `public.role_definitions` stores roles with JSONB permissions arrays
- **User Role Assignments**: `public.user_roles` links users to roles with department context
- **Explicit Permissions**: Each role has explicitly defined permissions (no implicit level hierarchies)
- **JSONB Permission Checking**: RLS policies use `permissions ? 'permission_name'` for access control

#### Examples of Correct vs Incorrect Role Assignments

**CORRECT - Safety HSE Roles (01300_02400_SAFETY_HSE_ROLES_PERMISSIONS.md):**
- ✅ HSE Director (02400) with `["hse:*", "contractor:approve_final", "incident:investigate_critical"]`
- ✅ Safety Officer (02400) with `["safety:inspect", "training:conduct", "incident:report"]`
- ✅ Environmental Officer (02400) with `["environmental:monitor", "permit:process"]`

**INCORRECT - Template Management Roles (01300_01300_TEMPLATE_MANAGEMENT_ROLES_PERMISSIONS.md):**
- ❌ Safety Template Designer (02400) - Cross-discipline role
- ❌ Procurement Template Designer (01900) - Cross-discipline role
- ✅ Template Designer (01300) with `["template:create", "template:edit_own", "template:preview"]`

### System Components Involved
- **Supabase Database**: Core data storage and RLS enforcement
- **Supabase Auth**: User authentication and JWT token management
- **Application Server**: API endpoints and business logic
- **Client Applications**: User interface and role-based feature access
- **Security Dashboard**: Role management and policy monitoring

## Database Schema Analysis

### Schema Extraction Queries

Before implementing user roles, always extract and analyze the current database schema to understand table structures, relationships, and existing constraints.

#### Extract All User Roles Related Tables
```sql
-- Get all tables related to user roles and permissions
SELECT
  schemaname,
  tablename,
  tableowner,
  tablespace,
  hasindexes,
  hasrules,
  hastriggers,
  rowsecurity
FROM pg_tables
WHERE schemaname = 'public'
  AND (tablename LIKE '%role%'
       OR tablename LIKE '%user%'
       OR tablename LIKE '%permission%'
       OR tablename LIKE '%auth%'
       OR tablename LIKE '%audit%')
ORDER BY tablename;
```

#### Extract Table Schema Details
```sql
-- Function to get complete table schema
CREATE OR REPLACE FUNCTION get_table_schema(table_name text)
RETURNS TABLE (
  column_name text,
  data_type text,
  is_nullable text,
  column_default text,
  character_maximum_length integer,
  numeric_precision integer,
  numeric_scale integer,
  ordinal_position integer
)
LANGUAGE sql
AS $$
  SELECT
    c.column_name,
    c.data_type,
    c.is_nullable,
    c.column_default,
    c.character_maximum_length,
    c.numeric_precision,
    c.numeric_scale,
    c.ordinal_position
  FROM information_schema.columns c
  WHERE c.table_schema = 'public'
    AND c.table_name = table_name
  ORDER BY c.ordinal_position;
$$;

-- Get schema for key tables
SELECT * FROM get_table_schema('user_roles');
SELECT * FROM get_table_schema('role_definitions');
SELECT * FROM get_table_schema('user_role_assignments');
SELECT * FROM get_table_schema('role_permissions');
SELECT * FROM get_table_schema('audit_log');
```

#### Extract Indexes and Constraints
```sql
-- Get indexes for user roles tables
SELECT
  schemaname,
  tablename,
  indexname,
  indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND (tablename LIKE '%role%'
       OR tablename LIKE '%user%'
       OR tablename LIKE '%permission%'
       OR tablename LIKE '%auth%'
       OR tablename LIKE '%audit%')
ORDER BY tablename, indexname;

-- Get constraints for user roles tables
SELECT
  tc.table_schema,
  tc.table_name,
  tc.constraint_name,
  tc.constraint_type,
  cc.column_name,
  rc.unique_constraint_name,
  rc.match_option,
  rc.update_rule,
  rc.delete_rule
FROM information_schema.table_constraints tc
LEFT JOIN information_schema.key_column_usage cc
  ON tc.constraint_name = cc.constraint_name
  AND tc.table_schema = cc.table_schema
LEFT JOIN information_schema.referential_constraints rc
  ON tc.constraint_name = rc.constraint_name
  AND tc.table_schema = rc.table_schema
WHERE tc.table_schema = 'public'
  AND (tc.table_name LIKE '%role%'
       OR tc.table_name LIKE '%user%'
       OR tc.table_name LIKE '%permission%'
       OR tc.table_name LIKE '%auth%'
       OR tc.table_name LIKE '%audit%')
ORDER BY tc.table_name, tc.constraint_name;
```

#### Extract Row Level Security Policies
```sql
-- Get RLS policies for user roles tables
SELECT
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd,
  qual,
  with_check
FROM pg_policies
WHERE schemaname = 'public'
  AND (tablename LIKE '%role%'
       OR tablename LIKE '%user%'
       OR tablename LIKE '%permission%'
       OR tablename LIKE '%auth%'
       OR tablename LIKE '%audit%')
ORDER BY tablename, policyname;
```

#### Extract Functions and Triggers
```sql
-- Get functions related to user roles
SELECT
  n.nspname as schema_name,
  p.proname as function_name,
  pg_get_function_identity_arguments(p.oid) as arguments,
  obj_description(p.oid, 'pg_proc') as description
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public'
  AND (p.proname LIKE '%role%'
       OR p.proname LIKE '%user%'
       OR p.proname LIKE '%permission%'
       OR p.proname LIKE '%auth%'
       OR p.proname LIKE '%audit%')
ORDER BY function_name;

-- Get triggers for user roles tables
SELECT
  event_object_schema,
  event_object_table,
  trigger_name,
  event_manipulation,
  action_timing,
  action_statement
FROM information_schema.triggers
WHERE event_object_schema = 'public'
  AND (event_object_table LIKE '%role%'
       OR event_object_table LIKE '%user%'
       OR event_object_table LIKE '%permission%'
       OR event_object_table LIKE '%auth%'
       OR event_object_table LIKE '%audit%')
ORDER BY event_object_table, trigger_name;
```

#### Extract Existing Role Data
```sql
-- Analyze existing role data
SELECT
  'user_roles_count' as metric,
  COUNT(*) as value
FROM user_roles

UNION ALL

SELECT
  'role_definitions_count' as metric,
  COUNT(*) as value
FROM role_definitions

UNION ALL

SELECT
  'user_role_assignments_count' as metric,
  COUNT(*) as value
FROM user_role_assignments

UNION ALL

SELECT
  'role_permissions_count' as metric,
  COUNT(*) as value
FROM role_permissions

UNION ALL

SELECT
  'audit_log_count' as metric,
  COUNT(*) as value
FROM audit_log;

-- Get role distribution by department
SELECT
  department_code,
  COUNT(*) as role_count,
  STRING_AGG(DISTINCT role, ', ') as roles
FROM user_roles
GROUP BY department_code
ORDER BY department_code;

-- Get permission distribution by role
SELECT
  role_name,
  COUNT(*) as permission_count,
  STRING_AGG(permission, ', ' ORDER BY permission) as permissions
FROM role_permissions
GROUP BY role_name
ORDER BY role_name;
```

#### Generate Schema Documentation
```sql
-- Generate comprehensive schema documentation
CREATE OR REPLACE FUNCTION generate_schema_documentation()
RETURNS text
LANGUAGE plpgsql
AS $$
DECLARE
  result text := '';
  table_record record;
  column_record record;
  policy_record record;
BEGIN
  result := result || '# Database Schema Documentation' || E'\n\n';
  result := result || 'Generated: ' || now()::text || E'\n\n';

  -- Tables section
  result := result || '## Tables' || E'\n\n';

  FOR table_record IN
    SELECT tablename
    FROM pg_tables
    WHERE schemaname = 'public'
      AND (tablename LIKE '%role%'
           OR tablename LIKE '%user%'
           OR tablename LIKE '%permission%'
           OR tablename LIKE '%auth%'
           OR tablename LIKE '%audit%')
    ORDER BY tablename
  LOOP
    result := result || '### ' || table_record.tablename || E'\n\n';

    -- Columns
    result := result || '#### Columns' || E'\n\n';
    result := result || '| Column | Type | Nullable | Default |' || E'\n';
    result := result || '|--------|------|----------|---------|' || E'\n';

    FOR column_record IN
      SELECT
        column_name,
        data_type,
        is_nullable,
        COALESCE(column_default, '') as column_default
      FROM information_schema.columns
      WHERE table_schema = 'public'
        AND table_name = table_record.tablename
      ORDER BY ordinal_position
    LOOP
      result := result || '| ' || column_record.column_name || ' | ' ||
                          column_record.data_type || ' | ' ||
                          column_record.is_nullable || ' | ' ||
                          column_record.column_default || ' |' || E'\n';
    END LOOP;

    result := result || E'\n';

    -- RLS Policies
    result := result || '#### Row Level Security Policies' || E'\n\n';

    FOR policy_record IN
      SELECT policyname, cmd, qual
      FROM pg_policies
      WHERE schemaname = 'public'
        AND tablename = table_record.tablename
      ORDER BY policyname
    LOOP
      result := result || '**' || policy_record.policyname || '**: ' ||
                          policy_record.cmd || E'\n\n';
      IF policy_record.qual IS NOT NULL THEN
        result := result || '```sql' || E'\n' || policy_record.qual || E'\n```\n\n';
      END IF;
    END LOOP;

    result := result || E'\n---\n\n';
  END LOOP;

  RETURN result;
END;
$$;

-- Generate and display schema documentation
SELECT generate_schema_documentation();
```

### Schema Validation Checklist

Before implementing user roles, validate the following:

- [ ] **Tables Exist**: All required tables are created
- [ ] **Columns Match**: Column names and types are correct
- [ ] **Constraints**: Primary keys, foreign keys, and unique constraints
- [ ] **Indexes**: Performance indexes are in place
- [ ] **RLS Enabled**: Row Level Security is enabled on appropriate tables
- [ ] **Policies**: RLS policies are correctly defined
- [ ] **Functions**: Required functions exist and are accessible
- [ ] **Triggers**: Audit and metadata triggers are configured
- [ ] **Permissions**: Service role has appropriate access
- [ ] **Data Integrity**: Existing data follows schema constraints

## Implementation

### Phase 1: Database Schema Implementation

#### Step 1: Create user_roles Table

**Execute SQL Migration:**
```sql
-- Create user_roles table with proper constraints and indexes
CREATE TABLE IF NOT EXISTS public.user_roles (
  id uuid NOT NULL DEFAULT extensions.uuid_generate_v4(),
  user_id text NOT NULL,
  role text NOT NULL,
  department_code text NULL,
  level integer NULL DEFAULT 1,
  created_at timestamp with time zone NULL DEFAULT now(),
  organization_id uuid NULL,
  CONSTRAINT user_roles_pkey PRIMARY KEY (id)
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_user_roles_user_id ON public.user_roles USING btree (user_id);
CREATE INDEX IF NOT EXISTS idx_user_roles_department ON public.user_roles USING btree (department_code);
CREATE INDEX IF NOT EXISTS idx_user_roles_level ON public.user_roles USING btree (level);
CREATE INDEX IF NOT EXISTS idx_user_roles_organization ON public.user_roles USING btree (organization_id);

-- Enable Row Level Security
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;
```

**Verification:**
```sql
-- Verify table creation
\d public.user_roles

-- Check indexes
\di idx_user_roles_*

-- Confirm RLS is enabled
SELECT schemaname, tablename, rowsecurity
FROM pg_tables
WHERE tablename = 'user_roles';
```

#### Step 2: Implement Core RLS Policies

**User Access Policy:**
```sql
-- Users can view their own roles
CREATE POLICY "users_can_view_own_roles" ON public.user_roles
  FOR SELECT USING (auth.uid()::text = user_id);

-- Service role has full access for management
CREATE POLICY "service_role_full_access" ON public.user_roles
  FOR ALL USING (auth.role() = 'service_role');
```

**Administrative Access Policy:**
```sql
-- Department managers can view roles in their department
CREATE POLICY "department_managers_access" ON public.user_roles
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      WHERE ur.user_id = auth.uid()::text
      AND ur.level >= 3
      AND ur.department_code = user_roles.department_code
    )
  );

-- System administrators have full access
CREATE POLICY "system_admin_full_access" ON public.user_roles
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      WHERE ur.user_id = auth.uid()::text
      AND ur.level = 4
    )
  );
```

### Phase 2: Authentication Integration

#### Step 3: Configure JWT Claims

**Supabase Auth Configuration:**
```sql
-- Create function to get user roles for JWT claims
CREATE OR REPLACE FUNCTION auth.get_user_roles(user_uuid uuid)
RETURNS jsonb
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT jsonb_build_object(
    'roles', jsonb_agg(
      jsonb_build_object(
        'role', role,
        'department_code', department_code,
        'level', level,
        'organization_id', organization_id
      )
    )
  )
  FROM public.user_roles
  WHERE user_id = user_uuid::text;
$$;

-- Update auth.users metadata with roles
CREATE OR REPLACE FUNCTION auth.update_user_metadata()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = auth
AS $$
BEGIN
  UPDATE auth.users
  SET raw_user_meta_data = raw_user_meta_data || auth.get_user_roles(NEW.id::uuid)
  WHERE id = NEW.id;

  RETURN NEW;
END;
$$;

-- Create trigger for automatic metadata updates
CREATE TRIGGER on_user_role_change
  AFTER INSERT OR UPDATE OR DELETE ON public.user_roles
  FOR EACH ROW EXECUTE FUNCTION auth.update_user_metadata();
```

#### Step 4: Implement Role-Based Authentication Middleware

**Server-Side Role Checking:**
```javascript
// middleware/auth.js
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_KEY);

const requireRole = (requiredLevel, departmentCode = null) => {
  return async (req, res, next) => {
    try {
      const token = req.headers.authorization?.replace('Bearer ', '');

      if (!token) {
        return res.status(401).json({ error: 'No authorization token provided' });
      }

      const { data: { user }, error } = await supabase.auth.getUser(token);

      if (error || !user) {
        return res.status(401).json({ error: 'Invalid token' });
      }

      // Get user roles from database
      const { data: roles, error: roleError } = await supabase
        .from('user_roles')
        .select('*')
        .eq('user_id', user.id);

      if (roleError) {
        console.error('Role lookup error:', roleError);
        return res.status(500).json({ error: 'Role verification failed' });
      }

      // Check if user has required level
      const hasRequiredLevel = roles.some(role => {
        const levelCheck = role.level >= requiredLevel;
        const departmentCheck = !departmentCode || role.department_code === departmentCode;
        return levelCheck && departmentCheck;
      });

      if (!hasRequiredLevel) {
        return res.status(403).json({
          error: 'Insufficient permissions',
          required: { level: requiredLevel, department: departmentCode }
        });
      }

      req.user = user;
      req.userRoles = roles;
      next();

    } catch (error) {
      console.error('Auth middleware error:', error);
      res.status(500).json({ error: 'Authentication error' });
    }
  };
};

module.exports = { requireRole };
```

### Phase 3: Role Management Implementation

#### Step 5: Create Role Assignment Functions

**Role Assignment Function:**
```sql
-- Function to safely assign roles
CREATE OR REPLACE FUNCTION assign_user_role(
  target_user_id text,
  new_role text,
  new_department_code text DEFAULT NULL,
  new_level integer DEFAULT 1,
  new_organization_id uuid DEFAULT NULL,
  assigned_by text DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  result jsonb;
  assigner_level integer;
BEGIN
  -- Check if assigner has permission
  SELECT level INTO assigner_level
  FROM user_roles
  WHERE user_id = assigned_by
  AND level >= 3; -- Must be manager or higher

  IF assigner_level IS NULL THEN
    RETURN jsonb_build_object('success', false, 'error', 'Insufficient permissions to assign roles');
  END IF;

  -- Validate role parameters
  IF new_level < 1 OR new_level > 4 THEN
    RETURN jsonb_build_object('success', false, 'error', 'Invalid role level');
  END IF;

  -- Insert new role
  INSERT INTO user_roles (
    user_id,
    role,
    department_code,
    level,
    organization_id
  ) VALUES (
    target_user_id,
    new_role,
    new_department_code,
    new_level,
    new_organization_id
  );

  -- Log the assignment
  INSERT INTO audit_log (
    action,
    table_name,
    user_id,
    details
  ) VALUES (
    'ROLE_ASSIGNED',
    'user_roles',
    assigned_by,
    jsonb_build_object(
      'target_user', target_user_id,
      'role', new_role,
      'department', new_department_code,
      'level', new_level
    )
  );

  RETURN jsonb_build_object('success', true, 'message', 'Role assigned successfully');

EXCEPTION
  WHEN unique_violation THEN
    RETURN jsonb_build_object('success', false, 'error', 'User already has this role');
  WHEN OTHERS THEN
    RETURN jsonb_build_object('success', false, 'error', SQLERRM);
END;
$$;
```

#### Step 6: Implement Role Validation

**Role Validation Function:**
```sql
-- Function to validate role combinations
CREATE OR REPLACE FUNCTION validate_role_assignment(
  user_id text,
  role_name text,
  department_code text,
  role_level integer
)
RETURNS jsonb
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
  validation_result jsonb := jsonb_build_object('valid', true, 'warnings', '[]'::jsonb);
BEGIN
  -- Validate level ranges by department
  CASE department_code
    WHEN '01300' THEN -- Governance
      IF role_level > 4 THEN
        validation_result := jsonb_build_object(
          'valid', false,
          'error', 'Governance roles cannot exceed level 4'
        );
      END IF;
    WHEN '02050' THEN -- IT
      IF role_level > 4 THEN
        validation_result := jsonb_build_object(
          'valid', false,
          'error', 'IT roles cannot exceed level 4'
        );
      END IF;
    WHEN '02400' THEN -- Safety
      IF role_level > 3 THEN
        validation_result := jsonb_build_object(
          'valid', false,
          'error', 'Safety roles cannot exceed level 3'
        );
      END IF;
    ELSE
      -- Standard validation for other departments
      IF role_level > 3 THEN
        validation_result := jsonb_build_object(
          'valid', false,
          'error', 'Department roles cannot exceed level 3'
        );
      END IF;
  END CASE;

  -- Check for conflicting roles
  IF role_level = 4 AND department_code IS NOT NULL THEN
    validation_result := jsonb_set(
      validation_result,
      '{warnings}',
      (validation_result->'warnings')::jsonb || jsonb_build_array(
        'Level 4 roles should not be department-specific'
      )
    );
  END IF;

  RETURN validation_result;
END;
$$;
```

### Phase 4: Access Control Integration

#### Step 7: Implement Permission Checking

**Permission Checking Function:**
```sql
-- Function to check specific permissions
CREATE OR REPLACE FUNCTION has_permission(
  user_id text,
  required_permission text,
  resource_department text DEFAULT NULL,
  resource_level integer DEFAULT NULL
)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM user_roles ur
    LEFT JOIN role_permissions rp ON ur.role = rp.role_name
    WHERE ur.user_id = user_id
    AND rp.permission = required_permission
    AND (resource_department IS NULL OR ur.department_code = resource_department)
    AND (resource_level IS NULL OR ur.level >= resource_level)
  );
$$;

-- Create role_permissions table
CREATE TABLE IF NOT EXISTS public.role_permissions (
  id uuid NOT NULL DEFAULT extensions.uuid_generate_v4(),
  role_name text NOT NULL,
  permission text NOT NULL,
  created_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT role_permissions_pkey PRIMARY KEY (id),
  CONSTRAINT role_permissions_unique UNIQUE (role_name, permission)
);

-- Insert default permissions
INSERT INTO role_permissions (role_name, permission) VALUES
  ('System Administrator', 'user:manage_roles'),
  ('System Administrator', 'system:configure'),
  ('Template Manager', 'template:approve'),
  ('Template Manager', 'template:publish'),
  ('Safety Officer', 'contractor:vet'),
  ('Procurement Manager', 'contract:approve')
ON CONFLICT (role_name, permission) DO NOTHING;
```

#### Step 8: Create Access Control Middleware

**API Access Control:**
```javascript
// middleware/accessControl.js
const checkPermission = (permission, options = {}) => {
  return async (req, res, next) => {
    try {
      const userId = req.user?.id;
      if (!userId) {
        return res.status(401).json({ error: 'User not authenticated' });
      }

      // Check permission using database function
      const { data, error } = await supabase.rpc('has_permission', {
        user_id: userId,
        required_permission: permission,
        resource_department: options.department,
        resource_level: options.minLevel
      });

      if (error) {
        console.error('Permission check error:', error);
        return res.status(500).json({ error: 'Permission verification failed' });
      }

      if (!data) {
        return res.status(403).json({
          error: 'Insufficient permissions',
          required: permission,
          context: options
        });
      }

      next();

    } catch (error) {
      console.error('Access control error:', error);
      res.status(500).json({ error: 'Access control error' });
    }
  };
};

// Usage examples
app.get('/api/templates',
  requireAuth,
  checkPermission('template:view'),
  getTemplates
);

app.post('/api/templates',
  requireAuth,
  checkPermission('template:create', { department: '01300' }),
  createTemplate
);

app.put('/api/templates/:id/approve',
  requireAuth,
  checkPermission('template:approve', { minLevel: 3 }),
  approveTemplate
);
```

### Phase 5: Security Dashboard Integration

#### Step 9: Create Role Management Interface

**Role Management API:**
```javascript
// routes/roleManagement.js
const express = require('express');
const router = express.Router();

// Get all roles for a user
router.get('/user/:userId/roles', async (req, res) => {
  try {
    const { userId } = req.params;

    // Check if requester has permission to view roles
    const canView = await checkPermission(req.user.id, 'user:view_roles');
    if (!canView) {
      return res.status(403).json({ error: 'Cannot view user roles' });
    }

    const { data: roles, error } = await supabase
      .from('user_roles')
      .select('*')
      .eq('user_id', userId);

    if (error) throw error;

    res.json({ roles });

  } catch (error) {
    console.error('Get user roles error:', error);
    res.status(500).json({ error: 'Failed to get user roles' });
  }
});

// Assign role to user
router.post('/user/:userId/roles', async (req, res) => {
  try {
    const { userId } = req.params;
    const { role, departmentCode, level, organizationId } = req.body;

    // Validate role assignment
    const validation = await supabase.rpc('validate_role_assignment', {
      user_id: userId,
      role_name: role,
      department_code: departmentCode,
      role_level: level
    });

    if (!validation.valid) {
      return res.status(400).json({ error: validation.error });
    }

    // Assign role
    const result = await supabase.rpc('assign_user_role', {
      target_user_id: userId,
      new_role: role,
      new_department_code: departmentCode,
      new_level: level,
      new_organization_id: organizationId,
      assigned_by: req.user.id
    });

    if (!result.success) {
      return res.status(400).json({ error: result.error });
    }

    res.json({ message: 'Role assigned successfully' });

  } catch (error) {
    console.error('Assign role error:', error);
    res.status(500).json({ error: 'Failed to assign role' });
  }
});

// Remove role from user
router.delete('/user/:userId/roles/:roleId', async (req, res) => {
  try {
    const { userId, roleId } = req.params;

    // Check permissions
    const canManage = await checkPermission(req.user.id, 'user:manage_roles');
    if (!canManage) {
      return res.status(403).json({ error: 'Cannot manage user roles' });
    }

    const { error } = await supabase
      .from('user_roles')
      .delete()
      .eq('id', roleId)
      .eq('user_id', userId);

    if (error) throw error;

    res.json({ message: 'Role removed successfully' });

  } catch (error) {
    console.error('Remove role error:', error);
    res.status(500).json({ error: 'Failed to remove role' });
  }
});

module.exports = router;
```

### Phase 6: Testing and Validation

#### Step 10: Create Test Suite

**Role-Based Access Tests:**
```javascript
// tests/roleAccess.test.js
const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_KEY);

describe('User Roles Implementation', () => {
  let testUser;
  let adminUser;

  beforeAll(async () => {
    // Create test users
    const { data: user1 } = await supabase.auth.admin.createUser({
      email: 'testuser@example.com',
      password: 'testpass123'
    });
    testUser = user1.user;

    const { data: user2 } = await supabase.auth.admin.createUser({
      email: 'admin@example.com',
      password: 'adminpass123'
    });
    adminUser = user2.user;

    // Assign roles
    await supabase.from('user_roles').insert([
      { user_id: testUser.id, role: 'Project User', department_code: '01300', level: 1 },
      { user_id: adminUser.id, role: 'System Administrator', level: 4 }
    ]);
  });

  test('User can view own roles', async () => {
    const { data, error } = await supabase
      .from('user_roles')
      .select('*')
      .eq('user_id', testUser.id);

    expect(error).toBeNull();
    expect(data.length).toBeGreaterThan(0);
    expect(data[0].role).toBe('Project User');
  });

  test('User cannot view other users roles without permission', async () => {
    // This should be blocked by RLS
    const { data, error } = await supabase
      .from('user_roles')
      .select('*')
      .eq('user_id', adminUser.id);

    // Should return empty or error due to RLS
    expect(data.length).toBe(0);
  });

  test('Admin can view all roles', async () => {
    // Switch to admin context (in real test, use admin token)
    const { data, error } = await supabase
      .from('user_roles')
      .select('*');

    expect(error).toBeNull();
    expect(data.length).toBeGreaterThan(0);
  });

  test('Permission checking works', async () => {
    const { data: hasPermission } = await supabase.rpc('has_permission', {
      user_id: testUser.id,
      required_permission: 'template:view'
    });

    expect(hasPermission).toBe(true);

    const { data: noPermission } = await supabase.rpc('has_permission', {
      user_id: testUser.id,
      required_permission: 'user:manage_roles'
    });

    expect(noPermission).toBe(false);
  });

  afterAll(async () => {
    // Clean up test data
    await supabase.from('user_roles').delete().eq('user_id', testUser.id);
    await supabase.from('user_roles').delete().eq('user_id', adminUser.id);

    await supabase.auth.admin.deleteUser(testUser.id);
    await supabase.auth.admin.deleteUser(adminUser.id);
  });
});
```

#### Step 11: Implement Monitoring and Auditing

**Audit Logging Setup:**
```sql
-- Create audit log table
CREATE TABLE IF NOT EXISTS public.audit_log (
  id uuid NOT NULL DEFAULT extensions.uuid_generate_v4(),
  action text NOT NULL,
  table_name text NOT NULL,
  user_id text,
  record_id uuid,
  old_values jsonb,
  new_values jsonb,
  ip_address inet,
  user_agent text,
  timestamp timestamp with time zone DEFAULT now(),
  CONSTRAINT audit_log_pkey PRIMARY KEY (id)
);

-- Create audit trigger function
CREATE OR REPLACE FUNCTION audit_trigger_function()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  audit_row audit_log;
  old_row jsonb;
  new_row jsonb;
BEGIN
  IF TG_OP = 'DELETE' THEN
    old_row = row_to_json(OLD)::jsonb;
    new_row = null;
  ELSIF TG_OP = 'UPDATE' THEN
    old_row = row_to_json(OLD)::jsonb;
    new_row = row_to_json(NEW)::jsonb;
  ELSIF TG_OP = 'INSERT' THEN
    old_row = null;
    new_row = row_to_json(NEW)::jsonb;
  END IF;

  audit_row = (
    DEFAULT, -- id
    TG_OP, -- action
    TG_TABLE_NAME, -- table_name
    NEW.user_id, -- user_id (adjust based on table structure)
    NEW.id, -- record_id
    old_row, -- old_values
    new_row, -- new_values
    inet_client_addr(), -- ip_address
    current_setting('request.headers', true)::json->>'user-agent', -- user_agent
    now() -- timestamp
  );

  INSERT INTO audit_log VALUES (audit_row.*);

  RETURN COALESCE(NEW, OLD);
END;
$$;

-- Create audit triggers
CREATE TRIGGER audit_user_roles_trigger
  AFTER INSERT OR UPDATE OR DELETE ON public.user_roles
  FOR EACH ROW EXECUTE FUNCTION audit_trigger_function();
```

### Phase 7: Documentation and Training

#### Step 12: Update Documentation

**Cross-Reference Updates:**
- Update `docs/role-permissions/01300_00000_MASTER_ROLES_PERMISSIONS_INDEX.md` with implementation status
- Update `docs/authentication/0020_AUTHENTICATION_OVERVIEW.md` with role integration details
- Update `docs/authentication/0021_RLS_IMPLEMENTATION_GUIDE.md` with user_roles examples

#### Step 13: Create User Training Materials

**Role Management Guide:**
```markdown
# User Roles Management Guide

## Understanding Roles and Permissions

### Role Levels
- **Level 1**: Basic users with limited access
- **Level 2**: Contributors who can create and edit content
- **Level 3**: Managers who can approve and publish
- **Level 4**: Administrators with full system access

### Department-Specific Roles
- **01300 (Governance)**: Template management and approval
- **01900 (Procurement)**: Contract and vendor management
- **00850 (Civil Engineering)**: Design and construction oversight
- **02400 (Safety)**: HSE compliance and contractor vetting

## Managing User Roles

### Assigning Roles
1. Access the Security Dashboard
2. Navigate to User Management
3. Select user and click "Manage Roles"
4. Choose appropriate role and department
5. Save changes

### Best Practices
- Assign minimum necessary permissions
- Regularly review and update roles
- Document role changes in audit logs
- Use department-specific roles when possible
```

## Solution Implementation

### SQL File Storage and Naming Convention

**SQL File Location:**
All department-specific user roles implementation SQL files are stored in:
```
docs/role-permissions/sql/
```

**Standard Naming Convention:**
```
{DEPARTMENT_CODE}_{department_name}_user_roles_implementation.sql
```

**Examples:**
- `00850_civil_engineering_user_roles_implementation.sql`
- `01300_governance_user_roles_implementation.sql`
- `01900_procurement_user_roles_implementation.sql`
- `02400_safety_hse_user_roles_implementation.sql`

**SQL File Structure:**
Each implementation file contains:
1. **PHASE 1**: Cleanup existing mock data
2. **PHASE 2**: Insert department-specific roles
3. **PHASE 3**: Insert department-specific permissions
4. **PHASE 4**: Verification queries
5. **PHASE 5**: Audit logging

### Database Schema Implementation

**Core Infrastructure Files:**
- `database/migrations/001_create_user_roles.sql` - Base table schema
- `database/functions/role_management.sql` - Role management functions
- `database/policies/user_roles_policies.sql` - RLS policies

**Department-Specific Files:**
- `docs/role-permissions/sql/{DEPARTMENT_CODE}_{name}_user_roles_implementation.sql`

### API Implementation

**Files to Create:**
- `server/middleware/auth.js`
- `server/middleware/accessControl.js`
- `server/routes/roleManagement.js`
- `server/services/roleService.js`

### Client Implementation

**Files to Create/Modify:**
- `client/src/services/authService.js`
- `client/src/hooks/usePermissions.js`
- `client/src/components/RoleManagement.jsx`
- `client/src/pages/admin/SecurityDashboard.jsx`

### Testing Implementation

**Test Files to Create:**
- `tests/unit/roleAccess.test.js`
- `tests/integration/userRoles.test.js`
- `tests/e2e/roleManagement.test.js`

## Error Handling & Edge Cases

### Common Issues and Solutions

**RLS Policy Conflicts**
```
Symptom: Users cannot access expected data
Root Cause: Conflicting or overly restrictive RLS policies
Solution: Review policy logic and test with different user contexts
Prevention: Use clear policy naming and comprehensive testing
```

**JWT Token Expiration**
```
Symptom: Authentication failures after role changes
Root Cause: JWT tokens cached with old role information
Solution: Implement token refresh on role changes
Prevention: Set appropriate token expiration times
```

**Permission Inheritance Issues**
```
Symptom: Users lose access after department transfers
Root Cause: Role assignments not updated during transfers
Solution: Implement role transfer procedures
Prevention: Automate role updates based on organizational changes
```

## Phase 8: Bulk Role Management and Synchronization

### Overview

This phase addresses scenarios where users need to perform bulk role operations, such as synchronizing all roles in the app to match external systems, migrating role structures, or performing large-scale role updates. The implementation provides safe, validated bulk operations with comprehensive rollback capabilities.

### Recommendation: Adaptive Bulk Role Management

**APPROACH: Adapt the system to allow bulk role changes with intelligent mapping and restrictions**

Rather than restricting bulk changes (which would prevent legitimate synchronization needs) or simple difference mapping (which lacks safety controls), the recommended approach is:

1. **Allow bulk operations** with proper validation and approval workflows
2. **Implement intelligent mapping** that handles role differences, conflicts, and transformations
3. **Provide safety restrictions** including pre-validation, staged rollouts, and emergency rollback
4. **Require elevated permissions** for bulk operations (Level 4 administrators only)

### Bulk Role Synchronization Architecture

#### Core Components

**Bulk Role Sync Service:**
```javascript
// server/services/bulkRoleSyncService.js
const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_KEY);

class BulkRoleSyncService {
  constructor() {
    this.batchSize = 100;
    this.maxConcurrent = 5;
  }

  async synchronizeRoles(externalRoles, options = {}) {
    const transactionId = this.generateTransactionId();

    try {
      // Phase 1: Validation
      const validation = await this.validateBulkOperation(externalRoles, options);
      if (!validation.valid) {
        throw new Error(`Validation failed: ${validation.errors.join(', ')}`);
      }

      // Phase 2: Create backup
      await this.createRoleBackup(transactionId);

      // Phase 3: Generate mapping plan
      const mappingPlan = await this.generateMappingPlan(externalRoles, options);

      // Phase 4: Execute in batches with progress tracking
      const results = await this.executeBulkSync(mappingPlan, transactionId, options);

      // Phase 5: Verification and cleanup
      await this.verifySyncResults(results, transactionId);

      return {
        success: true,
        transactionId,
        summary: this.generateSyncSummary(results)
      };

    } catch (error) {
      // Emergency rollback
      await this.rollbackSync(transactionId);
      throw error;
    }
  }

  async validateBulkOperation(externalRoles, options) {
    const errors = [];
    const warnings = [];

    // Check permissions
    if (!await this.checkBulkSyncPermission(options.requestedBy)) {
      errors.push('Insufficient permissions for bulk role synchronization');
    }

    // Validate role structure
    for (const role of externalRoles) {
      const roleValidation = await this.validateRoleStructure(role);
      if (!roleValidation.valid) {
        errors.push(`Invalid role ${role.name}: ${roleValidation.errors.join(', ')}`);
      }
    }

    // Check for conflicts
    const conflicts = await this.identifyRoleConflicts(externalRoles);
    if (conflicts.critical.length > 0) {
      errors.push(`Critical conflicts detected: ${conflicts.critical.join(', ')}`);
    }

    // Impact assessment
    const impact = await this.assessSyncImpact(externalRoles);
    if (impact.affectedUsers > options.maxAffectedUsers) {
      errors.push(`Operation would affect ${impact.affectedUsers} users, exceeding limit of ${options.maxAffectedUsers}`);
    }

    return {
      valid: errors.length === 0,
      errors,
      warnings,
      impact
    };
  }

  async generateMappingPlan(externalRoles, options) {
    const plan = {
      create: [],
      update: [],
      deactivate: [],
      conflicts: []
    };

    for (const externalRole of externalRoles) {
      const existingRole = await this.findExistingRole(externalRole);

      if (!existingRole) {
        // New role
        plan.create.push({
          external: externalRole,
          mapped: await this.mapExternalRole(externalRole, options.mappingRules)
        });
      } else if (this.rolesDiffer(existingRole, externalRole)) {
        // Role exists but differs
        const diff = this.calculateRoleDifference(existingRole, externalRole);
        if (diff.isCompatible) {
          plan.update.push({
            existing: existingRole,
            external: externalRole,
            changes: diff.changes
          });
        } else {
          plan.conflicts.push({
            existing: existingRole,
            external: externalRole,
            conflictType: diff.conflictType
          });
        }
      }
    }

    // Identify roles to deactivate
    const rolesToDeactivate = await this.identifyObsoleteRoles(externalRoles);
    plan.deactivate = rolesToDeactivate;

    return plan;
  }

  async executeBulkSync(mappingPlan, transactionId, options) {
    const results = {
      created: 0,
      updated: 0,
      deactivated: 0,
      errors: []
    };

    // Execute creates
    if (mappingPlan.create.length > 0) {
      const createResults = await this.batchExecute(
        mappingPlan.create,
        (role) => this.createRole(role.mapped, transactionId),
        options
      );
      results.created = createResults.successful;
      results.errors.push(...createResults.errors);
    }

    // Execute updates
    if (mappingPlan.update.length > 0) {
      const updateResults = await this.batchExecute(
        mappingPlan.update,
        (role) => this.updateRole(role.existing, role.external, transactionId),
        options
      );
      results.updated = updateResults.successful;
      results.errors.push(...updateResults.errors);
    }

    // Execute deactivations
    if (mappingPlan.deactivate.length > 0) {
      const deactivateResults = await this.batchExecute(
        mappingPlan.deactivate,
        (role) => this.deactivateRole(role, transactionId),
        options
      );
      results.deactivated = deactivateResults.successful;
      results.errors.push(...deactivateResults.errors);
    }

    return results;
  }
}
```

#### Bulk Role Import API

**API Endpoint for Bulk Synchronization:**
```javascript
// server/routes/bulkRoleSync.js
const express = require('express');
const router = express.Router();
const BulkRoleSyncService = require('../services/bulkRoleSyncService');

const bulkSyncService = new BulkRoleSyncService();

// Bulk role synchronization endpoint
router.post('/sync', async (req, res) => {
  try {
    const {
      externalRoles,
      mappingRules = {},
      options = {}
    } = req.body;

    // Default options
    const syncOptions = {
      dryRun: options.dryRun || false,
      maxAffectedUsers: options.maxAffectedUsers || 1000,
      requireApproval: options.requireApproval !== false,
      autoRollback: options.autoRollback !== false,
      requestedBy: req.user.id,
      ...options
    };

    // Validate input
    if (!Array.isArray(externalRoles)) {
      return res.status(400).json({
        error: 'externalRoles must be an array'
      });
    }

    if (externalRoles.length === 0) {
      return res.status(400).json({
        error: 'No roles provided for synchronization'
      });
    }

    // Check permissions
    const hasPermission = await checkPermission(
      req.user.id,
      'role:bulk_sync',
      null,
      4 // Level 4 required
    );

    if (!hasPermission) {
      return res.status(403).json({
        error: 'Bulk role synchronization requires Level 4 administrator privileges'
      });
    }

    // Execute synchronization
    const result = await bulkSyncService.synchronizeRoles(
      externalRoles,
      syncOptions
    );

    // Log the operation
    await logAuditEvent({
      action: 'BULK_ROLE_SYNC',
      userId: req.user.id,
      details: {
        transactionId: result.transactionId,
        summary: result.summary
      }
    });

    res.json({
      success: true,
      ...result
    });

  } catch (error) {
    console.error('Bulk role sync error:', error);

    await logAuditEvent({
      action: 'BULK_ROLE_SYNC_FAILED',
      userId: req.user.id,
      details: {
        error: error.message
      }
    });

    res.status(500).json({
      error: 'Bulk role synchronization failed',
      details: error.message
    });
  }
});

// Get synchronization status
router.get('/sync/:transactionId', async (req, res) => {
  try {
    const { transactionId } = req.params;

    const status = await bulkSyncService.getSyncStatus(transactionId);

    res.json(status);

  } catch (error) {
    console.error('Get sync status error:', error);
    res.status(500).json({
      error: 'Failed to get synchronization status'
    });
  }
});

// Rollback synchronization
router.post('/sync/:transactionId/rollback', async (req, res) => {
  try {
    const { transactionId } = req.params;

    // Check permissions
    const hasPermission = await checkPermission(
      req.user.id,
      'role:bulk_rollback',
      null,
      4
    );

    if (!hasPermission) {
      return res.status(403).json({
        error: 'Bulk rollback requires Level 4 administrator privileges'
      });
    }

    const result = await bulkSyncService.rollbackSync(transactionId);

    await logAuditEvent({
      action: 'BULK_ROLE_ROLLBACK',
      userId: req.user.id,
      details: {
        transactionId,
        result
      }
    });

    res.json({
      success: true,
      ...result
    });

  } catch (error) {
    console.error('Rollback error:', error);
    res.status(500).json({
      error: 'Rollback failed',
      details: error.message
    });
  }
});

module.exports = router;
```

#### Role Mapping and Conflict Resolution

**Intelligent Role Mapping Function:**
```sql
-- Function for intelligent role mapping during bulk sync
CREATE OR REPLACE FUNCTION map_external_role(
  external_role jsonb,
  mapping_rules jsonb DEFAULT '{}'::jsonb
)
RETURNS jsonb
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
  mapped_role jsonb := external_role;
  rule_key text;
  rule_value jsonb;
BEGIN
  -- Apply custom mapping rules first
  FOR rule_key, rule_value IN SELECT * FROM jsonb_object_keys(mapping_rules) k
    CROSS JOIN jsonb_extract_path(mapping_rules, k.jsonb_object_keys) v
  LOOP
    CASE rule_key
      WHEN 'role_name_mapping' THEN
        -- Map role names
        IF external_role ? 'name' AND rule_value ? external_role->>'name' THEN
          mapped_role := jsonb_set(mapped_role, '{name}', rule_value->(external_role->>'name'));
        END IF;
      WHEN 'department_mapping' THEN
        -- Map department codes
        IF external_role ? 'department' AND rule_value ? external_role->>'department' THEN
          mapped_role := jsonb_set(mapped_role, '{department_code}', rule_value->(external_role->>'department'));
        END IF;
      WHEN 'level_mapping' THEN
        -- Map permission levels
        IF external_role ? 'level' AND rule_value ? (external_role->>'level')::text THEN
          mapped_role := jsonb_set(mapped_role, '{level}', rule_value->((external_role->>'level')::text));
        END IF;
      WHEN 'permission_mapping' THEN
        -- Transform permissions
        IF external_role ? 'permissions' THEN
          mapped_role := jsonb_set(mapped_role, '{permissions}',
            transform_permissions(external_role->'permissions', rule_value)
          );
        END IF;
    END CASE;
  END LOOP;

  -- Apply default mappings for common external systems
  mapped_role := apply_default_mappings(mapped_role, external_role);

  -- Validate final mapping
  PERFORM validate_role_mapping(mapped_role);

  RETURN mapped_role;
END;
$$;

-- Function to transform permissions during mapping
CREATE OR REPLACE FUNCTION transform_permissions(
  external_permissions jsonb,
  mapping_rules jsonb
)
RETURNS jsonb
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
  transformed jsonb := '[]'::jsonb;
  ext_perm text;
  mapped_perm text;
BEGIN
  -- Transform each permission
  FOR ext_perm IN SELECT jsonb_array_elements_text(external_permissions)
  LOOP
    -- Check if there's a mapping rule for this permission
    IF mapping_rules ? ext_perm THEN
      mapped_perm := mapping_rules->>ext_perm;
    ELSE
      -- Apply default transformation
      mapped_perm := apply_default_permission_mapping(ext_perm);
    END IF;

    -- Add to transformed permissions if valid
    IF mapped_perm IS NOT NULL AND mapped_perm != '' THEN
      transformed := transformed || jsonb_build_array(mapped_perm);
    END IF;
  END LOOP;

  RETURN transformed;
END;
$$;
```

#### Safety and Validation Measures

**Pre-Sync Validation:**
```sql
-- Comprehensive validation for bulk role operations
CREATE OR REPLACE FUNCTION validate_bulk_role_sync(
  external_roles jsonb,
  options jsonb DEFAULT '{}'::jsonb
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  result jsonb := jsonb_build_object(
    'valid', true,
    'errors', '[]'::jsonb,
    'warnings', '[]'::jsonb,
    'impact_assessment', '{}'::jsonb
  );
  role_data jsonb;
  validation_errors jsonb := '[]'::jsonb;
  validation_warnings jsonb := '[]'::jsonb;
  affected_users integer := 0;
  affected_departments jsonb := '[]'::jsonb;
BEGIN
  -- Validate each external role
  FOR role_data IN SELECT * FROM jsonb_array_elements(external_roles)
  LOOP
    -- Check required fields
    IF NOT (role_data ? 'name' AND role_data ? 'department_code') THEN
      validation_errors := validation_errors || jsonb_build_array(
        format('Role missing required fields: %s', role_data->>'name')
      );
      CONTINUE;
    END IF;

    -- Validate department code exists
    IF NOT EXISTS (
      SELECT 1 FROM department_codes
      WHERE code = role_data->>'department_code'
    ) THEN
      validation_errors := validation_errors || jsonb_build_array(
        format('Invalid department code: %s', role_data->>'department_code')
      );
    END IF;

    -- Validate role level
    IF role_data ? 'level' THEN
      IF (role_data->>'level')::integer NOT BETWEEN 1 AND 4 THEN
        validation_errors := validation_errors || jsonb_build_array(
          format('Invalid role level for %s: %s', role_data->>'name', role_data->>'level')
        );
      END IF;
    END IF;

    -- Check for naming conflicts
    IF EXISTS (
      SELECT 1 FROM role_definitions
      WHERE role_name = role_data->>'name'
      AND department_code != role_data->>'department_code'
    ) THEN
      validation_warnings := validation_warnings || jsonb_build_array(
        format('Role name conflict: %s exists in different department', role_data->>'name')
      );
    END IF;
  END LOOP;

  -- Impact assessment
  SELECT
    COUNT(DISTINCT ur.user_id),
    jsonb_agg(DISTINCT ur.department_code)
  INTO affected_users, affected_departments
  FROM user_roles ur
  WHERE ur.role IN (
    SELECT r->>'name'
    FROM jsonb_array_elements(external_roles) r
  );

  -- Check against limits
  IF affected_users > (options->>'max_affected_users')::integer THEN
    validation_errors := validation_errors || jsonb_build_array(
      format('Operation would affect %s users, exceeding limit of %s',
        affected_users, options->>'max_affected_users')
    );
  END IF;

  -- Build result
  result := jsonb_set(result, '{errors}', validation_errors);
  result := jsonb_set(result, '{warnings}', validation_warnings);
  result := jsonb_set(result, '{impact_assessment}', jsonb_build_object(
    'affected_users', affected_users,
    'affected_departments', affected_departments,
    'risk_level', CASE
      WHEN affected_users > 1000 THEN 'HIGH'
      WHEN affected_users > 100 THEN 'MEDIUM'
      ELSE 'LOW'
    END
  ));

  -- Set validity
  IF jsonb_array_length(validation_errors) > 0 THEN
    result := jsonb_set(result, '{valid}', 'false'::jsonb);
  END IF;

  RETURN result;
END;
$$;
```

#### Bulk Sync User Interface

**Bulk Role Sync Component:**
```jsx
// client/src/components/admin/BulkRoleSync.jsx
import React, { useState, useEffect } from 'react';
import { supabase } from '../../services/supabaseClient';

const BulkRoleSync = () => {
  const [externalRoles, setExternalRoles] = useState([]);
  const [mappingRules, setMappingRules] = useState({});
  const [syncOptions, setSyncOptions] = useState({
    dryRun: true,
    maxAffectedUsers: 1000,
    requireApproval: true
  });
  const [validation, setValidation] = useState(null);
  const [syncStatus, setSyncStatus] = useState(null);
  const [loading, setLoading] = useState(false);

  const validateSync = async () => {
    setLoading(true);
    try {
      const { data, error } = await supabase.rpc('validate_bulk_role_sync', {
        external_roles: externalRoles,
        options: syncOptions
      });

      if (error) throw error;
      setValidation(data);
    } catch (error) {
      console.error('Validation error:', error);
      setValidation({ valid: false, errors: [error.message] });
    } finally {
      setLoading(false);
    }
  };

  const executeSync = async () => {
    if (!validation?.valid) {
      alert('Please fix validation errors before proceeding');
      return;
    }

    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('bulk_role_sync')
        .insert({
          external_roles: externalRoles,
          mapping_rules: mappingRules,
          options: syncOptions,
          requested_by: supabase.auth.user().id
        });

      if (error) throw error;

      setSyncStatus(data);
      // Start polling for status updates
      pollSyncStatus(data.transaction_id);
    } catch (error) {
      console.error('Sync error:', error);
      alert('Sync failed: ' + error.message);
    } finally {
      setLoading(false);
    }
  };

  const pollSyncStatus = (transactionId) => {
    const poll = async () => {
      try {
        const { data, error } = await supabase
          .from('bulk_role_sync')
          .select('*')
          .eq('transaction_id', transactionId)
          .single();

        if (error) throw error;

        setSyncStatus(data);

        if (data.status === 'completed' || data.status === 'failed') {
          return; // Stop polling
        }

        setTimeout(poll, 2000); // Poll every 2 seconds
      } catch (error) {
        console.error('Status poll error:', error);
      }
    };

    poll();
  };

  return (
    <div className="bulk-role-sync">
      <h2>Bulk Role Synchronization</h2>

      {/* File Upload Section */}
      <div className="upload-section">
        <h3>Import External Roles</h3>
        <input
          type="file"
          accept=".json,.csv"
          onChange={handleFileUpload}
        />
        <p>Supported formats: JSON array, CSV</p>
      </div>

      {/* Mapping Rules */}
      <div className="mapping-section">
        <h3>Role Mapping Rules</h3>
        <textarea
          value={JSON.stringify(mappingRules, null, 2)}
          onChange={(e) => setMappingRules(JSON.parse(e.target.value))}
          placeholder="Enter mapping rules as JSON..."
        />
      </div>

      {/* Sync Options */}
      <div className="options-section">
        <h3>Synchronization Options</h3>
        <label>
          <input
            type="checkbox"
            checked={syncOptions.dryRun}
            onChange={(e) => setSyncOptions({...syncOptions, dryRun: e.target.checked})}
          />
          Dry Run (validate without making changes)
        </label>
        <label>
          Max Affected Users:
          <input
            type="number"
            value={syncOptions.maxAffectedUsers}
            onChange={(e) => setSyncOptions({...syncOptions, maxAffectedUsers: parseInt(e.target.value)})}
          />
        </label>
      </div>

      {/* Validation Results */}
      {validation && (
        <div className="validation-results">
          <h3>Validation Results</h3>
          <div className={`status ${validation.valid ? 'valid' : 'invalid'}`}>
            {validation.valid ? '✅ Valid' : '❌ Invalid'}
          </div>

          {validation.errors?.length > 0 && (
            <div className="errors">
              <h4>Errors:</h4>
              <ul>
                {validation.errors.map((error, i) => (
                  <li key={i}>{error}</li>
                ))}
              </ul>
            </div>
          )}

          {validation.warnings?.length > 0 && (
            <div className="warnings">
              <h4>Warnings:</h4>
              <ul>
                {validation.warnings.map((warning, i) => (
                  <li key={i}>{warning}</li>
                ))}
              </ul>
            </div>
          )}

          {validation.impact_assessment && (
            <div className="impact">
              <h4>Impact Assessment:</h4>
              <p>Affected Users: {validation.impact_assessment.affected_users}</p>
              <p>Risk Level: {validation.impact_assessment.risk_level}</p>
            </div>
          )}
        </div>
      )}

      {/* Action Buttons */}
      <div className="actions">
        <button onClick={validateSync} disabled={loading}>
          {loading ? 'Validating...' : 'Validate'}
        </button>
        <button
          onClick={executeSync}
          disabled={loading || !validation?.valid}
        >
          {loading ? 'Executing...' : 'Execute Sync'}
        </button>
      </div>

      {/* Sync Status */}
      {syncStatus && (
        <div className="sync-status">
          <h3>Sync Status</h3>
          <div className={`status ${syncStatus.status}`}>
            Status: {syncStatus.status}
          </div>
          <div className="progress">
            Progress: {syncStatus.progress}%
          </div>
          {syncStatus.summary && (
            <div className="summary">
              <h4>Summary:</h4>
              <pre>{JSON.stringify(syncStatus.summary, null, 2)}</pre>
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default BulkRoleSync;
```

### Testing Bulk Operations

**Bulk Sync Test Suite:**
```javascript
// tests/integration/bulkRoleSync.test.js
const { createClient } = require('@supabase/supabase-js');
const BulkRoleSyncService = require('../../server/services/bulkRoleSyncService');

describe('Bulk Role Synchronization', () => {
  let supabase;
  let bulkSyncService;
  let testTransactionId;

  beforeAll(async () => {
    supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_KEY);
    bulkSyncService = new BulkRoleSyncService();
  });

  beforeEach(() => {
    testTransactionId = `test_${Date.now()}`;
  });

  test('Validates bulk sync operations', async () => {
    const externalRoles = [
      {
        name: 'Test Role 1',
        department_code: '01300',
        level: 2,
        permissions: ['template:view', 'template:create']
      },
      {
        name: 'Test Role 2',
        department_code: '02400',
        level: 3,
        permissions: ['safety:inspect', 'contractor:approve']
      }
    ];

    const validation = await bulkSyncService.validateBulkOperation(externalRoles, {
      requestedBy: 'test_admin'
    });

    expect(validation.valid).toBe(true);
    expect(validation.errors).toHaveLength(0);
  });

  test('Rejects invalid bulk operations', async () => {
    const invalidRoles = [
      {
        name: 'Invalid Role',
        department_code: '99999', // Invalid department
        level: 5 // Invalid level
      }
    ];

    const validation = await bulkSyncService.validateBulkOperation(invalidRoles, {
      requestedBy: 'test_admin'
    });

    expect(validation.valid).toBe(false);
    expect(validation.errors.length).toBeGreaterThan(0);
  });

  test('Generates correct mapping plan', async () => {
    const externalRoles = [
      {
        name: 'New Role',
        department_code: '01300',
        level: 2
      },
      {
        name: 'Existing Role',
        department_code: '01300',
        level: 3
      }
    ];

    const mappingPlan = await bulkSyncService.generateMappingPlan(externalRoles, {});

    expect(mappingPlan.create).toHaveLength(1);
    expect(mappingPlan.update).toHaveLength(1);
    expect(mappingPlan.create[0].external.name).toBe('New Role');
  });

  test('Executes bulk sync successfully', async () => {
    const externalRoles = [
      {
        name: `TestRole_${testTransactionId}`,
        department_code: '01300',
        level: 2,
        permissions: ['template:view']
      }
    ];

    const result = await bulkSyncService.synchronizeRoles(externalRoles, {
      dryRun: false,
      requestedBy: 'test_admin'
    });

    expect(result.success).toBe(true);
    expect(result.transactionId).toBeDefined();
    expect(result.summary.created).toBe(1);
  });

  test('Rolls back failed sync operations', async () => {
    // Create a role that will cause a conflict
    const conflictingRoles = [
      {
        name: 'System Administrator', // This should conflict
        department_code: '01300',
        level: 4
      }
    ];

    await expect(
      bulkSyncService.synchronizeRoles(conflictingRoles, {
        requestedBy: 'test_admin'
      })
    ).rejects.toThrow();

    // Verify rollback occurred
    const rollbackResult = await bulkSyncService.rollbackSync(testTransactionId);
    expect(rollbackResult.success).toBe(true);
  });

  afterEach(async () => {
    // Clean up test data
    await supabase
      .from('user_roles')
      .delete()
      .like('role', `%${testTransactionId}%`);
  });
});
```

## Performance & Scalability Considerations

### Database Performance
- Indexes on frequently queried columns (user_id, department_code, level)
- Partition audit_log table by month for large volumes
- Use connection pooling for role lookup queries

### Caching Strategy
- Cache user roles in Redis with 15-minute TTL
- Invalidate cache on role changes
- Implement cache warming for frequently accessed users

### Monitoring Metrics
- Role assignment success rate
- Permission check response time
- RLS policy evaluation time
- Authentication failure rate by role

## Monitoring & Alerting

### Key Metrics to Monitor
```javascript
// Role management metrics
const roleMetrics = {
  assignmentsPerHour: 'count(role_assignments)',
  permissionChecksPerMinute: 'rate(permission_checks)',
  authenticationFailures: 'rate(auth_failures)',
  rlsPolicyViolations: 'count(rls_violations)'
};
```

### Alert Conditions
- **High permission check latency**: > 100ms average
- **Role assignment failures**: > 5% failure rate
- **RLS policy violations**: Any violations detected
- **Authentication failures by role**: > 10 failures per hour

## Documentation & Maintenance

### Update Required Documentation
- [Role Permissions Master Index](../role-permissions/01300_00000_MASTER_ROLES_PERMISSIONS_INDEX.md)
- [Authentication Overview](../authentication/0020_AUTHENTICATION_OVERVIEW.md)
- [RLS Implementation Guide](../authentication/0021_RLS_IMPLEMENTATION_GUIDE.md)
- [Security Dashboard Documentation](../user-interface/0750_USER_ACCESS_CONTROL_IMPLEMENTATION.md)

### Maintenance Procedures
- Monthly role audit and cleanup
- Quarterly permission matrix review
- Annual security assessment
- Regular backup and recovery testing

### Version History
- **v1.0** (2025-12-11): Initial user roles implementation procedure
  - Complete database schema and RLS policies
  - Authentication integration with JWT claims
  - Role management API and middleware
  - Comprehensive testing and monitoring
  - Cross-referenced documentation updates

---

## Related Documentation

- [Master Roles & Permissions Index](../role-permissions/01300_00000_MASTER_ROLES_PERMISSIONS_INDEX.md)
- [Authentication Overview](../authentication/0020_AUTHENTICATION_OVERVIEW.md)
- [RLS Implementation Guide](../authentication/0021_RLS_IMPLEMENTATION_GUIDE.md)
- [Security Dashboard](../user-interface/0750_USER_ACCESS_CONTROL_IMPLEMENTATION.md)

---

## Status Tracking

### Implementation Status
- [x] Database schema created
- [x] RLS policies implemented
- [x] Authentication integration completed
- [x] Role management API developed
- [x] Access control middleware implemented
- [x] Security dashboard integrated
- [x] Testing suite created
- [x] Audit logging configured
- [x] Documentation updated
- [x] User training materials prepared
- [ ] Production deployment completed
- [ ] User acceptance testing finished

### Testing Status
- [x] Unit tests for role functions
- [x] Integration tests for API endpoints
- [x] RLS policy validation tests
- [x] Authentication flow tests
- [x] Permission checking tests
- [ ] Performance load testing
- [ ] Security penetration testing
- [ ] End-to-end user workflow testing

### Rollback Plan
**If critical issues occur after deployment:**
1. Disable new RLS policies and revert to basic authentication
2. Restore previous role assignment backup
3. Clear JWT token cache to force re-authentication
4. Communicate with users about temporary access changes
5. Monitor system stability for 24 hours before re-implementation

---

## Related Documentation

**Database Schema Management:**
- → `docs/schema/README.md` → Comprehensive database schema documentation and management guide
- → `extract_schema.sql` → PostgreSQL functions for automated schema extraction with RLS policies and constraints
- → `extract-schema-openapi.js` → Node.js script using Supabase OpenAPI specification for comprehensive schema extraction
- → `update_schema.sh` → Automated schema update script with backup creation and validation

**Security & Access Control:**
- → `0000_TABLE_POLICIES_SECURITY_PROCEDURE.md` → RLS policy management and security configurations
- → `docs/role-permissions/01300_00000_MASTER_ROLES_PERMISSIONS_INDEX.md` → Master roles permissions index
- → `docs/authentication/0020_AUTHENTICATION_OVERVIEW.md` → Authentication system overview
- → `docs/authentication/0021_RLS_IMPLEMENTATION_GUIDE.md` → RLS implementation guide

**System Integration:**
- → `0000_SQL_EXECUTION_PROCEDURE.md` → Raw SQL execution and schema deployment
- → `0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md` → JavaScript data population scripts

---

## Database Schema Management

**Database Schema Management:**
- → `docs/schema/README.md` → Comprehensive database schema documentation and management guide
- → `extract_schema.sql` → PostgreSQL functions for automated schema extraction with RLS policies and constraints
- → `extract-schema-openapi.js` → Node.js script using Supabase OpenAPI specification for comprehensive schema extraction

  **The code in `extract-schema-openapi.js` is used to output the schema to `/Users/_PropAI/construct_ai/docs/schema/current-full-schema.md`.**

  **The script performs the following key operations:**

  1. Fetches the OpenAPI specification from Supabase
  2. Parses table definitions and metadata (RLS policies, foreign keys, indexes, constraints, etc.)
  3. Analyzes script usage patterns across the codebase
  4. Generates comprehensive markdown documentation using the `generateMarkdownSchema` function
  5. Writes the markdown content to `current-full-schema.md` with this specific line:

  ```javascript
  const mdFile = path.join(OUTPUT_DIR, 'current-full-schema.md');
  fs.writeFileSync(mdFile, markdown);
  ```

  **The script is executed to extract and document the complete database schema with all metadata, producing the markdown file you referenced.**
- → `update_schema.sh` → Automated schema update script with backup creation and validation

---

**Procedure Version:** v1.0 (2025-12-11)
**Last Updated:** 2025-12-11
**Review Cycle:** Quarterly
**Next Review:** 2026-03-11

**Recent Updates:**
- **2025-12-11**: Governance (01300) Template Management roles fully implemented
  - ✅ 13 roles with 45 permissions implemented via `01300_governance_user_roles_implementation.sql`
  - ✅ RLS policies configured for role_definitions and audit_log tables
  - ✅ Master roles permissions index updated with implementation status
  - ✅ SQL cleanup queries made specific to avoid conflicts with other department roles
