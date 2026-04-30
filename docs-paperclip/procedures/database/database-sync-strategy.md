# Database Synchronization Strategy

## The Problem

Paperclip can use multiple database configurations, leading to confusion:
- **Local PGlite** (embedded) - for quick development
- **Local PostgreSQL** - for full-featured development
- **Supabase** (remote) - for production/staging

This creates chaos when data exists in one database but not another.

## The Solution: Single Source of Truth

### Recommended Setup

**Use ONE primary database for your environment:**

#### Option 1: Development with Supabase (RECOMMENDED)
Best for teams and production-like development.

**Configuration:**
```bash
# .env
DATABASE_URL=postgresql://postgres.[project-ref]:[password]@aws-0-[region].pooler.supabase.com:6543/postgres
SUPABASE_URL=https://gmorarhibiptvcrnvrpi.supabase.co
SUPABASE_SERVICE_ROLE_KEY=your_service_key
```

**Pros:**
- ✅ Same database for local development and production
- ✅ Team can share data
- ✅ Built-in backups and monitoring
- ✅ No sync issues

**Cons:**
- ❌ Requires internet connection
- ❌ Slower than local database

#### Option 2: Local Development Only
Best for offline work and fast iteration.

**Configuration:**
```bash
# .env
# Leave DATABASE_URL unset - Paperclip will use embedded PGlite
# OR
DATABASE_URL=postgres://paperclip:paperclip@localhost:5432/paperclip
```

**Pros:**
- ✅ Works offline
- ✅ Very fast
- ✅ Full control

**Cons:**
- ❌ Data not shared with team
- ❌ Must manually sync to production

## Database Sync Scripts

### 1. Dump from Supabase to Local

```bash
#!/bin/bash
# scripts/database/sync_from_supabase.sh

# Get connection details from Supabase Dashboard > Project Settings > Database
SUPABASE_HOST="aws-0-us-east-1.pooler.supabase.com"
SUPABASE_DB="postgres"
SUPABASE_USER="postgres.[project-ref]"
SUPABASE_PASS="your_password"

# Dump Supabase data
PGPASSWORD=$SUPABASE_PASS pg_dump \
  -h $SUPABASE_HOST \
  -U $SUPABASE_USER \
  -d $SUPABASE_DB \
  --data-only \
  --no-owner \
  --no-privileges \
  -f supabase_dump.sql

# Restore to local
psql -U paperclip -d paperclip -f supabase_dump.sql

echo "✅ Supabase data synced to local database"
```

### 2. Push from Local to Supabase

```bash
#!/bin/bash
# scripts/database/sync_to_supabase.sh

# Dump local data
pg_dump -U paperclip -d paperclip --data-only --no-owner --no-privileges -f local_dump.sql

# Restore to Supabase (run in Supabase SQL Editor)
echo "⚠️  Upload local_dump.sql to Supabase SQL Editor and run"
echo "   Dashboard > SQL Editor > New Query > Paste file content"
```

### 3. Unified Insert Script

```javascript
// scripts/database/insert_company_unified.mjs
// Automatically inserts to BOTH local and Supabase

import { createClient } from '@supabase/supabase-js';

const TARGETS = {
  local: process.env.DATABASE_URL || null,
  supabase: {
    url: process.env.SUPABASE_URL,
    key: process.env.SUPABASE_SERVICE_ROLE_KEY
  }
};

async function insertCompany(companyData) {
  const results = {
    local: null,
    supabase: null
  };

  // Insert to Local (via Paperclip API)
  if (TARGETS.local || process.env.BOARD_TOKEN) {
    try {
      const response = await fetch('http://localhost:3100/api/companies', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${process.env.BOARD_TOKEN}`
        },
        body: JSON.stringify(companyData)
      });
      results.local = response.ok ? 'Success' : 'Failed';
    } catch (error) {
      results.local = `Error: ${error.message}`;
    }
  }

  // Insert to Supabase (direct)
  if (TARGETS.supabase.url && TARGETS.supabase.key) {
    try {
      const supabase = createClient(TARGETS.supabase.url, TARGETS.supabase.key);
      const { error } = await supabase.from('companies').insert(companyData);
      results.supabase = error ? `Error: ${error.message}` : 'Success';
    } catch (error) {
      results.supabase = `Error: ${error.message}`;
    }
  }

  return results;
}

