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

# SQL Execution Procedure - Enterprise Database Deployment

__CRITICAL__: This procedure incorporates lessons from massive SQL deployment failures and persistent error patterns. Follow this exact workflow to prevent errors and ensure successful deployments.

---

## __Correct Procedure to Use:__

This procedure is for __**Raw SQL execution and schema deployment**__ including:

✅ **Schema creation** (`CREATE TABLE`, `CREATE INDEX`)\
✅ **RLS policy setup** (`ALTER TABLE ENABLE ROW LEVEL SECURITY`)\
✅ **Direct database operations** (No API calls or JavaScript)\
✅ **Infrastructure setup** (Tables, indexes, constraints, permissions)

**❌ DO NOT use this procedure for:**
- API-based data insertion (use `0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md`)
- Complex business logic validation
- Rate-limited operations
- External service dependencies

## __When to Use Each Procedure:__

| __Script Type__ | __Procedure__ | __Example__ |
|----------------|---------------|-------------|
| __Schema Creation__ | `0000_SQL_EXECUTION_PROCEDURE.md` | `CREATE TABLE custom_assignments` |
| __Data Population__ | `0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md` | API-based data insertion |
| __RLS Policy Setup__ | `0000_SQL_EXECUTION_PROCEDURE.md` | `ALTER TABLE ENABLE ROW LEVEL SECURITY` |
| __Bulk Data Loading__ | `0000_SQL_EXECUTION_PROCEDURE.md` | Large dataset imports |
| __API Data Insertion__ | `0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md` | RLS-enforced record creation |

**Example: The `custom_assignments_table.sql` script creates schema/infrastructure and belongs to this SQL execution procedure.** 🎯

---

## 🏗️ **HIERARCHICAL DOCUMENT STORAGE - AUTOMATED BUCKET CREATION**

### **Environment Setup for Hierarchical Storage**

#### **Update .env File**
Add the following environment variables to your `.env.dev` or `.env` file:

```bash
# Hierarchical Document Storage Configuration
SUPABASE_URL=https://mseizswoiwyewsidknta.supabase.co
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1zZWl6c3dvaXd5ZXdzaWRrbnRhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyNTM1MTA2MCwiZXhwIjoyMDQwOTI3MDYwfQ.7UmcdZK07uYAFowRg8E_dM0xfbYTF8D7RojBFMdDfe0
```

#### **Verify Environment Variables**
```bash
# Check that environment variables are loaded
echo "SUPABASE_URL: $SUPABASE_URL"
echo "SUPABASE_SERVICE_ROLE_KEY: ${SUPABASE_SERVICE_ROLE_KEY:0:20}..."
```

### **Automated Bucket Creation Script**

#### **Run Bucket Creation Script**
```bash
# Navigate to project root
cd /Users/chadferguson/Documents/construct_ai

# Run the automated bucket creation script
node scripts/create-organization-buckets.js

# Or specify specific organizations
node scripts/create-organization-buckets.js org-123 org-456 org-789
```

#### **Expected Script Output**
```
🚀 Hierarchical Storage Buckets Creation Script

🧪 Testing Path Generation:
✅ Path Generation Test Passed
📁 Full Path: org-123-documents/company-456/organization-123/project-789/phase-001/discipline-01900/tenders/DOC-001_vendor-proposal.pdf
👁️ Display Path: org-123-documents ▸ company-456 ▸ organization-123 ▸ project-789 ▸ phase-001 ▸ discipline-01900 ▸ tenders ▸ DOC-001_vendor-proposal.pdf

📋 Creating buckets for organizations:
  • org-demo-org-001
  • org-demo-org-002

📦 Creating bucket: org-demo-org-001-documents
✅ Created bucket: org-demo-org-001-documents
📦 Creating bucket: org-demo-org-002-documents
✅ Created bucket: org-demo-org-002-documents

📊 CREATION SUMMARY
✅ Created: 2 buckets
📦 Existing: 0 buckets
🎯 Total Buckets Available: 2
🎉 All organization buckets are ready for hierarchical document storage!
```

### **Verify Bucket Creation in Supabase**
```bash
# List all buckets to verify creation
curl -X GET "https://mseizswoiwyewsidknta.supabase.co/storage/v1/bucket" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1zZWl6c3dvaXd5ZXdzaWRrbnRhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyNTM1MTA2MCwiZXhwIjoyMDQwOTI3MDYwfQ.7UmcdZK07uYAFowRg8E_dM0xfbYTF8D7RojBFMdDfe0" \
  -H "apikey: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1zZWl6c3dvaXd5ZXdzaWRrbnRhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjUzNTEwNjAsImV4cCI6MjA0MDkyNzA2MH0.8gQFNBNO6u_ErGK3isgj3mn81JtOps8ReXCz45wuBgU"
```

### **Files Created for Hierarchical Storage**
- **`server/src/services/hierarchicalPathGenerator.js`** - Path generation service
- **`scripts/create-organization-buckets.js`** - Automated bucket creation
- **`docs/data-processing/0500_STORAGE_BUCKETS_IMPLEMENTATION.md`** - Implementation guide
- **`database_schema_setup.sql`** - Updated with document processing tables

### **Next Steps After Bucket Creation**
1. **Apply RLS Policies**: Run hierarchical access control policies
2. **Update Upload Modals**: Integrate hierarchical path generation
3. **Test Document Upload**: Verify paths and permissions work
4. **Migrate Existing Documents**: Move current documents to new structure

---

## 🚨 __MANDATORY PRE-DEPLOYMENT CHECKS__

**🔗 Cross-References to Related Procedures:**

**System Maintenance & Troubleshooting:**
- → `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` → Framework for diagnosing SQL execution failures and database issues
- → `0000_DEBUGGING_GUIDE.md` → Advanced debugging techniques for SQL-related problems and deployment failures
- → `0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md` → JavaScript/Node.js data population scripts (includes decision framework for SQL vs JavaScript)

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

**Setup & Navigation:**
- → `0000_QUICK_START_GUIDE.md` → Initial system setup and basic JavaScript execution testing
- → `0000_PROCEDURES_GUIDE.md` → Complete index of all troubleshooting and operational procedures
- → `docs/0000_MASTER_DATABASE_SCHEMA.md` → Database schema reference for understanding table structures

## 🚨 __MANDATORY PRE-DEPLOYMENT CHECKS__

### Step 1: Run Diagnostic Assessment

__ALWAYS run the diagnostic script first:__

```bash
# Critical: Run diagnostic BEFORE any SQL execution
psql -d your_database -f sql/diagnostic_system_check.sql

# Check the output for:
# ✅ Table existence status
# ✅ Column existence and data types
# ✅ Function conflicts
# ✅ Permission status
# ✅ Data integrity issues
# ✅ Foreign key relationships
# ✅ RLS policy status
```

__STOP if any ❌ CRITICAL issues are found. Resolve before proceeding.__

#### Critical Enhancement: Real-Time Schema Validation

__NEW REQUIREMENT: Run comprehensive schema validation immediately before any data operation__

