# Paperclip Database Schema Documentation

Complete reference for Paperclip database schema - tables, constraints, and SQL patterns.

## 📁 Structure

```
schema/
├── README.md                           ← You are here
├── tables/                            ← Table schemas (organized by domain)
│   ├── agents.md                       ← agents table
│   ├── agent-models.md                 ← agent_models table ⚠️
│   ├── companies.md                    ← companies table
│   ├── issues.md                       ← issues table
│   ├── projects.md                     ← projects table
│   ├── goals.md                       ← goals table
│   ├── agent-api-keys.md             ← agent_api_keys table
│   └── activity-log.md                ← activity_log table
├── constraints/                        ← Constraints and foreign keys
│   ├── foreign-keys.md               ← Foreign key relationships ✓
│   └── unique-constraints.md        ← Unique constraints per table ⚠️
├── generated/                          ← Generated schema files
│   └── drizzle-schema-reference.ts    ← Drizzle ORM schema (TypeScript)
└── scripts/                            ← Schema extraction scripts
    └── extract-schema.sh              ← Extract from PostgreSQL
```

## 🚀 Quick Start

### Finding a Table Schema
1. Look in `tables/` for the table name
2. Each table file includes:
   - Column definitions
   - Required vs optional columns
   - Data types and defaults
   - Unique constraints

### Finding Constraints
1. `constraints/foreign-keys.md` - All FK relationships
2. `constraints/unique-constraints.md` - Unique constraints (critical for ON CONFLICT!)

## ⚠️ Critical: ON CONFLICT Constraints

**ALWAYS check `constraints/unique-constraints.md` before using ON CONFLICT!**

Example error if wrong constraint used:
```
ERROR: 42P10: there is no unique or exclusion constraint matching the ON CONFLICT specification
```

## 📊 Core Tables

| Table | Purpose | Key Reference |
|-------|---------|---------------|
| `agents` | AI agent definitions | `tables/agents.md` |
| `agent_models` | Model assignments per agent | `tables/agent-models.md` ⚠️ |
| `companies` | Company/organisation definitions | `tables/companies.md` |
| `issues` | Task/issue tracking | `tables/issues.md` |
| `projects` | Project management | `tables/projects.md` |
| `goals` | Goal hierarchy | `tables/goals.md` |
| `agent_api_keys` | API key management | `tables/agent-api-keys.md` |

## 🔗 Key Relationships

```
companies ─┬─< agents ─┬─< agent_models
           │           ├─< agent_api_keys
           │           └─< activity_log
           │
           ├─< goals ─┬─< projects ─< issues
           │           └─< issues
           │
           └─< projects ─< issues
```

## 📚 TypeScript Schema

- `generated/drizzle-schema-reference.ts` - TypeScript/Drizzle ORM definitions
  - Contains all table definitions: activity_log, agent_api_keys, agents, companies, issues, goals, projects, etc.
  - Used by the application code for type-safe database operations

## 📝 Extracting Schema from Database

```bash
# Requires DATABASE_URL environment variable
./scripts/extract-schema.sh "$DATABASE_URL"

# Or run SQL directly
psql "$DATABASE_URL" -c "\d agents"
psql "$DATABASE_URL" -c "\d agent_models"
```

---

**Last Updated**: 2026-04-20
**Version**: 3.0 (consolidated)
