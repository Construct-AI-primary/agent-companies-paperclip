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

# JavaScript Data Population Procedure - Supabase API Data Deployment

__CRITICAL__: This procedure incorporates lessons from massive JavaScript data population failures and persistent error patterns. Follow this exact workflow to prevent errors and ensure successful API-based data deployments.

---

## __Correct Procedure to Use:__

This procedure is for __**JavaScript/Node.js data population scripts**__ that use API-based operations with RLS enforcement.

**❌ DO NOT use this procedure for:**
- Schema creation (`CREATE TABLE`, `CREATE INDEX`)
- RLS policy setup (`ALTER TABLE ENABLE ROW LEVEL SECURITY`)
- Infrastructure operations (direct database operations)
- Bulk data loading via SQL

**For infrastructure/schema operations, use `0000_SQL_EXECUTION_PROCEDURE.md` instead.**

## __When to Use Each Procedure:__

| __Script Type__ | __Procedure__ | __Example__ |
|----------------|---------------|-------------|
| __Schema Creation__ | `0000_SQL_EXECUTION_PROCEDURE.md` | `CREATE TABLE custom_assignments` |
| __Data Population__ | `0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md` | API-based data insertion |
| __RLS Policy Setup__ | `0000_SQL_EXECUTION_PROCEDURE.md` | `ALTER TABLE ENABLE ROW LEVEL SECURITY` |
| __Bulk Data Loading__ | `0000_SQL_EXECUTION_PROCEDURE.md` | Large dataset imports |
| __API Data Insertion__ | `0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md` | RLS-enforced record creation |

**Example: The `custom_assignments_table.sql` script uses `0000_SQL_EXECUTION_PROCEDURE.md` because it creates schema/infrastructure, not application data population.** 🎯

---

## 🎯 __WHEN TO USE SQL VS JAVASCRIPT FOR DATA POPULATION__

### **Decision Framework: SQL vs JavaScript**

| **Criteria** | **Use SQL** | **Use JavaScript** |
|--------------|-------------|-------------------|
| **Data Volume** | Large datasets (1000+ records) | Small to medium datasets (<1000 records) |
| **Complexity** | Simple bulk inserts | Complex business logic, data transformation |
| **Performance** | High-throughput bulk operations | Rate-limited API operations |
| **Dependencies** | No external dependencies | API calls, external services, complex validation |
| **Environment** | Direct database access | Remote/API access only |
| **Security** | Database-level operations | RLS-enforced operations |
| **Transactions** | Multi-table transactions | Single-record operations |
| **Error Recovery** | Transaction rollback | Record-by-record error handling |
| **Maintenance** | Schema changes, migrations | Application data population |
| **RLS Policies** | Must handle/disable policies manually | Policies automatically enforced |

### **SQL Approach - When to Choose:**

**✅ BEST FOR:**
- **Schema Setup & Migrations**: Creating tables, indexes, constraints
- **Bulk Data Loading**: Large-scale data imports (>1000 records)
- **Complex Relationships**: Multi-table transactions with foreign keys
- **Performance-Critical**: High-throughput data operations
- **Direct Database Access**: When you have psql or direct DB access

**📋 EXAMPLE USE CASES:**
```sql
-- Schema creation and migrations
-- Bulk loading of reference data
-- Complex data transformations
-- Multi-table relationship setup
```

**🔧 TOOLS:**
- `psql` command line
- SQL files (`.sql`)
- Database migration tools
- Direct Supabase SQL editor

### **JavaScript Approach - When to Choose:**

**✅ BEST FOR:**
- **API-Based Operations**: When direct DB access unavailable
- **RLS-Enforced Data**: Organization-scoped data insertion
- **Complex Validation**: Business logic validation during insertion
- **External Dependencies**: API calls, file processing, external services
- **Error Resilience**: Individual record error handling and recovery
- **Progressive Loading**: Rate-limited operations with progress tracking

**📋 EXAMPLE USE CASES:**
```javascript
// API-based data population
// Organization-scoped data insertion
// Complex data transformation with external APIs
// Progressive loading with user feedback
// Data validation with business rules
```

**🔧 TOOLS:**
- Node.js scripts
- Supabase JavaScript client
- API-based operations
- Progress tracking and monitoring

### **Hybrid Approach - When Both Are Needed:**

**For complex deployments, use both approaches:**
1. **SQL First**: Schema setup, bulk reference data
2. **JavaScript Second**: Application data, API-dependent records

**Example Workflow:**
```bash
# Phase 1: SQL for infrastructure
psql -d "$DATABASE_URL" -f schema_setup.sql
psql -d "$DATABASE_URL" -f bulk_reference_data.sql

# Phase 2: JavaScript for application data
node populate-organization-data.js
node populate-user-permissions.js
```

### **Migration Path Decision Tree:**

