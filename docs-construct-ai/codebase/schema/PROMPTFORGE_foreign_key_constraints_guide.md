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

# Foreign Key Constraints Guide

## Overview

This document explains foreign key (FK) constraints in the ConstructAI database, how they protect data integrity, and the proper approach to handling cascading deletions when removing records.

## What are Foreign Key Constraints?

Foreign key constraints are database rules that maintain referential integrity between tables. They ensure that relationships between tables remain consistent by preventing:

- **Orphaned records**: Child records that reference non-existent parent records
- **Invalid references**: References to deleted or non-existent data
- **Data inconsistency**: Broken relationships between related data

### Example

```sql
CREATE TABLE agents (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    company_id UUID REFERENCES companies(id)
);

CREATE TABLE agent_wakeup_requests (
    id UUID PRIMARY KEY,
    agent_id UUID REFERENCES agents(id),  -- FK constraint
    requested_at TIMESTAMP
);
```

In this example, `agent_wakeup_requests.agent_id` has a foreign key constraint to `agents.id`. This means:
- You cannot insert a wakeup request with an `agent_id` that doesn't exist in the `agents` table
- You cannot delete an agent if it has wakeup requests referencing it (unless you delete those requests first)

## The PromptForge Duplication Problem

### Background

The PromptForge company (ID: `f02b83a8-e0db-4332-b507-22f85e71ebf5`) had **56 agent records representing only 28 unique agents**. Each agent was duplicated with different creation timestamps.

**Goal**: Remove the 28 duplicate agents (keeping the earliest created versions) while respecting all foreign key constraints.

### Initial Error

When attempting to delete duplicate agents, we encountered:

```
ERROR: 23503: update or delete on table "agents" violates foreign key constraint 
"agent_wakeup_requests_agent_id_agents_id_fk" on table "agent_wakeup_requests"
DETAIL: Key (id)=(70b0bc03-efb9-4ca5-ad5a-52ca23e14eaf) is still referenced 
from table "agent_wakeup_requests".
```

This error indicates that we tried to delete an agent that still had related records in the `agent_wakeup_requests` table.

## Foreign Key Dependency Chain

Through analysis, we identified **5 tables** with foreign key relationships to the `agents` table:

### 1. Direct Dependencies (1-level)

Tables that directly reference `agents`:

```
agents (parent)
├── agent_api_keys (child)
├── agent_runtime_state (child)
├── agent_wakeup_requests (child)
└── heartbeat_runs (child)
```

### 2. Cascading Dependencies (2-level)

Tables that reference tables which reference `agents`:

```
agents (parent)
└── heartbeat_runs (child)
    └── heartbeat_run_events (grandchild)
```

### Complete Dependency Tree

```
agents
├── agent_api_keys
├── agent_runtime_state
├── agent_wakeup_requests
└── heartbeat_runs
    └── heartbeat_run_events
```

## The Solution: Cascading Deletion Order

To successfully delete agents with foreign key constraints, we must delete records in **reverse dependency order** (deepest children first, parent last).

### Deletion Sequence

```sql
-- 1. Delete deepest dependency first (grandchild)
DELETE FROM heartbeat_run_events
WHERE run_id IN (
    SELECT id FROM heartbeat_runs
    WHERE agent_id IN (SELECT agent_id FROM duplicate_agents)
);

-- 2. Delete second-level dependency (child of heartbeat_runs)
DELETE FROM heartbeat_runs
WHERE agent_id IN (SELECT agent_id FROM duplicate_agents);

-- 3. Delete direct dependencies (children of agents)
DELETE FROM agent_api_keys
WHERE agent_id IN (SELECT agent_id FROM duplicate_agents);

DELETE FROM agent_runtime_state
WHERE agent_id IN (SELECT agent_id FROM duplicate_agents);

DELETE FROM agent_wakeup_requests
WHERE agent_id IN (SELECT agent_id FROM duplicate_agents);

-- 4. Finally, delete the parent records (agents)
DELETE FROM agents
WHERE id IN (SELECT agent_id FROM duplicate_agents);
```

### Why This Order Matters

