# KnowledgeForge Implementation Plan

Status: **Implemented (Phase 1)**  
Owner: Agent Configuration + Skills  
Date: 2026-04-06  
Last Updated: 2026-04-06  

## Summary

Create **KnowledgeForge**, a Paperclip agent company that serves as an institutional-memory layer for the Paperclip-render codebase, 50+ engineering/construction disciplines, sector-specific workflows, and QA/testing knowledge.

KnowledgeForge consolidates the research-backed multi-agent QA and codebase-ownership pattern into a concrete, importable company package that can be deployed alongside Paperclip to achieve repeatable, automated code quality assurance.

**Phase 1: 11 Core Agents** — the minimum viable set. Proven value first, expand by demand.
- Doc Analyzer, QA Strategist, Arch Refactorer, App Guardian
- Workflow Guardian, Discipline Reader, Standards Keeper
- Memory Manager, Integration Monitor, Error Tracker, Failure Learner

**Phase 2+ (Only If Needed)** — add discipline specialists (start with top 4: procurement, safety, logistics, contracts), then non-discipline specialists.

**Do NOT build yet**: 66-agent import, quarterly archive automation, per-discipline specialists for all 50+ disciplines.

See the knowledge architecture: [KnowledgeForge KNOWLEDGE-ARCHITECTURE.md](../companies/knowledgeforge-ai/KNOWLEDGE-ARCHITECTURE.md)

## Goals

1. Package 11 specialized agents under a single KnowledgeForge company following the `agentcompanies/v1` spec.
2. Wire each agent to the appropriate discipline/sector tags in the existing docs-construct-ai knowledge base.
3. Use `hermes_local` adapter type for all agents so they run via the Hermes agent runtime.
4. Enable paperclip-QA loop: agents review PRs, generate tests, run linters, and gate deployments.
5. Keep the package portable — all content lives in markdown with YAML frontmatter, no database dependency.

## Non-Goals

- Building new API endpoints or database schema.
- Creating skills from scratch (skills reference existing `docs-construct-ai` content).
- Replacing existing company packages — KnowledgeForge is additive.
- Implementing the full artifact/deliverables system.

## Research Context

Three findings drive this design:

### 1. OpenCode + Paperclip achieves solid QA
OpenCode acts as an AI coding agent with LSP-style awareness. Paperclip orchestrates multiple agents. Together they can:
- Run QA-engineer agents that review PRs, generate tests, run linters, and gate deployments.
- Enforce approval gates and rollbacks so only reviewed changes land in main.
- Quality depends on model choice, prompt engineering, and human review loops on critical paths.

### 2. OpenCode outperforms OpenClaw for coding
Even with the same LLM, OpenCode is a dedicated coding assistant with diff-aware workflows. OpenClaw is a general-purpose automation gateway. Use OpenCode (via `hermes_local` adapter) as the coding executor; use Paperclip for orchestration.

### 3. Knowledge is transportable
Hermes stores skills and memory in a local file tree (`~/.hermes/skills/`, `~/.hermes/memory/`). The docs-construct-ai knowledge base (~5k tagged markdowns) can be exported, synced, and imported into any environment.

## Proposed Company Structure

```
knowledgeforge-ai/
├── COMPANY.md
├── .paperclip.yaml
├── agents/
│   ├── knowledgeforge-doc-analyzer/
│   │   └── AGENTS.md
│   ├── knowledgeforge-qa-strategist/
│   │   └── AGENTS.md
│   ├── knowledgeforge-arch-refactorer/
│   │   └── AGENTS.md
│   ├── knowledgeforge-failure-learner/
│   │   └── AGENTS.md
│   ├── knowledgeforge-clinet-integrator/
│   │   └── AGENTS.md
│   ├── knowledgeforge-app-guardian/
│   │   └── AGENTS.md
│   ├── knowledgeforge-discipline-strategist/
│   │   └── AGENTS.md
│   ├── knowledgeforge-cross-discipline-guardian/
│   │   └── AGENTS.md
│   ├── knowledgeforge-workflow-guardian/
│   │   └── AGENTS.md
│   ├── knowledgeforge-sector-analyst/
│   │   └── AGENTS.md
│   └── knowledgeforge-sector-qa-lead/
│       └── AGENTS.md
├── skills/
│   ├── doc-analysis/
│   │   └── SKILL.md
│   ├── qa-strategy/
│   │   └── SKILL.md
│   ├── arch-refactor/
│   │   └── SKILL.md
│   ├── failure-learning/
│   │   └── SKILL.md
│   ├── clinet-integration/
│   │   └── SKILL.md
│   ├── app-guardian/
│   │   └── SKILL.md
│   ├── discipline-strategy/
│   │   └── SKILL.md
│   ├── cross-discipline-guard/
│   │   └── SKILL.md
│   ├── workflow-guard/
│   │   └── SKILL.md
│   ├── sector-analysis/
│   │   └── SKILL.md
│   └── sector-qa/
│       └── SKILL.md
└── tasks/
    └── qa-review/
        └── TASK.md
```

