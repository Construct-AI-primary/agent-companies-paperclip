# Foreign Key Constraints Reference

**Complete foreign key relationships for Paperclip database schema.**

## Core Entity Relationships

```
companies (root entity)
  ├── agents (company_id → companies.id)
  ├── goals (company_id → companies.id)
  ├── projects (company_id → companies.id)
  └── issues (company_id → companies.id)

agents
  ├── agent_models (agent_id → agents.id)
  ├── agent_api_keys (agent_id → agents.id)
  ├── activity_log (actor_id → agents.id)
  └── agent_skills (agent_id → agents.id)

goals
  └── projects (goal_id → goals.id, optional)

projects
  └── issues (project_id → projects.id, optional)

skills
  └── agent_skills (skill_id → skills.id)
```

## Detailed Foreign Key Mappings

### companies (Root)
- No foreign keys (root entity)

### agents
- `company_id` → `companies.id` (required)

### agent_models
- `agent_id` → `agents.name` (references agent name, not id)

### goals
- `company_id` → `companies.id` (required)
- `owner_agent_id` → `agents.id` (optional)

### projects
- `company_id` → `companies.id` (required)
- `goal_id` → `goals.id` (optional)

### issues
- `company_id` → `companies.id` (required)
- `project_id` → `projects.id` (optional)
- `goal_id` → `goals.id` (optional)
- `assignee_id` → `agents.id` (optional)

### agent_api_keys
- `agent_id` → `agents.id` (required)

### activity_log
- `company_id` → `companies.id` (required)
- `actor_id` → `agents.id` (optional)

### agent_skills
- `agent_id` → `agents.id` (required)
- `skill_id` → `skills.id` (required)

## Insertion Order (Foreign Key Dependency)

When creating SQL scripts, follow this order:

1. **companies** - Must exist first
2. **agents** - Requires company_id
3. **goals** - Requires company_id (optional: owner_agent_id)
4. **projects** - Requires company_id (optional: goal_id)
5. **issues** - Requires company_id (optional: project_id, goal_id)

## Safe Insert Pattern

⚠️ **ALWAYS** verify the parent record exists before inserting dependent data:

```sql
-- WRONG - will fail if company doesn't exist
INSERT INTO goals (company_id, ...) VALUES ('uuid-here', ...);

-- CORRECT - only inserts if company exists
INSERT INTO goals (company_id, title, ...)
SELECT c.id, 'Title', ...
FROM companies c
WHERE c.name = 'Company Name'
ON CONFLICT DO NOTHING;
```

## Query: Verify Foreign Key Relationships

```sql
-- List all foreign keys
SELECT
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu
    ON ccu.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
ORDER BY tc.table_name, kcu.column_name;
```

---

**Last Updated**: 2026-04-20
**Source**: FOREIGN_KEY_CONSTRAINTS.md (consolidated)
