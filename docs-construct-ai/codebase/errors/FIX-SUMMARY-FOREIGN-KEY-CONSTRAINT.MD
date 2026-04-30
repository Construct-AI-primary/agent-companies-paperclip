---
memory_layer: durable_knowledge
para_section: pages/codebase/errors
gigabrain_tags: errors, debugging, troubleshooting
documentation
openstinger_context: error-handling
last_updated: 2026-03-28
related_docs:
  - codebase/errors/
---
# Fix Summary: Foreign Key Constraint Issue

## Problem Description
**Issue**: Unable to delete rows from `procurement_orders` table due to foreign key constraint violation with `logistics_documents` table.

**Error Message**:
```
Unable to delete rows as one of them is currently referenced by a foreign key constraint from the table `logistics_documents`
DETAIL: Key (id)=(ad3c4e8d-dc73-41cf-8179-6e584d0c0d66) is still referenced from table logistics_documents
```

## Root Cause
The `logistics_documents` table had a foreign key constraint on `procurement_order_id` that referenced `procurement_orders(id)` **without** specifying an `ON DELETE` action. This meant:

1. When attempting to delete a procurement order that has associated logistics documents, PostgreSQL prevented the deletion
2. The database enforced referential integrity by blocking the delete operation
3. This prevented proper cleanup of procurement order records

## Solution Implemented

### Changes Made:

#### 1. Updated Table Creation Script (`create_logistics_documents_table.sql`)
```sql
-- Before:
procurement_order_id UUID REFERENCES procurement_orders(id),

-- After:
procurement_order_id UUID REFERENCES procurement_orders(id) ON DELETE SET NULL,
```

#### 2. Created Migration Script (`fix_logistics_documents_fk_constraint.sql`)
This script provides a manual fix for existing databases:

```sql
-- Step 1: Drop the existing foreign key constraint
ALTER TABLE logistics_documents 
DROP CONSTRAINT IF EXISTS logistics_documents_procurement_order_id_fkey;

-- Step 2: Add the foreign key constraint with ON DELETE SET NULL
ALTER TABLE logistics_documents 
ADD CONSTRAINT logistics_documents_procurement_order_id_fkey 
FOREIGN KEY (procurement_order_id) 
REFERENCES procurement_orders(id) 
ON DELETE SET NULL;
```

## Behavior Change

### Before Fix:
- ❌ Deleting a procurement order with associated logistics documents → **BLOCKED**
- ❌ Error: Foreign key constraint violation

### After Fix:
- ✅ Deleting a procurement order with associated logistics documents → **ALLOWED**
- ✅ The `procurement_order_id` field in `logistics_documents` is set to `NULL`
- ✅ Logistics documents are preserved but no longer linked to the deleted procurement order
- ✅ No data loss occurs

## Rationale for `ON DELETE SET NULL`

This approach was chosen because:

1. **Data Preservation**: Logistics documents contain valuable information that should not be lost when a procurement order is deleted
2. **Audit Trail**: Maintains historical record of logistics operations even after procurement order cleanup
3. **Business Logic**: A logistics document without a procurement order reference can still be useful for historical reporting
4. **Flexibility**: Allows procurement order cleanup while preserving logistics data

## Alternative Options Considered

### Option 1: `ON DELETE CASCADE`
```sql
REFERENCES procurement_orders(id) ON DELETE CASCADE
```
**Pros**: Automatically cleans up logistics documents when procurement order is deleted
**Cons**: Permanent data loss, violates audit requirements
**Decision**: ❌ Not chosen - too destructive

### Option 2: `ON DELETE RESTRICT`
```sql
REFERENCES procurement_orders(id) ON DELETE RESTRICT
```
**Pros**: Prevents accidental deletion
**Cons**: Same as current behavior - blocks deletion
**Decision**: ❌ Not chosen - doesn't solve the problem

### Option 3: `ON DELETE SET DEFAULT`
```sql
REFERENCES procurement_orders(id) ON DELETE SET DEFAULT
```
**Pros**: Sets to a default value
**Cons**: Requires defining a default value, which may not make business sense
**Decision**: ❌ Not chosen - unnecessarily complex

## Testing Instructions

### Prerequisites
1. Access to the Supabase database
2. SQL execution privileges
3. Test environment with sample data

### Test Steps

