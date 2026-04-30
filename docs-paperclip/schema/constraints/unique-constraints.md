# Unique Constraints Reference

**Critical for ON CONFLICT clauses!** Always check this before writing INSERT statements.

## Core Tables

### agents
- **Primary Key**: `id`
- **Unique Constraints**: NONE on `name` column
- **Important**: The `name` column is NOT NULL but has NO unique constraint
- **Idempotent Pattern**: Use `WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = '...')` for safe inserts

### companies
- **Primary Key**: `id`
- **Unique Constraints**:
  - `name` (company name must be unique)

### issues
- **Primary Key**: `id`
- **Unique Constraints**:
  - `(company_id, issue_number)` (issue numbers are sequential per company)

### projects
- **Primary Key**: `id`
- **Unique Constraints**:
  - `(company_id, name)` (project names unique within company)

### goals
- **Primary Key**: `id`
- **Unique Constraints**:
  - `(company_id, title)` (goal titles unique within company)

### agent_api_keys
- **Primary Key**: `id`
- **Unique Constraints**:
  - `(agent_id, name)` (key names unique per agent)

### agent_models ⚠️ DOES NOT EXIST
- **Important**: There is NO `agent_models` table in this schema
- Model configuration is stored in `adapter_config` JSONB field within the `agents` table
- Example: `adapter_config->>'model'` to query the model

## ON CONFLICT Patterns

### ✅ CORRECT - Using actual unique constraints

```sql
-- companies: unique on name
INSERT INTO companies (id, name, ...)
VALUES (...)
ON CONFLICT (name) DO NOTHING;

-- issues: unique on (company_id, issue_number)
INSERT INTO issues (company_id, issue_number, title, ...)
VALUES (...)
ON CONFLICT (company_id, issue_number) DO NOTHING;
```

### ✅ CORRECT - Idempotent pattern for agents (no unique constraint on name)

```sql
-- agents: NO unique constraint on name - use NOT EXISTS pattern
INSERT INTO agents (id, company_id, name, role, status, ...)
SELECT gen_random_uuid(), $company_id, 'agent-name', 'specialist', 'idle', ...
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'agent-name');
```

### ❌ WRONG - Using non-existent constraints

```sql
-- This will FAIL with ERROR: 42P10
INSERT INTO agents (id, name, role, ...)
VALUES (...)
ON CONFLICT (name) DO NOTHING;
-- ❌ No unique constraint on name in agents table!

-- This will FAIL
INSERT INTO agent_models (agent_id, model_id, ...)
VALUES (...)
ON CONFLICT (agent_id, model_id) DO NOTHING;
-- ❌ agent_models table does not exist!
```

## Finding Constraints in Database

```sql
-- List all unique constraints
SELECT conname, conrelid::regclass AS table_name, conkey
FROM pg_constraint
WHERE contype = 'u'
ORDER BY table_name;

-- Specific table constraints
SELECT conname, conkey::integer[]
FROM pg_constraint
WHERE conrelid = 'agents'::regclass
  AND contype = 'u';

-- Alternative: information_schema
SELECT constraint_name, table_name, column_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
  ON tc.constraint_name = kcu.constraint_name
WHERE constraint_type = 'UNIQUE'
ORDER BY table_name, ordinal_position;

-- Check if agent_models table exists
SELECT table_name FROM information_schema.tables 
WHERE table_name = 'agent_models';
```

## Model Configuration

Models are stored in the `adapter_config` JSONB field:

```sql
-- Query model for an agent
SELECT name, adapter_config->>'model' as model FROM agents;

-- Update model for an agent
UPDATE agents 
SET adapter_config = jsonb_set(adapter_config, '{model}', '"new-model-name"')
WHERE name = 'agent-name';
```

---

**Last Updated**: 2026-04-20
**Critical**: Always verify unique constraints before using ON CONFLICT!
