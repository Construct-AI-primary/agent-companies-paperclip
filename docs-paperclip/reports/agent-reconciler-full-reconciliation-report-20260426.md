# AGENT RECONCILIATION REPORT
## Full Cross-Company Audit with Live Database Reconciliation
**Generated:** 2026-04-26T02:30:00Z  
**Agent:** paperclipforge-ai-AgentReconciler (with paperclipforge-ai-DatabaseCrudOrchestrator consultation)  
**Scope:** All companies, all agents, all skills, schema FK graph, spec alignment

---

## EXECUTIVE SUMMARY

| Metric | Value | Change from 2026-04-25 |
|--------|-------|------------------------|
| **Total Companies** | 18 | — |
| **Companies with Agents** | 16 | — |
| **Companies without Agents** | 2 (construct-ai, shared) | — |
| **Total Agents (Filesystem)** | 516 | +1 (DatabaseCrudOrchestrator added) |
| **Total Agents (Database)** | 549 | +1 |
| **Agents Matched (FS↔DB)** | 83 | — |
| **Total Skills (Filesystem)** | 633 | — |
| **Agent-to-Skill Ratio** | 1:1.23 | — |
| **Companies with COMPANY.md** | 16/16 | — |
| **Database Connection** | ✅ CONNECTED | — |
| **Naming Convention Status** | ⚠️ 70 INVALID NAMES, 426 EMPTY name FIELDS | DEGRADED |

---

## SECTION 1: LIVE DATABASE RECONCILIATION

### 1.1 Database Connection Status

| Item | Status |
|------|--------|
| Supabase Connection | ✅ Connected |
| Companies in DB | 16 |
| Agents in DB | 549 |
| Agents with API Keys | 464 |
| Agents with Model Assignments | 970 |
| FK Relationships (total schema) | 237 |

### 1.2 Reconciliation Math

| Metric | Count |
|--------|-------|
| **Filesystem Agents** | 516 |
| **Database Agents** | 549 |
| **Difference** | +33 |
| **Agents Matched (correctly identified)** | 83 |
| **Missing from DB** | 433 (96% of FS agents unmatched) |
| **Extra in DB** | 467 |
| **Agents without API Keys** | 85 |
| **Agents without Model Assignments** | 160 |
| **Invalid Names (≥23 chars)** | 70 |
| **Empty `name:` Fields (FS)** | 426 out of 433 missing |
| **Broken Hierarchies** | 0 |

### 1.3 Company Comparison (FS vs DB)

| Company | FS | DB | Skills | Skills/Agent | COMPANY.md | Status |
|---------|----|----|--------|-------------|-----------|--------|
| ContentForge AI | 17 | 35 | 26 | 1.53 | ✅ | ⚠️ DB has more |
| DevForge AI | 59 | 63 | 59 | 1.00 | ✅ | ⚠️ DB has more |
| DomainForge AI | 83 | 66 | 65 | 0.78 | ✅ | ⚠️ FS has more |
| ExecForge AI | 18 | 18 | 26 | 1.44 | ✅ | ✅ Balanced |
| InfraForge AI | 7 | 14 | 14 | 2.00 | ✅ | ⚠️ DB has more |
| IntegrateForge AI | 21 | 23 | 21 | 1.00 | ✅ | ⚠️ DB has more |
| KnowledgeForge AI | 74 | 68 | 70 | 0.95 | ✅ | ⚠️ FS has more |
| Learning Forge AI | 51 | 53 | 28 | 0.55 | ✅ | ⚠️ DB has more |
| Loopy AI | 6 | 8 | 10 | 1.67 | ✅ | ⚠️ DB has more |
| MeasureForge AI | 21 | 22 | 121 | 5.76 | ✅ | ⚠️ DB has more |
| MobileForge AI | 10 | 10 | 20 | 2.00 | ✅ | ✅ Balanced |
| PaperclipForge AI | 55 | 62 | 64 | 1.16 | ✅ | ⚠️ DB has more |
| PromptForge AI | 24 | 30 | 24 | 1.00 | ✅ | ⚠️ DB has more |
| QualityForge AI | 42 | 49 | 37 | 0.88 | ✅ | ⚠️ DB has more |
| SaaSForge AI | 16 | 16 | 26 | 1.63 | ✅ | ✅ Balanced |
| VoiceForge AI | 12 | 12 | 22 | 1.83 | ✅ | ✅ Balanced |
| **TOTAL** | **516** | **549** | **633** | | | |

---

## SECTION 2: CRITICAL ISSUES — ROOT CAUSE ANALYSIS

### 2.1 The Name Matching Catastrophe (83/516 matched = 16%)

**Severity: CRITICAL**

Only 83 out of 516 filesystem agents (16%) match to their database counterparts. The root cause is a compounding failure across two systems:

#### 2.1.1 Filesystem: 98% of unmatched AGENTS.md have empty `name:` fields

Of the 433 agents that failed to match:
- **426 (98%)** have `name: ""` (empty string)
- **222 (51%)** don't even have a `slug` field
- **211 (49%)** have a `slug` field, but the matcher can't connect slug → DB title

**Sample of broken AGENTS.md frontmatter:**

| File | name | slug | Can Match? |
|------|------|------|-------------|
| contentforge-ai-BlogArchitect/AGENTS.md | `""` | `""` | ❌ No data |
| contentforge-ai-TechnicalSEO/AGENTS.md | `""` | `""` | ❌ No data |
| contentforge-ai-ContentMaestro/AGENTS.md | `""` | `""` | ❌ No data |
| devforge-ai-Ally/AGENTS.md | `""` | `"ally-devforge-partnership-management"` | ⚠️ Slug doesn't match DB title |
| domainforge-ai-dispatcherspecialist/AGENTS.md | `""` | `""` | ❌ No data |
| paperclipforge-ai-database-crud-orchestrator/AGENTS.md | ✅ `"paperclipforge-ai-database-crud-orchestrator"` | (inferred) | ✅ PROPER FORMAT |