#### Test 1: Verify Current State
```sql
-- Check current foreign key constraints
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

#### Test 2: Create Test Data
```sql
-- Create a test procurement order
INSERT INTO procurement_orders (id, order_number, order_type)
VALUES (gen_random_uuid(), 'TEST-PO-001', 'purchase_order');

-- Create a test logistics document linked to the procurement order
INSERT INTO logistics_documents (id, document_type, direction, country_code, procurement_order_id)
VALUES (gen_random_uuid(), 'commercial_invoice', 'export', 'ZA', (SELECT id FROM procurement_orders WHERE order_number = 'TEST-PO-001'));
```

#### Test 3: Attempt Deletion (Should Fail Before Fix)
```sql
-- Try to delete the procurement order
DELETE FROM procurement_orders WHERE order_number = 'TEST-PO-001';

-- Expected: Foreign key constraint violation error
```

#### Test 4: Apply Fix
```sql
-- Run the migration script
\i fix_logistics_documents_fk_constraint.sql
```

#### Test 5: Verify Fix Applied
```sql
-- Check that constraint now has ON DELETE SET NULL
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

-- Expected: delete_rule should show 'SET NULL'
```

#### Test 6: Test Deletion After Fix
```sql
-- Verify the logistics document exists
SELECT * FROM logistics_documents WHERE procurement_order_id = (SELECT id FROM procurement_orders WHERE order_number = 'TEST-PO-001');

-- Delete the procurement order
DELETE FROM procurement_orders WHERE order_number = 'TEST-PO-001';

-- Expected: Deletion succeeds without error

-- Verify the logistics document still exists but with NULL procurement_order_id
SELECT * FROM logistics_documents WHERE document_type = 'commercial_invoice';

-- Expected: logistics document exists, procurement_order_id is NULL
```

#### Test 7: Verify No Data Loss
```sql
-- Check that logistics document is preserved
SELECT 
    id,
    document_type,
    direction,
    country_code,
    procurement_order_id,
    status,
    created_at
FROM logistics_documents
WHERE document_type = 'commercial_invoice';

-- Expected: Document exists with procurement_order_id = NULL
```

## Impact Analysis

### Affected Tables
- ✅ `logistics_documents` - Foreign key constraint modified
- ✅ `procurement_orders` - Can now be deleted when referenced

### Affected Functionality
- ✅ Procurement order deletion functionality
- ✅ Logistics document linkage to procurement orders
- ✅ Data integrity and referential constraints

### Data Integrity
- ✅ No data loss
- ✅ Preserves historical records
- ✅ Maintains audit trail
- ✅ Allows flexible cleanup operations

## Deployment Considerations

### For New Deployments
The fix is already included in `create_logistics_documents_table.sql`. New installations will have the correct constraint by default.

### For Existing Deployments
1. Execute `fix_logistics_documents_fk_constraint.sql` on the database
2. Verify the constraint change using the query in Test 1
3. Test deletion functionality as described in Test 6

### Rollback Plan
If needed, the original constraint can be restored:

```sql
ALTER TABLE logistics_documents 
DROP CONSTRAINT IF EXISTS logistics_documents_procurement_order_id_fkey;

ALTER TABLE logistics_documents 
ADD CONSTRAINT logistics_documents_procurement_order_id_fkey 
FOREIGN KEY (procurement_order_id) 
REFERENCES procurement_orders(id);
```

## Related Files
- ✅ `create_logistics_documents_table.sql` - Updated table creation script
- ✅ `fix_logistics_documents_fk_constraint.sql` - Migration script for existing databases
- ✅ `FIX_SUMMARY_foreign_key_constraint.md` - This summary document

## Next Steps
1. ✅ Review and approve the fix
2. ✅ Execute migration on test environment
3. ✅ Run comprehensive tests (see Test Steps section)
4. ✅ Deploy to production environment
5. ✅ Monitor for any issues
6. ✅ Update documentation

## References
- Issue: Unable to delete procurement orders due to foreign key constraint from logistics_documents
- Error: `Key (id)=(ad3c4e8d-dc73-41cf-8179-6e584d0c0d66) is still referenced from table logistics_documents`
- Schema docs: `/Users/_PropAI/construct_ai/docs/schema/reports/index-policies.md`
- Schema docs: `/Users/_PropAI/construct_ai/docs/schema/reports/index-table.md`