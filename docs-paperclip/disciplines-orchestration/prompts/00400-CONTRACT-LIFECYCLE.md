# CONTRACT-LIFECYCLE — Dispatch Prompts

**Project**: CONTRACT-LIFECYCLE
**Discipline**: 00400 — Contracts
**Server**: CONTRACTS-QS (1500130883154219258)
**Issues**: 15 (CONTRACT-001 through CONTRACT-015)
**Phases**: 5
**Integration Chains**: INT-002, INT-003, INT-009

---

## Phase 1 — Foundation (100% pass threshold, 0 critical allowed)

**Dispatch command (in #ai-work on CONTRACTS-QS server):**
```
@agent work on CONTRACT-001,CONTRACT-002,CONTRACT-003 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| CONTRACT-001 | 00400 Page Foundation — Login, Navigation & Logout | domainforge-ai | DomainForge AI | #domainforge-contract-foundation |
| CONTRACT-002 | 00400 Database & API Connectivity | infraforge-ai | InfraForge AI | #infraforge-contract-database |
| CONTRACT-003 | 00400 Page Layout & Navigation | devforge-ai | DevForge AI | #devforge-contract-layout |

**Phase Gate 1**: 100% pass rate, 0 critical issues → DomainForge AI

---

## Phase 2 — Contract Creation (>95% pass threshold, 0 critical allowed)

**After Phase Gate 1 passes:**
```
@agent work on CONTRACT-004,CONTRACT-005,CONTRACT-006 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| CONTRACT-004 | Contract Template Management | domainforge-ai | DomainForge AI | #domainforge-contract-templates |
| CONTRACT-005 | Contract Drafting & Editing | devforge-ai | DevForge AI | #devforge-contract-drafting |
| CONTRACT-006 | Party Management & Signatures | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-contract-parties |

**Phase Gate 2**: >95% pass rate, 0 critical issues → DomainForge AI

---

## Phase 3 — Bid & Tender Integration (>90% pass threshold, ≤1 critical allowed)

**After Phase Gate 2 passes:**
```
@agent work on CONTRACT-007,CONTRACT-008,CONTRACT-009 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| CONTRACT-007 | Bid Evaluation Integration (INT-002) | domainforge-ai | DomainForge AI | #domainforge-contract-bid-int |
| CONTRACT-008 | Tender Package Processing | paperclipforge-ai | PaperclipForge AI | #paperclipforge-contract-tender |
| CONTRACT-009 | Award Recommendation Workflow | measureforge-ai | MeasureForge AI | #measureforge-contract-award |

**Phase Gate 3**: >90% pass rate, ≤1 critical issue → DomainForge AI

---

## Phase 4 — Execution & Compliance (>85% pass threshold, ≤2 critical allowed)

**After Phase Gate 3 passes:**
```
@agent work on CONTRACT-010,CONTRACT-011,CONTRACT-012 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| CONTRACT-010 | Signed Contract Execution (INT-003) | domainforge-ai | DomainForge AI | #domainforge-contract-execution |
| CONTRACT-011 | Compliance Monitoring Setup | devforge-ai | DevForge AI | #devforge-contract-compliance |
| CONTRACT-012 | Payment Certification & Tracking | measureforge-ai | MeasureForge AI | #measureforge-contract-payment |

**Phase Gate 4**: >85% pass rate, ≤2 critical issues → DomainForge AI

---

## Phase 5 — Advanced Features & Sign-off (Go/no-go)

**After Phase Gate 4 passes:**
```
@agent work on CONTRACT-013,CONTRACT-014,CONTRACT-015 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| CONTRACT-013 | Contract Amendments & Variations | domainforge-ai | DomainForge AI | #domainforge-contract-amendments |
| CONTRACT-014 | Performance Bond Management | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-contract-bonds |
| CONTRACT-015 | Production Readiness Sign-off | validator-qualityforge + ALL | QualityForge AI + ALL | #devforge-contract-signoff |

**Phase Gate 5**: Go/no-go recommendation → CEO

---

## Integration Chain Touchpoints

| Chain ID | Trigger Point | Data Flow | Status |
|----------|---------------|-----------|--------|
| INT-002 | After CONTRACT-009 | 00425 Pre-Award → 00400 Contracts (Award Handoff) | 🔴 Pending Wave 2 |
| INT-003 | After CONTRACT-010 | 00400 Contracts → 00435 Post-Award (Execution Handoff) | 🔴 Pending Wave 2 |
| INT-009 | After CONTRACT-004 | 01900 Procurement → 00400 Contracts (PO → Contract) | 🔴 Pending Wave 2 |

---

## Related Documents

- `../disciplines/00400-contracts/projects/CONTRACT-LIFECYCLE/`
- `../../orchestration/EXECUTION-TRACKER.md`
- `../../orchestration/INTEGRATION-REGISTRY.md`
- `../procedures/projects/batched-execution-plan.md`