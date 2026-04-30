---
title: KnowledgeForge Agent Memory Management
date: 2026-04-06
status: **Implemented (Phase 1)**
---

# KnowledgeForge Agent Memory Management

> **Cross-reference:** See the unified knowledge architecture at [KNOWLEDGE-ARCHITECTURE.md](../companies/knowledgeforge-ai/KNOWLEDGE-ARCHITECTURE.md) for the complete picture.

## Memory Architecture Overview

KnowledgeForge agents use a **3-layer memory model** (simplified from the original 5-layer A-E proposal). The layers are:

| Layer | Name | Purpose | Read/Write | Example |
|-------|------|---------|------------|---------|
| 1 | **Reference** | Durable, read-only knowledge that defines how things work | **Read-only** | `disciplines/`, `disciplines-non/`, `standards/` |
| 2 | **Working** | Active project knowledge that changes as work progresses | **Write** | `para/projects/`, `para/areas/`, `disciplines/*/agent-data/` |
| 3 | **Session** | Conversation context and daily memory that expires or is archived | **Write, archive** | `memory/YYYY-MM-DD.md`, in-context conversation |

This simplified model replaces the original labels (A=Session, B=LCM, C=PARA, E=Durable Knowledge). The YAML frontmatter tags (`memory_layer`, `gigabrain_tags`, `last_updated`) on existing documents remain valid and are used by the knowledge index for discovery.

> **Note:** The 5-layer A-E naming was conceptually correct but academically labeled. The 3-layer model (Reference, Working, Session) expresses the same structure in operational terms that agents can reason about directly.

## How KnowledgeForge Agents Add and Remove Memory

### 1. Adding Memory (Write Operations)

#### Daily Memory File (`memory/YYYY-MM-DD.md`)
- **What:** Each agent appends findings, decisions, and task summaries to the daily file.
- **Who:** All KnowledgeForge agents.
- **Format:** Bullet-point entries under section headers matching the agent's role.
- **Example:**
  ```md
  ## KnowledgeForge QA Strategist
  - Reviewed PR #1234; generated 15 new unit tests for `src/gateway/`
  - Found cross-discipline conflict: procurement workflow breaks safety checklist ordering
  - Flagged for KnowledgeForge Cross-Discipline Guardian review
  ```
- **Frequency:** Append to current day's file; new file created daily.

#### PARA Directory Updates (`para/projects/`, `para/areas/`)
- **What:** New project areas, resource links, and cross-references.
- **Who:** KnowledgeForge Discipline Strategist, KnowledgeForge Arch Refactorer.
- **Format:** Markdown files with PARA frontmatter.
- **Example:** A new agent creates `para/projects/safety-procurement-integration/` when a task spans two disciplines.

#### Discipline File Updates (discipline agents)
- **What:** Discipline specialists never modify existing discipline files (they are read-only canonical knowledge). Instead they create **supplement files** in the discipline directory:
  - `disciplines/[code]/agent-data/findings/` — analysis results
  - `disciplines/[code]/agent-data/decisions/` — documented rationale
  - `disciplines/[code]/agent-data/tasks/` — task tracking

### 2. Removing Memory (Pruning Operations)

#### Session Memory (In-Context)
- **What:** The conversation context buffer.
- **How:** Truncated per session when context window approaches limits. Oldest conversation turns are discarded first. Recent turns preserved.
- **Who:** All agents (automatic via LLM context management).

#### Daily Memory File Pruning
- **What:** Older `memory/YYYY-MM-DD.md` files.
- **How:** After N days (configurable, e.g., 90), files are archived to `memory/archive/` and summarized into `memory/quarterly-summary.md`.
- **Who:** `KnowledgeForge Failure Learner` — responsible for archiving and summarizing old daily memory.

#### PARA Stale Entry Cleanup
- **What:** Completed projects and obsolete resource entries.
- **How:** When a project status changes to `done`, KnowledgeForge Doc Analyzer moves it from `para/projects/` to `para/resources/completed/` and creates a one-page summary.
- **Who:** `KnowledgeForge DocAnalyzer`.

#### Supplement File Cleanup (Discipline Agent Findings)
- **What:** Agent-generated findings/decisions/tasks in discipline directories.
- **How:** `KnowledgeArchive App Guardian` enforces a retention policy:
  - Findings older than 30 days → archive
  - Duplicate findings (same issue referenced) → deduplicate
  - Resolved tasks → move to `tasks/completed/`