```
Need to populate data?
├── Direct DB access available?
│   ├── Yes → Large dataset or schema changes?
│   │   ├── Yes → Use SQL approach
│   │   └── No → Simple inserts?
│   │       ├── Yes → Use SQL approach
│   │       └── No → Use JavaScript approach
│   └── No → API access only?
│       ├── Yes → Use JavaScript approach
│       └── No → ERROR: No data access method available
└── No data population needed
```

### **Cost-Benefit Analysis:**

**SQL Advantages:**
- ⚡ **Performance**: 10-100x faster for bulk operations
- 🔒 **Security**: Direct database control
- 🎯 **Precision**: Exact control over data insertion
- 📊 **Monitoring**: Built-in database performance metrics

**JavaScript Advantages:**
- 🌐 **Flexibility**: API-based, works anywhere
- 🛡️ **Safety**: RLS enforcement, organization isolation
- 🔄 **Resilience**: Individual error handling and recovery
- 📈 **Monitoring**: Custom progress tracking and logging

**Choose SQL when performance and control are critical. Choose JavaScript when safety, flexibility, and API integration are required.**

---

## 🚨 __CRITICAL DEVELOPER NOTIFICATIONS__

### **🔴 IMMEDIATE SECURITY ACTIONS REQUIRED**

**MAJOR SECURITY BREACH RISK: 275+ database tables lack Row Level Security (RLS) policies!**

| **Risk Level** | **Tables Affected** | **Impact** | **Action Required** |
|----------------|-------------------|------------|-------------------|
| **🔴 EXTREME** | 15+ financial tables | Complete financial data exposure | **IMMEDIATE: Apply RLS policies** |
| **🔴 EXTREME** | 20+ user credential tables | Authentication compromise | **IMMEDIATE: Secure user data** |
| **🔴 EXTREME** | 25+ business intelligence tables | Trade secret exposure | **IMMEDIATE: Apply data isolation** |
| **🟠 HIGH** | 100+ operational tables | Unauthorized data access | **HIGH PRIORITY: Review and secure** |
| **🟡 MEDIUM** | 150+ reference tables | Information leakage | **PLAN: Security audit** |

**📞 IMMEDIATE ACTION:** Contact security team for emergency RLS policy deployment.

**Reference:** `0000_TABLE_POLICIES_SECURITY_PROCEDURE.md` - Complete security audit and remediation guide.

### **📚 CRITICAL DOCUMENTATION GAPS**

**400+ documentation files exist but only 50 are referenced in master guides!**

| **Gap Category** | **Actual Files** | **Referenced** | **Missing** | **Impact** |
|------------------|------------------|---------------|-------------|------------|
| **Procedure Docs** | 25+ | 8 | **17** | Critical operational procedures undocumented |
| **Error Tracking** | 33+ | 1 | **32** | Troubleshooting knowledge scattered |
| **Business Logic** | 29+ | 3 | **26** | Application behavior not documented |
| **Security Policies** | 11+ | 2 | **9** | Access control procedures missing |
| **UI Components** | 71+ | 15 | **56** | Component usage undocumented |

**📞 ACTION:** Use `docs/0000_DOCUMENTATION_MASTER_GUIDE.md` for complete file inventory and navigation assistance.

### **🐛 KNOWN SYSTEM ISSUES**

#### **High-Impact Bugs Requiring Immediate Attention:**

1. **Tasks Table RLS Blockage** 🚨
   - **Issue**: RLS policies prevent development access to tasks
   - **Impact**: My Tasks Dashboard shows no data
   - **Status**: Partially resolved, monitor for regression
   - **Reference**: `0000_TABLE_POLICIES_SECURITY_PROCEDURE.md` → Tasks RLS Fix

2. **Form Save Failures** 🚨
   - **Issue**: Complex RLS policies break procurement form submissions
   - **Impact**: Users cannot save procurement data
   - **Status**: Workarounds implemented, permanent fix pending
   - **Reference**: Procurement error tracking documents

3. **Vector Search Performance** ⚠️
   - **Issue**: RLS policies causing slow AI document searches
   - **Impact**: Degraded search performance
   - **Status**: Optimization planned
   - **Reference**: Vector system documentation

#### **Development Environment Warnings:**

- **🔶 Dev Mode Bypass**: Ensure `is_dev_mode()` function returns `true` for development access
- **🔶 Organization Headers**: Always include `x-organization-id` in API requests
- **🔶 Rate Limiting**: Monitor API usage to prevent 429 errors
- **🔶 Schema Changes**: Backup before any database modifications

### **📋 OUTSTANDING ACTIONS FOR DEVELOPERS**

#### **This Week (High Priority):**
- [ ] **Security Audit**: Review `0000_TABLE_POLICIES_SECURITY_PROCEDURE.md`
- [ ] **Documentation Navigation**: Study `docs/0000_DOCUMENTATION_MASTER_GUIDE.md`
- [ ] **RLS Policy Testing**: Verify policies work in development environment
- [ ] **Error Handling**: Test rollback procedures for data population scripts

