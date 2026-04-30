---
delegation:
  parent_goal_id: "MEASURE-ROOT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Deliver MEASURE-TENDER subcontractor integration system"
title: "MEASURE-TENDER-006b: External Portal - Admin Dashboard"
description: "Create internal admin dashboard for contracts pre-award team: tender management, evaluation, and award workflows"
gigabrain_tags: issue, measurement, tender, external-portal, admin-dashboard, contracts-pre-award, evaluation, awards
labels: ["measurement", "tender", "frontend", "web", "external", "admin"]
blocked_by: []
depends_on: ["MEASURE-TENDER-001", "MEASURE-TENDER-003", "MEASURE-TENDER-006a"]
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/web/issues
last_updated: 2026-04-25
status: backlog
phase: "4 — Testing & Deployment"
priority: High
story_points: 21
due_date: "2026-05-15"
assignee: loopy-ai
company: loopy-ai
team: ui
---

# MEASURE-TENDER-006b: External Portal - Admin Dashboard

## Executive Summary

Create the **internal admin dashboard** for the contracts pre-award team. This issue focuses on authenticated internal user workflows: tender management, quotation evaluation, and award approvals. The dashboard serves contracts pre-award team, procurement officers, QS/measurement team, and management with role-specific capabilities.

## Required Actions

| Action | Details |
|--------|---------|
| Tender management | Create/edit/publish tenders from BOQ or manual entry |
| Contracts pre-award dashboard | Active tenders, pending evaluations, award recommendations |
| Quotation evaluation | Side-by-side comparison with multi-criteria scoring matrix (technical 40%, commercial 40%, B-BBEE 20%) |
| Award workflow | Management approval queue, award letter generation, vendor notifications |
| Vendor management | Registered vendor list, prequalification status, document verification, compliance tracking |
| SSO integration | Single sign-on with ConstructAI for internal users |
| Audit trail | Logging for all admin actions |

## Assigned Company & Agent

- **Company**: loopy-ai
- **Assignee**: loopy-ai
- **Team**: ui

## Required Skills

- Next.js 14 (App Router)
- React / TypeScript / Tailwind CSS
- NextAuth.js with SSO
- Data visualization (scoring charts)
- Role-based access control
- Document management

## Acceptance Criteria

- [ ] Internal admin dashboard for contracts team
- [ ] Tender create/edit/publish workflows
- [ ] Multi-criteria evaluation matrix
- [ ] Quotation comparison visualization
- [ ] Award workflow with approvals
- [ ] Vendor management interface
- [ ] Email notifications for all key events
- [ ] SSO with ConstructAI for internal users
- [ ] Audit trail for compliance

## Dependencies

- MEASURE-TENDER-001: Database Schema (RLS policies)
- MEASURE-TENDER-003: API Routes (admin endpoints)
- MEASURE-TENDER-006a: Public Portal (shared components)
- NextAuth.js configuration with SSO
- 03010 Email system integration

## Estimated Duration

- **Story Points**: 21
- **Estimated Hours**: 20–30 hours
- **Due Date**: 2026-05-15

## Risk Level

Medium — internal tool with procurement data handling; requires RBAC and audit trail enforcement.

## QC Team Checks

- [ ] Admin dashboard loads with correct role-based menus
- [ ] Tender create/publish flow completes end-to-end
- [ ] Evaluation matrix scores calculate correctly
- [ ] Award approval workflow enforces required approvers
- [ ] SSO login redirects correctly from ConstructAI
- [ ] Audit logs capture all admin actions
- [ ] Shared components from MEASURE-TENDER-006a remain functional

---

**Issue Type**: Frontend Web Application  
**Estimated Hours**: 20–30 hours  
**Agent Assignment**: loopy-ai (loopy-ai)  

**Parent**: MEASURE-TENDER-006  
**Sibling**: MEASURE-TENDER-006a (Public Pages)
