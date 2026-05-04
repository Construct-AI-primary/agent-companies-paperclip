---
title: Batched Execution Plan — Multi-Discipline Testing
author: OpenClaw AI
date: 2026-05-03
version: 1.0
status: active
---

# Batched Execution Plan — Multi-Discipline Testing

## Overview

This document defines the **batched-by-phase** execution plan for testing all disciplines simultaneously. Instead of testing one discipline at a time (which would repeat infrastructure setup 10+ times), we group issues by phase across all disciplines and execute them in parallel batches.

## Test Projects

| Project | Discipline | Issues | Phases | Platform | Discord Server |
|---------|-----------|--------|--------|----------|----------------|
| **PROCURE-TEST** | 01900 — Procurement | 15 issues (001–015) | 5 phases | Desktop | `PROCURE-TEST` |
| **PROD-TEST** | Cross-discipline | 14 issues (001–014 + HITL) | 4 tiers | Desktop | `ALL-DISCIPLINES` |
| **MOBILE-TEST** | Mobile | 6 issues (001–006) | 1 phase | Mobile | `ALL-DISCIPLINES` |

## Complete Discipline Page Inventory (120 pages)

The construct_ai app has **120 pages** registered in Supabase. They are grouped by their `page_number` code as follows:

### Core Pages (00100–00900)
| Code | Page Name | Category |
|------|-----------|----------|
| 00100 | Home | General |
| 00102 | Administration | General |
| 00175 | Auth Callback | General |
| 00200 | All Documents | General |
| 00300 | Construction | General |
| 00400 | Contracts | Contracts |
| 00425 | Contracts Pre Award | Contracts |
| 00435 | Contracts Post Award | Contracts |
| 00800 | Design | Engineering |
| 00825 | Architectural | Engineering |
| 00835 | Chemical Engineering | Engineering |
| 00850 | Civil Engineering | Engineering |
| 00855 | Geotechnical Engineering | Engineering |
| 00860 | Electrical Engineering | Engineering |
| 00870 | Mechanical Engineering | Engineering |
| 00871 | Process Engineering | Engineering |
| 00872 | Developer | IT |
| 00875 | Sales | Commercial |
| 00876 | Directors | Management |
| 00877 | Sundry | General |
| 00880 | Board of Directors | Management |
| 00882 | Director Construction | Management |
| 00883 | Director Contracts | Management |
| 00884 | Director Engineering | Management |
| 00885 | Director HSE | Management |
| 00886 | Director Logistics | Management |
| 00888 | Director Procurement | Management |
| 00889 | Director Finance | Management |
| 00890 | Director Projects | Management |
| 00895 | Director Project | Management |
| 00900 | Document Control | General |

### Discipline Pages (01000–03010)
| Code | Page Name | Category |
|------|-----------|----------|
| 01000 | Environmental | HSE |
| 01100 | Ethics | Governance |
| 01200 | Finance | Commercial |
| 01300 | Governance | Governance |
| 01400 | Health | HSE |
| 01500 | Human Resources | HR |
| 01600 | Local Content | Commercial |
| 01700 | Logistics | Logistics |
| 01750 | Legal | Legal |
| 01800 | Operations | Operations |
| 01850 | Other Parties | Commercial |
| 01900 | **Procurement** | **Procurement** |
| 02000 | Project Controls | PM |
| 02025 | Quantity Surveying | QS |
| 02035 | Scheduling | PM |
| 02050 | Information Technology | IT |
| 02075 | Inspection | QA/QC |
| 02100 | Public Relations | Commercial |
| 02200 | Quality Assurance | QA/QC |
| 02250 | Quality Control | QA/QC |
| 02400 | **Safety** | **HSE** |
| 02500 | Security | Security |
| 03000 | Landscaping | General |
| 03010 | Email Management | IT |

### Client/Project Pages (20000–20125)
| Code | Page Name |
|------|-----------|
| 20000 | Accounting-Finance |
| 20005 | Construction |
| 20010 | Contracts-Subcontracts |
| 20015 | Contracts |
| 20020 | Subcontracts |
| 20025 | Engineering |
| 20030 | Field Engineering |
| 20035 | HSE |
| 20040 | Environmental |
| 20045 | Health |
| 20050 | Safety |
| 20055 | Human Resources |
| 20060 | Legal |
| 20065 | Marketing and Business Development |
| 20070 | Operations and Maintenance |
| 20075 | Procurement |
| 20080 | Purchasing |
| 20085 | Logistics |
| 20090 | Materials Management |
| 20095 | Project Controls |
| 20100 | Estimating |
| 20105 | Scheduling and Planning |
| 20110 | Project Management |
| 20115 | Quality Assurance |
| 20120 | Quality Control |
| 20125 | Risk Management |

