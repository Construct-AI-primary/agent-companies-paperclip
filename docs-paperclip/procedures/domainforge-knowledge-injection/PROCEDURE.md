---
title: DomainForge AI Dynamic Knowledge Injection Procedure
version: 1.0
last_updated: 2026-04-28
maintainer: knowledge-curator-domainforge
applies_to: DomainForge AI discipline agents (electrical, civil, mechanical, and all 45 disciplines)
---

# DomainForge AI Dynamic Knowledge Injection Procedure

## Purpose

This procedure defines how DomainForge AI discipline agents dynamically resolve and load sector-specific and organisation-specific knowledge at runtime. It eliminates knowledge duplication by keeping knowledge files at their source of truth and having agents reference them through a central registry.

## Architecture Overview

```
Knowledge Files (source of truth)
  ├── disciplines-sector-specific-details/{sector_id}/knowledge/{discipline}-{sector}-knowledge.md
  └── organisation-knowledge/{org_slug}/knowledge/{category}/*.md
                          │
                          ▼
              KNOWLEDGE-REGISTRY.md (index)
              Maintained by knowledge-curator-domainforge
                          │
                          ▼
              DomainForge Discipline Agent
              Resolves sector_ref + org_ref from issue frontmatter
              → Looks up registry → Loads knowledge files → Executes task
```

## Roles and Responsibilities

| Role | Responsibility |
|------|---------------|
| `knowledge-curator-domainforge` | Maintains KNOWLEDGE-REGISTRY.md; scans directories; validates entries |
| `orion-domainforge-ceo` | Triggers registry rebuilds; approves new agent creation |
| Discipline agents (electrical, civil, mechanical, etc.) | Resolve knowledge references at runtime; load knowledge files before task execution |
| `paperclipforge-ai-atlasagentcreator` | Creates new agents when knowledge gaps are identified |

## Step-by-Step Workflow

### Step 1: Knowledge File Creation or Update

**Who:** Any contributor or agent

1. Create or update knowledge files in the appropriate directory:
   - Sector-specific: `disciplines-sector-specific-details/{sector_id}/knowledge/{discipline}-{sector}-knowledge.md`
   - Organisation: `organisation-knowledge/{org_slug}/knowledge/{category}/{filename}.md`
2. Follow the naming convention:
   - Sector files: `{discipline}-{sector}-knowledge.md` (e.g., `electrical-solar-knowledge.md`)
   - Organisation files: descriptive category-based naming

### Step 2: Registry Rebuild

**Who:** `knowledge-curator-domainforge` (on-demand)

1. Trigger: request from `orion-domainforge-ceo` or after knowledge PR merge
2. Execute the rebuild procedure (see SKILL.md for full details):
   - Scan `disciplines-sector-specific-details/*/knowledge/` for `{discipline}-*-knowledge.md` files
   - Scan `organisation-knowledge/*/knowledge/` for all files
   - Build sector and organisation tables
   - Validate all file paths
   - Update `last_rebuilt` timestamp
   - Commit updated `KNOWLEDGE-REGISTRY.md`

### Step 3: Issue Creation with Knowledge References

**Who:** Issue creator (agent or human)

When creating an issue that requires sector-specific or organisation-specific knowledge, add the following fields to the issue frontmatter:

```yaml
---
id: SOLAR-003
title: Electrical System Design for Solar Installation
sector_ref: 00001-solar-installations    # Links to sector knowledge
org_ref: GPC                               # Links to organisation knowledge (optional)
---
```

- `sector_ref`: The directory name from `disciplines-sector-specific-details/{sector_ref}/`
- `org_ref`: The directory name from `organisation-knowledge/{org_ref}/`
- Both fields are optional — include only when relevant
- Multiple sectors/orgs can be referenced as comma-separated values

### Step 4: Agent Knowledge Resolution at Runtime

**Who:** DomainForge discipline agent

When a DomainForge discipline agent receives an issue:

