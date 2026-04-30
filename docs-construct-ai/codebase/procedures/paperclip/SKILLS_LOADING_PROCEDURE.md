# Skills Loading Procedure for Paperclip

## Overview

This document describes the complete procedure for loading AI agent skills into the Supabase database and assigning them to agents in the Paperclip multi-company AI platform.

## Database Tables

### `company_skills` Table
Stores company-specific skills that belong to individual companies.

| Column | Type | Description |
|--------|------|-------------|
| `id` | uuid | Primary key |
| `company_id` | uuid | FK to companies table |
| `key` | text | Unique skill identifier |
| `slug` | text | URL-friendly name |
| `name` | text | Display name |
| `description` | text | Brief description |
| `markdown` | text | Full skill content (SKILL.md) |
| `source_type` | text | Source type (default: 'local_path') |
| `source_locator` | text | Path to skill file |
| `trust_level` | text | Trust level (default: 'markdown_only') |
| `compatibility` | text | Compatibility status (default: 'compatible') |
| `file_inventory` | jsonb | List of files in skill |
| `created_at` | timestamptz | Creation timestamp |
| `updated_at` | timestamptz | Last update timestamp |

### `shared_skills` Table
Stores cross-company shared skills that don't belong to a specific company.

| Column | Type | Description |
|--------|------|-------------|
| `id` | uuid | Primary key |
| `key` | text | Unique skill identifier |
| `slug` | text | URL-friendly name |
| `name` | text | Display name |
| `description` | text | Brief description |
| `markdown` | text | Full skill content (SKILL.md) |
| `source_type` | text | Source type (default: 'local_path') |
| `source_locator` | text | Path to skill file |
| `trust_level` | text | Trust level (default: 'markdown_only') |
| `compatibility` | text | Compatibility status (default: 'compatible') |
| `file_inventory` | jsonb | List of files in skill |
| `metadata` | jsonb | Additional metadata |
| `created_at` | timestamptz | Creation timestamp |
| `updated_at` | timestamptz | Last update timestamp |

### `agent_skill_assignments` Table
Maps agents to their assigned skills.

| Column | Type | Description |
|--------|------|-------------|
| `id` | uuid | Primary key |
| `company_id` | uuid | FK to companies table |
| `agent_id` | uuid | FK to agents table |
| `skill_key` | text | References company_skills.key or shared_skills.key |
| `source` | text | 'company_skills' or 'shared_skills' |
| `created_at` | timestamptz | Assignment timestamp |

## Company ID Mapping

| Company | Supabase ID |
|---------|-------------|
| DevForge AI | `f97b30e8-b022-4350-b4b0-30d43e2ebcf4` |
| PromptForge AI | `9ec4c0ec-d8f1-48ab-b473-ec164b584129` |
| QualityForge AI | `f535f9bc-00be-4b6d-9f53-c53abfacacef` |
| DomainForge AI | `2d7d9c60-c02f-42a7-8f6a-7db86ecc879d` |
| Loopy AI | `0a40625e-78f9-4b0a-82e4-169a8befa021` |
| InfraForge AI | `09f438a3-4041-46f2-b3cc-96fc9446e666` |

## Skill Sources

Skills are stored as markdown files in the `skills/` directory:

```
skills/
├── devforge-ai/          # 51 company-specific skills
├── promptforge-ai/       # 23 company-specific skills
├── qualityforge-ai/      # 41 company-specific skills
├── domainforge-ai/       # 23 company-specific skills
├── loopy-ai/             # 6 company-specific skills
├── infraforge-ai/        # 4 company-specific skills
├── construct-ai/         # Discipline-based skills
└── shared/               # 73 cross-company shared skills
```

Each skill is a directory containing a `SKILL.md` file with YAML frontmatter:
```yaml
---
name: skill-name
description: Brief description of the skill
---

# Skill Content
...
```

## Loading Procedure

### Prerequisites
1. Node.js installed
2. Supabase project with `company_skills`, `shared_skills`, and `agent_skill_assignments` tables
3. Service role key from Supabase Dashboard → Settings → API

### Step 1: Create Tables (First Time Only)

Run in Supabase SQL Editor:

```sql
-- shared_skills table
CREATE TABLE IF NOT EXISTS shared_skills (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  key text NOT NULL,
  slug text NOT NULL,
  name text NOT NULL,
  description text,
  markdown text NOT NULL,
  source_type text NOT NULL DEFAULT 'local_path',
  source_locator text,
  trust_level text NOT NULL DEFAULT 'markdown_only',
  compatibility text NOT NULL DEFAULT 'compatible',
  file_inventory jsonb NOT NULL DEFAULT '[]'::jsonb,
  metadata jsonb,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  updated_at timestamp with time zone NOT NULL DEFAULT now(),
  PRIMARY KEY (id),
  UNIQUE (key)
);

ALTER TABLE shared_skills DISABLE ROW LEVEL SECURITY;
GRANT ALL ON shared_skills TO service_role;

-- agent_skill_assignments table
CREATE TABLE IF NOT EXISTS agent_skill_assignments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES companies(id),
  agent_id uuid NOT NULL REFERENCES agents(id),
  skill_key text NOT NULL,
  source text DEFAULT 'company_skills' CHECK (source IN ('company_skills', 'shared_skills')),
  created_at timestamptz DEFAULT now(),
  UNIQUE (agent_id, skill_key)
);

ALTER TABLE agent_skill_assignments DISABLE ROW LEVEL SECURITY;
GRANT ALL ON agent_skill_assignments TO service_role;
```

