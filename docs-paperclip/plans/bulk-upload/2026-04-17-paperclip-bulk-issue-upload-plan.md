---
plan_id: BULK-ISSUE-UPLOAD-20260417
title: Paperclip Bulk Issue Upload Plan — Multi-Project Validation & Submission
created_date: 2026-04-17
status: draft
author: AI Coordinator
review_cycle: daily
---

# Paperclip Bulk Issue Upload Plan

## Overview

This plan outlines the methodology for validating and bulk uploading project issues to Paperclip for the following projects across multiple disciplines.

**Total**: 9 projects, 113 issues

**Strategy**: Bulk uploads per project, with validation before submission.

---

## Phase 1: Pre-Upload Validation Checklist

### 1.1 File Structure Validation

For each project, verify:

- [ ] `issues/` directory exists
- [ ] Issue files follow naming pattern: `{PREFIX}-{NUMBER}-{slug}.md`
- [ ] `project.md` exists at project root
- [ ] `knowledge/PAGE-KNOWLEDGE.md` exists (if applicable)

### 1.2 Frontmatter Validation

Each issue file must have these required fields:

```yaml
---
id: PROJ-NNN              # REQUIRED: Issue identifier (PREFIX-NUMBER)
title: Clear description  # REQUIRED: Descriptive title
status: todo              # REQUIRED: backlog|todo|in_progress|in_review|done|blocked
priority: high            # REQUIRED: critical|high|medium|low
assignee: agent-slug      # REQUIRED: Assigned agent
company: company-slug     # REQUIRED: Company ownership (e.g., devforge-ai)
created_date: YYYY-MM-DD  # REQUIRED: Creation date
due_date: YYYY-MM-DD      # REQUIRED: Due date
estimated_hours: N        # REQUIRED: Estimated hours
---
```

---

## Phase 2: Project-by-Project Submission

### 2.1 UNIV-WORKFLOW (workflows-common)

**Path**: `disciplines/workflows-common/projects/UNIV-WORKFLOW/desktop/issues/`

**Status**: 28 issues generated across 6 phases

**Submission Steps**:
1. [ ] Validate all 28 issue frontmatter
2. [ ] Batch upload in phase order

---

### 2.2 SECURITY-ASSET (02500-security)

**Path**: `disciplines/02500-security/projects/SECURITY-ASSET/desktop/issues/`

**Status**: 8 issues generated

**Submission Steps**:
1. [ ] Validate all 8 issue frontmatter
2. [ ] Batch upload

---

### 2.3 SAFETY Projects (02400-safety)

**Parent Path**: `disciplines/02400-safety/projects/`

Each SAFETY project needs desktop issues generated, and some need mobile issues:

| Project Folder | Desktop Issues | Mobile Issues | Notes |
|----------------|---------------|---------------|-------|
| SAFETY-CONTRACTOR | 5 issues | TBD | Desktop ready |
| SAFETY-EMERGENCY | 5 issues | TBD | Desktop ready |
| SAFETY-HAZARD | TBD |  TBD | Needs both |
| SAFETY-HEALTH | TBD | TBD | Needs both |
| SAFETY-INCIDENT | TBD | TBD | Needs both |
| SAFETY-INSPECTION | TBD | TBD | Needs both |
| SAFETY-PPE | TBD | TBD | Needs both |
| SAFETY-RESEARCH-ENHANCEMENT | 6 issues | No | Desktop ready |
| SAFETY-TRAINING | TBD | TBD | Needs both |

**Correct Path Structure:**
```
disciplines/02400-safety/projects/SAFETY-CONTRACTOR/desktop/issues/
disciplines/02400-safety/projects/SAFETY-CONTRACTOR/mobile/issues/
disciplines/02400-safety/projects/SAFETY-EMERGENCY/desktop/issues/
disciplines/02400-safety/projects/SAFETY-EMERGENCY/mobile/issues/
... (repeat for all projects)
```

**Submission Steps**:
1. [ ] Generate desktop issues for each SAFETY project (8 need generation, 1 has partial)
2. [ ] Generate mobile issues for each SAFETY project where applicable
3. [ ] Validate frontmatter for all 18+ SAFETY issue folders
4. [ ] Batch upload per project