## Agent Roster

### App-Focused Agents

| Agent | Role | Tags Read | Primary Skill |
|-------|------|-----------|---------------|
| `KnowledgeForge_DocAnalyzer` | Ingests 5k tagged MDs, aligns structure, validates tags | `codebase/*`, `documentation/*` | `doc-analysis` |
| `KnowledgeForge_QA_Strategist` | Drafts QA test strategies for prod-ready runs | `testing/*`, `ci/*` | `qa-strategy` |
| `KnowledgeForge_Arch_Refactorer` | Proposes architecture-aligned refactors | `codebase/architecture/*`, `disciplines/01300_developer/*` | `arch-refactor` |
| `KnowledgeForge_Failure_Learner` | Turns QA test failures into reusable skills | `testing/failures/*`, `error-tracking/*` | `failure-learning` |
| `KnowledgeForge_ClieNT_Integrator` | Imports Cline task history, turns runs into skills | `codebase/agents/*`, `hermes_agent/*` | `clinet-integration` |
| `KnowledgeForge_App_Guardian` | Ensures PRs conform to app-policy docs | `standards/*`, `codebase/security/*`, `codebase/audits/*` | `app-guardian` |

### Discipline-Focused Agents

| Agent | Role | Tags Read | Primary Skill |
|-------|------|-----------|---------------|
| `KnowledgeForge_Discipline_Strategist` | Maps features to 50+ discipline workflows | `disciplines/*` | `discipline-strategy` |
| `KnowledgeForge_Cross_Discipline_Guardian` | Guards against multi-discipline conflicts | `disciplines/CROSS-DISCIPLINE.md`, `disciplines/*/workflow_docs/` | `cross-discipline-guard` |
| `KnowledgeForge_Workflow_Guardian` | Ensures discipline-specific workflows survive changes | `disciplines/*/workflow_docs/*`, `procedures/*` | `workflow-guard` |

### Sector-Focused Agents

| Agent | Role | Tags Read | Primary Skill |
|-------|------|-----------|---------------|
| `KnowledgeForge_Sector_Analyst` | Applies sector rules (oil-gas, infrastructure, etc.) | `disciplines/00300_construction/*`, sector-specific directories | `sector-analysis` |
| `KnowledgeForge_Sector_QA_Lead` | Generates QA tests for sector-specific workflows | `disciplines/00300_construction/*/testing/*` | `sector-qa` |

## Adapter Configuration

All agents use the `hermes_local` adapter type. The `.paperclip.yaml` sidecar declares:

```yaml
schema: paperclip/v1
agents:
  knowledgeforge-doc-analyzer:
    adapter:
      type: hermes_local
      config:
        model: openrouter/qwen/qwen3.6-pro
        maxIterations: 50
    inputs:
      env:
        OPENROUTER_API_KEY:
          kind: secret
          requirement: required
  knowledgeforge-qa-strategist:
    adapter:
      type: hermes_local
      config:
        model: openrouter/qwen/qwen3.6-pro
        maxIterations: 50
    inputs:
      env:
        OPENROUTER_API_KEY:
          kind: secret
          requirement: required
  # ... same pattern for all 11 agents
```

Key settings shared across all agents:
- `persistSession: true` — all agents learn from the same shared knowledge base.
- `model: openrouter/qwen/qwen3.6-pro` — free model via OpenRouter.
- `enabled_toolsets: ["file_tools", "terminal_tools", "code_execution"]` — coding-focused agents get full tool access.

## Knowledge Source Mapping

The KnowledgeForge agents read from the existing `docs-construct-ai` knowledge base. See the complete index at [KNOWLEDGE-ARCHITECTURE.md](../companies/knowledgeforge-ai/KNOWLEDGE-ARCHITECTURE.md).

### Knowledge Index

