---
id: PROCURE-004
title: 01900 Upserts State — Cloud, URL & File Upserts
description: Verify Upserts state and all 3 upsert modals (Cloud, URL, File) function correctly with database persistence
labels: ["testing", "procurement", "2 — State Buttons & Modals"]
blocked_by: []
depends_on: ["PROCURE-001", "PROCURE-002"]
para_section: testing/projects/PROCURE-TEST/desktop/issues
phase: 2 — State Buttons & Modals
status: backlog
priority: High
story_points: 5
due_date: "2026-05-02"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-PROCUREMENT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: ["database-infraforge"]
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 01900 procurement page production readiness"
  agent_goal: "As validator-qualityforge, verify Upserts state and all 3 upsert modals (Cloud, URL, File) function correctly with database persistence"
  task_goal: "Execute upsert operations (Cloud→insert, URL→fetch+insert, File→parse+insert) with >95% pass rate"
---

# PROCURE-004: 01900 Upserts State — Cloud, URL & File Upserts

## Executive Summary

This issue validates the Upserts state button and its three associated modals: Cloud Upsert, URL Upsert, and File Upsert. The Upserts state enables users to insert vector data into the system from three different sources. Each modal performs a distinct data ingestion pathway: direct insert, URL fetch-and-insert, and file parse-and-insert. All operations must persist data to the `supabase_vectors` table. A pass rate above 95% is required.

## Problem Statement / Scope

When the user clicks the Upserts state button, the page must transition to the Upserts state, displaying three buttons corresponding to the three upsert methods. Each modal handles a different ingestion pattern: Cloud Upsert inserts data directly into the vectors table, URL Upsert fetches content from a remote URL and inserts the processed result, and File Upsert parses an uploaded file and inserts the extracted data. This issue covers modal lifecycle, data ingestion, error handling for malformed data, and database persistence. A subordinate database-infraforge agent may be delegated for database verification tasks.

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 4A | Upserts button click | Clicking Upserts button highlights it; page state transitions to Upserts; 3 buttons render |
| 4B | Cloud Upsert modal — insert to supabase_vectors | Modal opens; form accepts vector data; submission inserts row into supabase_vectors |
| 4C | URL Upsert modal — fetch and insert | Modal opens; URL input accepted; system fetches URL content; processed data inserted into supabase_vectors |
| 4D | File Upsert modal — parse and insert | Modal opens; file upload accepted; system parses file; extracted data inserted into supabase_vectors |
| 4E | Error handling for malformed data | Invalid URL, corrupt file, and malformed JSON show appropriate error messages; no partial inserts |

## Assigned Company & Agent

- **Company:** qualityforge-ai
- **Agent:** validator-qualityforge
- **Sub-agents:** database-infraforge (for database persistence verification)

## Required Skills

- quality-assurance
- database-testing
- api-testing

## Acceptance Criteria

- [ ] Upserts state button renders and is clickable
- [ ] Clicking Upserts button highlights it and transitions page state
- [ ] Exactly 3 buttons render in Upserts state: Cloud Upsert, URL Upsert, File Upsert
- [ ] Cloud Upsert modal opens and accepts vector data input
- [ ] Cloud Upsert submission inserts a row into supabase_vectors
- [ ] URL Upsert modal opens and accepts URL input
- [ ] URL Upsert fetches content from the provided URL
- [ ] URL Upsert processes and inserts data into supabase_vectors
- [ ] File Upsert modal opens and accepts file upload
- [ ] File Upsert parses file content correctly
- [ ] File Upsert inserts extracted data into supabase_vectors
- [ ] Malformed URL shows appropriate error message
- [ ] Corrupt file shows appropriate error message
- [ ] Malformed JSON shows appropriate error message
- [ ] No partial data is inserted on error

## Dependencies

- **Blocked by:** PROCURE-001 (page foundation), PROCURE-002 (database connectivity)
- **Depends on:** PROCURE-001, PROCURE-002
- **Blocks:** None

## Estimated Duration

45 minutes

## Risk Level

**High** — Upserts state is the primary data ingestion pathway. Failures here prevent users from adding vector data to the system.

## QC Team Checks

The following checks must be performed against the PAGE-KNOWLEDGE metadata for the 01900 page:

- [ ] **3 buttons render in Upserts state:** Confirm exactly three buttons appear: Cloud Upsert, URL Upsert, File Upsert
- [ ] **Cloud Upsert inserts to supabase_vectors:** Verify row count increases in supabase_vectors after submission
- [ ] **URL Upsert fetches and inserts:** Verify network request is made to the provided URL and data appears in supabase_vectors
- [ ] **File Upsert parses and inserts:** Verify file is parsed correctly and extracted data appears in supabase_vectors
- [ ] **Error handling:** Confirm each error case (invalid URL, corrupt file, malformed JSON) shows a user-facing error message
- [ ] **No partial inserts:** Confirm that when an error occurs, no partial or orphaned rows remain in the database