---

### 2.4 PROC-ORDER (01900-procurement)

**Path**: `disciplines/01900-procurement/projects/PROC-001/desktop/PROC-ORDER/issues/`

**Note**: Project uses PROC-001 container with PROC-ORDER subfolder structure. Contains 25 issues ready for upload.

**Status**: 25 issues ready for upload

**Submission Steps**:
1. [ ] Validate all 25 issues have proper frontmatter
2. [ ] Batch upload issues
3. [ ] Verify upload success

---

### 2.5 CIVIL-WORKFLOW (00850-civil-engineering)

**Path**: `disciplines/00850-civil-engineering/projects/CIVIL-WORKFLOW/desktop/issues/`

**Status**: 9 workflow issues

**Submission Steps**:
1. [ ] Validate all 9 issue frontmatter
2. [ ] Batch upload

---

### 2.6 ELEC-WORKFLOW (00860-electrical-engineering)

**Path**: `disciplines/00860-electrical-engineering/projects/ELEC-WORKFLOW/desktop/issues/`

**Status**: 8 workflow issues

**Submission Steps**:
1. [ ] Validate all 8 issue frontmatter
2. [ ] Batch upload

---

### 2.7 INTEGRATION-SETTINGS-UI (02050-information-technology)

**Path**: `disciplines/02050-information-technology/projects/INTEGRATION-SETTINGS-UI/desktop/issues/`

**Status**: 5 issues generated

**Submission Steps**:
1. [ ] Validate all 5 issue frontmatter
2. [ ] Batch upload

---

### 2.8 PROD-TEST (disciplines-non/testing)

**Path**: `disciplines-non/testing/projects/PROD-TEST/desktop/issues/`

**Status**: 14 issues

**Submission Steps**:
1. [ ] Validate all 14 issue frontmatter
2. [ ] Batch upload

---

## Phase 3: Progress Tracking

See `PAPERCLIP-UPLOAD-STATUS.md`:

| Project | Issues | Validated | Uploaded | Status |
|---------|--------|-----------|----------|--------|
| UNIV-WORKFLOW | 28 | ⬜ | ⬜ | Ready |
| SECURITY-ASSET | 8 | ⬜ | ⬜ | Ready |
| SAFETY-CONTRACTOR | TBD | ⬜ | ⬜ | Needs Generation |
| SAFETY-EMERGENCY | 5 | ⬜ | ⬜ | Ready |
| SAFETY-HAZARD | TBD | ⬜ | ⬜ | Needs Generation |
| SAFETY-HEALTH | TBD | ⬜ | ⬜ | Needs Generation |
| SAFETY-INCIDENT | TBD | ⬜ | ⬜ | Needs Generation |
| SAFETY-INSPECTION | TBD | ⬜ | ⬜ | Needs Generation |
| SAFETY-PPE | TBD | ⬜ | ⬜ | Needs Generation |
| SAFETY-RESEARCH-ENHANCEMENT | 1 | ⬜ | ⬜ | Ready |
| SAFETY-TRAINING | TBD | ⬜ | ⬜ | Needs Generation |
| PROC-ORDER | 25 | ⬜ | ⬜ | Ready |
| CIVIL-WORKFLOW | 9 | ⬜ | ⬜ | Ready |
| ELEC-WORKFLOW | 8 | ⬜ | ⬜ | Ready |
| INTEGRATION-SETTINGS-UI | 5 | ⬜ | ⬜ | Ready |
| PROD-TEST | 14 | ⬜ | ⬜ | Ready |

---

## Key References

| Document | Path |
|----------|------|
| Discipline Workflow Conversion | `docs-paperclip/procedures/workflows/discipline_workflow_conversion_procedure.md` |
| Agent Assignment Guide | `docs-construct-ai/codebase/agents/paperclip-teams/` |
| Issue Template Standard | `docs-paperclip/development-paperclip/issues/` |

---

*Plan created: 2026-04-17*
*Last updated: 2026-04-17*
*Status: READY — Most projects have issues generated and ready for upload*
