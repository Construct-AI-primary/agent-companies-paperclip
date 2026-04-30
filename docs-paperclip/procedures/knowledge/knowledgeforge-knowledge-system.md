---
title: KnowledgeForge Knowledge System Procedure
date: 2026-04-06
status: **Implemented (Phase 1)**
scope: KnowledgeForge company setup, deployment, and maintenance
---

# KnowledgeForge Knowledge System Procedure

> **Cross-reference:** See the unified knowledge architecture at [KNOWLEDGE-ARCHITECTURE.md](../companies/knowledgeforge-ai/KNOWLEDGE-ARCHITECTURE.md) for the complete picture, and [2026-04-06-knowledgeforge-implementation.md](../plans/2026-04-06-knowledgeforge-implementation.md) for the implementation plan.

## Purpose

This procedure documents the setup, deployment, and ongoing maintenance of the KnowledgeForge company within Paperclip — the institutional memory and QA automation layer for the Construct-AI codebase, engineering disciplines, and associated knowledge.

## Scope

### Phase 1 (Current): 11 Core Agents
- Doc Analyzer, QA Strategist, Arch Refactorer, App Guardian
- Workflow Guardian, Discipline Reader, Standards Keeper
- Memory Manager, Integration Monitor, Error Tracker, Failure Learner

### Future Phases (Only If Needed)
- Discipline specialists (start with top 4: procurement, safety, logistics, contracts)
- Non-discipline specialists (consolidated into 3 agents)

## Prerequisites

1. Paperclip instance running with `agentcompanies` support
2. `docs-construct-ai/` knowledge base accessible (50+ discipline directories)
3. Knowledge index built and up to date (`docs-construct-ai/KNOWLEDGE-INDEX.json`)
4. Database with `companies`, `agents`, and `goals` tables (Drizzle schema)
5. Hermes agent runtime available (`hermes_local` adapter type)
6. OpenRouter API key configured for `openrouter/qwen/qwen3.6-pro`

## Phase 1 Procedure: 11 Core Agents

### Step 1: Build the Knowledge Index

Before importing agents, ensure the knowledge index is current:

```sh
cd docs-construct-ai
python3 scripts/build-knowledge-index.py --root . --output KNOWLEDGE-INDEX.json
```

This indexes all 2,900+ markdown files with discipline codes, workflow procedures, and frontmatter tags. Verify:
```
Total documents: 2900+
Disciplines: 67
Workflows: 17
```

### Step 2: Import the KnowledgeForge Company

```sh
# From paperclip-render root
psql $DATABASE_URL < tmp/knowledgeforge-import.sql
```

Verify the 11 core agents are present:
```sql
SELECT a.name, a.role, a.reports_to
FROM agents a
WHERE a.company_id = (SELECT id FROM companies WHERE name = 'KnowledgeForge AI')
ORDER BY a.reports_to, a.name;
-- Expected: 11 agents
```

### Step 3: Configure Agent Knowledge Sources

Each KnowledgeForge agent reads from specific directories in `docs-construct-ai/`:

| Agent | Knowledge Source Directories |
|-------|------------------------------|
| Doc Analyzer | `codebase/`, `documentation/`, all directories (index builder) |
| QA Strategist | `testing/`, `standards/` |
| Arch Refactorer | `codebase/architecture/`, `codebase/procedures/` |
| App Guardian | `standards/`, `error-tracking/`, `codebase/security/` |
| Workflow Guardian | `disciplines/*/workflow_docs/` |
| Discipline Reader | `disciplines/*/`, `disciplines/*/agent-data/` |
| Standards Keeper | `standards/` |
| Memory Manager | `memory-integration/`, `memory/`, `para/` |
| Integration Monitor | `integration/`, `implementation/` |
| Error Tracker | `error-tracking/` |
| Failure Learner | `error-tracking/`, `testing/`, `memory/archive/` |

**Action:** Configure each agent's `knowledge_dirs` in `adapter_config` to point to the correct directories.

### Step 4: Configure Memory Integration

KnowledgeForge uses the 3-layer memory model:

| Layer | Purpose | Storage | Read/Write |
|-------|---------|---------|------------|
| **Reference** | Durable, read-only knowledge | `disciplines/`, `standards/`, `codebase/` | Read-only |
| **Working** | Active project knowledge | `para/projects/`, `para/areas/`, `disciplines/*/agent-data/` | Write |
| **Session** | Conversation context | `memory/YYYY-MM-DD.md`, in-context buffer | Write, archive |

**Setup:**
```sh
cd docs-construct-ai
mkdir -p memory
mkdir -p para/{projects,areas,resources,pages}
```

**Agent responsibilities:**
- All agents append findings to `memory/YYYY-MM-DD.md` (daily, structured by agent role)
- Cross-agent tasks create `para/projects/[slug]/` handoff folders
- `KnowledgeForge Failure Learner` archives files older than 90 days to `memory/archive/`
- `KnowledgeForge Doc Analyzer` moves completed projects to `para/resources/completed/`

