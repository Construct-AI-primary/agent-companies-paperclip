# Agent Table Reconciliation & Naming Fix Plan

**Date:** 2026-04-22
**Status:** DEFERRED - SQL execution issues encountered. Marked for future work when SQL access is available.
**Scope:** PaperclipForge AI + MeasureForge AI agent table cleanup, deduplication, and human naming standardization

---

## 1. Problem Statement

### 1.1 Current Issues Identified

1. **Duplicate Agents in Database**: The agents table contains duplicate entries for both PaperclipForge AI and MeasureForge AI agents, likely caused by multiple registration script runs without proper idempotency.

2. **Missing Agents**: Some agents defined in company documentation and filesystem directories are not registered in the database.

3. **Non-Human Agent Names**: Agent `name` fields use technical/slug-style names (e.g., `paperclipforge-ai-advanced-engineering-analysis`, `the-measuremaster`) instead of human-readable unique names.

4. **Cross-Company Name Uniqueness**: Agent names should be unique across ALL companies to prevent routing confusion and database conflicts.

5. **SQL Syntax Errors in MeasureForge Tiered Script**: The `register-tiered-agents.sql` file contains malformed SQL on lines 166, 230, 290, 350, 410, 470, 530, and 590:
   ```sql
   -- BROKEN (current):
   ) SELECT ... WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = '([^']*)'))
     name = EXCLUDED.name, ...
   
   -- Should be proper INSERT ... ON CONFLICT or just INSERT ... WHERE NOT EXISTS
   ```

### 1.2 Impact

- Agent routing failures due to duplicate names
- Confusion in task assignment and cross-company coordination
- Inability to run MeasureForge tiered architecture migration
- Inconsistent agent identity across the ecosystem

---

## 2. Discovery Summary

### 2.1 PaperclipForge AI

| Source | Count | Notes |
|--------|-------|-------|
| Filesystem directories | 58 | Found in `docs-paperclip/companies/paperclipforge-ai/agents/` |
| COMPANY.md defined teams | ~16 | Leadership + 4 core teams with 4 agents each |
| Audit report expected | 37 | Per reconciliation file |
| Database entries | Unknown | Requires live query to determine |

**Key Finding**: 58 filesystem directories vs 37 expected agents = 21 extra/legacy directories that need cleanup or reclassification.

### 2.2 MeasureForge AI

| Source | Count | Notes |
|--------|-------|-------|
| COMPANY.md defined agents | 39 | Across 6 layers (Swarm, Element, Visual, Standards, CAD, Procurement) |
| Tiered coordination layer | 10 | 3 Strategic + 7 Tactical coordinators (orchestration only) |
| **Total agents to register** | **39** | ALL agents must be registered for Paperclip orchestrator to route tasks |
| Filesystem directories | 5 subdirs | coordinators, creators, measurement-validation-specialist, specialists, validators |
| SQL script agents (tiered) | 10 | the-measuremaster, reggie-the-regulator, quincy-the-quality-queen, quantina-the-calculator, terra-the-terrain-titan, cindy-the-concrete-queen, sparky-the-electrical-wizard, traffic-tina-the-transit-guru, caddy-the-cad-commander, quill-the-quality-inspector |

**Key Finding**: The 10 tiered agents are the coordination/orchestration layer ONLY. ALL 39 agents from COMPANY.md must be registered in the database for the Paperclip orchestrator to properly route tasks. The tiered architecture defines reporting structure, not agent reduction. The tiered SQL script has syntax errors preventing migration.

---

## 3. Naming Convention Standard

### 3.1 Principles

1. **Human Names Only**: Every agent `name` field must be a human-readable name (first name or first + last name)
2. **Globally Unique**: No two agents across ANY company can share the same name
3. **Role-Indicative**: Names should be memorable and optionally hint at the agent's role
4. **Kebab-Case Slugs**: The `name` field uses kebab-case for database compatibility

### 3.2 Proposed Naming Pattern

```
{human-name}-{company-slug}
```

Example:
- `maya-paperclipforge` (Operations Director)
- `atlas-paperclipforge` (Agent Creator)
- `reggie-measureforge` (Standards Director)
- `terra-measureforge` (Earthwork Coordinator)

### 3.3 Reserved Name Registry

A central registry file will be maintained at:
```
docs-paperclip/schema/agent-name-registry.md
```

This file tracks all assigned agent names across companies to prevent collisions.

---

## 4. Fix Plan - Phase by Phase

### Phase 1: Database Audit & Cleanup (Day 1)

**Objective**: Understand current database state and remove duplicates.

