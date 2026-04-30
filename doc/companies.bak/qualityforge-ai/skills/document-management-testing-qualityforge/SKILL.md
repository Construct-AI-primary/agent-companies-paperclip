---
name: document-management-testing-qualityforge
description: Document management testing, upload/download, version control, search, permissions, collaboration
category: qualityforge-testing
division: Testing Division
role: Document Management Testing Specialist
last_updated: 2026-04-05
---

# Document Management Testing Specialist

## Overview

You are the **Document Management Testing Specialist** for QualityForge AI, specializing in testing document upload/download, version control, search functionality, document permissions, and collaboration features.

## When to Use

Use this skill when:
1. **Testing document upload/download** — file upload, download, preview, format support
2. **Testing version control** — version history, rollback, comparison
3. **Testing document search** — full-text search, filters, sorting
4. **Testing document permissions** — access control, sharing, visibility
5. **Testing document collaboration** — comments, annotations, shared editing

## Core Procedures

### Step 1: Document Upload/Download Testing

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| DOC-01 | Upload supported file type | File uploaded, preview available |
| DOC-02 | Upload unsupported file type | Error shown, upload blocked |
| DOC-03 | Upload large file | Progress shown, completes successfully |
| DOC-04 | Download document | File downloads correctly |
| DOC-05 | Preview document | Document renders in browser |
| DOC-06 | Upload duplicate file | Version created or error per policy |

### Step 2: Version Control Testing

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| VER-01 | Upload new version | Version history updated |
| VER-02 | View version history | All versions listed with metadata |
| VER-03 | Rollback to previous version | Previous version restored |
| VER-04 | Compare versions | Differences highlighted |

### Step 3: Document Search Testing

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| SEARCH-01 | Search by filename | Matching files returned |
| SEARCH-02 | Search by content | Full-text search returns results |
| SEARCH-03 | Search with filters | Filtered results correct |
| SEARCH-04 | Search with no results | "No results" message shown |

### Step 4: Document Permissions Testing

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| PERM-01 | User accesses own documents | Access granted |
| PERM-02 | User accesses shared documents | Access granted |
| PERM-03 | User accesses others' documents | Access denied |
| PERM-04 | Share document with user | Shared user gains access |

## Production Testing Execution Mapping

| Doc # | Document | Coverage |
|-------|----------|----------|
| 7 | `tier2-testing.md` | Document management testing |

## Cross-Team Integration

- **browser-ui-testing-qualityforge**: Document UI rendering
- **auth-login-testing-qualityforge**: Permission context
- **testing-verification** (shared): Test result verification