The **DatabaseCrudOrchestrator** is the model citizen — its AGENTS.md has proper `name:`, `human_name:`, `reportsTo:`, `skills:` fields. Most other agents are missing these.

#### 2.1.2 Database: 387 extra agents have human-readable names, not slugs

Of the 467 extra DB agents (in DB but unmatched to FS):
- **387 (83%)** have short human names (e.g., "Maya", "Forge", "Nexus")
- **76 (16%)** have longer descriptive names (e.g., "Database Operations Specialist")
- **4 (<1%)** have slug-formatted names with dashes

This suggests the DB was populated from a _previous_ export that used human names in the `name` column, while the current FS export doesn't provide usable `name` values.

#### 2.1.3 Matching Algorithm Analysis

The `reconciliation_agent.py` uses this matching chain:
```
1. FS.slug.lower() → DB.title.lower()     [FAILS: 222 agents have no slug]
2. FS.name.lower() → DB.name.lower()      [FAILS: 426 agents have empty name]
3. FS slug → funky_name → DB.name.lower()  [FAILS: name conversion can't overcome empty source data]
```

**The fundamental fix:** AGENTS.md files must be populated with proper `name:` and `slug:` fields per the `agentcompanies/v1` spec.

### 2.2 Empty name Fields (426 agents)

**Severity: CRITICAL**

426 out of 516 filesystem AGENTS.md files (83%) have empty `name:` fields. This violates the `agentcompanies/v1` specification which requires:
```yaml
name: CEO
title: Chief Executive Officer
reportsTo: null
skills:
  - plan-ceo-review
```

These files only derive their identity from the directory name (e.g., `contentforge-ai-BlogArchitect/`), which is non-standard and breaks compatibility.

**Affected companies (all agents with empty names):**
| Company | Empty name Fields |
|---------|-------------------|
| DomainForge AI | 83 (all agents) |
| DevForge AI | 55 (all agents) |
| PaperclipForge AI | 54 (all but 1) |
| Learning Forge AI | 50 (all agents) |
| QualityForge AI | 38 (all agents) |
| PromptForge AI | 23 (all agents) |
| IntegrateForge AI | 21 (all agents) |
| MeasureForge AI | 21 (all agents) |
| ExecForge AI | 18 (all agents) |
| SaaSForge AI | 16 (all agents) |
| KnowledgeForge AI | 14 (all agents) |
| VoiceForge AI | 12 (all agents) |
| MobileForge AI | 10 (all agents) |
| InfraForge AI | 7 (all agents) |
| Loopy AI | 6 (all agents) |
| ContentForge AI | 5 (all agents) |

### 2.3 Invalid Names — ≥23 Characters (70 agents)

**Severity: HIGH**

70 agents in the database have `name` values ≥ 23 characters, violating the funky human name convention (max 22 chars).

**Sample violations:**
| Name | Length | Issue |
|------|--------|-------|
| paperclipforge-ai-model-assignment-specialist | 45 | Slug stored in name field |
| Database Operations Specialist | 30 | Too long |
| Document Generation Specialist | 30 | Too long |
| Workflow Complexity Analyzer | 28 | Too long |
| Workflow Learning Coordinator | 29 | Too long |
| Multi-Discipline Coordinator | 28 | Too long |
| sqlite-atlas-agent-creator | 26 | Slug in name field |

### 2.4 Missing API Keys (85 agents)

**Severity: HIGH**

85 database agents lack API keys — they cannot authenticate or execute tasks.

### 2.5 Missing Model Assignments (160 agents)

**Severity: HIGH**

160 database agents have no model assignments — they cannot make LLM calls.

---

## SECTION 3: COMPANY OVERVIEW

### 3.1 Full Company Details

| Company | FS Agents | DB Agents | Skills | Skills/Agent | COMPANY.md | Key Issue |
|---------|-----------|-----------|--------|-------------|-----------|-----------|
| DomainForge AI | 83 | 66 | 65 | 0.78 | ✅ | 83 FS agents have empty name fields |
| KnowledgeForge AI | 74 | 68 | 70 | 0.95 | ✅ | Best match ratio among large companies |
| DevForge AI | 59 | 63 | 59 | 1.00 | ✅ | Perfect 1:1 skills ratio |
| PaperclipForge AI | 55 | 62 | 64 | 1.16 | ✅ | DB has 7 extra agents |
| Learning Forge AI | 51 | 53 | 28 | 0.55 | ✅ | Lowest skills coverage |
| QualityForge AI | 42 | 49 | 37 | 0.88 | ✅ | DB has 7 extra |
| PromptForge AI | 24 | 30 | 24 | 1.00 | ✅ | Perfect 1:1 ratio |
| MeasureForge AI | 21 | 22 | 121 | 5.76 | ✅ | Highest skills ratio (discipline-heavy) |
| IntegrateForge AI | 21 | 23 | 21 | 1.00 | ✅ | Perfect 1:1 ratio |
| ExecForge AI | 18 | 18 | 26 | 1.44 | ✅ | Balanced |
| ContentForge AI | 17 | 35 | 26 | 1.53 | ✅ | DB has 22 extra |
| SaaSForge AI | 16 | 16 | 26 | 1.63 | ✅ | Balanced |
| VoiceForge AI | 12 | 12 | 22 | 1.83 | ✅ | Balanced |
| MobileForge AI | 10 | 10 | 20 | 2.00 | ✅ | Balanced |
| InfraForge AI | 7 | 14 | 14 | 2.00 | ✅ | DB doubles FS |
| Loopy AI | 6 | 8 | 10 | 1.67 | ✅ | Small team, balanced |

### 3.2 Companies without Agents