### Office Pages (30000–30165)
| Code | Page Name |
|------|-----------|
| 30000 | Board of Directors |
| 30005 | Client and Project Management |
| 30010 | Company Secretarial Services |
| 30015 | Corporate & Commercial |
| 30020 | Corporate and M&A support |
| 30030 | Data Privacy and Protection |
| 30035 | Employment Law |
| 30040 | Environmental & Sustainable Dev |
| 30045 | Estate Planning & Trusts |
| 30050 | Ethics |
| 30055 | Finance |
| 30060 | Governance |
| 30065 | Information Technology |
| 30070 | Intellectual Property |
| 30075 | Leasing & Eviction |
| 30080 | Litigation & Alternative Dispute Mgmt |
| 30085 | Mining & Infrastructure |
| 30090 | Notary Public |
| 30095 | Oversight - Africa group |
| 30100 | Partners - key |
| 30105 | Partner - Commercial |
| 30110 | Partner - Corporate |
| 30115 | Partner - Corporate & Commercial |
| 30120 | Partner - Disputes |
| 30125 | Partner - Employment Law |
| 30130 | Partner - International Arbitration |
| 30135 | Partner - Mining & Infrastructure |
| 30140 | Partners - managing |
| 30145 | Durban |
| 30150 | Johannesburg |
| 30155 | Pro-bono |
| 30160 | Real Estate |
| 30165 | Tax |

### Legacy Pages (D/E codes)
| Code | Page Name |
|------|-----------|
| D0010 | Document Control |
| D0030 | Document Control |
| D0205 | Document Control |
| E0010 | Email Management |
| E0170 | Email Management |
| E0205 | Email Management |

## Execution Strategy

```
Batch 1 ── Foundation + Database ── PROCURE-001/002, PROD-001/002/003/004
Batch 2 ── UI + State + Workspace ── PROCURE-003/004/005, PROD-005/006/007/008/009/010
Batch 3 ── Chatbot + Workflow ── PROCURE-006/007/008, PROD-011/012
Batch 3.5 ── Mobile Platform ── MOBILE-001/002/003/004/005/006
Batch 4 ── Domain Logic ── PROCURE-009/010/011, PROD-013
Batch 5 ── Compliance + Signoff ── PROCURE-012/013/013a/014
Batch 6 ── Regression + HITL ── PROCURE-015, PROD-014/HITL
```
Batch 3.5 ── Mobile Platform ── runs in parallel with Batches 4–6
```
```

## Pre-Execution Checklist (Run Once)

- [ ] **App server**: `http://localhost:3060` running (123 API routes)
- [ ] **Auth**: Login with `sarah.safety@epcm.co.za` works
- [ ] **Frontend**: `npm run build:client:optimized` completed
- [ ] **Discord bot**: `agent-vps#0729` running on VPS (144 channels)
- [ ] **Supabase**: Connected (user_management, pages tables populated)
- [ ] **Orchestration gates**: All unblocked in `EXECUTION-TRACKER.md`

---

## Batch 1 — Foundation + Database

**Goal**: Verify core infrastructure — auth, page loading, database connectivity

### Issues

| Issue | Discipline | Agent | Test Focus |
|-------|-----------|-------|------------|
| **PROCURE-001** | 01900 Procurement | DevForge AI | Auth flow, page load, nav container |
| **PROCURE-002** | 01900 Procurement | InfraForge AI | Database tables, schema validation |
| **PROD-001** | Cross-discipline | DevForge AI | Tier 1: basic page rendering |
| **PROD-002** | Cross-discipline | DevForge AI | Login testing |
| **PROD-003** | Cross-discipline | DevForge AI | User creation testing |
| **PROD-004** | Cross-discipline | DevForge AI | Database upsert testing |

### Test Steps

