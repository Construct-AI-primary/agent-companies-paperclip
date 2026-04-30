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

# RLS BULK FIX - FINAL SCHEMA-ACCURATE EXECUTION GUIDE

## ✅ Schema Analysis Complete - Final File Ready

### Issue Resolution Summary:
1. **Original Issue**: Non-existent tables error (`procurement_order_items` does not exist)
2. **Second Issue**: Wrong column names error (`column "created_by" does not exist`)
3. **Final Solution**: Schema-accurate file using actual table columns

### Database Schema Analysis Results:
- **13 existing tables** confirmed
- **Column verification** completed for all tables
- **Schema-accurate policies** created for each table

### What You Need to Do:
1. **DO NOT use**: `bulk_fix_circular_dependencies.sql` (wrong tables)
2. **DO NOT use**: `bulk_fix_circular_dependencies_corrected.sql` (wrong columns)
3. **DO use**: `bulk_fix_circular_dependencies_final.sql` ⭐ **FINAL VERSION**

### Step-by-Step Instructions:

#### Option 1: Copy and Paste into Supabase SQL Editor
1. Open your Supabase project
2. Go to **SQL Editor** in the left sidebar
3. Create a **new query**
4. Open the file `bulk_fix_circular_dependencies_final.sql` in your editor
5. **Copy ALL content** from the final `.sql` file
6. **Paste** the content into the Supabase SQL Editor
7. Click **"Run"** to execute

#### Option 2: Schema-Accurate Content
The final SQL file contains commands to fix 13 existing tables with **correct column names**:

**Tables with `user_id` columns:**
- `user_department_access` - `user_id::text = auth.uid()::text`
- `user_discipline_access` - `user_id::text = auth.uid()::text`  
- `user_roles` - `user_id::text = auth.uid()::text`

**Tables with `created_by` columns:**
- `procurement_orders` - `created_by::text = auth.uid()::text`
- `governance_approval_instances` - `created_by::text = auth.uid()::text`
- `governance_approval_matrices` - `created_by::text = auth.uid()::text`
- `governance_approval_steps` - `created_by::text = auth.uid()::text OR approver_user_id::text = auth.uid()::text`

**Empty tables (no user columns):**
- `a_00900_user_langchain_settings` - Dev/service role only
- `user_email_aliases` - Dev/service role only
- `user_emails` - Dev/service role only

**Core tables (already fixed in emergency):**
- `user_organization_access` ✅
- `user_role_assignments` ✅

**Special case:**
- `procurement_categories` - Only `created_at`, no `created_by` (fixed)

### What the Final Fix Does:
1. **Drops all existing RLS policies** on each of the 13 existing tables
2. **Re-enables RLS** on each table
3. **Creates schema-accurate policies** using actual column names
4. **Tests access** to verify no infinite recursion

### Expected Result:
- ✅ All 13 existing tables will have safe RLS policies
- ✅ Correct column names used for each table
- ✅ No more infinite recursion errors
- ✅ System should be fully functional
- ✅ Verification messages will show success for each table

### If You Get Errors:
1. Make sure you're using the `bulk_fix_circular_dependencies_final.sql` file content
2. Check that you're connected to the correct Supabase project
3. Verify you have sufficient permissions to run SQL commands
4. The script includes error handling, so most issues will be logged

### After Running the Fix:
1. **Test the application** to ensure all features work
2. **Run verification**: `node test_rls_recursion_fix.js`
3. **Check the logs** for any remaining issues
4. **Update the todo list** to mark this step as complete

---

**Ready to proceed?** Copy the content from `bulk_fix_circular_dependencies_final.sql` and paste it into your Supabase SQL Editor!
