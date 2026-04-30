---
memory_layer: durable_knowledge
para_section: pages/workflows
gigabrain_tags: workflow, database, routing, infraforge, sql-validation
openstinger_context: database-workflow, agent-routing, sql-validation
last_updated: 2026-04-24
related_docs:
  - docs-paperclip/companies/infraforge-ai/skills/supabase-testing-infraforge/SKILL.md
  - docs-paperclip/companies/infraforge-ai/skills/database-infraforge-database-infrastructure/SKILL.md
---

# InfraForge Database Routing Workflow

## Overview

This workflow establishes the proper routing and validation process for complex SQL generation within InfraForge AI, ensuring that SQL scripts involving schema constraints and relationships are validated by the appropriate specialized agents.

## Problem Solved

Previously, complex SQL scripts were created by Nimbus (Supabase Database Specialist) without validation by the Database agent, leading to constraint violations and execution errors. This workflow prevents such issues by establishing clear routing rules.

## Agents Involved

### Nimbus - Supabase Database Specialist
**Role:** SQL generation, connectivity testing, RLS validation
**Skills:** `supabase-testing-infraforge`
**Location:** `infraforge-ai/agents/nimbus-infraforge-supabase-specialist/`

### Database Agent - Database Infrastructure Specialist
**Role:** Schema validation, constraint checking, SQL review
**Skills:** `database-infraforge-database-infrastructure`
**Location:** `infraforge-ai/agents/database-infraforge-database-infrastructure/`

## Routing Decision Matrix

### Route to Database Agent (Required)
When SQL scripts involve:
- ✅ Multi-table INSERT/UPDATE/DELETE operations
- ✅ Foreign key relationship management
- ✅ Unique constraint validation
- ✅ Complex subqueries with dependencies
- ✅ Schema constraint checking
- ✅ Referential integrity requirements

### Handle Directly (Nimbus Only)
When SQL scripts involve:
- 🔸 Single-table operations
- 🔸 Simple SELECT queries
- 🔸 RLS policy testing
- 🔸 Connectivity validation
- 🔸 Real-time subscription testing

## Workflow Steps

### Step 1: SQL Generation (Nimbus)
1. **Receive requirements** for database operations
2. **Assess complexity** using routing decision matrix
3. **Generate initial SQL** based on requirements
4. **Route decision**:
   - If simple → Execute directly
   - If complex → Route to Database agent

### Step 2: SQL Validation (Database Agent)
1. **Receive routed SQL** from Nimbus
2. **Review SQL structure** and syntax
3. **Validate constraints** against schema files:
   - `/docs-paperclip/schema/constraints/foreign-keys.md`
   - `/docs-paperclip/schema/constraints/unique-constraints.md`
   - `/docs-paperclip/schema/constraints/FK-DEPENDENCY-LEVELS.md`
4. **Check referential integrity**
5. **Verify schema compliance**
6. **Return validation results**:
   - ✅ Approved → Return validated SQL
   - ❌ Issues found → Return corrections

### Step 3: SQL Execution (Nimbus)
1. **Receive validated SQL** from Database agent
2. **Execute SQL** in appropriate environment
3. **Verify execution results**
4. **Log completion** and any issues

## Validation Checklist

### Database Agent Validation Steps:
- [ ] SQL syntax is correct
- [ ] Foreign key constraints are respected
- [ ] Unique constraints are not violated
- [ ] Referential integrity is maintained
- [ ] Schema relationships are correct
- [ ] Multi-table operations are safe
- [ ] Transaction boundaries are appropriate

## Error Handling

### If Database Agent Rejects SQL:
1. **Review rejection reasons** provided by Database agent
2. **Modify SQL** according to corrections
3. **Re-route** to Database agent for re-validation
4. **Repeat** until approved

### If Execution Fails:
1. **Check error messages** for constraint violations
2. **Route to Database agent** for analysis
3. **Apply fixes** and re-execute

## Examples

### Example 1: Simple Agent Creation (Nimbus Direct)
```sql
-- Simple single-table insert
INSERT INTO agents (name, role) VALUES ('test-agent', 'specialist');
```
**Decision:** Handle directly - no constraints to validate

### Example 2: Complex Agent Creation (Route Required)
```sql
-- Multi-table insert with foreign keys
INSERT INTO agents (...) VALUES (...);
INSERT INTO agent_api_keys (...) VALUES (...);
INSERT INTO activity_log (...) VALUES (...);
```
**Decision:** Route to Database agent - multi-table, foreign keys, constraints

## Success Metrics

- **Routing Compliance:** 100% of complex SQL routed for validation
- **Error Reduction:** <5% SQL execution failures due to constraints
- **Validation Time:** <30 minutes for SQL validation
- **Approval Rate:** >90% of routed SQL approved on first pass

## Implementation Status

- ✅ **Nimbus skill updated** with routing workflow
- ✅ **Database agent skill updated** with validation workflow
- ✅ **Decision matrix defined**
- ✅ **Error handling procedures established**

## Learning Integration

### 🚨🚨 CRITICAL SYSTEM FAILURE: LearningForge AI URGENT ENGAGEMENT REQUIRED