```bash
# 1. Verify app is running
curl -s -o /dev/null -w "HTTP %{http_code}" http://localhost:3060/

# 2. Test auth
curl -s -X POST http://localhost:3060/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"sarah.safety@epcm.co.za","password":"anything"}' | python3 -m json.tool

# 3. Verify discipline pages exist
curl -s http://localhost:3060/api/pages | python3 -c "import sys,json; pages=json.load(sys.stdin); print(f'Total pages: {len(pages)}')"

# 4. Check procurement-specific pages
curl -s http://localhost:3060/api/pages | python3 -c "import sys,json; [print(p['title']) for p in json.load(sys.stdin) if '01900' in str(p.get('id','')) or 'procurement' in str(p.get('title','')).lower()]"

# 5. Send Discord notification
# In #agent-commands: !status
```

### Success Criteria
- [ ] Auth returns JWT token with 24h expiry
- [ ] `/api/pages` returns 120+ pages
- [ ] Procurement discipline pages load (01900)
- [ ] Database tables exist for procurement
- [ ] Discord bot acknowledges in PROCURE-TEST channels

---

## Batch 2 — UI + State + Workspace

**Goal**: Verify UI components render, state management works, workspace loads

### Issues

| Issue | Discipline | Agent | Test Focus |
|-------|-----------|-------|------------|
| **PROCURE-003** | 01900 Procurement | DevForge AI | Agents state management |
| **PROCURE-004** | 01900 Procurement | DevForge AI | Upserts state management |
| **PROCURE-005** | 01900 Procurement | DevForge AI | Workspace state |
| **PROD-005** | Cross-discipline | DevForge AI | Accordion production testing |
| **PROD-006** | Cross-discipline | DevForge AI | Environment switching |
| **PROD-007** | Cross-discipline | DevForge AI | Tier 2: component rendering |
| **PROD-008** | Cross-discipline | DevForge AI | UI settings testing |
| **PROD-009** | Cross-discipline | DevForge AI | Non-discipline pages |
| **PROD-010** | Cross-discipline | DevForge AI | Discipline page testing |

### Test Steps

```bash
# 1. Verify modals render (from generated registry)
curl -s http://localhost:3060/api/pages | python3 -c "
import sys,json
pages = json.load(sys.stdin)
procurement = [p for p in pages if '01900' in str(p.get('id',''))]
print(f'Procurement pages: {len(procurement)}')
for p in procurement:
    print(f'  - {p.get(\"title\",\"unknown\")} (ID: {p.get(\"id\",\"\")[:20]}...)')
"

# 2. Test workspace endpoint
curl -s http://localhost:3060/api/procurement/agent | head -c 200

# 3. Test UI settings
curl -s http://localhost:3060/api/ui-settings | head -c 200
```

### Success Criteria
- [ ] Procurement workspace loads (HTTP 200)
- [ ] UI settings API returns configuration
- [ ] Non-discipline pages render correctly
- [ ] Environment switching works (dev → prod)

---

## Batch 3 — Chatbot + Workflow

**Goal**: Verify chatbot responses, workflow execution

### Issues

| Issue | Discipline | Agent | Test Focus |
|-------|-----------|-------|------------|
| **PROCURE-006** | 01900 Procurement | DevForge AI | Chatbot integration |
| **PROCURE-007** | 01900 Procurement | DomainForge AI | Workflow execution |
| **PROCURE-008** | 01900 Procurement | DomainForge AI | Template rendering |
| **PROD-011** | Cross-discipline | DevForge AI | Tier 3: chatbot production testing |
| **PROD-012** | Cross-discipline | DevForge AI | Chatbot production testing |

### Test Steps

```bash
# 1. Test chatbot endpoint
curl -s -X POST http://localhost:3060/api/chat \
  -H "Content-Type: application/json" \
  -d '{"message":"Hello, can you help with procurement?","discipline":"01900"}' | head -c 500

# 2. Test workflow endpoint
curl -s http://localhost:3060/api/workflows | head -c 200

# 3. Test templates
curl -s http://localhost:3060/api/procurement-templates | head -c 200
```

### Success Criteria
- [ ] Chatbot responds to procurement queries
- [ ] Workflow API returns available workflows
- [ ] Templates render correctly

---

## Batch 3.5 — Mobile Platform

