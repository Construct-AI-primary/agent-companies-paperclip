# LOGISTICS — Dispatch Prompts

**Project**: LOGISTICS-WORKFLOW
**Discipline**: 01700 — Logistics
**Server**: LOGISTICS (1500131961761566851)
**Issues**: 15 (LOGISTICS-001 through LOGISTICS-015)
**Phases**: 5
**Integration Chains**: INT-004, INT-005

---

## Phase 1 — Foundation (100% pass threshold, 0 critical allowed)

**Dispatch command (in #ai-work on LOGISTICS server):**
```
@agent work on LOGISTICS-001,LOGISTICS-002,LOGISTICS-003 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| LOGISTICS-001 | 01700 Page Foundation — Login, Navigation & Logout | domainforge-ai | DomainForge AI | #domainforge-logistics-foundation |
| LOGISTICS-002 | 01700 Database & API Connectivity | infraforge-ai | InfraForge AI | #infraforge-logistics-database |
| LOGISTICS-003 | 01700 Page Layout & Navigation | devforge-ai | DevForge AI | #devforge-logistics-layout |

**Phase Gate 1**: 100% pass rate, 0 critical issues → DomainForge AI

---

## Phase 2 — Weighbridge & Field Capture (>95% pass threshold, 0 critical allowed)

**After Phase Gate 1 passes:**
```
@agent work on LOGISTICS-004,LOGISTICS-005,LOGISTICS-006 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| LOGISTICS-004 | Weighbridge Integration & QR Scanning | domainforge-ai | DomainForge AI | #domainforge-logistics-weighbridge |
| LOGISTICS-005 | Mobile Field Data Capture (FSP-001) | mobileforge-ai | MobileForge AI | #mobileforge-logistics-field |
| LOGISTICS-006 | Transaction Correlation & Tracking (FSP-003) | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-logistics-transaction |

**Phase Gate 2**: >95% pass rate, 0 critical issues → DomainForge AI

---

## Phase 3 — Delivery & Integration (>90% pass threshold, ≤1 critical allowed)

**After Phase Gate 2 passes:**
```
@agent work on LOGISTICS-007,LOGISTICS-008,LOGISTICS-009 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| LOGISTICS-007 | Delivery Verification & Acceptance (INT-004) | domainforge-ai | DomainForge AI | #domainforge-logistics-delivery |
| LOGISTICS-008 | Document Capture & Numbering (INT-005, FSP-008) | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-logistics-docs |
| LOGISTICS-009 | Transport Route Optimization (FSP-004) | domainforge-ai | DomainForge AI | #domainforge-logistics-transport |

**Phase Gate 3**: >90% pass rate, ≤1 critical issue → DomainForge AI

---

## Phase 4 — Payment & Compliance (>85% pass threshold, ≤2 critical allowed)

**After Phase Gate 3 passes:**
```
@agent work on LOGISTICS-010,LOGISTICS-011,LOGISTICS-012 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| LOGISTICS-010 | Automated Payment Calculation (FSP-005) | measureforge-ai | MeasureForge AI | #measureforge-logistics-payment |
| LOGISTICS-011 | Performance Bond Integration (FSP-006) | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-logistics-bonds |
| LOGISTICS-012 | Compliance Monitoring & Audit | devforge-ai | DevForge AI | #devforge-logistics-compliance |

**Phase Gate 4**: >85% pass rate, ≤2 critical issues → DomainForge AI

---

## Phase 5 — Advanced Features & Sign-off (Go/no-go)

**After Phase Gate 4 passes:**
```
@agent work on LOGISTICS-013,LOGISTICS-014,LOGISTICS-015 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| LOGISTICS-013 | Context-Aware Validation Framework (FSP-007) | domainforge-ai | DomainForge AI | #domainforge-logistics-validation |
| LOGISTICS-014 | Logistics Analytics & Reporting | measureforge-ai | MeasureForge AI | #measureforge-logistics-analytics |
| LOGISTICS-015 | Production Readiness Sign-off | validator-qualityforge + ALL | QualityForge AI + ALL | #devforge-logistics-signoff |

**Phase Gate 5**: Go/no-go recommendation → CEO

---

## Integration Chain Touchpoints

| Chain ID | Trigger Point | Data Flow | Status |
|----------|---------------|-----------|--------|
| INT-004 | After LOGISTICS-007 | 01700 Logistics → 00435 Post-Award (Delivery → Payment) | 🔴 Pending Wave 3 |
| INT-005 | After LOGISTICS-008 | 01700 Logistics → 00900 Document Control (Field Documents) | 🔴 Pending Wave 3 |

---

## Related Documents

- `../disciplines/01700-logistics/projects/LOGISTICS-WORKFLOW/`
- `../../orchestration/EXECUTION-TRACKER.md`
- `../../orchestration/INTEGRATION-REGISTRY.md`