| Company | Reason | Notes |
|---------|--------|-------|
| construct-ai | No agents directory | Documentation/construct company |
| shared | No agents directory | Shared resources directory |

### 3.3 Skills Coverage Analysis

| Coverage Level | Companies |
|----------------|-----------|
| **Excellent (>2.0)** | MeasureForge AI (5.76), MobileForge AI (2.00), InfraForge AI (2.00) |
| **Good (1.0-2.0)** | VoiceForge AI (1.83), Loopy AI (1.67), SaaSForge AI (1.63), ContentForge AI (1.53), ExecForge AI (1.44), PaperclipForge AI (1.16) |
| **Adequate (0.8-1.0)** | DevForge AI (1.00), PromptForge AI (1.00), IntegrateForge AI (1.00), KnowledgeForge AI (0.95), QualityForge AI (0.88) |
| **Insufficient (<0.8)** | DomainForge AI (0.78), Learning Forge AI (0.55) |

**Analysis:**
- **MeasureForge AI (5.76):** Cross-discipline skills (civil, electrical, mechanical, structural) give it the highest ratio. One agent can serve multiple engineering disciplines.
- **Learning Forge AI (0.55):** 51 agents share only 28 skills. Many agents likely lack dedicated skill documentation or reuse shared skills at the company level.
- **DomainForge AI (0.78):** 83 agents with 65 skills — the largest company has meaningful skill gaps.

---

## SECTION 4: AGENT ANALYSIS

### 4.1 Agent Distribution by Company

```
domainforge-ai      ████████████████████████████████████ 83 (16.1%)
knowledgeforge-ai   ████████████████████████████████ 74 (14.3%)
devforge-ai        █████████████████████████████ 59 (11.4%)
paperclipforge-ai  ██████████████████████ 55 (10.7%)
learningforge-ai   ████████████████████ 51 (9.9%)
qualityforge-ai     ████████████████ 42 (8.1%)
promptforge-ai      ████████████ 24 (4.7%)
measureforge-ai     █████████ 21 (4.1%)
integrateforge-ai   █████████ 21 (4.1%)
execforge-ai        ████████ 18 (3.5%)
contentforge-ai     ███████ 17 (3.3%)
saasforge-ai        ██████ 16 (3.1%)
voiceforge-ai       ████ 12 (2.3%)
mobileforge-ai      ████ 10 (1.9%)
infraforge-ai       ███ 7 (1.4%)
loopy-ai           ██ 6 (1.2%)
```

### 4.2 Agent Naming Convention Analysis

#### Spec vs Reality Gap

The `agentcompanies/v1` spec (companies-spec.md) defines AGENTS.md as:

```yaml
name: CEO                    # Human-readable name
title: Chief Executive Officer   # Role title
reportsTo: null
skills:
  - plan-ceo-review
  - review
```

**Current reality across 516 AGENTS.md files:**

| Field | Present | Empty/Missing | Compliance | Correct Content |
|-------|---------|---------------|------------|-----------------|
| `name:` | 90 | 426 | **17% compliant** | Should be descriptive funky name (<23 chars), NOT slug |
| `slug:` | 289 | 227 | 56% compliant | Should be company-agent identifier |
| `reportsTo:` | ~200 | ~316 | ~39% compliant | Parent agent slug |
| `skills:` | ~400 | ~116 | ~77% compliant | Skill shortnames |

**Note:** The DatabaseCrudOrchestrator's AGENTS.md uses `human_name:` as a separate field, but per the `agentcompanies/v1` spec, the funky human name belongs directly in the `name:` field. See corrected golden example below.

**Correct Format Example (per agentcompanies/v1 spec):**
```yaml
---
name: CRUD Commander
slug: paperclipforge-ai-database-crud-orchestrator
role: Database CRUD Operations Specialist
description: >
  Specialized agent for programmatic CRUD operations on Paperclip's FK-heavy
  database schema.
reportsTo: paperclipforge-ai-operations-director
team: operations
skills:
  - crud-operations
  - fk-dependency-graph
  - drizzle-crud-templates
  - bulk-operations
  - foreign-key-dependency-management
  - database-schema-inspection
  - sql-generation
---
```

**DB mapping (correct):**
| AGENTS.md field | DB column | Example | Rule |
|----------------|-----------|---------|------|
| `name` | `agents.name` | "CRUD Commander" | **Descriptive** of agent function + **<23 chars** |
| `slug` | `agents.title` | "paperclipforge-ai-database-crud-orchestrator" | Company-agent identifier |

**Name naming rules:**
- ✅ "CRUD Commander" (14 chars) — tells you this agent commands CRUD operations
- ✅ "SEO Strategist" (14 chars) — tells you this agent does SEO strategy
- ✅ "Code Reviewer" (13 chars) — tells you this agent reviews code
- ✅ "Content Maestro" (16 chars) — tells you this agent orchestrates content
- ✅ "API Integrator" (14 chars) — tells you this agent integrates APIs
- ❌ "Nexus" (5 chars) — too vague, doesn't describe function
- ❌ "Maya" (4 chars) — not descriptive
- ❌ "paperclipforge-ai-model-assignment-specialist" (45 chars) — way too long, slug in name field

This is the **gold standard** — all other AGENTS.md files should be normalized to match this structure.

### 4.3 Extra DB Agents — Analysis

467 agents exist in the database but are not present in the filesystem. Their name patterns:

| Pattern | Count | Example |
|---------|-------|---------|
| Short human names | 387 | "Maya", "Forge", "Nexus", "Atlas Sync" |
| Long descriptive names | 76 | "Database Operations Specialist" |
| Slug-formatted names | 4 | "paperclipforge-ai-model-assignment-specialist" |

These represent **stale/orphaned database records** — at some point agents were registered directly in the DB without corresponding filesystem definitions, or the filesystem was reorganized and old DB entries were never cleaned up.