```sql
-- COMPREHENSIVE SCHEMA VALIDATION - Run this before ANY INSERT/UPDATE
DO $$
DECLARE
    target_table TEXT := 'user_profiles'; -- CHANGE THIS for your target table
    required_columns TEXT[] := ARRAY['id', 'company_id', 'role', 'settings', 'last_login']; -- CHANGE THIS
    all_columns_exist BOOLEAN := true;
    col_info RECORD;
    not_null_columns TEXT[] := ARRAY[]::TEXT[];
BEGIN
    RAISE NOTICE '🔍 COMPREHENSIVE SCHEMA VALIDATION FOR: %', target_table;

    -- 1. Verify table exists
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = target_table AND table_schema = 'public') THEN
        RAISE EXCEPTION '❌ CRITICAL: Table % does not exist. Run infrastructure setup first.', target_table;
    END IF;

    -- 2. Get ALL columns with full details
    RAISE NOTICE '📋 Complete column analysis for %:', target_table;
    FOR col_info IN
        SELECT
            column_name,
            data_type,
            is_nullable,
            column_default,
            CASE WHEN is_nullable = 'NO' THEN 'REQUIRED' ELSE 'OPTIONAL' END as requirement
        FROM information_schema.columns
        WHERE table_name = target_table AND table_schema = 'public'
        ORDER BY ordinal_position
    LOOP
        RAISE NOTICE '  → %: % (% - Default: %)', col_info.column_name, col_info.data_type, col_info.requirement,
                    COALESCE(col_info.column_default, 'NONE');

        -- Collect NOT NULL columns
        IF col_info.is_nullable = 'NO' THEN
            not_null_columns := not_null_columns || col_info.column_name;
        END IF;
    END LOOP;

    -- 3. Check required columns exist
    RAISE NOTICE '✅ Checking required columns: %', required_columns;
    FOR i IN 1..array_length(required_columns, 1) LOOP
        IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                      WHERE table_name = target_table AND column_name = required_columns[i] AND table_schema = 'public') THEN
            RAISE EXCEPTION '❌ CRITICAL: Required column % missing from %', required_columns[i], target_table;
        END IF;
    END LOOP;

    -- 4. CRITICAL: Report ALL NOT NULL columns that will require values
    RAISE NOTICE '🚨 CRITICAL NOT NULL COLUMNS (must provide values): %', not_null_columns;
    RAISE NOTICE '⚠️  INSERT statement MUST include ALL of these columns: %', not_null_columns;

    -- 5. Check constraints
    RAISE NOTICE '🔒 Constraint analysis:';
    FOR col_info IN
        SELECT
            conname as constraint_name,
            contype as constraint_type,
            conkey::text as constrained_columns
        FROM pg_constraint
        WHERE conrelid = target_table::regclass
    LOOP
        RAISE NOTICE '  → % (%): %', col_info.constraint_name, col_info.constraint_type, col_info.constrained_columns;
    END LOOP;

    RAISE NOTICE '✅ SCHEMA VALIDATION COMPLETE - Safe to proceed with INSERT using columns: %', not_null_columns;
END $$;
```

#### **CRITICAL REQUIREMENT: Extract Actual Database Schema**

**MANDATORY FIRST STEP: Extract real schema from the running database**

Before writing ANY SQL, run this query in Supabase SQL Editor to get the ACTUAL schema:

```sql
-- EXTRACT ACTUAL DATABASE SCHEMA - Run this FIRST
SELECT
    table_name,
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'public'
    AND table_name IN ('projects', 'procurement_orders', 'scope_of_work', 'tasks') -- Add your target tables
ORDER BY table_name, ordinal_position;
```

**DO NOT rely on SQL files in the codebase** - they may be outdated or not match the deployed database.

#### Enhanced Error Prevention Checklist

**MANDATORY: Complete this checklist before any data operation**

- [ ] __Table Exists__: Confirmed target table exists in database
- [ ] __Real-Time Schema Validation__: Run comprehensive schema analysis (see above)
- [ ] __Column Inventory__: Listed ALL columns with data types and nullability
- [ ] __NOT NULL Audit__: Identified every column that requires a value
- [ ] __Constraint Review__: Checked all PRIMARY KEY, FOREIGN KEY, UNIQUE constraints
- [ ] __INSERT Statement__: Verified statement includes ALL required NOT NULL columns
- [ ] __Data Types Match__: Confirmed INSERT values match column data types
- [ ] __PostgreSQL Function Compatibility__: Verified all functions exist and work with column data types
- [ ] __JSONB vs Array Functions__: Used correct functions (jsonb_array_length vs array_length)
- [ ] __PL/pgSQL Type Safety__: Verified all variable types match array element types in FOREACH loops
- [ ] __Transaction DDL Check__: Confirmed no CONCURRENTLY operations in transaction blocks
- [ ] __Type Casting Audit__: Verified all cross-type comparisons use explicit casting
- [ ] __Type Consistency__: Confirmed related tables use consistent data types for same logical fields
- [ ] __RLS Complexity Check__: Verified RLS policies use simple expressions without complex subqueries
- [ ] __Migration Size Limit__: Confirmed migration under 100 lines, broken into phases if needed
- [ ] __Test Run__: Performed test INSERT with minimal data first
=======
- [ ] __Table Exists__: Confirmed target table exists in database
- [ ] __Real-Time Schema Validation__: Run comprehensive schema analysis (see above)
- [ ] __Column Inventory__: Listed ALL columns with data types and nullability
- [ ] __NOT NULL Audit__: Identified every column that requires a value
- [ ] __Constraint Review__: Checked all PRIMARY KEY, FOREIGN KEY, UNIQUE constraints
- [ ] __INSERT Statement__: Verified statement includes ALL required NOT NULL columns
- [ ] __Data Types Match__: Confirmed INSERT values match column data types
- [ ] __PL/pgSQL Type Safety__: Verified all variable types match array element types in FOREACH loops
- [ ] __Transaction DDL Check__: Confirmed no CONCURRENTLY operations in transaction blocks
- [ ] __Type Casting Audit__: Verified all cross-type comparisons use explicit casting
- [ ] __Type Consistency__: Confirmed related tables use consistent data types for same logical fields
- [ ] __RLS Complexity Check__: Verified RLS policies use simple expressions without complex subqueries
- [ ] __Migration Size Limit__: Confirmed migration under 100 lines, broken into phases if needed
- [ ] __Test Run__: Performed test INSERT with minimal data first
>>>>>>> 4d167670487102c232ad090d0cadb7a706a18e1e

#### Critical Lesson: Real-Time Schema Validation Required

**⚠️ CRITICAL LESSON FROM THIS INCIDENT**

The basic diagnostic script passed, but missed the `user_id` NOT NULL constraint. **Real-time comprehensive schema validation must be run immediately before any data operation**, not just during initial diagnostics.

**Why the basic diagnostic failed:**
- ✅ Checked table existence
- ✅ Verified some columns existed
- ❌ **Did not identify ALL NOT NULL constraints**
- ❌ **Did not provide complete column inventory**
- ❌ **Did not validate INSERT statement compatibility**

**Enhanced procedure now requires real-time validation before every data operation.**

#### **⚠️ CRITICAL LESSON FROM PROCURMENT TEST DATA INCIDENT (October 2025)**

During the procurement document assembly test data creation, schema assumptions were made without proper validation for ALL referenced tables, resulting in a "column 'description' of relation 'projects' does not exist" error.

**Why the procedure failed this time:**
- ✅ Ran schema validation for some tables (tasks, procurement_orders, scope_of_work)
- ❌ **Did NOT run schema validation for ALL referenced tables (projects table)**
- ❌ **Assumed column existence based on similar tables rather than checking each table individually**
- ❌ **Did not validate the complete INSERT statement against actual schema**

**Root Cause:** The procedure requires validation for "target tables" but this operation involved multiple related tables with foreign key relationships. **ALL tables referenced in an operation must be validated individually.**

**Enhanced requirement: Multi-table operations require individual schema validation for EVERY table involved.**

## Schema Documentation References

### Essential Schema Documentation Files

**📋 Core Schema References for SQL Execution:**

#### **Master Schema Guides**
- **[0300_DATABASE_SCHEMA_MASTER_GUIDE.md](../schema/0300_DATABASE_SCHEMA_MASTER_GUIDE.md)** - Master guide for database schema architecture and design patterns
- **[current-full-schema.md](../schema/current-full-schema.md)** - Authoritative current schema reference with all tables, columns, and relationships
- **[schema-part-01.md](../schema/schema-part-01.md)** - Core schema components and table definitions
- **[schema-part-02.md](../schema/schema-part-02.md)** - Advanced schema features and relationships
- **[schema-part-03.md](../schema/schema-part-03.md)** - Schema extensions and specialized tables

#### **Schema Management Scripts**
- **[update_schema.js](../schema/update_schema.js)** - Automated schema update utilities
- **[current-full-schema.sql](../schema/current-full-schema.sql)** - Executable SQL schema dump for validation
- **[extract_schema.sql](../schema/extract_schema.sql)** - Schema extraction queries
- **[run_schema_update.sh](../schema/run_schema_update.sh)** - Schema update automation script

#### **Migration-Specific References**
- **[0300_PROCUREMENT_TEMPLATES_TO_UNIFIED_MIGRATION.md](../0300_PROCUREMENT_TEMPLATES_TO_UNIFIED_MIGRATION.md)** - Template table unification migration guide
- **JavaScript Data Population Procedures**: See [0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md](../procedures/0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md)

### Schema Validation Workflow

**Pre-SQL Execution Schema Review:**
```bash
# 1. Review current schema architecture
cat docs/schema/0300_DATABASE_SCHEMA_MASTER_GUIDE.md | head -50

# 2. Check current full schema reference
grep -A 5 "Foreign Keys" docs/schema/current-full-schema.md

# 3. Validate table relationships
grep -A 10 "RLS Policies" docs/schema/current-full-schema.md

# 4. Review RLS policies
grep -A 5 "RLS Policies" docs/schema/current-full-schema.md
```

