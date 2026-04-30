# Editing Database Tables in Paperclip

This procedure documents the comprehensive process for safely editing database tables in a Paperclip instance, including data manipulation, schema changes, and maintenance operations.

## Overview

Database table editing in Paperclip requires careful consideration of data integrity, foreign key relationships, and system consistency. This procedure covers:

- Safe data manipulation operations
- Schema modification best practices
- Foreign key constraint management
- Data validation and verification
- Rollback and recovery procedures
- Performance considerations

## Prerequisites

- Database access (Supabase SQL Editor or direct PostgreSQL connection)
- Understanding of Paperclip database schema and relationships
- Backup of current data (recommended)
- Clear understanding of the business impact of changes

## Core Principles

### 1. Data Integrity First
- Always maintain referential integrity
- Never break foreign key relationships
- Validate data consistency before and after changes

### 2. Transaction Safety
- Use transactions for multi-step operations
- Test operations in development first
- Have rollback plans ready

### 3. Performance Awareness
- Consider query performance impact
- Use appropriate indexes
- Monitor execution time for large operations

### 4. Documentation
- Document all changes made
- Include rollback procedures
- Update schema documentation

## Table Editing Operations

### Data Manipulation (INSERT, UPDATE, DELETE)

#### Safe UPDATE Operations

```sql
-- Always use WHERE clauses to limit scope
-- Include verification before and after

-- Example: Update agent status with verification
BEGIN;

-- Verify current state
SELECT id, name, status
FROM agents
WHERE company_id = 'your-company-id'
  AND status = 'old_status';

-- Perform update
UPDATE agents
SET status = 'new_status',
    updated_at = NOW()
WHERE company_id = 'your-company-id'
  AND status = 'old_status';

-- Verify changes
SELECT id, name, status, updated_at
FROM agents
WHERE company_id = 'your-company-id'
  AND status = 'new_status';

COMMIT;
```

#### Safe DELETE Operations

```sql
-- Check for foreign key dependencies first
-- Delete child records before parent records

-- Example: Safe agent deletion
BEGIN;

-- Check for dependencies
SELECT
    a.id, a.name,
    COUNT(ak.id) as api_keys,
    COUNT(asa.id) as skill_assignments
FROM agents a
LEFT JOIN agent_api_keys ak ON a.id = ak.agent_id
LEFT JOIN agent_skill_assignments asa ON a.id = asa.agent_id
WHERE a.id = 'agent-to-delete'
GROUP BY a.id, a.name;

-- Delete child records first
DELETE FROM agent_api_keys WHERE agent_id = 'agent-to-delete';
DELETE FROM agent_skill_assignments WHERE agent_id = 'agent-to-delete';

-- Then delete the agent
DELETE FROM agents WHERE id = 'agent-to-delete';

COMMIT;
```

#### Bulk Data Operations

```sql
-- Use CTEs for complex bulk operations
-- Include progress tracking for large datasets

WITH agents_to_update AS (
    SELECT id
    FROM agents
    WHERE company_id = 'target-company'
      AND updated_at < '2024-01-01'
    LIMIT 1000  -- Process in batches
)
UPDATE agents
SET status = 'updated',
    updated_at = NOW()
WHERE id IN (SELECT id FROM agents_to_update);
```

### Schema Modifications

#### Adding Columns

```sql
-- Always add columns as nullable first
-- Then populate data if needed
-- Finally add constraints

-- Step 1: Add nullable column
ALTER TABLE agents ADD COLUMN new_field TEXT;

-- Step 2: Populate data (if needed)
UPDATE agents SET new_field = 'default_value' WHERE new_field IS NULL;

-- Step 3: Add constraints (if appropriate)
ALTER TABLE agents ALTER COLUMN new_field SET NOT NULL;
ALTER TABLE agents ALTER COLUMN new_field SET DEFAULT 'default_value';
```

#### Modifying Columns