A generated `KNOWLEDGE-INDEX.json` (built by `docs-construct-ai/scripts/build-knowledge-index.py`) provides a searchable index of all 2,906+ markdown files with:
- 67 disciplines indexed
- 17 workflow procedures catalogued
- 767 unique tags
- Frontmatter metadata extraction (`memory_layer`, `gigabrain_tags`, `last_updated`)

### Source Directories

| Directory | Documents | Purpose |
|-----------|-----------|---------|
| `disciplines/` | 639+ | Engineering/construction discipline documentation |
| `disciplines/*/workflow_docs/` | 17 | Detailed workflow procedures (e.g., procurement orders) |
| `disciplines/*/agent-data/` | 109 | Agent-specific domain knowledge |
| `disciplines-non/` | 47 | Non-discipline areas (admin, IT, UI stubs) |
| `codebase/` | 1,263 | Architecture, coding standards, procedures, guides |
| `standards/` | 31 | Coding and quality standards |
| `testing/` | 16 | Testing procedures and validation reports |
| `error-tracking/` | 37 | Error logs and failure analysis |
| `para/` | Working | PARA projects, areas, resources |
| `memory-integration/` | 3 | Agent guidelines, daily templates, testing validation |
| `chat-history-index/` | Summaries | Past agent conversation summaries |

### Tag Schema

The current knowledge base uses these tag domains:

| Tag Prefix | Domain | Example |
|------------|--------|---------|
| `discipline:*` | Engineering/construction disciplines | `discipline:procurement` |
| `wf:*` | Workflows | `wf:po-materials` |
| `sec:*` | Construction sectors | `sec:oil-gas` |
| `codebase:*` | Codebase documentation | `codebase/architecture` |
| `testing:*` | Testing strategies and results | `testing/tier1` |
| `standards:*` | Coding and quality standards | `standards/coding` |
| `error-tracking:*` | Error logs and failure analysis | `error-tracking/ui-settings` |
| `type:*` | Document type (from index) | `type:workflow`, `type:discipline` |
| `layer:*` | Memory layer (from frontmatter) | `layer:durable_knowledge` |

### Export Script

A small export script syncs the knowledge base into a portable archive:

```bash
#!/bin/bash
# scripts/export_knowledgeforge.sh
set -euo pipefail

KNOWLEDGE_DIR="${1:-../docs-construct-ai}"
OUTPUT_DIR="${2:-./knowledge-export}"

mkdir -p "$OUTPUT_DIR"

# Core knowledge domains
rsync -av --include='*/' --include='*.md' --exclude='*' \
  "$KNOWLEDGE_DIR/disciplines/" "$OUTPUT_DIR/disciplines/"

rsync -av --include='*/' --include='*.md' --exclude='*' \
  "$KNOWLEDGE_DIR/codebase/" "$OUTPUT_DIR/codebase/"

rsync -av --include='*/' --include='*.md' --exclude='*' \
  "$KNOWLEDGE_DIR/testing/" "$OUTPUT_DIR/testing/"

rsync -av --include='*/' --include='*.md' --exclude='*' \
  "$KNOWLEDGE_DIR/error-tracking/" "$OUTPUT_DIR/error-tracking/"

rsync -av --include='*/' --include='*.md' --exclude='*' \
  "$KNOWLEDGE_DIR/standards/" "$OUTPUT_DIR/standards/"

# Archive
tar czf "$OUTPUT_DIR/knowledgeforge-$(date +%Y%m%d).tar.gz" -C "$OUTPUT_DIR" .
```

## Implementation Phases

### Phase 1: Company scaffold

Files:
- `docs-paperclip/companies/knowledgeforge-ai/COMPANY.md`
- `docs-paperclip/companies/knowledgeforge-ai/.paperclip.yaml`

Create the company root with frontmatter, goals, and directory listing placeholders.

Acceptance:
- COMPANY.md follows `agentcompanies/v1` spec.
- Company can be imported via `paperclip companies import`.

### Phase 2: Agent definitions

Files:
- `docs-paperclip/companies/knowledgeforge-ai/agents/*/AGENTS.md` (11 files)

Each agent file contains:
- YAML frontmatter with name, title, role, skills list.
- Body text with the agent's charter and operating instructions.
- Skills list referencing the `skills/` directory.

Acceptance:
- All 11 agents defined with unique roles.
- Each agent references at least one skill.
- Roles map to Paperclip task workflow.

### Phase 3: Skill definitions

Files:
- `docs-paperclip/companies/knowledgeforge-ai/skills/*/SKILL.md` (11 files)

Each skill contains:
- Trigger conditions (when to use this skill).
- Step-by-step instructions.
- Tool allowlists.
- References to docs-construct-ai knowledge directories.

