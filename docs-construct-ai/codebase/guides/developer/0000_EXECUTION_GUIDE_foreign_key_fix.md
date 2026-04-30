---
memory_layer: durable_knowledge
para_section: pages/codebase/guides
gigabrain_tags: guides, codebase, documentation
documentation
openstinger_context: development-guides, implementation-guidance
last_updated: 2026-03-21
related_docs:
  - codebase/guides/
  - disciplines/
---
# Execution Guide: Foreign Key Constraint Fix

## Quick Reference

**Problem**: Cannot delete procurement orders due to foreign key constraint from logistics_documents  
**Solution**: Change foreign key constraint to use ON DELETE SET NULL  
**Files Modified**: 
- `create_logistics_documents_table.sql` (table creation)
- `fix_logistics_documents_fk_constraint.sql` (migration for existing databases)

---

## For New Database Deployments

No action needed. The fix is already included in `create_logistics_documents_table.sql`.

---

## For Existing Database Deployments

### Option 1: Automated Migration (Recommended)

Execute the migration script:

```bash
# Using psql
psql -h <host> -U <user> -d <database> -f fix_logistics_documents_fk_constraint.sql

# Or using Supabase CLI
supabase db reset --db-url "postgresql://..."
```

### Option 2: Manual SQL Execution

If you prefer to execute SQL manually:

```sql
-- Step 1: Check current constraint (optional)
SELECT 
    tc.constraint_name,
    rc.delete_rule
FROM information_schema.table_constraints tc
JOIN information_schema.referential_constraints rc ON rc.constraint_name = tc.constraint_name
WHERE tc.table_name = 'logistics_documents' 
AND tc.constraint_type = 'FOREIGN KEY'
AND EXISTS (
    SELECT 1 FROM information_schema.key_column_usage kcu
    WHERE kcu.constraint_name = tc.constraint_name
    AND kcu.column_name = 'procurement_order_id'
);

-- Step 2: Drop the existing constraint
ALTER TABLE logistics_documents 
DROP CONSTRAINT IF EXISTS logistics_documents_procurement_order_id_fkey;

-- Step 3: Add the new constraint with ON DELETE SET NULL
ALTER TABLE logistics_documents 
ADD CONSTRAINT logistics_documents_procurement_order_id_fkey 
FOREIGN KEY (procurement_order_id) 
REFERENCES procurement_orders(id) 
ON DELETE SET NULL;
```

### Option 3: Using Supabase SQL Editor

1. Open Supabase dashboard
2. Navigate to SQL Editor
3. Copy and paste the SQL from `fix_logistics_documents_fk_constraint.sql`
4. Execute the query
5. Verify the constraint was updated

---

## Verification Steps

After applying the fix, verify it was successful:

```sql
-- Verify the constraint now has ON DELETE SET NULL
SELECT 
    tc.constraint_name,
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name,
    rc.delete_rule
FROM 
    information_schema.table_constraints AS tc 
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
    JOIN information_schema.referential_constraints AS rc
      ON rc.constraint_name = tc.constraint_name
WHERE 
    tc.table_name = 'logistics_documents'
    AND tc.constraint_type = 'FOREIGN KEY'
    AND kcu.column_name = 'procurement_order_id';
```

**Expected Result**:
```
constraint_name            | table_name          | column_name         | foreign_table_name | foreign_column_name | delete_rule
---------------------------+---------------------+---------------------+--------------------+---------------------+-------------
logistics_documents_procurement_order_id_fkey | logistics_documents | procurement_order_id | procurement_orders | id                  | SET NULL
```

---

## Testing the Fix

### Test Scenario 1: Create Linked Records

```sql
-- Create a procurement order
INSERT INTO procurement_orders (id, order_number, order_type, status)
VALUES (gen_random_uuid(), 'TEST-PO-' || substr(md5(random()::text), 1, 8), 'purchase_order', 'active')
RETURNING id, order_number;

-- Save the returned ID
-- Example: a1b2c3d4-e5f6-7890-abcd-ef1234567890

-- Create a logistics document linked to the procurement order
INSERT INTO logistics_documents (document_type, direction, country_code, procurement_order_id, status)
VALUES ('commercial_invoice', 'export', 'ZA', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'draft');
```

### Test Scenario 2: Attempt Deletion (Should Succeed)

```sql
-- Try to delete the procurement order
DELETE FROM procurement_orders 
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890';

-- Expected: DELETE 1 (success)
```

### Test Scenario 3: Verify Data Preservation

```sql
-- Check that the logistics document still exists but has NULL procurement_order_id
SELECT 
    id,
    document_type,
    direction,
    country_code,
    procurement_order_id,
    status,
    created_at
FROM logistics_documents
WHERE document_type = 'commercial_invoice'
ORDER BY created_at DESC
LIMIT 5;

-- Expected: The document exists with procurement_order_id = NULL
```

---

## Rollback Instructions

If you need to revert the change (not recommended):

```sql
-- Drop the current constraint
ALTER TABLE logistics_documents 
DROP CONSTRAINT IF EXISTS logistics_documents_procurement_order_id_fkey;

-- Recreate the original constraint (without ON DELETE clause)
ALTER TABLE logistics_documents 
ADD CONSTRAINT logistics_documents_procurement_order_id_fkey 
FOREIGN KEY (procurement_order_id) 
REFERENCES procurement_orders(id);
```

**Warning**: This will restore the original behavior where deletion of procurement orders is blocked if they have linked logistics documents.

---

## Common Issues & Solutions

### Issue 1: Constraint Doesn't Exist

**Error**: `constraint "logistics_documents_procurement_order_id_fkey" does not exist`

**Solution**: The constraint might have a different name. Find it with:

```sql
SELECT constraint_name 
FROM information_schema.table_constraints 
WHERE table_name = 'logistics_documents' 
AND constraint_type = 'FOREIGN KEY';
```

Then use the actual constraint name in your DROP statement.

### Issue 2: Permission Denied

**Error**: `permission denied to alter table logistics_documents`

**Solution**: Execute with elevated privileges or ask your database administrator.

### Issue 3: Data Loss Concerns

**Concern**: Will logistics documents be deleted?

**Answer**: NO. With `ON DELETE SET NULL`, the logistics documents are preserved. Only the `procurement_order_id` field is set to NULL.

---

## Monitoring After Deployment

After deploying to production, monitor for:

1. **Deletion Success Rate**: Track successful procurement order deletions
2. **Orphaned Documents**: Monitor logistics documents with NULL procurement_order_id
3. **User Reports**: Watch for user feedback on deletion functionality

```sql
-- Count logistics documents with NULL procurement_order_id
SELECT 
    COUNT(*) as orphaned_documents,
    document_type,
    status
FROM logistics_documents
WHERE procurement_order_id IS NULL
GROUP BY document_type, status;
```

---

## Support

If you encounter issues:

1. Check the error message carefully
2. Verify you're connected to the correct database
3. Ensure you have the necessary permissions
4. Review the `FIX_SUMMARY_foreign_key_constraint.md` file for detailed explanation
5. Test in a non-production environment first

---

## Summary

✅ **Fix Applied**: Foreign key constraint now uses ON DELETE SET NULL  
✅ **Result**: Procurement orders can be deleted while preserving logistics documents  
✅ **Data Safety**: No data loss, only linkage is removed  
✅ **Deployment**: Ready for production use  

**Files Created**:
- `fix_logistics_documents_fk_constraint.sql` - Migration script
- `FIX_SUMMARY_foreign_key_constraint.md` - Detailed explanation
- `EXECUTION_GUIDE_foreign_key_fix.md` - This execution guide