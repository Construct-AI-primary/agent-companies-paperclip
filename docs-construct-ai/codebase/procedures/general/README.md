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

# Scripts Directory

This directory contains scripts for data integration, testing, and maintenance of the ConstructAI procurement system.

## Available Scripts

### 1. Template Integration Scripts

#### `integrate_templates.js`
**Purpose:** Import procurement templates, SOW templates, and supplier data into the database  
**Usage:** `node scripts/integrate_templates.js`  
**What it does:**
- Imports 10 procurement templates (HSSE evaluation forms with HTML content)
- Imports 7 SOW templates (Scope of Work templates with appendix definitions)
- Imports cleaned supplier data (deduped)
- Uses Supabase client for database operations

**Prerequisites:**
```bash
# Environment variables must be set
NEXT_PUBLIC_SUPABASE_URL="your-url"
NEXT_PUBLIC_SUPABASE_ANON_KEY="your-key"

# Install dependencies
npm install @supabase/supabase-js
```

**Expected Output:**
```
🚀 Starting template import...

📋 Importing procurement templates...
✅ Imported 10 procurement templates

📋 Importing SOW templates...
✅ Imported 7 SOW templates

📋 Importing suppliers...
✅ Imported 1 supplier

🎉 All imports completed successfully!
📊 Summary:
   - 10 procurement templates
   - 7 SOW templates
   - 1 supplier
```

---

#### `test_template_integration.js`
**Purpose:** Validate that template integration was successful  
**Usage:** `node scripts/test_template_integration.js`  
**What it does:**
- Verifies 10 procurement templates are loaded
- Verifies 7 SOW templates are loaded
- Verifies 1 supplier exists (after deduplication)
- Checks for approved templates
- Validates SOW template structure
- Checks for template content
- Verifies discipline distribution
- Confirms no duplicate suppliers remain

**Test Suite (8 Tests):**
1. ✅ Procurement Templates count (Expected: 10)
2. ✅ SOW Templates count (Expected: 7)
3. ✅ Suppliers count (Expected: 1)
4. ✅ Approved Templates count (Expected: ≥8)
5. ✅ SOW Template Structure (Appendix & Discipline defaults)
6. ✅ Template Content existence
7. ✅ Discipline Distribution verification
8. ✅ Supplier Deduplication verification

**Success Criteria:**
- All 8 tests must pass
- Zero duplicate suppliers
- All templates in "approved" status

---

### 2. SQL Scripts

#### `clean_supplier_duplicates.sql`
**Purpose:** Identify and remove duplicate supplier entries  
**Usage:** 
```bash
# Method 1: Supabase SQL Editor
# Copy and paste contents into SQL Editor → Run

# Method 2: Command line
psql $DATABASE_URL -f scripts/clean_supplier_duplicates.sql
```

**What it does:**
- **Step 1:** Identifies duplicate suppliers by name, email, address
- **Step 2:** Removes all duplicates except the first (lowest ID)
- **Step 3:** Verifies cleanup was successful
- **Step 4:** Shows final supplier count

**What it removes:**
```
Before: 6 supplier entries
- 5 duplicate "Test Export Supplier ZA" entries
- 1 test supplier with minimal data

After: 1 supplier entry
- 1 unique "Test Export Supplier ZA" with complete data
```

**Safety Features:**
- Only affects suppliers named 'Test Export Supplier ZA'
- Keeps the first occurrence (lowest ID)
- Creates backup via SQL WHERE clause
- Can be safely run multiple times

---

### 3. Documentation Files

#### `TEMPLATE_INTEGRATION_GUIDE.md`
**Purpose:** Comprehensive guide for template integration workflow  
**Contents:**
- Prerequisites and setup instructions
- Phase-by-phase implementation guide
- Testing and validation procedures
- Troubleshooting common issues
- Post-integration tasks
- Rollback procedures

**Key Sections:**
- **Phase 1:** Data Cleanup (Supplier deduplication)
- **Phase 2:** Template Integration (Import scripts)
- **Phase 3:** Frontend Integration (UI updates)
- **Phase 4:** Workflow Integration (Procurement flow)
- **Phase 5:** Testing & Validation
- **Phase 6:** Documentation Updates

**Use this guide when:**
- Setting up templates for the first time
- Troubleshooting integration issues
- Rolling back changes
- Training new team members

---

#### `README.md` (This File)
**Purpose:** Overview of all scripts and their usage  
**Contents:**
- Script catalog with descriptions
- Usage instructions for each script
- Expected outputs and success criteria
- Troubleshooting links

---

## Quick Start Guide

### Step 1: Clean Supplier Data
```bash
# Run the SQL cleanup script
psql $DATABASE_URL -f scripts/clean_supplier_duplicates.sql
```
**Expected:** 1 duplicate removed, 1 supplier remains

### Step 2: Import Templates
```bash
# Run the Node.js import script
node scripts/integrate_templates.js
```
**Expected:** 10 procurement templates + 7 SOW templates imported

### Step 3: Verify Integration
```bash
# Run the test script
node scripts/test_template_integration.js
```
**Expected:** All 8 tests pass

### Step 4: Update Frontend
1. Add template selection to `CreateOrderModal.jsx`
2. Update `SOWAssociationModal.jsx` (already enhanced)
3. Test workflow integration