#### **This Month (Medium Priority):**
- [ ] **Documentation Updates**: Add missing procedure cross-references
- [ ] **Security Compliance**: Ensure all new tables have RLS policies
- [ ] **Performance Monitoring**: Track API response times and rate limits
- [ ] **Backup Verification**: Test database backup and restore procedures

#### **This Quarter (Planning):**
- [ ] **Documentation Consolidation**: Address 350+ missing documentation references
- [ ] **Security Hardening**: Complete RLS policy deployment for all tables
- [ ] **Performance Optimization**: Implement advanced caching and query optimization
- [ ] **Monitoring Enhancement**: Deploy comprehensive system monitoring

### **🆘 EMERGENCY CONTACTS**

| **Issue Type** | **Primary Contact** | **Backup Contact** | **Response Time** |
|----------------|-------------------|-------------------|------------------|
| **Security Breach** | Security Team Lead | System Admin | **Immediate (< 15 min)** |
| **Data Loss** | Database Admin | DevOps Lead | **< 1 hour** |
| **System Down** | DevOps Lead | System Admin | **< 30 minutes** |
| **Performance Issues** | Performance Team | Database Admin | **< 4 hours** |
| **Documentation Issues** | Tech Writing Lead | Development Lead | **< 24 hours** |

### **📊 SYSTEM HEALTH STATUS**

| **Component** | **Status** | **Last Checked** | **Next Review** |
|---------------|------------|------------------|-----------------|
| **Database Security** | 🔴 **CRITICAL** | Dec 13, 2025 | **IMMEDIATE** |
| **Documentation Coverage** | 🟡 **INCOMPLETE** | Dec 13, 2025 | **HIGH PRIORITY** |
| **API Performance** | 🟢 **HEALTHY** | Dec 13, 2025 | **WEEKLY** |
| **Backup Systems** | 🟢 **HEALTHY** | Dec 13, 2025 | **DAILY** |

---

## ⚠️ __DEVELOPER RESPONSIBILITIES__

### **Before Any Data Operation:**
1. **Security Check**: Verify RLS policies allow your operation
2. **Documentation Review**: Check if procedure exists for your task
3. **Backup Verification**: Ensure recent database backup exists
4. **Impact Assessment**: Evaluate potential impact on other systems

### **During Data Operations:**
1. **Progress Monitoring**: Use verbose logging and progress tracking
2. **Error Handling**: Implement proper rollback procedures
3. **Rate Limiting**: Respect API limits and system constraints
4. **Security Compliance**: Maintain organization data isolation

### **After Data Operations:**
1. **Verification**: Complete post-deployment verification steps
2. **Documentation**: Update procedures if new patterns discovered
3. **Security Audit**: Verify no security policies were bypassed
4. **Performance Check**: Monitor for performance degradation

**Remember: Security and documentation are everyone's responsibility. When in doubt, ask for help rather than taking risks.**

---

## 📞 __SUPPORT RESOURCES__

| **Resource** | **Purpose** | **Location** |
|--------------|-------------|--------------|
| **Security Procedures** | RLS policy management | `0000_TABLE_POLICIES_SECURITY_PROCEDURE.md` |
| **Documentation Guide** | Complete file inventory | `docs/0000_DOCUMENTATION_MASTER_GUIDE.md` |
| **Error Tracking** | Troubleshooting guides | `docs/error-tracking/` directory |
| **API Documentation** | Service integration | `docs/external-services/` directory |
| **Database Schema** | Table structures | `docs/database-systems/` directory |

---

## 🚨 __MANDATORY PRE-DEPLOYMENT CHECKS__

**🔗 Cross-References to Related Procedures:**

**System Maintenance & Troubleshooting:**
- → `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` → Framework for diagnosing JavaScript execution failures and API issues
- → `0000_DEBUGGING_GUIDE.md` → Advanced debugging techniques for JavaScript-related problems and deployment failures
- → `0000_PROCEDURES_GUIDE.md` → Complete index of all operational procedures and workflows
- → `0000_WORKFLOW_DOCUMENTATION_PROCEDURE.md` → Standardized workflow documentation procedures

**Data & Schema Management:**
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
- → `0000_SQL_EXECUTION_PROCEDURE.md` → Raw SQL execution and schema deployment (complementary procedure)
- → `0000_TABLE_POLICIES_SECURITY_PROCEDURE.md` → RLS policy management and security configurations
- → `docs/schema/README.md` → Complete database schema reference

## Schema Documentation References

### Essential Schema Documentation Files

**📋 Core Schema References for JavaScript Data Population:**

