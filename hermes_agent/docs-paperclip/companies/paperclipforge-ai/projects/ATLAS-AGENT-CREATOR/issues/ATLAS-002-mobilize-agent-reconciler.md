---
issue_id: ATLAS-002
title: Mobilize Agent Reconciler (Recon)
description: >
  Activate the paperclipforge-ai-agent-reconciler agent to perform a full
  reconciliation of all filesystem agents against the database (agents,
  agent_models, agent_api_keys). Ensure funky human names <23 chars,
  naming conventions are maintained, and SQL fixes are generated via
  collaboration with Database Druid and SQL experts.
status: todo
priority: high
created: 2026-04-24
owner: paperclipforge-ai-agent-reconciler
assignee: paperclipforge-ai-agent-reconciler
tags:
  - agent-reconciliation
  - database-audit
  - sql-generation
  - naming-conventions
  - funky-human-names
---

# ATLAS-002: Mobilize Agent Reconciler (Recon)

## Overview

The Paperclip ecosystem currently has a significant discrepancy between filesystem agent definitions and database registrations. Based on the latest reconciliation run:

- **Filesystem agents**: 496
- **Database agents**: 548
- **Missing in DB**: 344 agents present in filesystem but not registered
- **Extra in DB**: 402 agents in database with no filesystem definition
- **Without API keys**: 84
- **Without model assignments**: 159
- **Invalid names (≥23 chars)**: 70

This issue mobilizes the newly created **Recon** agent (`paperclipforge-ai-agent-reconciler`) to systematically audit, report, and generate fixes for these discrepancies.

## Agent Under Mobilization

| Field | Value |
|-------|-------|
| **Agent Slug** | `paperclipforge-ai-agent-reconciler` |
| **Funky Human Name** | `Recon` |
| **Company** | PaperclipForge AI |
| **Team** | Operations |
| **Reports To** | `paperclipforge-ai-operations-director` |
| **Skill** | `agent-reconciliation` |

## Mission Objectives

### 1. Full Filesystem Audit
- [ ] Scan all `docs-paperclip/companies/*/agents/**/AGENTS.md`
- [ ] Parse YAML frontmatter for each agent
- [ ] Extract: `name`, `slug`, `reportsTo`, `team`, `skills`
- [ ] Record directory names for naming convention validation

### 2. Database State Query
- [ ] Query `companies` table → map slug to `id`
- [ ] Query `agents` table → all rows
- [ ] Query `agent_models` table → active assignments
- [ ] Query `agent_api_keys` table → all keys
- [ ] Cross-reference filesystem vs database

### 3. Reconciliation Analysis
- [ ] Identify missing agents (in FS, not DB)
- [ ] Identify extra agents (in DB, not FS)
- [ ] Identify agents without API keys
- [ ] Identify agents without model assignments
- [ ] Identify invalid funky human names (≥23 chars)
- [ ] Identify naming convention violations

### 4. SQL Fix Generation
- [ ] Collaborate with **Database Druid** (`paperclipforge-ai-database-druid`) for schema-aware SQL
- [ ] Generate INSERT statements for missing agents
- [ ] Generate INSERT statements for missing model assignments
- [ ] Generate INSERT statements for missing API keys
- [ ] Generate UPDATE statements for invalid names
- [ ] Generate UPDATE statements for broken hierarchies
- [ ] Save all SQL to `reconciliation_fixes.sql`

### 5. Naming Convention Enforcement
- [ ] Ensure all `name` fields are <23 characters
- [ ] Ensure all `name` fields contain only valid characters
- [ ] Ensure all directories follow `{company-slug}-{AgentName}`
- [ ] Ensure all agent files are named `AGENTS.md`

### 6. Validation & Reporting
- [ ] Save JSON report to `reconciliation_report.json`
- [ ] Print company-by-company summary
- [ ] Verify math: DB count - FS count = extra - missing
- [ ] Report remaining discrepancies after fixes

## Collaboration Plan

### Database Druid (SQL Expert)
- **When engaged**: For complex schema queries and SQL optimization
- **Input**: Required operations, table names, constraints
- **Output**: Validated, optimized SQL statements

### Atlas (Agent Creator)
- **When engaged**: For creating new agents from filesystem definitions
- **Input**: Agent definition from AGENTS.md
- **Output**: Properly formatted agent creation SQL

### Model Assignment Specialist
- **When engaged**: For assigning default models to new agents
- **Input**: Agent ID, company context
- **Output**: `agent_models` INSERT statements

## Reference Documents

- **Paperclip Teams Cross Reference**: `docs-paperclip/companies-teams/Paperclip_Teams_Cross_Reference.md`
- **Agent Reconciliation Script**: `reconciliation_agent.py`
- **Previous SQL Fixes**: `reconciliation_fixes.sql`
- **Previous Report**: `reconciliation_report.json`
- **SQL Generation Procedure**: `docs-paperclip/procedures/database/sql-generation-procedure.md`

## Success Criteria

- [ ] 100% of filesystem agents audited
- [ ] All missing agents have generated INSERT SQL
- [ ] All agents without API keys have generated INSERT SQL
- [ ] All agents without models have generated INSERT SQL
- [ ] All invalid names have generated UPDATE SQL
- [ ] All naming convention violations documented
- [ ] Math check passes: DB - FS = extra - missing
- [ ] SQL output is idempotent (safe to re-run)

## Definition of Done

- [ ] `reconciliation_fixes.sql` generated with all fixes
- [ ] `reconciliation_report.json` generated with full report
- [ ] Console summary printed with per-company breakdown
- [ ] Database Druid consulted for SQL validation
- [ ] All generated names are <23 characters
- [ ] All generated SQL uses `WHERE NOT EXISTS` for idempotency

---

**Issue ID**: ATLAS-002
**Priority**: High
**Created**: 2026-04-24
**Owner**: paperclipforge-ai-agent-reconciler