Acceptance:
- Skills are valid per Agent Skills spec.
- Skills reference correct knowledge directories.
- Skills compose cleanly without overlap.

### Phase 4: Adapter configuration

Files:
- `docs-paperclip/companies/knowledgeforge-ai/.paperclip.yaml`

Define adapter type, model config, and environment inputs for all 11 agents.

Acceptance:
- All agents use `hermes_local` adapter type.
- Environment inputs declare required secrets.
- Configuration validates against Paperclip schema.

### Phase 5: QA workflow tasks

Files:
- `docs-paperclip/companies/knowledgeforge-ai/tasks/qa-review/TASK.md`

Define the base QA review task that ties agents together in a review loop.

Acceptance:
- Task assigns work to QA Strategist → Arch Refactorer → App Guardian.
- Task includes approval gate before merge.
- Task writes activity log on completion.

### Phase 6: Import and smoke test

Acceptance:
- Company imports successfully via Paperclip.
- All 11 agents appear in the company agent list.
- Knowledge export script runs without errors.
- At least one agent can complete a task against the paperclip-render codebase.

## Test Plan

### Company package
- COMPANY.md parses with correct frontmatter fields.
- All agent paths resolve to existing files.
- All skill paths resolve to existing files.
- `.paperclip.yaml` validates against Paperclip schema.

### Agent definitions
- Each AGENTS.md has valid YAML frontmatter.
- Skills references resolve to existing SKILL.md files.
- No duplicate agent names or roles.

### Skills
- Each SKILL.md is a valid Agent Skills package.
- Trigger conditions are unambiguous.
- Tool allowlists are appropriate for the task.

### Integration
- Import the company into a test Paperclip instance.
- Verify all agents appear with correct roles.
- Run a smoke task against a test repository.
- Verify activity log entries are written.

### Verification
```sh
paperclip companies validate docs-paperclip/companies/knowledgeforge-ai/
pnpm -r typecheck
pnpm build
```

## Open Questions

1. **Model choice**: All agents use `openrouter/qwen/qwen3.6-pro` (free). Upgrade only if quality is insufficient.

2. **Knowledge base freshness**: Should KnowledgeForge re-export docs-construct-ai on every import, or on a schedule?  
   Recommendation: Export on import for freshness; add a cron job for periodic sync if the company is long-running.

3. **Cross-company access**: Can KnowledgeForge agents review issues in other Paperclip companies?  
   Recommendation: Yes — KnowledgeForge should be able to act as a cross-company QA service via delegation.

4. **Skill deduplication**: Some skills may overlap with existing company skills (e.g., code review skills in DomainForge).  
   Recommendation: Keep KnowledgeForge skills QA-focused and generic; reference existing skills via `includes` rather than duplicating.

## Final Recommendation

Ship KnowledgeForge as a focused, importable company package that:
- Uses 11 specialized agents, each with a clear role and skill set.
- Leverages the existing docs-construct-ai knowledge base (~5k tagged documents).
- Uses `hermes_local` adapter for all agents via the Hermes runtime.
- Follows the `agentcompanies/v1` spec for portability.
- Provides a concrete QA review-loop pattern: review → refactor → guard → approve.

This gives the user a working multi-agent QA system that can be deployed alongside any Paperclip company to achieve solid, repeatable code quality assurance across their codebase.

## Actual Database Schema Reference

The complete Drizzle schema (58 tables, 2456 lines) has been extracted to:
- `docs-paperclip/schema/drizzle-schema-reference.ts`

Key tables for KnowledgeForge import:

### companies
- `id` (uuid, PK), `name` (text), `description` (text), `status` (text, default 'active')
- `budget_monthly_cents` (integer), `spent_monthly_cents` (integer)
- `created_at`, `updated_at`

### agents
- `id` (uuid, PK), `company_id` (uuid, FK → companies), `name` (text), `role` (text, default 'general')
- `title` (text), `icon` (text), `status` (text, default 'idle')
- `reports_to` (uuid, FK → agents.id)
- `capabilities` (text), `adapter_type` (text, default 'process')
- `adapter_config` (jsonb), `runtime_config` (jsonb)
- `budget_monthly_cents`, `spent_monthly_cents`, `pause_reason`, `paused_at`, `permissions` (jsonb)
- `last_heartbeat_at` (timestamptz), `metadata` (jsonb)
- `created_at`, `updated_at`

SQL migration is ready at `tmp/knowledgeforge-import.sql`.