#### **Master Schema Guides**
- **[0300_DATABASE_SCHEMA_MASTER_GUIDE.md](../schema/0300_DATABASE_SCHEMA_MASTER_GUIDE.md)** - Master guide for database schema architecture and design patterns
- **[current-full-schema.md](../schema/current-full-schema.md)** - Authoritative current schema reference with all tables, columns, and relationships
- **[table-index.md](../schema/table-index.md)** - Comprehensive index of all database tables and their purposes
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
- **SQL Data Population Procedures**: See [0000_SQL_EXECUTION_PROCEDURE.md](../procedures/0000_SQL_EXECUTION_PROCEDURE.md)

### Schema Validation Workflow

**Pre-JavaScript Data Population Schema Review:**
```bash
# 1. Review current schema architecture
cat docs/schema/0300_DATABASE_SCHEMA_MASTER_GUIDE.md | head -30

# 2. Check current full schema reference
grep -A 3 "RLS Policies" docs/schema/current-full-schema.md

# 3. Validate table relationships
grep -A 5 "Foreign Keys" docs/schema/current-full-schema.md

# 4. Review organization scoping requirements
grep -A 3 "organization_id" docs/schema/current-full-schema.md
```

**Post-JavaScript Data Population Schema Validation:**
```bash
# 1. Verify schema consistency after data population
node docs/schema/extract_schema.js

# 2. Validate against master guide
# Ensure data population didn't break schema integrity

# 3. Check RLS policy enforcement
# Verify organization isolation is maintained
```

**Setup & Navigation:**
- → `0000_QUICK_START_GUIDE.md` → Initial system setup and basic JavaScript execution testing
- → `0000_DOCUMENTATION_MASTER_GUIDE.md` → Complete documentation system organization

## 🚨 __MANDATORY PRE-DEPLOYMENT CHECKS__

### Step 1: Environment Validation

```bash
# Verify all required environment variables for Supabase access
echo "SUPABASE_URL: $SUPABASE_URL"
echo "SUPABASE_ANON_KEY: ${SUPABASE_ANON_KEY:0:20}..."
echo "SUPABASE_SERVICE_ROLE_KEY: ${SUPABASE_SERVICE_ROLE_KEY:0:10}..."

# Test Supabase connectivity
curl -s "$SUPABASE_URL/rest/v1/" -H "apikey: $SUPABASE_ANON_KEY" -H "Authorization: Bearer $SUPABASE_ANON_KEY" | head -c 50

# Check server availability
curl -s -o /dev/null -w "%{http_code}" "$SUPABASE_URL/rest/v1/" -H "apikey: $SUPABASE_ANON_KEY"
```

### Step 2: Schema Validation

__CRITICAL: Always validate target table schema before JavaScript execution__

```bash
# For API-based data population, validate table schema via API
curl -s "$SUPABASE_URL/rest/v1/discipline_document_sections?select=*&limit=1" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "Authorization: Bearer $SUPABASE_ANON_KEY" \
  -H "x-organization-id: 90cd635a-380f-4586-a3b7-a09103b6df94" | jq '.'

# Check RLS policy status
curl -s "$SUPABASE_URL/rest/v1/discipline_document_sections" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "Authorization: Bearer $SUPABASE_ANON_KEY" \
  -H "x-organization-id: 90cd635a-380f-4586-a3b7-a09103b6df94" \
  -X OPTIONS | jq '.definitions'
```

### Step 3: Authentication Testing

```bash
# Test organization-scoped access
curl -s "$SUPABASE_URL/rest/v1/discipline_document_sections?organization_id=eq.90cd635a-380f-4586-a3b7-a09103b6df94" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "Authorization: Bearer $SUPABASE_ANON_KEY" \
  -H "x-organization-id: 90cd635a-380f-4586-a3b7-a09103b6df94" | jq length

# Test service role access (if needed)
curl -s "$SUPABASE_URL/rest/v1/discipline_document_sections?select=count" \
  -H "apikey: $SUPABASE_SERVICE_ROLE_KEY" \
  -H "Authorization: Bearer $SUPABASE_SERVICE_ROLE_KEY" | jq '.'
```

## 🚀 __DEPLOYMENT WORKFLOW__

### Phase 1: Script Preparation

#### **1.1 Validate Script Structure**

```javascript
// MANDATORY: Check script has proper error handling
const scriptStructure = {
  imports: '✅ ES6 imports with proper paths',
  environment: '✅ Environment variable loading',
  authentication: '✅ Supabase client initialization',
  errorHandling: '✅ Try/catch blocks with detailed logging',
  rateLimiting: '✅ Request throttling to avoid API limits',
  progressTracking: '✅ Real-time progress reporting',
  rollbackCapability: '✅ Ability to undo changes on failure'
};

// Test script syntax
node -c populate-discipline-sections.js
```

#### **1.2 Environment Setup**

```bash
# Ensure proper Node.js environment
node --version  # Should be 18+ for ES modules
npm --version   # Should be compatible

# Check for required dependencies
npm list @supabase/supabase-js dotenv

# Install if missing
npm install @supabase/supabase-js dotenv
```

#### **1.3 Test Data Validation**

