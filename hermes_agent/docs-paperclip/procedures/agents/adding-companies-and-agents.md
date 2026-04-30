# Adding Companies and Agents to Paperclip

This procedure documents the process for adding new companies and agents to a Paperclip instance using SQL scripts for direct database population.

## Overview

When you need to populate a Paperclip database with companies and agents, you can use SQL scripts to directly insert data into the `companies` and `agents` tables. This approach is useful for:

- Initial database seeding
- Bulk data migration
- Development and testing environments
- Supabase deployments where direct SQL access is available

## Prerequisites

- Access to the Paperclip database (Supabase SQL Editor or direct PostgreSQL connection)
- Understanding of the Paperclip database schema
- Company and agent data prepared
- **CRITICAL**: Review `unique-constraints.md` - agents table has NO unique constraint on `name` column
- **CRITICAL**: Check for schema drift - `agent_skill_assignments` table may exist in production but not in schema

## Database Schema

### Companies Table

The `companies` table has the following key fields:

```sql
CREATE TABLE companies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT,
  status TEXT NOT NULL DEFAULT 'active',
  issue_prefix TEXT NOT NULL UNIQUE,
  issue_counter INTEGER NOT NULL DEFAULT 0,
  budget_monthly_cents INTEGER NOT NULL DEFAULT 0,
  spent_monthly_cents INTEGER NOT NULL DEFAULT 0,
  require_board_approval_for_new_agents BOOLEAN NOT NULL DEFAULT true,
  brand_color TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);
```

**Important Notes:**
- `issue_prefix` must be unique across all companies
- Check existing companies to avoid prefix conflicts
- Use 3-4 character prefixes (e.g., DOM, INF, PFA)

### Agents Table

The `agents` table has the following complete schema (based on `populate_agents_supabase.sql`):

```sql
CREATE TABLE agents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID NOT NULL REFERENCES companies(id),
  name TEXT NOT NULL,
  role TEXT NOT NULL DEFAULT 'general',
  title TEXT,
  capabilities TEXT,
  status TEXT NOT NULL DEFAULT 'idle',
  reports_to UUID REFERENCES agents(id),
  adapter_type TEXT,  -- 'http', 'claude', 'openai', etc.
  adapter_config JSONB,  -- Webhook URLs, API keys, model configs
  budget_monthly_cents INTEGER NOT NULL DEFAULT 0,
  spent_monthly_cents INTEGER NOT NULL DEFAULT 0,
  last_heartbeat_at TIMESTAMP WITH TIME ZONE,
  metadata JSONB,  -- team, specialization, skills, reports_to_details
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  runtime_config JSONB,  -- persistSession, etc.
  permissions JSONB NOT NULL DEFAULT '{}',
  icon TEXT,
  pause_reason TEXT,
  paused_at TIMESTAMP WITH TIME ZONE,
  model_config JSONB,  -- Primary model, fallbacks, temperature
  device_config JSONB,  -- Device priority, device_id
  deleted_at TIMESTAMP WITH TIME ZONE,
  is_active BOOLEAN NOT NULL DEFAULT true
);
```

**Critical Fields for New Agents:**
- **`adapter_type`**: Communication protocol ('http' for webhooks, 'claude' for Anthropic, etc.)
- **`adapter_config`**: JSON with webhook URLs, API keys, model settings, provider configs
- **`metadata`**: Include `reports_to_details` with manager name, title, and company
- **`model_config`**: Primary model configuration with fallback models
- **`device_config`**: Device priority and assignment settings
- **`is_active`**: Must be `true` for active agents

**Important Notes:**
- `company_id` must reference an existing company
- `reports_to` creates hierarchical relationships between agents
- `permissions` is a JSONB column (no separate permissions table)
- Common roles: `ceo`, `engineer`, `general`, `pm`, `devops`, `specialist`
- Always include `ON CONFLICT (id) DO UPDATE SET` for safe re-execution

## Procedure Steps

### Step 1: Check Existing Companies

Before creating new companies, check for existing `issue_prefix` values to avoid conflicts:

```sql
SELECT id, name, issue_prefix, status 
FROM companies 
WHERE status = 'active'
ORDER BY name;
```

### Step 2: Prepare Company Data

Create INSERT statements for your companies with unique prefixes:

```sql
INSERT INTO companies (
  id,
  name,
  description,
  status,
  issue_prefix,
  issue_counter,
  budget_monthly_cents,
  spent_monthly_cents,
  require_board_approval_for_new_agents,
  brand_color,
  created_at,
  updated_at
) VALUES
(
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'DomainForge AI',
  'Multi-discipline autonomous AI company specializing in comprehensive engineering expertise',
  'active',
  'DOM',  -- Ensure this is unique!
  0,
  0,
  0,
  true,
  '#2563eb',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  status = EXCLUDED.status,
  brand_color = EXCLUDED.brand_color,
  updated_at = EXCLUDED.updated_at;
```