1. **Parse issue frontmatter** for `sector_ref` and `org_ref` fields
2. **Open KNOWLEDGE-REGISTRY.md** at `docs-paperclip/companies/domainforge-ai/knowledge/KNOWLEDGE-REGISTRY.md`
3. **Resolve sector knowledge:**
   - If `sector_ref` is present, filter the sector table for rows matching:
     - `sector_id` = issue's `sector_ref`
     - `discipline` = agent's discipline (e.g., `electrical`)
   - Resolve each `knowledge_file` path relative to the registry location
   - Read all matched files into working context
4. **Resolve organisation knowledge:**
   - If `org_ref` is present, filter the organisation table for rows matching:
     - `org_slug` = issue's `org_ref`
   - Resolve each `knowledge_file` path relative to the registry location
   - Read all matched files into working context
5. **Proceed with task execution** using the loaded knowledge context

### Step 5: Knowledge Validation

**Who:** `knowledge-curator-domainforge` (periodic or on-demand)

1. Read all entries from `KNOWLEDGE-REGISTRY.md`
2. Resolve each file path and verify existence
3. Report valid entries, orphaned entries, and unregistered files
4. Flag issues for remediation

## Issue Frontmatter Examples

### Sector-specific only (no organisation context)
```yaml
---
id: SOLAR-003
title: Electrical System Design for Solar Installation
sector_ref: 00001-solar-installations
---
```

### Organisation-specific only (no sector context)
```yaml
---
id: GPC-001
title: GPC Electrical Infrastructure Assessment
org_ref: GPC
---
```

### Both sector and organisation
```yaml
---
id: SOLAR-003
title: Electrical System Design for GPC Solar Farm
sector_ref: 00001-solar-installations
org_ref: GPC
---
```

### Multiple references
```yaml
---
id: SOLAR-003
title: Electrical System Design for GPC Solar Farm
sector_ref: 00001-solar-installations, 00002-traffic-signals
org_ref: GPC, zama
---
```

## Migration: Adding sector_ref to Existing Issues

For existing issues under `disciplines-sector-specific-details/*/projects/*/desktop/issues/`:

1. Identify the sector from the parent directory structure
2. Add `sector_ref: {sector_id}` to the issue frontmatter
3. No need to strip knowledge content — the knowledge files serve as reference material, not duplicated content
4. Future issues should include `sector_ref` and `org_ref` at creation time

## Adding New Discipline Agents to the System

When a new discipline agent is needed (e.g., for a sector that requires a discipline not yet covered):

1. `knowledge-curator-domainforge` identifies the gap during registry validation
2. Coordinates with `paperclipforge-ai-atlasagentcreator` to create the new agent
3. After agent creation, the registry is updated to include the new discipline's knowledge mappings
4. The new agent's SKILL.md includes the Knowledge Loading Protocol

## Error Handling

| Scenario | Resolution |
|----------|-----------|
| `sector_ref` in issue but no matching registry entry | Agent logs warning, proceeds without sector knowledge |
| `org_ref` in issue but no matching registry entry | Agent logs warning, proceeds without organisation knowledge |
| Registry file path does not resolve | Agent logs error, falls back to convention-based discovery |
| Knowledge file referenced in registry is missing | `knowledge-curator-domainforge` flags orphaned entry for removal |
| Knowledge file exists but no registry entry | `knowledge-curator-domainforge` adds entry during next rebuild |

## Related Documents

- `docs-paperclip/companies/domainforge-ai/knowledge/KNOWLEDGE-REGISTRY.md` — The knowledge index
- `docs-paperclip/companies/domainforge-ai/agents/knowledge-curator-domainforge/AGENTS.md` — Curator agent definition
- `docs-paperclip/companies/domainforge-ai/skills/knowledge-curator-domainforge/SKILL.md` — Curator skill procedures
- `docs-paperclip/procedures/agents/atlas-agent-creation-with-schema-inspection-procedure.md` — Agent creation procedure