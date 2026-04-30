---
title: KnowledgeForge Non-Discipline Specialists Consolidation Plan
date: 2026-04-06
status: proposed
---

# Non-Discipline Specialists Consolidation Plan v2

## Key Finding: Discipline 02050 IT is the Master Directory

`disciplines/02050_information-technology` has **293 files** (290 .md + subdirs for agents/, chatbot/, modal/, pages/, plan/, agent-data/). It already contains content for:
- Modal management (`00-MODAL-MANAGEMENT.MD`, `modal/` subdir)
- Agent platform (`agents/` subdir, `AGENTS-REGISTRY.MD`, `UNIFIED-AGENT-PLATFORM-UI.MD`)
- Chatbot (`chatbot/` subdir, `CHATBOT-SYSTEM-MASTER-GUIDE.MD`)
- Email (`00200-EMAIL-MANAGEMENT-SYSTEM-COMPLETE.MD`, `HYBRID-EMAIL-SYSTEM-COMPLETE.MD`)
- UI Settings (`UI-SETTINGS-MASTER-GUIDE.MD`, `EXTERNAL-API-SETTINGS-UI-REDESIGN.MD`)
- Error tracking (5+ error tracking files)
- Contributor hub (`CONTRIBUTOR-SETUP-COMPLETE.MD`, `ENHANCED-CONTRIBUTOR-HUB-IMPLEMENTATION.MD`)
- Timesheet, auth, travel, admin, LangGraph — all covered

**All 10 non-discipline `02050-*` stubs are UI page documentation for the IT discipline app.**
**All other non-discipline stubs have content already in the IT discipline directory.**

## Consolidation Decision

### Move Administration to Disciplines

`disciplines-non/00102-administration` (2 files) and `disciplines-non/00102-privacy-settings` (1 file) are administrative topics that warrant a **discipline-level agent** rather than a non-discipline stub. The IT discipline already has `01500_MASTER_GUIDE_PRIVACY_.md` (71KB).

**Action:** Create `KnowledgeForge Administration` as a **discipline specialist** agent (not non-discipline), reading from both `disciplines/02050_information-technology/` and `disciplines-non/00102-administration/`.

### Absorb ALL Non-Discipline 02050-* into IT Discipline Agent

The 10 non-discipline `02050-*` directories are all thin UI page stubs whose actual knowledge lives in the discipline IT directory:

| Non-Discipline Stub | Covered by IT Discipline |
|---------------------|-------------------------|
| `02050-agent-simulation-ui` (1 file) | `UNIFIED-AGENT-PLATFORM-UI.MD`, `agents/` |
| `02050-agent-system-management` (1 file) | `AGENTS-REGISTRY.MD`, `agent-data/` |
| `02050-coding-templates` (empty) | Part of IT development workflow |
| `02050-cross-discipline-ui-check` (1 file) | `CROSS-DISCIPLINE-UI-CHECK-DEPLOYMENT-STATUS.MD` |
| `02050-development-console` (1 file) | Part of IT dev tooling |
| `02050-engineering-templates` (empty) | Part of IT development workflow |
| `02050-information-technology` (26 files) | Already a discipline: `02050_information-technology` |
| `02050-system-settings` (1 file) | `UI-SETTINGS-MASTER-GUIDE.MD`, `LANGCHAIN-SETTINGS-UI.MD` |
| `02050-testing-dashboard` (1 file) | `TESTING-GUIDE.MD`, `INTEGRATION-TEST-RESULTS-SUMMARY.MD` |

**Action:** Remove all 10 non-discipline agents for `02050-*`. The single `KnowledgeForge Information Technology` discipline agent reads the entire 293-file IT discipline directory. No separate non-discipline agents needed.

### Remaining Non-Discipline Stubs (absorbed into IT Discipline agent)

After removing the 02050-* duplicates and moving administration to disciplines, the remaining non-discipline stubs are all thin UI page docs whose knowledge lives in the IT discipline directory:

