---
status_tracker_id: UPLOAD-STATUS-20260417
title: Paperclip Bulk Upload Status Tracker
created_date: 2026-04-17
last_updated: 2026-04-17
---

# Paperclip Bulk Upload Status Tracker

## Summary

| Project | Path | Total Issues | Validated | Uploaded | Status |
|---------|------|-------------|-----------|----------|--------|
| UNIV-WORKFLOW | `disciplines/workflows-common/projects/UNIV-WORKFLOW/desktop/issues/` | 28 | ⬜ | ⬜ | Ready |
| SECURITY-ASSET | `disciplines/02500-security/projects/SECURITY-ASSET/desktop/issues/` | 8 | ⬜ | ⬜ | Ready |
| SAFETY-CONTRACTOR | `disciplines/02400-safety/projects/SAFETY-CONTRACTOR/desktop/issues/` | 5 | ⬜ | ⬜ | Ready |
| SAFETY-EMERGENCY | `disciplines/02400-safety/projects/SAFETY-EMERGENCY/desktop/issues/` | 5 | ⬜ | ⬜ | Ready |
| SAFETY-HAZARD | `disciplines/02400-safety/projects/SAFETY-HAZARD/desktop/issues/` | TBD | ⬜ | ⬜ | Needs Generation |
| SAFETY-HEALTH | `disciplines/02400-safety/projects/SAFETY-HEALTH/desktop/issues/` | TBD | ⬜ | ⬜ | Needs Generation |
| SAFETY-INCIDENT | `disciplines/02400-safety/projects/SAFETY-INCIDENT/desktop/issues/` | TBD | ⬜ | ⬜ | Needs Generation |
| SAFETY-INSPECTION | `disciplines/02400-safety/projects/SAFETY-INSPECTION/desktop/issues/` | TBD | ⬜ | ⬜ | Needs Generation |
| SAFETY-PPE | `disciplines/02400-safety/projects/SAFETY-PPE/desktop/issues/` | TBD | ⬜ | ⬜ | Needs Generation |
| SAFETY-RESEARCH-ENHANCEMENT | `disciplines/02400-safety/projects/SAFETY-RESEARCH-ENHANCEMENT/desktop/issues/` | 6 | ⬜ | ⬜ | Ready |
| SAFETY-TRAINING | `disciplines/02400-safety/projects/SAFETY-TRAINING/desktop/issues/` | TBD | ⬜ | ⬜ | Needs Generation |
| PROC-ORDER | `disciplines/01900-procurement/projects/PROC-001/desktop/PROC-ORDER/issues/` | 25 | ⬜ | ⬜ | Ready |
| CIVIL-WORKFLOW | `disciplines/00850-civil-engineering/projects/CIVIL-WORKFLOW/desktop/issues/` | 9 | ⬜ | ⬜ | Ready |
| ELEC-WORKFLOW | `disciplines/00860-electrical-engineering/projects/ELEC-WORKFLOW/desktop/issues/` | 8 | ⬜ | ⬜ | Ready |
| INTEGRATION-SETTINGS-UI | `disciplines/02050-information-technology/projects/INTEGRATION-SETTINGS-UI/desktop/issues/` | 5 | ⬜ | ⬜ | Ready |
| PROD-TEST | `disciplines-non/testing/projects/PROD-TEST/desktop/issues/` | 14 | ⬜ | ⬜ | Ready |

**Total Issues**: 113 (excluding TBD counts)
**Completed**: 0 / 16 projects (0%)
**Overall Progress**: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ 0%

---

## SAFETY Projects Correct Path Structure

Each SAFETY project needs **both desktop and mobile** issues:
`disciplines/02400-safety/projects/{SAFETY-PROJECT}/desktop/issues/`
`disciplines/02400-safety/projects/{SAFETY-PROJECT}/mobile/issues/`

| Project | Desktop Status | Mobile Status |
|---------|---------------|---------------|
| SAFETY-CONTRACTOR | Has 5 issues | Needs creation + issues |
| SAFETY-EMERGENCY | Has 5 issues | Needs creation + issues |
| SAFETY-HAZARD | Empty | Needs creation + issues |
| SAFETY-HEALTH | Empty | Needs creation + issues |
| SAFETY-INCIDENT | Empty | Needs creation + issues |
| SAFETY-INSPECTION | Empty | Needs creation + issues |
| SAFETY-PPE | Empty | Needs creation + issues |
| SAFETY-RESEARCH-ENHANCEMENT | Has 6 issues | No mobile needed |
| SAFETY-TRAINING | Empty | Needs creation + issues |

---

## Change Log

| Date | Project | Action | Notes |
|------|---------|--------|-------|
| 2026-04-17 | All | Initial tracking created | Plan document updated with correct paths |
| 2026-04-17 | Safety | Clarified path structure | SAFETY-* projects are under PROC-001/desktop/ |
| 2026-04-17 | INTEGRATION-SETTINGS-UI | Project created | 5 issues generated for third-party tool integration UI |
| 2026-04-17 | All Projects | Status updated | Verified actual issue counts and marked ready projects |

---

## Validation Requirements Summary

### Required Frontmatter Fields (per issue)
1. `id` - Issue identifier (PREFIX-NUMBER)
2. `title` - Descriptive title
3. `status` - backlog|todo|in_progress|in_review|done|blocked
4. `priority` - critical|high|medium|low
5. `assignee` - Agent slug
6. `company` - Company slug (e.g., devforge-ai)
7. `created_date` - YYYY-MM-DD format
8. `due_date` - YYYY-MM-DD format
9. `estimated_hours` - Numeric value

---

*Last Updated: 2026-04-17*
*Tracking Started: 2026-04-17*