```sql
-- Use multiple steps for safe column modifications

-- Step 1: Create new column
ALTER TABLE agents ADD COLUMN new_email TEXT;

-- Step 2: Migrate data
UPDATE agents SET new_email = LOWER(TRIM(email)) WHERE email IS NOT NULL;

-- Step 3: Drop old column (after verification)
-- ALTER TABLE agents DROP COLUMN email;

-- Step 4: Rename new column
ALTER TABLE agents RENAME COLUMN new_email TO email;
```

#### Adding Indexes

```sql
-- Add indexes for frequently queried columns
-- Consider performance impact

-- Example: Index for agent name searches
CREATE INDEX CONCURRENTLY idx_agents_name ON agents (name);

-- Example: Composite index for company + status queries
CREATE INDEX CONCURRENTLY idx_agents_company_status ON agents (company_id, status);

-- Example: Partial index for active agents
CREATE INDEX CONCURRENTLY idx_agents_active ON agents (company_id, name)
WHERE status = 'active';
```

### Foreign Key Management

#### Adding Foreign Key Constraints

```sql
-- Verify data consistency first
-- Add constraints with appropriate actions

-- Check for orphaned records
SELECT COUNT(*) as orphaned_count
FROM agent_api_keys ak
LEFT JOIN agents a ON ak.agent_id = a.id
WHERE a.id IS NULL;

-- Add foreign key constraint
ALTER TABLE agent_api_keys
ADD CONSTRAINT agent_api_keys_agent_id_fkey
FOREIGN KEY (agent_id) REFERENCES agents(id) ON DELETE CASCADE;
```

#### Handling Constraint Violations

```sql
-- Identify constraint violations
SELECT
    ak.id, ak.agent_id, ak.key_name,
    'No matching agent' as issue
FROM agent_api_keys ak
LEFT JOIN agents a ON ak.agent_id = a.id
WHERE a.id IS NULL;

-- Fix violations (delete or update)
DELETE FROM agent_api_keys
WHERE agent_id NOT IN (SELECT id FROM agents);
```

## Data Validation and Verification

### Pre-Change Validation

```sql
-- Count records before changes
SELECT
    'agents' as table_name,
    COUNT(*) as record_count
FROM agents
UNION ALL
SELECT
    'companies' as table_name,
    COUNT(*) as record_count
FROM companies
UNION ALL
SELECT
    'agent_api_keys' as table_name,
    COUNT(*) as record_count
FROM agent_api_keys;
```

### Post-Change Verification

```sql
-- Verify data integrity after changes
SELECT
    'Orphaned API keys' as check_type,
    COUNT(*) as count
FROM agent_api_keys ak
LEFT JOIN agents a ON ak.agent_id = a.id
WHERE a.id IS NULL
UNION ALL
SELECT
    'Orphaned skill assignments' as check_type,
    COUNT(*) as count
FROM agent_skill_assignments asa
LEFT JOIN agents a ON asa.agent_id = a.id
WHERE a.id IS NULL
UNION ALL
SELECT
    'Duplicate agents' as check_type,
    COUNT(*) as count
FROM (
    SELECT name, company_id, COUNT(*)
    FROM agents
    GROUP BY name, company_id
    HAVING COUNT(*) > 1
) duplicates;
```

### Performance Validation

```sql
-- Check query performance
EXPLAIN ANALYZE
SELECT a.name, a.status, COUNT(ak.id) as key_count
FROM agents a
LEFT JOIN agent_api_keys ak ON a.id = ak.agent_id
WHERE a.company_id = 'target-company'
GROUP BY a.id, a.name, a.status;

-- Check index usage
SELECT
    schemaname, tablename, indexname,
    idx_scan, idx_tup_read, idx_tup_fetch
FROM pg_stat_user_indexes
WHERE tablename IN ('agents', 'companies', 'agent_api_keys')
ORDER BY idx_scan DESC;
```

## Rollback and Recovery

### Transaction Rollback

