---
title: KnowledgeForge Enhanced Organization Chart
date: 2026-04-06
status: proposed
revision: 2 — consolidated to 66 agents
---

# KnowledgeForge Enhanced Organization Chart (66 agents)

## Overview

KnowledgeForge has **66 agents** organized into a hierarchical structure:
- **12 Core Agents** — coordination, QA, and institutional memory
- **51 Discipline Specialists** — one agent per engineering/construction discipline (50 + Administration)
- **3 Non-Discipline Specialists** — consolidated from 36 thin stubs

Consolidation analysis: [2026-04-06-knowledgeforge-non-discipline-consolidation.md](./2026-04-06-knowledgeforge-non-discipline-consolidation.md)

## Organization Structure

- KnowledgeForge CEO (reports to Board)
  - Knowledge Engineering Team
    - Doc Analyzer (team lead) — reads `codebase/`, `documentation/`
    - QA Strategist — reads `testing/`, `ci/`
    - Arch Refactorer — reads `codebase/architecture/`
    - Failure Learner — reads `testing/failures/`, `error-tracking/`
    - ClieNT Integrator — reads `codebase/agents/`, `hermes_agent/`
    - App Guardian — reads `standards/`, `codebase/security/`
  - Discipline Operations Team
    - Discipline Strategist (team lead) — reads `disciplines/*`
    - Cross-Discipline Guardian — reads `disciplines/CROSS-DISCIPLINE.md`
    - Workflow Guardian — reads `disciplines/*/workflow_docs/`
  - Sector Analysis Team
    - Sector Analyst (team lead)
    - Sector QA Lead
  - Discipline Specialists (51) — report to Discipline Strategist
    - Engineering (7): Mechanical, Civil, Electrical, Chemical, Process, Geotechnical, Developer
    - Design & Architecture (2): Architectural, Design
    - Commercial & Contracts (4): Commercial, Contracts, Contracts Pre-Award, Contracts Post-Award
    - Construction & PM (4): Construction, Construction Director, Projects Director, Director Project
    - Directors & Leadership (9): Directors, Board of Directors, Engineering Director, HSE Director, Logistics Director, Sales Director, Procurement Director, Finance Director
    - Support (23): Document Control, Environmental, Ethics, Finance, Governance, Health, Local Content, Logistics, Legal, Other Parties, Procurement, Project Controls, Quantity Surveying, Scheduling, **Information Technology** (293 files), Inspection, Public Relations, Quality Assurance, Quality Control, Safety, Security, Landscaping, **Administration** (new)
    - Sales & Sundry (2): Sales, Sundry
  - Non-Discipline Specialists (3) — report to Sector Analyst
    - Home & Login (`home-login`) — absorbs: `home`, `user-login`, `password-reset`
    - Auth Flow (`auth-flow`) — absorbs: `auth-callback` (9 files)
    - User Signup (`user-signup`) — absorbs: `user-signup`, `user-management`

## Agent Count Summary

| Category | Count | Notes |
|----------|-------|-------|
| Core Agents (CEO + 3 teams) | 12 | Unchanged |
| Discipline Specialists | 51 | 50 existing + 1 new (Administration) |
| Non-Discipline Specialists | 3 | Consolidated from 36 (92% reduction) |
| **Total** | **66** | Down from 98 (−32 agents) |

## Knowledge Sources per Agent Type

| Agent Type | Primary Knowledge Source |
|------------|-------------------------|
| Core Agents | All knowledge sources (coordination) |
| Discipline Specialists | `disciplines/[code]/agent-data/domain-knowledge/` |
| Information Technology | `disciplines/02050_information-technology/` (293 files — absorbs 33 thin stubs) |
| Administration | `disciplines-non/00102-administration/` + `disciplines/02050_information-technology/` |
| Non-Discipline (3) | `disciplines-non/[code]/` (only 3 directories with unique content) |

## Consolidation Details

### Why 3 Non-Discipline Agents (Not 36)

The `disciplines/02050_information-technology` directory has 293 files covering: modals, chatbot, agent platform, email, settings, error tracking, monitoring, contributor hub, timesheets, training pipeline, LangGraph, etc. All 33 other non-discipline directories are thin UI page stubs whose knowledge already exists in the IT discipline.

Only 3 non-discipline directories contain unique knowledge not already in a discipline:
- `00100-home` + `00100-user-login` + `00175-password-reset` → **KF Home & Login**
- `00175-auth-callback` (9 files) → **KF Auth Flow**
- `00150-user-signup` (6 files) + `00155-user-management` → **KF User Signup**

### Administration Moved to Disciplines

`00102-administration` is now a **discipline specialist** agent (not non-discipline), reading from both the IT discipline directory and the admin non-discipline directory. Privacy settings are included in this consolidated agent.

## Implementation Notes

1. **Core agents** use `hermes_local` adapter with `claude-sonnet-4.5`
2. **Discipline specialists** use `hermes_local` adapter, each reads their specific discipline knowledge
3. **Non-discipline specialists** use `hermes_local` adapter with `persistSession: true`
4. Discipline specialists report to Discipline Strategist
5. Non-discipline specialists report to Sector Analyst
6. SQL migration: `tmp/knowledgeforge-import.sql`