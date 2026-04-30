# Archived Companies Cleanup Report

**Date:** 2026-04-12  
**Operation:** Delete archived companies and all dependencies from Supabase  
**Status:** ✅ Successfully Completed

## Summary

Successfully deleted 10 archived companies and all their related records from the Supabase database, following proper foreign key dependency chain to avoid constraint violations.

## Archived Companies Deleted

1. **ConstructAI** (archived 2026-04-06)
2. **K** (archived 2026-03-24)
3. **KnowledgeForge AI** (archived duplicate, 2026-04-06)
4. **PromptForge AI** (archived duplicate, 2026-03-29)
5. **Quality Forge** (archived 2026-03-24)
6. **Test (Disabled)** (archived 2026-03-23)
7. **test-openclaw** (archived 2026-03-24)
8. **test2 (Disabled)** (archived 2026-03-24)
9. **test3 (Disabled)** (archived 2026-03-24)
10. **TESTER** (archived 2026-04-03)

## Records Deleted by Category

### Core Entities
- **Companies**: 10
- **Agents**: 21
- **Goals**: 31

### Heartbeat & Activity
- **Heartbeat Runs**: 569
- **Heartbeat Run Events**: 1,434
- **Activity Log**: 73
- **Cost Events**: 2
- **Finance Events**: 0

### Agent Configuration
- **Agent API Keys**: 78
- **Agent Config Revisions**: 536
- **Agent Runtime State**: 0
- **Agent Skill Assignments**: 657
- **Agent Task Sessions**: 7
- **Agent Wakeup Requests**: 0

### Issues & Work Products
- **Issues**: 1
- **Issue Work Products**: 0
- **Issue Comments**: 0
- **Issue Approvals**: 0
- **Issue Attachments**: 0
- **Issue Documents**: 0
- **Issue Inbox Archives**: 0
- **Issue Labels**: 0
- **Issue Read States**: 0

### Company Configuration
- **Company Skills**: 2
- **Company Secrets**: 0
- **Company Secret Versions**: 0
- **Company Logos**: 0
- **Budget Policies**: 0
- **Budget Incidents**: 0

### Other Resources
- **Projects**: 0
- **Project Goals**: 0
- **Project Workspaces**: 0
- **Routines**: 0
- **Routine Triggers**: 0
- **Routine Runs**: 6
- **Documents**: 3
- **Document Revisions**: 2
- **Assets**: 0
- **Approvals**: 0
- **Approval Comments**: 0
- **Invites**: 0
- **Join Requests**: 0
- **Labels**: 1
- **CLI Auth Challenges**: 0
- **Plugin Company Settings**: 0
- **Principal Permission Grants**: 0
- **Workspace Operations**: 0
- **Workspace Runtime Services**: 0
- **Execution Workspaces**: 0

## Remaining Active Companies (13)

1. ContentForge AI
2. DevForge AI
3. DomainForge AI
4. ExecForge AI
5. InfraForge AI
6. KnowledgeForge AI (active)
7. Learning Forge AI
8. Loopy AI
9. MobileForge AI
10. PromptForge AI (active)
11. QualityForge AI
12. SaaSForge AI
13. VoiceForge AI

## Final Database State

| Metric | Count |
|--------|-------|
| Companies | 13 |
| Active Agents | 391 |
| Active Goals | 41 |
| Heartbeat Runs | 199 |
| Issues | 171 |

## Technical Implementation

### Foreign Key Dependency Chain

The cleanup followed this deletion order to respect FK constraints:

1. **Level 1**: Records referencing `heartbeat_runs`
   - workspace_runtime_services
   - workspace_operations
   - issue_work_products
   - issues (checkout_run_id, execution_run_id)
   - finance_events
   - cost_events
   - activity_log
   - agent_task_sessions

2. **Level 2**: Heartbeat records
   - heartbeat_run_events
   - heartbeat_runs

3. **Level 3**: Company-scoped records
   - cost_events (company_id)
   - finance_events (company_id)
   - activity_log (company_id)
   - agent_task_sessions (company_id)

4. **Level 4**: Agent-related records
   - agent_wakeup_requests
   - agent_runtime_state
   - agent_config_revisions
   - agent_api_keys
   - agent_skill_assignments

5. **Level 5**: Issue-related records
   - issue_work_products
   - issue_read_states
   - issue_labels
   - issue_inbox_archives
   - issue_documents
   - issue_attachments
   - issue_approvals
   - issue_comments
   - issues

6. **Level 6**: Other resources
   - routines, projects, documents, assets, approvals, etc.

7. **Level 7**: Company configuration
   - company_secret_versions
   - company_secrets
   - company_skills
   - budget_policies, etc.

8. **Level 8**: Auth and invites
   - cli_auth_challenges
   - join_requests
   - invites
   - labels

9. **Level 9**: Goals
   - goals

10. **Level 10**: Agents
    - agents

11. **Level 11**: Companies
    - companies

### Script Location

`scripts/database/cleanup_archived_companies.sql`

### Execution Command

```bash
PGPASSWORD='***' psql -h db.gmorarhibiptvcrnvrpi.supabase.co -U postgres -d postgres \
  -f scripts/database/cleanup_archived_companies.sql
```

## Data Integrity Verification

✅ **All foreign key constraints respected**  
✅ **Transaction completed successfully (COMMIT)**  
✅ **No orphaned records**  
✅ **13 active companies remain with all dependencies intact**  

## Lessons Learned

1. **FK Dependency Mapping Critical**: The 92 FK relationships required careful ordering to avoid constraint violations
2. **Heartbeat_runs is deeply nested**: Referenced by 11 different tables, must be deleted after all dependents
3. **Company_secrets has cascade**: company_secret_versions must be deleted before company_secrets
4. **Test data accumulation**: 6 test companies were archived, highlighting the need for regular cleanup

## Recommendations

1. **Regular Cleanup Schedule**: Run archived company cleanup quarterly
2. **Prevent Test Accumulation**: Use a dedicated test environment or implement auto-cleanup for test companies
3. **Archive Process**: Consider implementing soft-delete cascade to automate dependency cleanup when companies are archived
4. **Monitoring**: Track archived company count and alert when threshold is exceeded

---

**Report Generated:** 2026-04-12  
**Executed By:** Database Administrator  
**Verified By:** Automated integrity checks