#### 4.1.1 Query Current State
```sql
-- Find all duplicate agent names
SELECT name, company_id, COUNT(*) as cnt
FROM agents
GROUP BY name, company_id
HAVING COUNT(*) > 1;

-- Find agents with same name across companies
SELECT name, COUNT(DISTINCT company_id) as company_count
FROM agents
GROUP BY name
HAVING COUNT(DISTINCT company_id) > 1;

-- List all PaperclipForge AI agents
SELECT a.id, a.name, a.role, a.title, a.status, c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'PaperclipForge AI'
ORDER BY a.name;

-- List all MeasureForge AI agents
SELECT a.id, a.name, a.role, a.title, a.status, c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'MeasureForge AI'
ORDER BY a.name;
```

#### 4.1.2 Remove Duplicates
- Keep the most recently updated entry for each duplicate
- Delete older duplicates
- Preserve all associated data (skills, permissions, etc.)

#### 4.1.3 Generate Cleanup Report
- Document what was removed and why
- Create rollback script

**Deliverable**: Clean database with no duplicate agent names

---

### Phase 2: Fix MeasureForge Tiered SQL Script (Day 1-2)

**Objective**: Fix SQL syntax errors in `register-tiered-agents.sql`.

#### 4.2.1 Fix Pattern

Replace the broken pattern:
```sql
) VALUES (
  ...
) SELECT ... WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = '([^']*)'))
  name = EXCLUDED.name,
  ...
```

With correct pattern (Option A - INSERT WHERE NOT EXISTS):
```sql
INSERT INTO agents (...)
SELECT ...
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'the-measuremaster');
```

Or correct pattern (Option B - INSERT ON CONFLICT):
```sql
INSERT INTO agents (...)
VALUES (...)
ON CONFLICT (name) DO UPDATE SET
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  ...
  updated_at = EXCLUDED.updated_at;
```

**Recommendation**: Use Option A (INSERT WHERE NOT EXISTS) for idempotent registration without requiring a unique constraint on `name`.

#### 4.2.2 Affected Lines
- Line 166: `quincy-the-quality-queen`
- Line 230: `quantina-the-calculator`
- Line 290: `terra-the-terrain-titan`
- Line 350: `cindy-the-concrete-queen`
- Line 410: `sparky-the-electrical-wizard`
- Line 470: `traffic-tina-the-transit-guru`
- Line 530: `caddy-the-cad-commander`
- Line 590: `quill-the-quality-inspector`

**Deliverable**: Working `register-tiered-agents.sql` that can be executed without errors

---

### Phase 3: Human Name Standardization (Day 2-3)

**Objective**: Rename all agents to human-readable, globally unique names.

#### 4.3.1 PaperclipForge AI Name Mapping

