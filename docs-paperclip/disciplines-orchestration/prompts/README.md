# Dispatch Prompts — Wave Execution Index

**Location**: `disciplines-orchestration/prompts/`
**Purpose**: One-file-per-project dispatch prompts for all waves of testing execution.

---

## Wave 1 — Active Pilot (5-Instance Parallel Execution)

| File | Project | Discipline | Issues | Server | Est. Duration |
|------|---------|-----------|--------|--------|---------------|
| [01900-PROCURE-TEST.md](01900-PROCURE-TEST.md) | PROCURE-TEST | 01900 Procurement | 16 | PROCURE-TEST | ~2.5h |
| [00000-PROD-TEST.md](00000-PROD-TEST.md) | PROD-TEST | Cross-discipline | 15 | ALL-DISCIPLINES | ~2.5h |
| [00000-MOBILE-TEST.md](00000-MOBILE-TEST.md) | MOBILE-TEST | Mobile | 6 | ALL-DISCIPLINES | ~40min (parallel) |

**Wave 1 Total**: 37 issues, ~2.5h wall-clock (parallel execution)

---

## Wave 2 — Contracts (00400/00425/00435)

| File | Project | Discipline | Issues | Server | Est. Duration |
|------|---------|-----------|--------|--------|---------------|
| [00400-CONTRACT-LIFECYCLE.md](00400-CONTRACT-LIFECYCLE.md) | CONTRACT-LIFECYCLE | 00400 Contracts | 15 | CONTRACTS-QS | ~3h |
| [00425-PREAWARD.md](00425-PREAWARD.md) | PREAWARD-BID | 00425 Pre-Award | 15 | PROCUREMENT-BIDDING | ~3h |
| [00435-POSTAWARD.md](00435-POSTAWARD.md) | POSTAWARD-COMPLIANCE | 00435 Post-Award | 15 | PROCUREMENT-BIDDING | ~3h |

**Wave 2 Total**: 45 issues, ~3h wall-clock (parallel projects)

**Integration Chains**: INT-001, INT-002, INT-003, INT-009

---

## Wave 3 — Logistics/Document Control/Governance/Electrical/Safety

| File | Project | Discipline | Issues | Server | Est. Duration |
|------|---------|-----------|--------|--------|---------------|
| [01700-LOGISTICS.md](01700-LOGISTICS.md) | LOGISTICS-WORKFLOW | 01700 Logistics | 15 | LOGISTICS | ~5h |
| [00860-ELECTRICAL.md](00860-ELECTRICAL.md) | ELECTRICAL-INSPECTIONS | 00860 Electrical | 15 | ELEC-TEST | ~5h |
| [00900-DOCUMENT-CONTROL.md](00900-DOCUMENT-CONTROL.md) | DOCUMENT-REGISTRY | 00900 Document Control | 15 | ENGINEERING | ~5h |
| [01300-GOVERNANCE.md](01300-GOVERNANCE.md) | GOVERNANCE-FORMS | 01300 Governance | 15 | ENGINEERING | ~5h |
| [02400-SAFETY.md](02400-SAFETY.md) | SAFETY-INCIDENTS | 02400 Safety | 15 | SAFETY | ~5h |
| [00000-ESIGN-INTEGRATION.md](00000-ESIGN-INTEGRATION.md) | ESIGN-INTEGRATION | E-Signing | 11 | ALL-DISCIPLINES | ~2h |

**Wave 3 Total**: 86 issues, ~5h wall-clock (parallel projects)

**Integration Chains**: INT-004, INT-005, INT-006, INT-007, INT-008, INT-010

---

## Execution Summary

| Wave | Projects | Issues | Est. Wall-Clock | Execution Model |
|------|----------|--------|-----------------|-----------------|
| **Wave 1** | PROCURE-TEST, PROD-TEST, MOBILE-TEST | 37 | ~2.5h | 5 parallel instances (I1-I5) + mobile parallel |
| **Wave 2** | CONTRACT-LIFECYCLE, PREAWARD, POSTAWARD | 45 | ~3h | Sequential phases per project, parallel projects |
| **Wave 3** | LOGISTICS, ELECTRICAL, DOCUMENT-CONTROL, GOVERNANCE, SAFETY, ESIGN | 86 | ~5h | Sequential phases per project, parallel projects |
| **Total** | **11 projects** | **168** | **~10.5h** | |

---

## Pre-Flight Checklist (Run Once Before Any Wave)

```bash
# 1. Verify app server is running
curl -s -o /dev/null -w "HTTP %{http_code}" http://localhost:3060/

# 2. Verify auth works
curl -s -X POST http://localhost:3060/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"sarah.safety@epcm.co.za","password":"anything"}' | python3 -m json.tool

# 3. Verify pages load (expect 120+)
curl -s http://localhost:3060/api/pages | python3 -c "import sys,json; pages=json.load(sys.stdin); print(f'Total pages: {len(pages)}')"

# 4. Verify Discord bot is online
!ping in #agent-commands

# 5. Verify Supabase connectivity
```

---

## Phase Gate Thresholds

| Phase | Pass Rate | Critical Issues Allowed | Gate Keeper |
|-------|-----------|------------------------|-------------|
| 1 — Foundation | 100% | 0 | DomainForge AI / QualityForge AI |
| 2 — State/Modals | >95% | 0 | DomainForge AI / QualityForge AI |
| 3 — Integration | >90% | ≤1 | DomainForge AI |
| 4 — Advanced | >85% | ≤2 | DomainForge AI |
| 5 — Compliance | Go/no-go | N/A | CEO |

---

## Integration Chain Registry

| Chain ID | Source | Target | Trigger Point | Wave |
|----------|--------|--------|---------------|------|
| INT-001 | 01900 Procurement | 00425 Pre-Award | After PROCURE-010 | Wave 2 |
| INT-002 | 00425 Pre-Award | 00400 Contracts | After PREAWARD-011 | Wave 2 |
| INT-003 | 00400 Contracts | 00435 Post-Award | After CONTRACT-010 | Wave 2 |
| INT-004 | 01700 Logistics | 00435 Post-Award | After LOGISTICS-007 | Wave 3 |
| INT-005 | 01700 Logistics | 00900 Document Control | After LOGISTICS-008 | Wave 3 |
| INT-006 | 00900 Document Control | 01300 Governance | After DOCUMENT-008 | Wave 3 |
| INT-007 | 01300 Governance | 02400 Safety | After GOVERNANCE-009 | Wave 3 |
| INT-008 | 00860 Electrical | 00900 Document Control | After ELECTRICAL-007 | Wave 3 |
| INT-009 | 01900 Procurement | 00400 Contracts | After PROCURE-009 | Wave 2 |
| INT-010 | 02400 Safety | 01900 Procurement | After SAFETY-001 | Wave 3 |

---

## Related Documents

- `../../orchestration/EXECUTION-TRACKER.md` — Execution status tracking
- `../../orchestration/INTEGRATION-REGISTRY.md` — Cross-discipline integration register
- `../../orchestration/TRIGGER-README.md` — Trigger architecture and dispatch map
- `../procedures/projects/batched-execution-plan.md` — Batched execution plan