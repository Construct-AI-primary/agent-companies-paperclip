---
id: MEASURE-TENDER-001
title: Database Schema & RLS Policies
description: Create 6 parallel database tables for subcontractor tender integration with clean RLS policies from day 1
labels: ["measurement", "tender", "database", "critical"]
blocked_by: []
depends_on: []
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/shared/issues
phase: "1 — Foundation"
status: backlog
priority: Critical
story_points: 13
due_date: "2026-05-01"
assignee: database-infraforge
company: infraforge-ai
delegation:
  parent_goal_id: "MEASURE-ROOT-2026"
  delegation_prompt: "Design and implement 6 parallel database tables for the subcontractor tender integration system with RLS policies, indexes, and migration scripts."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Deliver a secure, isolated database schema for MEASURE-TENDER subcontractor integration"
  agent_goal: "As database-infraforge, create 6 parallel tables with RLS policies and indexes, ensuring security separation from gov.za integration tables"
  task_goal: "Execute schema migration with all 6 tables created, RLS enabled, indexes built, and rollback script generated"
---

# MEASURE-TENDER-001: Database Schema & RLS Policies

## Executive Summary

Create the 6 parallel database tables for the Subcontract Tender Integration System (Option B architecture). This is a **security-first design** with RLS policies enforced from day 1 to prevent cross-contamination with the existing gov.za tender integration tables.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1A | Create subcontract_portal_sources table | Portal/source configuration table created with RLS |
| 1B | Create subcontract_rfq_sync_history table | Sync audit trail table created with RLS |
| 1C | Create subcontract_rfq_error_logs table | Error tracking table created with RLS |
| 1D | Create subcontract_rfqs table | Main RFQ tender data table created with RLS |
| 1E | Create subcontractor_prequalification table | Subcontractor prequal records table created with RLS |
| 1F | Create quotation_comparisons table | Bid comparison matrix table created with RLS |
| 1G | Create indexes for common query patterns | Indexes on org_id, status, trade_category |
| 1H | Write and test rollback script | Rollback drops all 6 tables cleanly |

## Assigned Company & Agent

- **Company:** infraforge-ai
- **Agent:** database-infraforge (Database Administrator)
- **Sub-agents:** None

## Required Skills

- database-administration
- sql-migration
- rls-policy-design
- supabase-administration

## Acceptance Criteria

- [ ] All 6 tables created with correct schema (UUID PKs, organization_id FK, timestamps)
- [ ] All tables have RLS enabled and proper organization-scoped policies
- [ ] Foreign key relationships verified (subcontract_rfqs → subcontractor_prequalification, etc.)
- [ ] Indexes created for org_id, status, trade_category query patterns
- [ ] Test queries confirm no cross-tenant access
- [ ] Migration script generated and tested
- [ ] Rollback script generated and tested
- [ ] Separate credential encryption from gov.za integration tables

## Dependencies

- Requires existing `organizations(id)` table
- Requires existing `users(id)` table
- Must NOT depend on gov.za integration tables

## Estimated Duration

8-12 hours

## Risk Level

Critical — database schema is foundational; all other issues depend on it

## QC Team Checks

- [ ] **subcontract_portal_sources:** Verify credentials_encrypted field + rate_limit_per_minute constraints
- [ ] **subcontract_rfq_sync_history:** Verify sync_type, records_processed, status fields
- [ ] **subcontract_rfq_error_logs:** Verify retry_count + resolved_at tracking
- [ ] **subcontract_rfqs:** Verify all 4 tender_type values accepted, boq_reference_id FK
- [ ] **subcontractor_prequalification:** Verify trade_categories GIN index, expiry_date constraints
- [ ] **quotation_comparisons:** Verify recommended_for_award BOOLEAN, overall_score DECIMAL constraints
- [ ] **RLS isolation:** Confirm organization-scoped policies work for SELECT/INSERT/UPDATE/DELETE