- **Who:** `KnowledgeForge App Guardian` for enforcement, `KnowledgeForge Failure Learner` for execution.

### 3. Memory Sharing Between Agents

#### Shared Knowledge Store
All KnowledgeForge agents share access to the same `paras/` and `memory/` directories. An entry added by one agent is visible to all others.

#### Cross-Agent Memory Handoff
When a task requires multiple agents (e.g., QA Strategist finds an issue → Arch Refactorer proposes fix → Cross-Discipline Guardian approves):
1. QA Strategist writes finding to `memory/YYYY-MM-DD.md` AND creates `paras/projects/[issue-slug]/` with context.
2. Cross-Discipline Guardian reads `para/projects/[issue-slug]/`, adds analysis, and marks decision.
3. Arch Refactorer reads the project folder, implements fix, updates project status to `done`.
4. App Guardian archives completed project.

## KnowledgeForge Agent Memory Responsibilities

| Agent | Write To | Prune Archive From |
|-------|----------|--------------------|
| **KnowledgeForge DocAnalyzer** | `para/resources/` (new resource entries), `disciplines/[code]/agent-data/` (doc analysis results) | Old `memory/` files → summaries |
| **KnowledgeForge QA Strategist** | `memory/YYYY-MM-DD.md` (QA findings), `para/projects/` (QA project folders) | — |
| **KnowledgeForge Arch Refactorer** | `para/projects/` (refactor proposals), `disciplines/[code]/agent-data/decisions/` (rationale) | — |
| **KnowledgeForge Failure Learner** | `disciplines/[code]/agent-data/findings/` (failure analysis) | `memory/archive/` (daily files), resolved tasks |
| **KnowledgeForge ClieNT Integrator** | `para/resources/` (integration notes), `disciplines/[code]/agent-data/` (task history) | — |
| **KnowledgeForge App Guardian** | `disciplines/[code]/agent-data/tasks/` (policy compliance tasks) | Old supplement files → archive |
| **KnowledgeForge Discipline Strategist** | `para/projects/` (cross-discipline project creation) | — |
| **KnowledgeForge Cross-Discipline Guardian** | `para/projects/` (conflict analysis), `memory/` (conflict reports) | — |
| **KnowledgeForge Workflow Guardian** | `memory/` (workflow integrity reports) | — |
| **KnowledgeForge Sector Analyst** | `memory/` (sector analysis reports) | — |
| **KnowledgeForge Sector QA Lead** | `memory/` (sector QA reports) | — |

## Persistence Setting (Paperclip `persistSession`)

All KnowledgeForge agents use `persistSession: true` in their adapter config. This means:
- **Conversation history is persisted** across sessions — if an agent is interrupted and resumed, it picks up where it left off.
- **Memory files are not session-scoped** — they are persistent disk files.
- **The difference:** session persistence keeps the conversation state; memory files keep the knowledge.

## What Happens When Knowledge Exceeds Limits

### Scenario 1: Daily Memory File Too Large
- Each daily file is limited to ~100 entries. When exceeded, a new file `YYYY-MM-DD-part2.md` is created.
- `KnowledgeForge Failure Learner` monitors file sizes and triggers archiving.

### Scenario 2: PARA Project Directory Proliferation
- Limit: 50 active `para/projects/` folders at any time.
- When limit reached, `KnowledgeForge DocAnalyzer` prioritizes by urgency, completes lowest-priority projects by archiving them first.

### Scenario 3: Discipline Supplement File Proliferation
- Each discipline agent's `agent-data/` directory is limited to 200 files.
- When exceeded, `KnowledgeForge App Guardian` enforces dedup: group related files, create consolidated reports, archive originals.

## Summary

KnowledgeForge agents follow a **write-once-daily, archive-on-schedule** discipline:
- **Add to memory:** Write to `memory/YYYY-MM-DD.md` and `para/projects/` with structured frontmatter.
- **Delete from memory:** Archive old daily files (>30 days), deduplicate supplement files, mark completed projects as done.
- **No destructive edits:** Discipline files in `disciplines/` are read-only. All agent additions go to `agent-data/` subdirectories.
- **Cross-agent collaboration:** Shared `para/projects/` folders serve as handoff points.