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

# 0000 Table Policies Security Procedure

## 📋 **Comprehensive Table Policy & Row Level Security (RLS) Management**

**Unified procedure for managing table policies, RLS configurations, and security policies across the Construct AI database system.**

---

## 🎯 **Overview**

### **Purpose**
This procedure establishes comprehensive guidelines for managing Row Level Security (RLS) policies, table access controls, and security configurations across all Construct AI database tables.

### **Scope**
- **300+ enterprise tables** with RLS policies
- **Development and production environments**
- **Authentication bypass mechanisms**
- **Organization-level data isolation**
- **Role-based access controls**

### **Key Components**
- **RLS Policy Patterns**: Standardized security approaches
- **Development Mode Bypass**: Auth bypass for development
- **Organization Isolation**: Multi-tenant data separation
- **Role-Based Access**: User permission management

---

## 🔐 **7 Core RLS Policy Groupings**

### **1. Development Mode Bypass Policies**
```sql
-- Pattern: Full access in development mode
CREATE POLICY "dev_mode_full_access" ON table_name
FOR ALL USING (is_dev_mode());
```
**Used in**: User management, procurement, safety, governance tables
**Purpose**: Allows full access when `is_dev_mode()` returns true

### **2. Service Role Override Policies**
```sql
-- Pattern: Server-side operations bypass
CREATE POLICY "service_role_full_access" ON table_name
FOR ALL USING (auth.role() = 'service_role'::text);
```
**Used in**: All tables requiring server-side access
**Purpose**: Bypasses RLS for service role operations

### **3. Organization-Based Access Policies**
```sql
-- Pattern: Multi-tenant organization isolation
CREATE POLICY "organization_access" ON table_name
FOR ALL USING (
    organization_id IN (
        SELECT organization_id FROM user_management
        WHERE user_id = auth.uid()
    )
);
```
**Used in**: Business data tables (procurement, safety, documents)
**Purpose**: Ensures users only access their organization's data

### **4. User Ownership Policies**
```sql
-- Pattern: Creator/owner access control
CREATE POLICY "user_ownership" ON table_name
FOR ALL USING (created_by::text = auth.uid()::text);
```
**Used in**: User-generated content (templates, documents, approvals)
**Purpose**: Users can access data they created

### **5. Authenticated User Policies**
```sql
-- Pattern: Basic authentication check
CREATE POLICY "authenticated_access" ON table_name
FOR ALL USING (auth.role() = 'authenticated');
```
**Used in**: Public/shared data (UI configs, reference data)
**Purpose**: Requires any authenticated user

### **6. Complex Multi-Condition Policies**
```sql
-- Pattern: Combined access rules
CREATE POLICY "complex_access" ON table_name
FOR ALL USING (
    -- Development bypass
    is_dev_mode() OR
    -- Service role override
    auth.role() = 'service_role' OR
    -- Organization access
    (organization_id IN (...) AND auth.uid() IS NOT NULL)
);
```
**Used in**: Critical business tables requiring layered security
**Purpose**: Multiple access pathways for different scenarios

### **7. Simple Bypass Policies**
```sql
-- Pattern: Conditional bypass (current tasks issue)
CREATE POLICY "conditional_bypass" ON table_name
FOR ALL USING (
    auth.uid() IS NULL OR
    organization_id = 'specific-org-id'
);
```
**Used in**: Development workarounds and emergency access
**Purpose**: Quick fixes for development access issues

---

## 📊 **RLS Implementation Status by Table Category**

### **🔴 CRITICAL SECURITY GAP - EMERGENCY RESPONSE REQUIRED**

**MAJOR SECURITY DISCOVERY (October 2025)**:
- **Total Database Tables**: 325+ tables
- **Tables Currently Secured**: 55+ tables (**17% compliance**)
- **Remaining Unsecured Tables**: **275+ tables (85% compliance gap)**
- **Security Risk Level**: **🔴 CRITICAL** - Major data breach potential
- **Immediate Impact**: Financial data, user credentials, business intelligence exposed

### **Risk-Based Critical Tables Requiring Immediate Action**

#### **Financial & Economic Data (8 tables - EXTREME RISK)**
1. `financial_reports` - Financial statements and reports
2. `project_budgets` - Project financial planning
3. `expense_reports` - Employee expense tracking
4. `payroll_data` - Salary and compensation data
5. `contract_pricing` - Contract pricing information
6. `budget_allocations` - Budget distribution data
7. `revenue_tracking` - Revenue and income data
8. `cost_centers` - Cost center allocation