| Stub | Content | Absorbed Into |
|------|---------|---------------|
| `00100-home` (7 files) | Landing page, login page stubs | **KnowledgeForge Home & Login** |
| `00100-user-login` (1 file) | Login stub | ↑ same agent |
| `00175-password-reset` (1 file) | Password reset stub | ↑ same agent |
| `00175-auth-callback` (9 files) | Auth flow | **KnowledgeForge Auth Flow** |
| `00150-user-signup` (6 files) | Signup flow | **KnowledgeForge User Signup** |
| `00155-user-management` (1 file) | User mgmt stub | ↑ same agent |
| `00165-ui-settings` (18 files) | Debug panel, settings | IT Discipline (has `UI-SETTINGS-MASTER-GUIDE.MD`) |
| `00165-debug-panel` (1 file) | Debug stub | IT Discipline |
| `00170-modal-management` (11 files) | Modal architecture | IT Discipline (has `00-MODAL-MANAGEMENT.MD`, `modal/`) |
| `00170-chatbot-management` (1 file) | Chatbot stub | IT Discipline (has `chatbot/`, `CHATBOT-SYSTEM-MASTER-GUIDE.MD`) |
| `00105-travel-arrangements` (8 files) | Travel booking | IT Discipline |
| `00106-timesheet` (11 files) | Timesheet | IT Discipline |
| `00180-contributor-hub` (21 files) | Contributor access | IT Discipline (has `CONTRIBUTOR-SETUP-COMPLETE.MD`) |
| `03010_email_management` (18 files) | Email system | IT Discipline (has `EMAIL-MANAGEMENT-SYSTEM-COMPLETE.MD`) |
| `02300-ai-enhancement-monitoring` (16 files) | AI monitoring | IT Discipline (has `MONITORING-ALERTING-BASELINES.MD`) |
| `02052-langraph-ui` (4 files) | LangGraph UI | IT Discipline (has `LANGCHAIN-SETTINGS-UI.MD`) |
| `02060-agent-workflow-status` (1 file) | Agent workflow stub | IT Discipline |
| `02070-agent-creator` (1 file) | Agent creator stub | IT Discipline |
| `02350-training-pipeline` (2 files) | Training pipeline | IT Discipline |
| `agent-generation` (1 file) | Agent gen stub | IT Discipline |
| `agent-operations-center` (1 file) | Agent ops stub | IT Discipline |
| `assembly` (1 file) | Assembly stub | IT Discipline |
| `00102-privacy-settings` (1 file) | Privacy stub | → Administration discipline |

### Already Counted in Disciplines (not part of non-discipline)

These non-discipline directories are **exact duplicates** of existing discipline agents and should simply be dropped — they were never separate agents:

| Non-Discipline Stub | Discipline Equivalent | Action |
|---------------------|----------------------|--------|
| `disciplines-non/02075_inspection` (8 files) | `disciplines/02075_inspection` → `KnowledgeForge Inspection` | Drop — already a discipline agent |
| `disciplines-non/02076-quality-assurance` (1 file) | `disciplines/02200_quality-assurance` → `KnowledgeForge Quality Assurance` | Drop — already a discipline agent |
| `disciplines-non/02076-quality-assurance-sub` (1 file) | `disciplines/02200_quality-assurance` → `KnowledgeForge Quality Assurance` | Drop — already a discipline agent |

## Revised Structure

### Non-Discipline Specialists: 36 → 3

| Agent | Content | Reason |
|-------|---------|--------|
| `KnowledgeForge Home & Login` | 00100-home, 00100-user-login, 00175-password-reset | Thin login page stubs |
| `KnowledgeForge Auth Flow` | 00175-auth-callback (9 files) | Has substantive auth content |
| `KnowledgeForge User Signup` | 00150-user-signup (6 files), 00155-user-management | Has substantive signup content |

### Moved to Discipline Specialists (new agent)

| Agent | Content | Discipline Source |
|-------|---------|-------------------|
| `KnowledgeForge Administration` | 00102-administration, 00102-privacy-settings | New discipline specialist reading from `02050_information-technology/` + admin directory |