// Usage
const newCompany = {
  name: 'Learning Forge AI',
  description: 'AI Learning & Knowledge Management',
  // ... other fields
};

const results = await insertCompany(newCompany);
console.log('Insertion Results:', results);
```

## Best Practices

### 1. Choose Your Primary Database

**Edit `.env` and commit to ONE approach:**

```bash
# OPTION A: Use Supabase for everything (RECOMMENDED)
DATABASE_URL=postgresql://postgres.[ref]:[pass]@aws-0-[region].pooler.supabase.com:6543/postgres
SUPABASE_URL=https://gmorarhibiptvcrnvrpi.supabase.co
SUPABASE_SERVICE_ROLE_KEY=your_key

# OPTION B: Use local database only
DATABASE_URL=postgres://paperclip:paperclip@localhost:5432/paperclip
# Leave SUPABASE_* commented out
```

### 2. Always Use Paperclip API for Data Changes

**✅ DO THIS:**
```bash
# Use API for inserts
BOARD_TOKEN=xxx node scripts/create_company_api.js
```

**❌ DON'T DO THIS:**
```bash
# Direct SQL creates sync issues
psql -d paperclip -c "INSERT INTO companies..."
```

### 3. Document Your Setup

Add to your project README:
```markdown
## Database Setup

This project uses: [Supabase | Local PostgreSQL | PGlite]

To sync data: `npm run db:sync`
```

### 4. Use Environment-Specific Configs

```bash
# .env.local - for local development
DATABASE_URL=postgres://paperclip:paperclip@localhost:5432/paperclip

# .env.production - for production (Render, etc.)
DATABASE_URL=$SUPABASE_DATABASE_URL
SUPABASE_URL=$SUPABASE_URL
SUPABASE_SERVICE_ROLE_KEY=$SUPABASE_SERVICE_KEY
```

## Migration Path: Current State → Clean State

### Current Situation
- Learning Forge AI company in LOCAL database (via API)
- Learning Forge AI company in SUPABASE (via SQL)  
- 46 agents in SUPABASE only

### Clean It Up

**Option 1: Make Supabase the Source of Truth**

1. **Configure Paperclip to use Supabase:**
   ```bash
   # .env
   DATABASE_URL=postgresql://postgres.gmor...@aws-0-us-east-1.pooler.supabase.com:6543/postgres
   ```

2. **Restart Paperclip:**
   ```bash
   pnpm dev
   ```

3. **Verify in UI:**
   - Open http://localhost:3100
   - Should see Learning Forge AI with 46 agents

**Option 2: Make Local the Source of Truth**

1. **Export from Supabase:**
   - Use Supabase Dashboard > SQL Editor
   - Run: `SELECT * FROM companies WHERE name = 'Learning Forge AI';`
   - Run: `SELECT * FROM agents WHERE company_id = '...';`
   - Save results

2. **Insert to Local via API:**
   ```bash
   BOARD_TOKEN=xxx node scripts/insert_agents_to_local.js
   ```

## Future: Prevent Chaos

### Rule 1: One Command for All Inserts
Create `scripts/database/insert_everywhere.sh`:
```bash
#!/bin/bash
# Always inserts to BOTH databases automatically
node scripts/insert_to_local_api.js && \
node scripts/insert_to_supabase.mjs
```

### Rule 2: Daily Sync Job
```bash
# Add to cron or GitHub Actions
0 2 * * * /path/to/scripts/sync_databases.sh
```

### Rule 3: Pre-commit Hook
```bash
# .git/hooks/pre-commit
#!/bin/bash
# Verify databases are in sync before committing
node scripts/verify_db_sync.js || exit 1
```

## Summary

**Immediate Action:**
1. Choose ONE primary database (recommend Supabase)
2. Update `.env` to use that database
3. Restart Paperclip server
4. Verify Learning Forge AI appears

**Long-term Solution:**
1. Always use Paperclip API for data operations
2. Use sync scripts when needed
3. Document which database is active in README

---

**Last Updated:** 2026-04-11
**Version:** 1.0