#### **User & Authentication Data (7 tables - EXTREME RISK)**
9. `user_credentials` - User authentication credentials
10. `user_access_logs` - User access tracking
11. `user_sessions` - Active user sessions
12. `user_personal_information` - Personal user data (GDPR/PII risk)
13. `user_contact_information` - Contact details
14. `user_emergency_contacts` - Emergency contact data
15. `user_employment_details` - Employment information

#### **Business Intelligence Data (5 tables - HIGH RISK)**
16. `company_proprietary_data` - Proprietary business data
17. `strategic_plans` - Strategic business plans
18. `competitive_analysis` - Competitive intelligence
19. `business_intelligence_data` - BI and analytics data
20. `market_research_data` - Market research findings

### **✅ Fully Implemented Categories (Pre-Existing)**

| **Category** | **Tables** | **Policy Type** | **Status** |
|-------------|------------|-----------------|------------|
| **User Management** | `user_management`, `user_roles`, `user_department_access` | Dev + Service Role + Ownership | ✅ **PRODUCTION** |
| **Procurement** | `procurement_orders`, `procurement_suppliers` | Dev + Service Role + Org | ✅ **PRODUCTION** |
| **Safety** | `safety_incidents`, `safety_inspections` | Dev + Service Role + Org | ✅ **PRODUCTION** |
| **Governance** | `governance_approval_*` tables | Dev + Service Role + Ownership | ✅ **PRODUCTION** |
| **Templates** | `templates`, `template_assignments` | Dev + Authenticated + Ownership | ✅ **PRODUCTION** |

### **🔄 Partially Implemented Categories**

| **Category** | **Tables** | **Current Status** | **Gaps** |
|-------------|------------|-------------------|----------|
| **Tasks** | `tasks` | ❌ **BLOCKED** - RLS preventing dev access | Missing dev bypass policy |
| **Documents** | `document_*` tables | ⚠️ **INCONSISTENT** - Mixed policies | Standardize dev access |
| **Vector Data** | `vector_*` tables | ✅ **WORKING** - Isolated properly | Monitor performance |

### **❌ Problematic Tables (Including Critical Security Gaps)**

| **Table** | **Issue** | **Impact** | **Priority** |
|-----------|-----------|------------|-------------|
| `tasks` | RLS blocks dev mode access | My Tasks Dashboard empty | **CRITICAL** |
| `financial_reports` | **NO RLS** - Complete exposure | Direct financial data breach | **EXTREME** |
| `user_credentials` | **NO RLS** - Complete exposure | Authentication compromise | **EXTREME** |
| `user_personal_information` | **NO RLS** - Complete exposure | GDPR/PII violation | **EXTREME** |
| `company_proprietary_data` | **NO RLS** - Complete exposure | Trade secret exposure | **EXTREME** |
| `procurement_orders` | Complex policy logic | Form save failures | **HIGH** |
| `vector_workspaces` | Performance impact | Slow queries | **MEDIUM** |

---

## 🛠️ **Common Policy Patterns & Solutions**

### **Pattern 1: Development + Production Access**
```sql
-- ✅ RECOMMENDED: Combined dev/prod policy
CREATE POLICY "universal_access" ON table_name
FOR ALL USING (
    -- Development mode
    auth.uid() IS NULL
    OR organization_id = '90cd635a-380f-4586-a3b7-a09103b6df94'
    OR
    -- Production mode
    (
        auth.uid() IS NOT NULL AND
        organization_id IN (
            SELECT organization_id FROM user_management
            WHERE user_id = auth.uid()
        )
    )
);
```

### **Pattern 2: Service Role Override**
```sql
-- ✅ RECOMMENDED: Service role bypass
CREATE POLICY "service_role_override" ON table_name
FOR ALL USING (auth.role() = 'service_role');
```

### **Pattern 3: Ownership-Based Access**
```sql
-- ✅ RECOMMENDED: Creator ownership
CREATE POLICY "creator_access" ON table_name
FOR ALL USING (created_by::uuid = auth.uid());
```

---

## 🔧 **Critical Issue Resolution Procedures**

### **Issue 1: Tasks Table RLS Blocking Development**

**Problem**: `tasks` table RLS policy prevents development access, causing empty My Tasks Dashboard.

**Root Cause**: Policy requires `auth.uid()` but returns `null` in development.

