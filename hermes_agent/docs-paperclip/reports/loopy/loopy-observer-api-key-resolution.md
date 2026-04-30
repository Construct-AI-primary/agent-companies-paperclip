# Loopy AI Observer Agent - Missing API Key Resolution

**Date:** 2026-04-12  
**Status:** Solution Prepared - Requires Supabase Execution  
**Issue:** Observer agent in Loopy AI company missing API key

## Problem Summary

The Observer agent in Loopy AI was identified as missing an API key, preventing it from authenticating with the Paperclip API.

**Status Report:**
```json
[
  {
    "company": "Loopy AI",
    "agent_name": "Observer",
    "status": "✗ Missing API Key"
  }
]
```

## Root Cause

The Observer agent was created in the database but no corresponding entry was made in the `agent_api_keys` table.

## Solution Prepared

### Files Created

1. **SQL Script:** `scripts/database/insert_loopy_observer_api_key.sql`
   - Comprehensive SQL script with verification steps
   - Safe to run multiple times (uses `ON CONFLICT DO NOTHING`)
   - Includes before/after status checks

2. **Shell Script:** `scripts/database/insert_loopy_observer_api_key.sh`
   - Automated execution script for local PostgreSQL
   - Not applicable for Supabase deployment

## Execution Instructions

### For Supabase Deployment (Recommended)

Since this system uses Supabase as the database backend, follow these steps:

#### Step 1: Access Supabase SQL Editor

1. Log in to Supabase Console: https://gmorarhibiptvcrnvrpi.supabase.co
2. Navigate to **SQL Editor** in the left sidebar
3. Create a new query

#### Step 2: Execute the SQL Script

Copy and paste the following SQL into the Supabase SQL Editor:

```sql
-- ============================================================================
-- INSERT API KEY FOR LOOPY AI OBSERVER AGENT
-- ============================================================================

-- Step 1: Verify the agent exists
SELECT 
    a.id as agent_id,
    a.name as agent_name,
    c.id as company_id,
    c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.name = 'Observer' 
  AND c.name = 'Loopy AI'
  AND a.is_active = true;

-- Step 2: Check if API key already exists (should return empty if missing)
SELECT 
    aak.id,
    aak.name,
    aak.created_at,
    a.name as agent_name,
    c.name as company_name
FROM agent_api_keys aak
JOIN agents a ON aak.agent_id = a.id
JOIN companies c ON aak.company_id = c.id
WHERE a.name = 'Observer' 
  AND c.name = 'Loopy AI';

-- Step 3: Insert API key for Observer agent
INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash, created_at) VALUES (
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = 'Observer' AND company_id = (SELECT id FROM companies WHERE name = 'Loopy AI') LIMIT 1),
    (SELECT id FROM companies WHERE name = 'Loopy AI' LIMIT 1),
    'Primary Key',
    encode(sha256(random()::text::bytea), 'hex'),
    NOW()
)
ON CONFLICT DO NOTHING
RETURNING id, name, created_at;

-- Step 4: Verify success - Show all Loopy AI agents and their API key status
SELECT 
    c.name as company,
    a.name as agent_name,
    a.is_active,
    CASE WHEN aak.id IS NULL THEN '✗ Missing API Key' ELSE '✓ Has API Key' END as status,
    aak.created_at as api_key_created
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.name = 'Loopy AI'
  AND a.is_active = true
ORDER BY a.name;
```

#### Step 3: Verify Results

After execution, the final query should show:

```
company   | agent_name | is_active | status           | api_key_created
----------|------------|-----------|------------------|------------------
Loopy AI  | Maya       | true      | ✓ Has API Key    | [timestamp]
Loopy AI  | Observer   | true      | ✓ Has API Key    | [timestamp]
```

### Alternative: Use Existing Mass Insert Script

Alternatively, you can use the comprehensive script that includes all missing API keys:

```bash
# This script includes the Observer agent along with other missing keys
# Located at: scripts/database/insert_missing_api_keys.sql
# Lines 663-669 contain the Observer agent API key insertion
```

## Technical Details

### API Key Schema

```sql
CREATE TABLE "agent_api_keys" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "agent_id" uuid NOT NULL REFERENCES "agents"("id"),
  "company_id" uuid NOT NULL REFERENCES "companies"("id"),
  "name" text NOT NULL,
  "key_hash" text NOT NULL,
  "last_used_at" timestamptz,
  "revoked_at" timestamptz,
  "created_at" timestamptz NOT NULL DEFAULT NOW()
);
```

### Security Notes

- API keys are hashed using SHA-256 before storage
- The `key_hash` is generated randomly using `encode(sha256(random()::text::bytea), 'hex')`
- Keys are never stored in plaintext
- The `revoked_at` field is NULL for active keys

## Expected Outcome

After successful execution:

1. ✅ Observer agent will have an active API key
2. ✅ Agent can authenticate with Paperclip API
3. ✅ Status will change from "✗ Missing API Key" to "✓ Has API Key"

## Verification Query

Run this query anytime to check API key status across all companies:

```sql
SELECT 
    c.name as company,
    a.name as agent_name,
    CASE WHEN aak.id IS NULL THEN '✗ Missing' ELSE '✓ Present' END as api_key_status
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE a.is_active = true
  AND c.name = 'Loopy AI'
ORDER BY c.name, a.name;
```

## Related Documentation

- [Agent API Keys Schema](../schema/details/agent_api_keys.md)
- [Adding Companies and Agents Procedure](../procedures/adding-companies-and-agents.md)
- [Complete Missing API Keys Report](./2026-04-12-complete-agent-api-keys-all-companies.md)

## Troubleshooting

### Issue: Agent Not Found

**Symptom:** Step 1 verification query returns no rows

**Solution:** 
1. Verify the agent exists: `SELECT * FROM agents WHERE name = 'Observer'`
2. Check company exists: `SELECT * FROM companies WHERE name = 'Loopy AI'`
3. Confirm agent is active: `SELECT * FROM agents WHERE name = 'Observer' AND is_active = true`

### Issue: API Key Already Exists

**Symptom:** Step 3 insert returns no rows (ON CONFLICT triggered)

**Solution:** This is normal behavior. The script is idempotent and safe to run multiple times. The key was already created in a previous run.

### Issue: Foreign Key Constraint Violation

**Symptom:** Error about foreign key constraint on agent_id or company_id

**Solution:** Ensure the agent and company exist in the database before running the insert. Run verification queries from Steps 1 and 2.

## Status Timeline

- **2026-04-12 10:47:50**: Issue identified via status check
- **2026-04-12 10:48:38**: SQL script created
- **2026-04-12 10:49:24**: Shell script created for local PostgreSQL
- **2026-04-12 10:49:39**: Local PostgreSQL connection failed (expected - using Supabase)
- **2026-04-12 10:50:00**: Solution documented for Supabase execution

## Next Steps

1. ✅ SQL script prepared and ready
2. ⏳ Execute SQL in Supabase SQL Editor
3. ⏳ Verify Observer agent has API key
4. ⏳ Test agent authentication with Paperclip API

---

**Resolution Status:** Awaiting Supabase Execution  
**Prepared By:** Paperclip AI Assistant  
**Documentation Version:** 1.0