**Key Considerations:**
- Use `ON CONFLICT (id)` to allow safe re-running of scripts
- Generate UUIDs in advance or use `gen_random_uuid()`
- Choose descriptive, unique `issue_prefix` values
- Set appropriate `brand_color` in hex format

### Step 3: Prepare Agent Data

Create INSERT statements for agents, ensuring proper company references:

```sql
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  capabilities,
  status,
  reports_to,
  created_at,
  updated_at,
  metadata
) VALUES
(
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',  -- Must match company ID
  'Orion',
  'ceo',
  'Chief Domain Orchestrator',
  'Central nervous system for domain engineering orchestration and coordination.',
  'active',
  NULL,  -- CEO reports to no one
  NOW(),
  NOW(),
  '{"team": "DomainForge AI", "specialization": "Domain Orchestration"}'::jsonb
),
(
  'a1b2c3d4-e5f6-4789-a0b1-c2d3e4f5a6b7',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Civil',
  'engineer',
  'Civil Engineering Specialist',
  'Comprehensive civil engineering expertise across all disciplines.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',  -- Reports to Orion
  NOW(),
  NOW(),
  '{"team": "DomainForge AI", "discipline": "Civil Engineering"}'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata;
```

**Key Considerations:**
- `company_id` must reference an existing company
- `reports_to` creates org chart hierarchy (NULL for top-level)
- Use `metadata` JSONB for additional structured data
- `permissions` column stores agent permissions (not a separate table)
- Use `ON CONFLICT (id)` for idempotent scripts

### Step 4: Execute SQL Script

Execute the complete SQL script in order:

1. **Companies first** (to satisfy foreign key constraints)
2. **Agents second** (referencing the created companies)

```sql
-- Complete script structure
BEGIN;

-- Insert companies
INSERT INTO companies (...) VALUES (...);

-- Insert agents
INSERT INTO agents (...) VALUES (...);

COMMIT;
```

### Step 5: Verify Data

Run verification queries to confirm successful insertion:

```sql
-- Count agents by company
SELECT 
  c.name AS company_name,
  COUNT(a.id) AS agent_count
FROM companies c
LEFT JOIN agents a ON c.id = a.company_id
WHERE c.id IN ('2d7d9c60-c02f-42a7-8f6a-7db86ecc879d', '09f438a3-4041-46f2-b3cc-96fc9446e666')
GROUP BY c.name;

-- View agent hierarchy
SELECT 
  a.name,
  a.role,
  a.title,
  boss.name AS reports_to
FROM agents a
LEFT JOIN agents boss ON a.reports_to = boss.id
WHERE a.company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
ORDER BY a.created_at;

-- Check permissions
SELECT name, role, title, permissions 
FROM agents 
WHERE company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
ORDER BY name;
```

## Common Patterns

### CEO Agent Pattern

Every company should have at least one CEO agent:

```sql
(
  '<uuid>',
  '<company_id>',
  'Orion',
  'ceo',
  'Chief Domain Orchestrator',
  'Central orchestration and coordination...',
  'active',
  NULL,  -- CEOs don't report to anyone
  NOW(),
  NOW(),
  '{"permissions": ["can_create_agents", "can_assign_tasks"]}'::jsonb
)
```

### Specialist Agent Pattern

Specialist agents report to the CEO or department heads:

```sql
(
  '<uuid>',
  '<company_id>',
  'Civil',
  'engineer',
  'Civil Engineering Specialist',
  'Comprehensive civil engineering expertise...',
  'active',
  '<ceo_agent_id>',  -- Reports to CEO
  NOW(),
  NOW(),
  '{"discipline": "Civil Engineering"}'::jsonb
)
```

### Hierarchical Reporting Pattern

Create multi-level hierarchies:

```sql
-- Level 1: CEO
INSERT INTO agents (...) VALUES ('<ceo_id>', ..., NULL);

-- Level 2: Directors
INSERT INTO agents (...) VALUES ('<director_id>', ..., '<ceo_id>');

-- Level 3: Specialists
INSERT INTO agents (...) VALUES ('<specialist_id>', ..., '<director_id>');
```

## Best Practices

### 1. Use Transactions

Wrap all operations in a transaction for atomicity:

```sql
BEGIN;
-- All INSERT statements
COMMIT;
```

### 2. Generate UUIDs Consistently

Use a consistent method for UUID generation:

```sql
-- Option 1: Pre-generate UUIDs
'2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'

-- Option 2: Use database function
gen_random_uuid()
```

### 3. Handle Conflicts Gracefully

Use `ON CONFLICT` clauses to make scripts idempotent:

```sql
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  updated_at = EXCLUDED.updated_at;
```

### 4. Validate Before Execution

- Check for `issue_prefix` conflicts
- Verify all `company_id` references exist
- Ensure `reports_to` references are valid
- Confirm UUID uniqueness

### 5. Document Your Data

Include comments in SQL scripts:

```sql
-- DomainForge AI Company
-- Specializes in civil engineering and infrastructure
INSERT INTO companies (...) VALUES (...);

-- DomainForge AI Agents
-- CEO: Orion - Chief Domain Orchestrator
INSERT INTO agents (...) VALUES (...);
```