| Current Name | Proposed Human Name | Role |
|-------------|-------------------|------|
| paperclipforge-ai-operations-director | maya-paperclipforge | COO |
| paperclipforge-ai-atlas-agent-creator | atlas-paperclipforge | Agent Creator |
| paperclipforge-ai-advanced-engineering-analysis | andy-paperclipforge | Engineering Analysis |
| paperclipforge-ai-cross-discipline-coordination | charlie-paperclipforge | Cross-Discipline Coordination |
| paperclipforge-ai-engineering-ui-specialist | uma-paperclipforge | Engineering UI |
| paperclipforge-ai-measurement-coordination-specialist | molly-paperclipforge | Measurement Coordination |
| paperclipforge-ai-measurement-validation-specialist | vera-paperclipforge | Measurement Validation |
| paperclipforge-ai-measurement-standards-specialist | stella-paperclipforge | Measurement Standards |
| paperclipforge-ai-wisdom-weaver | wisdom-paperclipforge | Knowledge Integration |
| paperclipforge-ai-org-research-folder-creator | scout-paperclipforge | Research & Documentation |
| paperclipforge-ai-github-operations-specialist | git-paperclipforge | GitHub Operations |
| paperclipforge-ai-api-manager | api-paperclipforge | API Management |
| paperclipforge-ai-assignment-specialist | assign-paperclipforge | Assignment |
| paperclipforge-ai-auth-administrator | auth-paperclipforge | Auth Administration |
| paperclipforge-ai-backup-butler | backup-paperclipforge | Backup Management |
| paperclipforge-ai-cache-keeper | cache-paperclipforge | Cache Management |
| paperclipforge-ai-chaos-champion | chaos-paperclipforge | Chaos Testing |
| paperclipforge-ai-code-sage | sage-paperclipforge | Code Quality |
| paperclipforge-ai-config-curator | config-paperclipforge | Configuration |
| paperclipforge-ai-data-architect | data-paperclipforge | Data Architecture |
| paperclipforge-ai-data-integrator | integrator-paperclipforge | Data Integration |
| paperclipforge-ai-database-druid | db-paperclipforge | Database Management |
| paperclipforge-ai-dependency-manager | depend-paperclipforge | Dependency Management |
| paperclipforge-ai-deployer | deploy-paperclipforge | Deployment |
| paperclipforge-ai-documentarian | docs-paperclipforge | Documentation |
| paperclipforge-ai-integration-architect | architect-paperclipforge | Integration Architecture |
| paperclipforge-ai-issue-generator | issue-paperclipforge | Issue Generation |
| paperclipforge-ai-knowledge-integrator | knowledge-paperclipforge | Knowledge Integration |
| paperclipforge-ai-log-analyst | log-paperclipforge | Log Analysis |
| paperclipforge-ai-metric-master | metric-paperclipforge | Metrics |
| paperclipforge-ai-monitor-maven | monitor-paperclipforge | Monitoring |
| paperclipforge-ai-network-navigator | network-paperclipforge | Network Management |
| paperclipforge-ai-performance-monitor | perfmon-paperclipforge | Performance Monitoring |
| paperclipforge-ai-performance-profiler | profiler-paperclipforge | Performance Profiling |
| paperclipforge-ai-predictive-modeler | predict-paperclipforge | Predictive Modeling |
| paperclipforge-ai-progress-tracker | progress-paperclipforge | Progress Tracking |
| paperclipforge-ai-project-coordinator | coord-paperclipforge | Project Coordination |
| paperclipforge-ai-quality-controller | qc-paperclipforge | Quality Control |
| paperclipforge-ai-reporting-analyst | report-paperclipforge | Reporting |
| paperclipforge-ai-resource-manager | resource-paperclipforge | Resource Management |
| paperclipforge-ai-risk-analyst | risk-paperclipforge | Risk Analysis |
| paperclipforge-ai-scheduler-sage | schedule-paperclipforge | Scheduling |
| paperclipforge-ai-secret-keeper | secret-paperclipforge | Secret Management |
| paperclipforge-ai-security-guardian | security-paperclipforge | Security |
| paperclipforge-ai-test-commander | test-paperclipforge | Testing |
| paperclipforge-ai-user-experience-coordinator | ux-paperclipforge | UX Coordination |
| paperclipforge-ai-version-vigilante | version-paperclipforge | Version Control |
| paperclipforge-ai-workflow-automator | workflow-paperclipforge | Workflow Automation |

**Note**: The "fun" nickname agents (Bridge Builder Extraordinaire, Chainlink Charmer, Ticket Tinkerer, etc.) should be mapped to their formal names with nicknames stored in metadata.

#### 4.3.2 MeasureForge AI Name Mapping (Tiered Architecture)

| Current Name | Proposed Human Name | Tier | Role |
|-------------|-------------------|------|------|
| the-measuremaster | master-measureforge | Strategic | Chief Measurement Orchestrator |
| reggie-the-regulator | reggie-measureforge | Strategic | Measurement Standards Director |
| quincy-the-quality-queen | quincy-measureforge | Strategic | Quality Assurance Coordinator |
| quantina-the-calculator | quantina-measureforge | Tactical | Quantity Surveying Coordinator |
| terra-the-terrain-titan | terra-measureforge | Tactical | Earthwork & Terrain Coordinator |
| cindy-the-concrete-queen | cindy-measureforge | Tactical | Civil Engineering Coordinator |
| sparky-the-electrical-wizard | sparky-measureforge | Tactical | Electrical Coordinator |
| traffic-tina-the-transit-guru | tina-measureforge | Tactical | Traffic & Transportation Coordinator |
| caddy-the-cad-commander | caddy-measureforge | Tactical | CAD Integration Coordinator |
| quill-the-quality-inspector | quill-measureforge | Tactical | Quality Control Coordinator |

#### 4.3.3 Migration Script

Create `scripts/database/migrate-agent-names.sql`:
```sql
-- PaperclipForge AI name updates
UPDATE agents SET name = 'maya-paperclipforge' 
WHERE name = 'paperclipforge-ai-operations-director' 
  AND company_id = (SELECT id FROM companies WHERE name = 'PaperclipForge AI');

-- ... (one UPDATE per agent)

-- MeasureForge AI name updates
UPDATE agents SET name = 'master-measureforge' 
WHERE name = 'the-measuremaster' 
  AND company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI');

-- ... (one UPDATE per agent)
```