**Post-SQL Execution Schema Validation:**
```bash
# 1. Extract updated schema if changes made
node docs/schema/extract_schema.js

# 2. Validate against master guide
# Compare changes with 0300_DATABASE_SCHEMA_MASTER_GUIDE.md

# 3. Update schema documentation
# Ensure current-full-schema.md reflects changes
```

#### Enhanced Diagnostic Queries

```sql
-- CRITICAL: Check target table existence and schema
SELECT '=== TARGET TABLE SCHEMA VALIDATION ===' as validation_check;

-- For user_profiles table (or any target table)
DO $$
DECLARE
    table_exists BOOLEAN := false;
    required_columns TEXT[] := ARRAY['id', 'company_id', 'role', 'settings', 'last_login'];
    missing_columns TEXT[] := ARRAY[]::TEXT[];
    column_check RECORD;
BEGIN
    -- Check if table exists
    SELECT EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_name = 'user_profiles' AND table_schema = 'public'
    ) INTO table_exists;

    IF NOT table_exists THEN
        RAISE EXCEPTION '❌ CRITICAL: user_profiles table does not exist. Create table first or check table name.';
    END IF;

    -- Check required columns
    FOREACH column_check IN
        SELECT column_name, data_type, is_nullable
        FROM information_schema.columns
        WHERE table_name = 'user_profiles' AND table_schema = 'public'
    LOOP
        -- Remove found columns from missing list
        missing_columns := array_remove(missing_columns, column_check.column_name);

        -- Validate data types for known columns
        IF column_check.column_name = 'id' AND column_check.data_type != 'uuid' THEN
            RAISE WARNING '⚠️ Column id has unexpected type: %, expected: uuid', column_check.data_type;
        END IF;

        IF column_check.column_name = 'settings' AND column_check.data_type != 'jsonb' THEN
            RAISE WARNING '⚠️ Column settings has unexpected type: %, expected: jsonb', column_check.data_type;
        END IF;
    END LOOP;

    -- Check for missing required columns
    FOREACH column_check IN ARRAY required_columns LOOP
        IF NOT EXISTS (
            SELECT 1 FROM information_schema.columns
            WHERE table_name = 'user_profiles'
            AND table_schema = 'public'
            AND column_name = column_check
        ) THEN
            missing_columns := missing_columns || column_check;
        END IF;
    END LOOP;

    IF array_length(missing_columns, 1) > 0 THEN
        RAISE EXCEPTION '❌ CRITICAL: Missing required columns in user_profiles: %', missing_columns;
    END IF;

    RAISE NOTICE '✅ user_profiles table schema validation passed';
END $$;

-- Check RLS status
SELECT '=== RLS SECURITY VALIDATION ===' as rls_check;
SELECT
    schemaname,
    tablename,
    rowsecurity as rls_enabled,
    CASE
        WHEN rowsecurity THEN '✅ RLS ENABLED'
        ELSE '⚠️ RLS DISABLED - Security Risk'
    END as security_status
FROM pg_tables
WHERE tablename = 'user_profiles' AND schemaname = 'public';

-- Check existing policies
SELECT '=== EXISTING RLS POLICIES ===' as policy_check;
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
WHERE tablename = 'user_profiles' AND schemaname = 'public';
```

### Step 2: Environment Validation

```bash
# Verify all required environment variables
echo "DATABASE_URL: $DATABASE_URL"
echo "SUPABASE_URL: $SUPABASE_URL"
echo "SUPABASE_SERVICE_ROLE_KEY: ${SUPABASE_SERVICE_ROLE_KEY:0:10}..."

# Test database connectivity
psql "$DATABASE_URL" -c "SELECT version();" || echo "❌ Connection failed"
```

### Step 3: Backup Current State

```bash
# Create backup before any changes
pg_dump "$DATABASE_URL" > "backup_$(date +%Y%m%d_%H%M%S).sql"

# Verify backup integrity
ls -la backup_*.sql"
```

## 🚀 __DEPLOYMENT WORKFLOW__

### Phase 1: Infrastructure Deployment

```bash
# 1. Create tables and core infrastructure
echo "=== PHASE 1: Creating infrastructure ==="
psql -d "$DATABASE_URL" -f sql/create_task_management_system.sql

# Verify: Check that tables were created
psql -d "$DATABASE_URL" -c "\dt" | grep -E "(tasks|organizations|user_management)"
```

### Phase 2: Data Population

```bash
# 2. Populate test data (safe for re-runs)
echo "=== PHASE 2: Populating test data ==="
psql -d "$DATABASE_URL" -f sql/setup_task_management_test_data.sql

# Verify: Check data was inserted
psql -d "$DATABASE_URL" -c "SELECT COUNT(*) FROM organizations; SELECT COUNT(*) FROM user_management;"
```

### Phase 3: Data Migration and Relationships

```bash
# 3. Run migration scripts (creates data relationships)
echo "=== PHASE 3: Running migrations ==="

# For complex migrations, refer to task-specific procedures
# Example: Migration procedures documented in docs/procedures/MIGRATION_*.md

# Verify: Check data relationships were created
psql -d "$DATABASE_URL" -c "
SELECT 'Migration verification:' as check;
-- Add migration-specific verification queries here
"
```

## 🔒 __RLS POLICY SECURITY SYSTEM__

### Mandatory RLS Policy Application

__ALL table creation/modification MUST include RLS policy implementation.__

#### Automatic RLS Policy Application

```bash
# For NEW tables: Policies are applied automatically via event trigger
# No manual intervention required for new table creation

# For EXISTING tables: Apply policies manually
echo "=== APPLYING RLS POLICIES TO EXISTING TABLES ==="
psql -d "$DATABASE_URL" -c "SELECT apply_default_rls_policies('your_table_name');"
```

#### RLS Policy Verification (MANDATORY)

```bash
# ALWAYS verify RLS policies after any schema changes
echo "=== RLS POLICY VERIFICATION ==="
psql -d "$DATABASE_URL" -c "
SELECT * FROM extract_rls_policy_inventory()
WHERE tablename = 'your_table_name'
ORDER BY security_status;
"

# Check for security gaps
psql -d "$DATABASE_URL" -c "
SELECT 'Critical Security Gaps:' as alert;
SELECT * FROM extract_rls_policy_inventory()
WHERE security_status IN ('❌ NO SECURITY', '❌ NO POLICIES');
"
```

#### RLS Policy Generation for Custom Requirements

```bash
# Generate custom RLS SQL for complex requirements
echo "=== GENERATING CUSTOM RLS POLICIES ==="
psql -d "$DATABASE_URL" -c "
SELECT generate_table_rls_sql('your_table_name');
" > custom_rls_policies.sql

# Review and apply the generated policies
psql -d "$DATABASE_URL" -f custom_rls_policies.sql
```

### RLS Security Audit Requirements

__MANDATORY: Run security audit after ANY schema changes__

```bash
# Complete RLS security audit
psql -d "$DATABASE_URL" -c "
SELECT
    'RLS Security Audit Results:' as audit_header,
    COUNT(*) as total_tables,
    SUM(CASE WHEN security_status = '❌ NO SECURITY' THEN 1 ELSE 0 END) as critical_breaches,
    SUM(CASE WHEN security_status = '✅ FULLY SECURE' THEN 1 ELSE 0 END) as fully_secure,
    SUM(CASE WHEN security_status LIKE '🔶%' THEN 1 ELSE 0 END) as partially_secure
FROM extract_rls_policy_inventory();
"

# Generate security compliance report
psql -d "$DATABASE_URL" -c "
SELECT
    priority_level,
    security_status,
    COUNT(*) as table_count,
    ROUND(AVG(CASE WHEN policies_active >= 3 THEN 100 ELSE 0 END), 1) as compliance_percentage
FROM extract_rls_policy_inventory()
GROUP BY priority_level, security_status
ORDER BY priority_level, security_status;
"
```

### RLS Policy Deployment Checklist

- [ ] __Table Creation__: Confirm event trigger applied policies automatically
- [ ] __Schema Changes__: Run `apply_default_rls_policies()` for modified tables
- [ ] __Policy Verification__: Execute `extract_rls_policy_inventory()` audit
- [ ] __Security Compliance__: Ensure no '❌ NO SECURITY' tables exist
- [ ] __Multi-tenancy Check__: Verify `user_organization_access` integration when available

