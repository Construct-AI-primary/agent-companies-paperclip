# Deleting Companies and Agents

**Last Updated:** 2026-04-12  
**Version:** 1.0  
**Audience:** Database Administrators, Platform Operators

## Overview

This procedure provides step-by-step instructions for safely deleting companies and agents from the Paperclip database while respecting foreign key constraints and maintaining data integrity.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Important Considerations](#important-considerations)
3. [Foreign Key Dependency Overview](#foreign-key-dependency-overview)
4. [Procedure A: Deleting Archived Companies](#procedure-a-deleting-archived-companies)
5. [Procedure B: Deleting Terminated Agents](#procedure-b-deleting-terminated-agents)
6. [Verification Steps](#verification-steps)
7. [Rollback Procedures](#rollback-procedures)
8. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required Access
- PostgreSQL admin access to Supabase database
- `psql` command-line tool installed
- Database credentials (connection string)

### Required Knowledge
- Understanding of SQL and foreign key constraints
- Familiarity with PostgreSQL transactions
- Basic understanding of Paperclip data model

### Backup Requirements
**CRITICAL**: Always create a backup before deletion operations:

```bash
# Create database backup
PGPASSWORD='your_password' pg_dump -h db.host.supabase.co -U postgres -d postgres \
  -f backup_$(date +%Y%m%d_%H%M%S).sql
```

### Scripts Location
Pre-built cleanup scripts are available:
- Companies: `scripts/database/cleanup_archived_companies.sql`
- Agents: `scripts/database/cleanup_terminated_agents.sql`

### CRITICAL SCHEMA WARNINGS
**⚠️ BEFORE PROCEEDING: Check for Schema Drift**

1. **agent_skill_assignments table**: This table exists in production but may NOT be in your schema
   - Check: `SELECT table_name FROM information_schema.tables WHERE table_name = 'agent_skill_assignments';`
   - If missing from schema: Add to `packages/db/src/schema/index.ts` before proceeding
   - Impact: Deletion will fail with FK constraint violations if this table exists but isn't handled

2. **Verify FK Dependencies**: Always check `FK-DEPENDENCY-LEVELS.md` for the latest dependency mapping
   - Current critical gap: `agent_skill_assignments` table missing from deletion procedures
   - Use corrected procedures from `fk-deletion-procedure.md` (updated 2026-04-22)

3. **Type Casting**: Use `::TEXT` for all UUID comparisons in WHERE clauses
   - Correct: `WHERE agent_id::TEXT IN (SELECT id FROM to_delete)`
   - Incorrect: `WHERE agent_id IN (SELECT id FROM to_delete)` ← Causes "operator does not exist" errors

---

## Important Considerations

### Before You Delete

1. **Soft Delete vs Hard Delete**
   - Consider using `status='archived'` or `deleted_at` timestamps first
   - Hard deletion is permanent and cannot be easily reversed

2. **Impact Assessment**
   - Run analysis queries to understand deletion impact
   - Review dependencies and affected records
   - Communicate with stakeholders about affected issues/projects

3. **Timing**
   - Schedule deletions during low-activity periods
   - Ensure no active agent operations are running
   - Allow sufficient time for verification

4. **Data Preservation**
   - Export critical data before deletion
   - Document deleted entities for audit trail
   - Consider archiving historical data separately

---

## Foreign Key Dependency Overview

Understanding the FK dependency chain is crucial for proper deletion order.

### Company Deletion Dependencies (92 FK relationships)

Companies are referenced by 40+ tables. The deletion order must be:

**Level 1**: Deepest dependencies (records referencing heartbeat_runs)
- workspace_runtime_services
- workspace_operations
- issue_work_products
- issues (checkout_run_id, execution_run_id)
- finance_events (heartbeat_run_id)
- cost_events (heartbeat_run_id)
- activity_log (run_id)
- agent_task_sessions (last_run_id)

**Level 2**: Heartbeat records
- heartbeat_run_events
- heartbeat_runs

**Level 3**: Company-scoped activity
- cost_events (company_id)
- finance_events (company_id)
- activity_log (company_id)
- agent_task_sessions (company_id)

**Level 4**: Agent configuration
- agent_wakeup_requests
- agent_runtime_state
- agent_config_revisions
- agent_api_keys
- agent_skill_assignments

**Level 5**: Issue-related records
- issue_work_products
- issue_read_states
- issue_labels
- issue_inbox_archives
- issue_documents
- issue_attachments
- issue_approvals
- issue_comments
- issues

**Level 6**: Projects and routines
- routine_runs
- routine_triggers
- routines
- project_workspaces
- project_goals
- projects

**Level 7**: Documents and approvals
- approval_comments
- approvals
- document_revisions
- documents
- assets

**Level 8**: Workspaces
- workspace_runtime_services (company_id)
- workspace_operations (company_id)
- execution_workspaces

**Level 9**: Company configuration
- company_secret_versions
- company_secrets
- company_skills
- company_logos
- budget_incidents
- budget_policies
- plugin_company_settings
- principal_permission_grants

**Level 10**: Auth and invites
- cli_auth_challenges
- join_requests
- invites
- labels

**Level 11**: Goals and agents
- goals
- agents

**Level 12**: Companies
- companies

### Agent Deletion Dependencies (34 FK relationships)

Agents are referenced by 30+ tables. The deletion order must be:

**Level 1**: Records referencing heartbeat_runs (same as companies)

**Level 2**: Heartbeat records
- heartbeat_run_events
- heartbeat_runs

**Level 3**: Agent activity
- cost_events
- finance_events
- activity_log
- agent_task_sessions

**Level 4**: Agent configuration
- agent_wakeup_requests
- agent_runtime_state
- agent_skill_assignments (MUST be deleted before agents table)
- agent_config_revisions (both agent_id and created_by_agent_id)
- agent_api_keys
- agent_models

**Level 5**: Records created/owned by agent
- company_secret_versions (created_by_agent_id)
- company_secrets (created_by_agent_id)
- document_revisions (created_by_agent_id)
- documents (created_by_agent_id, updated_by_agent_id)
- assets (created_by_agent_id)
- approval_comments (author_agent_id)
- approvals (requested_by_agent_id)
- issue_approvals (linked_by_agent_id)
- issue_comments (author_agent_id)
- workspace_runtime_services (owner_agent_id)

**Level 6**: Nullable FK updates (set to NULL)
- issues (assignee_agent_id, created_by_agent_id)
- goals (owner_agent_id)
- projects (lead_agent_id)
- routines (assignee_agent_id, created_by_agent_id, updated_by_agent_id)
- routine_triggers (created_by_agent_id, updated_by_agent_id)
- join_requests (created_agent_id)
- agents (reports_to) - self-referential

**Level 7**: Agent deletion
- agents

---

## Procedure A: Deleting Archived Companies

### Step 1: Identify Companies to Delete

```sql
-- List archived companies
SELECT id, name, status, created_at, 
       (SELECT COUNT(*) FROM agents WHERE company_id = companies.id) as agent_count,
       (SELECT COUNT(*) FROM goals WHERE company_id = companies.id) as goal_count,
       (SELECT COUNT(*) FROM issues WHERE company_id = companies.id) as issue_count
FROM companies 
WHERE status = 'archived'
ORDER BY name;
```

**Review the output carefully**:
- Note company names and IDs
- Check agent counts (will be deleted)
- Check goal and issue counts (will be deleted)
- Verify these are truly obsolete companies

### Step 2: Document Deletion Scope

Create a record of what will be deleted:

```sql
-- Export deletion impact report
COPY (
  SELECT 'Company' as type, c.name, c.id::text
  FROM companies c
  WHERE c.status = 'archived'
  UNION ALL
  SELECT 'Agent', a.name, a.id::text
  FROM agents a
  WHERE a.company_id IN (SELECT id FROM companies WHERE status = 'archived')
  UNION ALL
  SELECT 'Goal', g.title, g.id::text
  FROM goals g
  WHERE g.company_id IN (SELECT id FROM companies WHERE status = 'archived')
) TO '/tmp/deletion_manifest.csv' WITH CSV HEADER;
```

### Step 3: Create Database Backup

```bash
# Create timestamped backup
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
PGPASSWORD='your_password' pg_dump -h db.host.supabase.co -U postgres -d postgres \
  -f backup_before_company_deletion_${TIMESTAMP}.sql

# Verify backup exists and has content
ls -lh backup_before_company_deletion_${TIMESTAMP}.sql
```

### Step 4: Execute Deletion Script

```bash
# Run the cleanup script
PGPASSWORD='your_password' psql -h db.host.supabase.co -U postgres -d postgres \
  -f scripts/database/cleanup_archived_companies.sql
```

**The script will**:
1. Display companies to be deleted
2. Delete all dependencies in correct order
3. Delete the companies
4. Show remaining companies
5. Commit the transaction

### Step 5: Verify Deletion

```sql
-- Confirm no archived companies remain
SELECT COUNT(*) as archived_count FROM companies WHERE status = 'archived';
-- Expected: 0

-- Confirm active companies intact
SELECT name, status FROM companies WHERE status = 'active' ORDER BY name;

-- Verify no orphaned records
SELECT COUNT(*) FROM agents WHERE company_id NOT IN (SELECT id FROM companies);
-- Expected: 0

SELECT COUNT(*) FROM goals WHERE company_id NOT IN (SELECT id FROM companies);
-- Expected: 0
```

### Step 6: Document Results

Create a cleanup report documenting:
- Companies deleted (names, IDs, deletion timestamp)
- Record counts deleted
- Remaining companies
- Any issues encountered

Template: `docs-paperclip/reports/YYYY-MM-DD-archived-companies-cleanup.md`

---

## Procedure B: Deleting Terminated Agents

### Step 1: Identify Agents to Delete

```sql
-- List terminated and soft-deleted agents
SELECT a.id, c.name as company, a.name as agent_name, 
       a.status, a.is_active, a.deleted_at, a.created_at,
       (SELECT COUNT(*) FROM issues WHERE assignee_agent_id = a.id) as assigned_issues,
       (SELECT COUNT(*) FROM issues WHERE created_by_agent_id = a.id) as created_issues
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.status = 'terminated' OR a.deleted_at IS NOT NULL
ORDER BY c.name, a.name;
```

**Review the output carefully**:
- Note agent names and IDs
- Check company assignments
- Review issue counts (will be unassigned)
- Verify these agents are truly obsolete

**IMPORTANT**: Do NOT delete agents with status='idle' unless they have `deleted_at` set. "Idle" is the normal ready state for agents.

### Step 2: Assess Impact

```sql
-- Check what will be affected
SELECT 
  'Agents' as entity,
  COUNT(*) as count
FROM agents
WHERE status = 'terminated' OR deleted_at IS NOT NULL

UNION ALL

SELECT 
  'Issues to unassign (assignee)',
  COUNT(*)
FROM issues
WHERE assignee_agent_id IN (
  SELECT id FROM agents WHERE status = 'terminated' OR deleted_at IS NOT NULL
)

UNION ALL

SELECT 
  'Issues to unassign (creator)',
  COUNT(*)
FROM issues
WHERE created_by_agent_id IN (
  SELECT id FROM agents WHERE status = 'terminated' OR deleted_at IS NOT NULL
)

UNION ALL

SELECT 
  'Agent hierarchy refs',
  COUNT(*)
FROM agents
WHERE reports_to IN (
  SELECT id FROM agents WHERE status = 'terminated' OR deleted_at IS NOT NULL
);
```

### Step 3: Create Database Backup

```bash
# Create timestamped backup
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
PGPASSWORD='your_password' pg_dump -h db.host.supabase.co -U postgres -d postgres \
  -f backup_before_agent_deletion_${TIMESTAMP}.sql

# Verify backup exists
ls -lh backup_before_agent_deletion_${TIMESTAMP}.sql
```

### Step 4: Execute Deletion Script

**Option A: Using SQL Script (PostgreSQL)**
```bash
# Run the cleanup script
PGPASSWORD='your_password' psql -h db.host.supabase.co -U postgres -d postgres \
  -f scripts/database/cleanup_terminated_agents.sql
```

**Option B: Using Supabase Client (Node.js)**
```javascript
const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

const agentIds = ['agent-id-1', 'agent-id-2'];

async function deleteAgents() {
  // CRITICAL: Delete in this exact order to respect FK constraints
  
  // 1. Delete agent_skill_assignments FIRST (blocks agent deletion)
  await supabase.from('agent_skill_assignments').delete().in('agent_id', agentIds);
  
  // 2. Delete agent_models
  await supabase.from('agent_models').delete().in('agent_id', agentIds);
  
  // 3. Delete agent_api_keys
  await supabase.from('agent_api_keys').delete().in('agent_id', agentIds);
  
  // 4. Delete agents
  await supabase.from('agents').delete().in('id', agentIds);
}
```

**The script will**:
1. Display agents to be deleted
2. Delete all dependencies in correct order (agent_skill_assignments MUST be first)
3. Update nullable FK references to NULL
4. Delete the agents
5. Show remaining agent distribution
6. Commit the transaction

### Step 5: Verify Deletion

```sql
-- Confirm no terminated agents remain
SELECT COUNT(*) as terminated_count 
FROM agents 
WHERE status = 'terminated' OR deleted_at IS NOT NULL;
-- Expected: 0

-- Verify agent status distribution
SELECT status, is_active, COUNT(*) as count
FROM agents
GROUP BY status, is_active
ORDER BY status, is_active;

-- Check for orphaned references (should be 0)
SELECT COUNT(*) FROM agent_api_keys 
WHERE agent_id NOT IN (SELECT id FROM agents);
-- Expected: 0
```

### Step 6: Review Affected Issues

```sql
-- List issues that lost their assignee
SELECT id, title, status, company_id
FROM issues
WHERE assignee_agent_id IS NULL
  AND status NOT IN ('done', 'closed')
ORDER BY created_at DESC
LIMIT 50;
```

**Post-deletion action**: These issues may need manual reassignment to active agents.

### Step 7: Document Results

Create a cleanup report documenting:
- Agents deleted (names, companies, deletion timestamp)
- Record counts deleted/updated
- Issues requiring reassignment
- Any issues encountered

Template: `docs-paperclip/reports/YYYY-MM-DD-terminated-agents-cleanup.md`

---

## Verification Steps

### General Health Checks

Run these queries after any deletion operation:

```sql
-- 1. FK integrity check (should return no rows)
SELECT 'orphaned_agents' as check_name, COUNT(*) as count
FROM agents WHERE company_id NOT IN (SELECT id FROM companies)
UNION ALL
SELECT 'orphaned_goals', COUNT(*)
FROM goals WHERE company_id NOT IN (SELECT id FROM companies)
UNION ALL
SELECT 'orphaned_agent_api_keys', COUNT(*)
FROM agent_api_keys WHERE agent_id NOT IN (SELECT id FROM agents)
UNION ALL
SELECT 'orphaned_heartbeat_runs', COUNT(*)
FROM heartbeat_runs WHERE agent_id NOT IN (SELECT id FROM agents);

-- 2. Company health check
SELECT 
  status,
  COUNT(*) as company_count,
  SUM((SELECT COUNT(*) FROM agents WHERE company_id = companies.id)) as total_agents
FROM companies
GROUP BY status;

-- 3. Agent health check
SELECT 
  c.name as company,
  COUNT(a.id) as agent_count,
  COUNT(CASE WHEN a.status = 'idle' THEN 1 END) as idle,
  COUNT(CASE WHEN a.status = 'active' THEN 1 END) as active,
  COUNT(CASE WHEN a.status = 'error' THEN 1 END) as error
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id AND a.is_active = true
GROUP BY c.name
ORDER BY c.name;
```

All orphan checks should return count = 0.

---

## Rollback Procedures

### If Deletion Fails Mid-Transaction

PostgreSQL transactions will auto-rollback on error. The database will be unchanged.

### If Deletion Completes But Needs Reversal

**Option 1**: Restore from backup (RECOMMENDED)

```bash
# Stop application access to database first
# Then restore from backup
PGPASSWORD='your_password' psql -h db.host.supabase.co -U postgres -d postgres \
  < backup_before_deletion_TIMESTAMP.sql
```

**Option 2**: Selective restoration

If you only need to restore specific companies/agents:

```bash
# Extract specific tables from backup
PGPASSWORD='your_password' pg_restore -h db.host.supabase.co -U postgres -d postgres \
  -t companies -t agents backup_file.dump
```

**Important**: Full restoration may conflict with any data created after the backup. Always test in a staging environment first.

---

## Troubleshooting

### Error: Foreign Key Violation

**Symptom**: `ERROR: update or delete on table "X" violates foreign key constraint "Y"`

**Cause**: Deletion order is incorrect or script missed a dependency

**Solution**:
1. The transaction will auto-rollback, database is safe
2. Identify the missing table in the error message
3. Add deletion for that table before the table it references
4. Re-run the script

**Example**:
```
ERROR: delete on table "heartbeat_runs" violates FK "activity_log_run_id_fk"
```
Means: Delete from `activity_log` BEFORE deleting from `heartbeat_runs`

### Error: Temp Table Already Exists

**Symptom**: `ERROR: relation "agents_to_delete" already exists`

**Cause**: Previous script run didn't complete cleanup

**Solution**:
```sql
DROP TABLE IF EXISTS agents_to_delete;
-- Then re-run script
```

### Slow Deletion Performance

**Symptom**: Script takes very long to execute

**Cause**: Large number of records, missing indexes, or lock contention

**Solutions**:
1. Run during low-activity periods
2. Consider batching deletions (delete 1 company at a time)
3. Check for locks: `SELECT * FROM pg_locks WHERE NOT granted;`
4. Ensure indexes exist on FK columns

### Deletion Completes But Data Seems Inconsistent

**Actions**:
1. Run verification queries immediately
2. Check for orphaned records
3. Review transaction log
4. If serious inconsistency found, restore from backup
5. Document issue for investigation

---

## Best Practices

### Before Deletion

1. ✅ **Always create backups** before ANY deletion operation
2. ✅ **Test scripts on staging** environment first
3. ✅ **Document deletion scope** - what and why
4. ✅ **Communicate with stakeholders** - warn affected users
5. ✅ **Schedule appropriately** - low-activity periods only
6. ✅ **Review dependencies** - understand impact fully

### During Deletion

1. ✅ **Monitor progress** - watch for errors in real-time
2. ✅ **Use transactions** - all or nothing approach
3. ✅ **Follow exact FK order** - documented in this guide
4. ✅ **Update nullables** - set FKs to NULL where appropriate
5. ✅ **Log everything** - capture all output

### After Deletion

1. ✅ **Verify immediately** - run all health checks
2. ✅ **Document results** - create cleanup report
3. ✅ **Review affected items** - issues, projects needing attention
4. ✅ **Monitor for issues** - watch for unexpected problems
5. ✅ **Archive backups** - keep for audit trail

### Regular Maintenance

1. 📅 **Quarterly cleanup** - remove accumulated archived data
2. 📅 **Monthly review** - identify candidates for archival
3. 📊 **Trend monitoring** - track growth and deletion patterns
4. 📚 **Documentation** - keep procedures updated
5. 🔄 **Process refinement** - improve based on experience

---

## Quick Reference

### Company Deletion Checklist

- [ ] Identify archived companies
- [ ] Review deletion impact (agents, goals, issues)
- [ ] Create database backup
- [ ] Export deletion manifest
- [ ] Run cleanup script
- [ ] Verify no archived companies remain
- [ ] Verify no orphaned records
- [ ] Document results in cleanup report
- [ ] Archive backup

### Agent Deletion Checklist

- [ ] Identify terminated/soft-deleted agents
- [ ] Review impact (issues, hierarchy, created content)
- [ ] Create database backup
- [ ] Run cleanup script
- [ ] Verify no terminated agents remain
- [ ] Check orphaned references
- [ ] Review unassigned issues
- [ ] Plan issue reassignment
- [ ] Document results in cleanup report
- [ ] Archive backup

---

## Related Documentation

- **Schema Reference**: `docs-paperclip/schema/FOREIGN_KEY_CONSTRAINTS.md`
- **Company Table**: `docs-paperclip/schema/details/tables/companies.md`
- **Agent Table**: `docs-paperclip/schema/details/agents.md`
- **Adding Companies**: `docs-paperclip/procedures/adding-companies-and-agents.md`

---

## Revision History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.1 | 2026-04-15 | Added agent_skill_assignments as critical FK dependency; Added Supabase client deletion example | Database Admin |
| 1.0 | 2026-04-12 | Initial version based on successful cleanup operations | Database Admin |

---

**For Questions or Issues**: Contact Paperclip Platform Operations Team
