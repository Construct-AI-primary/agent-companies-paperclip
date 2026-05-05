# MOBILE-TEST — Dispatch Prompts

**Project**: MOBILE-TEST
**Discipline**: Mobile (cross-platform)
**Server**: ALL-DISCIPLINES (1500134557649731634)
**Issues**: 6 (MOBILE-001 through MOBILE-006)
**Phases**: 1

---

## Pre-Flight Checklist

```bash
# Verify app server
curl -s -o /dev/null -w "HTTP %{http_code}" http://localhost:3060/

# Verify auth
curl -s -X POST http://localhost:3060/api/auth/login -H "Content-Type: application/json" -d '{"email":"sarah.safety@epcm.co.za","password":"anything"}' | python3 -m json.tool
```

---

## Mobile Batch A — Platform Testing

**Dispatch command (in #ai-work on ALL-DISCIPLINES server):**
```
@agent work on MOBILE-001,MOBILE-002,MOBILE-003 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| MOBILE-001 | iOS Testing | mobileforge-ai | MobileForge AI | #mobileforge-mobile-ios |
| MOBILE-002 | Android Testing | mobileforge-ai | MobileForge AI | #mobileforge-mobile-android |
| MOBILE-003 | Cross-Platform Testing | mobileforge-ai | MobileForge AI | #mobileforge-mobile-cross |

**Success criteria**: iOS and Android rendering correct, cross-platform consistency verified

---

## Mobile Batch B — Quality Testing

**After Mobile Batch A passes:**
```
@agent work on MOBILE-004,MOBILE-005,MOBILE-006 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| MOBILE-004 | Performance Testing | mobileforge-ai | MobileForge AI | #mobileforge-mobile-performance |
| MOBILE-005 | Security Testing | mobileforge-ai | MobileForge AI | #mobileforge-mobile-security |
| MOBILE-006 | UI/UX Testing | mobileforge-ai | MobileForge AI | #mobileforge-mobile-uiux |

**Success criteria**: Performance within thresholds, security scan passes, UI/UX consistent

---

## Related Documents

- `../disciplines-shared/testing/projects/MOBILE-TEST/`
- `../procedures/projects/batched-execution-plan.md`
- `../../orchestration/EXECUTION-TRACKER.md`