### Current Database Security Status (December 2025)

Based on the latest emergency security audit:

| **Metric** | **Value** | **Status** |
|------------|-----------|------------|
| **Total Tables Audited** | 365 | ✅ Complete coverage |
| **Fully Secure Tables** | 169 | 🟡 Moderate progress |
| **Remaining Security Gaps** | 130 | 🟠 Needs attention |
| **Security Compliance** | **46.3%** | 🟡 Improving |

**Security Status Breakdown:**
- **🔴 Critical Priority**: Financial, user credential, business intelligence tables
- **🟠 High Priority**: Contract, project, personnel data tables
- **🟡 Medium Priority**: Safety, compliance, document management tables
- **🟢 Low Priority**: Reference and system tables

### Emergency Security Audit Commands

#### Run Complete Security Assessment
```bash
# Execute comprehensive security audit
psql -d "$DATABASE_URL" -f sql/emergency_security_audit.sql
```

#### Quick Security Check
```bash
# Get current security status summary
psql -d "$DATABASE_URL" -c "
SELECT
    'SECURITY STATUS SUMMARY' as header,
    COUNT(*) as total_tables,
    SUM(CASE WHEN security_status = '✅ SECURE' THEN 1 ELSE 0 END) as secure_tables,
    SUM(CASE WHEN security_status IN ('❌ NO RLS', '❌ NO POLICIES') THEN 1 ELSE 0 END) as unsecured_tables,
    ROUND(SUM(CASE WHEN security_status = '✅ SECURE' THEN 1 ELSE 0 END)::numeric / COUNT(*)::numeric * 100, 1) as compliance_pct
FROM emergency_security_audit();
"
```

#### Identify Critical Security Gaps
```bash
# Find most critical tables needing immediate attention
psql -d "$DATABASE_URL" -c "
SELECT table_name, risk_level, security_status, remediation_priority
FROM emergency_security_audit()
WHERE security_status IN ('❌ NO RLS', '❌ NO POLICIES')
  AND risk_level = '🔴 CRITICAL'
ORDER BY table_name;
"
```

#### Apply Emergency Security Fixes
```bash
# Secure the top 10 most critical tables automatically
psql -d "$DATABASE_URL" -c "SELECT apply_emergency_security_fixes();"
```

## 🚀 __BATCH IMPLEMENTATION PROCEDURES__

### 🏗️ __Batch SQL Execution Strategy__

**CRITICAL LESSON**: For batch implementations involving multiple tables and policies, use the following enhanced workflow:

#### Phase 1: Pre-Batch Analysis
```bash
# 1. Analyze all target tables for conflicts
echo "=== PRE-BATCH ANALYSIS ==="
psql -d "$DATABASE_URL" -c "
SELECT
    'BATCH IMPACT ANALYSIS' as analysis,
    COUNT(*) as total_tables_to_create,
    SUM(CASE WHEN t.table_name IS NOT NULL THEN 1 ELSE 0 END) as existing_tables,
    SUM(CASE WHEN p.tablename IS NOT NULL THEN 1 ELSE 0 END) as tables_with_policies
FROM (VALUES
    ('a_00800_design_vector'),
    ('a_00872_developer_vector'),
    ('a_00875_sales_vector'),
    ('a_00877_sundry_vector'),
    ('a_00882_dirconst_vector'),
    ('a_00895_dirproject_vector'),
    ('a_01000_environmental_vector'),
    ('a_01300_governance_vector'),
    ('a_01400_health_vector'),
    ('a_01750_legal_vector'),
    ('a_02050_it_vector'),
    ('a_02500_security_vector')
) AS target_tables(table_name)
LEFT JOIN information_schema.tables t
    ON t.table_name = target_tables.table_name
    AND t.table_schema = 'public'
LEFT JOIN pg_policies p
    ON p.tablename = target_tables.table_name;
"
```

#### Phase 2: Policy Conflict Resolution
```bash
# 2. Generate policy cleanup script
echo "=== POLICY CONFLICT RESOLUTION ==="
psql -d "$DATABASE_URL" -c "
-- Generate DROP POLICY statements for existing policies
SELECT
    'DROP POLICY IF EXISTS \"' || policyname || '\" ON ' || tablename || ';' as cleanup_statement
FROM pg_policies
WHERE tablename IN (
    'a_00800_design_vector', 'a_00872_developer_vector', 'a_00875_sales_vector',
    'a_00877_sundry_vector', 'a_00882_dirconst_vector', 'a_00895_dirproject_vector',
    'a_01000_environmental_vector', 'a_01300_governance_vector', 'a_01400_health_vector',
    'a_01750_legal_vector', 'a_02050_it_vector', 'a_02500_security_vector'
);
" > policy_cleanup.sql

# Execute policy cleanup
psql -d "$DATABASE_URL" -f policy_cleanup.sql
```

#### Phase 3: Safe Batch Execution
```bash
# 3. Execute batch with error handling
echo "=== SAFE BATCH EXECUTION ==="

# Create tables first (idempotent)
psql -d "$DATABASE_URL" -f vector_tables_creation_2025-12-22T08-47-23-793Z.sql

# Verify table creation
psql -d "$DATABASE_URL" -c "
SELECT
    'TABLE CREATION VERIFICATION' as check,
    COUNT(*) as tables_created
FROM information_schema.tables
WHERE table_name LIKE 'a_%_vector'
    AND table_schema = 'public'
    AND table_name IN (
        'a_00800_design_vector', 'a_00872_developer_vector', 'a_00875_sales_vector',
        'a_00877_sundry_vector', 'a_00882_dirconst_vector', 'a_00895_dirproject_vector',
        'a_01000_environmental_vector', 'a_01300_governance_vector', 'a_01400_health_vector',
        'a_01750_legal_vector', 'a_02050_it_vector', 'a_02500_security_vector'
    );
"
```

#### Phase 4: Policy Application
```bash
# 4. Apply policies in separate transaction
echo "=== POLICY APPLICATION ==="
psql -d "$DATABASE_URL" -c "
-- Apply RLS and policies
ALTER TABLE a_00800_design_vector ENABLE ROW LEVEL SECURITY;
ALTER TABLE a_00872_developer_vector ENABLE ROW LEVEL SECURITY;
ALTER TABLE a_00875_sales_vector ENABLE ROW LEVEL SECURITY;
-- ... continue for all tables

-- Apply policies with error handling
DO \$\$
DECLARE
    table_record RECORD;
BEGIN
    FOR table_record IN
        SELECT table_name
        FROM (VALUES
            ('a_00800_design_vector'), ('a_00872_developer_vector'), ('a_00875_sales_vector'),
            ('a_00877_sundry_vector'), ('a_00882_dirconst_vector'), ('a_00895_dirproject_vector'),
            ('a_01000_environmental_vector'), ('a_01300_governance_vector'), ('a_01400_health_vector'),
            ('a_01750_legal_vector'), ('a_02050_it_vector'), ('a_02500_security_vector')
        ) AS tables(table_name)
    LOOP
        -- Apply private access policy
        EXECUTE format('DROP POLICY IF EXISTS %I_private_access ON %I',
                      split_part(table_record.table_name, '_', 2) || '_' ||
                      split_part(table_record.table_name, '_', 3) || '_private',
                      table_record.table_name);

        EXECUTE format('CREATE POLICY %I_private_access ON %I FOR ALL USING (access_scope = ''private'' AND created_by_user_id::text = auth.uid()::text)',
                      split_part(table_record.table_name, '_', 2) || '_' ||
                      split_part(table_record.table_name, '_', 3) || '_private',
                      table_record.table_name);

        -- Apply shared access policy
        EXECUTE format('DROP POLICY IF EXISTS %I_shared_access ON %I',
                      split_part(table_record.table_name, '_', 2) || '_' ||
                      split_part(table_record.table_name, '_', 3) || '_shared',
                      table_record.table_name);

        EXECUTE format('CREATE POLICY %I_shared_access ON %I FOR SELECT USING (access_scope IN (''shared'', ''public'') OR created_by_user_id::text = auth.uid()::text)',
                      split_part(table_record.table_name, '_', 2) || '_' ||
                      split_part(table_record.table_name, '_', 3) || '_shared',
                      table_record.table_name);

        RAISE NOTICE 'Applied policies to: %', table_record.table_name;
    END LOOP;
END \$\$;
"
```

