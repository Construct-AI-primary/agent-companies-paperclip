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
# Contractor Vetting Workflow - UUID Migration Guide

## Overview
This guide provides step-by-step instructions to migrate the contractors table from integer IDs to UUIDs, enabling proper referential integrity with the external party evaluation system.

## Problem Statement
The contractors table currently uses integer IDs (e.g., `id="94"`), but the evaluation system requires UUID foreign keys. This causes:
- `invalid input syntax for type uuid: "94"` errors
- Packages created without `party_id` references
- Loss of referential integrity between contractors and evaluation packages

## Solution
Migrate the contractors table to use UUID primary keys, maintaining all existing data while establishing proper foreign key relationships.

---

## Prerequisites

Before starting, ensure you have:
- ✓ Admin access to Supabase SQL Editor
- ✓ Backup of your database (recommended)
- ✓ RLS temporarily disabled for testing (see Step 1)

---

## Migration Steps

### Step 1: Disable RLS for Testing (Optional but Recommended)

**File:** `server/sql/temporarily_disable_rls.sql`

This allows testing without authentication barriers.

```sql
-- Execute in Supabase SQL Editor
-- File: server/sql/temporarily_disable_rls.sql
```

**What it does:**
- Disables RLS on `external_party_document_instances`
- Disables RLS on `evaluation_packages`
- Disables RLS on `discipline_evaluation_weights`
- Disables RLS on `user_discipline_access`

**Output:** You should see confirmation messages for each table.

---

### Step 2: Ensure Evaluation Tables Exist

**File:** `server/sql/ensure_evaluation_packages_table.sql`

Verifies the evaluation_packages table is created with correct schema.

```sql
-- Execute in Supabase SQL Editor
-- File: server/sql/ensure_evaluation_packages_table.sql
```

**What it does:**
- Creates `evaluation_packages` table if missing
- Sets up proper columns (NO `is_active` field)
- Establishes indexes for performance

**Expected Output:**
```
✓ evaluation_packages table created or already exists
```

---

### Step 3: Fix Party ID Foreign Key Constraints

**File:** `server/sql/fix_party_id_foreign_key.sql`

**CRITICAL:** Before migrating contractors to UUID, we need to fix a schema issue where `party_id` columns have foreign key constraints to `user_management`, but contractors are stored in a separate table.

```sql
-- Execute in Supabase SQL Editor
-- File: server/sql/fix_party_id_foreign_key.sql
```

**What it does:**
- Removes foreign key constraint from `evaluation_packages.party_id`
- Removes foreign key constraint from `external_party_document_instances.assigned_to_party_id`
- Makes these fields truly generic (can reference contractors, user_management, or other party tables)
- Preserves `party_email` as the primary identifier

**Expected Output:**
```
✓ Constraints dropped successfully
✓ Party ID columns verified as nullable
✓ Test insert successful (then rolled back)
✓ PARTY_ID FOREIGN KEY FIX COMPLETE
```

**Why This Fix is Needed:**
The original schema assumed all parties would be in `user_management`, but contractors are stored in a separate `contractors` table. This fix allows the system to reference external parties from any table.

---

### Step 4: Migrate Contractors Table to UUID

**File:** `server/sql/migrate_contractors_to_uuid.sql`

This is the main migration script that converts contractor IDs from integers to UUIDs.

#### 4.1 Review Current Structure

**Before executing**, read through the script to understand what it does:

1. **Step 1:** Checks current table structure
2. **Step 2:** Creates backup table (`contractors_backup_before_uuid_migration`)
3. **Step 3:** Adds UUID column, generates UUIDs
4. **Step 4:** Checks for foreign key references (manual intervention if found)
5. **Step 5:** Drops integer ID, renames UUID column to `id`
6. **Step 6:** Updates RLS policies if applicable
7. **Step 7:** Verifies migration success

#### 4.2 Execute Migration

```sql
-- Execute in Supabase SQL Editor
-- File: server/sql/migrate_contractors_to_uuid.sql
```

#### 4.3 Verify Results

The script provides detailed output for each step. Look for:

**✓ Successful indicators:**
- `✓ contractors table exists`
- Backup table created with matching record count
- All records have valid UUIDs
- Primary key constraint successfully applied

**✗ Failure indicators:**
- Missing contractors table
- Record count mismatch between original and backup
- Foreign key constraint errors (requires manual intervention)

#### 4.4 Handle Foreign Key References (if any)

If Step 4 shows foreign key references, you'll need to:
1. Note which tables reference `contractors.id`
2. Add UUID columns to those tables
3. Migrate the references
4. Re-create foreign key constraints