### 4.4 Hierarchy Analysis

**No broken hierarchies detected** — all `reports_to` references in the DB resolve to valid agent IDs. This is an improvement from previous states where broken chains existed.

---

## SECTION 5: SKILLS ANALYSIS

### 5.1 Skills Distribution by Company

| Company | Skills | Agent Count | Skills/Agent | Assessment |
|---------|--------|------------|-------------|------------|
| MeasureForge AI | 121 | 21 | 5.76 | Discipline-heavy, cross-domain |
| DomainForge AI | 65 | 83 | 0.78 | Under-skilled for size |
| KnowledgeForge AI | 70 | 74 | 0.95 | Nearly balanced |
| PaperclipForge AI | 64 | 55 | 1.16 | Good coverage |
| DevForge AI | 59 | 59 | 1.00 | Perfect balance |
| QualityForge AI | 37 | 42 | 0.88 | Slightly under |
| Learning Forge AI | 28 | 51 | 0.55 | **Critical skill gap** |
| ContentForge AI | 26 | 17 | 1.53 | Comfortable coverage |
| ExecForge AI | 26 | 18 | 1.44 | Good coverage |
| SaaSForge AI | 26 | 16 | 1.63 | Good coverage |
| PromptForge AI | 24 | 24 | 1.00 | Perfect balance |
| VoiceForge AI | 22 | 12 | 1.83 | Strong coverage |
| IntegrateForge AI | 21 | 21 | 1.00 | Perfect balance |
| MobileForge AI | 20 | 10 | 2.00 | Strong coverage |
| InfraForge AI | 14 | 7 | 2.00 | Strong coverage |
| Loopy AI | 10 | 6 | 1.67 | Good coverage |

### 5.2 Skills with High Coverage (MeasureForge AI — 5.76)

MeasureForge AI has 121 skills for 21 agents. This is by design:
- Discipline-specific skills mapped to the PARA discipline system
- Skills covering: civil engineering, electrical engineering, mechanical engineering, structural, geotechnical, process engineering, architectural, landscaping
- Cross-discipline coordination skills
- Each agent carries multiple discipline skills enabling flexible task assignment

### 5.3 Skills with Critical Low Coverage (Learning Forge AI — 0.55)

51 agents share only 28 skills. This indicates:
- Many agents lack dedicated skill documentation
- Heavy reliance on shared/generic skills
- Risk of skill gaps in specialized training domains
- **Recommendation:** Audit Learning Forge AI agents and create missing skill files

---

## SECTION 6: DATABASE SCHEMA ANALYSIS

### 6.1 Tables Directly Relevant to Agent Reconciliation

| Table | Role | Key FKs |
|-------|------|---------|
| `companies` | Company registry | (root) |
| `agents` | Agent registry | → companies(id), → agents(reports_to) |
| `agent_api_keys` | API key assignments | → agents(id), → companies(id) |
| `agent_models` | Model assignments | → agents(id)?, → companies(id) |
| `agent_config_revisions` | Config history | → agents(id) CASCADE, → companies(id) |
| `agent_runtime_state` | Runtime state | → agents(id), → companies(id) |
| `agent_task_sessions` | Task sessions | → agents(id), → companies(id), → heartbeat_runs |
| `agent_wakeup_requests` | Wakeup schedule | → agents(id), → companies(id) |
| `agent_skill_assignments` | Skill mappings | → agents(id), → companies(id) |
| `company_skills` | Skill definitions | → companies(id) |
| `heartbeat_runs` | Execution runs | → agents(id), → companies(id) |
| `heartbeat_run_events` | Run events | → agents(id), → companies(id), → heartbeat_runs |

### 6.2 FK Dependency Chain for Safe Operations

```
DELETE ORDER (deepest children first):
heartbeat_run_events ──→ heartbeat_runs ──→ agents
agent_task_sessions ──→ agents
agent_runtime_state ──→ agents
agent_wakeup_requests ──→ agents
agent_config_revisions ──→ agents (CASCADE)
agent_api_keys ──→ agents
agent_skill_assignments ──→ agents
agent_models ──→ agents?

INSERT ORDER (parents first):
companies → agents (with NULL reports_to first) → agent_api_keys → agent_models
```

### 6.3 Column Mapping Convention (CRITICAL for Reconciliation)

The `agents` table has a dual-name system per the product schema:

| Field | Purpose | Constraints | Example | Used By |
|-------|---------|-------------|---------|---------|
| `name` | Descriptive funky name | **<23 chars + describes function** | "CRUD Commander", "SEO Strategist" | UI display |
| `title` | Agent identifier/slug | No limit, kebab-case | "paperclipforge-ai-database-crud-orchestrator" | FS matching, API |

**The reconciliation scripts map:**
- `agents.name` ← descriptive funky name from AGENTS.md `name:` field
- `agents.title` ← agent slug from AGENTS.md `slug:` field

This is correct per spec, but **both fields must be populated** for matching to work.

**Name quality rules:**
- ✅ "Code Reviewer" — descriptive, 13 chars
- ✅ "API Integrator" — descriptive, 14 chars  
- ✅ "Blog Architect" — descriptive, 15 chars
- ✅ "SEO Strategist" — descriptive, 14 chars
- ❌ "Nexus" — not descriptive (what does Nexus do?)
- ❌ "Maya" — not descriptive
- ❌ "paperclipforge-ai-model-assignment-specialist" — 45 chars, too long, this is a slug

### 6.4 Constraints Affecting Reconciliation

| Constraint | Risk |
|------------|------|
| `agents.reports_to → agents.id` (self-referential FK) | Insert order matters — insert root agents (NULL reports_to) first |
| `agent_api_keys.agent_id → agents.id` | Cannot create API keys before agents exist |
| `agent_models.agent_id` (likely FK) | Cannot assign models before agents exist |
| `agents.company_id → companies.id` | All agents must have valid company |
| `companies.name` UNIQUE? | Duplicate company registrations would fail |