#### Phase 5: Batch Validation
```bash
# 5. Comprehensive batch validation
echo "=== BATCH VALIDATION ==="
psql -d "$DATABASE_URL" -c "
SELECT
    'BATCH IMPLEMENTATION VALIDATION' as validation,
    COUNT(*) as total_vector_tables,
    SUM(CASE WHEN rowsecurity THEN 1 ELSE 0 END) as rls_enabled_tables,
    SUM(CASE WHEN rowsecurity THEN 0 ELSE 1 END) as rls_disabled_tables,
    COUNT(DISTINCT p.tablename) as tables_with_policies
FROM information_schema.tables t
LEFT JOIN pg_policies p ON p.tablename = t.table_name
WHERE t.table_name LIKE 'a_%_vector'
    AND t.table_schema = 'public'
    AND t.table_name IN (
        'a_00800_design_vector', 'a_00872_developer_vector', 'a_00875_sales_vector',
        'a_00877_sundry_vector', 'a_00882_dirconst_vector', 'a_00895_dirproject_vector',
        'a_01000_environmental_vector', 'a_01300_governance_vector', 'a_01400_health_vector',
        'a_01750_legal_vector', 'a_02050_it_vector', 'a_02500_security_vector'
    )
GROUP BY t.table_schema;
"
```

### 🛡️ __Batch Implementation Error Handling__

#### Common Batch Errors and Solutions

**"Policy already exists" Error**
```bash
# Solution: Pre-clean policies before batch execution
psql -d "$DATABASE_URL" -c "
DO \$\$
DECLARE
    table_name TEXT;
BEGIN
    FOR table_name IN
        SELECT table_name
        FROM (VALUES
            ('a_00800_design_vector'), ('a_00872_developer_vector'), ('a_00875_sales_vector'),
            ('a_00877_sundry_vector'), ('a_00882_dirconst_vector'), ('a_00895_dirproject_vector'),
            ('a_01000_environmental_vector'), ('a_01300_governance_vector'), ('a_01400_health_vector'),
            ('a_01750_legal_vector'), ('a_02050_it_vector'), ('a_02500_security_vector')
        ) AS tables(table_name)
    LOOP
        EXECUTE format('DROP POLICY IF EXISTS %I_private_access ON %I',
                      split_part(table_name, '_', 2) || '_' ||
                      split_part(table_name, '_', 3) || '_private', table_name);
        EXECUTE format('DROP POLICY IF EXISTS %I_shared_access ON %I',
                      split_part(table_name, '_', 2) || '_' ||
                      split_part(table_name, '_', 3) || '_shared', table_name);
    END LOOP;
END \$\$;
"
```

**"Table already exists" Error**
```sql
-- Solution: Tables are created with IF NOT EXISTS, but check for schema differences
SELECT
    table_name,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name IN ('a_00800_design_vector', 'a_00872_developer_vector')
    AND table_schema = 'public'
ORDER BY table_name, ordinal_position;
```

**"Invalid regex pattern" Error**
```bash
# Solution: Remove invalid regex patterns from SQL files
sed -i '' '/DROP POLICY IF EXISTS "\[.*\]" ON a_\[.*\];/d' vector_tables_creation_*.sql
```

#### Batch Rollback Strategy
```bash
# Complete batch rollback if needed
echo "=== BATCH ROLLBACK ==="
psql -d "$DATABASE_URL" -c "
DO \$\$
DECLARE
    table_name TEXT;
BEGIN
    FOR table_name IN
        SELECT table_name
        FROM (VALUES
            ('a_00800_design_vector'), ('a_00872_developer_vector'), ('a_00875_sales_vector'),
            ('a_00877_sundry_vector'), ('a_00882_dirconst_vector'), ('a_00895_dirproject_vector'),
            ('a_01000_environmental_vector'), ('a_01300_governance_vector'), ('a_01400_health_vector'),
            ('a_01750_legal_vector'), ('a_02050_it_vector'), ('a_02500_security_vector')
        ) AS tables(table_name)
    LOOP
        -- Drop policies first
        EXECUTE format('DROP POLICY IF EXISTS %I_private_access ON %I',
                      split_part(table_name, '_', 2) || '_' ||
                      split_part(table_name, '_', 3) || '_private', table_name);
        EXECUTE format('DROP POLICY IF EXISTS %I_shared_access ON %I',
                      split_part(table_name, '_', 2) || '_' ||
                      split_part(table_name, '_', 3) || '_shared', table_name);

        -- Drop table
        EXECUTE format('DROP TABLE IF EXISTS %I CASCADE', table_name);

        RAISE NOTICE 'Rolled back: %', table_name;
    END LOOP;
END \$\$;
"
```

### 📊 __Batch Implementation Metrics__

#### Track Batch Progress
```bash
# Monitor batch implementation progress
psql -d "$DATABASE_URL" -c "
SELECT
    'BATCH PROGRESS MONITORING' as metric,
    COUNT(*) as total_target_tables,
    SUM(CASE WHEN t.table_name IS NOT NULL THEN 1 ELSE 0 END) as tables_created,
    SUM(CASE WHEN p.tablename IS NOT NULL THEN 1 ELSE 0 END) as tables_with_policies,
    SUM(CASE WHEN i.indexname IS NOT NULL THEN 1 ELSE 0 END) as tables_with_indexes,
    ROUND(
        SUM(CASE WHEN t.table_name IS NOT NULL AND p.tablename IS NOT NULL THEN 1 ELSE 0 END)::numeric
        / COUNT(*)::numeric * 100, 1
    ) as completion_percentage
FROM (VALUES
    ('a_00800_design_vector'), ('a_00872_developer_vector'), ('a_00875_sales_vector'),
    ('a_00877_sundry_vector'), ('a_00882_dirconst_vector'), ('a_00895_dirproject_vector'),
    ('a_01000_environmental_vector'), ('a_01300_governance_vector'), ('a_01400_health_vector'),
    ('a_01750_legal_vector'), ('a_02050_it_vector'), ('a_02500_security_vector')
) AS target_tables(table_name)
LEFT JOIN information_schema.tables t
    ON t.table_name = target_tables.table_name AND t.table_schema = 'public'
LEFT JOIN pg_policies p ON p.tablename = target_tables.table_name
LEFT JOIN pg_indexes i
    ON i.tablename = target_tables.table_name
    AND i.indexname LIKE 'idx_%';
"
```

#### Generate Batch Completion Report
```bash
# Generate comprehensive batch completion report
psql -d "$DATABASE_URL" -c "
SELECT
    'BATCH COMPLETION REPORT' as report_title,
    CURRENT_TIMESTAMP as report_generated_at,
    COUNT(*) as total_operations_attempted,
    SUM(CASE WHEN status = 'SUCCESS' THEN 1 ELSE 0 END) as successful_operations,
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) as failed_operations,
    SUM(CASE WHEN status = 'SKIPPED' THEN 1 ELSE 0 END) as skipped_operations,
    ROUND(
        SUM(CASE WHEN status = 'SUCCESS' THEN 1 ELSE 0 END)::numeric
        / COUNT(*)::numeric * 100, 2
    ) as success_rate_percentage
FROM batch_execution_log
WHERE batch_id = (SELECT MAX(batch_id) FROM batch_execution_log);
"
```

### 🎯 __Batch Implementation Best Practices__

**CRITICAL REQUIREMENTS for Batch Operations:**

1. **Pre-Flight Analysis**: Always analyze target tables for conflicts before execution
2. **Policy Cleanup**: Drop existing policies before applying new ones
3. **Idempotent Operations**: Use `IF NOT EXISTS` and `IF EXISTS` constructs
4. **Error Isolation**: Execute table creation and policy application separately
5. **Progress Monitoring**: Track completion status throughout the batch
6. **Rollback Strategy**: Maintain ability to completely rollback if needed
7. **Validation Testing**: Test each component after implementation

**Batch Size Guidelines:**
- **Small Batches (< 10 tables)**: Execute all operations in single transaction
- **Medium Batches (10-50 tables)**: Execute tables first, then policies separately
- **Large Batches (> 50 tables)**: Phase execution with validation checkpoints

**Error Recovery Strategy:**
- **Table Creation Failure**: Skip to policy application (may already exist)
- **Policy Application Failure**: Re-run policy cleanup, then reapply
- **Index Creation Failure**: Non-critical, log and continue
- **Complete Failure**: Execute full rollback, investigate root cause

## 🛡️ __ERROR HANDLING & RECOVERY__