**Deliverable**: All agents renamed with human-readable, globally unique names

---

### Phase 4: Missing Agent Registration (Day 3-4)

**Objective**: Register all agents defined in COMPANY.md that are missing from the database.

#### 4.4.1 PaperclipForge AI Gap Analysis

Compare the 58 filesystem directories against database entries to identify:
- Agents in filesystem but not in database → Register
- Agents in database but not in filesystem → Investigate (legacy or orphaned)
- Agents in neither → Create from COMPANY.md definition

#### 4.4.2 MeasureForge AI Gap Analysis

**CRITICAL**: ALL 39 agents from COMPANY.md must be registered for Paperclip orchestrator to route tasks. The 10 tiered agents are only the coordination layer.

**Complete Agent Registration Plan:**

| Layer | Count | Agents |
|-------|-------|--------|
| Swarm Coordination | 3 | CAD Measurement Orchestrator, Quality Assurance Monitor, Workflow Controller |
| Element Measurement | 15-20 | Structural, Architectural, MEP, Earthworks element specialists |
| Visual Intelligence | 4 | Rendering Engine, Standards Visualizer, Collaboration Hub, Audit Trail Manager |
| Standards & Compliance | 4 | ASAQS, SANS, International Standards, Dynamic Standards Monitor |
| CAD Integration | 7+ | AutoCAD, Revit, Civil 3D, MicroStation, SketchUp, ArchiCAD, SolidWorks |
| Procurement Integration | 6 | Procurement Order, Contract Tender, Candy Materials, Supplier Integration, Procurement Workflow, Materials Analytics |

**Steps:**
1. Fix and run `register-tiered-agents.sql` for 10 coordination agents
2. Create `register-specialist-agents.sql` for remaining 29 specialist agents
3. Verify all 39 agents are created and properly linked to MeasureForge AI company
4. Set up proper `reports_to` hierarchy linking specialists to their coordinators

**Deliverable**: All 39 MeasureForge agents registered in database with proper hierarchy

---

### Phase 5: Unique Constraint Enforcement (Day 4)

**Objective**: Prevent future duplicate agent names.

#### 4.5.1 Add Unique Constraint

```sql
-- Add unique constraint on agent name across all companies
ALTER TABLE agents ADD CONSTRAINT uq_agent_name UNIQUE (name);
```

#### 4.5.2 Update Registration Scripts

Ensure all `INSERT` statements use `WHERE NOT EXISTS` or `ON CONFLICT` patterns.

**Deliverable**: Database schema prevents duplicate agent names

---

### Phase 6: Name Registry Documentation (Day 4-5)

**Objective**: Create and maintain central agent name registry.

#### 4.6.1 Create Registry File

Location: `docs-paperclip/schema/agent-name-registry.md`

Format:
```markdown
# Agent Name Registry

**Purpose**: Track all agent names across companies to ensure global uniqueness.
**Last Updated**: 2026-04-22

## PaperclipForge AI
| Name | Role | Status | Registered |
|------|------|--------|------------|
| maya-paperclipforge | COO | Active | 2026-04-22 |

## MeasureForge AI
| Name | Role | Status | Registered |
|------|------|--------|------------|
| master-measureforge | Chief Measurement Orchestrator | Active | 2026-04-22 |
```

#### 4.6.2 Update Procedures

Update `docs-paperclip/procedures/agents/adding-companies-and-agents.md` to:
1. Check name registry before assigning new agent names
2. Add new names to registry upon registration
3. Enforce `{human-name}-{company-slug}` pattern

**Deliverable**: Central name registry with update procedures

---

## 5. Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Data loss during cleanup | Low | High | Full database backup before any changes |
| Breaking existing integrations | Medium | High | Update all references in scripts and configs |
| Name conflicts with other companies | Low | Medium | Check name registry before assignment |
| SQL script execution failure | Medium | Medium | Test in development environment first |
| Agent downtime during migration | High | Low | Schedule during maintenance window |

---

## 6. Rollback Plan

1. **Pre-migration backup**: Full database dump before any changes
2. **Rollback script**: `scripts/database/rollback-agent-migration.sql` that restores original names
3. **Verification queries**: Post-migration checks to confirm success
4. **Rollback trigger**: If >5% of agents fail migration, rollback entire batch

---

## 7. Success Criteria