### Eliminated from Non-Discipline Count (absorbed by discipline agents)

| Non-Discipline | Absorbed By |
|----------------|-------------|
| All 10 × `02050-*` IT page stubs | **KnowledgeForge Information Technology** discipline agent (293 files) |
| `00165-ui-settings` (18 files) | IT Discipline contains `UI-SETTINGS-MASTER-GUIDE.MD` |
| `00165-debug-panel` (1 file) | Part of IT UI settings |
| `00170-modal-management` (11 files) | IT Discipline contains `modal/` subdir |
| `00170-chatbot-management` (1 file) | IT Discipline contains `chatbot/` subdir |
| `00105-travel-arrangements` (8 files) | IT Discipline contains travel files |
| `00106-timesheet` (11 files) | IT Discipline contains timesheet files |
| `00180-contributor-hub` (21 files) | IT Discipline contains CONTRIBUTOR files |
| `03010_email_management` (18 files) | IT Discipline contains EMAIL files |
| `02300-ai-enhancement-monitoring` (16 files) | IT Discipline contains MONITORING files |
| `02052-langraph-ui` (4 files) | IT Discipline contains LANGCHAIN files |
| `02060-agent-workflow-status` (1 file) | IT Discipline agent |
| `02070-agent-creator` (1 file) | IT Discipline agent |
| `02350-training-pipeline` (2 files) | IT Discipline contains TRAINING files |
| `agent-generation/operations-center/assembly` (3 files) | IT Discipline agent |

### Dropped (exact duplicates of discipline agents — never counted separately)

| Non-Discipline Stub | Discipline Equivalent | Status |
|---------------------|----------------------|--------|
| `disciplines-non/02075_inspection` | `disciplines/02075_inspection` | Already counted in 50 disciplines |
| `disciplines-non/02076-quality-assurance` | `disciplines/02200_quality-assurance` | Already counted in 50 disciplines |
| `disciplines-non/02076-quality-assurance-sub` | `disciplines/02200_quality-assurance` | Already counted in 50 disciplines |

## Result

| Category | Before | After | Reduction |
|----------|--------|-------|-----------|
| Core Agents | 12 | 12 | — |
| Discipline Specialists | 50 | 51 (+1 Administration) | +1 |
| Non-Discipline Specialists | 36 | 3 | **-33 (92% reduction)** |
| **Total** | **98** | **66** | **-32 agents** |

## Final KnowledgeForge Structure (66 agents)

```
KnowledgeForge CEO
├── Knowledge Engineering Team (6)
│   ├── Doc Analyzer (lead)
│   ├── QA Strategist
│   ├── Arch Refactorer
│   ├── Failure Learner
│   ├── ClieNT Integrator
│   └── App Guardian
├── Discipline Operations Team (3)
│   ├── Discipline Strategist (lead)
│   ├── Cross-Discipline Guardian
│   └── Workflow Guardian
├── Sector Analysis Team (2)
│   ├── Sector Analyst (lead)
│   └── Sector QA Lead
├── Discipline Specialists (51) — each maps to one disciplines/ directory
│   └── Including new: KnowledgeForge Administration
└── Non-Discipline Specialists (3)
    ├── Home & Login (home, user-login, password-reset)
    ├── Auth Flow (auth-callback)
    └── User Signup (user-signup, user-management)
```

## Why This Works

The `disciplines/02050_information-technology` directory is the **canonical IT knowledge** — 293 files covering every app feature: agents, modals, chatbot, email, settings, error tracking, monitoring, contributor hub, timesheets, training pipeline, LangGraph, etc. The non-discipline subdirectories are just UI page documentation stubs generated by the app's navigation structure. They add no unique knowledge beyond "this page exists." A single IT discipline agent reading the full 293-file directory is sufficient.

## Next Steps

1. Confirm — should I update SQL migration and org chart to 66 agents?
2. Delete duplicate/empty non-discipline directories from docs-construct-ai (or move to archive)
3. Update KnowledgeForge agent AGENTS.md files to reflect consolidated structure