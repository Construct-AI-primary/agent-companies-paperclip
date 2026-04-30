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

# Procurement Tables - SQL to JavaScript Conversion Strategy

## 📊 **Current File Status**

### **✅ CONVERTED TO JAVASCRIPT:**
- `populate-users.js` - User management population with RLS compliance
- `populate-user-management.js` - Complete conversion from user_management.sql
- `populate-procurement-orders.js` - Procurement orders with proper relationships
- `populate-agent-workflow-executions.js` - Agent workflow executions

### **🔄 PENDING CONVERSION:**

**SQL Files to Convert:**
- `templates.sql` → `populate-templates.js`
- `procurement_orders.sql` → `populate-procurement-orders.js` (partial)
- `tasks.sql` → `populate-tasks.js`
- `agent_workflow_executions.sql` → `populate-agent-workflow-executions.js` (partial)
- `document_variations.sql` → Already converted
- `document_variation_sections.sql` → Already converted

### **📋 Conversion Priority:**

1. **HIGH PRIORITY:** Core workflow tables (users, templates, procurement orders)
2. **MEDIUM PRIORITY:** Support tables (tasks, agent executions)
3. **LOW PRIORITY:** Legacy files (archive after conversion)

## 🚀 **Conversion Template**

### **Standard JavaScript Population Script:**

```javascript
#!/usr/bin/env node

/**
 * [Table Name] Data Population Script
 * Converted from: [original_sql_file.sql]
 * Environment: Supabase with RLS
 * Dependencies: [List dependencies]
 * Re-runnable: Yes (upsert with conflict resolution)
 *
 * Usage:
 *   node populate-[table].js --dry-run  # Test mode
 *   node populate-[table].js --verbose  # Detailed logging
 *   node populate-[table].js            # Production run
 */

import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

// Configuration with environment validation
dotenv.config({ path: './server/.env.dev' });
const CONFIG = {
  supabaseUrl: process.env.SUPABASE_URL,
  supabaseKey: process.env.SUPABASE_SERVICE_ROLE_KEY,
  organizationId: '90cd635a-380f-4586-a3b7-a09103b6df94',
  delayMs: 200,
  dryRun: process.argv.includes('--dry-run'),
  verbose: process.argv.includes('--verbose')
};

// Data with proper UUIDs and constraint compliance
const tableData = [/* Data from SQL file with proper formatting */];

// Main execution with comprehensive error handling
async function main() {
  try {
    console.log('🚀 Starting [Table Name] population...\n');

    // Validate environment
    if (!CONFIG.supabaseUrl || !CONFIG.supabaseKey) {
      throw new Error('Missing required environment variables');
    }

    const supabase = createClient(CONFIG.supabaseUrl, CONFIG.supabaseKey, {
      global: { headers: { 'x-organization-id': CONFIG.organizationId } }
    });

    if (CONFIG.dryRun) {
      console.log('🔍 DRY RUN MODE - Previewing changes...');
      console.log(`📊 Would process ${tableData.length} records`);
      return;
    }

    // Progress tracking
    let successCount = 0;
    let errorCount = 0;

    // Process each record
    for (let i = 0; i < tableData.length; i++) {
      try {
        const record = tableData[i];

        // Use upsert for safe updates
        const { error } = await supabase
          .from('[table_name]')
          .upsert(record, {
            onConflict: '[primary_key_column]',
            ignoreDuplicates: false
          });

        if (error) throw error;

        successCount++;

        if (CONFIG.verbose || (i + 1) % 5 === 0) {
          console.log(`✅ Processed ${i + 1}/${tableData.length} records`);
        }

        // Rate limiting
        await new Promise(resolve => setTimeout(resolve, CONFIG.delayMs));

      } catch (error) {
        console.error(`❌ Failed to process record ${i + 1}:`, error.message);
        errorCount++;
      }
    }

    // Summary
    console.log('\n📈 Population Summary:');
    console.log(`✅ Successful: ${successCount}`);
    console.log(`❌ Errors: ${errorCount}`);
    console.log(`⏱️  Duration: ${((Date.now() - startTime) / 1000).toFixed(1)}s`);

    if (errorCount === 0) {
      console.log('\n🎉 [Table Name] population completed successfully!');
    } else {
      console.log(`\n⚠️  [Table Name] population completed with ${errorCount} errors.`);
    }

  } catch (error) {
    console.error('💥 Critical error:', error);
    console.error('Stack trace:', error.stack);
    process.exit(1);
  }
}

// Execute
main().catch(console.error);
```

## 🔄 **Conversion Process**

### **Step 1: Analyze SQL File**
```bash
# Review SQL file structure
head -50 user_management.sql
grep -n "INSERT INTO" user_management.sql
grep -n "VALUES" user_management.sql
```

### **Step 2: Extract Data Structure**
```javascript
// Convert SQL VALUES to JavaScript objects
const sqlData = `
INSERT INTO user_management (user_id, email, full_name, job_title, department, disciplines, organization_id, is_active, created_at)
VALUES
('550e8400-e29b-41d4-a716-446655440001', 'user1@company.com', 'John Doe', 'Manager', 'Engineering', '["Engineering"]', '90cd635a-380f-4586-a3b7-a09103b6df94', true, '2026-01-01T10:00:00Z'),
('550e8400-e29b-41d4-a716-446655440002', 'user2@company.com', 'Jane Smith', 'Officer', 'Procurement', '["Procurement"]', '90cd635a-380f-4586-a3b7-a09103b6df94', true, '2026-01-01T10:00:00Z')
`;

// Becomes:
const tableData = [
  {
    user_id: '550e8400-e29b-41d4-a716-446655440001',
    email: 'user1@company.com',
    full_name: 'John Doe',
    job_title: 'Manager',
    department: 'Engineering',
    disciplines: ['Engineering'],  // JSON array
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  }
  // ... more records
];
```