### Step 5: Set Agent Adapter Configuration

All 11 Phase 1 agents use the same adapter configuration:

```json
{
  "adapter_type": "hermes_local",
  "adapter_config": {
    "model": "openrouter/qwen/qwen3.6-pro",
    "maxIterations": 50,
    "persistSession": true
  },
  "runtime_config": {
    "persistSession": true
  }
}
```

### Step 6: Smoke Test

Run a smoke test against a single discipline:

1. Create a test task in Paperclip UI
2. Assign to `KnowledgeForge Doc Analyzer`
3. Task: "Rebuild the knowledge index and report any errors"
4. Verify:
   - Agent runs `build-knowledge-index.py` successfully
   - Index contains 2,900+ documents
   - No encoding errors reported
   - Results written to `memory/YYYY-MM-DD.md`

### Step 7: Smoke Test — Discipline Knowledge

1. Create a test task in Paperclip UI
2. Assign to `KnowledgeForge Discipline Reader`
3. Task: "Read and summarize the 01900 Procurement discipline"
4. Verify:
   - Agent reads from `disciplines/01900_procurement/`
   - Agent finds and reads `workflow_docs/` files
   - Response references actual discipline content (not hallucinated)
   - Findings written to `memory/YYYY-MM-DD.md`

### Step 8: Enable Automated QA Loop

Configure the QA review-loop workflow:

1. `KnowledgeForge QA Strategist` is triggered on pull request
2. Reads PR changes, generates QA test plan from `testing/` discipline
3. Runs tests (or delegates to test runner skill)
4. Writes findings to `memory/YYYY-MM-DD.md` and `para/projects/[pr-number]/`
5. `KnowledgeForge Cross-Discipline Guardian` reviews for cross-discipline conflicts
6. `KnowledgeForge App Guardian` verifies compliance with app policies
7. Decision: merge / request changes / block

## Maintenance

### Daily
- All agents append findings to `memory/YYYY-MM-DD.md`
- Doc Analyzer runs knowledge index rebuild if new docs detected
- New `para/projects/` created for cross-agent tasks

### Weekly
- `KnowledgeForge Failure Learner` reviews memory file sizes, triggers archiving if >100 entries/day
- `KnowledgeForge Doc Analyzer` reviews index coverage, flags documents missing frontmatter

### Monthly
- `KnowledgeForge Doc Analyzer` reviews `para/projects/` for stale entries
- Completed projects moved to `para/resources/completed/` with summary
- Rebuild KNOWLEDGE-INDEX.json and review stats for growth trends

### Quarterly
- `KnowledgeForge Failure Learner` archives `memory/YYYY-MM-DD.md` files older than 90 days
- Creates `memory/quarterly-summary-YYYYQn.md`
- `KnowledgeForge Chat History Index` updated with summaries from `chat-history-index/`

### As Needed
- New discipline added to `disciplines/` → Doc Analyzer picks it up on next index rebuild
- New `workflow_docs/` added → Workflow Guardian reads them on next cycle
- Knowledge index script updated → rerun `build-knowledge-index.py` to regenerate

## Rollback

If the KnowledgeForge company import fails or causes issues:

```sql
-- Delete all KnowledgeForge data
DELETE FROM goals WHERE company_id = (SELECT id FROM companies WHERE name = 'KnowledgeForge AI');
DELETE FROM agents WHERE company_id = (SELECT id FROM companies WHERE name = 'KnowledgeForge AI');
DELETE FROM companies WHERE name = 'KnowledgeForge AI';
```

Re-run import:
```sh
psql $DATABASE_URL < tmp/knowledgeforge-import.sql
```

## Files Reference

| File | Purpose |
|------|---------|
| `docs-paperclip/companies/knowledgeforge-ai/KNOWLEDGE-ARCHITECTURE.md` | **Unified knowledge architecture (source of truth)** |
| `docs-paperclip/plans/2026-04-06-knowledgeforge-implementation.md` | Implementation plan |
| `docs-paperclip/plans/2026-04-06-knowledgeforge-enhanced-org-chart.md` | Org chart (proposed 66-agent structure) |
| `docs-paperclip/plans/2026-04-06-knowledgeforge-non-discipline-consolidation.md` | Consolidation analysis |
| `docs-paperclip/plans/2026-04-06-knowledgeforge-memory-management.md` | Memory architecture |
| `docs-paperclip/companies/knowledgeforge-ai/` | Company package directory |
| `docs-construct-ai/scripts/build-knowledge-index.py` | Knowledge index builder |
| `docs-construct-ai/KNOWLEDGE-INDEX.json` | Generated knowledge index |
| `docs-construct-ai/disciplines/` | 50+ discipline knowledge directories |
| `docs-construct-ai/disciplines-non/` | Non-discipline directories |
| `tmp/knowledgeforge-import.sql` | KnowledgeForge company import (11 core + specialists) |
| `tmp/update-all-agents-to-hermes-local.sql` | **Universal migration: all agents → hermes_local + qwen/qwen3.6-pro** |