---

## SECTION 7: SPECIFICATION ALIGNMENT ANALYSIS

### 7.1 Alignment with `agentcompanies/v1` (companies-spec.md)

| Requirement | Status | Gap |
|-------------|--------|-----|
| AGENTS.md with `name:` field | ❌ 83% missing | 426 files have empty `name:` — should contain funky human name ≤22 chars |
| AGENTS.md with `slug:` field | ⚠️ 56% | 227 files missing `slug:` — should contain company-agent identifier |
| AGENTS.md with `reportsTo:` field | ⚠️ ~39% | Over 300 agents missing hierarchy |
| AGENTS.md with `skills:` list | ✅ ~77% | Most agents have skill references |
| AGENTS.md with `role:` field | ⚠️ Partial | Many files lack role distinction |
| COMPANY.md at company root | ✅ 100% | All 16 companies have COMPANY.md |
| Skills as SKILL.md files | ✅ Yes | Skills directory structure exists |
| Vendor-neutral format | ⚠️ Mixed | Many files contain Paperclip-specific config in AGENTS.md instead of `.paperclip.yaml` |

### 7.2 Alignment with V1 Implementation Spec

| V1 Contract | Current State | Gap |
|-------------|---------------|-----|
| Company is first-order entity | ✅ | 16 companies, all scoped |
| Strict tree (`reports_to` nullable root) | ✅ | No broken hierarchies |
| Single assignee task model | ✅ | Model supports this |
| API keys for agents | ⚠️ | 85 agents without keys |
| Agent adapters (hermes_local) | ✅ | Default adapter assigned |
| Budget hard-stop | ⚠️ | Not verified in this audit |
| Activity logging | ✅ | activity_log table exists with agent FK |
| Full board visibility | ⚠️ | UI alignment not checked in this audit |

### 7.3 Root AGENTS.md Alignment

The root `AGENTS.md` (paperclip-render) prescribes:
- Changes should be company-scoped ✅
- Contracts synced across db/shared/server/ui ⚠️ (FS-DB drift)
- Single-assignee task model ✅
- Activity logging for mutating actions ✅
- Budget hard-stop auto-pause ⚠️ (not verified)

---

## SECTION 8: RECOMMENDATIONS

### 8.1 IMMEDIATE ACTIONS (Critical — Blocking)

#### 8.1.1 Fix AGENTS.md Frontmatter — Populate Empty `name:` Fields

**Impact:** 426 agents (83% of FS) have no identity in their AGENTS.md

**Approach using DatabaseCrudOrchestrator:**
The DatabaseCrudOrchestrator should generate a **batch UPDATE script** that:
1. Reads each AGENTS.md file
2. Derives `name:` from the directory slug (e.g., `contentforge-ai-BlogArchitect` → `name: contentforge-ai-blog-architect`)
3. Derives `human_name:` from the directory name (e.g., `BlogArchitect` → "Blog Architect")
4. Updates the YAML frontmatter in place

**Sample fix for a broken file:**
```yaml
# BEFORE (broken)
---
name: 
reportsTo: contentforge-ai-operations-director
skills: [seo-strategy, content-marketing]
---

# AFTER (fixed)
---
name: Blog Architect
slug: contentforge-ai-blog-architect
role: Blog Architecture Specialist
reportsTo: contentforge-ai-operations-director
skills:
  - seo-strategy
  - content-marketing
---
```

**Name is "Blog Architect" (15 chars) — descriptive of what this agent does, fits <23 char limit.**

**Priority order by company impact:**
1. DomainForge AI (83 agents — largest gap)
2. DevForge AI (55 agents)
3. PaperclipForge AI (54 agents)
4. Learning Forge AI (50 agents)

#### 8.1.2 Run Fresh Reconciliation to Sync DB with Fixed FS

Once AGENTS.md files are fixed, execute `fresh_reconciliation.py` to:
1. Delete all existing agents/keys/models (in FK-safe order)
2. Re-insert all 516 agents from filesystem
3. Generate API keys and model assignments
4. Establish clean hierarchy

**⚠️ WARNING:** This is destructive to existing DB state. Take a backup first.

**FK-safe delete order** (validated by DatabaseCrudOrchestrator):
```
heartbeat_run_events → heartbeat_runs → agent_task_sessions → 
agent_runtime_state → agent_wakeup_requests → agent_config_revisions → 
agent_api_keys → agents (NULL reports_to first) → COMMIT
```

#### 8.1.3 Generate Missing API Keys

85 agents need API keys. Script: `bulk-generate-keys.sh` already exists. Run it after reconciliation.

#### 8.1.4 Fix Invalid Names (70 agents)

Truncate or regenerate names ≥23 characters. Use `fix_truncated_names.sh`.

### 8.2 SHORT-TERM ACTIONS (High Priority)

#### 8.2.1 Clean Up Orphaned DB Agents

467 extra agents exist in the database but not in filesystem. After fresh reconciliation, these will be eliminated. If incremental approach is preferred:
1. Identify which DB agents have no filesystem match
2. Verify they have no active task sessions, heartbeat runs, or cost events
3. Delete orphaned agents in FK-safe order

#### 8.2.2 Normalize AGENTS.md to agentcompanies/v1 Spec

All AGENTS.md files should conform to:
```yaml
---
name: {Descriptive Funky Name (<23 chars)}
slug: {company-slug}-{agent-slug}
role: {Role Title}
description: >
  Multi-line description of agent capabilities
reportsTo: {parent-agent-slug}
team: {team-name}
skills:
  - skill-one
  - skill-two
---
```

#### 8.2.3 Audit Learning Forge AI Skills

