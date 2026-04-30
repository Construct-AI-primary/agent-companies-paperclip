---
title: Agent Companies Repository Restructure Plan
description: Plan to split the current paperclip-render repo into three repos (agent-companies-core, agent-companies-paperclip, agent-companies-openclaw) separating platform-agnostic domain knowledge from platform-specific orchestration layers
author: Paperclip Render / Construct AI
date: 2026-04-30
status: phase-1-complete
version: 1.1
related_docs:
  - docs-paperclip/reports/2026-04-29-ui-ux-specification-projects-report.md
  - docs-paperclip/companies-teams/Paperclip_Teams_Cross_Reference.md
  - docs-paperclip/companies/README.md
  - docs-paperclip/companies/companies-spec.md
  - docs-construct-ai/AGENTS.md
  - docs-construct-ai/para/README.md
  - docs-construct-ai/disciplines/01900_procurement/1900_README.MD
  - docs-paperclip/disciplines/01900-procurement/projects/PROC-ORDER/orchestration/OVERVIEW.md
---

# Agent Companies Repository Restructure Plan

## Overview

The current `paperclip-render` repository contains a mixture of platform-agnostic domain knowledge (agent definitions, skills, discipline workflows, templates, PARA knowledge base) and platform-specific orchestration artifacts (Paperclip API configurations, Hermes runtime docs, Paperclip board workflows, SQL scripts). As we migrate from Paperclip to OpenClaw while preserving the ability to return to Paperclip later, we need to split this into three independent repos:

| Repo | Purpose | Supabase | Status |
|------|---------|----------|--------|
| `agent-companies-core` | Platform-agnostic knowledge (agents, skills, domain knowledge, issues, specs, PARA) | Supabase A (Domain data) | ✅ DONE |
| `agent-companies-paperclip` | Paperclip + Hermes orchestration (preserved as-is) | Supabase B (Paperclip) | 📋 NEXT |
| `agent-companies-openclaw` | OpenClaw orchestration (new active development) | Supabase C (OpenClaw, new) | 📋 PLANNED |

---

## Phase 1: Create agent-companies-core ✅ DONE (2026-04-30)

### Repository

- **URL**: https://github.com/Construct-AI-primary/agent-companies-core
- **Commit**: `d3fb79d` — Initial import
- **Size**: 62 MB, 4,595 files, 1,514,345 lines
- **Structure**:

```
agent-companies-core/
├── companies/         COMPANY.md (16), TEAM.md (29)
├── agents/            AGENTS.md (419)
├── skills/            per-company SKILL.md (1,038), shared SKILL.md (85)
├── domain-knowledge/
│   ├── disciplines/           50+ engineering/commercial domains
│   ├── shared-disciplines/    bidding, engineering, measurement, SaaS, testing, voice
│   ├── organisations/         GPC, Zama client knowledge
│   └── disciplines-non/       travel, timesheets
├── projects/          ~70 project charters + ~479 issue descriptions
├── specs/             78 UI-UX spec files
├── cross-reference/   Deduplicated teams/rosters (2 files)
├── para/              Full PARA knowledge base (~11k files)
└── README.md
```

### Submodule Registration

Registered in `paperclip-render` `.gitmodules` as `agent-companies-core` pointing to `https://github.com/Construct-AI-primary/agent-companies-core.git`.

### Migration Script

`scripts/restructure/01-copy-to-core.sh` — can be re-run to sync changes.

---

## What Remains

See original plan sections 2-5 for phases 2 and 3 (Paperclip preservation, OpenClaw creation, validation pilot). These are unchanged.

---

## Known Gaps (from original analysis)

| # | Gap | Severity | Status |
|---|-----|----------|--------|
| 1 | Dual documentation (`docs-construct-ai/` vs `docs-paperclip/`) with overlapping procurement data | Critical | Resolved — both now in core |
| 2 | PROC-ORDER orchestration coupled to PaperclipForge AI agents, Paperclip API, Hermes adapter | Critical | Unresolved — blocked on Phase 3 |
| 3 | All 26 PROC-ORDER issues at 0% (pending/blocked since Apr 12) | High | Unresolved — blocked on OpenClaw |
| 4 | Apr 29 report references OpenClaw — orchestration docs still reference Paperclip | High | Unresolved — blocked on Phase 3 |
| 5 | PROC-001 trigger is a 44-line stub with no automation logic | Medium | Unresolved — blocked on Phase 3 |
| 6 | Duplicate cross-reference files (2 copies, will drift) | Medium | Resolved — deduped in core |
| 7 | Issue format inconsistency — PROC-ORDER lacks structured frontmatter | Medium | Unresolved — across all issues |
| 8 | No knowledge-to-issue traceability links | Medium | Unresolved |
| 9 | No standalone Hermes repo use case (keep with Paperclip) | Low | Resolved — Hermes stays with Paperclip |

---

## Supabase Split Summary

| Supabase Project | Purpose | Connected To |
|-----------------|---------|-------------|
| A (Domain) | Domain data — shared across platforms | `agent-companies-core` |
| B (Paperclip) | Paperclip orchestration data | `agent-companies-paperclip` |
| C (OpenClaw) | OpenClaw orchestration data | `agent-companies-openclaw` |

---

## Success Criteria

- [x] `agent-companies-core` created and published as public GitHub repo
- [x] Submodule registered in paperclip-render
- [x] All platform-agnostic agents, skills, domain knowledge, projects, specs, PARA in core
- [x] Cross-reference files deduplicated to one canonical copy in core
- [ ] `agent-companies-paperclip` references core via submodule and adds Paperclip-specific orchestration
- [ ] `agent-companies-openclaw` references core via submodule and adds OpenClaw-specific orchestration
- [ ] PROC-ORDER orchestration rewritten for OpenClaw
- [ ] PROC-001 trigger rewritten with real automation logic
- [ ] PROCURE-TEST validation pilot passes
- [ ] All 70 projects / 479 issues mapped to OpenClaw execution

---

## Document Control

| Field | Value |
|-------|-------|
| **Author** | Paperclip Render / Construct AI |
| **Date** | 2026-04-30 |
| **Version** | 1.1 |
| **Status** | Phase 1 Complete |