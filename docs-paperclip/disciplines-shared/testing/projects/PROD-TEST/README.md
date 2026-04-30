---
title: PROD-TEST Project
author: PaperclipForge AI
date: 2026-04-16
version: 1.0
status: active
---

# PROD-TEST Project

## Overview

The **PROD-TEST** project focuses on production environment testing, including tier-based testing, UI/UX validation, and integration testing.

## Project Structure

```
PROD-TEST/
├── README.md                                    ← This file
├── plan.md                                      ← Project plan
├── AGENTS.md                                    ← Project-specific agent instructions
├── PROD-TEST-implementation.md                 ← Implementation plan
├── PROD-TEST-workflows-list.md                  ← Workflows catalog
│
├── trigger/                                     ← Project automation triggers
│   └── README.md
│
├── issues/                                      ← Non-platform-specific issues
│   ├── PROD-001-tier1-testing.md
│   ├── PROD-002-login-testing.md
│   ├── PROD-003-user-creation-testing.md
│   ├── PROD-004-database-upsert-testing.md
│   ├── PROD-005-accordion-production-testing.md
│   ├── PROD-006-environment-switching-production-testing.md
│   ├── PROD-007-tier2-testing.md
│   ├── PROD-008-ui-settings-testing.md
│   ├── PROD-009-non-discipline-pages-production-testing.md
│   ├── PROD-010-discipline-testing.md
│   ├── PROD-011-tier3-testing.md
│   ├── PROD-012-chatbot-production-testing.md
│   ├── PROD-013-tier4-testing.md
│   ├── PROD-014-HITL_Production_Testing_Hermes_Agent.md
│   └── ISSUE-GENERATION-STATUS.md
│
├── desktop/                                     ← Desktop platform
├── mobile/                                      ← Mobile platform
├── web/                                         ← Web platform
│
├── shared/                                      ← Shared across platforms
│
├── knowledge/                                  ← Project-specific knowledge
│   └── PAGE-KNOWLEDGE.md
│
├── learning/
│   └── PROD-TEST-LEARNING-TRACKER.md
│
└── orchestration/
    └── LEARNING-INTEGRATION.md
```

## Purpose

- **Tier-Based Testing**: Systematic testing across tiers 1-4
- **UI/UX Validation**: User interface and experience testing
- **Integration Testing**: System integration validation
- **Production Monitoring**: Production environment monitoring

## Related Documentation

- [Code and Documentation Placement Procedure](../../procedures/workflows/code-and-doc-placement-procedure.md)

---

**Project Version**: 1.0
**Last Updated**: 2026-04-16
**Author**: PaperclipForge AI