**Goal**: Verify mobile platform rendering, iOS/Android functionality, cross-platform consistency, performance, security, and mobile UI/UX

**Note**: This batch runs independently and can execute **in parallel** with Batches 4–6. Mobile tests use the mobile build system, not the desktop API stack.

### Issues

| Issue | Discipline | Agent | Test Focus |
|-------|-----------|-------|------------|
| **MOBILE-001** | Mobile | MobileForge AI | iOS testing |
| **MOBILE-002** | Mobile | MobileForge AI | Android testing |
| **MOBILE-003** | Mobile | MobileForge AI | Cross-platform testing |
| **MOBILE-004** | Mobile | MobileForge AI | Performance testing |
| **MOBILE-005** | Mobile | MobileForge AI | Security testing |
| **MOBILE-006** | Mobile | MobileForge AI | UI/UX testing |

### Test Steps

```bash
# 1. Build mobile app (iOS)
cd construct_ai-mobile
npm run build:ios

# 2. Build mobile app (Android)
npm run build:android

# 3. Run cross-platform tests
npm run test:cross-platform

# 4. Run performance benchmarks
npm run test:performance

# 5. Run security scan
npm run test:security

# 6. Run UI/UX accessibility tests
npm run test:ui-ux
```

### Success Criteria
- [ ] iOS build completes successfully
- [ ] Android build completes successfully
- [ ] Cross-platform consistency verified
- [ ] Performance metrics within thresholds (load time < 2s, scroll 60fps)
- [ ] No critical security vulnerabilities
- [ ] UI/UX accessibility standards met (WCAG 2.1 AA)

---

## Batch 4 — Domain Logic

**Goal**: Verify domain-specific features — suppliers, tenders, integrations

### Issues

| Issue | Discipline | Agent | Test Focus |
|-------|-----------|-------|------------|
| **PROCURE-009** | 01900 Procurement | DomainForge AI | Supplier management |
| **PROCURE-010** | 01900 Procurement | DomainForge AI | Tender management |
| **PROCURE-011** | 01900 Procurement | InfraForge AI | Integration testing |
| **PROD-013** | Cross-discipline | DevForge AI | Tier 4: full integration testing |

### Test Steps

```bash
# 1. Test suppliers endpoint
curl -s http://localhost:3060/api/suppliers | head -c 200

# 2. Test tender integration
curl -s http://localhost:3060/api/tender-integration | head -c 200

# 3. Test external API configurations
curl -s http://localhost:3060/api/external-api-configurations | head -c 200
```

### Success Criteria
- [ ] Supplier CRUD operations work
- [ ] Tender management API responds
- [ ] External integrations configured
- [ ] Performance metrics within thresholds

---

## Batch 5 — Compliance + Signoff

**Goal**: Verify compliance workflows, delegation, feedback loops, sign-off

### Issues

| Issue | Discipline | Agent | Test Focus |
|-------|-----------|-------|------------|
| **PROCURE-012** | 01900 Procurement | DevForge AI | Compliance testing |
| **PROCURE-013** | 01900 Procurement | DevForge AI | Delegation testing |
| **PROCURE-013a** | 01900 Procurement | DevForge AI | Feedback loop testing |
| **PROCURE-014** | 01900 Procurement | DevForge AI | Sign-off testing |

### Test Steps

```bash
# 1. Test compliance endpoint
curl -s http://localhost:3060/api/governance | head -c 200

# 2. Test approvals
curl -s http://localhost:3060/api/approvals | head -c 200

# 3. Test enterprise approval workflow
curl -s http://localhost:3060/api/enterprise-approval | head -c 200
```

### Success Criteria
- [ ] Compliance rules enforced
- [ ] Delegation workflow works
- [ ] Feedback loop operational
- [ ] Sign-off process completes

---

## Batch 6 — Regression + HITL

**Goal**: Final quality gate — regression tests and human-in-the-loop verification

### Issues

| Issue | Discipline | Agent | Test Focus |
|-------|-----------|-------|------------|
| **PROCURE-015** | 01900 Procurement | QualityForge AI | Subcontract RFQ regression |
| **PROD-014** | Cross-discipline | DevForge AI | HITL production testing (Hermes Agent) |
| **PROD-HITL** | Cross-discipline | DevForge AI | HITL workflow |

### Test Steps

