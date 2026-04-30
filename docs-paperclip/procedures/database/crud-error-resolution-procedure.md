# CRUD Error Resolution Procedure

**Document Type**: Procedure
**Last Updated**: 2026-04-22
**Status**: Critical - Immediate Implementation Required

## Executive Summary

This procedure addresses the repeated errors in adding, editing, and deleting records across Paperclip database tables. Root cause analysis reveals **schema drift**, **incomplete FK dependency handling**, and **unique constraint violations** as primary causes.

## Root Cause Analysis

### 1. Schema Drift (Critical)
- **Issue**: `agent_skill_assignments` table exists in production but NOT in TypeScript schema (`packages/db/src/schema/index.ts`)
- **Impact**: FK deletion procedures fail because they don't account for this table
- **Evidence**: FK-DEPENDENCY-LEVELS.md explicitly warns about this schema drift

### 2. Incomplete FK Dependency Handling
- **Issue**: Deletion procedures don't include all child tables in correct order
- **Impact**: FK constraint violations when deleting agents
- **Evidence**: FK deletion procedure missing `agent_skill_assignments` and other potential dependencies

### 3. Unique Constraint Misunderstanding
- **Issue**: Agents table has NO unique constraint on `name` column, but procedures assume it does
- **Impact**: Duplicate prevention scripts fail, causing confusion
- **Evidence**: unique-constraints.md states "agents.name has NO unique constraint"

### 4. Type Casting Issues
- **Issue**: UUID vs VARCHAR comparison errors in SQL scripts
- **Impact**: Query failures during bulk operations
- **Evidence**: Multiple scripts use incorrect type comparisons

## Comprehensive Solution Plan

### Phase 1: Schema Synchronization (Immediate - 1-2 hours)

#### Step 1.1: Add Missing Schema Definitions
```sql
-- Add agent_skill_assignments table to packages/db/src/schema/index.ts
-- This table exists in production but is missing from schema
```

#### Step 1.2: Update FK Dependency Documentation
- Add `agent_skill_assignments` to FK-DEPENDENCY-LEVELS.md
- Update deletion order to include the missing table
- Verify all production tables are documented

#### Step 1.3: Schema Validation Script
```sql
-- Create script to compare production schema vs TypeScript schema
SELECT 'Production tables not in schema:' as check_type;
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name NOT IN (
    'companies', 'agents', 'agent_api_keys', 'agent_config_revisions',
    'heartbeat_runs', 'heartbeat_run_events', 'agent_task_sessions',
    'execution_workspaces', 'agent_runtime_state', 'agent_wakeup_requests',
    'issues', 'issue_comments', 'issue_labels', 'issue_relations',
    'projects', 'project_workspaces', 'goals', 'labels', 'plugins',
    'adapter_configurations', 'budget_policies', 'api_keys',
    'company_skills', 'company_secrets', 'cost_events', 'finance_events',
    'activity_log'
  );
```

### Phase 2: FK Deletion Procedure Overhaul (Immediate - 2-4 hours)

#### Step 2.1: Complete FK Dependency Mapping
Update `fk-deletion-procedure.md` with complete dependency chain:

```
agents (parent)
├── agent_api_keys (direct FK)
├── agent_config_revisions (direct FK - agent_id, created_by_agent_id)
├── agent_skill_assignments (MISSING - direct FK) ← ADD THIS
├── heartbeat_runs (direct FK)
│   └── heartbeat_run_events (chained FK)
├── agent_task_sessions (direct FK)
├── agent_runtime_state (direct FK)
├── agent_wakeup_requests (direct FK)
├── issues (nullable FK - assignee_id)
├── agents (self-ref - reports_to)
└── activity_log (nullable FK - actor_id)
```

