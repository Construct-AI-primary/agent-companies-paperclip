# Agent Naming Standard

## Overview

This document defines the canonical location and format for agent human names in the Paperclip ecosystem.

## Canonical Location: AGENTS.md

**Human names MUST be documented in the YAML frontmatter of each AGENTS.md file.**

```yaml
---
name: nexus-devforge-ceo
human_name: Nexus
slug: nexus-devforge-ceo
reportsTo: null
skills:
  - nexus-devforge-ceo
---
```

## Field Definitions

| Field | Purpose | Example |
|-------|---------|---------|
| `name` | Unique identifier (slug format) | `nexus-devforge-ceo` |
| `human_name` | Display name for UI/messages (<23 chars) | `Nexus` |
| `slug` | Full qualified slug | `nexus-devforge-ceo` |

## Human Name Requirements (HARD REQUIREMENT)

1. **Length**: Must be **< 23 characters** (hard requirement)
2. **Characters**: Only `a-z`, `A-Z`, `0-9`, spaces, hyphens, underscores
3. **Uniqueness**: Human name should be unique within the company
4. **Readability**: Should be human-readable (e.g., "Nexus", "Dataforge", "Scout")

### Valid Examples
- `Nexus` (5 chars)
- `Dataforge` (9 chars)
- `Operations Director` (19 chars)
- `Multi-Discipline Lead` (21 chars)

### Invalid Examples (≥23 chars)
- `Multi-Discipline Coordinator` (26 chars) → shorten to `Multi-Discipline Lead`
- `Document Generation Specialist` (31 chars) → shorten to `Doc Generation Lead`

## Secondary Location: register-agent.sql

For database registration, human names are stored in the `metadata` JSONB field:

```sql
'{
  "human_name": "Nexus",
  "specialization": "orchestration",
  "created_via": "atlas-agent-creator",
  "department": "executive"
}'::jsonb
```

Both locations MUST be kept in sync.

## Migration Checklist

- [ ] All AGENTS.md files need `human_name` field added to YAML frontmatter
- [ ] All human names must be validated as < 23 characters
- [ ] register-agent.sql files should match AGENTS.md human_name values

## Enforcement

The `paperclipforge-ai-agent-reconciler` agent validates:
1. Every AGENTS.md has a `human_name` field
2. Every `human_name` is < 23 characters
3. DB metadata matches filesystem definitions

---

**Document Version**: 1.0
**Created**: 2026-04-25
**Owner**: paperclipforge-ai-agent-reconciler