```sql
-- For operations in transactions
ROLLBACK;

-- Or rollback specific changes
UPDATE agents
SET status = 'previous_status'
WHERE id IN (SELECT id FROM recently_modified_agents);
```

### Data Recovery from Backup

```sql
-- Restore from backup if needed
-- (Specific commands depend on backup method used)

-- Verify recovery
SELECT COUNT(*) as recovered_count FROM agents;
```

### Point-in-Time Recovery

```sql
-- For Supabase, use point-in-time recovery
-- Access via Supabase dashboard > Database > Backups
```

## Performance Considerations

### Large Table Operations

```sql
-- Process large updates in batches
CREATE OR REPLACE FUNCTION update_agents_batch(batch_size INTEGER DEFAULT 1000)
RETURNS INTEGER AS $$
DECLARE
    updated_count INTEGER := 0;
    batch_count INTEGER;
BEGIN
    LOOP
        UPDATE agents
        SET updated_at = NOW()
        WHERE id IN (
            SELECT id
            FROM agents
            WHERE updated_at < '2024-01-01'
            LIMIT batch_size
        );

        GET DIAGNOSTICS batch_count = ROW_COUNT;
        updated_count := updated_count + batch_count;

        EXIT WHEN batch_count = 0;

        -- Optional: Add delay between batches
        PERFORM pg_sleep(0.1);
    END LOOP;

    RETURN updated_count;
END;
$$ LANGUAGE plpgsql;

-- Execute the batch update
SELECT update_agents_batch(500);
```

### Index Maintenance

```sql
-- Reindex for performance
REINDEX TABLE CONCURRENTLY agents;

-- Analyze for query planner
ANALYZE agents;

-- Vacuum for space reclamation
VACUUM ANALYZE agents;
```

## Monitoring and Logging

### Change Logging

```sql
-- Create audit log table
CREATE TABLE IF NOT EXISTS table_change_log (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    table_name TEXT NOT NULL,
    operation TEXT NOT NULL, -- INSERT, UPDATE, DELETE
    record_id UUID,
    old_values JSONB,
    new_values JSONB,
    changed_by TEXT,
    changed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Log changes (example trigger function)
CREATE OR REPLACE FUNCTION log_agent_changes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO table_change_log (table_name, operation, record_id, old_values, new_values)
    VALUES (
        'agents',
        TG_OP,
        COALESCE(NEW.id, OLD.id),
        CASE WHEN TG_OP != 'INSERT' THEN row_to_json(OLD) ELSE NULL END,
        CASE WHEN TG_OP != 'DELETE' THEN row_to_json(NEW) ELSE NULL END
    );

    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Attach trigger
CREATE TRIGGER agent_change_log_trigger
    AFTER INSERT OR UPDATE OR DELETE ON agents
    FOR EACH ROW EXECUTE FUNCTION log_agent_changes();
```

## Common Scenarios

### Scenario 1: Bulk Status Updates

```sql
-- Update agent statuses based on criteria
BEGIN;

-- Preview changes
SELECT id, name, status, reports_to
FROM agents
WHERE company_id = 'target-company'
  AND status = 'idle'
  AND last_heartbeat_at < NOW() - INTERVAL '30 days';

-- Apply changes
UPDATE agents
SET status = 'inactive',
    updated_at = NOW()
WHERE company_id = 'target-company'
  AND status = 'idle'
  AND last_heartbeat_at < NOW() - INTERVAL '30 days';

COMMIT;
```

### Scenario 2: Data Migration

```sql
-- Migrate data between columns/tables
BEGIN;

-- Create backup table
CREATE TABLE agents_backup AS
SELECT * FROM agents;

-- Perform migration
UPDATE agents
SET adapter_config = jsonb_set(
    adapter_config,
    '{model}',
    '"new-model-name"'
)
WHERE adapter_config->>'model' = 'old-model-name';

-- Verify migration
SELECT id, name, adapter_config->>'model' as model
FROM agents
WHERE adapter_config->>'model' = 'new-model-name';

COMMIT;
```