```javascript
// MANDATORY: Validate test data structure before execution
const dataValidation = {
  arrayStructure: '✅ Data is array of objects',
  requiredFields: '✅ All objects have required fields',
  dataTypes: '✅ Field types match API expectations',
  organizationId: '✅ All records have organization_id',
  uniqueConstraints: '✅ No duplicate unique field combinations',
  foreignKeys: '✅ Referenced entities exist'
};
```

### Phase 2: Dry Run Execution

#### **2.1 Run with Dry Run Flag**

```bash
# Always run dry run first - modify script to support --dry-run
node populate-discipline-sections.js --dry-run --verbose

# Expected dry run output:
# 🔍 DRY RUN MODE - No data will be modified
# 📊 Would process 37 sections
# ✅ All validations passed
# 🛡️ Safe to proceed with actual execution
```

#### **2.2 API Rate Limit Testing**

```bash
# Test API rate limits before full execution
node -e "
const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);

async function testRateLimits() {
  const start = Date.now();
  for (let i = 0; i < 10; i++) {
    await supabase.from('discipline_document_sections').select('count').limit(1);
  }
  console.log(\`10 requests took \${Date.now() - start}ms\`);
}
testRateLimits();
"
```

### Phase 3: Full Execution

#### **3.1 Execute with Full Logging**

```bash
# Run with maximum verbosity for debugging
node populate-discipline-sections.js --verbose --progress

# Monitor execution in real-time
tail -f /tmp/populate-sections.log
```

#### **3.2 Progress Monitoring**

```bash
# Monitor progress during execution
watch -n 2 "ps aux | grep populate-discipline-sections"

# Check API request rate
curl -s "$SUPABASE_URL/rest/v1/" -H "apikey: $SUPABASE_ANON_KEY" | jq '.requests_this_hour'
```

## 🛡️ __ERROR HANDLING & RECOVERY__

### Common JavaScript Data Population Errors

#### **1. Supabase Client Connection Issues**

**Error:** `ConnectionError: Failed to fetch`
```javascript
// INCORRECT: No error handling
const supabase = createClient(url, key);

// CORRECT: With retry logic
const supabase = createClient(url, key, {
  auth: { persistSession: false },
  global: {
    headers: { 'x-organization-id': process.env.ORG_ID }
  }
});

// Add retry wrapper
async function withRetry(operation, maxRetries = 3) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await operation();
    } catch (error) {
      if (i === maxRetries - 1) throw error;
      await new Promise(resolve => setTimeout(resolve, 1000 * (i + 1)));
    }
  }
}
```

#### **2. RLS Policy Violations**

**Error:** `Permission denied for table discipline_document_sections`
```javascript
// INCORRECT: Missing organization header
const { data, error } = await supabase
  .from('discipline_document_sections')
  .insert(sectionData);

// CORRECT: Include organization context
const { data, error } = await supabase
  .from('discipline_document_sections')
  .insert(sectionData)
  .select();

// Headers are set globally in client initialization
```

#### **3. Unique Constraint Violations**

**Error:** `duplicate key value violates unique constraint`
```javascript
// INCORRECT: No duplicate checking
for (const section of sections) {
  await supabase.from('discipline_document_sections').insert(section);
}

// CORRECT: Check existence first
for (const section of sections) {
  const { data: existing } = await supabase
    .from('discipline_document_sections')
    .select('id')
    .eq('section_code', section.section_code)
    .eq('organization_id', section.organization_id)
    .single();

  if (!existing) {
    await supabase.from('discipline_document_sections').insert(section);
  }
}
```

#### **4. API Rate Limiting**

**Error:** `Too Many Requests (429)`
```javascript
// INCORRECT: No rate limiting
sections.forEach(async (section) => {
  await supabase.from('discipline_document_sections').insert(section);
});

// CORRECT: Add delays between requests
async function insertWithDelay(sections, delayMs = 100) {
  for (const section of sections) {
    await supabase.from('discipline_document_sections').insert(section);
    await new Promise(resolve => setTimeout(resolve, delayMs));
  }
}
```

#### **5. Foreign Key Constraint Violations**

**Error:** `violates foreign key constraint`
```javascript
// INCORRECT: Insert child before parent
await supabase.from('child_table').insert(childData);

// CORRECT: Ensure parent exists first
const { data: parent } = await supabase
  .from('parent_table')
  .select('id')
  .eq('id', childData.parent_id)
  .single();

if (parent) {
  await supabase.from('child_table').insert(childData);
}
```

### Emergency Recovery Procedures

#### **Rollback Failed Inserts**

```javascript
// Script to rollback failed population
async function rollbackPopulation(organizationId, createdAfter) {
  const { error } = await supabase
    .from('discipline_document_sections')
    .delete()
    .eq('organization_id', organizationId)
    .gte('created_at', createdAfter);

  if (error) {
    console.error('Rollback failed:', error);
  } else {
    console.log('Rollback completed successfully');
  }
}

// Usage
rollbackPopulation('90cd635a-380f-4586-a3b7-a09103b6df94', '2025-12-13T08:00:00Z');
```