#### Step 2.2: Updated Deletion Order
```sql
-- CORRECTED DELETION ORDER (12 steps)
DELETE FROM heartbeat_run_events WHERE run_id IN (...);         -- 1
DELETE FROM heartbeat_runs WHERE agent_id::TEXT IN (...);       -- 2
DELETE FROM execution_workspaces WHERE agent_id::TEXT IN (...); -- 3
DELETE FROM agent_task_sessions WHERE agent_id::TEXT IN (...);  -- 4
DELETE FROM agent_runtime_state WHERE agent_id::TEXT IN (...);  -- 5
DELETE FROM agent_wakeup_requests WHERE agent_id::TEXT IN (...);-- 6
DELETE FROM agent_config_revisions WHERE agent_id::TEXT IN (...) OR created_by_agent_id::TEXT IN (...); -- 7
DELETE FROM agent_api_keys WHERE agent_id::TEXT IN (...);       -- 8
DELETE FROM agent_skill_assignments WHERE agent_id::TEXT IN (...); -- 9 ← ADD THIS
UPDATE issues SET assignee_id = NULL WHERE assignee_id::TEXT IN (...); -- 10
UPDATE agents SET reports_to = NULL WHERE reports_to::TEXT IN (...); -- 11
UPDATE activity_log SET actor_id = NULL WHERE actor_id::TEXT IN (...); -- 12
DELETE FROM agents WHERE id::TEXT IN (...); -- 13 (FINAL)
```

#### Step 2.3: Create Automated Deletion Script
```sql
CREATE OR REPLACE FUNCTION delete_agent_safely(agent_ids TEXT[])
RETURNS TABLE(deleted_table TEXT, deleted_count INTEGER) AS $$
DECLARE
    temp_table_name TEXT := 'temp_agents_to_delete_' || gen_random_uuid()::TEXT;
BEGIN
    -- Create temporary table
    EXECUTE format('CREATE TEMP TABLE %I (id TEXT)', temp_table_name);
    EXECUTE format('INSERT INTO %I SELECT unnest($1)', temp_table_name) USING agent_ids;

    -- Delete in correct order with proper type casting
    RETURN QUERY SELECT 'heartbeat_run_events'::TEXT,
        (SELECT COUNT(*) FROM heartbeat_run_events hre
         WHERE hre.run_id IN (
             SELECT hr.id::TEXT FROM heartbeat_runs hr
             WHERE hr.agent_id::TEXT IN (SELECT id FROM temp_table_name)
         ));

    -- ... continue for all tables in correct order

    -- Cleanup
    EXECUTE format('DROP TABLE %I', temp_table_name);

    RETURN;
END;
$$ LANGUAGE plpgsql;
```

### Phase 3: Unique Constraint Handling Fix (Immediate - 1 hour)

#### Step 3.1: Update Agent Creation Procedures
- Remove assumptions about unique agent names
- Use `WHERE NOT EXISTS` pattern for safe inserts
- Update all agent creation scripts

#### Step 3.2: Fix Duplicate Detection Scripts
```sql
-- CORRECTED: Agents table has NO unique constraint on name
-- Use this pattern for "safe" inserts:
INSERT INTO agents (id, company_id, name, ...)
SELECT gen_random_uuid(), $company_id, 'agent-name', ...
WHERE NOT EXISTS (
    SELECT 1 FROM agents
    WHERE name = 'agent-name'
    -- Optionally add company_id check if cross-company duplicates not allowed
);
```

#### Step 3.3: Update Documentation
- Clarify that agent names are NOT unique
- Document proper duplicate handling procedures
- Update all procedures that assume unique names

### Phase 4: Type Casting Standardization (Immediate - 30 minutes)

#### Step 4.1: Create Type Casting Guidelines
```sql
-- ALWAYS use ::TEXT for UUID comparisons in WHERE clauses
SELECT * FROM agents WHERE id::TEXT IN ('uuid1', 'uuid2');

-- NEVER do this (causes "operator does not exist" errors):
SELECT * FROM agents WHERE id IN ('uuid1', 'uuid2');
```