### Scenario 3: Duplicate Cleanup

```sql
-- Remove duplicate agents (similar to our earlier script)
WITH duplicate_groups AS (
    SELECT
        name,
        company_id,
        id,
        ROW_NUMBER() OVER (
            PARTITION BY name, company_id
            ORDER BY created_at DESC
        ) as rn
    FROM agents
)
DELETE FROM agents
WHERE id IN (
    SELECT id
    FROM duplicate_groups
    WHERE rn > 1
);
```

## Best Practices Checklist

### Before Making Changes
- [ ] Backup database
- [ ] Test changes in development environment
- [ ] Review foreign key relationships
- [ ] Check for dependent systems
- [ ] Document change plan and rollback procedure

### During Changes
- [ ] Use transactions for multi-step operations
- [ ] Validate data before and after changes
- [ ] Monitor performance impact
- [ ] Log all changes made

### After Changes
- [ ] Verify data integrity
- [ ] Update documentation
- [ ] Monitor system performance
- [ ] Communicate changes to stakeholders
- [ ] Plan follow-up monitoring

## Troubleshooting

### Common Issues

**Foreign Key Constraint Violations**
```sql
-- Identify violations
SELECT * FROM table_with_fk
WHERE fk_column NOT IN (SELECT id FROM referenced_table);

-- Fix by deleting orphans or updating references
DELETE FROM table_with_fk
WHERE fk_column NOT IN (SELECT id FROM referenced_table);
```

**Performance Degradation**
```sql
-- Check slow queries
SELECT pid, query, state, wait_event
FROM pg_stat_activity
WHERE state = 'active' AND query NOT LIKE '%pg_stat%';

-- Add missing indexes
CREATE INDEX CONCURRENTLY idx_table_column ON table_name (column_name);
```

**Lock Conflicts**
```sql
-- Check for locks
SELECT
    blocked_locks.pid AS blocked_pid,
    blocking_locks.pid AS blocking_pid,
    blocked_activity.query AS blocked_query,
    blocking_activity.query AS blocking_query
FROM pg_catalog.pg_locks blocked_locks
JOIN pg_catalog.pg_stat_activity blocked_activity ON blocked_activity.pid = blocked_locks.pid
JOIN pg_catalog.pg_locks blocking_locks
    ON blocking_locks.locktype = blocked_locks.locktype
    AND blocking_locks.database IS NOT DISTINCT FROM blocked_locks.database
    AND blocking_locks.relation IS NOT DISTINCT FROM blocked_locks.relation
    AND blocking_locks.page IS NOT DISTINCT FROM blocked_locks.page
    AND blocking_locks.tuple IS NOT DISTINCT FROM blocked_locks.tuple
    AND blocking_locks.virtualxid IS NOT DISTINCT FROM blocked_locks.virtualxid
    AND blocking_locks.transactionid IS NOT DISTINCT FROM blocked_locks.transactionid
    AND blocking_locks.classid IS NOT DISTINCT FROM blocked_locks.classid
    AND blocking_locks.objid IS NOT DISTINCT FROM blocked_locks.objid
    AND blocking_locks.objsubid IS NOT DISTINCT FROM blocked_locks.objsubid
    AND blocking_locks.pid != blocked_locks.pid
JOIN pg_catalog.pg_stat_activity blocking_activity ON blocking_activity.pid = blocking_locks.pid
WHERE NOT blocked_locks.granted;
```

## Emergency Procedures

### System Unavailable
1. Check database connectivity
2. Review recent changes
3. Restore from backup if necessary
4. Contact system administrator

### Data Corruption Detected
1. Stop all write operations
2. Assess corruption extent
3. Restore affected data from backup
4. Implement preventive measures

### Performance Issues
1. Identify slow queries
2. Check system resources
3. Add missing indexes
4. Optimize query patterns

---

**Version:** 1.0
**Last Updated:** 2026-04-09
**Applies To:** Paperclip Database Operations
**Review Cycle:** Quarterly