### Immediate Error Response

```bash
# If any command fails, immediately:
echo "❌ DEPLOYMENT FAILED - Initiating rollback"

# Option 1: Restore from backup
psql -d "$DATABASE_URL" < backup_file.sql

# Option 2: Drop created objects
psql -d "$DATABASE_URL" -c "DROP TABLE IF EXISTS tasks CASCADE; DROP TABLE IF EXISTS task_comments CASCADE;"

# Then investigate the error
tail -f /var/log/postgresql/postgresql.log  # or equivalent
```

### Common Error Scenarios

__"operator does not exist: uuid = text"__

```sql
-- ERROR: operator does not exist: uuid = text
-- HINT: No operator matches the given name and argument types. You might need to add explicit type casts.

-- Common cause: auth.uid() returns TEXT but comparing to UUID column
SELECT * FROM users WHERE id = auth.uid();  -- ❌ FAILS

-- Solutions:
SELECT * FROM users WHERE id = auth.uid()::UUID;                    -- ✅ CAST auth.uid() to UUID
SELECT * FROM users WHERE id::TEXT = auth.uid()::TEXT;             -- ✅ CAST column to TEXT
SELECT * FROM users WHERE id = auth.uid()::TEXT::UUID;             -- ✅ Double cast if needed

-- RLS Policy examples:
-- ❌ BROKEN: Type mismatch
CREATE POLICY user_access ON users FOR SELECT USING (id = auth.uid());

-- ✅ FIXED: Explicit casting
CREATE POLICY user_access ON users FOR SELECT USING (id = auth.uid()::UUID);
CREATE POLICY user_access ON users FOR SELECT USING (id::TEXT = auth.uid());
```

__"Permission denied for schema public"__

```bash
# Solution: Use superuser or grant permissions
psql -d "$DATABASE_URL" -c "GRANT ALL ON SCHEMA public TO current_user;"
psql -d "$DATABASE_URL" -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO current_user;"
```

__"Relation already exists"__

```bash
# Solution: Check for existing objects
psql -d "$DATABASE_URL" -c "\dt" | grep tasks
psql -d "$DATABASE_URL" -c "DROP TABLE IF EXISTS tasks CASCADE;"
```

__"Invalid foreign key reference"__

```bash
# Solution: Verify referenced tables exist and have data
psql -d "$DATABASE_URL" -c "\dt organizations"
psql -d "$DATABASE_URL" -c "SELECT COUNT(*) FROM organizations;"
```

## 📊 __POST-DEPLOYMENT VERIFICATION__

### Automated Verification Script

```bash
# Run comprehensive checks
echo "=== POST-DEPLOYMENT VERIFICATION ==="

# 1. Table existence
psql -d "$DATABASE_URL" -c "
SELECT 'Tables created:' as check;
SELECT tablename FROM pg_tables WHERE schemaname = 'public'
AND tablename IN ('tasks', 'task_comments', 'task_history', 'task_attachments', 'sow_appendices', 'quality_checks');
"

# 2. Data integrity
psql -d "$DATABASE_URL" -c "
SELECT 'Data integrity:' as check;
SELECT COUNT(*) as tasks_count FROM tasks;
SELECT COUNT(*) as users_count FROM user_management;
SELECT COUNT(*) as orgs_count FROM organizations;
"

# 3. Foreign key validation
psql -d "$DATABASE_URL" -c "
SELECT 'Foreign keys valid:' as check;
SELECT COUNT(*) as orphaned_tasks
FROM tasks t
WHERE NOT EXISTS (SELECT 1 FROM organizations o WHERE o.id = t.organization_id);
"
```

### Manual Verification Steps

1. __Connect to database__ and verify tables exist
2. __Check row counts__ match expectations
3. __Test foreign key relationships__ are intact
4. __MANDATORY: Verify RLS policies__ are applied correctly
5. __MANDATORY: Run security audit__ with `extract_rls_policy_inventory()`
6. __Test basic queries__ perform as expected
7. __Test RLS enforcement__ by attempting unauthorized access

## 🔄 __MIGRATION SYSTEM SPECIFIC PROCEDURES__

### 🚨 __Migration System Challenges__

Migration systems face unique challenges that standard SQL execution doesn't encounter:

1. __Schema Variations__: Different environments have varying table schemas
2. __Column Existence__: Missing columns cause migration failures
3. __Data Type Mismatches__: Incompatible data types between source and target
4. __Foreign Key Dependencies__: Circular or broken foreign key relationships
5. __Business Logic Dependencies__: Migration depends on existing business rules
6. __Data Volume__: Large datasets require chunking and performance considerations

### 🔍 __Table Discovery and Field Mapping Analysis__

#### Automatic Table Discovery

```sql
-- Discover all tables that could be migration sources
SELECT 
  table_name,
  table_schema,
  table_type,
  CASE 
    WHEN EXISTS (
      SELECT 1 FROM information_schema.columns ic2 
      WHERE ic2.table_name = it.table_name 
      AND ic2.table_schema = it.table_schema
      AND ic2.column_name IN ('organization_id', 'created_by', 'updated_at')
    ) THEN '✅ POTENTIAL MIGRATION SOURCE'
    ELSE '❌ NOT MIGRATION SOURCE'
  END as migration_potential
FROM information_schema.tables it
WHERE it.table_schema = 'public'
  AND it.table_type = 'BASE TABLE'
  AND it.table_name NOT LIKE 'pg_%'
  AND it.table_name NOT IN ('migration_state', 'migration_audit_log')
ORDER BY it.table_name;
```

#### Field Mapping Analysis

```sql
-- Analyze field mappings between source and target tables
WITH source_fields AS (
  SELECT 
    table_name,
    column_name,
    data_type,
    is_nullable,
    column_default
  FROM information_schema.columns
  WHERE table_schema = 'public'
    AND table_name IN ('quality_checks', 'safety_incidents', 'legal_reviews')
),
target_fields AS (
  SELECT 
    'tasks' as table_name,
    column_name,
    data_type,
    is_nullable,
    column_default
  FROM information_schema.columns
  WHERE table_schema = 'public'
    AND table_name = 'tasks'
)
SELECT 
  s.table_name as source_table,
  s.column_name as source_field,
  s.data_type as source_type,
  t.column_name as target_field,
  t.data_type as target_type,
  CASE 
    WHEN s.data_type = t.data_type THEN '✅ COMPATIBLE'
    WHEN s.data_type = 'character varying' AND t.data_type = 'text' THEN '⚠️ CONVERTIBLE'
    WHEN s.data_type = 'integer' AND t.data_type = 'bigint' THEN '⚠️ CONVERTIBLE'
    WHEN s.data_type = 'timestamp with time zone' AND t.data_type = 'timestamp without time zone' THEN '⚠️ CONVERTIBLE'
    ELSE '❌ INCOMPATIBLE'
  END as compatibility_status,
  CASE 
    WHEN s.is_nullable != t.is_nullable THEN '⚠️ NULLABILITY MISMATCH'
    ELSE '✅ NULLABILITY MATCH'
  END as nullability_status
FROM source_fields s
LEFT JOIN target_fields t ON s.column_name = t.column_name
ORDER BY s.table_name, s.column_name;
```

#### Data Type Compatibility Matrix

```sql
-- Create a comprehensive data type compatibility matrix
SELECT 
  source_type,
  target_type,
  CASE 
    WHEN source_type = target_type THEN 'DIRECT_MAP'
    WHEN source_type = 'character varying' AND target_type IN ('text', 'varchar') THEN 'CONVERTIBLE'
    WHEN source_type = 'integer' AND target_type IN ('bigint', 'numeric') THEN 'CONVERTIBLE'
    WHEN source_type = 'timestamp with time zone' AND target_type IN ('timestamp without time zone', 'timestamptz') THEN 'CONVERTIBLE'
    WHEN source_type = 'boolean' AND target_type IN ('text', 'varchar') THEN 'CONVERTIBLE_WITH_CAST'
    WHEN source_type = 'uuid' AND target_type = 'text' THEN 'CONVERTIBLE_WITH_CAST'
    WHEN source_type = 'text' AND target_type = 'uuid' THEN 'CONVERTIBLE_WITH_CAST'
    ELSE 'NOT_COMPATIBLE'
  END as conversion_strategy,
  conversion_function
FROM (
  VALUES 
    ('character varying', 'text', 'CONVERTIBLE', 'CAST(column AS TEXT)'),
    ('integer', 'bigint', 'CONVERTIBLE', 'CAST(column AS BIGINT)'),
    ('timestamp with time zone', 'timestamp without time zone', 'CONVERTIBLE', 'CAST(column AS TIMESTAMP)'),
    ('boolean', 'text', 'CONVERTIBLE_WITH_CAST', 'CASE WHEN column THEN ''true'' ELSE ''false'' END'),
    ('uuid', 'text', 'CONVERTIBLE_WITH_CAST', 'CAST(column AS TEXT)')
) AS compatibility_matrix(source_type, target_type, conversion_strategy, conversion_function);
```

