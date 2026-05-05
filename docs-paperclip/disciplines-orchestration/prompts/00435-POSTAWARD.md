# POSTAWARD — Dispatch Prompts

**Project**: POSTAWARD-COMPLIANCE
**Discipline**: 00435 — Contracts Post-Award
**Server**: PROCUREMENT-BIDDING
**Issues**: 15 (POSTAWARD-001 through POSTAWARD-015)
**Phases**: 5
**Integration Chains**: INT-003, INT-004

---

## Phase 1 — Foundation (100% pass threshold, 0 critical allowed)

**Dispatch command (in #ai-work on PROCUREMENT-BIDDING server):**
```
@agent work on POSTAWARD-001,POSTAWARD-002,POSTAWARD-003 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| POSTAWARD-001 | 00435 Page Foundation — Login, Navigation & Logout | domainforge-ai | DomainForge AI | #domainforge-postaward-foundation |
| POSTAWARD-002 | 00435 Database & API Connectivity | infraforge-ai | InfraForge AI | #infraforge-postaward-database |
| POSTAWARD-003 | 00435 Page Layout & Navigation | devforge-ai | DevForge AI | #devforge-postaward-layout |

**Phase Gate 1**: 100% pass rate, 0 critical issues → DomainForge AI

---

## Phase 2 — Contract Administration (>95% pass threshold, 0 critical allowed)

**After Phase Gate 1 passes:**
```
@agent work on POSTAWARD-004,POSTAWARD-005,POSTAWARD-006 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| POSTAWARD-004 | Contract Administration & Records | domainforge-ai | DomainForge AI | #domainforge-postaward-admin |
| POSTAWARD-005 | Progress Payment Management | measureforge-ai | MeasureForge AI | #measureforge-postaward-payment |
| POSTAWARD-006 | Variation Order Management | domainforge-ai | DomainForge AI | #domainforge-postaward-variation |

**Phase Gate 2**: >95% pass rate, 0 critical issues → DomainForge AI

---

## Phase 3 — Performance Monitoring (>90% pass threshold, ≤1 critical allowed)

**After Phase Gate 2 passes:**
```
@agent work on POSTAWARD-007,POSTAWARD-008,POSTAWARD-009 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| POSTAWARD-007 | Performance Monitoring & KPIs | devforge-ai | DevForge AI | #devforge-postaward-performance |
| POSTAWARD-008 | Delivery Verification (INT-004) | domainforge-ai | DomainForge AI | #domainforge-postaward-delivery |
| POSTAWARD-009 | Non-Conformance & Corrective Actions | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-postaward-ncr |

**Phase Gate 3**: >90% pass rate, ≤1 critical issue → DomainForge AI

---

## Phase 4 — Claims & Variations (>85% pass threshold, ≤2 critical allowed)

**After Phase Gate 3 passes:**
```
@agent work on POSTAWARD-010,POSTAWARD-011,POSTAWARD-012 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| POSTAWARD-010 | Claims Management & Dispute Resolution | domainforge-ai | DomainForge AI | #domainforge-postaward-claims |
| POSTAWARD-011 | Extension of Time Management | measureforge-ai | MeasureForge AI | #measureforge-postaward-eot |
| POSTAWARD-012 | Final Account Preparation | measureforge-ai | MeasureForge AI | #measureforge-postaward-final-account |

**Phase Gate 4**: >85% pass rate, ≤2 critical issues → DomainForge AI

---

## Phase 5 — Close-out & Sign-off (Go/no-go)

**After Phase Gate 4 passes:**
```
@agent work on POSTAWARD-013,POSTAWARD-014,POSTAWARD-015 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| POSTAWARD-013 | Contract Close-out & Handover | domainforge-ai | DomainForge AI | #domainforge-postaward-closeout |
| POSTAWARD-014 | Lessons Learned & Archive | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-postaward-archive |
| POSTAWARD-015 | Production Readiness Sign-off | validator-qualityforge + ALL | QualityForge AI + ALL | #devforge-postaward-signoff |

**Phase Gate 5**: Go/no-go recommendation → CEO

---

## Integration Chain Touchpoints

| Chain ID | Trigger Point | Data Flow | Status |
|----------|---------------|-----------|--------|
| INT-003 | After POSTAWARD-001 | 00400 Contracts → 00435 Post-Award (Execution Handoff) | 🔴 Pending Wave 2 |
| INT-004 | After POSTAWARD-008 | 01700 Logistics → 00435 Post-Award (Delivery → Payment) | 🔴 Pending Wave 3 |

---

## Related Documents

- `../disciplines/00435-contracts-post-award/projects/POSTAWARD-COMPLIANCE/`
- `../../orchestration/EXECUTION-TRACKER.md`
- `../../orchestration/INTEGRATION-REGISTRY.md`