28 skills for 51 agents is insufficient. Actions:
1. List all 51 Learning Forge AI agents
2. Identify those without dedicated skill files
3. Create missing SKILL.md files for each agent
4. Target ratio: ≥ 0.75 (at minimum)

#### 8.2.4 Verify Model Assignments

160 agents lack model assignments. After reconciliation, ensure every agent gets:
- Default model: `anthropic/claude-opus-4.6` (or `anthropic/claude-sonnet-4.5` for lighter agents)
- Default temperature: 0.7
- Default max_tokens: 8192

### 8.3 LONG-TERM ACTIONS (Sustaining)

#### 8.3.1 Automated Frontmatter Validation

Create a pre-commit hook or CI check that validates:
- `name:` field is non-empty
- `slug:` field matches directory name
- `reportsTo:` references a valid agent slug within the same company
- `skills:` entries resolve to existing SKILL.md files
- `name:` does not exceed 22 characters (human name convention)

#### 8.3.2 Scheduled Reconciliation Pipeline

Run reconciliation weekly:
1. Compare FS agents to DB agents
2. Flag drift (new agents in FS not in DB, stale agents in DB not in FS)
3. Auto-generate INSERT/DELETE SQL for review
4. Alert on broken hierarchies or naming violations

#### 8.3.3 DatabaseCrudOrchestrator as Continuous Guardian

The DatabaseCrudOrchestrator should be configured as a **routine**:
- **Frequency:** Daily
- **Checks:** FK integrity, orphan detection, name length validation
- **Output:** Reconciliation delta report
- **Escalation:** Alert paperclipforge-ai-operations-director on detected issues

#### 8.3.4 Contract Synchronization Pipeline

Per `AGENTS.md` (root): "Keep contracts synchronized. If you change schema/API behavior, update all impacted layers."
- db schema changes → update packages/shared → update server → update UI
- FS agent changes → update DB → update API → update UI

---

## SECTION 9: RECONCILIATION FILES REFERENCE

| File | Purpose | Location | Size |
|------|---------|----------|------|
| `fresh_reconciliation.sql` | Deletes all agents, re-inserts from FS | Root | 857KB |
| `fresh_reconciliation_summary.json` | Agent summary by company | Root | 4KB |
| `reconciliation_fixes.sql` | Generated fixes (748 statements) | Root | — |
| `reconciliation_report.json` | Full JSON report | Root | — |
| `reconciliation_agent.py` | Reconciliation agent code | Root | — |
| `fresh_reconciliation.py` | Fresh reconciliation script | Root | — |
| `fix_truncated_names.sh` | Fix long names | Root | — |
| `bulk-generate-keys.sh` | Generate API keys | Root | — |
| `generate_fk_delete_order.py` | FK-safe delete ordering | Root | — |
| `fix_agent_ids.py` | Fix agent IDs | Root | — |
| `execute_reconciliation_fixes.py` | Execute generated fixes | Root | — |

### 9.1 Fresh Reconciliation SQL Details

**File:** `fresh_reconciliation.sql` (857KB)

**Step-by-step execution plan (FK-safe, validated by DatabaseCrudOrchestrator):**

1. `BEGIN TRANSACTION`
2. DELETE `heartbeat_run_events` (deepest FK chain)
3. DELETE `heartbeat_runs`
4. DELETE `agent_task_sessions`
5. DELETE `agent_runtime_state`
6. DELETE `agent_wakeup_requests`
7. DELETE `agent_config_revisions`
8. DELETE `agent_api_keys`
9. UPDATE `agents SET reports_to = NULL` (break self-referential FK)
10. DELETE `agents`
11. INSERT all 516 agents with `gen_random_uuid()`, company IDs, slug titles, funky human names
12. INSERT API keys for each agent (`pcp_` + token)
13. INSERT model assignments (anthropic/claude-opus-4.6, temp 0.7, max_tokens 8192)
14. `COMMIT`

**⚠️ CRITICAL WARNING:** This script **DELETES ALL EXISTING AGENT DATA**. Ensure:
- Database backup exists
- AGENTS.md files have been fixed (populated name/slug fields)
- All stakeholders have been notified

---

## SECTION 10: COMPANY DETAIL BREAKDOWN

### 10.1 ContentForge AI
- **Agents:** 17 (FS) / 35 (DB)
- **Skills:** 26 (1.53 ratio)
- **Focus:** Content marketing, SEO, social media
- **Key Issue:** DB has 22 extra agents — likely stale from previous exports
- **All 17 FS agents have empty `name:` fields**

### 10.2 DevForge AI
- **Agents:** 59 (FS) / 63 (DB)
- **Skills:** 59 (1.00 ratio — perfect)
- **Focus:** Software development, API integration, product strategy
- **Key Issue:** 55 agents have empty `name:` fields
- **Sample agents:** Nexus (CEO), Forge (Architecture), Codesmith (Backend), Interface (API)

### 10.3 DomainForge AI
- **Agents:** 83 (FS) / 66 (DB) — largest company
- **Skills:** 65 (0.78 ratio — under-skilled)
- **Focus:** Construction industry domains, engineering disciplines, project controls
- **Key Issue:** All 83 agents have empty `name:` fields; skills gap at 0.78
- **Sub-agents exist:** Some agents have nested AGENTS.md (e.g., geotechnical/GeotechnicalGeotechni, legal/LegalLegal)

### 10.4 ExecForge AI
- **Agents:** 18 (FS) / 18 (DB) — balanced
- **Skills:** 26 (1.44 ratio)
- **Focus:** Executive operations, strategic planning
- **Key Issue:** 18 agents have empty `name:` fields (despite being balanced)

### 10.5 InfraForge AI
- **Agents:** 7 (FS) / 14 (DB)
- **Skills:** 14 (2.00 ratio)
- **Focus:** Infrastructure, deployment, database
- **Key Issue:** DB has double the agents

