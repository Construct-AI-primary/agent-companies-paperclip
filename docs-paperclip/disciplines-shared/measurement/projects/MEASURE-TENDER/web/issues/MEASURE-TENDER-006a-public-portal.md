---
delegation:
  parent_goal_id: "MEASURE-ROOT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Deliver MEASURE-TENDER subcontractor integration system"
title: "MEASURE-TENDER-006a: External Portal - Public Pages"
description: "Create public-facing pages for vendor registration, tender listings, and quotation submission"
gigabrain_tags: issue, measurement, tender, external-portal, public-pages, vendor-registration, quotation-submission
labels: ["measurement", "tender", "frontend", "web", "external", "public"]
blocked_by: []
depends_on: ["MEASURE-TENDER-001", "MEASURE-TENDER-003"]
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/web/issues
last_updated: 2026-04-25
status: backlog
phase: "3 — Enhancement & Optimization"
priority: High
story_points: 13
due_date: "2026-05-12"
assignee: loopy-ai
company: loopy-ai
team: ui
---

# MEASURE-TENDER-006a: External Portal - Public Pages

## Executive Summary

Create the **public-facing pages** for the bespoke B2B tender portal. This issue focuses on external vendor user experience: registration, tender browsing, and quotation submission. The portal serves sub-vendors, suppliers, and public users with role-specific access levels, built with Next.js 14 and shared Supabase infrastructure.

## Required Actions

| Action | Details |
|--------|---------|
| Public tender listings | `/tenders` page with filtering by trade category, value range, closing date |
| Tender detail page | `/tenders/[id]` with document download and registration CTA |
| Vendor registration | `/register` with company info, CIDB/B-BBEE, document upload, email verification |
| Quotation submission wizard | Step-by-step: company details → amount → validity → proposal → documents → review |
| Vendor dashboard | `/dashboard` with quotation status tracking and notifications |
| Authentication | `/login` with NextAuth.js and email verification |
| Mobile-responsive design | Professional construction industry aesthetic |

## Assigned Company & Agent

- **Company**: loopy-ai
- **Assignee**: loopy-ai
- **Team**: ui

## Required Skills

- Next.js 14 (App Router)
- React / TypeScript / Tailwind CSS
- NextAuth.js authentication
- Supabase database integration
- File upload and validation
- Mobile-responsive design

## Acceptance Criteria

- [ ] Public tender listing page with filtering
- [ ] Tender detail page with document download
- [ ] Vendor self-registration with document upload
- [ ] Quotation submission wizard
- [ ] Vendor dashboard (submission status)
- [ ] Email notifications for registration confirmation
- [ ] Mobile-responsive design
- [ ] Sub-vendor email verification

## Dependencies

- MEASURE-TENDER-001: Database Schema (RLS policies for public access)
- MEASURE-TENDER-003: API Routes (public endpoints)
- NextAuth.js configuration
- 03010 Email system integration

## Estimated Duration

- **Story Points**: 13
- **Estimated Hours**: 20–30 hours
- **Due Date**: 2026-05-12

## Risk Level

Medium — external-facing application with vendor registration flows; requires security review for data protection.

## QC Team Checks

- [ ] Public pages render correctly without authentication
- [ ] Vendor registration flow completes end-to-end
- [ ] Document upload validates file type and size limits
- [ ] Quotation wizard saves draft and allows resume
- [ ] Email verification link functions correctly
- [ ] Mobile-responsive layouts verified at breakpoints
- [ ] CSRF and rate limiting confirmed on submission endpoints

---

**Issue Type**: Frontend Web Application  
**Estimated Hours**: 20–30 hours  
**Agent Assignment**: loopy-ai (loopy-ai)  

**Parent**: MEASURE-TENDER-006  
**Sibling**: MEASURE-TENDER-006b (Admin Dashboard)
