# ESIGN-INTEGRATION — Dispatch Prompts

**Project**: ESIGN-INTEGRATION
**Discipline**: E-Signing (cross-discipline)
**Server**: ALL-DISCIPLINES (1500134557649731634)
**Issues**: 11 (ESIGN-001 through ESIGN-011 + ESIGN-MOBILE-001/002/003 + ESIGN-WEB-001/002/003)
**Phases**: 1 (single phase)

---

## Pre-Flight Checklist

```bash
# Verify app server
curl -s -o /dev/null -w "HTTP %{http_code}" http://localhost:3060/

# Verify auth
curl -s -X POST http://localhost:3060/api/auth/login -H "Content-Type: application/json" -d '{"email":"sarah.safety@epcm.co.za","password":"anything"}' | python3 -m json.tool
```

---

## Desktop Issues — Core Integration

**Dispatch command (in #ai-work on ALL-DISCIPLINES server):**
```
@agent work on ESIGN-001,ESIGN-002,ESIGN-003,ESIGN-004,ESIGN-005 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| ESIGN-001 | Foundation & Core Setup | devforge-ai | DevForge AI | #devforge-esign-foundation |
| ESIGN-002 | Core Integration — API & Workflow | integateforge-ai | IntegrateForge AI | #integrateforge-esign-core |
| ESIGN-003 | Discipline Integration — Procurement, Contracts, Safety | integateforge-ai | IntegrateForge AI | #integrateforge-esign-discipline |
| ESIGN-004 | Mobile & Offline Signing | mobileforge-ai | MobileForge AI | #mobileforge-esign-mobile |
| ESIGN-005 | Compliance & Audit Trail | qualityforge-ai | QualityForge AI | #qualityforge-esign-compliance |

**Success criteria**: Core e-signing integration operational, discipline integration verified

---

## Mobile Issues

**After desktop core passes:**
```
@agent work on ESIGN-MOBILE-001,ESIGN-MOBILE-002,ESIGN-MOBILE-003 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| ESIGN-MOBILE-001 | iOS Signing | mobileforge-ai | MobileForge AI | #mobileforge-esign-ios |
| ESIGN-MOBILE-002 | Android Signing | mobileforge-ai | MobileForge AI | #mobileforge-esign-android |
| ESIGN-MOBILE-003 | Cross-Platform Signing | mobileforge-ai | MobileForge AI | #mobileforge-esign-cross |

---

## Web Issues

**After mobile passes:**
```
@agent work on ESIGN-WEB-001,ESIGN-WEB-002,ESIGN-WEB-003 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| ESIGN-WEB-001 | Signature Dashboard | devforge-ai | DevForge AI | #devforge-esign-dashboard |
| ESIGN-WEB-002 | Workflow Admin | devforge-ai | DevForge AI | #devforge-esign-admin |
| ESIGN-WEB-003 | Audit Trail Viewer | devforge-ai | DevForge AI | #devforge-esign-audit |

---

## Related Documents

- `../disciplines-shared/e-signing/projects/ESIGN-INTEGRATION/`
- `../../orchestration/EXECUTION-TRACKER.md`