1. **heartbeat_run_events** must be deleted first because it references `heartbeat_runs`
2. **heartbeat_runs** must be deleted before `agents` because it references `agents`
3. **agent_api_keys**, **agent_runtime_state**, and **agent_wakeup_requests** must be deleted before `agents` because they all reference `agents`
4. **agents** can only be deleted after all child records are removed

## Best Practices for FK Constraint Management

### 1. Discovery Phase

Before deleting any parent records, identify all foreign key constraints:

```sql
-- Find all tables that reference a specific table
SELECT
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu
    ON ccu.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
    AND ccu.table_name = 'agents';
```

### 2. Verification Phase

Before deletion, check how many records will be affected:

```sql
SELECT 'agent_wakeup_requests' as table_name, COUNT(*) as records_to_delete
FROM agent_wakeup_requests
WHERE agent_id IN (SELECT agent_id FROM duplicate_agents);
```

### 3. Deletion Phase

Use a temporary table to manage the list of IDs to delete:

```sql
CREATE TEMP TABLE duplicate_agents AS
SELECT unnest(ARRAY[
    '462cd9a9-15a7-4ab3-914b-5daee597936b'::uuid,
    '661b05f2-efec-44f2-9329-cebb5b56573c'::uuid
    -- ... more IDs
]) as agent_id;
```

### 4. Validation Phase

After deletion, verify the cleanup:

```sql
-- Should show expected count
SELECT COUNT(*) as remaining_agents
FROM agents
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
AND deleted_at IS NULL;
```

## Common FK Constraint Errors

### Error 23503: Foreign Key Violation

```
ERROR: 23503: update or delete on table "X" violates foreign key constraint "Y" on table "Z"
```

**Cause**: Attempting to delete/update a parent record that has child records referencing it.

**Solution**: Delete child records first, then parent records.

### Error 23502: Not Null Violation

```
ERROR: 23502: null value in column "X" violates not-null constraint
```

**Cause**: Attempting to set a foreign key column to NULL when it's defined as NOT NULL.

**Solution**: Delete the record instead of setting it to NULL, or modify the constraint.

### Error 23505: Unique Violation

```
ERROR: 23505: duplicate key value violates unique constraint "X"
```

**Cause**: Attempting to insert/update a record with a value that already exists in a unique column.

**Solution**: Check for existing records before insertion, or use `ON CONFLICT` clauses.

## Tools for FK Analysis

### 1. Schema Extraction Script

Located at: `schemas/generate_database_schema.cjs`

Generates comprehensive schema documentation including all foreign key relationships.

### 2. Foreign Key Checker

Located at: `schemas/check_foreign_keys.cjs`

Analyzes and reports all foreign key constraints for a specific table.

### 3. Database Schema Documentation

Located at: `schemas/database_schema.json`

Machine-readable schema with complete FK constraint information.

## The PromptForge Solution

The complete solution is implemented in: `rectify_promptforge_duplicates.sql`

**Key Features**:
- Temporary table for managing duplicate IDs
- Verification queries before deletion
- Proper cascading deletion order
- Post-deletion validation
- Clean temp table cleanup

**Result**: Successfully removes 28 duplicate agents while preserving 28 original agents with earliest timestamps.

## Lessons Learned

1. **Always discover all FK constraints** before attempting deletions
2. **Delete in reverse dependency order** (children before parents)
3. **Use verification queries** to understand the scope of changes
4. **Test on a subset** before running full deletions
5. **Document the dependency chain** for future reference
6. **Use temporary tables** for cleaner, more maintainable SQL
7. **Validate results** after deletion to ensure data integrity

## Related Documentation

- [Agents Schema Documentation](./agents_schema.md)
- [Database Schema JSON](../../schemas/database_schema.json)
- [PromptForge Duplication Analysis](../../appendix_a_agents_reconciliation_analysis.md)

## References

- PostgreSQL Foreign Keys: https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-FK
- Supabase Foreign Keys: https://supabase.com/docs/guides/database/tables#foreign-keys
- SQL Error Codes: https://www.postgresql.org/docs/current/errcodes-appendix.html
