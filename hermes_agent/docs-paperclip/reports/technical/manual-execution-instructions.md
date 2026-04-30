# Manual Execution Instructions for API Keys Scripts

**Date:** 2026-04-12  
**Status:** Ready for Manual Execution

## Overview

Due to Supabase RPC limitations and Hermes API key configuration issues, these scripts need to be executed manually through the Supabase SQL Editor.

## Scripts Ready for Execution

### 1. Diagnostic Script (Run First)
**File:** `scripts/database/diagnose_api_key_issues.sql`  
**Purpose:** Identify root causes of excess API keys

### 2. Insert Script (Run After Diagnosis)
**File:** `scripts/database/insert_all_missing_api_keys.sql`  
**Purpose:** Add API keys for agents missing them

---

## Step-by-Step Execution Guide

### Step 1: Open Supabase SQL Editor

1. Go to https://supabase.com/dashboard
2. Select your project: `gmorarhibiptvcrnvrpi`
3. Click on "SQL Editor" in the left sidebar
4. Click "New query" button

### Step 2: Run Diagnostic Script

**Copy and paste the entire contents of:**
```
scripts/database/diagnose_api_key_issues.sql
```

**Expected Output:**
The script will show 5 diagnostic sections:

1. **Companies with Excess API Keys**
   - Lists companies with more keys than active agents
   - Shows the number of excess keys

2. **Agents with Multiple API Keys**
   - Identifies specific agents with 2+ active keys
   - Shows which company they belong to

3. **API Keys for Inactive Agents**  
   - Lists keys assigned to deactivated agents
   - Should be revoked to maintain data quality

4. **Orphaned API Keys**
   - Keys with agent_id that doesn't reference any existing agent
   - Should be deleted

5. **Detailed Statistics by Company**
   - Complete breakdown of agents and keys per company
   - Shows active vs inactive counts

### Step 3: Analyze Results

Based on diagnostic output, determine:
- Are there multiple keys per agent? (keep oldest, revoke others)
- Are there keys for inactive agents? (revoke all)
- Are there orphaned keys? (delete them)

### Step 4: Run Insert Script (Optional)

**Only if there are agents missing API keys:**

Copy and paste the entire contents of:
```
scripts/database/insert_all_missing_api_keys.sql
```

**What it does:**
- Inserts API keys for all active agents without keys
- Shows verification results
- Displays breakdown by company

**Expected Result:**
- All active agents will have at least 1 API key
- Verification shows 0 agents missing keys

---

## What to Look For

### ✅ Healthy State
- 1 active API key per active agent
- 0 active keys for inactive agents
- 0 orphaned keys
- All companies show "missing_keys: 0"

### ⚠️ Data Quality Issues to Fix

**Multiple Keys Per Agent:**
- Keep the oldest API key (lowest created_at)
- Revoke all others by setting revoked_at = NOW()

**Keys for Inactive Agents:**
- Revoke all by setting revoked_at = NOW()

**Orphaned Keys:**
- Delete entirely (no matching agent exists)

---

## Cleanup Scripts (If Needed)

After running diagnostics, if issues are found, you may need cleanup scripts. Based on the diagnostic results, I can create targeted cleanup scripts for:

1. Revoking duplicate API keys
2. Revoking keys for inactive agents
3. Deleting orphaned keys

---

## Example Diagnostic Output

```sql
=== COMPANIES WITH EXCESS API KEYS ===
company             | active_agents | active_keys | excess_keys
--------------------|---------------|-------------|-------------
PaperclipForge AI   | 64            | 107         | -43
PromptForge AI      | 29            | 55          | -26
DevForge AI         | 52            | 54          | -2

=== AGENTS WITH MULTIPLE API KEYS ===
company             | agent_name           | is_active | active_key_count
--------------------|----------------------|-----------|------------------
PaperclipForge AI   | nexus-paperclipforge | true      | 3
PaperclipForge AI   | forge-paperclipforge | true      | 2
...
```

---

## Files Reference

- **Diagnostic Script:** `scripts/database/diagnose_api_key_issues.sql`
- **Insert Script:** `scripts/database/insert_all_missing_api_keys.sql`
- **Data Quality Report:** `docs-paperclip/reports/2026-04-12-api-keys-data-quality-issues.md`
- **This Guide:** `docs-paperclip/reports/2026-04-12-manual-execution-instructions.md`

---

## Support

Both scripts have been validated against the actual database schema:
- ✅ Uses correct column names from `docs-paperclip/schema/details/`
- ✅ No schema errors (`slug` → `name`, removed non-existent columns)
- ✅ Proper filtering for active/revoked keys

If you encounter any SQL errors, check that you copied the entire script contents.

---

**Last Updated:** 2026-04-12  
**Status:** Ready for Manual Execution via Supabase SQL Editor