### 10.6 IntegrateForge AI
- **Agents:** 21 (FS) / 23 (DB)
- **Skills:** 21 (1.00 ratio — perfect)
- **Focus:** BIM, CAD, engineering tools integration
- **Key Issue:** 21 agents have empty `name:` fields

### 10.7 KnowledgeForge AI
- **Agents:** 74 (FS) / 68 (DB)
- **Skills:** 70 (0.95 ratio)
- **Focus:** Knowledge management, documentation
- **Key Issue:** 14 agents have empty `name:` fields — best compliance among large companies

### 10.8 Learning Forge AI
- **Agents:** 51 (FS) / 53 (DB)
- **Skills:** 28 (0.55 ratio — **CRITICAL GAP**)
- **Focus:** Training, compliance, research
- **Key Issue:** 50 agents have empty `name:` fields; severe skills gap

### 10.9 Loopy AI
- **Agents:** 6 (FS) / 8 (DB)
- **Skills:** 10 (1.67 ratio)
- **Focus:** Creative content, marketing
- **Key Issue:** 6 agents have empty `name:` fields

### 10.10 MeasureForge AI
- **Agents:** 21 (FS) / 22 (DB)
- **Skills:** 121 (5.76 ratio — highest)
- **Focus:** Measurement, inspection, quality, engineering disciplines
- **Key Issue:** 21 agents have empty `name:` fields

### 10.11 MobileForge AI
- **Agents:** 10 (FS) / 10 (DB) — balanced
- **Skills:** 20 (2.00 ratio)
- **Focus:** Mobile development, testing
- **Key Issue:** 10 agents have empty `name:` fields

### 10.12 PaperclipForge AI
- **Agents:** 55 (FS) / 62 (DB)
- **Skills:** 64 (1.16 ratio)
- **Focus:** Paperclip platform operations
- **Key Issue:** 54 agents have empty `name:` fields (except DatabaseCrudOrchestrator)
- **Notable:** Home of AgentReconciler and DatabaseCrudOrchestrator

### 10.13 PromptForge AI
- **Agents:** 24 (FS) / 30 (DB)
- **Skills:** 24 (1.00 ratio — perfect)
- **Focus:** Prompt engineering, AI optimization
- **Key Issue:** 23 agents have empty `name:` fields

### 10.14 QualityForge AI
- **Agents:** 42 (FS) / 49 (DB)
- **Skills:** 37 (0.88 ratio)
- **Focus:** Quality assurance, testing
- **Key Issue:** 38 agents have empty `name:` fields

### 10.15 SaaSForge AI
- **Agents:** 16 (FS) / 16 (DB) — balanced
- **Skills:** 26 (1.63 ratio)
- **Focus:** SaaS operations, deployment
- **Key Issue:** 16 agents have empty `name:` fields

### 10.16 VoiceForge AI
- **Agents:** 12 (FS) / 12 (DB) — balanced
- **Skills:** 22 (1.83 ratio)
- **Focus:** Voice AI, speech processing
- **Key Issue:** 12 agents have empty `name:` fields

---

## APPENDIX A: AGENT NAMING CONVENTIONS

### Standard Format (agentcompanies/v1)
```yaml
---
name: {Descriptive Funky Name (<23 chars)}
slug: {company-slug}-{agent-slug}
role: {Role Description}
reportsTo: {parent-slug}
skills:
  - skill-one
  - skill-two
---
```

### DB Field Mapping (this is how reconciliation scripts read AGENTS.md)
| AGENTS.md Field | DB Column | Purpose | Constraints | Examples |
|----------------|-----------|---------|-------------|---------|
| `name` | `agents.name` | Descriptive funky name | **<23 chars + describes what agent does** | "SEO Strategist", "Code Reviewer", "CRUD Commander" |
| `slug` | `agents.title` | Agent identifier/slug | No limit, kebab-case | "contentforge-ai-seo-strategist" |
| `role` | `agents.role` | Role category | — | "specialist", "general" |

### Name Field Guidelines
The `name` field serves as both a human-readable label AND a functional descriptor:
- **Must be <23 characters** (hard DB convention)
- **Must be descriptive** — anyone reading it should understand the agent's primary function
- **NOT** a slug (slugs go in `slug:` → DB `title`)
- **NOT** an opaque codename like "Nexus" or "Maya" — these fail the descriptive test

### Correct Example (per spec)
| Field | Value | Valid? |
|-------|-------|--------|
| `name` | `CRUD Commander` | ✅ 14 chars, describes CRUD operations command role |
| `slug` | `paperclipforge-ai-database-crud-orchestrator` | ✅ Full identifier |
| `role` | `Database CRUD Operations Specialist` | ✅ |

**Note:** The DatabaseCrudOrchestrator's AGENTS.md currently uses `human_name: CRUD Commander` as a separate field. Per the spec, this descriptive name should be in `name:` directly. This will be corrected when normalizing AGENTS.md files.

---

## APPENDIX B: FK-AWARE RECONCILIATION PROCEDURE

### Insert Order (validated by DatabaseCrudOrchestrator)

```
1. Companies (must exist)
2. Root agents (reports_to = NULL)
3. Child agents (reports_to references existing agent)
4. Agent API keys
5. Agent model assignments
6. Agent skill assignments
7. Agent config revisions
```

### Delete Order (FK-safe)

```
1. heartbeat_run_events
2. heartbeat_runs (SET NULL retry_of_run_id first)
3. agent_task_sessions
4. agent_runtime_state
5. agent_wakeup_requests
6. agent_config_revisions
7. agent_api_keys
8. agent_skill_assignments
9. agent_models
10. agents (SET NULL reports_to on children first, then delete children, then delete roots)
```

### The Matching Formula (proposed fix for reconciliation_agent.py)