#### Field Mapping Validation Query

```sql
-- Comprehensive field mapping validation
DO $$
DECLARE
  source_table TEXT := 'quality_checks';
  target_table TEXT := 'tasks';
  mapping_report JSON;
BEGIN
  -- Build mapping validation report
  WITH field_analysis AS (
    SELECT 
      s.column_name as source_field,
      s.data_type as source_type,
      s.is_nullable as source_nullable,
      t.column_name as target_field,
      t.data_type as target_type,
      t.is_nullable as target_nullable,
      CASE 
        WHEN s.column_name = t.column_name AND s.data_type = t.data_type THEN 'DIRECT_MAP'
        WHEN s.column_name = t.column_name AND s.data_type != t.data_type THEN 'TYPE_CONVERSION_NEEDED'
        WHEN s.column_name != t.column_name AND EXISTS (
          SELECT 1 FROM information_schema.columns ic2 
          WHERE ic2.table_name = target_table 
          AND ic2.column_name LIKE '%' || s.column_name || '%'
        ) THEN 'FIELD_RENAMED'
        ELSE 'NO_MATCH'
      END as mapping_strategy
    FROM information_schema.columns s
    LEFT JOIN information_schema.columns t ON t.table_name = target_table
    WHERE s.table_name = source_table 
      AND s.table_schema = 'public'
      AND (t.table_name = target_table OR t.table_name IS NULL)
  ),
  compatibility_check AS (
    SELECT 
      source_field,
      source_type,
      target_field,
      target_type,
      mapping_strategy,
      CASE 
        WHEN mapping_strategy = 'DIRECT_MAP' THEN '✅ READY'
        WHEN mapping_strategy = 'TYPE_CONVERSION_NEEDED' THEN '⚠️ NEEDS_CONVERSION'
        WHEN mapping_strategy = 'FIELD_RENAMED' THEN '⚠️ FIELD_RENAME_NEEDED'
        ELSE '❌ NO_MAPPING_FOUND'
      END as readiness_status,
      CASE 
        WHEN mapping_strategy IN ('DIRECT_MAP', 'TYPE_CONVERSION_NEEDED', 'FIELD_RENAMED') THEN 'MIGRATABLE'
        ELSE 'BLOCKING_ISSUE'
      END as migration_blocker
    FROM field_analysis
  )
  SELECT json_agg(
    json_build_object(
      'source_field', source_field,
      'source_type', source_type,
      'target_field', target_field,
      'target_type', target_type,
      'mapping_strategy', mapping_strategy,
      'readiness_status', readiness_status,
      'migration_blocker', migration_blocker
    )
  ) INTO mapping_report
  FROM compatibility_check;
  
  RAISE NOTICE 'Field Mapping Analysis for % -> %:', source_table, target_table;
  RAISE NOTICE '%', mapping_report::TEXT;
  
  -- Generate migration recommendations
  PERFORM generate_migration_recommendations(source_table, target_table, mapping_report);
END $$;

-- Function to generate migration recommendations
CREATE OR REPLACE FUNCTION generate_migration_recommendations(
  p_source_table TEXT,
  p_target_table TEXT,
  p_mapping_report JSON
) RETURNS TEXT AS $$
DECLARE
  recommendations TEXT := '';
  mapping_item JSON;
BEGIN
  recommendations := 'MIGRATION RECOMMENDATIONS FOR ' || p_source_table || ' -> ' || p_target_table || E'\n';
  recommendations := recommendations || '==========================================================' || E'\n';
  
  FOR mapping_item IN SELECT * FROM json_array_elements(p_mapping_report) LOOP
    IF (mapping_item->>'migration_blocker') = 'BLOCKING_ISSUE' THEN
      recommendations := recommendations || '❌ BLOCKING: ' || (mapping_item->>'source_field') || ' (' || (mapping_item->>'source_type') || ') - No mapping found' || E'\n';
    ELSIF (mapping_item->>'readiness_status') = '⚠️ NEEDS_CONVERSION' THEN
      recommendations := recommendations || '⚠️ CONVERSION: ' || (mapping_item->>'source_field') || ' -> ' || (mapping_item->>'target_field') || ' (' || (mapping_item->>'source_type') || ' -> ' || (mapping_item->>'target_type') || ')' || E'\n';
    ELSIF (mapping_item->>'readiness_status') = '⚠️ FIELD_RENAME_NEEDED' THEN
      recommendations := recommendations || '⚠️ RENAME: ' || (mapping_item->>'source_field') || ' -> ' || (mapping_item->>'target_field') || E'\n';
    ELSE
      recommendations := recommendations || '✅ DIRECT: ' || (mapping_item->>'source_field') || E'\n';
    END IF;
  END LOOP;
  
  RETURN recommendations;
END;
$$ LANGUAGE plpgsql;
```

### 🛡️ __Defensive Migration Patterns__

#### Pattern 1: Conditional Column Existence

```sql
-- SAFE: Check column existence before referencing
CASE
  WHEN EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'quality_checks' 
    AND column_name = 'priority' 
    AND table_schema = 'public'
  )
  THEN CASE
    WHEN qc.priority = 'urgent' THEN 'urgent'
    WHEN qc.priority = 'high' THEN 'high'
    ELSE 'normal'
  END
  ELSE 'normal'  -- Default when column missing
END
```

#### Pattern 2: Safe Table Existence

```sql
-- SAFE: Only migrate if table exists with required columns
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.tables 
    WHERE table_name = 'quality_checks' 
    AND table_schema = 'public'
  ) THEN
    -- Check if critical columns exist
    IF EXISTS (
      SELECT 1 FROM information_schema.columns 
      WHERE table_name = 'quality_checks' 
      AND column_name = 'priority' 
      AND table_schema = 'public'
    ) THEN
      RAISE NOTICE 'Migrating quality_checks table...';
      -- Perform migration
    ELSE
      RAISE NOTICE 'quality_checks.priority missing - skipping migration';
    END IF;
  ELSE
    RAISE NOTICE 'quality_checks table does not exist - skipping migration';
  END IF;
END $$;
```

#### Pattern 3: Graceful Data Handling

```sql
-- SAFE: Handle missing or null data gracefully
SELECT
  COALESCE(qc.organization_id, 'default-org-uuid') as organization_id,
  COALESCE(qc.priority, 'normal') as priority,
  CASE
    WHEN qc.description IS NOT NULL 
    THEN substring(qc.description, 1, 200)
    ELSE 'Default description'
  END as description
FROM quality_checks qc;
```

#### Pattern 4: Chunked Migration for Large Datasets

```sql
-- SAFE: Process large tables in chunks
DO $$
DECLARE
  batch_size INTEGER := 1000;
  total_rows INTEGER;
  processed_rows INTEGER := 0;
BEGIN
  SELECT COUNT(*) INTO total_rows FROM large_source_table;
  
  WHILE processed_rows < total_rows LOOP
    INSERT INTO target_table (id, name, created_at)
    SELECT id, name, created_at
    FROM large_source_table
    ORDER BY id
    LIMIT batch_size
    OFFSET processed_rows;
    
    processed_rows := processed_rows + batch_size;
    RAISE NOTICE 'Processed % of % rows', processed_rows, total_rows;
  END LOOP;
  
  RAISE NOTICE 'Migration completed: % rows processed', total_rows;
END $$;
```

### ⚡ __Migration Optimization Strategies__

#### Index Strategy for Migrations

```sql
-- Create indexes before migration for better performance
CREATE INDEX IF NOT EXISTS idx_source_table_org_id ON source_table(organization_id);
CREATE INDEX IF NOT EXISTS idx_source_table_status ON source_table(status);
CREATE INDEX IF NOT EXISTS idx_target_table_org_type ON target_table(organization_id, record_type);

-- After migration, create additional indexes for query performance
CREATE INDEX IF NOT EXISTS idx_target_table_relationships ON target_table(foreign_key_columns);
```