**Example if found:**
```sql
-- If a table like contractor_projects references contractors
ALTER TABLE contractor_projects ADD COLUMN contractor_uuid uuid;

-- Map integer IDs to new UUIDs using backup table
UPDATE contractor_projects cp
SET contractor_uuid = c.id
FROM contractors c
INNER JOIN contractors_backup_before_uuid_migration cb 
  ON c.id = cb.id_uuid
WHERE cp.contractor_id = cb.id;

-- Drop old constraint and column
ALTER TABLE contractor_projects DROP CONSTRAINT IF EXISTS fk_contractor;
ALTER TABLE contractor_projects DROP COLUMN contractor_id;

-- Rename UUID column
ALTER TABLE contractor_projects RENAME COLUMN contractor_uuid TO contractor_id;

-- Re-create foreign key
ALTER TABLE contractor_projects 
ADD CONSTRAINT fk_contractor 
FOREIGN KEY (contractor_id) REFERENCES contractors(id);
```

---

### Step 5: Update Application Code

#### 5.1 Remove UUID Validation Workaround

**File:** `client/src/pages/02400-safety/components/modals/02400-assign-contractor-modal.js`

**Current code (with workaround):**
```javascript
// UUID validation workaround
const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

if (contractor.id && uuidRegex.test(contractor.id)) {
  packageData.party_id = contractor.id;
} else {
  console.warn('⚠️ Contractor ID is not a valid UUID, skipping party_id:', contractor.id);
}
```

**Updated code (after migration):**
```javascript
// After UUID migration - all contractor IDs are now valid UUIDs
packageData.party_id = contractor.id;
```

#### 5.2 Update Contractor Queries

Ensure all contractor queries expect UUID type:

```javascript
// Before migration - might have worked with integers
const contractor = await supabase
  .from('contractors')
  .select('*')
  .eq('id', 94) // Integer
  .single();

// After migration - use UUID
const contractor = await supabase
  .from('contractors')
  .select('*')
  .eq('id', 'uuid-string-here')
  .single();
```

---

### Step 6: Test the Complete Workflow

#### 6.1 Test Template Assignment

1. Navigate to Safety Templates page (`02400-safety-document-templates-page.js`)
2. Click "Assign to Contractor" on a template with HTML content
3. Select a contractor from the dropdown
4. Verify the modal shows contractor details correctly
5. Click "Assign Template"

**Expected behavior:**
- No UUID validation errors
- `evaluation_packages` record created with `party_id` populated
- `external_party_document_instances` record created with proper references
- Console shows success messages

**Console output should show:**
```javascript
✓ Created evaluation package: {uuid}
✓ Created external party document instance: {uuid}
✓ Successfully assigned template to contractor
```

#### 6.2 Verify Database Records

```sql
-- Check evaluation packages have party_id
SELECT 
    id,
    package_name,
    party_id,
    party_email,
    party_org_name
FROM evaluation_packages
ORDER BY created_at DESC
LIMIT 5;

-- Verify foreign key relationship
SELECT 
    ep.package_name,
    c.name as contractor_name,
    c.email as contractor_email
FROM evaluation_packages ep
INNER JOIN contractors c ON ep.party_id = c.id
ORDER BY ep.created_at DESC
LIMIT 5;
```

**Expected:**
- All `party_id` fields populated with valid UUIDs
- JOIN query returns matching contractor records
- No `null` party_id values for new assignments

#### 6.3 Test HTML Content Flow

1. Navigate to External Party Evaluation page (`01850`)
2. Verify assigned questionnaires appear
3. Click to open a questionnaire
4. Confirm HTML content renders correctly with `dangerouslySetInnerHTML`
5. Test Save and Submit buttons

---

### Step 7: Re-enable RLS Security

**File:** `server/sql/re_enable_rls.sql`

After successful testing, restore security policies:

```sql
-- Execute in Supabase SQL Editor
-- File: server/sql/re_enable_rls.sql
```

**What it does:**
- Re-enables RLS on all evaluation system tables
- Verifies policies are active
- Confirms security is restored

**Expected output:**
```
✓ RLS re-enabled on external_party_document_instances
✓ RLS re-enabled on evaluation_packages
✓ RLS re-enabled on discipline_evaluation_weights
✓ RLS re-enabled on user_discipline_access
Security policies verified: 12 active policies
```

---

### Step 8: Clean Up Backup Table (Optional)

After confirming everything works correctly for several days:

```sql
-- Wait at least 1 week before dropping backup
-- Only drop if you're 100% confident migration was successful

DROP TABLE IF EXISTS contractors_backup_before_uuid_migration;
```

