# PROD-TEST — Dispatch Prompts

**Project**: PROD-TEST
**Discipline**: Cross-discipline (all disciplines)
**Server**: ALL-DISCIPLINES (1500134557649731634)
**Issues**: 15 (PROD-001 through PROD-014 + PROD-HITL)
**Tiers**: 4

---

## Pre-Flight Checklist

```bash
# Verify app server
curl -s -o /dev/null -w "HTTP %{http_code}" http://localhost:3060/

# Verify auth
curl -s -X POST http://localhost:3060/api/auth/login -H "Content-Type: application/json" -d '{"email":"sarah.safety@epcm.co.za","password":"anything"}' | python3 -m json.tool

# Verify pages
curl -s http://localhost:3060/api/pages | python3 -c "import sys,json; pages=json.load(sys.stdin); print(f'Total pages: {len(pages)}')"
```

---

## Tier 1 — Basic Page Rendering (100% pass threshold)

**Dispatch command (in #ai-work on ALL-DISCIPLINES server):**
```
@agent work on PROD-001,PROD-002 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| PROD-001 | Tier 1: Basic Page Rendering | devforge-ai | DevForge AI | #devforge-prod-tier1 |
| PROD-002 | Login Testing | devforge-ai | DevForge AI | #devforge-prod-login |

**Tier Gate 1**: 100% pass rate → DevForge AI

---

## Tier 2 — Component Rendering (>95% pass threshold)

**After Tier Gate 1 passes:**
```
@agent work on PROD-005,PROD-007,PROD-008,PROD-009 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| PROD-005 | Accordion Production Testing | devforge-ai | DevForge AI | #devforge-prod-accordion |
| PROD-007 | Tier 2: Component Rendering | devforge-ai | DevForge AI | #devforge-prod-tier2 |
| PROD-008 | UI Settings Testing | devforge-ai | DevForge AI | #devforge-prod-ui-settings |
| PROD-009 | Non-Discipline Pages Production Testing | devforge-ai | DevForge AI | #devforge-prod-non-discipline |

**Tier Gate 2**: >95% pass rate → DevForge AI

---

## Tier 3 — Chatbot Production Testing (>90% pass threshold)

**After Tier Gate 2 passes:**
```
@agent work on PROD-011,PROD-012 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| PROD-011 | Tier 3: Chatbot Production Testing | devforge-ai | DevForge AI | #devforge-prod-tier3 |
| PROD-012 | Chatbot Production Testing | devforge-ai | DevForge AI | #devforge-prod-chatbot |

**Tier Gate 3**: >90% pass rate → DevForge AI

---

## Tier 4 — Full Integration Testing (>85% pass threshold)

**After Tier Gate 3 passes:**
```
@agent work on PROD-013,PROD-003,PROD-004,PROD-006,PROD-010,PROD-014,PROD-HITL in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| PROD-013 | Tier 4: Full Integration Testing | devforge-ai | DevForge AI | #devforge-prod-tier4 |
| PROD-003 | User Creation Testing | devforge-ai | DevForge AI | #devforge-prod-user-creation |
| PROD-004 | Database Upsert Testing | devforge-ai | DevForge AI | #devforge-prod-database-upsert |
| PROD-006 | Environment Switching Production Testing | devforge-ai | DevForge AI | #devforge-prod-environment |
| PROD-010 | Discipline Page Testing | devforge-ai | DevForge AI | #devforge-prod-discipline |
| PROD-014 | HITL Production Testing (Hermes Agent) | devforge-ai | DevForge AI | #devforge-prod-hitl |
| PROD-HITL | HITL Workflow | devforge-ai | DevForge AI | #devforge-prod-hitl-workflow |

**Tier Gate 4**: >85% pass rate → DevForge AI

---

## Related Documents

- `../disciplines-shared/testing/projects/PROD-TEST/plan.md`
- `../disciplines-shared/testing/projects/PROD-TEST/desktop/issues/`
- `../procedures/projects/batched-execution-plan.md`
- `../../orchestration/EXECUTION-TRACKER.md`