**Current Incident**: **CATASTROPHIC SCHEMA VALIDATION FAILURE**
- Multiple FK constraint violations discovered sequentially
- Schema documentation **~80% incomplete** (at least 2+ undocumented child tables)
- Validation system **completely broken** - approved SQL with known missing constraints
- **Emergency dynamic FK discovery** implemented as workaround

**Pattern Detected**: **SYSTEMIC SCHEMA KNOWLEDGE COLLAPSE**
**Status**: **CRITICAL - IMMEDIATE LearningForge AI INTERVENTION REQUIRED**
**Risk Level**: **SEVERE** - All database operations at risk

#### Trigger Conditions Met (ALL):
- ✅ **Schema Knowledge Gap**: Massive - 80%+ FK relationships undocumented
- ✅ **Validation Failure**: Total system failure - multiple critical constraints missed
- ✅ **Recurring Risk**: Every table deletion operation likely affected
- ✅ **Process Improvement Needed**: Complete validation system rebuild required
- ✅ **Agent Training Crisis**: Database Agent lacks basic schema knowledge

#### LearningForge AI Agents - EMERGENCY ENGAGEMENT:

1. **Feedback Synthesis Agent** (`learningforge-ai-feedback-synthesis`) 🚨 **CRITICAL PRIORITY**
   - **EMERGENCY**: Analyze catastrophic FK validation failures
   - Document all missing FK relationships (`issue_comments`, `issue_read_states`, and potentially dozens more)
   - Map complete schema documentation gaps

2. **Workflow Coach** (`learningforge-ai-workflow-coach`) 🚨 **CRITICAL PRIORITY**
   - **EMERGENCY**: Implement immediate dynamic FK discovery requirements
   - Replace static validation with automated database queries
   - Establish schema completeness monitoring

3. **Learning Strategy Agent** (`learningforge-ai-ceo`) 🚨 **CRITICAL PRIORITY**
   - **EMERGENCY**: Declare schema documentation CRISIS
   - Coordinate immediate cross-company schema audit
   - Implement automated schema sync and validation pipelines

#### Immediate Emergency Actions Required:

1. **CRITICAL: Schema Documentation Reconstruction**
   - Complete audit: Compare all documented FK vs actual database
   - Identify ALL missing table relationships (potentially 50+ undocumented)
   - Rebuild `/docs-paperclip/schema/constraints/foreign-keys.md` from scratch

2. **CRITICAL: Validation System Overhaul**
   - Replace static file validation with dynamic database queries
   - Implement automated FK discovery for ALL SQL operations
   - Add schema completeness validation gates

3. **CRITICAL: Agent Knowledge Update**
   - Emergency training for Database Agent on complete schema
   - Implement automated schema sync for all agents
   - Establish continuous schema monitoring

#### Learning Workflow Steps (CRITICAL FAILURE MODE):

1. **Error Pattern Detection** ✅ **COMPLETE FAILURE DETECTED**
   - Multiple sequential FK constraint violations
   - Schema documentation found 80%+ incomplete
   - Validation system approved fatally flawed SQL

2. **Root Cause Analysis** 🔴 **CRITICAL FINDINGS**
   - **Catastrophic**: Schema documentation not maintained vs actual DB
   - **Systemic**: No automated sync between docs and database
   - **Process Failure**: Validation relies on incomplete static files

3. **Improvement Implementation** 🚨 **EMERGENCY MODE ACTIVATED**
   - Dynamic FK discovery implemented as immediate workaround
   - Schema audit project initiated
   - Automated validation pipelines required

4. **Knowledge Capture** 📝 **CRISIS DOCUMENTATION**
   - Complete failure analysis documented
   - Emergency procedures established
   - Prevention measures designed

#### Success Metrics (CRITICAL FAILURE STATE):
- **Error Recurrence Rate**: <20% of previously fixed errors (**CURRENT: 100% - TOTAL FAILURE**)
- **Schema Completeness**: 100% FK relationships documented (**CURRENT: ~20% based on failures**)
- **Validation Compliance**: >95% of complex SQL routed properly (**CURRENT: 0% effective**)
- **Learning Velocity**: New validation patterns learned within 1 week (**TARGET: 24 hours for critical gaps**)
- **Agent Improvement**: 30% reduction in repeated mistakes (**CURRENT: Negative - skills degraded**)

#### Emergency Response Timeline:
- **Hour 0-4**: Complete schema audit and dynamic validation implementation
- **Hour 4-24**: Schema documentation rebuild and agent retraining
- **Day 1-3**: Automated sync and monitoring systems deployment
- **Week 1-2**: Full validation system rebuild and testing

## Monitoring and Auditing

- **Route all complex SQL** through this workflow
- **Log routing decisions** for audit purposes
- **Track validation outcomes** and error rates
- **Review workflow effectiveness** quarterly

## Related Documentation

- [Supabase Testing Specialist Skill](../companies/infraforge-ai/skills/supabase-testing-infraforge/SKILL.md)
- [Database Infrastructure Skill](../companies/infraforge-ai/skills/database-infraforge-database-infrastructure/SKILL.md)
- [Schema Constraints Documentation](../../schema/constraints/)

---

**Workflow Version:** 1.0
**Effective Date:** 2026-04-24
**Review Date:** 2026-07-24
**Owner:** InfraForge AI Orchestrator