### **Step 3: Add RLS Compliance**
```javascript
// Ensure organization context for multi-tenant safety
const supabase = createClient(CONFIG.supabaseUrl, CONFIG.supabaseKey, {
  global: { headers: { 'x-organization-id': CONFIG.organizationId } }
});
```

### **Step 4: Implement Upsert Logic**
```javascript
// Safe upsert with conflict resolution
const { error } = await supabase
  .from('user_management')
  .upsert(record, {
    onConflict: 'user_id',  // Primary key or unique constraint
    ignoreDuplicates: false
  });
```

### **Step 5: Add Error Handling & Progress**
```javascript
// Comprehensive error handling
try {
  // Process record
} catch (error) {
  console.error(`❌ Failed: ${error.message}`);
  errorCount++;
}

// Progress tracking
if (CONFIG.verbose || (i + 1) % 5 === 0) {
  console.log(`✅ Processed ${i + 1}/${tableData.length}`);
}
```

### **Step 6: Test & Verify**
```bash
# Dry run first
node populate-user-management.js --dry-run

# Execute
node populate-user-management.js

# Verify
node scripts/verify-population.js user_management
```

## 📋 **Conversion Status Tracking**

### **Phase 1: Core Tables (Week 1)**
- [x] `user_management.sql` → `populate-user-management.js`
- [ ] `templates.sql` → `populate-templates.js`
- [ ] `procurement_orders.sql` → `populate-procurement-orders.js`

### **Phase 2: Support Tables (Week 2)**
- [ ] `tasks.sql` → `populate-tasks.js`
- [ ] `agent_workflow_executions.sql` → `populate-agent-workflow-executions.js`

### **Phase 3: Cleanup (Week 3)**
- [ ] Move converted SQL files to `archive/` directory
- [ ] Update all documentation references
- [ ] Remove duplicate scripts

## 🎯 **Benefits of JavaScript Conversion**

### **✅ Advantages:**
- **RLS Compliance**: Proper organization headers and multi-tenant support
- **Error Recovery**: Individual record error handling and rate limiting
- **Progress Tracking**: Real-time feedback during execution
- **Dry Run Support**: Safe testing before production execution
- **Environment Flexibility**: Works across dev/staging/production
- **Re-runnable**: Upsert logic prevents duplicates

### **❌ SQL Limitations:**
- **No RLS Support**: Cannot set organization context
- **All-or-Nothing**: Single failure stops entire process
- **No Progress**: No visibility into execution progress
- **Environment Issues**: Difficult to parameterize for different environments
- **Maintenance**: Harder to modify and extend

## 🔧 **Migration Strategy**

### **Approach: Parallel Maintenance**
1. **Keep SQL files** during transition for reference
2. **Create JavaScript equivalents** with improved features
3. **Test JavaScript versions** thoroughly
4. **Archive SQL files** after successful conversion
5. **Update documentation** to reference JavaScript scripts

### **Rollback Plan:**
- SQL files remain available for emergency rollback
- Version control preserves all historical versions
- Documentation includes both approaches for reference

## 📚 **Related Documentation**

### **📋 Essential Schema References (Always Check First)**
- **[0300_DATABASE_SCHEMA_MASTER_GUIDE.md](../../../schema/0300_DATABASE_SCHEMA_MASTER_GUIDE.md)** - Complete database architecture
- **[index-table.md](../../../schema/index-table.md)** - Direct links to all schema part files
- **[index-pages.md](../../../schema/index-pages.md)** - Page-specific schema documentation
- **[index-chatbots.md](../../../schema/index-chatbots.md)** - Chatbot and AI system schemas
- **[schema-part-01.md](../../../schema/schema-part-01.md)** - Core tables (users, organizations, disciplines)
- **[schema-part-02.md](../../../schema/schema-part-02.md)** - Workflow and process tables
- **[schema-part-03.md](../../../schema/schema-part-03.md)** - Vector and AI tables
- **[schema-part-04.md](../../../schema/schema-part-04.md)** - Integration and external system tables
- **[constraint-quick-reference.md](../../../schema/constraint-quick-reference.md)** - Common constraint violations and fixes
- **[data-validation-templates.md](../../../schema/data-validation-templates.md)** - Pre-validated data structures
- **[rls-policy-quick-reference.md](../../../schema/rls-policy-quick-reference.md)** - Multi-tenant access rules

### **🔧 Test Data Procedures**
- **[0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md](../../procedures/0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md)** - JavaScript population standards
- **[1300_TEST_DATA_GENERATION_PROCEDURE.md](../../procedures/1300_TEST_DATA_GENERATION_PROCEDURE.md)** - Overall test data strategy

**⚠️ Critical:** Always reference schema documentation before converting SQL files to ensure proper table structures, constraints, and RLS policies are implemented correctly.

---

**Conversion Status**: Phase 1 in progress
**Target Completion**: End of January 2026
**Benefits**: Improved reliability, RLS compliance, better error handling**Benefits**: Improved reliability, RLS compliance, better error handling