---
id: SAFETY-010
title: "02400 Investigation Workflow — Root Cause Analysis & Findings"
phase: "Phase 4 — Advanced"
status: open
priority: medium
platform: desktop
blocked_by: []
depends_on: [SAFETY-007, SAFETY-008, SAFETY-009]
parent_goal: SAFETY-INCIDENTS-2026
due_date: 2026-05-20
---

# SAFETY-010: 02400 Investigation Workflow — Root Cause Analysis & Findings

## Executive Summary

Implement the structured investigation workflow for safety incidents, guiding investigators through root cause analysis (RCA), evidence collection, findings documentation, and report generation.

## Problem Statement / Scope

Safety incidents requiring investigation need a structured, repeatable process to ensure thorough root cause analysis and proper documentation. Without a formal workflow, investigations may miss critical factors. Scope includes:

- Investigation assignment and scope definition
- Evidence collection: photos, witness statements, equipment records, training records
- Root cause analysis using 5-Whys and Fishbone diagram templates
- Findings documentation with severity and contributing factors
- Investigation report generation (PDF export)
- Investigation status tracking: Assigned → In Progress → Under Review → Complete
- Integration with incident detail view (Investigation tab)

## Required Actions

| # | Action | Detail |
|---|--------|--------|
| 1 | Design investigation data model | Investigation ID, assigned investigator, scope, status, findings, evidence |
| 2 | Build investigation assignment flow | Assign investigator modal with scope definition and deadline |
| 3 | Implement evidence collection UI | Photo upload, witness statement forms, equipment record links, training record links |
| 4 | Build RCA tools | 5-Whys template, Fishbone diagram (Mermaid), contributing factor categorization |
| 5 | Implement findings documentation | Finding description, severity, contributing factors, recommended actions |
| 6 | Build investigation report generator | PDF report with all investigation data, export from Investigation tab |
| 7 | Wire to incident detail | Investigation tab shows investigation progress and findings |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Supporting:** guardian-qualityforge, devforge-ai-workflow-developer

## Required Skills

- Investigation workflow design
- Root cause analysis methodology (5-Whys, Fishbone)
- PDF report generation
- Evidence management (file uploads, metadata)
- Mermaid diagram integration for Fishbone

## Acceptance Criteria

- [ ] Investigation can be assigned with scope and deadline
- [ ] Evidence collection supports photos, witness statements, equipment records
- [ ] 5-Whys template guides user through root cause analysis
- [ ] Fishbone diagram renders via Mermaid with editable categories
- [ ] Findings documentation captures severity and contributing factors
- [ ] Investigation report generates as PDF with all investigation data
- [ ] Investigation status tracks through complete workflow
- [ ] Investigation tab on incident detail shows current state

## Dependencies

- BLOCKED BY: SAFETY-007, SAFETY-008, SAFETY-009
- BLOCKS: SAFETY-013, SAFETY-014, SAFETY-015

## Estimated Duration

- **Estimated Hours:** 32 hours
- **Complexity:** High
- **Timeline:** 4 business days

## Risk Level

**Medium** — Incomplete investigations could miss root causes; structured workflow mitigates this risk.

## QC Team Checks

- [ ] 5-Whys template enforces sequential reasoning
- [ ] Fishbone diagram renders correctly in Mermaid
- [ ] Evidence upload handles multiple file types
- [ ] PDF report includes all investigation sections
- [ ] Investigation status transitions are enforced
- [ ] Evidence is linked to investigation and not orphaned