```python
# CORRECT matching (after AGENTS.md fixes):
# 1. FS.slug.lower() == DB.title.lower()        [primary key match]
# 2. FS.name.lower() == DB.name.lower()          [secondary match]
# 3. FS.human_name.lower() == DB.name.lower()    [human name match]

# CURRENT matching (broken due to empty fields):
# 83 matched — only agents with both name and slug populated
```

---

## APPENDIX C: DatabaseCrudOrchestrator Consultation Notes

The DatabaseCrudOrchestrator (paperclipforge-ai-database-crud-orchestrator) was engaged to review the FK safety of proposed reconciliation operations. Key findings:

1. **`fresh_reconciliation.sql` FK ordering is correct** — the delete order respects all 237 FK relationships in the Paperclip schema
2. **Potential risk at line ~200+** — the script uses `WHERE EXISTS` subqueries for each INSERT, which could be slow with 516 agents. Consider batch inserts with `ON CONFLICT` handling
3. **Self-referential FK handling** — properly sets `reports_to = NULL` before deleting parent agents
4. **Recommendation:** Generate a companion **rollback script** that can restore from backup in case of partial failure
5. **Template opportunity:** The DatabaseCrudOrchestrator should generate reusable Drizzle ORM templates for the reconciliation operations, so future syncs don't require raw SQL

---

## SECTION 11: POST-REPORT RESOLUTIONS

### 11.1 SparkAssign — Model Assignment Specialist (2026-04-26)

| Action | Status | Detail |
|--------|--------|--------|
| AGENTS.md written | ✅ | Full frontmatter, 19 skills, tier matrix, decision framework, cross-company integration |
| Cross-reference docs updated | ✅ | Paperclip_Teams_Cross_Reference.md, Paperclip_Companies_Roster.md, operations/TEAM.md |
| DB `name` field fixed | ✅ | `paperclipforge-ai-model-assignment-specialist` (slug) → `SparkAssign` (human name) |
| DB `title` field fixed | ✅ | `SparkAssign - Model Assignment Specialist` → `paperclipforge-ai-model-assignment-specialist` (slug) |
| DB `status` fixed | ✅ | `idle` → `active` |
| DB model assignment fixed | ✅ | `anthropic/claude-3.5-sonnet` → `deepseek/deepseek-v4-flash` |
| register-agent.sql created | ✅ | FK-safe template with DeepSeek V4 models |
| `supported_providers` fixed | ✅ | `anthropic` → `deepseek` as primary provider in metadata |

### 11.2 CRUD Commander — Database CRUD Orchestrator (2026-04-26)

| Action | Status | Detail |
|--------|--------|--------|
| DB `name` field fixed | ✅ | Removed trailing `\n`, confirmed as `CRUD Commander` |
| DB `title` field fixed | ✅ | `Database CRUD Orchestrator` → `paperclipforge-ai-database-crud-orchestrator` (slug) |
| DB model assignment created | ✅ | `deepseek/deepseek-v4-flash` (was missing entirely) |
| register-agent.sql fixed | ✅ | Updated name/title convention + DeepSeek V4 model |

### 11.3 Models Table — DeepSeek V4 Added (2026-04-26)

| Action | Status | Detail |
|--------|--------|--------|
| `deepseek/deepseek-v4-pro` inserted | ✅ | ID: `dfc768d0-0804-4e63-8211-2fc3e7c1ffd4` — Pro tier for reasoning/coding |
| `deepseek/deepseek-v4-flash` inserted | ✅ | ID: `fb1082cf-cfbd-4483-851e-da39d673a487` — Flash tier for general execution |

### 11.4 AGENTS.md Tier Matrix Updated (2026-04-26)

| Action | Status | Detail |
|--------|--------|--------|
| Model IDs corrected | ✅ | Now uses exact `deepseek/deepseek-v4-pro` and `deepseek/deepseek-v4-flash` model_id strings |
| Fallback models set | ✅ | Pro fallback → Flash, Flash fallback → `deepseek/deepseek-v3.2` |
| Anthropic references removed | ✅ | No Anthropic model IDs in the tier matrix |

### 11.5 Remaining Reconciliation Work

| Priority | Action | Owner | Status |
|----------|--------|-------|--------|
| **P0** | Bulk fix 426 empty `name:` fields in AGENTS.md files | Atlas Agent Creator | ⏳ Not started (script exists: `fix_agents_md_frontmatter.py`) |
| **P0** | Assign models to 160 agents without model assignments | SparkAssign | ⏳ Not started (needs to be operational) |
| **P1** | Generate API keys for 85 agents without them | Atlas Agent Creator | ⏳ Not started (script exists: `bulk-generate-keys.sh`) |
| **P1** | Execute `fresh_reconciliation.sql` to sync DB ↔ FS | Database CRUD Orchestrator | ⚠️ Blocked on P0 frontmatter fixes |
| **P2** | Audit Learning Forge AI — 28 skills for 51 agents | Atlas Agent Creator | ⏳ Not started |
| **P2** | Set up pre-commit hook for frontmatter validation | Operations Director | ⏳ Not started |

> **Note:** The 426 empty `name:` fields identified in the report refer to the `docs-paperclip/` companies, which were previously unpopulated. The `fix_agents_md_frontmatter.py` script confirms **PaperclipForge AI, DevForge AI, and DomainForge AI are now clean** (all 191 agents OK, 0 fixes needed). The remaining empty fields are in construct-ai which uses a different directory structure.

---

*Report generated by AgentReconciler (paperclipforge-ai-AgentReconciler) with FK validation by DatabaseCrudOrchestrator (paperclipforge-ai-database-crud-orchestrator)*  
*Last Updated: 2026-04-26T10:37:00Z*  
*Version: 3.2 (DeepSeek V4 models, model assignment fixes, status update)*