#### **Partial Data Cleanup**

```javascript
// Remove specific problematic records
async function cleanupPartialData(sectionCodes) {
  const { error } = await supabase
    .from('discipline_document_sections')
    .delete()
    .in('section_code', sectionCodes);

  if (error) {
    console.error('Cleanup failed:', error);
  } else {
    console.log(`Cleaned up ${sectionCodes.length} problematic records`);
  }
}
```

## 📊 __POST-DEPLOYMENT VERIFICATION__

### API-Based Verification

```bash
# Verify data was inserted correctly
curl -s "$SUPABASE_URL/rest/v1/discipline_document_sections?select=count&organization_id=eq.90cd635a-380f-4586-a3b7-a09103b6df94" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "Authorization: Bearer $SUPABASE_ANON_KEY" \
  -H "x-organization-id: 90cd635a-380f-4586-a3b7-a09103b6df94"

# Check data integrity
curl -s "$SUPABASE_URL/rest/v1/discipline_document_sections?organization_id=eq.90cd635a-380f-4586-a3b7-a09103b6df94&select=section_code,section_name,template_variation" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "Authorization: Bearer $SUPABASE_ANON_KEY" \
  -H "x-organization-id: 90cd635a-380f-4586-a3b7-a09103b6df94" | jq '.[0:5]'

# Verify RLS policies are working
curl -s "$SUPABASE_URL/rest/v1/discipline_document_sections?select=count" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "Authorization: Bearer $SUPABASE_ANON_KEY" \
  -w "HTTP Status: %{http_code}\n"
```

### JavaScript-Based Verification

```javascript
// Comprehensive post-deployment verification
async function verifyPopulation() {
  console.log('🔍 Starting post-deployment verification...\n');

  // 1. Count verification
  const { data: allSections, error: countError } = await supabase
    .from('discipline_document_sections')
    .select('id', { count: 'exact' });

  if (countError) {
    console.error('❌ Count verification failed:', countError);
    return;
  }

  console.log(`✅ Total sections: ${allSections.length}`);

  // 2. Template variation distribution
  const { data: variations } = await supabase
    .from('discipline_document_sections')
    .select('template_variation')
    .eq('organization_id', process.env.ORG_ID);

  const variationCounts = variations.reduce((acc, item) => {
    const variation = item.template_variation || 'standard';
    acc[variation] = (acc[variation] || 0) + 1;
    return acc;
  }, {});

  console.log('📊 Template variation distribution:', variationCounts);

  // 3. Data integrity checks
  const { data: sections } = await supabase
    .from('discipline_document_sections')
    .select('section_code, section_name, discipline_code, organization_id')
    .eq('organization_id', process.env.ORG_ID)
    .limit(10);

  console.log('🔍 Sample records:');
  sections.forEach(section => {
    console.log(`  ${section.discipline_code}:${section.section_code} - ${section.section_name}`);
  });

  // 4. Organization isolation verification
  const { data: otherOrgSections } = await supabase
    .from('discipline_document_sections')
    .select('count')
    .neq('organization_id', process.env.ORG_ID);

  console.log(`🔒 Organization isolation: ${otherOrgSections.length} sections from other organizations (should be 0)`);

  console.log('\n✅ Post-deployment verification completed');
}

// Run verification
verifyPopulation().catch(console.error);
```

## 🔧 __SCRIPT DEVELOPMENT BEST PRACTICES__

### Script Template Structure