---

## Rollback Plan

If migration fails or causes issues:

### Immediate Rollback

```sql
-- Drop problematic contractors table
DROP TABLE IF EXISTS contractors CASCADE;

-- Restore from backup
CREATE TABLE contractors AS 
SELECT * FROM contractors_backup_before_uuid_migration;

-- Re-create primary key
ALTER TABLE contractors 
ADD PRIMARY KEY (id);

-- Verify restoration
SELECT count(*) as restored_records FROM contractors;
```

### Restore UUID Validation Workaround

Re-add the validation code to the modal:

```javascript
const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

if (contractor.id && uuidRegex.test(contractor.id)) {
  packageData.party_id = contractor.id;
} else {
  console.warn('⚠️ Contractor ID is not a valid UUID, skipping party_id:', contractor.id);
}
```

---

## Troubleshooting

### Issue: "relation 'contractors' does not exist"

**Solution:** The contractors table hasn't been created yet. Create it first:

```sql
CREATE TABLE contractors (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name varchar(255) NOT NULL,
    email varchar(255) UNIQUE NOT NULL,
    company_name varchar(255),
    phone varchar(50),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);
```

### Issue: Foreign key constraint violations during migration

**Solution:** Identify and update referencing tables before completing migration (see Step 4.4).

### Issue: "evaluation_packages" violates foreign key constraint "evaluation_packages_party_id_fkey"

**Error Details:**
```
Key (party_id)=(uuid) is not present in table "user_management"
```

**Cause:** The `party_id` column has a foreign key to `user_management`, but contractors are in a separate table.

**Solution:** Run `fix_party_id_foreign_key.sql` BEFORE the UUID migration. This removes the inappropriate foreign key constraints and makes the party_id fields truly generic.

### Issue: UUID validation still failing after migration

**Cause:** Modal code still has validation workaround, or contractor records weren't actually migrated.

**Solution:**
1. Verify contractors table structure: `SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'contractors' AND column_name = 'id';`
2. Should show `data_type = 'uuid'`
3. If not, re-run migration script
4. Remove validation code from modal

### Issue: RLS blocking operations after re-enabling

**Solution:** Ensure authenticated user session exists and has proper discipline access:

```sql
-- Grant discipline access for testing
INSERT INTO user_discipline_access 
  (user_id, organization_id, discipline_code, access_level)
VALUES 
  (auth.uid(), '00000000-0000-0000-0000-000000000001', '02400', 'write');
```

---

## Summary

**Files Modified:**
1. ✅ `server/sql/fix_party_id_foreign_key.sql` - **Remove party_id foreign key constraints (CRITICAL)**
2. ✅ `server/sql/migrate_contractors_to_uuid.sql` - UUID migration script
3. ✅ `server/sql/temporarily_disable_rls.sql` - RLS testing bypass
4. ✅ `server/sql/re_enable_rls.sql` - RLS restoration
5. ✅ `server/sql/ensure_evaluation_packages_table.sql` - Table creation
6. 🔄 `client/src/pages/02400-safety/components/modals/02400-assign-contractor-modal.js` - Remove UUID workaround after migration

**Expected Outcome:**
- ✅ Contractors use UUID primary keys
- ✅ Foreign key relationships established properly
- ✅ Template assignments create proper references
- ✅ HTML questionnaires flow end-to-end
- ✅ Save/Submit functionality works
- ✅ Security policies active and functional

**Migration Checklist:**
- [ ] Backup database
- [ ] Disable RLS for testing
- [ ] Ensure evaluation tables exist
- [ ] **Fix party_id foreign key constraints (CRITICAL)**
- [ ] Execute UUID migration script
- [ ] Verify migration success
- [ ] Update modal code (remove UUID validation)
- [ ] Test template assignment workflow
- [ ] Verify database records have party_id
- [ ] Test HTML rendering on evaluation page
- [ ] Re-enable RLS security
- [ ] Monitor for issues
- [ ] Drop backup table (after 1+ week)

---

## Next Steps

After successful migration:

1. **Monitor** the system for 1-2 weeks to ensure stability
2. **Document** any contractor-related queries that need UUID updates
3. **Update** API documentation to reflect UUID requirement
4. **Consider** migrating other integer ID tables to UUIDs for consistency
5. **Clean up** backup table after confidence period

---

## Support

If you encounter issues during migration:
1. Check Supabase SQL Editor logs for detailed error messages
2. Verify backup table still exists before attempting fixes
3. Review RLS policies if authentication errors occur
4. Test with temporarily disabled RLS to isolate security vs. data issues
