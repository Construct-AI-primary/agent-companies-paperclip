---
title: Shared Discipline Features Platform Structure
description: Define how to organize shared discipline feature projects for desktop vs mobile platforms
date: 2026-04-17
---

# Shared Discipline Features Platform Structure

## Overview

Shared discipline features are cross-discipline platforms and system-level features that serve multiple engineering disciplines. They provide essential capabilities that are shared across all disciplines rather than being discipline-specific.

## Categories

### User Management (00100-series)
- User Home, Login, Signup, Privacy Settings

### Administration (00102-series)
- Administration, Debug Panel, UI Settings

### Business Operations (00105-00106-series)
- Travel Arrangements, Timesheet

### AI & Agent Management (02050-series)
- Agent Simulation, Agent System Management, Development Console

### Chat & Communication (00170-series, 02052-series)
- Chatbot Management, Modal Management, Langraph UI

### Quality & Testing (02075-02076-series)
- Inspection, Quality Assurance

### Training & Monitoring (02300-02350-series)
- AI Enhancement Monitoring, Training Pipeline

## Directory Structure

```
{feature-code}-{feature-name}/
├── README.md                              # Feature overview
├── AGENTS.md                             # Agent instructions
├── {FEATURE}-workflows-list.md         # Feature workflows catalog
├── {FEATURE}-implementation.md           # Implementation plan
├── discipline_workflow_conversion_procedure.md
├── trigger/                              # Feature automation triggers
│   └── {FEATURE}-000-project-automation.md
├── research/                             # Research and enhancement
│   └── {FEATURE}-research-enhancement-plan.md
├── scripts/                              # Generator scripts
│   └── generate-issues.py
├── knowledge/                            # Feature knowledge base
│   └── PAGE-KNOWLEDGE.md
├── shared/                               # Shared across platforms
│   ├── api/
│   ├── business-logic/
│   └── data-models/
├── desktop/                              # Desktop platform
│   ├── trigger/
│   ├── issues/
│   ├── learning/
│   └── orchestration/
├── mobile/                               # Mobile platform
│   ├── trigger/
│   ├── issues/
│   ├── learning/
│   └── orchestration/
└── web/                                  # Web platform
    ├── trigger/
    ├── issues/
    ├── learning/
    └── orchestration/
```

## Example: Voice Communication (02050)

```
02050-voice-communication/
├── README.md
├── AGENTS.md
├── VOICE-COMM-workflows-list.md
├── VOICE-COMM-implementation.md
├── discipline_workflow_conversion_procedure.md
├── trigger/
├── research/
├── scripts/
├── knowledge/
│   └── PAGE-KNOWLEDGE.md
├── shared/
├── desktop/
│   ├── issues/
│   │   ├── VOICE-COMM-001-core-voice-call-interface.md
│   │   ├── VOICE-COMM-002-hitl-approval-workflow.md
│   │   ├── VOICE-COMM-003-document-attachment-system.md
│   │   ├── VOICE-COMM-004-audit-logging-system.md
│   │   └── ISSUE-GENERATION-STATUS.md
│   └── trigger/
├── mobile/
│   ├── issues/
│   │   ├── VOICE-COMM-101-mobile-voice-call-screen.md
│   │   ├── VOICE-COMM-102-mobile-document-attachment.md
│   │   └── ISSUE-GENERATION-STATUS.md
│   └── trigger/
└── web/
    └── issues/
```

## Issue Numbering Convention

### Desktop Issues
- **Range**: 001-099
- **Example**: VOICE-COMM-001, VOICE-COMM-002

### Mobile Issues
- **Range**: 101-199
- **Example**: VOICE-COMM-101, VOICE-COMM-102

### Web Issues
- **Range**: 201-299
- **Example**: VOICE-COMM-201, VOICE-COMM-202

---

**Document Version**: 1.0
**Last Updated**: 2026-04-17