#### Step 4.2: Audit and Fix Existing Scripts
- Search all SQL scripts for incorrect UUID comparisons
- Replace with proper `::TEXT` casting
- Add validation to prevent future occurrences

### Phase 5: Automated Validation System (Medium-term - 4-8 hours)

#### Step 5.1: Pre-Operation Validation Function
```sql
CREATE OR REPLACE FUNCTION validate_crud_operation(
    operation_type TEXT,  -- 'INSERT', 'UPDATE', 'DELETE'
    table_name TEXT,
    record_ids TEXT[] DEFAULT NULL
) RETURNS TABLE(validation_result TEXT, is_valid BOOLEAN) AS $$
BEGIN
    -- Validate FK constraints
    -- Check for orphaned records
    -- Verify schema consistency
    -- Return validation results
END;
$$ LANGUAGE plpgsql;
```

#### Step 5.2: Post-Operation Verification
```sql
CREATE OR REPLACE FUNCTION verify_crud_operation(
    operation_type TEXT,
    table_name TEXT,
    affected_count INTEGER
) RETURNS TABLE(check_type TEXT, status TEXT, details TEXT) AS $$
BEGIN
    -- Verify no orphaned records
    -- Check FK constraint satisfaction
    -- Validate data integrity
END;
$$ LANGUAGE plpgsql;
```

## Implementation Priority

### Immediate Actions (Today)
1. ✅ Add `agent_skill_assignments` to schema and FK procedures
2. ✅ Update deletion order to include missing table
3. ✅ Fix type casting in all scripts
4. ✅ Update agent creation procedures to handle non-unique names

### Short-term Actions (This Week)
1. Create automated deletion function
2. Implement pre/post-operation validation
3. Update all documentation with corrected procedures
4. Train team on proper CRUD operations

### Long-term Actions (This Month)
1. Implement schema drift detection system
2. Create comprehensive test suite for CRUD operations
3. Establish regular schema validation procedures
4. Implement automated FK dependency mapping

## Success Metrics

### Error Reduction
- **Target**: 90% reduction in FK constraint violation errors within 1 week
- **Target**: 100% elimination of "operator does not exist" type casting errors
- **Target**: Zero schema drift issues

### Process Improvement
- **Target**: All CRUD operations follow validated procedures
- **Target**: Automated validation catches 100% of FK issues
- **Target**: Documentation accuracy maintained at 100%

## Emergency Procedures

### When FK Errors Occur
1. **Stop all operations** on affected tables
2. **Run validation queries** to identify orphaned records
3. **Use corrected deletion procedure** with proper order
4. **Verify schema consistency** before resuming operations

### When Schema Drift Detected
1. **Document the drift** with evidence
2. **Update TypeScript schema** to match production
3. **Update all dependent procedures** and documentation
4. **Implement prevention measures** for future drift

## Related Documentation Updates Required

1. `fk-deletion-procedure.md` - Add missing `agent_skill_assignments` table
2. `FK-DEPENDENCY-LEVELS.md` - Update with complete dependency mapping
3. `unique-constraints.md` - Clarify agent name handling
4. `editing-database-tables.md` - Add type casting guidelines
5. `atlas-agent-creation-with-schema-inspection-procedure.md` - Update for schema drift handling

## Quality Assurance

### Pre-Implementation Testing
- [ ] Test deletion procedure on development data
- [ ] Verify all FK constraints properly handled
- [ ] Confirm type casting fixes work correctly
- [ ] Validate agent creation with duplicate names

### Post-Implementation Validation
- [ ] Monitor error rates for 1 week after implementation
- [ ] Verify all CRUD operations work without FK violations
- [ ] Confirm schema documentation matches production
- [ ] Validate automated procedures work correctly

---

**Implementation Owner**: Database Operations Team
**Review Cycle**: Weekly until stabilized, then monthly
**Last Updated**: 2026-04-22
**Priority**: Critical - Blocks all database operations