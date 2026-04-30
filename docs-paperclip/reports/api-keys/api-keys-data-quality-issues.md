# API Keys Data Quality Issues

**Date:** 2026-04-12  
**Status:** 🔴 Data Quality Issues Detected  
**Priority:** High

## Executive Summary

While fixing the API keys insertion script to match the actual database schema, we discovered significant data quality issues in the `agent_api_keys` table. Some companies have **more active API keys than active agents**, indicating data inconsistencies.

## Problem Overview

### Companies with Excess API Keys

| Company | Active Agents | Active Keys | Excess Keys |
|---------|--------------|-------------|-------------|
| **PaperclipForge AI** | 64 | 107 | **-43** |
| **PromptForge AI** | 29 | 55 | **-26** |
| **DevForge AI** | 52 | 54 | **-2** |

### Healthy Companies (0 excess keys)

✅ ContentForge AI: 31 agents / 31 keys  
✅ DomainForge AI: 63 agents / 63 keys  
✅ ExecForge AI: 18 agents / 18 keys  
✅ InfraForge AI: 7 agents / 7 keys  
✅ KnowledgeForge AI: 64 agents / 64 keys  
✅ Loopy AI: 6 agents / 6 keys  
✅ MobileForge AI: 10 agents / 10 keys  
✅ QualityForge AI: 36 agents / 36 keys  
✅ SaaSForge AI: 12 agents / 12 keys  
✅ VoiceForge AI: 12 agents / 12 keys  

## Possible Root Causes

### 1. Multiple API Keys Per Agent
Some agents may have been assigned multiple API keys (intentionally or by mistake).

**Expected:** 1 active API key per active agent  
**Actual:** Some agents have 2+ active keys

### 2. API Keys for Inactive Agents
Agents that were deactivated may still have active (non-revoked) API keys.

**Expected:** API keys should be revoked when agents are deactivated  
**Actual:** Keys remain active after agent deactivation

### 3. Orphaned API Keys
API keys exist in the database with `agent_id` references that don't match any existing agent.

**Expected:** All API keys reference valid agents  
**Actual:** Some keys may reference deleted or non-existent agents

### 4. Historical Data Migration Issues
Previous data migrations or imports may have created duplicate or invalid keys.

## Investigation Tools

### Diagnostic Script

**File:** `scripts/database/diagnose_api_key_issues.sql`

This comprehensive diagnostic script will identify:
- Companies with excess API keys
- Agents with multiple active API keys
- API keys assigned to inactive agents
- Orphaned API keys (no matching agent)
- Detailed statistics by company

**How to Run:**
1. Open Supabase SQL Editor
2. Copy contents of `scripts/database/diagnose_api_key_issues.sql`
3. Execute the script
4. Review all 5 diagnostic sections

## Recommended Actions

### Immediate Actions (Data Investigation)

1. **Run Diagnostic Script** - Execute `diagnose_api_key_issues.sql` to understand the full scope
2. **Document Findings** - Create detailed report of diagnostic results
3. **Identify Root Cause** - Determine why excess keys exist

### Short-term Actions (Data Cleanup)

Based on diagnostic findings, create targeted cleanup scripts to:

1. **Revoke Duplicate Keys** - Keep only the oldest API key per agent, revoke others
2. **Revoke Keys for Inactive Agents** - Mark all keys as revoked when agent is inactive
3. **Delete Orphaned Keys** - Remove keys that reference non-existent agents

### Long-term Actions (Prevention)

1. **Add Database Constraints**
   - Consider unique constraint on `(agent_id, revoked_at IS NULL)` if only 1 active key per agent is desired
   - Add foreign key constraint with CASCADE for agent deletions

2. **Add Application Logic**
   - Auto-revoke API keys when agents are deactivated
   - Prevent creation of multiple active keys per agent (unless intentional)

3. **Add Monitoring**
   - Regular audits for data quality
   - Alerts when key counts exceed agent counts

## Impact Assessment

### Severity: High
- **Security:** Multiple active keys per agent increases attack surface
- **Data Integrity:** Inconsistent state between agents and keys
- **Operational:** Unclear which key is "primary" for agents with multiple keys

### Affected Companies
- PaperclipForge AI: 43 excess keys (67% excess)
- PromptForge AI: 26 excess keys (90% excess)
- DevForge AI: 2 excess keys (4% excess)

### Unaffected Companies
10 companies maintain perfect 1:1 active agent to active key ratio ✅

## Next Steps

1. ✅ Created diagnostic script: `scripts/database/diagnose_api_key_issues.sql`
2. ⏳ **USER ACTION REQUIRED:** Run diagnostic script in Supabase SQL Editor
3. ⏳ Analyze diagnostic results to identify specific problem records
4. ⏳ Create targeted cleanup scripts based on findings
5. ⏳ Execute cleanup after approval
6. ⏳ Implement preventive measures

## Files

- **Diagnostic Script:** `scripts/database/diagnose_api_key_issues.sql`
- **Original Fix:** `scripts/database/insert_all_missing_api_keys.sql`
- **This Report:** `docs-paperclip/reports/2026-04-12-api-keys-data-quality-issues.md`

## Notes

This issue was discovered while fixing the original API keys insertion script to match the actual database schema. The schema fix is complete and correct - this is a separate data quality issue that requires investigation and cleanup.

---

**Report Generated:** 2026-04-12  
**Generated By:** Cline AI Assistant  
**Status:** Investigation Phase - Awaiting Diagnostic Results