**Solution**:
```sql
-- Drop restrictive policy
DROP POLICY IF EXISTS tasks_organization_access ON tasks;

-- Apply development-friendly policy
CREATE POLICY tasks_dev_access ON tasks
FOR ALL USING (
    -- Allow all access for EPCM org in development
    organization_id = '90cd635a-380f-4586-a3b7-a09103b6df94'
    OR
    -- Production mode authentication
    auth.uid() IS NOT NULL
);
```

**Testing**: Verify tasks appear in My Tasks Dashboard after policy update.

### **Issue 2: Form Save Failures**

**Problem**: Complex RLS policies prevent form submissions in procurement tables.

**Root Cause**: Policies require authenticated users but dev mode uses null auth.

**Solution**:
```sql
-- Simplify procurement policies
DROP POLICY IF EXISTS complex_policy ON procurement_orders;

CREATE POLICY procurement_dev_access ON procurement_orders
FOR ALL USING (
    -- Development bypass
    auth.uid() IS NULL OR
    -- Organization access
    organization_id IN (
        SELECT organization_id FROM user_management
        WHERE user_id = auth.uid()
    ) OR
    -- Creator access
    created_by = auth.uid()
);
```

### **Issue 3: Vector Data Performance**

**Problem**: Complex RLS policies slow down vector searches.

**Solution**:
```sql
-- Optimize vector policies
CREATE POLICY vector_optimized_access ON vector_tables
FOR ALL USING (
    -- Fast dev check
    auth.uid() IS NULL OR
    -- Indexed organization check
    organization_id = ANY(
        SELECT organization_id FROM user_organization_access
        WHERE user_id = auth.uid()
    )
);
```

---

## 📋 **Policy Maintenance Checklist**

### **Daily Monitoring**
- [ ] Check for new tables without RLS policies
- [ ] Verify `is_dev_mode()` function returns correct value
- [ ] Monitor policy performance impact
- [ ] Review failed authentication attempts

### **Weekly Maintenance**
- [ ] Audit policy consistency across similar tables
- [ ] Update organization IDs in dev policies
- [ ] Review and rotate service role keys
- [ ] Test policy changes in staging environment

### **Monthly Review**
- [ ] Complete policy audit against security requirements
- [ ] Update policies for new business requirements
- [ ] Review and optimize slow-performing policies
- [ ] Document policy changes in change log

---

## 🎯 **Quick Reference Commands**

### **Enable RLS on Table**
```sql
ALTER TABLE table_name ENABLE ROW LEVEL SECURITY;
```

### **Check Existing Policies**
```sql
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual
FROM pg_policies
WHERE schemaname = 'public' AND tablename = 'table_name';
```

### **Test Policy Access**
```sql
-- As anon user (development)
SELECT * FROM table_name LIMIT 1;

-- As authenticated user
SET LOCAL auth.uid TO 'user-uuid';
SELECT * FROM table_name LIMIT 1;
```

### **Emergency Policy Bypass**
```sql
-- Temporarily disable RLS (use with caution)
ALTER TABLE table_name DISABLE ROW LEVEL SECURITY;

-- Re-enable after fix
ALTER TABLE table_name ENABLE ROW LEVEL SECURITY;
```

---

## 🚨 **Emergency Procedures**

### **Complete System Lockout**
1. **Immediate**: Disable RLS on critical tables
2. **Diagnose**: Check `is_dev_mode()` function
3. **Fix**: Apply universal access policy
4. **Test**: Verify application functionality
5. **Re-enable**: Restore proper security policies

### **Performance Degradation**
1. **Monitor**: Identify slow queries with `EXPLAIN ANALYZE`
2. **Optimize**: Add indexes on policy filter columns
3. **Simplify**: Replace complex subqueries with indexed lookups
4. **Test**: Verify performance improvement

---

## 📈 **Policy Performance Optimization**

### **Index Strategy**
```sql
-- Index policy filter columns
CREATE INDEX idx_table_organization ON table_name(organization_id);
CREATE INDEX idx_table_created_by ON table_name(created_by);
CREATE INDEX idx_table_user_id ON table_name(user_id);
```

### **Query Optimization**
```sql
-- Replace subqueries with JOINs for better performance
CREATE POLICY optimized_policy ON table_name
FOR ALL USING (
    EXISTS (
        SELECT 1 FROM user_organization_access uoa
        WHERE uoa.user_id = auth.uid()
        AND uoa.organization_id = table_name.organization_id
    )
);
```

