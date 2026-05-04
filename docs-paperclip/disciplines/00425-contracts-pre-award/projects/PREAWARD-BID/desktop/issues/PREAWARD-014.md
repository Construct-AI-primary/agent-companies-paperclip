---
id: PREAWARD-014
title: "00425 Late Submission Handling — Configurable Policy"
phase: "5 — Compliance"
status: open
priority: Medium
blocked_by: []
depends_on: [PREAWARD-010, PREAWARD-011, PREAWARD-012]
---

# PREAWARD-014: 00425 Late Submission Handling — Configurable Policy

## Executive Summary

Implement the configurable late submission handling system for the 00425 Pre-Award page. This enables procurement officers to configure late submission policies (accept, reject, or accept with penalty), enforce submission deadlines, and manage late submissions according to organizational rules.

## Problem Statement / Scope

Tenders have strict submission deadlines, but organizations may have different policies for handling late submissions. Some may reject all late submissions, others may accept with a penalty, and some may accept under specific circumstances. Currently there is no configurable late submission policy system.

**Scope:**
- Configurable late submission policy (Accept, Reject, Accept with Penalty)
- Deadline enforcement with timezone-aware cutoff
- Late submission flagging and categorization
- Penalty calculation for accepted late submissions
- Late submission review workflow
- Audit trail for late submission decisions

## Required Actions

| # | Action | Agent Role | Expected Outcome |
|---|--------|------------|-----------------|
| 1 | Build late submission policy configuration interface | Codesmith DevForge | Users configure late submission rules per tender |
| 2 | Implement deadline enforcement with timezone-aware cutoff | DevCore DevForge | Submissions after deadline flagged as late |
| 3 | Create late submission flagging and categorization | Interface DevForge | Late submissions categorized by lateness duration |
| 4 | Build penalty calculation engine for accepted late submissions | DomainForge AI | Penalties calculated based on configurable rules |
| 5 | Implement late submission review workflow | Codesmith DevForge | Late submissions routed for review and decision |

## Assigned Company & Agent

- **Company:** DevForge AI
- **Agent:** Codesmith (codesmith-devforge) — Policy config & review workflow
- **Agent:** DevCore (devcore-devforge) — Deadline enforcement
- **Agent:** Interface (interface-devforge-api-integration) — Late flagging
- **Supporting:** DomainForge AI (procurement-domainforge) — Penalty calculation
- **Supporting:** QualityForge AI (validator-qualityforge) — Policy testing

## Required Skills

- `procurement-management` (DomainForge)
- `policy-configuration` (DevForge)
- `deadline-enforcement` (DevForge)
- `penalty-calculation` (DomainForge)
- `audit-trail` (DomainForge)

## Acceptance Criteria

- [ ] Late submission policy configurable per tender (Accept/Reject/Accept with Penalty)
- [ ] Deadline enforcement uses timezone-aware cutoff time
- [ ] Late submissions automatically flagged with lateness duration
- [ ] Late submissions categorized (minutes, hours, days late)
- [ ] Penalty calculation applies configurable percentage reduction
- [ ] Late submission review workflow routes to procurement officer
- [ ] Review decision (accept/reject) recorded with justification
- [ ] Accepted late submissions marked with penalty indicator
- [ ] Rejected late submissions returned with notification
- [ ] Audit trail maintained for all late submission decisions

## Dependencies

- BLOCKED BY: PREAWARD-010, PREAWARD-011, PREAWARD-012
- BLOCKS: None

## Estimated Duration

- **Estimated:** 4 days
- **Risk Level:** Low

## QC Team Checks

- [ ] Code review completed by DomainForge AI
- [ ] Policy configuration tested with all options
- [ ] Deadline enforcement tested with timezone edge cases
- [ ] Penalty calculation accuracy verified
- [ ] Unit tests for policy logic
- [ ] Integration test for late submission API
