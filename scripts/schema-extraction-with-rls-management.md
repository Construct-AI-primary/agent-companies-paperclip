# Complete Database Schema Extraction with RLS Management

## Overview
This procedure allows you to extract comprehensive schema documentation for ALL tables in the Paperclip database by temporarily disabling Row Level Security (RLS) policies, running the schema extraction, and then restoring RLS to its original state.

## ⚠️ Security Warning
**This procedure temporarily disables data access controls. Only use for documentation purposes and ensure you restore RLS immediately after extraction.**

## Prerequisites
- Database admin/service role access
- Node.js environment with schema extraction script
- Backup of current database state (recommended)

## Step-by-Step Procedure

### Step 1: Disable RLS (Preparation)
```bash
# Run the disable script - this creates a backup and disables RLS
node scripts/database/execute_sql_script.mjs scripts/disable-rls-for-schema-extraction.sql
```

**Expected Output:**
```
NOTICE:  RLS backup created for X tables
NOTICE:  Disabled RLS on: public.agents
NOTICE:  Disabled RLS on: public.companies
[... more tables ...]
NOTICE:  RLS disabled on X tables total
```

### Step 2: Run Schema Extraction
```bash
# Run the schema extraction script
node scripts/extract-all-table-schemas.js
```

**Expected Output:**
```
🚀 Starting comprehensive schema extraction...

🔍 Discovering all tables in the database...
📊 Checking 120+ potential tables...
✅ Found table: agents
✅ Found table: companies
✅ Found table: issues
[... many more tables ...]

📋 Analyzing table: public.agents
✅ Generated: agents-schema.md

📋 Analyzing table: public.companies
✅ Generated: companies-schema.md

[... processing all tables ...]

🎉 Schema extraction complete!
✅ Successfully processed: 100+ tables
❌ Errors: 0 tables
📁 Files saved to: docs-paperclip/schema
📋 Summary saved to: schema-extraction-summary.md
```

### Step 3: Restore RLS (Critical - Do Not Skip)
```bash
# IMMEDIATELY restore RLS to original state
node scripts/database/execute_sql_script.mjs scripts/restore-rls-after-schema-extraction.sql
```

**Expected Output:**
```
NOTICE:  Restored RLS (ENABLED) on: public.agents
NOTICE:  Restored RLS (ENABLED) on: public.companies
[... verification output ...]
NOTICE:  RLS restoration complete: X tables processed (Y enabled, Z disabled)
NOTICE:  FINAL VERIFICATION: X total tables (Y RLS enabled, Z RLS disabled)
```

## Verification Steps

### Verify RLS Restoration
After running the restore script, verify that RLS has been properly restored:

```sql
-- Check RLS status on all tables
SELECT
    schemaname,
    tablename,
    rowsecurity as rls_enabled
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY schemaname, tablename;
```

### Test Data Access
Verify that normal data access controls are working:

```sql
-- This should be restricted (depending on your RLS policies)
SELECT COUNT(*) FROM agents;
SELECT COUNT(*) FROM companies;
```

## Generated Documentation

### Schema Files Location
```
docs-paperclip/schema/
├── agents-schema.md
├── companies-schema.md
├── issues-schema.md
├── projects-schema.md
├── goals-schema.md
├── agent_api_keys-schema.md
├── heartbeat_runs-schema.md
├── cost_events-schema.md
├── activity_log-schema.md
├── ... (all tables)
└── schema-extraction-summary.md
```

### Documentation Content
Each schema file contains:
- **Complete table definition** with CREATE TABLE SQL
- **Column specifications** with data types and constraints
- **Primary and foreign key relationships**
- **Index definitions** where available
- **Usage notes** and metadata

## Troubleshooting

### Issue: RLS Backup Table Not Found
**Error:** `ERROR: RLS backup table not found`
**Solution:** Ensure you run the disable script first in the same database session

### Issue: Schema Extraction Fails
**Error:** Script exits with errors
**Solution:** Check database connectivity and permissions

### Issue: RLS Not Restored Properly
**Error:** Verification shows mismatched RLS states
**Solution:** Manually restore RLS using the backup data or contact database admin

### Issue: Database Connection Issues
**Error:** Cannot connect to database
**Solution:** Verify `.env` file has correct `SUPABASE_URL` and `SUPABASE_SERVICE_ROLE_KEY`

## Security Considerations

### Data Exposure Risk
- RLS is disabled for the entire duration of schema extraction
- All data becomes accessible during this window
- Minimize the time between disable and restore operations

### Access Control
- Only run this procedure with service role credentials
- Ensure no other processes access the database during RLS disable
- Restore RLS immediately after extraction completes

### Audit Trail
- All RLS changes are logged in database audit logs
- Schema extraction generates documentation of all table structures
- Backup verification ensures no data loss

## Alternative Approaches

### Option 1: Manual Schema Inspection
Instead of disabling RLS, manually inspect each table's schema through the Supabase dashboard or direct SQL queries for accessible tables only.

### Option 2: Selective RLS Disable
Modify the disable script to only disable RLS on specific tables rather than all tables, reducing the security exposure window.

### Option 3: Database Backup First
Create a full database backup before running this procedure for additional safety.

## Files Created

### Scripts
- `scripts/disable-rls-for-schema-extraction.sql` - Disables RLS with backup
- `scripts/restore-rls-after-schema-extraction.sql` - Restores RLS from backup
- `scripts/extract-all-table-schemas.js` - Main extraction script

### Documentation
- `docs-paperclip/schema/schema-extraction-summary.md` - Extraction report
- `docs-paperclip/schema/{table_name}-schema.md` - Individual table schemas

## Success Metrics

### Expected Results
- **100+ schema files** generated
- **Complete table coverage** across all database tables
- **Zero RLS verification errors** after restoration
- **Professional documentation** ready for development teams

### Verification Checklist
- [ ] RLS backup created successfully
- [ ] All tables accessible during extraction
- [ ] Schema extraction completes without errors
- [ ] RLS restored to original state
- [ ] Verification queries show correct RLS status
- [ ] Normal data access controls working

## Emergency Recovery

If RLS restoration fails, you can manually restore using this SQL:

```sql
-- Emergency RLS restoration (replace table names as needed)
ALTER TABLE public.agents ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.companies ENABLE ROW LEVEL SECURITY;
-- ... repeat for all tables
```

Contact database administrator if manual restoration is required.

---

**⚠️ Remember: Always restore RLS immediately after schema extraction completes!**