---

## 🔍 **Troubleshooting Guide**

### **Symptom: Empty Query Results**
**Possible Causes**:
- RLS policy too restrictive
- `is_dev_mode()` returning false
- Missing organization association

**Debug Steps**:
1. Check `is_dev_mode()` result
2. Verify user organization association
3. Test with service role key
4. Review policy logic

### **Symptom: Permission Denied**
**Possible Causes**:
- Policy logic error
- Missing user authentication
- Incorrect role assignment

**Debug Steps**:
1. Verify user authentication state
2. Check role assignments
3. Test policy conditions manually
4. Review Supabase auth configuration

### **Symptom: Slow Queries**
**Possible Causes**:
- Unindexed policy columns
- Complex subqueries
- Missing statistics

**Debug Steps**:
1. Run `EXPLAIN ANALYZE` on slow queries
2. Check for missing indexes
3. Optimize policy conditions
4. Update table statistics

---

## 📋 **Implementation Checklist**

### **New Table Onboarding**
- [ ] Enable RLS: `ALTER TABLE table_name ENABLE ROW LEVEL SECURITY;`
- [ ] Add dev policy: `CREATE POLICY "dev_mode_full_access" ON table_name FOR ALL USING (is_dev_mode());`
- [ ] Add service role policy: `CREATE POLICY "service_role_full_access" ON table_name FOR ALL USING (auth.role() = 'service_role');`
- [ ] Add organization policy: Based on data classification
- [ ] Test policies in development environment
- [ ] Document policies in table comments

### **Policy Update Process**
- [ ] Backup current policies
- [ ] Test changes in development
- [ ] Apply changes during maintenance window
- [ ] Monitor for issues post-deployment
- [ ] Update documentation

---

## 🎯 **Success Metrics**

### **Security Metrics**
- [ ] Zero unauthorized data access incidents
- [ ] 100% tables with appropriate RLS policies
- [ ] Development bypass working correctly

### **Performance Metrics**
- [ ] Query performance within acceptable limits (<100ms)
- [ ] No policy-related query timeouts
- [ ] Efficient policy evaluation

### **Maintenance Metrics**
- [ ] Policy documentation up-to-date
- [ ] Regular policy audits completed
- [ ] Automated policy testing implemented

---

## 🔗 **Related Procedures & Documentation**

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

**System Maintenance & Troubleshooting:**
- → `0000_PROCEDURES_GUIDE.md` → Complete index of all operational procedures
- → `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` → Framework for diagnosing RLS and security issues
- → `0000_DEBUGGING_GUIDE.md` → Advanced debugging techniques for policy-related problems

**Data Management:**
- → `0000_SQL_EXECUTION_PROCEDURE.md` → Raw SQL execution and schema deployment
- → `0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md` → JavaScript/Node.js data population scripts

---

## 📞 **Support & Escalation**

### **Immediate Issues**
- **Tasks not loading**: Apply dev policy bypass (see Issue 1)
- **Form save failures**: Check procurement policies
- **Authentication errors**: Verify `is_dev_mode()` function

### **Escalation Path**
1. **Developer**: Check policy logic and test queries
2. **Security Team**: Review policy changes and security implications
3. **Database Admin**: Apply schema changes and performance optimization
4. **System Admin**: Emergency bypass and system recovery

---

## 📝 **Change Log**

| **Date** | **Change** | **Impact** | **Status** |
|----------|------------|------------|------------|
| 2025-12-07 | Document creation | New comprehensive policy guide | ✅ **COMPLETE** |
| 2025-12-07 | Tasks RLS fix documented | Critical dashboard issue resolved | ✅ **READY** |
| 2025-12-07 | Policy patterns standardized | Consistent security approach | ✅ **IMPLEMENTED** |

---

## ✅ **Quick Fix for Tasks Issue**

**Apply this SQL immediately to fix the empty My Tasks Dashboard:**

```sql
-- Fix tasks table RLS policy
DROP POLICY IF EXISTS tasks_organization_access ON tasks;

CREATE POLICY tasks_dev_access ON tasks
FOR ALL USING (
    organization_id = '90cd635a-380f-4586-a3b7-a09103b6df94'
    OR auth.uid() IS NOT NULL
);
```

**Result**: Tasks will appear in My Tasks Dashboard immediately after applying this policy.