- [ ] Zero duplicate agent names in database ❌ BLOCKED - duplicates exist, run `find-duplicate-agent-names.sql`
- [ ] All agent names follow `{human-name}-{company-slug}` pattern (3 renamed: molly, vera, stella)
- [ ] All agent names are globally unique across companies
- [x] MeasureForge tiered SQL script executes without errors ✅ COMPLETED 2026-04-22
- [x] **10 tiered coordination agents registered** ✅ COMPLETED 2026-04-22
- [ ] **ALL 39 MeasureForge AI agents registered** (10 coordinators + 22 specialists script ready)
- [ ] All expected PaperclipForge AI agents registered
- [ ] Proper `reports_to` hierarchy established for MeasureForge agents
- [ ] Unique constraint on `agents.name` enforced ❌ BLOCKED - duplicates must be resolved first
- [x] Name registry document created and populated ✅ COMPLETED 2026-04-22
- [x] Agent registration procedures updated ✅ COMPLETED 2026-04-22

---

## 8. Timeline

| Phase | Duration | Dependencies |
|-------|----------|-------------|
| Phase 1: Database Audit & Cleanup | 0.5 day | None |
| Phase 2: Fix MeasureForge SQL | 0.5 day | Phase 1 |
| Phase 3: Name Standardization | 1 day | Phase 1, 2 |
| Phase 4: Missing Agent Registration | 1 day | Phase 3 |
| Phase 5: Unique Constraint | 0.5 day | Phase 4 |
| Phase 6: Documentation | 0.5 day | Phase 5 |
| **Total** | **4 days** | |

---

## 9. Approval

| Role | Name | Status | Date |
|------|------|--------|------|
| Plan Author | Hermes Agent | Draft | 2026-04-22 |
| Engineering Review | TBD | Pending | |
| Database Admin | TBD | Pending | |
| Company CEOs | TBD | Pending | |

---

## Appendix A: SQL Syntax Error Details

### Broken Pattern (Lines 166, 230, 290, 350, 410, 470, 530, 590)

```sql
-- Current broken code:
) VALUES (
  gen_random_uuid(),
  ...
) SELECT ... WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = '([^']*)'))
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  ...
```

This is invalid SQL because:
1. `VALUES` clause cannot be followed by `SELECT`
2. `EXCLUDED` reference requires `ON CONFLICT` clause
3. Regex pattern `([^']*)` is not valid SQL syntax

### Correct Pattern

```sql
-- Option A: INSERT ... SELECT ... WHERE NOT EXISTS (recommended)
INSERT INTO agents (id, company_id, name, ...)
SELECT
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'agent-name',
  ...
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = 'agent-name');

-- Option B: INSERT ... ON CONFLICT (requires unique constraint)
INSERT INTO agents (id, company_id, name, ...)
VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'MeasureForge AI'),
  'agent-name',
  ...
) ON CONFLICT (name) DO UPDATE SET
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  ...
  updated_at = EXCLUDED.updated_at;
```

---

## Appendix B: Future Refinements & Known Issues

### B.1 Schema Drift Issue - `agent_skill_assignments` Table

**Issue**: The `agent_skill_assignments` table exists in the production database but is NOT defined in `packages/db/src/schema/index.ts`.

**Impact**: 
- SQL deletion scripts must manually account for this table
- Schema documentation is incomplete
- Future migrations may miss this table

**Discovered**: 2026-04-22 during agent duplicate cleanup
**Error**: `ERROR: 23503: update or delete on table "agents" violates foreign key constraint "agent_skill_assignments_agent_id_fkey"`

**Workaround**: 
- Added deletion step in `scripts/database/remove-agent-duplicates.sql` (step 8b)
- Documented in `docs-paperclip/schema/constraints/FK-DEPENDENCY-LEVELS.md`

**Recommended Fix** (Future Work):
1. Add `agent_skill_assignments` table definition to `packages/db/src/schema/index.ts`
2. Generate migration to formalize the table structure
3. Update all schema documentation
4. Add to standard deletion templates

**Priority**: Medium - Workaround is functional but schema drift should be resolved

### B.2 Duplicate Agent Cleanup Execution Issues

**Issue**: The `remove-agent-duplicates.sql` script encountered multiple execution errors during testing:
1. Subquery returning multiple rows (fixed)
2. Missing FK table `agent_skill_assignments` (workaround added)
3. Temp table persistence across statement executions (fixed with `DROP TABLE IF EXISTS`)

**Current Status**: Script is syntactically correct but has not been successfully executed in production due to ongoing errors.

**Recommendation**: 
- Manual duplicate cleanup via UI or direct database access
- OR comprehensive testing in staging environment before production execution
- Consider breaking script into smaller, independently testable chunks

**Priority**: High - Blocking Phase 5 (unique constraint enforcement)