```javascript
#!/usr/bin/env node

/**
 * Data Population Script Template
 * Follows enterprise JavaScript data population procedures
 */

import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

// Configuration
dotenv.config();

const CONFIG = {
  supabaseUrl: process.env.SUPABASE_URL,
  supabaseKey: process.env.SUPABASE_ANON_KEY,
  organizationId: '90cd635a-380f-4586-a3b7-a09103b6df94',
  batchSize: 10,
  delayMs: 100,
  dryRun: process.argv.includes('--dry-run'),
  verbose: process.argv.includes('--verbose')
};

// Validation
function validateConfig() {
  const required = ['supabaseUrl', 'supabaseKey', 'organizationId'];
  const missing = required.filter(key => !CONFIG[key]);

  if (missing.length > 0) {
    throw new Error(`Missing required configuration: ${missing.join(', ')}`);
  }
}

// Supabase client with proper configuration
function createSupabaseClient() {
  return createClient(CONFIG.supabaseUrl, CONFIG.supabaseKey, {
    auth: { persistSession: false },
    global: {
      headers: { 'x-organization-id': CONFIG.organizationId }
    }
  });
}

// Progress tracking
class ProgressTracker {
  constructor(total) {
    this.total = total;
    this.completed = 0;
    this.errors = 0;
    this.startTime = Date.now();
  }

  increment(success = true) {
    this.completed++;
    if (!success) this.errors++;

    if (CONFIG.verbose || this.completed % 10 === 0) {
      const percent = Math.round((this.completed / this.total) * 100);
      const elapsed = (Date.now() - this.startTime) / 1000;
      const rate = this.completed / elapsed;

      console.log(`📊 Progress: ${this.completed}/${this.total} (${percent}%) - ${rate.toFixed(1)} ops/sec`);
    }
  }

  getSummary() {
    const duration = (Date.now() - this.startTime) / 1000;
    return {
      total: this.total,
      completed: this.completed,
      errors: this.errors,
      duration: duration.toFixed(1),
      rate: (this.completed / duration).toFixed(1)
    };
  }
}

// Rate limiting
function delay(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

// Main execution with proper error handling
async function main() {
  try {
    console.log('🚀 Starting data population script...\n');

    validateConfig();

    const supabase = createSupabaseClient();

    // Add your data population logic here
    const data = []; // Your data array
    const progress = new ProgressTracker(data.length);

    if (CONFIG.dryRun) {
      console.log('🔍 DRY RUN MODE - Analyzing data...\n');
      // Dry run logic
      console.log(`📊 Would process ${data.length} records`);
      return;
    }

    console.log(`📊 Processing ${data.length} records...\n`);

    // Process data with rate limiting
    for (const item of data) {
      try {
        // Your API call here
        // await supabase.from('table').insert(item);

        progress.increment(true);
      } catch (error) {
        console.error(`❌ Error processing item:`, error);
        progress.increment(false);
      }

      await delay(CONFIG.delayMs);
    }

    const summary = progress.getSummary();
    console.log('\n📈 Execution Summary:');
    console.log(`✅ Successful: ${summary.completed}`);
    console.log(`❌ Errors: ${summary.errors}`);
    console.log(`⏱️  Duration: ${summary.duration}s`);
    console.log(`🚀 Rate: ${summary.rate} ops/sec`);

    if (summary.errors === 0) {
      console.log('\n🎉 Data population completed successfully!');
    } else {
      console.log('\n⚠️  Data population completed with errors. Check logs above.');
    }

  } catch (error) {
    console.error('💥 Critical error:', error);
    process.exit(1);
  }
}

// Execute
main().catch(console.error);
```

### Error Handling Patterns

```javascript
// Pattern 1: Retry with exponential backoff
async function withRetry(operation, maxRetries = 3, baseDelay = 1000) {
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await operation();
    } catch (error) {
      if (attempt === maxRetries) throw error;

      const delay = baseDelay * Math.pow(2, attempt - 1);
      console.log(`⏳ Retry ${attempt}/${maxRetries} after ${delay}ms delay`);
      await new Promise(resolve => setTimeout(resolve, delay));
    }
  }
}

// Pattern 2: Graceful degradation
async function safeOperation(operation, fallback = null) {
  try {
    return await operation();
  } catch (error) {
    console.warn(`⚠️ Operation failed, using fallback:`, error.message);
    return fallback;
  }
}

// Pattern 3: Batch processing with rollback
async function processBatch(items, batchSize = 10) {
  const batches = [];
  for (let i = 0; i < items.length; i += batchSize) {
    batches.push(items.slice(i, i + batchSize));
  }

  const results = [];
  for (const batch of batches) {
    try {
      const batchResults = await Promise.all(
        batch.map(item => processItem(item))
      );
      results.push(...batchResults);
    } catch (error) {
      console.error(`❌ Batch failed:`, error);
      // Attempt rollback for this batch
      await rollbackBatch(batch);
      throw error;
    }
  }

  return results;
}
```

## 🔒 __SECURITY CONSIDERATIONS__

### Organization Data Isolation

```javascript
// MANDATORY: Always include organization context
const supabase = createClient(url, key, {
  auth: { persistSession: false },
  global: {
    headers: { 'x-organization-id': organizationId }
  }
});

// All queries automatically scoped to organization
const { data, error } = await supabase
  .from('discipline_document_sections')
  .select('*'); // Automatically filtered by organization
```

### API Key Management

```bash
# Use appropriate key types
# - SUPABASE_ANON_KEY: For client-side operations with RLS
# - SUPABASE_SERVICE_ROLE_KEY: For server-side operations (bypass RLS)

# NEVER expose service role key in client-side code
# NEVER commit API keys to version control
```

### Data Validation

```javascript
// Validate data before insertion
function validateSection(section) {
  const required = ['section_code', 'section_name', 'discipline_code'];
  const missing = required.filter(field => !section[field]);

  if (missing.length > 0) {
    throw new Error(`Missing required fields: ${missing.join(', ')}`);
  }

  if (section.section_code.length > 20) {
    throw new Error('Section code too long (max 20 characters)');
  }

  return true;
}

// Apply validation to all data
const validData = data.filter(section => {
  try {
    validateSection(section);
    return true;
  } catch (error) {
    console.warn(`⚠️ Skipping invalid section:`, error.message);
    return false;
  }
});
```