### Step 2: Install Dependencies

```bash
cd construct-ai-docs/codebase/other-apps/paperclip/integration
npm install @supabase/supabase-js
```

### Step 3: Load Skills into Database

```bash
SUPABASE_URL=https://gmorarhibiptvcrnvrpi.supabase.co \
SUPABASE_KEY=<service_role_key> \
node insert_skills_to_supabase.mjs
```

### Step 4: Assign Skills to Agents

The `assign_agent_skills.mjs` script uses smart fuzzy matching:

1. **Primary match**: Finds company skill matching agent name (e.g., "Auditor" → `auditor-qualityforge-quality-auditor`)
2. **Shared skills**: Assigns ALL 73 shared skills to every agent as baseline
3. **Reports**: Shows which agents had no primary match

```bash
SUPABASE_URL=https://gmorarhibiptvcrnvrpi.supabase.co \
SUPABASE_KEY=<service_role_key> \
node assign_agent_skills.mjs
```

### Step 5: Sync adapterConfig for UI Display

The Skills tab UI reads from `agent.adapter_config.paperclipSkillSync.desiredSkills`. Run this SQL to sync:

```sql
UPDATE agents a
SET adapter_config = jsonb_set(
      COALESCE(a.adapter_config, '{}'::jsonb),
      '{paperclipSkillSync,desiredSkills}',
      COALESCE((
        SELECT jsonb_agg(DISTINCT asa.skill_key)
        FROM agent_skill_assignments asa
        WHERE asa.agent_id = a.id
      ), '[]'::jsonb)
    )
WHERE a.company_id IS NOT NULL;
```

## How Skills Display in UI

The Skills tab on each agent shows **3 sections**:

### 1. Company Skills (checkboxes, editable)
- All skills from `company_skills` table for the agent's company
- Each has a checkbox — checked if in `desiredSkills`, unchecked otherwise
- User can toggle on/off to customize per agent

### 2. Required by Paperclip (locked checkboxes)
- Skills marked `required: true` by the adapter
- Checkboxes are checked and **disabled** — cannot be unchecked

### 3. User-installed Skills (read-only, collapsible)
- External skills found in workspace but NOT in company library
- No checkbox — grey dot indicator
- Collapsible section (hidden by default)

## How Skills Enter Agent Context at Runtime

**Current state:**
1. ✅ Skills loaded into `company_skills` and `shared_skills` tables
2. ✅ `agent_skill_assignments` table maps agents → skills
3. ✅ `adapterConfig.paperclipSkillSync.desiredSkills` synced for UI
4. ✅ Runtime skill injection via `paperclipRuntimeSkills` in adapter config

**Runtime flow:**
1. Adapter reads `paperclipRuntimeSkills` from agent config
2. Skills are symlinked into `~/.claude/skills/` for the adapter
3. Each skill folder becomes one skill entry (one `SKILL.md` per folder)

## Multi-Skill Agents

Each skill folder = one skill. To give an agent multiple distinct capabilities:

- **Separate folders** = separate checkboxes (toggleable independently)
- **Multiple files in one folder** = one skill (only `SKILL.md` is loaded)

## Maintenance

### Adding New Skills
1. Create a new directory in the appropriate `skills/<company>/` folder
2. Add a `SKILL.md` file with frontmatter
3. Re-run `insert_skills_to_supabase.mjs`
4. Re-run `assign_agent_skills.mjs` to assign to agents

### Updating Existing Skills
1. Edit the `SKILL.md` file
2. Re-run the insertion script (it will detect and update)

### Removing Skills
1. Delete the skill directory
2. Manually delete from database:
   ```sql
   DELETE FROM company_skills WHERE key = 'skill-key';
   -- or
   DELETE FROM shared_skills WHERE key = 'skill-key';
   ```

## Files

| File | Purpose |
|------|---------|
| `insert_skills_to_supabase.mjs` | Node.js script for loading skills into DB |
| `assign_agent_skills.mjs` | Smart fuzzy-matching assignment script |
| `SYNC_AGENT_DESIRED_SKILLS.sql` | adapterConfig sync SQL |
| `SHARED_SKILLS_TABLE.sql` | SQL to create shared_skills table |
| `ALL_COMPANY_SKILLS.sql` | Generated SQL for company skills |
| `ALL_SKILLS.sql` | Generated SQL for all skills |
| `DOMAIN_SKILLS.sql` | Domain-based skill loading |