#### Performance Monitoring

```bash
# Monitor migration performance
psql -d "$DATABASE_URL" -c "
SELECT
  schemaname,
  tablename,
  n_tup_ins as inserts,
  n_tup_upd as updates,
  n_tup_del as deletes,
  extract(epoch from now() - last_analyze) / 3600 as hours_since_analyze
FROM pg_stat_user_tables
WHERE schemaname = 'public'
ORDER BY n_tup_ins DESC;
"
```

## 🐘 __POSTGRESQL-SPECIFIC REQUIREMENTS__

### Critical PostgreSQL Implementation Rules

__MANDATORY: PostgreSQL has specific syntax and operational requirements that differ from standard SQL.__

#### 1. PL/pgSQL Type System Requirements

**PL/pgSQL Variable Type Matching**
```sql
-- ✅ CORRECT: Variable type matches array element type
DO $$
DECLARE
    discipline_config TEXT;  -- TEXT matches TEXT[] array
    discipline_configs TEXT[] := ARRAY['01900_procurement', '00435_contracts_post'];
BEGIN
    FOREACH discipline_config IN ARRAY discipline_configs LOOP
        -- Safe: TEXT variable holds TEXT values
    END LOOP;
END $$;

-- ❌ INCORRECT: Type mismatch causes runtime error
DO $$
DECLARE
    discipline_config RECORD;  -- RECORD cannot hold TEXT values
    discipline_configs TEXT[] := ARRAY['01900_procurement', '00435_contracts_post'];
BEGIN
    FOREACH discipline_config IN ARRAY discipline_configs LOOP
        -- ERROR: "cannot assign non-composite value to a record variable"
    END LOOP;
END $$;
```

**Type Casting Requirements**
```sql
-- ✅ CORRECT: Explicit casting for type comparisons
SELECT * FROM users WHERE id::TEXT = 'some-uuid-string';

-- ✅ CORRECT: Cast to compatible types
SELECT * FROM users WHERE id = '550e8400-e29b-41d4-a716-446655440000'::UUID;

-- ❌ INCORRECT: Implicit type coercion fails
SELECT * FROM users WHERE id = '550e8400-e29b-41d4-a716-446655440000';
-- ERROR: "operator does not exist: uuid = text"
```

#### 2. DDL Operations in Transaction Blocks

**Transaction DDL Limitations**
```sql
-- ✅ CORRECT: Standard DDL in transactions
BEGIN;
CREATE TABLE test_table (id UUID PRIMARY KEY);
CREATE INDEX idx_test ON test_table(id);  -- Works in transaction
COMMIT;

-- ❌ INCORRECT: CONCURRENTLY DDL in transactions
BEGIN;
CREATE INDEX CONCURRENTLY idx_test ON test_table(id);  -- BLOCKED
-- ERROR: "CREATE INDEX CONCURRENTLY cannot run inside a transaction block"
COMMIT;

-- ✅ CORRECT: CONCURRENTLY DDL outside transactions
CREATE INDEX CONCURRENTLY idx_test ON test_table(id);  -- Works outside transaction
```

#### 3. PostgreSQL-Specific Syntax Rules

**Dynamic SQL Execution**
```sql
-- ✅ CORRECT: Proper EXECUTE syntax
DO $$
DECLARE
    table_name TEXT := 'test_table';
BEGIN
    EXECUTE format('CREATE INDEX IF NOT EXISTS idx_%I ON %I(id)', table_name, table_name);
END $$;

-- ❌ INCORRECT: Missing EXECUTE for dynamic DDL
DO $$
DECLARE
    table_name TEXT := 'test_table';
BEGIN
    CREATE INDEX IF NOT EXISTS idx_test_table ON test_table(id);  -- Static, not dynamic
END $$;
```

**Array Operations**
```sql
-- ✅ CORRECT: Array element access
DO $$
DECLARE
    my_array TEXT[] := ARRAY['item1', 'item2'];
    first_item TEXT;
BEGIN
    first_item := my_array[1];  -- PostgreSQL arrays are 1-indexed
END $$;

-- ❌ INCORRECT: Wrong array indexing
DO $$
DECLARE
    my_array TEXT[] := ARRAY['item1', 'item2'];
    first_item TEXT;
BEGIN
    first_item := my_array[0];  -- PostgreSQL arrays start at 1, not 0
END $$;
```

### PostgreSQL-Specific Error Prevention Checklist

**MANDATORY: Complete this PostgreSQL-specific checklist**

- [ ] __PL/pgSQL Types__: All FOREACH loop variables match array element types
- [ ] __Transaction DDL__: No `CONCURRENTLY` operations in transaction blocks
- [ ] __Type Casting__: All cross-type comparisons use explicit casting (`::UUID`, `::TEXT`, etc.)
- [ ] __Dynamic SQL__: DDL in dynamic SQL uses `EXECUTE` with proper `format()` functions
- [ ] __Array Indexing__: PostgreSQL arrays use 1-based indexing (`array[1]`, not `array[0]`)
- [ ] __Schema Qualification__: All table references include schema (`public.table_name`)
- [ ] __Function Volatility__: Proper `LANGUAGE plpgsql SECURITY DEFINER` for custom functions

### Common PostgreSQL Error Patterns

| **Error Pattern** | **Cause** | **Solution** |
|-------------------|-----------|-------------|
| `cannot assign non-composite value to a record variable` | `RECORD` variable in `FOREACH` loop | Change to matching type (`TEXT`, `INTEGER`, etc.) |
| `operator does not exist: uuid = text` | Type mismatch in comparison | Add explicit casting (`::UUID`, `::TEXT`) |
| `CREATE INDEX CONCURRENTLY cannot run inside a transaction block` | DDL limitation | Remove `CONCURRENTLY` or move outside transaction |
| `array subscript out of range` | 0-based indexing on 1-based arrays | Use `array[1]` instead of `array[0]` |
| `relation "table_name" does not exist` | Missing schema qualification | Use `public.table_name` or proper search_path |

### PostgreSQL-Specific Testing Commands

```bash
# Test PL/pgSQL type safety
psql -d "$DATABASE_URL" -c "
DO \$\$
DECLARE
    test_var TEXT;
    test_array TEXT[] := ARRAY['test'];
BEGIN
    FOREACH test_var IN ARRAY test_array LOOP
        RAISE NOTICE 'Type test passed: %', test_var;
    END LOOP;
END \$\$;
"

# Test transaction DDL limitations
psql -d "$DATABASE_URL" -c "
-- This should work
CREATE TABLE IF NOT EXISTS pg_test_table (id UUID PRIMARY KEY DEFAULT gen_random_uuid());
CREATE INDEX IF NOT EXISTS idx_pg_test ON pg_test_table(id);

-- This would fail in a transaction
-- CREATE INDEX CONCURRENTLY idx_pg_test_concurrent ON pg_test_table(id);
"

# Test type casting
psql -d "$DATABASE_URL" -c "
DO \$\$
DECLARE
    uuid_val UUID := '550e8400-e29b-41d4-a716-446655440000'::UUID;
    text_val TEXT := '550e8400-e29b-41d4-a716-446655440000';
BEGIN
    -- Test explicit casting works
    IF uuid_val = text_val::UUID THEN
        RAISE NOTICE 'Type casting test passed';
    END IF;
END \$\$;
"
```

### PostgreSQL Version Compatibility

**Important**: These rules apply to PostgreSQL 12+. For different versions:

- **PostgreSQL 11 and earlier**: More restrictive DDL in transactions
- **PostgreSQL 13+**: Enhanced CONCURRENTLY operations
- **PostgreSQL 14+**: Improved array and JSON operations

**Always test PostgreSQL-specific operations on your target version before deployment.**

### Emergency PostgreSQL Debugging

```bash
# Get PostgreSQL version and configuration
psql -d "$DATABASE_URL" -c "SELECT version(); SHOW server_version;"

# Check current transaction status
psql -d "$DATABASE_URL" -c "
SELECT
    pid,
    state,
    query,
    CASE WHEN state = 'idle in transaction' THEN '⚠️ POTENTIAL ISSUE' ELSE '✅ OK' END as status
FROM pg_stat_activity
WHERE pid = pg_backend_pid();
"

# Analyze recent errors
psql -d "$DATABASE_URL" -c "
SELECT
    created,
    message,
    detail,
    hint
FROM pg_log
WHERE message LIKE '%ERROR%'
ORDER BY created DESC
LIMIT 10;
"
```