## 🚨 __EMERGENCY PROCEDURES__

### Data Population Failure Recovery

#### **Immediate Actions**
```bash
# 1. Stop the failing script
pkill -f "populate-discipline-sections"

# 2. Check what was partially inserted
curl -s "$SUPABASE_URL/rest/v1/discipline_document_sections?select=count&created_at=gte.2025-12-13T08:00:00Z" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "Authorization: Bearer $SUPABASE_ANON_KEY"

# 3. Backup current state
mkdir -p backups
curl -s "$SUPABASE_URL/rest/v1/discipline_document_sections?select=*" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "Authorization: Bearer $SUPABASE_ANON_KEY" > "backups/sections_backup_$(date +%Y%m%d_%H%M%S).json"
```

#### **Rollback Procedures**
```javascript
// Emergency rollback script
async function emergencyRollback(cutoffTime) {
  console.log('🚨 Starting emergency rollback...');

  const { error } = await supabase
    .from('discipline_document_sections')
    .delete()
    .gte('created_at', cutoffTime)
    .eq('organization_id', process.env.ORG_ID);

  if (error) {
    console.error('❌ Rollback failed:', error);
  } else {
    console.log('✅ Emergency rollback completed');
  }
}

// Usage: Rollback everything created after script start
emergencyRollback('2025-12-13T08:00:00Z');
```

#### **Partial Recovery**
```javascript
// Recover valid records after cleanup
async function partialRecovery(validSections) {
  console.log('🔄 Starting partial recovery...');

  let successCount = 0;
  let errorCount = 0;

  for (const section of validSections) {
    try {
      await supabase.from('discipline_document_sections').insert(section);
      successCount++;
    } catch (error) {
      console.error(`❌ Failed to recover section ${section.section_code}:`, error);
      errorCount++;
    }

    // Rate limiting
    await new Promise(resolve => setTimeout(resolve, 100));
  }

  console.log(`✅ Recovered: ${successCount} sections`);
  console.log(`❌ Failed: ${errorCount} sections`);
}
```

## 📋 __TROUBLESHOOTING CHECKLIST__

### Pre-Execution Checklist
- [ ] __Environment Variables__: All Supabase credentials configured
- [ ] __Network Connectivity__: Can reach Supabase API endpoints
- [ ] __Authentication__: API keys are valid and have proper permissions
- [ ] __Organization Context__: x-organization-id header properly set
- [ ] __Schema Validation__: Target tables exist with correct structure
- [ ] __RLS Policies__: Row Level Security allows the operations
- [ ] __Rate Limits__: API rate limits won't be exceeded
- [ ] __Data Validation__: All input data is properly formatted
- [ ] __Unique Constraints__: No duplicate key violations expected
- [ ] __Foreign Keys__: All referenced entities exist

### Execution Monitoring Checklist
- [ ] __Progress Tracking__: Script provides real-time progress updates
- [ ] __Error Logging__: All errors are logged with sufficient detail
- [ ] __Rate Limiting__: Requests are properly throttled
- [ ] __Memory Usage__: Script doesn't consume excessive memory
- [ ] __Timeout Handling__: Long-running operations have proper timeouts
- [ ] __Cancellation Support__: Script can be safely interrupted
- [ ] __Resource Cleanup__: Connections and resources are properly closed

### Post-Execution Checklist
- [ ] __Data Integrity__: All inserted data is correct and complete
- [ ] __Referential Integrity__: Foreign key relationships are maintained
- [ ] __Performance Impact__: No performance degradation in the system
- [ ] __Security Compliance__: No security policies were violated
- [ ] __Audit Trail__: All changes are properly logged
- [ ] __Rollback Capability__: Changes can be undone if needed
- [ ] __Documentation Updated__: Any schema changes are documented

## 🎯 __SUCCESS METRICS__

### Performance Benchmarks
- **API Response Time**: < 200ms per request
- **Insertion Rate**: > 50 records per minute
- **Error Rate**: < 1% of total operations
- **Memory Usage**: < 100MB during execution
- **Network Usage**: < 10MB for 1000 records

### Quality Metrics
- **Data Accuracy**: 100% of inserted records match source data
- **Schema Compliance**: 100% of records conform to table schema
- **Relationship Integrity**: 100% of foreign keys are valid
- **Organization Isolation**: 100% of records properly scoped

### Reliability Metrics
- **Uptime**: Script completes successfully > 95% of the time
- **Recovery Time**: Failed executions recover within 5 minutes
- **Rollback Success**: Failed insertions are fully rolled back
- **Monitoring Coverage**: All operations are properly monitored

This procedure ensures reliable, secure, and efficient JavaScript-based data population for Supabase-backed applications, with comprehensive error handling and recovery mechanisms.