### 6. Verify Agent Reporting Structure

**Important**: Always ensure proper organizational hierarchy when adding agents:

- **CEO agents** should have `reports_to = NULL` (they report to no one)
- **All other agents** should report to their appropriate CEO or manager
- **Verify reporting chain** exists before adding agents
- **Update AGENTS.md files** with correct `reportsTo` field matching the database

**Example Reporting Structure:**
```sql
-- CEO (reports to no one)
INSERT INTO agents (..., reports_to) VALUES (..., NULL);

-- Specialist agents (report to CEO)
INSERT INTO agents (..., reports_to) VALUES (..., '<ceo_agent_id>');
```

**Validation Query:**
```sql
-- Check for orphaned agents (agents with invalid reports_to references)
SELECT a.name, a.role, a.reports_to
FROM agents a
LEFT JOIN agents boss ON a.reports_to = boss.id
WHERE a.reports_to IS NOT NULL
  AND boss.id IS NULL;
```

### 7. Assign Agent Models

**Important**: Every agent must have model assignments for proper AI model routing and performance tracking.

**See**: [Agent Model Assignment Procedure](agent-model-assignment-procedure.md) for complete model selection guidelines, assignment SQL, and validation queries.

### 8. Agent Name Registry

**Important**: All agent names must be globally unique across ALL companies. Before assigning a new agent name:

1. **Check the name registry**: See [Agent Name Registry](../schema/agent-name-registry.md)
2. **Follow the naming pattern**: `{human-name}-{company-slug}` (e.g., `maya-paperclipforge`, `reggie-measureforge`)
3. **Verify uniqueness**: No two agents across any company can share the same name
4. **Register the name**: Add the new name to the registry upon registration

**Naming Convention Examples:**
- ✅ `maya-paperclipforge` (COO, PaperclipForge AI)
- ✅ `reggie-measureforge` (Standards Director, MeasureForge AI)
- ❌ `operations-director` (not human-readable)
- ❌ `paperclipforge-ai-operations-director` (not human-readable)

**Duplicate Prevention:**
All registration scripts MUST use `WHERE NOT EXISTS` pattern to prevent duplicate registrations:

```sql
INSERT INTO agents (id, company_id, name, ...)
SELECT gen_random_uuid(), (SELECT id FROM companies WHERE name = 'Company Name'), 'agent-name', ...
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'agent-name');
```

## Troubleshooting

### Error: "relation 'agent_permissions' does not exist"

**Cause**: Attempting to insert into a non-existent `agent_permissions` table.

**Solution**: Use the `permissions` JSONB column in the `agents` table instead:

```sql
-- ❌ Wrong: No separate permissions table
INSERT INTO agent_permissions (...) VALUES (...);

-- ✅ Correct: Use permissions column
INSERT INTO agents (
  ...,
  permissions
) VALUES (
  ...,
  '{"can_create_agents": true}'::jsonb
);
```

### Error: "duplicate key value violates unique constraint 'companies_issue_prefix_idx'"

**Cause**: The `issue_prefix` already exists in the database.

**Solution**: Choose a different unique prefix:

```sql
-- Check existing prefixes
SELECT issue_prefix FROM companies;

-- Use a unique prefix
INSERT INTO companies (..., issue_prefix, ...) 
VALUES (..., 'DOM', ...);  -- Instead of 'DFA' if it exists
```

### Error: "insert or update on table 'agents' violates foreign key constraint"

**Cause**: The `company_id` doesn't exist in the `companies` table.

**Solution**: Ensure companies are created before agents:

```sql
-- 1. Create companies first
INSERT INTO companies (...) VALUES (...);

-- 2. Then create agents
INSERT INTO agents (..., company_id, ...) 
VALUES (..., '<existing_company_id>', ...);
```

### Error: "invalid input syntax for type json"

**Cause**: Malformed JSON in `metadata` or `permissions` columns.

**Solution**: Use proper JSON syntax and cast to `jsonb`:

```sql
-- ❌ Wrong
metadata = '{"key": value}'

-- ✅ Correct
metadata = '{"key": "value"}'::jsonb
```

## Example: Complete Script

See `scripts/database/populate_agents_supabase.sql` for a complete working example that creates:

- 2 companies (DomainForge AI, InfraForge AI)
- 9 agents (7 for DomainForge, 2 for InfraForge)
- Proper hierarchical relationships
- Conflict handling for safe re-execution

## Related Documentation

- [Database Schema](../DATABASE.md) - Complete database schema documentation
- [Paperclip API](../api/) - API endpoints for company and agent management
- [Agent Companies Spec](../../doc/AGENTCOMPANIES_SPEC_INVENTORY.md) - Agent company specifications
- [Agent Name Registry](../schema/agent-name-registry.md) - Global agent name registry

## Maintenance

- **Review Frequency**: Update when schema changes occur
- **Version**: 1.1
- **Last Updated**: 2026-04-22
- **Author**: Paperclip Team