---

## Troubleshooting

### Issue: Environment Variables Not Set
**Error:** `Missing Supabase environment variables`
**Solution:**
```bash
# Check environment variables
echo $NEXT_PUBLIC_SUPABASE_URL
echo $NEXT_PUBLIC_SUPABASE_ANON_KEY

# Set them if missing
export NEXT_PUBLIC_SUPABASE_URL="your-url"
export NEXT_PUBLIC_SUPABASE_ANON_KEY="your-key"
```

### Issue: Duplicate Data After Import
**Error:** Test shows incorrect counts
**Solution:**
```sql
-- Clear existing data
TRUNCATE procurement_templates RESTART IDENTITY CASCADE;
TRUNCATE sow_templates RESTART IDENTITY CASCADE;

-- Re-run import
node scripts/integrate_templates.js
```

### Issue: Missing Template Content
**Error:** Template forms not rendering
**Solution:**
```javascript
// Check template content length
SELECT template_name, LENGTH(template_content) as content_length
FROM procurement_templates
WHERE template_content IS NOT NULL;

// If empty, re-import with complete HTML
```

### Issue: SQL Script Errors
**Error:** "relation does not exist"
**Solution:**
```sql
-- Verify tables exist
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public'
AND table_name IN ('suppliers', 'procurement_templates', 'sow_templates');
```

---

## Script Dependencies

### Required Packages
- `@supabase/supabase-js` (Node.js scripts)
- PostgreSQL client (SQL scripts)

### Database Tables
- `procurement_templates` (HSSE evaluation forms)
- `sow_templates` (Scope of Work templates)
- `suppliers` (Supplier data)
- `user_profiles` (User data - used by frontend)
- `procurement_orders` (Order data - used by frontend)

### Environment Variables
- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`

---

## Performance Notes

### Import Speed
- **Procurement Templates:** ~100-200ms per template
- **SOW Templates:** ~50-100ms per template
- **Total Import Time:** ~2-5 seconds

### Test Execution Time
- **8 Tests:** ~1-2 seconds
- **Network Dependent:** Slower on slow connections

### SQL Script Performance
- **Cleanup:** < 1 second for small datasets
- **Verification:** < 1 second

---

## Best Practices

### 1. Backup Before Import
```sql
-- Create backup of existing data
CREATE TABLE procurement_templates_backup AS 
SELECT * FROM procurement_templates;

CREATE TABLE sow_templates_backup AS 
SELECT * FROM sow_templates;
```

### 2. Test in Development First
```bash
# Run on development database
export NEXT_PUBLIC_SUPABASE_URL="dev-url"
export NEXT_PUBLIC_SUPABASE_ANON_KEY="dev-key"

# Run scripts
node scripts/integrate_templates.js
node scripts/test_template_integration.js
```

### 3. Monitor Production Deployment
```bash
# Check counts after production deployment
psql $PROD_DATABASE_URL -c "
SELECT 
  (SELECT COUNT(*) FROM procurement_templates) as templates,
  (SELECT COUNT(*) FROM sow_templates) as sow_templates,
  (SELECT COUNT(*) FROM suppliers) as suppliers;
"
```

### 4. Document Changes
```bash
# Create deployment record
echo "Template Integration - $(date)" >> scripts/deployment.log
echo "   - 10 procurement templates imported" >> scripts/deployment.log
echo "   - 7 SOW templates imported" >> scripts/deployment.log
echo "   - 1 supplier (deduped)" >> scripts/deployment.log
```

---

## Related Files

### Configuration Files
- `.env.example` - Environment variable template
- `package.json` - Node.js dependencies

### Documentation Files
- `TEMPLATE_INTEGRATION_GUIDE.md` - Detailed guide
- `docs/implementation/implementation-plans/02400_CONTRACTOR_VETTING_WORKFLOW_INTEGRATION_PLAN.md` - Implementation plan
- `docs/workflows/02400_CONTRACTOR_VETTING_WORKFLOW/02400_CONTRACTOR_VETTING_WORKFLOW_CONFIGURATION.md` - Workflow config

### SQL Files
- `server/sql/create_procurement_templates_schema.sql` - Table definitions
- `scripts/clean_supplier_duplicates.sql` - Cleanup script

### Frontend Files
- `client/src/pages/01900-procurement/components/modals/CreateOrderModal.jsx` - Template selection UI
- `client/src/pages/01900-procurement/components/modals/SOWAssociationModal.jsx` - SOW association UI
- `client/src/pages/01900-procurement/hooks/useProcurementTemplates.js` - Template fetching hook

---

## Support

For issues or questions:
1. **Check this README** for common issues
2. **Review TEMPLATE_INTEGRATION_GUIDE.md** for detailed troubleshooting
3. **Check browser console** for frontend errors
4. **Check Supabase logs** for database errors
5. **Review database tables** directly in Supabase Dashboard

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-01-28 | Initial scripts and documentation |
| | | - Added integrate_templates.js |
| | | - Added clean_supplier_duplicates.sql |
| | | - Added test_template_integration.js |
| | | - Added TEMPLATE_INTEGRATION_GUIDE.md |
| | | - Added this README |

---

**Last Updated:** 2026-01-28  
**Maintainer:** Procurement System Admin  
**Status:** ✅ Production Ready