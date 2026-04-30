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

# SQL Implementation Template

## Purpose
This template provides a standardized approach for creating and implementing SQL scripts with safety measures and best practices.

## SQL Script Template Structure

```sql
-- =============================================
-- [SCRIPT_NAME] - [BRIEF_DESCRIPTION]
-- Created: [DATE]
-- Author: [AUTHOR]
-- Purpose: [DETAILED_PURPOSE]
-- =============================================

-- Safety Check: Verify we're on the correct database
-- SELECT current_database(), current_schema();

-- 1. PRE-IMPLEMENTATION CHECKS
-- Check if objects exist before creating them
-- SELECT * FROM information_schema.tables WHERE table_name = '[TABLE_NAME]';

-- 2. BACKUP (if needed for critical tables)
/*
CREATE TABLE [TABLE_NAME]_backup AS 
SELECT * FROM [TABLE_NAME];
*/

-- 3. IMPLEMENTATION
-- Add your main SQL implementation here
-- Use IF NOT EXISTS where appropriate
-- Include proper error handling

-- 4. VERIFICATION QUERIES
-- Add queries to verify the implementation worked correctly
-- SELECT COUNT(*), * FROM [TABLE_NAME] LIMIT 5;

-- 5. CLEANUP (if needed)
-- DROP TABLE IF EXISTS [TABLE_NAME]_backup;
```

## Safe Column Addition Template

```sql
-- =============================================
-- Safe Column Addition Template
-- =============================================

-- Check if column already exists
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = '[TABLE_NAME]' 
        AND column_name = '[COLUMN_NAME]'
        AND table_schema = 'public'
    ) THEN
        -- Add the column if it doesn't exist
        ALTER TABLE [TABLE_NAME] 
        ADD COLUMN [COLUMN_NAME] [DATA_TYPE] [CONSTRAINTS];
        
        RAISE NOTICE 'Column [COLUMN_NAME] added to [TABLE_NAME]';
    ELSE
        RAISE NOTICE 'Column [COLUMN_NAME] already exists in [TABLE_NAME]';
    END IF;
END $$;

-- Set default values if needed
-- UPDATE [TABLE_NAME] SET [COLUMN_NAME] = [DEFAULT_VALUE] WHERE [COLUMN_NAME] IS NULL;

-- Add constraints if needed
-- ALTER TABLE [TABLE_NAME] ALTER COLUMN [COLUMN_NAME] SET NOT NULL;
```

## Safe Table Creation Template

```sql
-- =============================================
-- Safe Table Creation Template  
-- =============================================

-- Create table with IF NOT EXISTS
CREATE TABLE IF NOT EXISTS [TABLE_NAME] (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Add your columns here
    [COLUMN_DEFINITIONS],
    
    -- Add constraints here
    [CONSTRAINTS]
);

-- Add comments for documentation
COMMENT ON TABLE [TABLE_NAME] IS '[TABLE_DESCRIPTION]';
COMMENT ON COLUMN [TABLE_NAME].[COLUMN_NAME] IS '[COLUMN_DESCRIPTION]';

-- Create indexes if needed
-- CREATE INDEX IF NOT EXISTS [INDEX_NAME] ON [TABLE_NAME] ([COLUMN_NAME]);

-- Grant permissions
-- GRANT SELECT, INSERT, UPDATE ON [TABLE_NAME] TO [ROLE_NAME];
```

## Foreign Key Implementation Template

```sql
-- =============================================
-- Safe Foreign Key Implementation Template
-- =============================================

-- First, ensure referenced table and column exist
DO $$ 
BEGIN
    IF EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = '[REFERENCED_TABLE]' 
        AND column_name = '[REFERENCED_COLUMN]'
        AND table_schema = 'public'
    ) THEN
        -- Check if foreign key already exists
        IF NOT EXISTS (
            SELECT 1 FROM information_schema.table_constraints tc
            JOIN information_schema.key_column_usage kcu 
                ON tc.constraint_name = kcu.constraint_name
            WHERE tc.constraint_type = 'FOREIGN KEY'
            AND tc.table_name = '[TABLE_NAME]'
            AND kcu.column_name = '[COLUMN_NAME]'
        ) THEN
            -- Add foreign key constraint
            ALTER TABLE [TABLE_NAME]
            ADD CONSTRAINT [FK_CONSTRAINT_NAME]
            FOREIGN KEY ([COLUMN_NAME]) REFERENCES [REFERENCED_TABLE]([REFERENCED_COLUMN])
            ON DELETE [DELETE_ACTION] ON UPDATE [UPDATE_ACTION];
            
            RAISE NOTICE 'Foreign key constraint added to [TABLE_NAME]';
        ELSE
            RAISE NOTICE 'Foreign key constraint already exists';
        END IF;
    ELSE
        RAISE EXCEPTION 'Referenced table or column does not exist';
    END IF;
END $$;
```

## Rollback Script Template

```sql
-- =============================================
-- Rollback Script Template
-- =============================================

-- 1. REVERSE COLUMN ADDITIONS
-- ALTER TABLE [TABLE_NAME] DROP COLUMN IF EXISTS [COLUMN_NAME];

-- 2. REVERSE TABLE CREATIONS  
-- DROP TABLE IF EXISTS [TABLE_NAME] CASCADE;

-- 3. REVERSE CONSTRAINT ADDITIONS
-- ALTER TABLE [TABLE_NAME] DROP CONSTRAINT IF EXISTS [CONSTRAINT_NAME];

-- 4. RESTORE FROM BACKUPS (if created)
/*
DROP TABLE IF EXISTS [TABLE_NAME];
ALTER TABLE [TABLE_NAME]_backup RENAME TO [TABLE_NAME];
*/
```

## Usage Guidelines

### 1. **Always Start with Audit**
Before implementing any changes, run an audit to understand the current state:
```sql
-- Check existing tables
SELECT tablename FROM pg_tables WHERE schemaname = 'public';

-- Check existing columns  
SELECT table_name, column_name, data_type 
FROM information_schema.columns 
WHERE table_name = '[YOUR_TABLE]' AND table_schema = 'public';
```

### 2. **Use Transactions for Complex Changes**
```sql
BEGIN;
    -- Your SQL changes here
    ALTER TABLE ...;
    UPDATE ...;
    INSERT ...;
COMMIT;
-- Or ROLLBACK; if something goes wrong
```

### 3. **Test in Development First**
- Always test scripts in a development environment
- Verify all constraints and relationships work correctly
- Check performance impact of changes

### 4. **Document Everything**
- Include clear comments explaining each operation
- Document the business logic behind changes
- Note any dependencies or prerequisites

### 5. **Create Verification Queries**
After implementation, always include queries to verify success:
```sql
-- Verify table exists
SELECT EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_name = '[TABLE_NAME]'
);

-- Verify column exists and has correct type
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = '[TABLE_NAME]' AND column_name = '[COLUMN_NAME]';
```

This template ensures consistent, safe, and well-documented SQL implementations across all future database changes.
