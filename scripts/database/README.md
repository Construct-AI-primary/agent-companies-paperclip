# Database Scripts

This directory contains scripts for direct database operations, migrations, and data population.

## Files

### `populate_agents_supabase.sql`

SQL script for populating companies and agents directly into the Supabase/PostgreSQL database.

**Usage:**
```sql
-- In Supabase SQL Editor or psql
\i scripts/database/populate_agents_supabase.sql
```

**Features:**
- Creates DomainForge AI and InfraForge AI companies
- Inserts 9 agents (7 for DomainForge, 2 for InfraForge)
- Handles conflicts with `ON CONFLICT` clauses for safe re-running
- Includes verification queries

**What it creates:**
- **DomainForge AI** (DOM prefix):
  - Orion (CEO) - Chief Domain Orchestrator
  - Civil (Engineer) - Civil Engineering Specialist
  - Strategos (General) - Strategic Planning Director
  - Council (General) - Governance & Standards Director
  - Structural (Engineer) - Structural Engineering Specialist
  - Geotechnical (Engineer) - Geotechnical Engineering Specialist
  - Transportation (Engineer) - Transportation Engineering Specialist

- **InfraForge AI** (INF prefix):
  - Orchestrator (CEO) - Infrastructure Orchestration Specialist
  - Database (Engineer) - Database Infrastructure Specialist

**Prerequisites:**
- Access to Supabase SQL Editor or PostgreSQL connection
- Companies table exists
- Agents table exists

### `populate_supabase_agents.js`

Node.js script for populating agents using the Supabase JavaScript client.

**Usage:**
```bash
# Set environment variables
export SUPABASE_URL="your-supabase-url"
export SUPABASE_KEY="your-supabase-key"

# Run the script
node scripts/database/populate_supabase_agents.js
```

**Features:**
- Uses Supabase JavaScript client
- Populates agents with proper error handling
- Supports environment variable configuration

**Prerequisites:**
- `@supabase/supabase-js` package installed
- `dotenv` package installed
- `.env` file with Supabase credentials

### `migrate-to-supabase.sh`

Shell script for migrating data to Supabase (placeholder).

**Usage:**
```bash
./scripts/database/migrate-to-supabase.sh
```

## Common Tasks

### Populate Database with Companies and Agents

**Option 1: Using SQL (Recommended)**
```bash
# Copy the SQL file content and paste into Supabase SQL Editor
# Or use psql:
psql $DATABASE_URL -f scripts/database/populate_agents_supabase.sql
```

**Option 2: Using JavaScript Client**
```bash
# Configure environment
cp .env.example .env
# Edit .env with your Supabase credentials

# Run the script
node scripts/database/populate_supabase_agents.js
```

### Verify Data

```sql
-- Count agents by company
SELECT 
  c.name AS company_name,
  COUNT(a.id) AS agent_count
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
WHERE c.issue_prefix IN ('DOM', 'INF')
GROUP BY c.name;

-- View agent hierarchy
SELECT 
  a.name,
  a.role,
  a.title,
  boss.name AS reports_to
FROM agents a
LEFT JOIN agents boss ON a.reports_to = boss.id
WHERE a.company_id IN (
  SELECT id FROM companies WHERE issue_prefix IN ('DOM', 'INF')
)
ORDER BY a.company_id, a.created_at;
```

## Best Practices

1. **Always check for conflicts** - Review existing `issue_prefix` values before running scripts
2. **Use transactions** - Wrap operations in `BEGIN`/`COMMIT` blocks
3. **Test in development first** - Verify scripts work before running in production
4. **Keep backups** - Backup database before running migration scripts
5. **Document changes** - Update this README when adding new scripts

## Troubleshooting

### "duplicate key value violates unique constraint"

Check for existing companies with the same `issue_prefix`:
```sql
SELECT id, name, issue_prefix FROM companies;
```

### "insert or update violates foreign key constraint"

Ensure companies exist before inserting agents:
```sql
SELECT id, name FROM companies WHERE issue_prefix IN ('DOM', 'INF');
```

### "relation does not exist"

Verify the database schema is up to date:
```bash
pnpm db:migrate
```

## Related Documentation

- [Adding Companies and Agents Procedure](../../docs-paperclip/procedures/adding-companies-and-agents.md)
- [Database Documentation](../../doc/DATABASE.md)
- [Setup Scripts](../setup/README.md)
