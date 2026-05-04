---
id: SAFETY-012
title: "02400 Training Records — Certification Tracking & Compliance"
phase: "Phase 4 — Advanced"
status: open
priority: medium
platform: desktop
blocked_by: []
depends_on: [SAFETY-007, SAFETY-008, SAFETY-009]
parent_goal: SAFETY-INCIDENTS-2026
due_date: 2026-05-20
---

# SAFETY-012: 02400 Training Records — Certification Tracking & Compliance

## Executive Summary

Implement the training records and certification tracking system, enabling safety managers to manage employee training requirements, track certification expiry, and ensure compliance with mandatory safety training obligations.

## Problem Statement / Scope

Regulatory compliance requires that employees and contractors maintain current safety training certifications. Without a tracking system, expired certifications may go unnoticed, leading to compliance violations. Scope includes:

- Training record creation: employee/contractor, training type, completion date, expiry date, provider
- Certification expiry tracking with RAG status (valid 🟢, due soon 🟡, expired 🔴)
- Automated notifications for upcoming and overdue renewals
- Training requirement matrix: role × training type mapping
- Bulk import of training records (CSV/PDF)
- Training compliance dashboard: % up-to-date by department, role, contractor
- Integration with incident investigation (training gap analysis)

## Required Actions

| # | Action | Detail |
|---|--------|--------|
| 1 | Design training record data model | Training ID, trainee, type, completion date, expiry date, provider, status |
| 2 | Build training record CRUD | Create/edit/delete training records with form validation |
| 3 | Implement expiry tracking engine | Auto-calculate RAG status based on expiry date relative to current date |
| 4 | Build training requirement matrix | Role × training type mapping with configurable requirements |
| 5 | Implement bulk import | CSV upload with column mapping, validation, and error reporting |
| 6 | Build training compliance dashboard | % up-to-date by department, role, contractor with drill-down |
| 7 | Add expiry notifications | Automated alerts for upcoming (30 days) and overdue renewals |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Supporting:** devforge-ai-workflow-developer, guardian-qualityforge

## Required Skills

- Data model design for training records
- CSV import with validation
- Expiry date calculation and RAG status logic
- Dashboard and chart implementation
- Notification integration

## Acceptance Criteria

- [ ] Training records can be created, edited, and deleted
- [ ] Expiry tracking shows correct RAG status (valid/due soon/expired)
- [ ] Training requirement matrix maps roles to required training types
- [ ] Bulk import processes CSV with validation and error reporting
- [ ] Training compliance dashboard shows % up-to-date with drill-down
- [ ] Expiry notifications trigger at 30 days before and on expiry date
- [ ] Training records are linked to employees and contractors
- [ ] Training gap analysis available in incident investigation

## Dependencies

- BLOCKED BY: SAFETY-007, SAFETY-008, SAFETY-009
- BLOCKS: SAFETY-013, SAFETY-014, SAFETY-015

## Estimated Duration

- **Estimated Hours:** 24 hours
- **Complexity:** Medium
- **Timeline:** 3 business days

## Risk Level

**Medium** — Expired training certifications pose compliance risk; tracking system mitigates this.

## QC Team Checks

- [ ] RAG status updates correctly based on expiry date
- [ ] CSV import handles malformed rows with clear error messages
- [ ] Training requirement matrix is configurable without code changes
- [ ] Dashboard drill-down navigates to filtered training list
- [ ] Notification timing is configurable
- [ ] Training records are immutable after verification (audit trail)