```bash
# 1. Run workflow tests
curl -s http://localhost:3060/api/workflow-tests | head -c 200

# 2. Run test runner
curl -s http://localhost:3060/api/test-runner | head -c 200

# 3. Check HITL tasks
curl -s http://localhost:3060/api/tasks/hitl | head -c 200
```

### Success Criteria
- [ ] All regression tests pass
- [ ] HITL workflow operational
- [ ] No regressions introduced from previous batches
- [ ] Orchestration gates all green

---

## Discord Communication Template (Hybrid Channel Model)

The bot now uses a **channel-type-aware dispatch** model. See `orchestration/DISCORD-CHANNEL-TAXONOMY.md` for full details.

### Channel Types

| Type | Name | Agent Behavior |
|------|------|---------------|
| **Control** | `#ai-work` | Orchestrator listens for `@agent` commands |
| **Log** | `#project-log` | Agent writes summaries, PR links, status |
| **Issue** | `#{agent}-{issue}` | Agent monitors read-only, replies in `#ai-work` |
| **System** | `#agent-commands` | Bot commands (`!ping`, `!status`, `!help`) |

### How to Communicate

```
# In #ai-work (control channel — orchestrator command hub):
@agent status
@agent plan on PROCURE-007
@agent work on PROCURE-007

# In #agent-commands (system channel — bot commands):
!status
!channels
!taxonomy

# In issue channels (e.g. #devforge-procure-foundation):
Type normally. Agent reads but replies in #ai-work.
Mention @agent to get a cross-reference reply in #ai-work.
```

### Pre-Execution Checklist Update

- [ ] **Control channels**: `#ai-work` and `#project-log` exist on each project server
- [ ] **Discord bot**: `agent-vps#0729` running on VPS with updated `bot.js` (hybrid channel model)
- [ ] **Channel taxonomy**: Verified via `!taxonomy` command

## Progress Tracking

Update `orchestration/EXECUTION-TRACKER.md` after each batch:

```markdown
| Batch | Issues | Status | Date | Notes |
|-------|--------|--------|------|-------|
| 1 — Foundation | PROCURE-001/002, PROD-001/002/003/004 | ✅ Complete | 2026-05-03 | Auth fixed, pages verified |
| 2 — UI/State | PROCURE-003/004/005, PROD-005/006/007/008/009/010 | ⏳ In progress | — | — |
| 3 — Chatbot | PROCURE-006/007/008, PROD-011/012 | ⏳ Pending | — | — |
| 3.5 — Mobile | MOBILE-001/002/003/004/005/006 | ⏳ Pending (parallel) | — | Runs alongside Batches 4–6 |
| 4 — Domain | PROCURE-009/010/011, PROD-013 | ⏳ Pending | — | — |
| 5 — Compliance | PROCURE-012/013/013a/014 | ⏳ Pending | — | — |
| 6 — Regression | PROCURE-015, PROD-014/HITL | ⏳ Pending | — | — |
```

## Estimated Timeline

| Batch | Est. Duration | Cumulative (desktop) | Cumulative (with mobile parallel) |
|-------|--------------|---------------------|----------------------------------|
| Batch 1 — Foundation | ~20 min | 20 min | 20 min |
| Batch 2 — UI/State | ~30 min | 50 min | 50 min |
| Batch 3 — Chatbot | ~30 min | 1h 20m | 1h 20m |
| Batch 3.5 — Mobile | ~30 min | — | Runs alongside Batches 4–6 |
| Batch 4 — Domain | ~30 min | 1h 50m | 1h 50m |
| Batch 5 — Compliance | ~20 min | 2h 10m | 2h 10m |
| Batch 6 — Regression | ~20 min | 2h 30m | 2h 30m |
| **Total (desktop)** | **~2.5 hours** | | |
| **Total (real-time, parallel)** | **~2.5 hours** | | mobile adds no extra wall-clock time |

## Status: 📋 Ready for Execution

Start with **Batch 1** and proceed sequentially. Each batch builds on the previous one. If a batch fails, fix the issues before proceeding to the next batch.

**Mobile batches (Batch 3.5) are independent** and can be executed in parallel with Batches 4–6 by a separate MobileForge AI agent. Mobile infrastructure is handled via the `construct_ai-mobile` repository and does not block desktop batches.
