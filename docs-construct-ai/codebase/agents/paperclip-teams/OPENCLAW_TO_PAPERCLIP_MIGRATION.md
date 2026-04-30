---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation, migration, openclaw-to-paperclip
openstinger_context: general-documentation
last_updated: 2026-04-06
related_docs:
  - docs/
---

# OpenClaw → Paperclip Teams Migration Log

## Migration Summary

**Date:** 2026-04-06  
**Status:** Completed  
**Type:** Directory rename, content update, file cleanup  

## Final Directory State: `docs-construct-ai/codebase/agents/paperclip-teams/`

| File | Status | Notes |
|------|--------|-------|
| `Paperclip_Teams_Cross_Reference.md` | **Updated** | Complete rewrite for 9 companies, Hermes runtime |
| `Paperclip_Companies_Roster.md` | **New** | Detailed roster for all 9 companies with teams, agents, skills |
| `Loopy_AI_Team.md` | Copied (unchanged) | Content valid |
| `DevForge_AI_Team.md` | Copied (unchanged) | Content valid |
| `DevForge_AI_Workflow_Review_Guide.md` | Copied (unchanged) | Content valid |
| `DomainForge_AI_Team.md` | Copied (unchanged) | Content valid |
| `InfraForge_AI_Team.md` | Copied (unchanged) | Content valid |
| `PromptForge_AI_Team.md` | Copied (unchanged) | Content valid |
| `QualityForge_AI_Team.md` | Copied (unchanged) | Content valid |
| `OPENCLAW_TO_PAPERCLIP_MIGRATION.md` | **New** | This migration log |

## Files NOT in paperclip-teams/ (belong elsewhere)

| File | Correct Location | Rationale |
|------|-----------------|-----------|
| `_memory_header.md` | `codebase/agents/` | Directory-level metadata for codebase/agents/ — belongs exactly here |
| `code-reviewer.md` | `codebase/agents/` | Code review agent definition — belongs exactly here |

## Files Relocated

| File | From | To | Rationale |
|------|------|-----|-----------|
| `PROCUREMENT_WORKFLOW_TEAM_STAFFING_ANALYSIS.md` | `openclaw-teams/` | `codebase/analysis/` | This is procurement analysis content, not a Paperclip company teams document |

## Content Updates

1. **Terminology**: All "OpenClaw" references replaced with "Paperclip" or "Hermes agent"
2. **Companies**: Updated from 6 to 9 companies (`construct-ai`, `knowledgeforge-ai`, `org-template-ai` added)
3. **Runtime**: Updated from "OpenClaw framework" to "Hermes agent via `hermes_local` adapter"
4. **Memory**: Updated to Hermes memory stack (SQLite sessions, FTS5 search, context compression)

## Old Directory Deleted

`docs-construct-ai/codebase/agents/openclaw-teams/` has been deleted. All relevant content preserved in new locations.